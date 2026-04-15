Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2519F428DA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6iz-0005ZN-RC; Wed, 15 Apr 2026 16:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6ix-0005W7-LW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:20:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6iu-0001NK-Qv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:20:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so77078205e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284430; x=1776889230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PTL+l/GwuosD3O/hbwf2MONUrJtnAid2gbNyzfmgsSw=;
 b=yyrg6D9RESZ1ckLBn4XNtEJBPsUK1ZqBs1U36P6XzTdRFsfhzgXKuuVJH4k0lHJLce
 5EfkhuMYV6UqVjqoqtgcVlisK+1uGSZ1omAqd5kshmsQBCDp9R1HP4Ozfqs92vxtqjdl
 /NNm2jGMiREgVh1lt67G6GnPcKJ8Y5N3gYGi5qYeIN78dhpcoWI/1BojlWd2s/ZAuybh
 d/Qm2fNZJGdR/z8pXHU8rYYAtmd5OSPg1AxdwgUr6i95H6kxlXWvG2Gg3F78OCWvOx3t
 T0zzXQw/6jgbgZlRVKHYs9UfFbJe7Ru7ioiLx+JfY1FbpgEk3qOoSXVtMCJHBSBFEG4L
 Dunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284430; x=1776889230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTL+l/GwuosD3O/hbwf2MONUrJtnAid2gbNyzfmgsSw=;
 b=P8ZU5jsf9GwBoTa1zByuqmzsWENKi0Ge2Clyr/KhHtC0LjKpHLyoz8+uO2jQypDwZ6
 mOLRAcWdjOdB93/CluwBeNCheWy5yJVeyML+1uqUMjXfqZAYpMUvxjM4Jc7uIAKrwEuN
 NpyHewo4/xCVgtUeqms/cM1mA8SIcvM3hfayCadLC74JKmXsJ7Q0/SGmHA1k4/JDwuIX
 MiMICbbSb9F4yfSpmtwoX7rCOFT6vF6tgSYaNnr7v+gFlJ0iwzxXaOGofgJ0dZVkV32O
 i9A52pmBN6pRHcGERrJmxXpQ3pr0hrkHoQCYDlBfa6Lu3REN9e8PCky/L+K82V2YRm+v
 6wiA==
X-Gm-Message-State: AOJu0YxQ549MueXmYrn6Iy0uXAKMt/7RfHIuNH4jxMqngDo3OHD8HPid
 JfpcogA9/b1AxPNV1kv4ydhTlxpssaL7uNNWlc+iWeBAtYFY2d67PfdFzypxvcEV3vTyFpYghBp
 fEXBF28g=
X-Gm-Gg: AeBDietgYlgclxLEySXDSy2YBpH3cHjoAfnlsvTKvU3JNM8TwJnfUEkONzEJO/WAJZ4
 4olpfM9/wxrFj0E8TnxmCXR8tmrUwTfug7skyZseWLBHu4nqBHGS4Fo+3ng2bDe2i49aIXpZrNq
 E8P3toDAwY7+8pU2/bcIAs8IXAL4i01aEI6g6jFl0b6anE7MEWuxczb7yJULRQpTdlM3cW2WNo6
 oxKSxtpNRlOty2tRyuIb/r+nbGpRmqS71Nd9I+NTURYtsna+3NXJuEjyYRvqKYz8kgsdMToAxz2
 EF5FrQ1sKNvDqCpSEWSA+AZphV+fHercEXjXWXpRnj16UGtqvxP1Lf+xPUUjhAmkK+2ApA0+kzL
 79sWUKXbAw2AY2QFfs/9U8fJkJ91mIrDqhkxMJKD17LEvUEzgJuaPnhJtyfIvyeK8xnJk2QjfQ5
 6DSEmYAq+N0xavr4D6ejVVxaUPZ7lXUr0EP/7DIxdUCAC85mwMonz5qOE1+G3YmnO3g6x8hhZ35
 6COS4fuFTY=
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-488d67fa48emr332984365e9.9.1776284430096; 
 Wed, 15 Apr 2026 13:20:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede24eb0sm173207295e9.8.2026.04.15.13.20.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:20:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 0/6] target/mips: Translate MSA vector load/store
 opcodes
Date: Wed, 15 Apr 2026 22:20:20 +0200
Message-ID: <20260415202027.83008-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since v4:
- No algorithm change
- Split to ease review

Hi Richard,

I tried to implement your suggestion from v3 [*]. Unfortunately
the box where I had the MSA test suite got erased, so it will
take me some time to restore the setup. I was surprised these
patches pass our CI tests so I added a pair of abort() which
didn't fire, so this code path isn't tested at all there.
Anyhow, do you mind having a quick look to see this is going
in the right direction?

Thanks!

Phil.

[*] https://lore.kernel.org/qemu-devel/2680c481-088b-4366-abc3-7d48d90db0b5@linaro.org/

Philippe Mathieu-Daudé (6):
  target/mips: Expand TRANS_DF_iv() macro for MSA Load/Store
  target/mips: Convert MSA LD/ST.B (Byte Vector)
  target/mips: Convert MSA LD/ST.H (Halfword Vector)
  target/mips: Convert MSA LD/ST.W (Word Vector)
  target/mips: Convert MSA LD/ST.D (Doubleword Vector)
  target/mips: Endian-swap MSA LD/ST.D (Doubleword Vector)

 target/mips/tcg/msa_helper.h.inc |   9 --
 target/mips/tcg/msa_helper.c     | 176 -------------------------------
 target/mips/tcg/msa_translate.c  |  93 +++++++++++++---
 3 files changed, 81 insertions(+), 197 deletions(-)

-- 
2.53.0


