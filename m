Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A98FD874C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2T9M-0000AM-93; Tue, 17 Mar 2026 08:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8e-0008T2-Pk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8d-0001VJ-8N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so67515555e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748985; x=1774353785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0HxmPJnGmE7FQY9r6fCQKIQrTNRChdRwpx8XRwLBNY=;
 b=RvF1Vg2t+n79phkOmVmPASjLzbhGYliNPDIAtfTBn4rkangrVdPrlE0kRHLFgm6vUL
 q3/pf7TU11aTua/llRvuT/3buZ/p9Rue+LL5/5zjHouek+a8+F4NlYF/t5ctfBLGMOPB
 fzgxsz91CsvnpNAOGliA79CVdPC/6LuxT7PKprc7NQlEAWTlF4YEdH/V5Tt0rmYhM4LF
 IvaVxrnNjti5F5O8OHqGFV8sICuvt2ddan/h/Un4JCt7Y7ydaBkYfRtJ63mLsiSNNki2
 j77K1OCBpz7EMpS18JgcJ7/U+J07wICu4IlxrpT1wtPX1C21a0N9fpsz/VyPCDfVDnRG
 QgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748985; x=1774353785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T0HxmPJnGmE7FQY9r6fCQKIQrTNRChdRwpx8XRwLBNY=;
 b=TCYqtmM6m5akyaArRgaKV6zJDAmFSVzFmDhNjFac1jTtsHjNPPgGiW49kwp7YEVmCj
 MEX0K3gKEQJoQ7nFGTsxejFk/676RXyLY83Z+9zZBaU8owJNw70ZljZA431FOnAVGNRL
 4jdU+Iht5dl2EOP5XrNsU1/EYXy8HVNqWh4pgShGMYNgqyVB4zFThaMK5swx+hkZfwmf
 4ZLAARX1na5KdQaLWWSYJrdJs4yhU8nJc5WO9NlkYePAldZeWXzTPLGRgODFGmN+tkWC
 xAzS9CuvIi1A4e8fH4NoFmHxYY7sufwqm74dEUK0FQl8K9DMH/BF7wPu0WxpvGz8VKqH
 XxIw==
X-Gm-Message-State: AOJu0YyzQybB0xO2xAHLkXxXQtmRoQ7to7lfb/g6yx9Kw1rrHl098di/
 4aVxWMWy2c7qi3KERR3x6/x1PFbSYlb0n9/MorMAXO5Kl4CfIXbvum2bzqF4e/VtVv0KN2NCTWa
 n0DFXgns=
X-Gm-Gg: ATEYQzwdFnzvefpDI6xD1Jye3HlKGCMTuyZEz4kpOUZ3TDUhq6F7FLs27V0SiO+tWoB
 fy7f1GFHkOt84P6qc8nH1jRHRYOOmqyO+Em+cKHWU5Xurc3pt/dNycugTAcI/zmI6q+itrlM/4w
 jIrR+HcOPUA5jBLFU+XiGnOrdJFbNYdQO9FvCAgcyUXEdQDegYm2X/38Vx3hQ6Ed0Oqaf/vVkPp
 1WmdLuGJCbEWiazboWjjbRmBqYgAl/SviSdCNleObYMus9YhSe4TE9crbFV8Gnuph+rI4P2SQYi
 158YoigmLh9BvXCr3GKhfMZlGIMQVL09BBXRS2+85znYkn9OypwxZcRlTUpeirAXCrSNEjK6Tfg
 MP4Cucx92+X4W9kl+BJ+rVPHKglXfVJjotAlOWjc6hU+mzcLay57bZ+50TSmOucek3gwxbSSqWX
 gtR5zsC8venrzhZ9Kye24YJVcXZGne6ZrECBVaUUKFLGCRvf+UE1omVpqXziBbcM8mGjB0Zig6G
 4T3pLwLBEg=
X-Received: by 2002:a05:600c:6287:b0:485:2c61:9457 with SMTP id
 5b1f17b1804b1-485566d6e1cmr281959095e9.10.1773748985261; 
 Tue, 17 Mar 2026 05:03:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74228sm118143125e9.18.2026.03.17.05.03.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 05:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/5] hw/tpm: Remove CRBState::ppi_enabled field
Date: Tue, 17 Mar 2026 13:02:39 +0100
Message-ID: <20260317120241.16320-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317120241.16320-1-philmd@linaro.org>
References: <20260317120241.16320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


