Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B8AE7FDDB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn12y-0001BX-IV; Mon, 02 Feb 2026 16:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn12o-0000rC-5V
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn12l-0004Oa-7x
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so3957707f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066069; x=1770670869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YJim5VyeZ2IuzxEBcViYaYebgWdJCSbLeyjuVRqPweo=;
 b=nOZntNZS4M9C1EM/L62taUFd8rKS03HBmzhincBRwQMMg0jIwGI0aJpvhFFEruHIv1
 zf8nh7vVLKrvWPV1MGm6mR2rrgRIfjzj24RW7lyO8+w7rauhNiPF6zK0l4Wzd8AIYywz
 EBILWAiPeGrg/2Cr504aYqX+c1y1+QkNfar0RTbhuueiZL3OkjcUASSJbAPQkXUMlN02
 WISIlMpAxzu3WtdLaqL5sSaIwMa7SWkpIuiTx3vQy6dIDHMcp+RtTjl4pst2usX8quya
 2XMvvJRcXG3NcSibNgJO2nm55kadIIF+mqZt0jts7gFUvC+CHwkm/EB+wY+Vs2Qs3Czn
 hA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066069; x=1770670869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJim5VyeZ2IuzxEBcViYaYebgWdJCSbLeyjuVRqPweo=;
 b=P5m7+i02gNmJFSxkk/AZlDnPQMjbbmyF5kgfx5pzaC9PabzJePIbKVgnbLn7Fy3/Ds
 0oc5RvW9/R6hg/9N/7UX1WQujhAlAFEdBmjS4ZJS01fT1jasyZMh1Dz+GqlT4Ufvtvuz
 3MhBmOA+00ieajeZflV72vo9udmx1DTmJ86QHYE1pBu0cVEWH+ZW0bRvDmsVr+aBBwDM
 KQbWLlRPnUAf/P1LzLkcx9vhF8ipPlgCUVYuTyayQQA0/b/gPIXqoXGzKZivDO4ia3Zw
 oU4OG/AK07LCWfc9dmBX7EmCr64ZhOInV8TgJLu2QYqXKyF6rTKIDkE/60OzDWJe6FS8
 cLTg==
X-Gm-Message-State: AOJu0Yy/Hsio76UNwxDt6XXnSXQCI2X7vm40pJW/vhwSnCUcILHBPUo4
 H0F/7gIPeXRAhQ14iZdOzoOyj0vZoaYYu5eTfni4HDDEiWnEpQV4MWrurosdA0iaqGW/FCaR9gp
 hP51687M=
X-Gm-Gg: AZuq6aKL3NxCHZ6uYJtIjX7CzlDPEBkd1+6T+0RNG8DuMhxs/H1xAb4TorB6OJ4c8Bd
 E+9XudF1u5ncjgQxfHC6Z5BXuK0yTyejJw+eNi7wy6LCIIHkwrePQMjlUZBheaPp0HpLuEpoFzC
 zoA1b2phSuaaWbh99coZdRNv4DbDyZmrTKp0kkrAS3benV54nVsG3TsflZ25Pm4dMZEPqZnlBA0
 t0KwIOcy/JX0AbDpFbwO5Vk3k08manzDMX/OX0MFHXuFbIhFsISbOqIP6jg6Q+AuuPQQudA6EUL
 xxLgfaqaClW24YA8uc2pLdr0yQ0BXALFVJe2Gc965Ch85tBobk8Yyx+Fi4JtDf7kVkz0uamamUy
 IcyE4iOj0sm2N6y0f5J1v4+a8qjNUXpmb90LixnDmCnFK5wVSBcoh2grRwXVZ+375s5oGrX92pl
 lzJ5y5KXLaoGK+srFNCqcu8DxiF5fPyc0qu22DaCL0IQV8Rak/r63MRDNWKkzX
X-Received: by 2002:a05:6000:2489:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-435f3a9244bmr21538398f8f.24.1770066068831; 
 Mon, 02 Feb 2026 13:01:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1048a54sm45305331f8f.0.2026.02.02.13.01.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 00/11] target/ppc: Remove most MO_TE uses in
 cpu_ld/st_code/data()
Date: Mon,  2 Feb 2026 22:00:54 +0100
Message-ID: <20260202210106.93257-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

All series reviewed.

Since v5:
- Renamed mo_endian_env() -> ppc_data_endian_env()
- Renamed ppc_code_endian() -> ppc_code_endian_dc()
- Clarified expression used in ppc_code_endian_dc()

Since v4:
- Fixed incorrect rebase

Since v3 (DATA path):
- Remove MO_UNALN in do_HASH (rth)
- Complete CODE path

Philippe Mathieu-Daudé (11):
  target/ppc: Inline cpu_ldl_data_ra() calls in ICBI helpers
  target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in memory helpers
  target/ppc: Inline cpu_ld/st_data_ra() calls in do_hash()
  target/ppc: Expect page translation hash addresses to be aligned
  target/ppc: Introduce ppc_data_endian_env() helper
  target/ppc: Introduce ppc_code_endian_dc() helper
  target/ppc: Inline need_byteswap() and replace translator_ldl_swap()
  target/ppc: Check endianness via env in ppc_disas_set_info()
  target/ppc: Introduce ppc_env_is_little_endian() helper
  target/ppc: Check endianness at runtime in ppc_data_endian_env()
  target/ppc: Inline cpu_ldl_code() call in ppc_ldl_code()

 target/ppc/internal.h        | 17 ++++++++++
 target/ppc/cpu_init.c        |  9 ++----
 target/ppc/gdbstub.c         |  2 +-
 target/ppc/mem_helper.c      | 60 ++++++++++++++++++++++++++----------
 target/ppc/tcg-excp_helper.c | 27 +++++++---------
 target/ppc/translate.c       | 21 +++++++------
 6 files changed, 87 insertions(+), 49 deletions(-)

-- 
2.52.0


