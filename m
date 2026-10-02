Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403AFCA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjke-0007T4-Ez; Fri, 02 Oct 2026 16:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkZ-0007O8-RS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkX-0005of-CV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e4a341d177so1692715ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972456; x=1791577256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZF8fC0jHy96GLAa6nYvC5U705z1kSHOy/j/N3xBALMk=;
 b=UIjgzjLhU5tq0fZp1qG+nYOGnxewgPhAKOrAd409SvUBJgI56jV7Yc4odxc97AEL1v
 pknqOfDmUWyj3W0O+rsHO0ZWiN8/vkMmywE+a0loavSqn7bTXq3q/AmowZTZ+N4EQXCQ
 3O3kzATzLpAoDjsVC0TrVoXlpxE0GKGPPY0bd2kH7zEiABfj6fe8D/b59lCLqBJn61NA
 wzZqp3yai2nlaUVUiozo9KEeQUOp3vpVVXnWQwYsTOnlRgKbYHVXE4GdGk/ZBbDneyqT
 M44GeR2CEYc/gr7AaZN4QyyNZ6+YfsLFxH2BwxLJyizjQOvpdGduz0IDVEkDT6OJybxm
 Q98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972456; x=1791577256;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZF8fC0jHy96GLAa6nYvC5U705z1kSHOy/j/N3xBALMk=;
 b=UbaXocIYA1LK3jFAxLKn5lVqn/5sch4e7MhhFq54sqWcTFheEHz646YUnn3eZImKAe
 coATmcziapvuUCO08cka2y/S/ZEn2q8o8EiDeiQ0HBqnX5nTqcvehazIZ8OCrmkxhUru
 gAhUB6agZ2bXCNfKbYvPqokf0AG5uTosu+PMMIhqW2+GBy0DGmPRpkRA7Ysj1nWeF9zs
 bf4MMV7op2Pz9kccW4DwpdsHepbworwmBntZ8C9RihmlGI22xoEXyQ2AXMSudqABvZKG
 HbmFRXXoPs8svJ+YURXP9WcizfOkqhJTaYA3bJfE9B4lUIbMQxk7ifeWQkBSn/6dDb2G
 y7xQ==
X-Gm-Message-State: AFq9FYKMvqZxxo4mIMe7g+aeod/9rGtS7ZUS/E1/2r1k9HPP9+0r3cHt
 VA3yYiTBH1hODlywJS6EMPe6IXoMsqNPsgKrbacyBHCKeABknFGVgq/XZ0eO2lCxKgc=
X-Gm-Gg: AYBFou0Wdg3W6KXPpMQB2dGzHyiXAnqlMngSr9H6H3ex5/khU7opLQLUeOP3h5wtWni
 7Hm18UBYKQ8cmVM83bNY89eZXH6Pw3H2lmPb0NzYkGm3AnTOhxhimSOryOrHWG+EfAfzdqInFPo
 hydeUFNh74YtymN5qUoUWnOomtbEspjo40f3GSsdK1ladW3zhH/35OtxlQBVmiabMSgPwIgmylo
 NiBScKeSn+ulbAP2HiWfQnVzWrnMu1LxiBlzicdEKcY0GqI7KkM3uhY4xBuU91UrhCfbyZKrADP
 gfj+yo4vG4x99FoKziHL+WmXOjhy8p4V3E7PIfZTrBtOBboRmEPZFvfP5s5t4C+cDPq5zMeoNgN
 IOWyR4hzUL1wmUnGypXtPk3r+oyLGM6emAWmC4NleeUquDB3uJWdZFL6iSa/USM+/vDgfZRU5rn
 dsk1hhb529kRsmIGoIKSFWFhlrdfFx/r96fd42GAaBoTTgtAPLfulONR7jV8B/kUtC1DhNpadwV
 DyJlDAyOoAMoO3+73lxdlFeOIpSpLsnq30=
X-Received: by 2002:a17:902:c947:b0:2dd:c053:e0f8 with SMTP id
 d9443c01a7336-2e5106142d1mr5307805ad.39.1790972452627; 
 Fri, 02 Oct 2026 13:20:52 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:52 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 13/22] hw/arm/virt: Set proper conduit method for Realms
Date: Fri,  2 Oct 2026 14:20:17 -0600
Message-ID: <20261002202026.1204110-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x631.google.com
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
index bdac33a1de86..5ab4bb23ef2d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -272,6 +272,11 @@ static const int a15irqmap[] = {
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
@@ -2945,10 +2950,11 @@ static void machvirt_init(MachineState *machine)
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


