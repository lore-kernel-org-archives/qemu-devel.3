Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B14DCAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LpC-0005TK-IS; Wed, 24 Sep 2025 05:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpB-0005P5-7D
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp7-0004sc-1H
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qs8pcMa93ewjzBHLMnxD/fqYcxndHhw9EpDQZaSEytE=;
 b=QrIjnmaMwlq9V8ROgt5TmaUHTieBmpTd8245hIy0bQuZDTvSGmLgwcQmPsg5dnXtzjsaUr
 YRI3EJX9E6B9nciTOPTD0I93CyRBMB5Nqr9RXG9bgjRkRljohuomHZTNuC3FoiptWDasCL
 WaFJyIRLbNYUeVccRPZj1FyMV5qJwl0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-CIjnR_dSOSSXO7yt0SsSMw-1; Wed, 24 Sep 2025 05:30:01 -0400
X-MC-Unique: CIjnR_dSOSSXO7yt0SsSMw-1
X-Mimecast-MFC-AGG-ID: CIjnR_dSOSSXO7yt0SsSMw_1758706201
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afcb7338319so824403266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706200; x=1759311000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qs8pcMa93ewjzBHLMnxD/fqYcxndHhw9EpDQZaSEytE=;
 b=p/ozXfA09mSIQuMNy4n9W36dnS+a9c/YxXJ51IbF2M98noZlHBd+vKYvb+lOF5Vapa
 DWZMHoajsVjqBOpH7EgxGrLX42aRVtyGhjVLG5vUt8JqABomo1x3yrDrqBLfNNe2KNha
 Dfy7wDtq597Zqy5vT4UkxB4ns4HAyW1Qh8HjF45f3BV1R2BgjJ/ZhXQGFbY8KL9IKQTe
 eskK/AtK0UEPCUrQ5SwRbfbeoEssJcRlvzzPSb3TSPXusL06lWkAzJDHk05DShY1m9Lx
 XykpvHY1kF2fd52o4vz+noL9nam4Pvg/miZpqzpnsgPM6mjP+pqxXNUvM5xl17qxXdkq
 tlPA==
X-Gm-Message-State: AOJu0Yz/Zfb+7CwrB6eAmsUCOYFfNh2mzZBzEgILoYqo82W3RwI+r6+a
 TD54+z4a9Q9NPLhgoRWFYvxGiWGtlZBEeGFYukwcP+hwFzhuPpNoLcX0wcbC2y87TXy2IJ60F3I
 TPE8uDHYd+eoMeePRfrCgV0XHtu3S4bEmoLnmTpTdXC4JnrAzxEa2dq0wuUrtsTj4lyP5MqJvTP
 jjhWGhPCniZ13+G9svZUEbkoLYagxXGQZDWhFCgrky
X-Gm-Gg: ASbGncuE37fHF/84Yeh7GGtotz02St50aebRhkXv/XybLQ+aik3Ur65H6gejFTF8jBZ
 IaNKASBYdO+Kzjuf9/EnnpbFFf1ICL2U8kKJqnSu6KF5kHk64M2NVszgeGtL914RsqezVV6nL7O
 UFl8k1sZnLsZxwbrRJZGM7X5FAErSOPgSPzQLeMLSgZm7dNaI8z8arwxf1lXueUAsxU9ERts5T+
 cQgWOkaphL5DElTW5eRLvD1blBne7tpLuHkOdP5wmrGwRmdrodan+ADmtSYdeoYgADj2RvrsbvC
 82/2I2OsAow2Zlb/Y8dDyITXmiZh6t8HrIdFweUcVVMglLvg2fVOaaRxGwK7GFXZysEZPq4QbQC
 VyXB/Vlfy9SAgX2WL8lVqntP+JaZLSpPHebewSufuefD3Cg==
X-Received: by 2002:a17:907:9618:b0:b0d:d831:6fba with SMTP id
 a640c23a62f3a-b302b51c6f9mr542193966b.59.1758706199487; 
 Wed, 24 Sep 2025 02:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQEu1SiVnwN0oEFQ5TqX4SLQjWfPo6UBQ/0pGEwP2uHs8CLhU6Ia0cESfSjlFuYUaH0tkww==
X-Received: by 2002:a17:907:9618:b0:b0d:d831:6fba with SMTP id
 a640c23a62f3a-b302b51c6f9mr542191466b.59.1758706199045; 
 Wed, 24 Sep 2025 02:29:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a88413acbsm799483666b.24.2025.09.24.02.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 23/29] hv-balloon: hw/core/register: Do not unparent in
 instance_finalize()
Date: Wed, 24 Sep 2025 11:28:43 +0200
Message-ID: <20250924092850.42047-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-4-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hv-balloon.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 6dbcb2d9a29..2d6d7db4ee0 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1475,16 +1475,6 @@ static void hv_balloon_ensure_mr(HvBalloon *balloon)
     balloon->mr->align = memory_region_get_alignment(hostmem_mr);
 }
 
-static void hv_balloon_free_mr(HvBalloon *balloon)
-{
-    if (!balloon->mr) {
-        return;
-    }
-
-    object_unparent(OBJECT(balloon->mr));
-    g_clear_pointer(&balloon->mr, g_free);
-}
-
 static void hv_balloon_vmdev_realize(VMBusDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
@@ -1580,7 +1570,7 @@ static void hv_balloon_vmdev_reset(VMBusDevice *vdev)
  */
 static void hv_balloon_unrealize_finalize_common(HvBalloon *balloon)
 {
-    hv_balloon_free_mr(balloon);
+    g_clear_pointer(&balloon->mr, g_free);
     balloon->addr = 0;
 
     balloon->memslot_count = 0;
-- 
2.51.0


