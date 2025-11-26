Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA75CD1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM37-0003wy-6n; Wed, 26 Nov 2025 15:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2z-0003pY-MY
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2t-0002UV-EQ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:28 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so194408f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188601; x=1764793401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDoRFtIf4DtlaKu8FqeCDNwKdTIWIuyOpEl6R55IExI=;
 b=oLwqclHf2zTenZc2x3+sMWEuFoIfqmLQ1yihfdxUV0bbbcNApApkPKshxsFLst0w+C
 5tOEGbnbTUBtA1pNgpdOVJF0bjrnJaXVuaQiBnH2St1yEgVQvZH4I6M1RBjWOolrnUxP
 QPy9AH2T29PtpxRJu3hQt1V8MxIHO8D5c7lx/VqNZB623pcg5msoCQgV2hV1Y/DRcwAx
 xMFy3c15gkcGJVrKbI8W92gC3ej2MCRyqpocBInHwlFp9sKlY1oSV94+rdqBN9P9AALK
 RK49Ya20b7GJ8AvjU5eZ5p7rLqnCtLhBtxhGntJtLchncpqwGGjQOqZmwKMLRobPrZ5r
 c9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188601; x=1764793401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HDoRFtIf4DtlaKu8FqeCDNwKdTIWIuyOpEl6R55IExI=;
 b=Gc5YPISYc2Q/4RN/0brMp3n8aeeopd8hYy8Uni2ZF6voH80X4iwwhpNUgH0zFCq292
 RNM4e6mpJR2mlVNFL41OFJ5pPYMA6pM/bZMDdGGz0Wowi15oHyt4FyGF3uUsaZc1yO1N
 p4DoV0jGh1qKCnqvpzfF/0610hCNHL21x/Sk6LnOd6NSM4k/wdV++dXtWINDXFfytQPB
 cBwnfGp/cdBaxNkwTz4JNZINfLITe+uuqjUb6PUuMJUNeNRZw9fz9NhhApE+ooqABL7f
 yggdAOGUTpmnqLU2TleyvC6ueN3+06DrBDiLZVp7wh26JZ0jw+mCaIYcO/Y8NKuHcm1O
 M3aQ==
X-Gm-Message-State: AOJu0Yy2GWJKokcC6Q8IVSHsMR8Xvg8nPjsUmxtgA89fodk2+4QUxdor
 8M306WRHOtqBRKRzOXL6GEoNxO+LI02QnCFWJPOp00fm4mbu4sUdgnyXg7CszqAPWwdzF9giZz9
 OIQvSsn2GM7T2
X-Gm-Gg: ASbGncsyXfQ8sBle97YMCACOrJb6VbTteGZzNH79EJDUiN1xVBL+h3FV/O3ODnv7xm5
 O3+zJsDddDRJy6d9l9BB5WB69JennRX4Ilxp+nKwKYHV3pBdFINhux0fLecGlyUeVXflXaLPllA
 D3Hc4x2Yh07FWt+UxiHBQzXWm9J8WJPQnOBj7YwvOXpBDNAbOqElf/c6jOJS6uCyHr20NRvx2Lx
 K2rEFW+DTTTTZJZxe4L04xttTmNQBRo4gFnEJJh1oCYJPiW8zFRRlQYxu4nM4BvQ8pYmU6QrR0j
 KNuCoo1xIYgA1lkBQZ6DhB4KPV8Fzp7q4x9JVergI6e08ngVGoOOz5RF5FEldVs0Q7jYPyycKJ7
 Q10xVrwcQUHMXMbdlN9P+I8v045/PuAR50gIT9ZIwWaoUQCpSt7msFnFwJLbiMW0Lb624ILYkmC
 NwO+IVCQ6EgmKwNU4LFCtbdEUbpqua6G6uaSk1Qhh41ZbZ5zgzRhWQNXvu2N+5
X-Google-Smtp-Source: AGHT+IFP1FGWF3zB+KoPGDZLKAAQDo5j3qIIL+EswbtfmJJT3d2iXEt+N31Kpe2Se6/ghA6FT/vcxA==
X-Received: by 2002:a05:6000:1445:b0:42b:3ed2:c08a with SMTP id
 ffacd0b85a97d-42cc1cbd06dmr23105135f8f.13.1764188600579; 
 Wed, 26 Nov 2025 12:23:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ffesm43443224f8f.10.2025.11.26.12.23.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 11/22] target/mips: Use big-endian variant of
 cpu_ld/st_data*() for MSA opcode
