Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22829C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbja5-00028W-Ja; Sat, 25 Jan 2025 12:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYi-0000fg-Ci
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:12 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYg-0000aI-Ni
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so33565665e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824576; x=1738429376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDsGnhplkgqT/f4agy456szrFVjRVVohKrpBFsRKCFM=;
 b=lRwvMzNAa1yYJeVXu7dU3OYi4z2SSUAiWQG4n89ZlywwfGiLYb6XdG1HdC+ZG9Gg+b
 xp49JrCw86Qb6BlCRa6CzGTQA5NoaybM9nEDKYOJsughNX9FbBwjcB3yT10lMbf7eIIv
 yOqdUTyVkaLdSl+KORqxHPmJnLm7M6W8s4Mh6spJ1Aqz6F5kqVywm1OMrE+60UO1m9LS
 QFo9/uyWwbkNMXIv8XUBSORLjtSKgw8lgs5uywUpNr0kPxOdLVJaOgy5tXlqVQ6gFkAQ
 f3WBCJnJywUpyOkGIrP58HNr1qDYTYTn3xJ6MLs7+H6KqMFAbnZ5DtJsi0kw0eMTX17v
 nl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824576; x=1738429376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDsGnhplkgqT/f4agy456szrFVjRVVohKrpBFsRKCFM=;
 b=o00eEQGHCqYj40QIWbNaopANeqGFPotxKOI+Wvd6/hxM1n6gUQ6SEL18qSSpTKuwh5
 lj02JefS7GqKsQadShBjc4p5u9Cq3MzrG8w3T97mGa0VPrvhXyqmga1pEuUU5mVuSmKt
 Ul8a9r3DsG7uvoDNkV7bTuZ6TVXpp5tN4JuHTkZKkhG809tFTvPKCjJE69wWifikk6Ww
 b9n8tEZvic6SVVuiGwww3xxoA4aPV+QSNVkUEEJ3gFqx/mvA5ACh5x7kuwILtn08H5Ls
 4n4cRIcgOW7xmWRKs7wfmHhtGGjjbVl+LdIzGVS3Rj/7//uN4HjRw5C/ECNGMQU68j2l
 QXjw==
X-Gm-Message-State: AOJu0Yw72GSaZAWj/LgXpzRQIO7cBUIFQjO/bKwmtYCzlifm3KlPmFcS
 hOPf5oqf3dkVY0fcryGT3I8zAH5OTpH9Q9tbXpRjBRlOGDvBCrJawvgRWjFaQXRAnN6kYyGLIOc
 /mus=
X-Gm-Gg: ASbGnct06rVgVsqOVUUO8pDalcBs6VPqyQ4YyLQIwegVNNhmIJK0q80jQ7dAVOny/PC
 DO0HzDy9+/21zp4f6c/dotU0epmIiKyhdB2EuVhR623xe7JVlFJzyplV8Lb4J53u1BvMXuAo6F0
 n0kmOyNJqGzuiw5MkvpsyM8b/r52UNCcq+f+q23JCHFmb80OtQccb3eCeit7WxkRT4E0d11sPeu
 ssCWL8OlvyaPh/CcNiS5kVGdDrB8hKKBiGwFF1PSl+0fj+/9eeOcU2CGrYIRN9yJc9oxnympeEt
 ulhLDEZxpytrRPdEbjkpcf8/32YUAZY53hsi/jCpfVv5Oya1u/9w670=
X-Google-Smtp-Source: AGHT+IHoqC6w0VYGsRgbrHQNSwaFRUCZRo78cWxL/EqZYxSxHuedeANvp5/IkPSOfrlPwIQYVZW7mQ==
X-Received: by 2002:a05:600c:1d20:b0:434:a781:f5d9 with SMTP id
 5b1f17b1804b1-438913e1b1fmr389270175e9.11.1737824576219; 
 Sat, 25 Jan 2025 09:02:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4a283csm67871755e9.0.2025.01.25.09.02.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 18/24] target/s390x: Restrict I/O handler installers to
 system emulation
Date: Sat, 25 Jan 2025 18:01:19 +0100
Message-ID: <20250125170125.32855-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/s390x-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a750e7a343a..6e2c98de97a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -356,6 +356,7 @@ void cpu_inject_stop(S390CPU *cpu);
 
 
 /* ioinst.c */
+#ifndef CONFIG_USER_ONLY
 void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
@@ -373,6 +374,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
 void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* mem_helper.c */
-- 
2.47.1


