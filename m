Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299C3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84x9-0004XR-KY; Thu, 24 Apr 2025 18:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84x7-0004XE-91
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84x5-0000yG-Gb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:53 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so1233339f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533309; x=1746138109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISCwHnamOi/ipI6KbYtyNzFTKPWQy4gkSjvWVBd5Fe0=;
 b=TrBi2cnhKgXhPhssPe8UcZQWCtgoRrQDz0iRLm55GEQ7Ift5SKqBguOfP6CKAMdl/C
 8qJd/CozUvebM/3OrXvtpHZmSQ5XesBZA5oghCxRins4VlARo3rjAD04joGjmrNf1X9v
 d+RJs8wyinEymn5QC/XGDx4ATUe/dVvFCy+utWUXp2/WyFCSw9qR7v88hKZB2jJext+h
 SaLf/2TWH2WJlo16tNApSXVg2lPRItdgO2nWeMtlWJelAdDR8t603FN5zVfa53YSyrE3
 0J1XNan2G9jpDuvD9SV/BqBPBS2DdpXds1dYJHaTh0LU/Dkk9fAKg8qA1MEsliCzoEAA
 emLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533309; x=1746138109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISCwHnamOi/ipI6KbYtyNzFTKPWQy4gkSjvWVBd5Fe0=;
 b=UOcp4CmQpjTjSyuxxSVMtGu1PN6iwF9o8BpGRX07IfN2mkdRCk3FrEJ1ruvX8oUfhS
 vJtvWXHul/FKFj5MbV5GuN2tiCIdgJPipfo+w/bQQvJrSxrX5xlYBMZqoEq2YmLayR4D
 zmn6f5U0ksLYWPRSVufDtlJ9jAlxpmyPgxI22qJnDcdihd+AEscbvkvYDU1wfED5rqtu
 Zk8UaomtGqDx49KVSJ0yx7rL5SUmVDM3puHjI3L27OnzgQwyGAYQ0QiKXsCHa1hDso+6
 m2dtlEtBNF3x9eUqzKAFvx5cyE8g1gueU772Dwa5UXP8CKDMcvlUkLQ+6zKKwjbKDq5H
 IMLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6cesW3cZGgcw466V9ZiAAdTiZCkN4SqTBNP0xCYU1VdZiJ8Zzr+mGiH/oyyS4DzmykHdi7ZtgSxZX@nongnu.org
X-Gm-Message-State: AOJu0YybdsQBfMsMH8s72SMsSWpy7Rj1lcTqEcESW/veDgVIbMIWD9iD
 kmLZ9Zozn1twke//5Wc3XLJOlSV/g50/1G5/swmPzC/Y67fwvGy7hCKoQd04J28=
X-Gm-Gg: ASbGncuuLYc6r/wQ1fOcSnX/I5J1uEJtocQ1GT3YQKwGOxXHD2tAY37661NzNv6mBiE
 Oe7keTyMkPMHUsrNBE6RENmJsdL7TUfmgYhgLdkVPcWJzclrE2n6agmjr1soOHUxs+GOC7MoHKD
 8IazA3CCTH3Lk966adEK3l2KTj0hT00WnrnIq67hyKgG+5vlfRTd0gUi+LNOmgZQVReC4VQK2a2
 m5wWv/rUMsHZYdLbSNsZ7Ql9xUkGQVCUrETqJaTLKof45LK2rH2CkQptG2O/n8p4dYnvMP/9BhM
 00ywYnJo/z++wRxjS8By/ps4TIaJMwWxFNCtr1YkLyX0/a2Z33oLLPA6bvYjJSWKCGLPxkfCJZj
 mmDkaMzBZtXgviqycbFDYU0r25w==
X-Google-Smtp-Source: AGHT+IFR0jyjcdiio3wg9YQAU0h/3Eyb0Bswd73Ngb5lSzGMs3e3uOoNpH/+InqSvEFBK/px1yfPOQ==
X-Received: by 2002:a05:6000:4022:b0:39c:30d8:ef9c with SMTP id
 ffacd0b85a97d-3a072abf5cemr713643f8f.24.1745533308856; 
 Thu, 24 Apr 2025 15:21:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e01bdsm36708995e9.38.2025.04.24.15.21.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 07/21] hw/boards: Introduce
 DEFINE_MACHINE_WITH_INTERFACES() macro
Date: Fri, 25 Apr 2025 00:20:58 +0200
Message-ID: <20250424222112.36194-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
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

DEFINE_MACHINE_WITH_INTERFACES() is similar to DEFINE_MACHINE()
but allows to pass a InterfaceInfo[] pointer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 765dc8dd35e..3573907d597 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -744,7 +744,7 @@ struct MachineState {
         } \
     } while (0)
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
+#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ifaces) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -754,6 +754,7 @@ struct MachineState {
         .name       = MACHINE_TYPE_NAME(namestr), \
         .parent     = TYPE_MACHINE, \
         .class_init = machine_initfn##_class_init, \
+        .interfaces = ifaces, \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -761,6 +762,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+#define DEFINE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, NULL)
+
 extern GlobalProperty hw_compat_10_0[];
 extern const size_t hw_compat_10_0_len;
 
-- 
2.47.1