Date: Wed, 26 Nov 2025 21:21:47 +0100
Message-ID: <20251126202200.23100-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

MSA vectors are accessed in big endianness.

Per the "MIPS® SIMD Architecture" (MD00926 rev 1.03):

  3.1 Registers Layout

  MSA vectors are stored in memory starting from the 0th element at
  the lowest byte address. The byte order of each element follows the
  big- or little-endian convention of the system configuration.

Use the explicit big-endian variants of cpu_ld/st_data*().

Running files in tests/tcg/mips/user/ase/msa shows:

 NLOC.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.21 ms  |
 NLOC.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.22 ms  |
 NLOC.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.18 ms  |
 NLOC.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.18 ms  |
 NLZC.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.19 ms  |
 NLZC.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.18 ms  |
 NLZC.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.21 ms  |
 NLZC.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.18 ms  |
 PCNT.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.17 ms  |
 PCNT.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.19 ms  |
 PCNT.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.18 ms  |
 PCNT.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.19 ms  |
 BINSL.B           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 BINSL.H           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 BINSL.W           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 BINSL.D           | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 BINSR.B           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 BINSR.H           | PASS: 112  | FAIL:   0  | elapsed time:  0.58 ms  |
 BINSR.W           | PASS: 112  | FAIL:   0  | elapsed time:  0.58 ms  |
 BINSR.D           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 BMNZ.V            | PASS: 112  | FAIL:   0  | elapsed time:  0.65 ms  |
 BMZ.V             | PASS: 112  | FAIL:   0  | elapsed time:  0.59 ms  |
 BSEL.V            | PASS: 112  | FAIL:   0  | elapsed time:  0.60 ms  |
 BCLR.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BCLR.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BCLR.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BCLR.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 BNEG.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BNEG.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 BNEG.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BNEG.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BSET.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 BSET.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BSET.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 BSET.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.33 ms  |
 MADD_Q.H          | PASS: 112  | FAIL:   0  | elapsed time:  0.60 ms  |
 MADD_Q.W          | PASS: 112  | FAIL:   0  | elapsed time:  0.83 ms  |
 MADDR_Q.H         | PASS: 112  | FAIL:   0  | elapsed time:  0.62 ms  |
 MADDR_Q.W         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MSUB_Q.H          | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 MSUB_Q.W          | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 MSUBR_Q.H         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MSUBR_Q.W         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MUL_Q.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MUL_Q.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MULR_Q.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MULR_Q.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 FMAX_A.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.36 ms  |
 FMAX_A.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 FMAX.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.33 ms  |
 FMAX.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 FMIN_A.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.36 ms  |
 FMIN_A.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 FMIN.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.35 ms  |
 FMIN.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 ADD_A.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADD_A.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADD_A.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADD_A.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 ADDS_A.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 ADDS_A.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.33 ms  |
 ADDS_A.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_A.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_S.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.80 ms  |
 ADDS_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 ADDS_U.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDS_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDV.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 ADDV.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ADDV.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 ADDV.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HADD_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HADD_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HADD_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HADD_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HADD_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.33 ms  |
 HADD_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVE_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 AVE_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVER_S.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVER_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 AVER_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVER_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVER_U.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 AVER_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVER_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AVER_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CEQ.B             | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 CEQ.H             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CEQ.W             | PASS:  80  | FAIL:   0  | elapsed time:  0.38 ms  |
 CEQ.D             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLE_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLE_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLE_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLE_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 CLE_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 CLE_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 CLE_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 CLE_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 CLT_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 CLT_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 CLT_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLT_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLT_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLT_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 CLT_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 CLT_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 DIV_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 DIV_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 DIV_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DIV_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DIV_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.39 ms  |
 DIV_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 DIV_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DIV_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DOTP_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DOTP_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.35 ms  |
 DOTP_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DOTP_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DOTP_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 DOTP_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 DPADD_S.H         | PASS: 112  | FAIL:   0  | elapsed time:  0.59 ms  |
 DPADD_S.W         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 DPADD_S.D         | PASS: 112  | FAIL:   0  | elapsed time:  0.58 ms  |
 DPADD_U.H         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 DPADD_U.W         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 DPADD_U.D         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 DPSUB_S.H         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 DPSUB_S.W         | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 DPSUB_S.D         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 DPSUB_U.H         | PASS: 112  | FAIL:   0  | elapsed time:  0.58 ms  |
 DPSUB_U.W         | PASS: 112  | FAIL:   0  | elapsed time:  0.59 ms  |
 DPSUB_U.D         | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MAX_A.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MAX_A.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 MAX_A.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.33 ms  |
 MAX_A.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MAX_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MAX_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MAX_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MAX_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.35 ms  |
 MAX_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.35 ms  |
 MAX_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MAX_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 MAX_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_A.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 MIN_A.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_A.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_A.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.33 ms  |
 MIN_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 MIN_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MIN_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 MOD_S.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 MOD_S.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 MOD_S.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MOD_S.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MOD_U.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.37 ms  |
 MOD_U.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 MOD_U.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MOD_U.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MADDV.B           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 MADDV.H           | PASS: 112  | FAIL:   0  | elapsed time:  0.63 ms  |
 MADDV.W           | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MADDV.D           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 MSUBV.B           | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MSUBV.H           | PASS: 112  | FAIL:   0  | elapsed time:  0.65 ms  |
 MSUBV.W           | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 MSUBV.D           | PASS: 112  | FAIL:   0  | elapsed time:  0.65 ms  |
 MULV.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 MULV.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MULV.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 MULV.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ASUB_S.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ASUB_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ASUB_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ASUB_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ASUB_U.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.44 ms  |
 ASUB_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 ASUB_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ASUB_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HSUB_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HSUB_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 HSUB_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 HSUB_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HSUB_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 HSUB_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 SUBS_S.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 SUBS_S.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.38 ms  |
 SUBS_S.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 SUBS_S.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBS_U.B          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBS_U.H          | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 SUBS_U.W          | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 SUBS_U.D          | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBSUS_U.B        | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBSUS_U.H        | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 SUBSUS_U.W        | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBSUS_U.D        | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBSUU_S.B        | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBSUU_S.H        | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 SUBSUU_S.W        | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBSUU_S.D        | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBV.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBV.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBV.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SUBV.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVEV.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.35 ms  |
 ILVEV.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 ILVEV.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 ILVEV.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 ILVOD.B           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVOD.H           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVOD.W           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVOD.D           | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVL.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 ILVL.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVL.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVL.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVR.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVR.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 ILVR.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 ILVR.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 AND.V             | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 NOR.V             | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 OR.V              | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 XOR.V             | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 MOVE.V            | PASS:  80  | FAIL:   0  | elapsed time:  0.18 ms  |
 PCKEV.B           | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 PCKEV.H           | PASS: 112  | FAIL:   0  | elapsed time:  0.56 ms  |
 PCKEV.W           | PASS: 112  | FAIL:   0  | elapsed time:  0.68 ms  |
 PCKEV.D           | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 PCKOD.B           | PASS: 112  | FAIL:   0  | elapsed time:  0.61 ms  |
 PCKOD.H           | PASS: 112  | FAIL:   0  | elapsed time:  0.62 ms  |
 PCKOD.W           | PASS: 112  | FAIL:   0  | elapsed time:  0.58 ms  |
 PCKOD.D           | PASS: 112  | FAIL:   0  | elapsed time:  0.58 ms  |
 VSHF.B            | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 VSHF.H            | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 VSHF.W            | PASS: 112  | FAIL:   0  | elapsed time:  0.62 ms  |
 VSHF.D            | PASS: 112  | FAIL:   0  | elapsed time:  0.57 ms  |
 SLL.B             | PASS:  80  | FAIL:   0  | elapsed time:  0.34 ms  |
 SLL.H             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SLL.W             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SLL.D             | PASS:  80  | FAIL:   0  | elapsed time:  0.38 ms  |
 SRA.B             | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 SRA.H             | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 SRA.W             | PASS:  80  | FAIL:   0  | elapsed time:  0.37 ms  |
 SRA.D             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SRAR.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 SRAR.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 SRAR.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 SRAR.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SRL.B             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SRL.H             | PASS:  80  | FAIL:   0  | elapsed time:  0.32 ms  |
 SRL.W             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SRL.D             | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SRLR.B            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |
 SRLR.H            | PASS:  80  | FAIL:   0  | elapsed time:  0.29 ms  |
 SRLR.W            | PASS:  80  | FAIL:   0  | elapsed time:  0.31 ms  |
 SRLR.D            | PASS:  80  | FAIL:   0  | elapsed time:  0.30 ms  |

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index f554b3d10ee..d6ce17abf9a 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8231,8 +8231,8 @@ void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
     uint64_t d0, d1;
 
     /* Load 8 bytes at a time.  Vector element ordering makes this LE.  */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
