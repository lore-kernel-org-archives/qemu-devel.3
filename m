Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC8E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxn-0004UL-Sf; Thu, 19 Dec 2024 03:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxf-0004Sg-Lz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxe-00054t-2B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inDs3wrtPcf3Fxmch4fAFhjkkRLJg4db13zJUiW/S3Y=;
 b=UmCFgRMkKV3xIH3DYkXGhBY1uFOU7iXgwVXGXjKrFkl/5i3LCXC2WsclZX31umFiLoQt3k
 FYjCaON36Pdmb+YtjtZMBc2/b+IIbioVJoMET9rzWVcQw6IzQOKRT/CoqUVL1KKSqV1HQE
 Oal1/OJY1dJfnCj1sfT/88H6pj7CknM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-H2uSaLUCPqqom8f-rgcNpA-1; Thu, 19 Dec 2024 03:32:42 -0500
X-MC-Unique: H2uSaLUCPqqom8f-rgcNpA-1
X-Mimecast-MFC-AGG-ID: H2uSaLUCPqqom8f-rgcNpA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436289a570eso4197195e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597160; x=1735201960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inDs3wrtPcf3Fxmch4fAFhjkkRLJg4db13zJUiW/S3Y=;
 b=TQc1f4pf+fAj15BN596kr2Zde4jr0umqPhbA0eC1Sg/Z7H/I3nFhRFcvnd2FbrZ/5K
 UinrVKs5z/65hn51108pYdDsoyKch+hMJITXhxBbWv8x+8c84S3XNoMy2oORCkKukSsG
 9SbCoaArr/rQTh+tjtlwsV0tp/ahi7MlsAKKkI3yi2Zw5T13h81PLEsWLhe9UZZG/8sA
 RuOvWnwb5VuBZzz1fuUiDf88dp4WtixA29Ip///MXrVI3O9HRhX6ZmFDVx7KM3pA5SbE
 7wnHVdWuEoViBD10B868h5no+aYogvW7ZpwUGVS/+8WX2/L6VRmh/W5dxIRv+xc9iuCR
 i8lw==
X-Gm-Message-State: AOJu0Yztlr1QCBkuiDxlCJLbtekKwgEFH/mGpO5keMrjodlVaqc6N6Oo
 DfpeVMZY47G4zaR68rhZVs9hMt20i3ppvkkTwwwxs78D1lFSlmyreak1aSOyUTK87rPL73kXYpn
 skMnREmU1+9mEwX0jeUHi/VXiFdRviLnlPkGD+q5GLFM6Kbn1yR56jFybQ6vBMW4qb8nO8qKBdv
 d4xVC1EBYdtwcRMlGMU9Q+EBqkKW9c+t9mDMhu
X-Gm-Gg: ASbGnctQ36J4POM2LOofRqngO5OHhAnlO5345zSmxaBonFHLJWLEl/GkypDJpnF3KEP
 KAfF5S7Z6GCmIJwKge980+aa7WH2crP/G4sPWnyzxNDdbPEpqz02425reFE7UfT3zr2PbGt27x/
 Kyhd7HNL06J+GtWMAyl3lB1JC4BcFgATQsQyUCNkCPYDZ93dEvXK1IrwdHobevqvMNlY43JxpIw
 MT5kMBpOkmoa98wu5ySM0X53gtN9Ic+BXG5VdTON+spkgs94jMVAhdiGsPn
X-Received: by 2002:a05:6000:1866:b0:385:df73:2f42 with SMTP id
 ffacd0b85a97d-38a19b139cbmr2130653f8f.32.1734597160226; 
 Thu, 19 Dec 2024 00:32:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWgeOHhNpzuDJdD5wojsTkJp/zHVITJypv/L16EMxrJFrh02K5V+C7O/sTT5pF88I8FSpDuQ==
X-Received: by 2002:a05:6000:1866:b0:385:df73:2f42 with SMTP id
 ffacd0b85a97d-38a19b139cbmr2130616f8f.32.1734597159742; 
 Thu, 19 Dec 2024 00:32:39 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8bb4d3sm974303f8f.110.2024.12.19.00.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/41] hw/pci-host/astro: Remove empty Property list
Date: Thu, 19 Dec 2024 09:31:52 +0100
Message-ID: <20241219083228.363430-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-6-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/astro.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 379095b3566..62e9c8acbf4 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -461,10 +461,6 @@ static void elroy_pcihost_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), elroy_set_irq, ELROY_IRQS);
 }
 
-static Property elroy_pcihost_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static const VMStateDescription vmstate_elroy = {
     .name = "Elroy",
     .version_id = 1,
@@ -490,7 +486,6 @@ static void elroy_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, elroy_reset);
-    device_class_set_props(dc, elroy_pcihost_properties);
     dc->vmsd = &vmstate_elroy;
     dc->user_creatable = false;
 }
-- 
2.47.1


