Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37260FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkZ-0007Dt-DM; Wed, 22 Apr 2026 16:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkM-0006cF-Qt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkA-0001oQ-Aj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso2916428f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888015; x=1777492815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tuztnUlSfQwod8ju5RlZjEzCQ50es7B6MliV5SRpEGk=;
 b=D/ph68DWIk0mu3pqOLptWGshCIi77ckQJ+AuL1fcyJkMhmcn3KmwyKjA22j1IUa0Wk
 SvAysXIcwvYJnc/L4CDkwFsBdMiZUeVOCPIAihz6GqUDM1H8i+WGQ+sAsmuy8bgDaj63
 yl5QAF+tqjG2J6itnbL1IrfvMYVaODoS1Gbz2sJejDUICzKXokWDt2Ub9DfUmCXlLCje
 bj7RsPnnam/aCv4t3IJXCGS3r3agOZUdz9ekRnfza3XUtx287Jt5ZKAaeJE+KWIwDEy0
 qarO4U0gEx7QuVIpvbCteSE1o9Y1+SndEa2N/cL+eIwY9JXkMcEFMSOJtf2tQmNy2KYm
 5UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888015; x=1777492815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tuztnUlSfQwod8ju5RlZjEzCQ50es7B6MliV5SRpEGk=;
 b=EYoqNXRC+WlGs/4CjSwvw9lE7rvV/vvIBkDaGRpAXDerEyejz++fCqHyqnyxa2hpIG
 NTAvQgBK46sMuJsVsThkeZ4zvbM3vdVIl47gIBzuD1tjTUmEnAFp1OU48OD9GnilNTYH
 ae48LFUZKhj/nwPXQifOWoPc9ms3/wL6rZluhTZmDQ3QcXhWizue9cET5qQ1dlhFkcED
 8pHMpGZMwIAucDZzsc3kWy0/4qfZ3+K0VQ8b/Xno4au94ERz2ZR5TvBty9dQZMWxlVer
 gNg9YclhRW42WUkC5ektRw9/EkyfiKrDyEoGeRjalP4dYmZ1smrTVFhFmOQ2EYaJeRtv
 1Syw==
X-Gm-Message-State: AOJu0Yy/2Q600btoiIzJPimL0FYmf3NlTjnGYpWRViOfZwOz3FDtHjOx
 tjA9zdZJ066oEzjgSnMaVQ0FD2sgaM2tYiwcUY/GhvBvBg0foVMJqmbpAYLos3ZdIUEhhY7xo86
 QVyGmO7c=
X-Gm-Gg: AeBDieuHtdsewR7iOWouy01YkPugtskjkin7B/Vq62LhNJdGvVWFAMKU4Pygwcz+2lm
 Nm+i9BObva0b81Q4TOPN5ratUjJGGWnP6Eg+k66qqTLK/Xyq3KVAhuhY4tFHs+L5oMkVGnIhz6l
 w6Arl7N3BGGfZfxY8BBMNN+vGIc+yu/4f5MrYJyWzdhrdQNrMIqJwqGtQ+3U0MdEm2cAXAIBUAQ
 kKTJPFS7zfNbp+TDvsVpqwreF6R7rfFR1gbJzR2DAHIz/SX3TOugFpeeVuKZmC8PFPtZ1UY1SWT
 JDSY0VVdYPH5OQcgbD/KSzoTZ7qgVwG1Z7bXD2EV3mdEC/RAYPUOnXVkNeJwNJ0K8tFkhenEt9f
 dwP+ruerragsxqH11tKSJdVDk8ZTFRKbkCdCqppw82n0utHiLcZfmYJCkDDXY2csFZzD2Bt8xIk
 ON1wiKyESh/5VU5eB0wU4sKmM3H7L6jEXs+j8DpIUuXs+c5+fTzBG0uYDL2834okYUKmSMTvDPH
 Pg6s66xP3FjqItRGC2kcQ==
X-Received: by 2002:a05:6000:1ac7:b0:43c:ff58:35c2 with SMTP id
 ffacd0b85a97d-43fe3dc5eaemr38074018f8f.20.1776888015335; 
 Wed, 22 Apr 2026 13:00:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm52513910f8f.18.2026.04.22.13.00.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/48] hw/tpm: Remove CRBState::ppi_enabled field
Date: Wed, 22 Apr 2026 21:57:19 +0200
Message-ID: <20260422195746.88865-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The CRBState::ppi_enabled boolean was only set in the
hw_compat_3_1[] array, via the 'ppi=false' property.
We removed all machines using that array, and the array
itself in commit a861ffef237 ("hw/core/machine: Remove
the hw_compat_3_1[] array"). We can safely remove the
now unused property. Since CRB devices always use PPI,
simplify removing the CRBState::ppi_enabled field.
Set the generic TPMIfClass::ppi_enabled so ACPI subsystem
can keep checking its availability.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20260317120241.16320-4-philmd@linaro.org>
---
 hw/tpm/tpm_crb.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8723536f931..02701ab9480 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -43,7 +43,6 @@ struct CRBState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 };
 typedef struct CRBState CRBState;
@@ -228,16 +227,13 @@ static const VMStateDescription vmstate_tpm_crb = {
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
-    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
 };
 
 static void tpm_crb_reset(void *dev)
 {
     CRBState *s = CRB(dev);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_reset(&s->ppi);
-    }
+    tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->tpmbe);
 
     memset(s->regs, 0, sizeof(s->regs));
@@ -303,10 +299,8 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, get_system_memory(),
-                     TPM_PPI_ADDR_BASE, OBJECT(s));
-    }
+    tpm_ppi_init(&s->ppi, get_system_memory(),
+                 TPM_PPI_ADDR_BASE, OBJECT(s));
 
     if (xen_enabled()) {
         tpm_crb_reset(dev);
@@ -325,6 +319,7 @@ static void tpm_crb_class_init(ObjectClass *klass, const void *data)
     dc->vmsd  = &vmstate_tpm_crb;
     dc->user_creatable = true;
     tc->model = TPM_MODEL_TPM_CRB;
+    tc->ppi_enabled = true;
     tc->get_version = tpm_crb_get_version;
     tc->request_completed = tpm_crb_request_completed;
 
-- 
2.53.0


