Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887EDC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLT4-00040K-Cc; Sat, 02 Aug 2025 19:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSh-0003gp-Rl
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:23 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSd-0002YJ-FZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:20 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so2555480fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176578; x=1754781378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRrzSNh7EH0UuJpL/aMxYHKRNncazgZh4BhqUvU7DkQ=;
 b=La7c4nSp8XD7Brh0Z7H+vtEhKv4v6E9m0mGLFdqlj5B7x4d+aDHssEG63LOEpt3lru
 mcBvCqMO14lw2N9UImtLVxquMZEIpeZbMly0iY3e2o+gAm8QD+yuo4zOzEHHHkzg0t1W
 rXqdlXpgtsJ8pOzOCh+WWwnFR5cYsfpkrU4cQvkVg2RsN1tnZYT+DKjfEVPpNvA4fv+6
 wY045xn7TBmo0Vrcq0uLDj8HIBVQboHAv3ZoYKqOvNt0GUpEKyNCQn6m9UNAwgT9QsI+
 IO+A8iYXairuYgmADb3cEXZC7U+sOq+SCv+9lSvBv3XC9iGfOJk2T89Kr7PfpWLcIZWf
 qXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176578; x=1754781378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRrzSNh7EH0UuJpL/aMxYHKRNncazgZh4BhqUvU7DkQ=;
 b=U6pZ6acVDRNkqHgvMTelu/WPxpY9nxJJzv4yhHwKSYAvjU7Yi7jWu1zXZdUhSyeiQl
 fR0GSG3oQR8lOQxg3YBzL5VulbqKmQqXecFo2ug5i8oZZQ8BsJbOEaqWTsk6VNNpfbev
 B+izvN0StmVfV1e2PcViXDZwYrhJLbhxN8PekuAtCCXW8Mp1EQaYoxBa5pWqp1FCjCRf
 nbihao+s7Tcmf65cNOSUOo77M07VsiqYsET2wrNr7lng7CedsIvLipca1ZIttkKYAmGo
 My54bx7FNHbfkNaa2n6WZzKt7bII5GI7/+0fSNHAq2VBU69tGsocHJNLatcOGlvycF8A
 b3Ng==
X-Gm-Message-State: AOJu0Yx0+jZGDboIFLBOynLEUgcY7h5zukZcAlgm5ICX7Hx1J1AJWp/r
 Wshbmak5NZAqKZFeKOZjSZTTPnchu0R58Y5ABHSjWqtGHWiktHEk0VGm0f9VdPcuw4dMiPx8DcC
 VHF/qHb8=
X-Gm-Gg: ASbGncu81trO2+QnZa8lCP6PYhTstdDkHCcOw0ZJkpOx468klzOTwjWw0buHwzlPrgW
 VcUCe/vc9OC50prpMe84jGyXS/DEIMOJW1phf7cHg//oK/rF9ASvvQC6XdH8yE1ANUPcsY5BIJ/
 fUtbGJGuLyzTaL74wpCZws2drSxJbsJr7hElxuwg8sC7hJ3RjkyM+XwMaTJJx3wkkArKBqLJdFt
 2K0ZPbREcxilgEZ551ZHwh4evSS2SRFbOlZZemLsClcy48bpLrkZrcTEagIXB+IA0TRyDX5qAL/
 h0H1FACWe6mzFtMks9l9apqPS8CXVM/TaNei+G0+moOvfa3CS4nb/cUA0beQ6cujWcosohLPHTi
 fJdxu47eMDDMw/745DOXxHWV2gSdV5y4XNrLo7jBQw5E86UM2zMRM
X-Google-Smtp-Source: AGHT+IG+XZbg+/Y2aijfsPbeU6QkYML7MjGX01UCCmF9bnZDyakrvROQ/ccRt3dM+pwTJiKLPGWMhw==
X-Received: by 2002:a05:6871:6210:b0:2e4:68ee:4f21 with SMTP id
 586e51a60fabf-30b6796e652mr2512111fac.20.1754176578157; 
 Sat, 02 Aug 2025 16:16:18 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 84/95] linux-user: Move elf parameters to
 hexagon/target_elf.h
Date: Sun,  3 Aug 2025 09:04:48 +1000
Message-ID: <20250802230459.412251-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hexagon/target_elf.h | 3 +++
 linux-user/elfload.c            | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index eccf207f6b..a9f6d77fc6 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -18,4 +18,7 @@
 #ifndef HEXAGON_TARGET_ELF_H
 #define HEXAGON_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_HEXAGON
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6fb9926a7..fdbc55ebc2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HEXAGON
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_HEXAGON
-
-#endif /* TARGET_HEXAGON */
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
-- 
2.43.0


