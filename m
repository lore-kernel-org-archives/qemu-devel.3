Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F2FD874E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2T9V-0000Ij-QS; Tue, 17 Mar 2026 08:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8m-0008UE-V3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8k-0001Vm-Bz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:03:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so64534575e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748992; x=1774353792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1iBN45/0I325gjkdxYXymOeFIR0ZvQlgHa0U8JXzqg=;
 b=XLazJ4VYnd3lFib4L7/a9kYiljz4TbbnnN/1UnpVea+Yb7+O5uPjisyO94Xm7QQEMN
 HTJvGxfV0xSLr36+15osKxajevkAbieyc0r14V5yiimHcvvdnlErKP2NjT+a5MYZR568
 pZzTkxVHB9dNOe6kwav+0+knCFim+G8yRWHBmH6yCn+0caNAVBgQYufVdVGRmUvMpG3P
 uAN0wjqohPhbG6XoCezF3lGH9IXPNxibXtv1pQuRbdyCkoOcHhIIDN0aplpFZ1UagAMa
 2E6NrxhIUtCMAGazIHmFA9f1W7pFsOlveGQYLoK+2zUJ+3+c5TIkb5GSjWDsDbhJuYrs
 D8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748992; x=1774353792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1iBN45/0I325gjkdxYXymOeFIR0ZvQlgHa0U8JXzqg=;
 b=I5FD5mPtI+FTUAj8CXzUHVtIsY5oqR2y5+/hua2zyPUgPVds+ohguV79CcLg3VcyFB
 zwDoFkEBHUIKKxdQZh5Z3g6mRPvtq4Zvn0YTt/ixGVtHzBzpOahRC36wUJUb4eqELEwo
 DlrbFFL6L2PFt6Bl7bXilU62/vyhXaxGV8ztImXV0IaSGsH2yZwPVhh75MUcK08eAE4/
 9MvZ4/uq7odZTUKaZ+byylzfi9RzTN9x+SOIAYcnjoAt0ML9halVvgqKoGaslqHL31Gn
 yT0NnYjCxl4+G4+pDy2sNMZT4AMOZSSslNB+ve8c6dS74zS3tbu4chG0Qezi6toJjVyM
 3IVA==
X-Gm-Message-State: AOJu0YyE+hIOXapyU2cmefkYhM9Hi4QFw0cGBM5/caI1VuAQfz7qXp3l
 JhBvU9EefHIC1/inGyWQN729l1/Y1P9Pw5qEjpyXR38QVoGk183VwekYes/UGjrwVb+K1wJ5N2T
 ae9i4g0o=
X-Gm-Gg: ATEYQzz+EQcA1Yj0WSCQbQplqf078hGkBsok5O5t7k7TMJtGrE/2YVT1lqSYaHxnbtx
 wdEsy/S/N3qR7DwK4b6VJE7zzUK1G3IeSOGlf7we8Y/z9zVLvaqZ87a3W2/7+FjlyVsXyi+PHpn
 VZVqIXFEP/xpatyQKVyzvdO6jhEiadnHjneehOSTQWUbA98wKe2+zDlDT1mMgz2CAioYHR18t5H
 Wb4ytHag3agzRMd/+ycL3XQKUWfkjJGOSO6bZK0qdbqVHHGEdRZ0HJ+pZ6Mnmnu65vr7c7macYZ
 MPPVMr+hPmut7gA2ek2vRT1VicEBTNsJ6CRXFtHMIdLvjBDg92bwExfvdFwq9NSA6KQLkpAkYUw
 FDW5kglazCoLECPzS2rnQ6ocgse+wW1uGIbIXNaTQX87KHDQaq3kOj51PHi9c5wlg8wP9ePA3TI
 hRoGziStmzRErAeh7Q1IOJAAJcqRofSN49JdJd6dlBIvtqg54O8hraEnLsjKQTheltKQjC475q
X-Received: by 2002:a05:600c:1f8d:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-48556711dfcmr281363735e9.32.1773748992117; 
 Tue, 17 Mar 2026 05:03:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b4938854csm8602067f8f.34.2026.03.17.05.03.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 05:03:11 -0700 (PDT)
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
Subject: [PATCH v3 4/5] hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and
 remove in TPMState
