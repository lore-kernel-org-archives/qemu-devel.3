Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A74C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9f-0007Sn-Tj; Mon, 06 May 2024 03:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9Y-00074Q-7p
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9W-0001km-Oy
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XG+/YIdax3MeleXDpFVwjxPQHTXWj33Onf7v92r1kBM=;
 b=LiBe2eUWFMVAq+OR8BqG/KA/lUhJwJGNrT2ssogo+LKXvJmBS1JGi7bKoV65AWn/9N/PPb
 vIxfPoELLVgo5kT+FBbGR0kNcuS5pHBG9lO0FM7rKVZjS3qbsKZ7uYC1SvjmOAD706nlBM
 jlMIX5DF3Q3jUOCSCUWZUhjtOmArdSU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-UV1pcIvVNsm_GS1DSjTVrQ-1; Mon, 06 May 2024 03:52:48 -0400
X-MC-Unique: UV1pcIvVNsm_GS1DSjTVrQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572cbbdb450so577733a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981967; x=1715586767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XG+/YIdax3MeleXDpFVwjxPQHTXWj33Onf7v92r1kBM=;
 b=blxLuBkHx8fZ3ebuY/ohyBL2jhzWMS5z1hM5rErFSVAqCZWHMoj8tPMxtRxlhzRB7M
 1LgexXNssNd58gDob8H85tnFLP4mhO90AC5bUl1ZHgCd+D/JXQVonVGGCpIJ21hRMSYe
 XnzETu/rTuYQxUZtOL/wem/97ZMQdDsixebiJ4R5PgjcuCxk0IfOUgWjMrOTTlahbauW
 mJ5IjCAhVPBYnm4ceuFX6+OAyeSms3Zb/Tk3it7+QDvtmdelbtZpf6Dykv1vff06fAAU
 ZIMBt5iZyr/wFKO5dceRgZDjJ0Bs8HlngAF1gRBqtLt9OM74mPjkKbRsZuzoJDo5Jidr
 9KDQ==
X-Gm-Message-State: AOJu0Ywn7ewx9BlJqXk6h0ZpkGSgSxYNQYI2BTggREbI+VIeytXocWua
 x+hDcoA7wIN8v6zi5PNNvqcZS7jDRbN0E2dXrYAR62k2s6MX8CQ6J10mWgX/r1Z5wSdAd6mNiNA
 lRko6zqym+yjP3wER8bqKJoL12tQrjnD5iQyIfE/T8MCNcMs6QAhnlJMhqTiZ08oYD+n5JNjxcp
 pJf2gecdd6WTSPqF7dvyJwUvsbbVWB1AkvBT18
X-Received: by 2002:a50:a6de:0:b0:572:a158:8a7c with SMTP id
 f30-20020a50a6de000000b00572a1588a7cmr4748349edc.42.1714981966940; 
 Mon, 06 May 2024 00:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKf69+QdXUeyjIZW5AhSICU/Bv/WaTYiPx0PKIqGt41tDHB4450UEumV9CTwItOWnv2mgzfQ==
X-Received: by 2002:a50:a6de:0:b0:572:a158:8a7c with SMTP id
 f30-20020a50a6de000000b00572a1588a7cmr4748338edc.42.1714981966473; 
 Mon, 06 May 2024 00:52:46 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a05640206cf00b00572b029ca57sm4788976edy.25.2024.05.06.00.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/46] qdev-core: remove DeviceListener from typedefs.h
Date: Mon,  6 May 2024 09:51:11 +0200
Message-ID: <20240506075125.8238-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is needed in very few places, which already depend on other parts of
qdev-core.h files.  The benefit of having it in typedefs.h is small.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h  | 1 +
 include/qemu/typedefs.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9228e96c87e..5336728a23f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -294,6 +294,7 @@ struct DeviceState {
     MemReentrancyGuard mem_reentrancy_guard;
 };
 
+typedef struct DeviceListener DeviceListener;
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 949d3e1daf9..66f0b146c8c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -47,7 +47,6 @@ typedef struct CpuInfoFast CpuInfoFast;
 typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
-typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisplayChangeListener DisplayChangeListener;
-- 
2.44.0


