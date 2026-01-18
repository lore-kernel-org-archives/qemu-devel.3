Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0232C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat7-0001IM-4K; Sun, 18 Jan 2026 17:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasy-0000go-PC
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:41 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasw-0000UF-46
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:40 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso28192485ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773877; x=1769378677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x6/nMlfDysnN6nEcooEPelvvHCju41IIbLE1D7/Ks4=;
 b=mSyGMmT/rGpvWBvQXBm5tpQA8mj9DLvZPLISNuGS7YF96fWQigY21zrssfKdFRIx5Z
 1/F3Vw8Y21VdT0scPo+eoRO4LqDT9dpNXgOWlog6kNcAGXJfriZ3khUwU6Wn560wjcZJ
 QdWUwxclrwtZv9RVNcA39nu4eNB3aq5W45Vp4L/H3EuC/osSun6dns+5if24xJPGyboI
 YFLteYxsq7SPnCwlB8irVOROekGyW9rkoA43JK028TxXIN2L+bRIaXJKY8WDLVyIWjKh
 jwYMeFGUQUSnqqL+irCmS/12tb/ZpBAdmEEDHpsaD2Gbci019kuWFKaOYKs/1LsuINJR
 W/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773877; x=1769378677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/x6/nMlfDysnN6nEcooEPelvvHCju41IIbLE1D7/Ks4=;
 b=buE/ONxnHUzysexenXuKsmWmLOnKzIgyVp77ZZ/P6KMnPxrkzQ2xhJJSazZDyBs8Zo
 WXIIt8caO7cZPGmeIgX4a2CnY3pNOgiiPHKJkKkjf5iuqpNaXJw51EE9oqrF0cHvkdtf
 32jvve4AJxgq0tU/fMrKEi7BrO1UTrrUdUFFpVGBL/RXKeSMW/2kg39LF3HWy3Z1d2Sb
 VUD5zK5BBS5j5bB/UIH31YE8tTwzBH+ai+c+LCV1OnXqtdbJY9EpvDUR4FrSTTpZqQKj
 qklrb0YVGADd+p3UcZaZJkPJpU7tLdzRihKWWEGRwX6/A1JJOMTXXwP9lOvzWc6NRWdJ
 JIHw==
X-Gm-Message-State: AOJu0Yzt2rAJnE6rRRtzyG6mDftoD+2sf6U38hpNQTPyyUK06Ftm/PAG
 lojH17niGiNZbr82LfWJuECZ1TCLwG73VhnjmrPKDfyCLqYSbqOn2l1MwdbrRwtja3iz5jQiyfH
 nQJxH9EnSwsRV
X-Gm-Gg: AY/fxX6PzH3T8a/agstHJ70W7uY6iQTknrPLznjJDdk4QvZ1BnCF6Zsm0a33M0wOWcc
 xA23XqHzKMgUsCnOg1tODYvSI0xdzz8K2ZGHtPVJGwjhsmLQSnnFKODMCDD1lcmKDsZhW3sTKoS
 viD8vB2IIBkZvVQsl0ykUgruGzQCIDobsWcXzQ228FbbxaLPiWNNQSIh17KiA+Il0jGKNX2cq8N
 gpuXugA5V10r/l+yuKsyicIBStDYeU+4YbBTDzs/29p56uqxwfqDgFg0JgANQvII4bye5oGwl3p
 yGADNMSpZlTCUPX5jzPgZn64suWbKv5A+WZBXSaNTnKKtpt0Iq8VjnzzyaT3+aUyQ1eD7kx0WBn
 JAtIQ96XvC3o8ESHo14tSxMdUpvrViGqBxOcoKC9BtYUYMIj88DUUE+yFErVfsxxnmMZ5dAWGpw
 LGoe4yY6fp2j3yt4kn5owWR9gfveI0
X-Received: by 2002:a17:903:2f48:b0:2a5:99ec:16d7 with SMTP id
 d9443c01a7336-2a71888b5c5mr93271835ad.7.1768773876641; 
 Sun, 18 Jan 2026 14:04:36 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/54] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
Date: Mon, 19 Jan 2026 09:03:27 +1100
Message-ID: <20260118220414.8177-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The target test is TARGET_I386, not __i386__.

Cc: Kyle Evans <kevans@freebsd.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 52f84d5dd1..c49be32bdc 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -247,7 +247,7 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
-#if defined(__i386__)
+#if defined(TARGET_I386)
 #define TARGET_HAS_STAT_TIME_T_EXT       1
 #endif
 
-- 
2.43.0


