Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287CBCD0438
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd04O-0003fI-OP; Tue, 06 Jan 2026 00:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04M-0003bz-8Z
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:26 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04K-0001lM-HN
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:25 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34c868b197eso820129a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679043; x=1768283843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+s2rn0WQ4NPkwRWrpQAsXchCwBIIESyEi2waaHVW+aM=;
 b=g65rnY+G0PuXA52TzXy3Ap8iawCPNAl6hWfxxk1HtvP1RBVtcmnYMuEGs/LeudIlum
 QW6AdzLM5/P3i5Es0CjHuH6RyGPj6tSDMJKG0ENH19T1pSzXG1/1N7UTAj0t/II2ulSO
 C/aOrwOz8gyGIn90RgrtskA3gYRENkJ74ANXS92G/3f/RE6D4ff17vf5lnjN/pjgGXH4
 rwxWhMtzU3gR0gnGsj4Rl0xNZdJBfXbYzyvBCg//WRgxn2fnkMHhVXonyKJtsQW2Xnxq
 NdkL0bGoR9inX+pe9yXsXlhGmjZVYt3uBPZwLoObK0Wq4YyoeK5m5kIPssrvtuNcVJo7
 qMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679043; x=1768283843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+s2rn0WQ4NPkwRWrpQAsXchCwBIIESyEi2waaHVW+aM=;
 b=mPo4exaYu2H7THEa0rnYoyM8b5NnOEZVUPwakfynfRxbRgUXdEFRo82h/Zc7SZcwmC
 j0hK9/t62pKbE+55qy8JBO52BilwmnDtlSbTx59+ovkP135JmoBaT/IrCJpz0QKBeYAz
 FJANZDuGgDD46sJy/+8FpUzv6ErTKvJik2JHSqPUS9diP3R4mKnMRz65Za11I+fTYcRl
 VfQqhxh0V5Wz+vjGK71GsbQ8kNU8DyuI9gmTf+6ZYHxV4h9O7s67k8e9LuyZ4FE1xcJY
 hqzG6GqxlFnAAhoQpECZzXfaAD7eYCE1imFUyOjmriUSfQd/Q445Eos6K0JprJO194H1
 ev5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq/JvbKbin0mD/dCXkTrWZTVkrHqQqHaPvV1V/Inju3F9KGhIFSo4QVCWtf9/Y92zfeVXbV/D3sNmn@nongnu.org
X-Gm-Message-State: AOJu0YxkcDen4y8C26UAces8Jd6sy9nPq2GjWrrkk2MsvU05BJApuSHC
 RGn35QSC9IyKSRAfeKVOZn0VWf17OCQ7dnADUjoWYs+uPh+arbhwDnT5
X-Gm-Gg: AY/fxX7GQ1iu6eg0+Z30JOuOg/w4kWTQ6ya8daJxXpj8NEQHIHmQtsTAr13OX6JlQJC
 pQGBl6KBvNx6fHz/2ZpkRXwdI92F3yp0Ow98x7KFQ5EuWCAwQFQsaDg/lfI/Z+eNCG9YDOjoeAv
 lt30jfPijNgDdwI3T2N/A0uSbyRtv88e+v6XE/SDxz1Loa4btUlKbDn9Wi+uTJAat0Qr5i++rHO
 iphhDV8uiCmgDDfuUmaDMhRKtONkRVz7UeAb5dlJIfy8gfqb625yT0/0m4aRFosH5ilXvq8PBRD
 ZKIchQaI1q/i8aZWk3j91zaVJ6d+ltOoI900iX2aNHjHwTee9av3M1o6BVkgFQJlwyPb7emgROe
 qMgbKmJqK+C0JyGJ8OhUct41Eml1xoR4eCPOy899yGA7/nXB3TsuEnZRMcmGxsccf5vLXsxrH7b
 Debf0cEx/jxP8CD8FoliyU
X-Google-Smtp-Source: AGHT+IFjrLyXOkWvpZQHXNFv4l5DYq267fJ3uFaI+MVfkvLh3dub8xSlR2xLfRxJiikdIECLkfvgfQ==
X-Received: by 2002:a17:90b:53d0:b0:34c:2db6:57d6 with SMTP id
 98e67ed59e1d1-34f5f2f8c60mr1445446a91.19.1767679043058; 
 Mon, 05 Jan 2026 21:57:23 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:57:22 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 02/16] target/riscv: tt-ascalon: Add Svadu extension
Date: Tue,  6 Jan 2026 16:26:42 +1030
Message-ID: <20260106055658.209029-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Svadu (hardware A/D bit updates).

QEMU makes Svadu and Svade mutually exclusive, remove Svadu so
Ascalon comes up with Svadu working.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2f31e79ae6cb..01bd522f9189 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3183,7 +3183,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_ssaia = true,
         .cfg.ext_sscofpmf = true,
         .cfg.ext_sstc = true,
-        .cfg.ext_svade = true,
         .cfg.ext_svinval = true,
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
-- 
2.47.3


