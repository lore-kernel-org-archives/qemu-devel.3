Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D32C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonSJ-0003QA-0I; Tue, 28 Jul 2026 15:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSH-0003PH-FJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:09 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSF-0001Yf-Vr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:09 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e347638adso231658a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266827; x=1785871627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rKkplhtluFWmCm3zdoFzjKyPXsLnGiTn/fxUme5nI1g=;
 b=nqtA8uCjEV9QsM7CBKNTyw+2WDdVFmSioSPkRUig34qC21Bev0fjgQQfGcziIbffeX
 GNgAGFmIFZdslxiyXCvw06Lpe0dqJ9M7ia4HHlsdyILxeKDVZxRhqAlssETkeOkveFFZ
 F1mwfsJ/dCi2UOSCiAmx6QnrdrCpgC27k3MGq7ov4cjN1dlHd4EwdSfV/c8oPze1s0EC
 aqeRy+7HcCXY0vLIJG7FnQY1s3a9zyOq++FDizWnwJ509LfRTmYWtEeP81Lcj8Dzg9xj
 WUa61MC3jK4/8NuZfp8VlWUD8PhgcRgiu6YOb9fhWL+In0yj+sBgHCuSB/2jAsUnHvJl
 i6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266827; x=1785871627;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rKkplhtluFWmCm3zdoFzjKyPXsLnGiTn/fxUme5nI1g=;
 b=kyFgnNEoKmwuGhWS4yyMlSy4Jf17D5heWejCKES9SOvXWF9+q2jmoj6KsDQY7dRUc3
 vT/B5Gn4z5LcLziEirFQ38cR+n/vMDJIZwqXb0SURnq4ws2MKq+mdbj+9W2Ane1oPk/L
 DFfZfy1T/9wJ0ujnBHAOktp4TZg+SRj7RaxpTxnTFTDWINLWVJ+9bo/uN3Mvysvy51+O
 olh6+FYhdqIfv7OL1ZOVgtx3GlfVc2nSiPynwGScWJzHOP7RUR34ZntYMidifeUVwMTd
 h1HTHTgw4cAqqcuF2Raviy8oSYcOaDlrCoFcqcrllA9O19B8peFvXXbvjW7kx0H30yGY
 RLSg==
X-Gm-Message-State: AOJu0YymyEKkPxNj6FTXdBa0v7RUGtis36W2E8VJDgZMNHOfql91w9D6
 z0Fmf6tadaZviSwBG8ahc2B62oODyDp2Jva55YodWewHKWuAwJNDyzBJ2LD7w1/cvMk=
X-Gm-Gg: AR+sD10q3UUcJ+1Mq6dX3f0WZ1A5VITZblrXeR9t2On/9BbGl2Z8sT9gip7De26pg45
 aXPxLqo7/VWL8eIZEDVYpPryURy0ipX33gSOo8S0ScY+UsyyTib68zAp4AlXVeAGotRH7wtK4/k
 HBYN5Mqki9iEwMhpeOQ9TQicB5fn6pK5+YYJ3WrY2FSZLfzIpNp1+iqJgCGBSyfWPD3fNjUlNQ4
 HCL194FC8Z2sn6TcD5kV/BHoEd0xMWVgA0x2VlJYQwELjiZnqmSzMHDtmqF/tUddl8kF8YBswdM
 1ZafTopzt0iJ6A7LYGVDBhSYGTjenWWhrlhbuFIxSTX48DTNVQeUyAKTELltQBshqvmggHwUxM+
 4FwYESI8OHF/dQJfZUJutiwWigvniSXhAZ7gOST2hvRbDnR1C/Fq55To1RfdZUAuKX5erNMkF4R
 qarI6oQG62mLyC2Ffl26Ya7JU2lDqfyn5gVITGPbk=
X-Received: by 2002:a17:90b:4f91:b0:38f:57f3:4dc6 with SMTP id
 98e67ed59e1d1-38f6a51c0c3mr3700949a91.21.1785266826646; 
 Tue, 28 Jul 2026 12:27:06 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:06 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 15/24] hw/arm/virt: Set proper conduit method for Realms
Date: Tue, 28 Jul 2026 13:26:21 -0600
Message-ID: <20260728192630.240375-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1035.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 219597cabd0b..27bed9755320 100644
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


