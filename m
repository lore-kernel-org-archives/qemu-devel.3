Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEW2-0001Rq-Qh; Tue, 07 Jul 2026 18:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW1-0001R9-KN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW0-0004Cp-2v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cace91f112so825825ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464223; x=1784069023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYpy9moJ1+tY6k9a9oX2AsYalmyatmE1LDfnjIQQLE0=;
 b=exhzCoDoRc4Tv78dS4bCuXDdcpn3rhS5Jvpv/97hEQjr3hknVJvRv3JVnWJv60JSLE
 QJsf7gPIhoMnKBGYog2ZQXWVDXMVIMuITkYgnEqU3LIsX4Fee88L4LvI+QeKhbEHpRGP
 DSA7GyNgTF2cgWznCslhFDxlMco4DxoyfJ39gxaaz2rm3e8gFsK8HxZkUkWPbe9bJBhw
 YBHkFBQvK4YIh99phzoNYE7ByPTm2t6RjQC2fFeU1zfskJUsSNi9udSH0HZ/mqeqBXqo
 3uhftlSbj3PU77Nw8Vs2cvXJobGkGjSTLKJPM9QWP5CwF4P2/B9mxj9zFyNumN6sefDe
 NAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464223; x=1784069023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PYpy9moJ1+tY6k9a9oX2AsYalmyatmE1LDfnjIQQLE0=;
 b=c9hlf21BdME/txRCQsB+23h7JYEq2CccWxNzIILqUqdOo5lztX88iPqwzXRvguOS8Q
 b/Ls59fF9Qh4li8K5gza9Z1wj3fdZxlgXySIYOAbWfauEAioEwDk7p4jRjK8W9F4G1Le
 7ltdAE/mJaui7OiRqWZfAyowhblWWv4b/3ydInwnUuJAkcc/iPniwvwN2KnVO4UKPff3
 zw21i2Ryowz1hx2yCRshYqx370sRGM5VHZ7VqssGrf1yqEI9zTNOv1/KRz1Nz4JKU9uC
 VjyfzKDkSmcxsiJvH5JZbLfLf62wz6fGib0OBBQEE3Fwea7x1PYX09ClbBEfg1gKTdZr
 Qiew==
X-Gm-Message-State: AOJu0YxeyE7hmuDCy+Jrh87Ei1ekGwNhT0YiDCsKwDw43dKQdTDipAgQ
 KU7qYqhKC4Ytr5ZWJPSdpYqb4RR0hU9bfD3dyKUmVR/l8SryuIhEOShrFD1KX1VsIaI=
X-Gm-Gg: AfdE7cl1KzjvjPo+TH0o0T0k2a0EucjsXKS8dp3kbMyRnPrQLR2ABzfMOnwTq/ob4z3
 gZPYN1TSH+IMT3U7gacUdiapW8czo8q/YEI42WBpkH95b/EQCLaWYd+WoKQVkP+QJg8DWwDDIPA
 Y1z398gcsVfpUcyoA/w5R9ZHmeSm64N8ue1xKUMoaio0Dym7nVopNWC1O/QIta9dFm97o8oF94H
 dINe9XhQcKOQL7ghUzLv6P+rkxZY9cHlpV7iRoxl/B+J2eFXLapNkzMukBGEtDDnsLbnUaTSSkE
 eUYKiYEdLkTauCiMrXLP8ekKNoMrFHJ5eujb2wcSjTQlYkIdKwwj5FuTm+ynqCXyI4a3DziTabi
 DxVPMJ8l96X+HWvdxGfy2vVxZ0Z4vkqoqsOiSiKtdJkoSwu7OtxA4O1c83GxounCE4RJKJmonwS
 +qYEqaTJe76Y4syXHXoIMkILwA3i3t/w8twe502Ls=
X-Received: by 2002:a17:902:ce82:b0:2cc:89ce:2ef8 with SMTP id
 d9443c01a7336-2ccbf05bd36mr68310485ad.40.1783464222672; 
 Tue, 07 Jul 2026 15:43:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:42 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 16/25] hw/arm/virt: Set proper conduit method for Realms
Date: Tue,  7 Jul 2026 16:42:57 -0600
Message-ID: <20260707224306.1202330-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The HVC conduit for PSCI is not supported for Realms, so default
to SMC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6a3c69ba8f90..317816f942de 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -274,6 +274,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2952,10 +2957,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
-- 
2.43.0