Date: Tue, 17 Mar 2026 13:02:40 +0100
Message-ID: <20260317120241.16320-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317120241.16320-1-philmd@linaro.org>
References: <20260317120241.16320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Of TMP devices using FIFO mode, only the ISA variant has PPI,
and call tpm_ppi_init() to initialize the PPI state. Propagate
@ppi_enabled to tpm_tis_reset() so it only resets the PPI part
when requested (ISA case) otherwise the PPI is in uninitialized
state. Remove the now unused TPMState::ppi_enabled field. Set
the generic TPMIfClass::ppi_enabled so ACPI subsystem can keep
checking its availability.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tpm/tpm_tis.h        |  3 +--
 hw/tpm/tpm_tis_common.c |  4 ++--
 hw/tpm/tpm_tis_i2c.c    |  2 +-
 hw/tpm/tpm_tis_isa.c    | 10 ++++------
 hw/tpm/tpm_tis_sysbus.c |  2 +-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66b..1531620bf9d 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -75,7 +75,6 @@ typedef struct TPMState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 } TPMState;
 
@@ -83,7 +82,7 @@ extern const VMStateDescription vmstate_locty;
 extern const MemoryRegionOps tpm_tis_memory_ops;
 
 int tpm_tis_pre_save(TPMState *s);
-void tpm_tis_reset(TPMState *s);
+void tpm_tis_reset(TPMState *s, bool ppi_enabled);
 enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
 void tpm_tis_request_completed(TPMState *s, int ret);
 uint32_t tpm_tis_read_data(TPMState *s, hwaddr addr, unsigned size);
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index f594b15b8ab..a134d5c2059 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -813,7 +813,7 @@ enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
  * This function is called when the machine starts, resets or due to
  * S3 resume.
  */
-void tpm_tis_reset(TPMState *s)
+void tpm_tis_reset(TPMState *s, bool ppi_enabled)
 {
     int c;
 
@@ -821,7 +821,7 @@ void tpm_tis_reset(TPMState *s)
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);
 
-    if (s->ppi_enabled) {
+    if (ppi_enabled) {
         tpm_ppi_reset(&s->ppi);
     }
     tpm_backend_reset(s->be_driver);
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 9f13e0ec120..b4f258c7bcb 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -523,7 +523,7 @@ static void tpm_tis_i2c_reset(DeviceState *dev)
     i2cst->csum_enable = 0;
     i2cst->loc_sel = 0x00;
 
-    return tpm_tis_reset(s);
+    return tpm_tis_reset(s, false);
 }
 
 static void tpm_tis_i2c_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 61e95434f5b..1ca403241de 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -88,13 +88,12 @@ static void tpm_tis_isa_reset(DeviceState *dev)
     TPMStateISA *isadev = TPM_TIS_ISA(dev);
     TPMState *s = &isadev->state;
 
-    return tpm_tis_reset(s);
+    return tpm_tis_reset(s, true);
 }
 
 static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
-    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
 };
 
 static void tpm_tis_isa_initfn(Object *obj)
@@ -132,10 +131,8 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
-                     TPM_PPI_ADDR_BASE, OBJECT(dev));
-    }
+    tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                 TPM_PPI_ADDR_BASE, OBJECT(dev));
 }
 
 static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -175,6 +172,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, tpm_tis_isa_properties);
     dc->vmsd  = &vmstate_tpm_tis_isa;
     tc->model = TPM_MODEL_TPM_TIS;
+    tc->ppi_enabled = true;
     dc->realize = tpm_tis_isa_realizefn;
     device_class_set_legacy_reset(dc, tpm_tis_isa_reset);
     tc->request_completed = tpm_tis_isa_request_completed;
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index e9372e73163..dd30344d5ac 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -87,7 +87,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
     TPMState *s = &sbdev->state;
 
-    return tpm_tis_reset(s);
+    return tpm_tis_reset(s, false);
 }
 
 static const Property tpm_tis_sysbus_properties[] = {
-- 
2.53.0


