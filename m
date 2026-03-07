Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305E2FC9EFF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyt9W-0005Ro-FX; Sat, 07 Mar 2026 10:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9K-0005KK-4K
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9I-00054k-M2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48370174e18so62337775e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772895659; x=1773500459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwHYmSLMbr6lHxtZHMQFJ29WCkaScZo0cizYELOiaa4=;
 b=soZ+hS7uA6ak0fNRn8HPJh4BSYYY8zun28K2U86rbnwv9k7LLXv3ppJBnGj6Dx4Ii4
 rU1BZyQBxbdu/ZtsRvq8UVuver3QWVR7k8ToebtCbZqkwQexTGltHxk/TADij+rW2Swz
 uGw8z39KFoLE6GzoZWDmXyuXnEmPkxZ8/ymBQmF7Hf1jct9aSNf8QpkuaKfW0/fM8G9b
 Shzclz/Nc2CEFBlZypBV/CYVSGs4sfptiCO8AAlI/CLUHwBRBBLsPwW8N1S+Z2MvIWc9
 Aqp1f9LA863iAyRRvU6iJmH10rlVxIC+xeX5RJ2gV/TqocYNoWQnYjSFpR/JmhZlAqTz
 yOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772895659; x=1773500459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dwHYmSLMbr6lHxtZHMQFJ29WCkaScZo0cizYELOiaa4=;
 b=p/v58e4f21OLgM4FP6i2Ud+FNp8aSOwMIrR5y81Ir0u8phcXXTBErxRWhHcOZkdZf/
 MNKxr9BjxamqpGjV5tu9YUAu6UT9MKgF9BJgUvFJDuwK6EPBShXcQtHsi5T6qEbGdxyh
 jILNaTgkugI2Y/FuULIfyOr1TJtIqqDIhyIBjL3WIpINVOpqHywN9/Ue/OTsL9YtIUHO
 bif3ew+ePFLsdMMK8KDCwNpK7QCov20c5arpxGMQTvyDD9lHMGQ6OKZ2sVwy1ajdlp4l
 ZKKuZepoJOdQdOvADbdkFNV/XlquII7I6Cj6odEk1romRsTYrJf9yGb3ajb6hmkNJJnP
 Xf0Q==
X-Gm-Message-State: AOJu0YygbJule5eYqOXz+zoAOsr9ornQYUa8LxkA2woPsI63xscryoCv
 ILgbkcsHgzGGXk7hr6yaDQh6Y4AVcP21WC2irZrH0KdlVIQj5uYu7k68O4zhr7C0p1nRLJ4S4Iy
 xC7DvIWM=
X-Gm-Gg: ATEYQzxfKIxwAqkUOPhgw/lVXnG9QTA7dHAgLBydJOqU2BfAX1mXQukfWXcmEyoacuo
 PNRtwNAc2DrMKF0XiiA5B2I1PIOeNC5gPw8Z/LcW+l2b4e+6JgrL3fPZvreOhaT/MzIovAP11ld
 vt0gl4sM1zPdkWzBxAacgDpo2vkNbHenpoE7BQP12RW3mfQTrN6VH8K0lNsXzbPLSNvMD6vhnKj
 bGB6aBTer387ceG2RIyC9at5XbImI9s6GTgrtJ8k1/ZZaPaKTsgUK0kP+sbrYu3VRPlbblGSwV/
 KOdrT3a7U4h39aNfH0RDJQd0coHBT/7fFlyMSM1uAarPfWeYA+tC1vFFny+FrmAJgbKyu6ECv2/
 94ut51eW+eCbAwmnK5RUjGN3tFs1Jl5cK57GxJIOrz7jVZFDcZUxwkpUtZFdTH+i7rKTqEYleFZ
 2JSfrxJ7PUW+c55/n7SiZWvcJEGtEE9/iTKZ2hULDT2JHOgxVX1Jp0Ax5VjUJJ0Xsn9VGOMSmr
X-Received: by 2002:a05:600c:3b04:b0:483:71f7:2796 with SMTP id
 5b1f17b1804b1-48526923e1amr94406945e9.10.1772895658629; 
 Sat, 07 Mar 2026 07:00:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485307fcee8sm11052465e9.21.2026.03.07.07.00.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:00:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/4] hw/i386/pc: Remove pc_compat_3_0[] array
Date: Sat,  7 Mar 2026 16:00:40 +0100
Message-ID: <20260307150042.78030-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307150042.78030-1-philmd@linaro.org>
References: <20260307150042.78030-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The pc_compat_3_0[] array was only used by the pc-q35-3.0
and pc-i440fx-3.0 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 113813c07d7..5623660f5dd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -277,9 +277,6 @@ extern const size_t pc_compat_4_0_len;
 extern GlobalProperty pc_compat_3_1[];
 extern const size_t pc_compat_3_1_len;
 
-extern GlobalProperty pc_compat_3_0[];
-extern const size_t pc_compat_3_0_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 819e729a6e3..a38634e3577 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -214,13 +214,6 @@ GlobalProperty pc_compat_3_1[] = {
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
-GlobalProperty pc_compat_3_0[] = {
-    { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
-    { "Skylake-Server" "-" TYPE_X86_CPU, "pku", "off" },
-    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "pku", "off" },
-};
-const size_t pc_compat_3_0_len = G_N_ELEMENTS(pc_compat_3_0);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.52.0


