Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7B1EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjgv-0006ex-Rs; Wed, 04 Feb 2026 15:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgu-0006eb-E2
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgs-0003AM-SY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so1576975e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237693; x=1770842493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPIlcBiRelExIRyQNM6oaC01DYiZibaRn5FV52AZS64=;
 b=O3wAP+JgRKE30tK0VUFkMUOuJMmKz/RNkEp6J9IIx0bhk/YeXycWyBnj/R2TzTg1Kn
 mN5dmqUQ/jz1WBygNacDJdOe5rNL3ps/T4FnQbxFF2MXv3l5L1FbisdM/7wlsTbuYitC
 IwbGcMDRkt6kkI2sgUsVI+lYufaRt4jsVuY0Ac8WWC+bYV/M5ocMrRgKa+oP6fU2z+Dx
 /enTkkTlDdJIe3FMl71+Fq55zzCBIA9rVHSZwbwV7AIOKEPfo6uGG1iPELd/WLYnA0kM
 6di7szYahflWXyN/TAMU8ZLQ3KG99ZZIu0NgRtTLvqRB+KLbtBuofrhmRoLosHVNrmlO
 ZsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237693; x=1770842493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iPIlcBiRelExIRyQNM6oaC01DYiZibaRn5FV52AZS64=;
 b=omkQ5YXL/wra8/F1yDSFkdag76G0D5nvPtHBEyOxffNibcdcLdBxJIRhUozCp3XR80
 xMVfrMhjL68IJkOZK6o81/J8QxwyldLFT33hG7Hc39kFBXrzyLYK73wNs2zXQQ42HOYY
 j20ceU0CXqehhNX1iYjQdP6OJGuJbW5WV0wudgB1OXIREpC+9kjnytGzvTQxGLW5iS/m
 oaSyUDdnuYnY4+0cxwcixTWJE8N6SkIAoWX+pe4+hoTSkQzYmxMb2cdthpEQR6m8FRsa
 vNWrTrHbxnFEvNQ6vquPxk/izlm/cvaHhMRoV68FvvCJ7ODkSwugyPi6CST4ax4M9EV8
 cqrA==
X-Gm-Message-State: AOJu0YyPQnR67BHyPxVZWIP67o3VxHD0JODjGvdSceMs1XbPGSTUB2ae
 CpU1RjJD82DTRVWIRC6TYv9czbfyp4dnLcCuF4244x+fFezBOWURyT11Za3xzMNVN0cVkhYNj0x
 uCLIj6mc=
X-Gm-Gg: AZuq6aIbgfPuPThRUdLaJRolM5RlNXxuF1CLVe4tuUsaY3vRO/WSQmMT6qtQ8YiOuLa
 KlcN+R7sf2WKCA26pA4DQ/nn5IgUEXnPzWOTvv62fKhwQjyn7Ar4BZKbTb2Kxycz9LRpkdsA3Ov
 5lXgMsq98o+vta83dVEiOCtinw+J05+F4l7RsC1QwGrsENSrmEDJxDQYo2qtPzKu66wRGMMrMIX
 L1yxUVv4xKb+3ifUN4sYcuyJ6ifaUQEvJe8e808oaE7b+Sx+k1eJx0m/q6SVNGBEAMgr1l4S9Kd
 GW2J3d/nMOU2vTzAdJfQqszjGq9JKwJ8wh554731JtLXpEQwnCVzVIXMZ7ADQ93ANhGvQm/KM83
 Nuz2eh5ORg3LdABe0hKsBTZO48yUUMDJow7ZATZV1rfqHyFyLAoZA5tNvovD8ImWRsR4+djGLgx
 xTcZAmnVo9uiZlnoNUiZ7H5pERuF/Lg+3Rrmg8blpSTX3k14hbxR/pIDNCY6GaH71wQ11TWRA=
X-Received: by 2002:a05:600c:3b14:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-4830e934671mr61880595e9.7.1770237693097; 
 Wed, 04 Feb 2026 12:41:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d299bfsm7806425e9.2.2026.02.04.12.41.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 12:41:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] configs/targets: Restrict the legacy ldst_phys() API on
 x86 targets
Date: Wed,  4 Feb 2026 21:41:03 +0100
Message-ID: <20260204204103.46343-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204204103.46343-1-philmd@linaro.org>
References: <20260204204103.46343-1-philmd@linaro.org>
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

The x86 targets don't use the legacy ldst_phys() API anymore.
Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to hide
the legacy API to the x86 binaries, avoiding further API uses
to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/i386-softmmu.mak   | 1 +
 configs/targets/x86_64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index e9d89e8ab41..19ef4a6690d 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 5180560d4d6..151862158c7 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-apx.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.52.0


