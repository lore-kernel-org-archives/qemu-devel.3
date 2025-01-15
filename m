Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF685C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCj5-0000ET-W6; Wed, 15 Jan 2025 18:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCj4-0000E3-NF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:06 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCj1-0003p0-0l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:05 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so201888f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983381; x=1737588181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mjrt+h0wE8tMpMJFIByyz0AtYhg5PsHPp+wMY17/Vb8=;
 b=M+WElkCMmF6dTjv5d/CSXTTOYZOJPLgNxQV8u/JTgp7dbdzHjywAu0A3f39a2meOOR
 islwH8gz7RkrUzW32IjVt5kKwL7UG2FvIuwyF+SQ4nYJjT2ES6D0AmKXHDvEV4pt20Lz
 7vnhU7I7nR9TWWKy0iV2wfT+RbnglXjmZ2W3jNqcJuOl6JOUm4eK46Ai0ZeWgfRl4KvT
 ROtKbttCp8O8VfN2UrLzvIeZd1+IW0ZU4mDvA5JrP28RfilN8lvaDs0Bk9irx1TbGeJp
 VTxZWWQJGyBdTpHI2Mrzde7bLibSztuGcFITNytizC3YAkox7yETZvzdOaH8Ad/9uW80
 KapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983381; x=1737588181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mjrt+h0wE8tMpMJFIByyz0AtYhg5PsHPp+wMY17/Vb8=;
 b=F68zFnjyo03iPEk03S9MuAmznw/WN3pRQ1c+f2exNvzqKRjkyGmmHomcsH8diVmIsc
 o0UTFivWh6UqBVpJoUEKQPEvzqWU/ZuIFPJgIK1FAxag967AF6coD1Vgq6Ke41nB6N+9
 tBV63WeMOkgiZUOb6gzcxFidF6cHU4BfeRXfEwwQNl9wdZrvBQHEd1+RTOobnxaTx84G
 e4qyqlmxTNKPs4zsXlM0mpovl7LLrp5XX67OHFk2dzn+6K4lMl3TFUO0OdgyGFcm2hk8
 VRbUMGsCjrpGh+Xg9qLvHlk/CeoGC8QHUsKQ6GpFlf0BW5Mh6id2uYQxozTKUpKa4RhV
 XRaA==
X-Gm-Message-State: AOJu0Ywy7i2CxblNWqLRyiL5wCsFQ/vUqzD6J3jke44mre6a6MQv0gKy
 KOD7vwl6EkCW6RaS71PJ6p0KYCbirdAnbCCtHyuO7bA8Gs9OfIZs7jNqsDRFnkhBTBBxrGnxUmu
 1sow=
X-Gm-Gg: ASbGncv4oIU/6kfJ8bNwXmZnxgHWc9h6mY+lCOyDKft4uuZP4sAMvw5RnpcYGiu/L5t
 nYWGHKPJjfUg9It0Lx86OlraH9OPYOy+iTgciF2gbfubbjUs0f0xJCF3uH4jt4oktg0rcQEpJm9
 teyNBwFJVkgahFneafkoJUQCFoU67qzYwLIjHBm1odqkRe/7/dHkjN42hoq6emhV1IWFXpag3q1
 wLcxrgvVUcV50tFAufbW4I2aFmXifuYxC8Zy8lD/YLY1LUwLAuYBvLq99b3CarMu3a/DqZZD5ZF
 l6hqOMpChzjcNNU/rwkJ8i62L8racB0=
X-Google-Smtp-Source: AGHT+IFpiFwVXNqaLM/t0gWKima8MRRv3gahn3Zg36+POf8tR8zRnnw+jdkDIT708GkcB9pcfqaMLw==
X-Received: by 2002:a05:6000:1448:b0:385:decf:52bc with SMTP id
 ffacd0b85a97d-38a872ea782mr27194293f8f.32.1736983380584; 
 Wed, 15 Jan 2025 15:23:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac5f9sm37984425e9.11.2025.01.15.15.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:22:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 02/21] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Date: Thu, 16 Jan 2025 00:22:28 +0100
Message-ID: <20250115232247.30364-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  4 ++++
 hw/i386/pc_piix.c               | 13 -------------
 hw/i386/pc_q35.c                | 13 -------------
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c6616ce05e5..e4bdb385a25 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1012,6 +1012,10 @@ This machine has been renamed ``fuloong2e``.
 These machine types were very old and likely could not be used for live
 migration from old QEMU versions anymore. Use a newer machine type instead.
 
+``pc-q35-2.4`` and `pc-i440fx-2.4` (removed in 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''
+This versioned machine has been supported for a period of more than 6 years.
+
 Raspberry Pi ``raspi2`` and ``raspi3`` machines (removed in 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adcd..64c1ab5ff3f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -780,19 +780,6 @@ static void pc_i440fx_machine_2_5_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 5);
 
-static void pc_i440fx_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 4);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77536dd697f..847f56263f3 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -674,16 +674,3 @@ static void pc_q35_machine_2_5_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 5);
-
-static void pc_q35_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_Q35_MACHINE(2, 4);
-- 
2.47.1


