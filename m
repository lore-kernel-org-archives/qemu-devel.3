Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F19C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3e-0000bV-ST; Fri, 20 Jun 2025 18:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLX-0002cC-As
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLV-0004bl-Fv
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-453608ed113so19666695e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439767; x=1751044567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ9HzRGq2YkLK75aks6LUHy4qRCZf2MFv/UyfZ7+gZE=;
 b=nIUqd9gItaja0Qs4T8kJMXgyFW+HQoGJMApdw3fwqn+G6iz+zxwuWs831RS3GrO83u
 fPtz64kthxWMpfOtobVbz7Erqy9dtmrkmFHmJkFRv78ZXy8kDittBDd/JbLVvYRCs2rf
 OiTSrBYV9F5X01bPx0Vls5UzwfmK5qBryGdA8EC9Bd7b7QDUcWtIkYCQZ3eq04hZKoVQ
 6YkOirICpeaOitw4tWMuCKcToMArN7N4NrCo1TEfZQCLNgSkwrQ+AB/kMNIp1jDJzvpZ
 hVOPfcwjKJvo3cHJZFi72t/g1cRBy4rY9CIumClExm7jiSaOIAootdBKe/kClOXLANnH
 rtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439767; x=1751044567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJ9HzRGq2YkLK75aks6LUHy4qRCZf2MFv/UyfZ7+gZE=;
 b=wS6hpUTT11xpQWng8zdv1t7srRarff9tDcUTVx94iu7wEN5iBswFqvbm+sE8/JOnBF
 9PCTo0BUoe5Zfs1Zfq71C9+LmBBCx0MwgZgEcA391hCRlTVG0rUsjZUNWOcLPwDqd2NB
 3qtYbTllsoNAsiy3BHila+gI9ZaCByCmK8o1hOLIFDngxcXaYHRXklwYAg/+eCbE802E
 EUduBfabiwTc338aJQr7vMZDuebMM6XzKJI/AljKyqFDUksghVlKeMk9rB35F4StgK2g
 8071tWyVLNAS5rI4Qun0ws/apIVUphahdfczyyUR2oVCgEXhbHqvjUECP1vutjmIx4K2
 OFqQ==
X-Gm-Message-State: AOJu0YxkiDmfArK7ASU7Rd2bFMl4NIbG3phx9pLZvXgxaOPOZVoFwOi7
 PF86tNHBLWD+CCmliNu4ubIS32WoCh81rLYvYICOyomWrNk8CGodspd8fkRCX9c3noc7Chosx40
 +pai/jRs=
X-Gm-Gg: ASbGncvw1GELZ+Vz6xz8u6IP0DyADzxS0gDsTKTI3gpVD66NgFS8C84FjrLlbWufLsA
 EzK1YQc+eeX3/CAC9ukGNb3f7g/zYyuzRToZaFHxP6O26RB+Xr+lo821sAu5MWUVU8ut99tSOi5
 KsThjclf/w+WZ0JjJ2bc3PyEQnw6qntANjKMtDRfWK9UF+Y+PQSXgh9q8+JYazvBFeWMT6uM3Y6
 KQNZgkiG73oI8bOPr0x/T2tbIOlCP5zsE55rX9Fgq8QBjXo8iaD9Xd1Q/zYAJU9d8phLhOnoWwh
 QNbFsZNBfnKAp7Lt8SJrycI4zFTJ9FIDsywPBHniDPuoCDLLtNLt4NlTHlw+YzYkv4onn8UsBmo
 pNZ+QIU14y9aLWNK/erXgxClcsQXgExdL5CT1diP5/R12XgQ=
X-Google-Smtp-Source: AGHT+IH5c/ImGIRBOHX9TMX1WPZ+pT8ZA5uIZ3Q0mOI+aUtQ09+3enpvFQPkfINvKwpPfAZMIOUcgA==
X-Received: by 2002:a05:600c:8b67:b0:453:aca:4d05 with SMTP id
 5b1f17b1804b1-45365a04624mr38518265e9.31.1750439765890; 
 Fri, 20 Jun 2025 10:16:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647071f4sm31494625e9.34.2025.06.20.10.16.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 29/48] accel: Factor accel_create_vcpu_thread() out
Date: Fri, 20 Jun 2025 19:13:22 +0200
Message-ID: <20250620171342.92678-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Factor accel_create_vcpu_thread() out of system/cpus.c
to be able to access accel/ internal definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 19 +++++++++++++++++++
 system/cpus.c        |  4 +---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 4ed5f264a88..4e30a633bca 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -93,6 +93,8 @@ void accel_setup_post(MachineState *ms);
  */
 void accel_cpu_instance_init(CPUState *cpu);
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu);
+
 /**
  * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d1a5f3ca3df..d719917063e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -89,6 +89,25 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
+{
+    AccelClass *ac;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    ac = ACCEL_GET_CLASS(accel);
+
+    /* accelerators all implement the AccelOpsClass */
+    g_assert(ac->ops);
+
+    if (ac->ops->create_vcpu_thread != NULL) {
+        ac->ops->create_vcpu_thread(cpu);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     AccelState *accel = current_accel();
diff --git a/system/cpus.c b/system/cpus.c
index 4fb764ac880..1721b32fc3f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -698,9 +698,7 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    /* accelerators all implement the AccelOpsClass */
-    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
-    cpus_accel->create_vcpu_thread(cpu);
+    accel_create_vcpu_thread(NULL, cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &bql);
-- 
2.49.0