+    d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
+    d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8248,9 +8248,9 @@ void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
      * Load 8 bytes at a time.  Use little-endian load, then for
      * big-endian target, we must then swap the four halfwords.
      */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
+    d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
+    d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
+    if (!mips_env_is_bigendian(env)) {
         d0 = bswap16x4(d0);
         d1 = bswap16x4(d1);
     }
@@ -8269,9 +8269,9 @@ void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
      * Load 8 bytes at a time.  Use little-endian load, then for
      * big-endian target, we must then bswap the two words.
      */
-    d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-    if (mips_env_is_bigendian(env)) {
+    d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
+    d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
+    if (!mips_env_is_bigendian(env)) {
         d0 = bswap32x2(d0);
         d1 = bswap32x2(d1);
     }
@@ -8286,8 +8286,12 @@ void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
     uintptr_t ra = GETPC();
     uint64_t d0, d1;
 
-    d0 = cpu_ldq_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_data_ra(env, addr + 8, ra);
+    d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
+    d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
+    if (!mips_env_is_bigendian(env)) {
+        d0 = bswap64(d0);
+        d1 = bswap64(d1);
+    }
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8320,8 +8324,8 @@ void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
     ensure_writable_pages(env, addr, mmu_idx, ra);
 
     /* Store 8 bytes at a time.  Vector element ordering makes this LE.  */
-    cpu_stq_le_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
+    cpu_stq_be_data_ra(env, addr + 0, pwd->d[0], ra);
+    cpu_stq_be_data_ra(env, addr + 8, pwd->d[1], ra);
 }
 
 void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
