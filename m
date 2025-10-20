Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C55CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnIG-0000oM-2g; Mon, 20 Oct 2025 06:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHv-0000gv-7Y
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHt-0000Fk-7s
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:50 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so3793221f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956727; x=1761561527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XchvKX1P3pmKtpFUzec2QYG+hUglh7SzS1YPHheIc9Y=;
 b=s6eQQEnzqlB71OFpF8B9Vm6z/Nr29PBFeJkPzkm0wZcl7Ay7Qsd8z9sbMNXTvJCzZu
 5+K6VYOkxbOQKeRiPZZtrK6Ri0gZFHdUGjaYhTpEzzS18bgvl0r/kuY0lRZPWrTm/Dh0
 OLDEIHY+lbj6B8lcDUIY1ncRgpgFkeq5bqdGEdQj0QixHd1iAJYtHSxIrwqEm8HWhqMT
 a9Ccg1wcjipG9LXlvhaHepC9H5TK9tFt9MOcEofIXbSg/eeDLUxOtyAFtasfPYNrwi6O
 ICb9/iy4K5jZ3WAVd2Er3Nc/IzgZlTRFmKXwjpQQ/EAwMINyvJUwMRDntr5YkpRrL5s0
 wolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956727; x=1761561527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XchvKX1P3pmKtpFUzec2QYG+hUglh7SzS1YPHheIc9Y=;
 b=a0Ex61qu+C/PJpk6eUUOkN9/Gb7LuiCbbRLtzTNzmaL3HTIeom6cMsbaVrEvCHDeYi
 17p9xu186wrAO1/T7IHeBgP1+hsl+K7VmPjkXLQutBn7xcrigbfNsexHfHobwi+AmJC4
 zIyx3DKj5ErBqYGz+EgQnvZdCpNiVtTeysS5clx/4ExTYJsEfeEzm8PUw1BAMrqgBWp8
 6fw5F1oKK3TgPTV+dRDoyfIDz6Vj09QsgOg+xdg/IT7QSMTGcWgDqprBpMf1Py+msS5V
 9q+6Z/e5C5DKRIohv0Rnv9ecz5YrK3G0J5IVnhVfmjSHn9lteZ7qYZK4o4UF3osaW976
 wDYQ==
X-Gm-Message-State: AOJu0Yy8iY3Pmgb3YO14VF03nka6n0Yuls0ALx9nYSa6S42fTcrnVElV
 0hbKJCHvYymWw6yWIqixliDQqYqGzhnKB7/RKJeV6MYL1ln0DXomYpROguPWtS6AA0cQ9Hsp4hC
 jrubnuK0=
X-Gm-Gg: ASbGncv7W/hcuxyn0qLQj4bTpnA6D0w6RR4P1p8SDakb+RvbbUFqyW7ev5Fq6ocoffh
 qs11xmY4XLyyHlqTSw9ryLTvQRS/fujfF7PAzV0bLLlM8FmogdtrQMhtM9ZHF5TyB83Mc0ndAWo
 oF4GC7t0399BVFjeptD5Rb11ekY7/Wn1Ad0tmdz9osu8B87lmC5D9UbIqMpO+1n/CTs7cYTyk7p
 x7Kto+PJLl8XwBnChNAcYNvAhicUrx14yE2DK0BNF1aaEdKohxH2HOA9dH+vFHebG6qq//HKZOc
 7GLmTr9NqRYuYrt4hoPlO2N85BvH6h9cJsTJTOtDjeQdm0CSg4Z0ZTfHeXhbKCCG0P3cbIG7BF/
 ESWDLM6D0LGhm8Tn8eKzaCuTTR8QS0fPNmZQGN29auKqAb/kemUsqLf9FLMtH6FKMe7qnP+VN4B
 mMcvRar0WpUbgmZCIhQeRFKIhw828xGLpsDE93/rvQm+SRC8orJ2IJL4lCVUEw
X-Google-Smtp-Source: AGHT+IHQgd4IyBZk1X8qax/mfrCj0WRZC+hpDHiPajM8IGn0ydegHDG75cWXcjnzX++NX0Exg2anBQ==
X-Received: by 2002:a5d:64c4:0:b0:426:d51c:4d71 with SMTP id
 ffacd0b85a97d-42704d44253mr6869195f8f.8.1760956726904; 
 Mon, 20 Oct 2025 03:38:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ba01bsm14420098f8f.41.2025.10.20.03.38.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/18] hw/ppc/spapr: Remove
 SpaprMachineClass::broken_host_serial_model field
Date: Mon, 20 Oct 2025 12:38:02 +0200
Message-ID: <20251020103815.78415-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The SpaprMachineClass::broken_host_serial_model field was only used by
the pseries-3.1 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 1 -
 hw/ppc/spapr.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 494367fb99a..06e2ad8ffe6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -145,7 +145,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2e07c5604aa..e06eefa3233 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1213,16 +1213,10 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     /* Host Model & Serial Number */
     if (spapr->host_model) {
         _FDT(fdt_setprop_string(fdt, 0, "host-model", spapr->host_model));
-    } else if (smc->broken_host_serial_model && kvmppc_get_host_model(&buf)) {
-        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
-        g_free(buf);
     }
 
     if (spapr->host_serial) {
         _FDT(fdt_setprop_string(fdt, 0, "host-serial", spapr->host_serial));
-    } else if (smc->broken_host_serial_model && kvmppc_get_host_serial(&buf)) {
-        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
-        g_free(buf);
     }
 
     _FDT(fdt_setprop_cell(fdt, 0, "#address-cells", 2));
-- 
2.51.0


