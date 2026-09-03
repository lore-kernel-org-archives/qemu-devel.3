Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D14DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEs-0001WY-Le; Thu, 03 Sep 2026 15:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEq-0001VN-SB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:44 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEn-0004GP-Ue
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:44 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc328b43a56so309524a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464200; x=1789069000; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jnpbPx5FmdZp5NVb3i561iSd61Y1NnaCqk0khHU6ssM=;
 b=TxikQErAmI0QQeZL6E4f4ArGv+hYz5c3PQPP5vnx7eCHbovU4QzXCautW9ENZud2oT
 XYTVfjCadgtsOyJdPlDKFIsJPvCK5ZYwD7puh4TjawKCu5Kp45I2fzDID21V7pEmuLL4
 D0bup6FMuKQL3QCvj6q6mLIUv+YNmbCoI//VVZfXq+kXzZKPW3tqF6CfENraGiSxF5Lj
 Uy1CPt3fH05g2wZgW3KPvY0o8ZLgUF06SKdozsObtsMfbmRnjGOeHm+KoLl8tUCA1cNz
 fo6Hp1TEcfP62Aj310ZNdgCeLd4RP2KcbpCbi+uI0GBGol9QbnP24otmtorKqyfwK8Er
 KxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464200; x=1789069000;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jnpbPx5FmdZp5NVb3i561iSd61Y1NnaCqk0khHU6ssM=;
 b=rXVHnB80uliOxnLm9T0sxk4Op6+IGNBtLCd2Re/GnF/4TJIIaj36f9druDPpi80cBr
 YU24xDBzgsN9KeWIpoRxiKj6dx5jz2fLJIzGLXhT1QqfjufBqYjrgE79x3s4kODJ+jf+
 MhQM6I23/BP7PC2pIZ+SAzbSbzJ0/QmKUSpqNP4bJpZRj1f3fCZUUoIEdM9oj5ewGMGY
 ckuE7qEqhGXxI7JxJMZsOuwFV0J57ttWpdmWNEZhhqtNUdxBzNEASR02UShZ0XOld1ox
 P4Frgmjt6FABf9fz6OOClmRko0ZOO9N24bnIbFjZpcMrOuxTcTT308osD91M5UXBVP0K
 206Q==
X-Gm-Message-State: AFuF++nop0Js0G6NNV/a5889dvIbu+Vb6AZT7WsyUc9Q/W7G6BjmbB/P
 KkL6b/cJghCtSqjELJgz2AonkiK23KMvmKyQSO7ia8pY4Y1X+1xs7EmtyOI+aotCwAA=
X-Gm-Gg: AYBFou3vq4wsKvhhnRUFjHt/hrmBcrx8tEc1RnpyzNVnuMgSeewWO8Oqh16Yj3iGTAL
 y3/TnFPMKzzgytVwTClIEF1RFY6Ak5grf/hrt2Xcddx/BRhYR5hJZOO8BXQChkilEfxJLnd9IMX
 2XUDVPVpvifecNXCFiZ5aVCEtGhM4KjMcTbaZENWEhaHUfVsMpakjKuDfqUwPmXPLerw8ty+Hr8
 mGgIjCzFVVMdCwkDHTTC0qIGeTCfox0+PNLv4sBFsE/Yft2HpFcwAv+mNyxdnjj69TnjJlYpkjZ
 ZByQWHArR+pWXDgmXndLfjdrOEbUVe7kEXOL6+Plu/c/PEfVxaPXmRUES1oJsMZMxm0y8lcCQEj
 nDoPiLCB0vigHootNr+Y1NFscFtmPqSf4u4xxLhwOz+tU/oSC2MmB68MDetNswNva3xLjLYlSvv
 gm8A0+u0xzbWGz/sFyRHF+DdbaYzYtgGLpjA6Msv4/K2dkeOE7eBvRD7f6azf7wYD6pma3m97DI
 cjlpweHuNNZ4/Y=
X-Received: by 2002:a17:90b:3c05:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-39b26106c44mr1332861a91.10.1788464200324; 
 Thu, 03 Sep 2026 12:36:40 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:39 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 15/24] hw/arm/virt: Set proper conduit method for Realms
Date: Thu,  3 Sep 2026 13:36:02 -0600
Message-ID: <20260903193611.1058589-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pg1-x52c.google.com
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
index d738b95c7264..37211bc81926 100644
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


