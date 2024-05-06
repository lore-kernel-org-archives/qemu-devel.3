Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15DAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9e-0007Nr-3D; Mon, 06 May 2024 03:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9V-0006x6-F9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9U-0001kS-08
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvZpu2Iq5b9J0WyrI5CvCUA5A69cf72SB0raiRtSeqI=;
 b=F3/ZAvzrzZX5StpszdTD6fKQgp1kI1Qo0OqAKGwJECYLgL00sGj4qN7Gadh3EiGT6yfNDC
 5LULrBND9K6lSYcbxUAcr3btAbopK/LayEzgsAORx3xfThtnKo29NfB7nwmKfVhKP2b5J0
 05MYCQq3Pw0KSaam9Ega1kwhzzITgOs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-fjicvz39P46IzkCeZcMsoA-1; Mon, 06 May 2024 03:52:46 -0400
X-MC-Unique: fjicvz39P46IzkCeZcMsoA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59ad486084so71618966b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981964; x=1715586764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mvZpu2Iq5b9J0WyrI5CvCUA5A69cf72SB0raiRtSeqI=;
 b=uO7lM0+FBI58EF5Hs/eIide2dYa7sUIA/IGpIWCZCqDeb8OMcnutOLqJ7aVBlROvwV
 rmy0LfFLDgN7JalZPl4aH6beREHgLZd93bAfEz8pc8NGBOJMWrEqnaJZrCSx2pe33vEO
 xO2nEvFZIzTtZXaq5RP/IB6wAwSHJweiQa/OyiWxftxCX2FLDGdjQMJzWa4DE5bCLNp4
 bVPwoiBsrP1IuPdrQuLg3q8XCmISjODpLHI2r2vXJhORuE7+8yJIp6ECJHO5dje6Qv+C
 I2ekbcGOSRzuioDHXrF/y0FkncGMHVxTJ0drz/QeHf9VO/w8ftxN8W3lPEQUVvLKEk26
 wXMw==
X-Gm-Message-State: AOJu0YzUbF3h0lTeMMCviaEInFLY1mYlUxCRaK7HrbNA/31nSumpFawh
 6ZhYhb2HwFsuVMGCtklBzEnY0lOIwf+0XH7weLBvz/kYWn/ukX+tci5Ljy8/y/o8NQoi4X/4PFE
 Fs8A5Q7PA4u+1F3YuwhQOqamEfm9PNAt8JwaexEr4lpfyR6UZkt/Zds/6blhOM7zh/yeub9ijDE
 b0xruySW8QJL8/eKLTB3eQx6d3J2A9kKehVTXN
X-Received: by 2002:a17:907:6d0e:b0:a59:b590:5d71 with SMTP id
 sa14-20020a1709076d0e00b00a59b5905d71mr3285665ejc.0.1714981964534; 
 Mon, 06 May 2024 00:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzI2M8OroqzgRnIE9vJYiWOwhftLMQYlWdONrjLZihuUipPCSrM6fV43YQpt0B3k4MEP1gbw==
X-Received: by 2002:a17:907:6d0e:b0:a59:b590:5d71 with SMTP id
 sa14-20020a1709076d0e00b00a59b5905d71mr3285653ejc.0.1714981964262; 
 Mon, 06 May 2024 00:52:44 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 wk16-20020a170907055000b00a59db6e54e2sm337589ejb.85.2024.05.06.00.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/46] fw_cfg: remove useless declarations from typedefs.h
Date: Mon,  6 May 2024 09:51:10 +0200
Message-ID: <20240506075125.8238-32-pbonzini@redhat.com>
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

Only FWCfgState is used as part of APIs such as acpi_ghes_add_fw_cfg.
Everything else need not be in typedefs.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 2 ++
 include/qemu/typedefs.h   | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index c1f81a5f13a..d173998803c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -59,6 +59,8 @@ typedef struct fw_cfg_dma_access FWCfgDmaAccess;
 typedef void (*FWCfgCallback)(void *opaque);
 typedef void (*FWCfgWriteCallback)(void *opaque, off_t start, size_t len);
 
+typedef struct FWCfgEntry FWCfgEntry;
+
 struct FWCfgState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 50c277cf0b4..949d3e1daf9 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -56,9 +56,6 @@ typedef struct DumpState DumpState;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
-typedef struct FWCfgEntry FWCfgEntry;
-typedef struct FWCfgIoState FWCfgIoState;
-typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
 typedef struct GraphicHwOps GraphicHwOps;
 typedef struct HostMemoryBackend HostMemoryBackend;
-- 
2.44.0


