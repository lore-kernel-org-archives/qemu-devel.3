Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09B0D34092
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklJ3-0006az-9I; Tue, 27 Jan 2026 10:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vklIg-0006Uj-Aj
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:48:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vklIe-0004DM-R1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:48:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so46101405e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 07:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769528895; x=1770133695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=amu2OeWvWLK1+yVy9GMmApWIyrEuwEAakiPtO/3dWsk=;
 b=a15VZI6zS74jbEzTJIU23/MaT3d8tY6LNllUIv6U8qCMyeOv6skc9eyXg742KiMbjs
 h4s1pI1ija17xSolDq/5wihJ+3i4lX6iMRMm1eg5vFqh8VQ4BVMzAk3txz7mbf+BMtoL
 VvNDdU/d/jXxtOSbxXPXCRLjc9F7/e+E14tuw/KiQ71dzmtNrRvMXdQgBliR9rx5CcrE
 swznP8UUlR1Cbdk5BoCwEAxq7Zer+v4CBBPFSnffde/1b6xIzAtXqXdw1RujrwK15YMZ
 BROkzjTGaPp0QH9TnvAxegxIanNNnR3FdhmEDzl+VqJSq58VQPdoRqZv/gKqEsKp85EJ
 zVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769528895; x=1770133695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amu2OeWvWLK1+yVy9GMmApWIyrEuwEAakiPtO/3dWsk=;
 b=FqiC0LlbjWaknUop1aihq9yO3B+Or7lxoeKZbUW9OrfKKR5n5mzNlc+Hnml0wLu+YD
 F/7cWSE8i1Tq5a0S7vAAB4ZzSLMXjc55hMjCIbVLrJDi88R/mcMRPmcOwPJtreFLCMa6
 DLHszW3ZoHXbmXyf2JQeDk9QHPYsmhr2fUC2PRhcBuKxzQjKjmZO9XvxpNp3fWQ5A9PS
 jhmW9Edt4VTOeCqHay1Q8PfoV61rD/RPJ1C63ryx/vjFSXiWTrAqofhraOCpnZHr5s+L
 06qjr+KRYKa0rzpRa9/J90axiq+EkEGSPuUF5ufFw1+WoglvAQlwqAQGPhCFOCnvJkyV
 CLMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrTxgdOA8c1Okq2BxOwtNP22/RgP3/9JDI8I21s2AsLDchlN8XMtT6IOa5NojC/EU2c1rj/OnipjFL@nongnu.org
X-Gm-Message-State: AOJu0Ywu4MmgFobDvMthyGEfHA7leGhVQvRIodFlPJejt6pkojMyuc8/
 xIWPXS55g8UKvvNvjqO8/TweI66pn3ARr+HxN2RVav8pQss5ns8u74UmphpmIJlhsGg=
X-Gm-Gg: AZuq6aLNYsS1rSYlAqKNvUWyzNwizqdDxPKQ+npc71h30HC2acbvnKblghLOfehgqMM
 aRlTPK/To2WpX2AzE/RGJKZJd34j7XIbQSIIeeyF2jYM+9OloGBLNN4A8FGAGDxcUuiNgJ8c8t5
 hijrue5ZhA1JcnvxW99APo9SpbehcLzguupvRFHW2SCcBrNNE2ywyS2+lUTsEsvu7ZR3qhS5JDw
 v7OUtmC5ByVLCeg1phnxr5p7h46c7qV+Z+LIyYD52S6wofytziMRyl8sZ8vAtbBfrXoVBQ1V7lW
 2VcxYIe/YhyHDcd8FFAwjt4/PeRwwGJg4O2qc6GIwAaOkGdLQ1AQqHFNfmK/hmr5kyC8+IuFqgD
 kT39HCWwFG9RhCnCQIJUwMkqNx8vVzK1C27cmzg4r5op81B59c0iTKWvfXxC9OBABmytlb/JFW+
 gv4opkdOaKcyw/kiitIk8lkgbkmz22CA==
X-Received: by 2002:a05:600c:820c:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-48069c7de80mr27104765e9.29.1769528895079; 
 Tue, 27 Jan 2026 07:48:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm43080090f8f.25.2026.01.27.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 07:48:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 0/3] target/arm: Allow SME-only TCG CPUs
Date: Tue, 27 Jan 2026 15:48:10 +0000
Message-ID: <20260127154813.591744-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

These patches add support to TCG for a CPU with SME but not SVE.  We
originally prevented users from doing that in the run-up to a
release, in commit f7767ca30179 ("target/arm: Disable SME if SVE is
disabled") by forcing SME to off if SVE wasn't implemented.  This was
a simple way to avoid users hitting an assertion failure.

I tracked down exactly why we were getting that assertion failure,
and fixed another "assumes SME implies SME" issue I spotted in the
code while I was auditing the various callers of
sve_vqm1_sve_for_el().  This lets us remove the hack we originally
put in.

This is an RFC because:
 * I tested that we can boot a kernel and it detects SME, but
   don't have an SME guest workload to hand that does much
   with registers, vector length, etc.
 * having "-cpu max,sve=off" now give you this oddball
   "SME only" config is perhaps surprising to users. We could
   perhaps flag this up in cpu-features.rst somewhere.
 * as noted in the other thread that adds hvf support for
   SME-only CPUs, it turns out that gdb will crash if you
   connect it to our debug stub in this config.

But I think the first two patches are worth getting reviewed
and into the tree even if we haven't figured out yet if we
want to hold off until we have an idea what to do about gdb.

Peter Maydell (3):
  target/arm: Make smcr_write() handle SME-without-SVE
  target/arm: Handle SME-without-SVE on change of EL
  target/arm: Permit configurations with SME but not SVE

 target/arm/cpu.c    | 10 ----------
 target/arm/helper.c | 23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0


