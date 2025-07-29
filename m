Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC8AC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguaC-0001Yh-QF; Tue, 29 Jul 2025 20:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJU-00053e-IS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJS-0004im-Tq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so435379b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833893; x=1754438693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uwpHuSE/h5PFhnCkORbwzYhE3VlT2Ub2wvIj4OwEWco=;
 b=a7TVC4HcyJ2eOvSxva2pna0N2v9JZfwC1Gchuf6dTxmDFO+Z4HcylHMnsZiAu61HJq
 Jwn1x5UUCSqGTg9cSZSsx8gZtUToRnCYM4IYcjenlN8oz5eayonzmcO/D+p6r6dohQ4n
 MlycZNmBe0IkRydq+ZPiH2DnVtypp1ZDiR4YgR45C4TqTdTVQxoYlEwjQNqzha0icv0/
 ixRW67TPuJb81XXLFcXs/51wCX2HRFqBSLD52XOHgpey/qX3yIHKTtQsrt+XdeMmPOpH
 XgODM03I+9u5usOR8gCpjiVWoAW9F9lMNeREvsP26cpa90zp42oRbKx6i0a4PLxpQOVZ
 roxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833893; x=1754438693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwpHuSE/h5PFhnCkORbwzYhE3VlT2Ub2wvIj4OwEWco=;
 b=lSA8HoPjvi0YwGt897E5/YEf8UUGTeTwUO9GPY59uzGd+1SrY//t4uK8L01CqmUu0V
 0wNrEbaLgRyCZAgEQXavOeHhghKAGm/riktZRGJ9Lu5zvRknoXpU/p640AdHlRg0/s4a
 G8TYn4MWWJ0vp3uJ7EXZfQcLzHJo1oOgHxqriIRcCH0NCLMWkarY6a+2Jb0LyrLe0mm+
 fC4+jbGQv2LiCjTui99vWpzHWUB6S36GKZbRyrmfaifmjQriQLYv9RIoyEQDkquwU/Yl
 61UmapPvL6digQEDYxBb05NiftK8uwURrYOGHsL5yQCOaY9Kq6DOVoqWeCXaRZ3n5oF4
 Tw8g==
X-Gm-Message-State: AOJu0YxRWheVg/4SuDSgL0t1Wpz93QHZ5uRA6DjqbLqGdv9AxccpCU23
 MT2ydNd3iSiF3dJ6V1hXZAsgvoyW3+bQwDWwI8Fs6oK6hNIO/lumtkgNUdnQT+r7D/F7a3xYjv6
 abZJK
X-Gm-Gg: ASbGncs3kOTYvaojALvYZjjTrS1XuU5wnoeCRBLlW7H3s0DZ8xy5k332FCsAHVIyOAY
 wzcBL+IlVN0LcTh9hciYg555YBemOybqsQ1fmrgpuXn4HnnJXSMtL3OCUg49qTBFL1BNsgucb4T
 y6ovvirgTMSMjbQdCMjBUhDt5uqaOJkhv4TnxrvXk66n1/VBJGUciXsuWbg4whZaFUBYMTfu8VD
 x9tniAddchnMqY3iJY8DsWEfiLk7LKVWYnA9JEVYNWsDS/FbMgwpoXP9ElW68NjRx49KZEIDGHB
 hg4+TzP/lFj94E5Hc8b0EoYgzx8+H21kR3Co5OFbEZNnVchhF5t5pJifSPWdNEkilO4n9laHc91
 OvFascyX+VMKczzcb9SK6ATkqO26jbQga9i+BEfIThYMunNF3LUQZj8iXTTaTBAF6znRmS3Vt95
 d7eb+8NGXqPpq3NRjOjO2i
X-Google-Smtp-Source: AGHT+IFKFHn8HfPvMTMrh/LcSpB2BWKTXuG4+N6SmwsL0nbh+Q2wWYWjCmzylxl0NFL2uUo35N3qJw==
X-Received: by 2002:a05:6a20:3d20:b0:23d:45b2:8e3c with SMTP id
 adf61e73a8af0-23dc0522316mr1972173637.6.1753833893234; 
 Tue, 29 Jul 2025 17:04:53 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/89] linux-user: Move elf parameters to hppa/target_elf.h
Date: Tue, 29 Jul 2025 13:59:49 -1000
Message-ID: <20250730000003.599084-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_elf.h |  6 ++++++
 linux-user/elfload.c         | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index a736bb9bb3..ed2ce895f5 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -8,6 +8,12 @@
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_PARISC
+#define STACK_GROWS_DOWN        0
+#define STACK_ALIGNMENT         64
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define LO_COMMPAGE  0
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5b3bdf58cb..e6d49d982f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,17 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HPPA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_PARISC
-#define STACK_GROWS_DOWN 0
-#define STACK_ALIGNMENT  64
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_HPPA */
-
 #ifdef TARGET_XTENSA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