@@ -8337,12 +8341,12 @@ void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
     /* Store 8 bytes at a time.  See helper_msa_ld_h. */
     d0 = pwd->d[0];
     d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
+    if (!mips_env_is_bigendian(env)) {
         d0 = bswap16x4(d0);
         d1 = bswap16x4(d1);
     }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
+    cpu_stq_be_data_ra(env, addr + 0, d0, ra);
+    cpu_stq_be_data_ra(env, addr + 8, d1, ra);
 }
 
 void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
@@ -8358,12 +8362,12 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
     /* Store 8 bytes at a time.  See helper_msa_ld_w. */
     d0 = pwd->d[0];
     d1 = pwd->d[1];
-    if (mips_env_is_bigendian(env)) {
+    if (!mips_env_is_bigendian(env)) {
         d0 = bswap32x2(d0);
         d1 = bswap32x2(d1);
     }
-    cpu_stq_le_data_ra(env, addr + 0, d0, ra);
-    cpu_stq_le_data_ra(env, addr + 8, d1, ra);
+    cpu_stq_be_data_ra(env, addr + 0, d0, ra);
+    cpu_stq_be_data_ra(env, addr + 8, d1, ra);
 }
 
 void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
@@ -8372,9 +8376,16 @@ void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     int mmu_idx = mips_env_mmu_index(env);
     uintptr_t ra = GETPC();
+    uint64_t d0, d1;
 
     ensure_writable_pages(env, addr, mmu_idx, GETPC());
 
-    cpu_stq_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_data_ra(env, addr + 8, pwd->d[1], ra);
+    d0 = pwd->d[0];
+    d1 = pwd->d[1];
+    if (!mips_env_is_bigendian(env)) {
+        d0 = bswap64(d0);
+        d1 = bswap64(d1);
+    }
+    cpu_stq_be_data_ra(env, addr + 0, d0, ra);
+    cpu_stq_be_data_ra(env, addr + 8, d1, ra);
 }
-- 
2.51.0


