Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF0D6E2D2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7p-00020L-I9; Wed, 20 Nov 2024 02:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7l-0001zH-RA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7k-00081l-7a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732087659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2F9E4mEmEirmkyQv404Dyo179Nuu2p/DO/bYOMpAzw=;
 b=SRITF/itIjqJx2D8VrfzTdhQUJ7EslUYa+NQLB3xsMzoJlTo5dwNR9KQ46gagJ6tbk/0Ct
 u0jUk4z1LAipik98xEX1Lyaw3qmg+x0d5lhTVK8A9aIbROG/gEHGH20IP3QdjW3L0pi5EF
 mVubkRpI+C1018pvDkpDmBwZNqVO54E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-j5vmsjoWOUe7OG-nwjAAYA-1; Wed, 20 Nov 2024 02:27:37 -0500
X-MC-Unique: j5vmsjoWOUe7OG-nwjAAYA-1
X-Mimecast-MFC-AGG-ID: j5vmsjoWOUe7OG-nwjAAYA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315ad4938fso13809195e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732087655; x=1732692455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2F9E4mEmEirmkyQv404Dyo179Nuu2p/DO/bYOMpAzw=;
 b=VCXj/d+EN6P6PnS0CSkFZnWmUf+5/ts/07jCr6zKUMmtGdgw2TPksVLzoftyA7YN4X
 lQnkA1sXiRxAwfbwCl/2iaKgSynH4wfORpHi+MNtjCKDVPcXvKyA6bMDi2cGpQr3aB8x
 wWOLgATek7aJvOBBns7U5K0PH3MRK7I7RYSSl9Gat0d3L3U2EjbWpK/OVcwYrjmJsOz9
 eKuYrCZ3woNe31eJ3RqQNcdmyJkt518CMZZsiErPV0lSFAHQmeLEPFdXQEwFfIu8Vp8X
 Z9YmaRCj3mgOOSA+OKaT9aGc5WcFbdZR2leEj5/ykeMOdqrgX2SxFfQkRoqYis3Xy4mN
 hnPw==
X-Gm-Message-State: AOJu0YwXmbrVSfy1ps6EtNzI4IfwHCcVe3mwwlbXRwhtUJzTR6z/Orqx
 wZ4FtNBCVYbnNRdUezQmpU4mH2n+xq5VdIq2sota14f/sI1val+flUkuT8Qx/I6RB3jNtq44ntz
 eCg4OVbzd0DJi37m7Xkp3On2+tIUoZdygwYICOUU0gVp6sMHGvXkiDaQbTtGB4bSEOggsYuUBr3
 HOAOB3vtaGgGC9qOmp4xUAlQTxD7rczdWVcw9e
X-Received: by 2002:a5d:64c6:0:b0:382:5206:8b5d with SMTP id
 ffacd0b85a97d-38254b21ac8mr976270f8f.42.1732087655183; 
 Tue, 19 Nov 2024 23:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGtjKu0P42Vwo06TAVfnN7ZEI6Gu+a7HawNXdaZ81ykKy1gTB52/PeupQA/RjI90nuuPLGhg==
X-Received: by 2002:a5d:64c6:0:b0:382:5206:8b5d with SMTP id
 ffacd0b85a97d-38254b21ac8mr976258f8f.42.1732087654777; 
 Tue, 19 Nov 2024 23:27:34 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4c68sm9007665e9.22.2024.11.19.23.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:27:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/5] hw/core/machine-smp: Fix error message parameter
Date: Wed, 20 Nov 2024 08:27:22 +0100
Message-ID: <20241120072723.103477-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120072723.103477-1-pbonzini@redhat.com>
References: <20241120072723.103477-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

In the loop checking smp cache support, the error message should report
the current cache level and type.

Fix the parameter of error_setg() to ensure it reports the correct cache
level and type.

Resolves: Coverity CID 1565391
Fixes: f35c0221fef8 ("hw/core: Check smp cache topology support for machine")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20241110150901.130647-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine-smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index b87637c78f6..b954eb84902 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -317,7 +317,7 @@ bool machine_parse_smp_cache(MachineState *ms,
             !mc->smp_props.cache_supported[props->cache]) {
             error_setg(errp,
                        "%s cache topology not supported by this machine",
-                       CacheLevelAndType_str(node->value->cache));
+                       CacheLevelAndType_str(props->cache));
             return false;
         }
 
-- 
2.47.0


