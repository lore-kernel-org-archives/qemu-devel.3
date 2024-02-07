Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91BBC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwG-0002p2-2y; Wed, 07 Feb 2024 11:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwE-0002oO-Eo
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:18 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwC-00066r-Pq
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so629375f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323895; x=1707928695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXky2CMDdzuIC8PBdEAHx/6nddz6mi+8QtS2LPbBGiM=;
 b=NAQQcfYHLL2BKX1Gdad3Jl6EucdWuXbq/UfjbsidFzBrd1PKuGRMfjnysWETedfrUg
 3Oc4fNpGRe/pMo8itUwclDP80nX8gXUg5gem3m6oJ2rE3+zwUhSOFpgZ2sGPcXaWGZol
 NdM0OsJLi5ekbqetvtjzZbFU0gfEVMGbihbhamKOiPdSkKrE8i0Wix3doJu4jjkgB8bS
 6yqJEkWguOfuAe0KBB+BPbG5Anxseje8hEAdOWHQCc7l7f8KCQ4TRGDYhJ8wfPS1E0XO
 z6JA05PDz2Guw4Q6AfNQ+K6BCEsIyZBWKZzgy4ycS3xkFFA8jEx3szwy2+rCJCmckjW8
 UUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323895; x=1707928695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXky2CMDdzuIC8PBdEAHx/6nddz6mi+8QtS2LPbBGiM=;
 b=cyVXrI9+lZJFmcDJhGPXKiRJlSBti++p2nT2bAvfBh/SFCf5b/jI1Rg+nSLeVJLwzf
 UOo9t4kloXV/NIQyeeyxYrloCDdfn25Zg8U8bnJiMpeBHpBlbhGZkAMw5N4N8xEZPCtv
 iV6tX2IAwhj9JIzSbLpgR3y93f+rmtl/Fq9ojglfvaGYcDuAr+Rnc43eAzuSRNZGMAmd
 HgqfHg8TIflBUikAI6+9LZ4VUprJcnmcAceRudpiIRpmfPpqdyN5gTo05XXEAMqltrey
 8RfuaXaJzyoDvHob6uwgc2UaTgUNkAJVAyCTSt6QA2EYLZk72XMQAfCqnjcj4ymt/rJ5
 /rOA==
X-Gm-Message-State: AOJu0YxC935s2x0GoGQ2zzFZFK7Xe7dYiQmYpwssTDI2QxBneVJI8AuN
 D/miF4eYCFkaY2QXhSX7RWj/5q9IVI0IUqn+krByrKDoFT3PDMACuvUl4P8Re3M=
X-Google-Smtp-Source: AGHT+IHGEvKiiXfJtsUpanJg17mF2fKs5Eih1K368Ch8Oz/fe7APF/YeZkinCz0RuMWhMjnGU/oXyQ==
X-Received: by 2002:adf:cf10:0:b0:33b:10ca:d190 with SMTP id
 o16-20020adfcf10000000b0033b10cad190mr4595531wrj.24.1707323895429; 
 Wed, 07 Feb 2024 08:38:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCURBABIzhGa29GJYD85vS1JlzBfwWWDBHDHNWOOt+PDigk4w90BZ3LBumxAS0OFVAuoaDI4+lsk7CucyNvPbqBGgPHFsYFinOKkl294O8mFv60MgGCuy4cfDNpwcESvls/IDaLuI0xLuZGQBlceyDOcm1BtQsPS3DwPIKG1pJsY0CKXE85vkiCOC5bpv4NqsMvXlrNiH+66D4FXPhJwcAaludYFlGuXZOBw8TS5+hXHog7Y9RvVH9w+9ELXoC1WmIsTIIes1CL2f2PVsHhPrehOAtvLgyFiLJ2TY2Au27b6J3g+JqvLZ29ub+POWomgB+PZvRRHUiSMWJiyV79xsffnIeTMqpLKA7cpDE5F4FwGPreWAvQbOuURwQGIJJt1Szu/NdSEP+c66Esr/qN5KpgFBPNDAtz2lT/9snhtUuKUZGBDouVjzKZ3L24RVJMjGPfAGsbUJIBnLdIz8UTJBulXVxcHdpkKhoCz/wU0/v8QURznRA80nUFgw+iTHn8HJXQ+GALLM6tJtV6J3Eq1FOR6CBYU8TDS5Ice2wJYpkCDnciaCM8auI6l87jUoAKQ9ijqTHUjyOIuJb/fnbF5oHr/NTGKJENwmXEqPi2JCDMfzZHw7tC3nAxnjspSOP4VmYMenExo7E9CqLgFJ6OfWMMXy+uUSZIoeiPjYfH9aXhr0iVCaPTp6xPhD0ekVcwPDdT4Ju7JZ2HrqpS+p0WCKKGRKcWIioHe+C+jF7GnI/U7wwvYe604yr8Fu/G6KWhADhDIp7olwjkaVRbtCIMzmVry3dZKHrQcfb01tIExhqMdxWWhgKVOoteIuxjpO6C3GNgjB/GfazFo1yAIcZE4dgqfXCDvW2sOAczAePfKxKSSoNi6AC6DpL6QxjaITmtrmNZYo2pC
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d11-20020adff2cb000000b0033b278cf5fesm1852878wrp.102.2024.02.07.08.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 510C05F88E;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Rabin Vincent <rabinv@axis.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 02/14] docs: mark CRIS support as deprecated
Date: Wed,  7 Feb 2024 16:38:00 +0000
Message-Id: <20240207163812.3231697-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

This might be premature but while streamlining the avocado tests I
realised the only tests we have are "check-tcg" ones. The ageing
fedora-cris-cross image works well enough for developers but can't be
used in CI as we need supported build platforms to build QEMU.

Does this mean the writing is on the wall for this architecture?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Rabin Vincent <rabinv@axis.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230925144854.1872513-5-alex.bennee@linaro.org>
---
 docs/about/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d4492b94604..82922476d72 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -183,6 +183,14 @@ Nios II CPU (since 8.2)
 The Nios II architecture is orphan. The ``nios2`` guest CPU support is
 deprecated and will be removed in a future version of QEMU.
 
+CRIS CPU architecture (since 9.0)
+'''''''''''''''''''''''''''''''''
+
+The CRIS architecture was pulled from Linux in 4.17 and the compiler
+is no longer packaged in any distro making it harder to run the
+``check-tcg`` tests. Unless we can improve the testing situation there
+is a chance the code will bitrot without anyone noticing.
+
 
 System emulator machines
 ------------------------
-- 
2.39.2


