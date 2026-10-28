Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69359606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hiTCv6D2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XYQ0fuf8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4jN-00052v-J8; Wed, 28 Oct 2026 10:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4ig-0004tC-Ff
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4ie-0004RE-KM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBe1eB994462
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FHNrySZKENM7JMaK+qV6uC
 eRhUbtJ3VhJtVhRrPaO7o=; b=hiTCv6D2xv2g/gfRd65rGlnXTYZjUn7kIrn2pD
 UpNa/K1FvDJ3yQ+PUJl4Ejsiwjj9sw2EQepuYuqe16Rsob7Vw6uyFjJscyuj5zst
 BhQnUXqLJiZ9oi4M89mdJ0aMolFofEzNxIIq+MDcyFzkLWl/HW2mIq5vhxfzfH+6
 Goni0Bflc0kmZ7OxtvYXkV4OHUexD2dupBW6s8KJUwysKTrYUWxi1LBsZ0Wihtqb
 kVBnB3okOku9LJ/Wql4ZZCTGrNYJj52hIgDi087ihPa8uQ+9G8NE7gjNAmDYdyF8
 Kxy+CZsTcr/DePLUfa6OJOq849CkgCY+R9pLV9sVlhisfguQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk82tthen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2005ce21so148263285a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793198014; x=1793802814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FHNrySZKENM7JMaK+qV6uCeRhUbtJ3VhJtVhRrPaO7o=;
 b=XYQ0fuf8JJmJg771j1cP+MlupG/I3Vg1IhuTzyc4k/V/oWwOXYhOo3fNNQbaewqTX6
 HIV1J69tNbVUA7d0oD0htHSiV+PcbVazRltaJsUmBVXvhy/5KZOhWd9sarRA9r1bRr6x
 ca7wf2aSqCoQ4aHv+cEtVyeRktbFyS5AtHEjLmQOHfDA4TjDk7QpD4NqJP/aj9BzwTF5
 jyfPQoYqKqlN0dHe2JDRseYK0kl8PMeaUvfkInBk7WvwhLaK5uRbL6YfYPIKI1oLcHKD
 GZetlyzzFA4UHMjLbioTC6rrBiXO4ZvW2rHfHjm3uIDTrGJa2Gn+d6eW0JlnaxRqwBfw
 p2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793198014; x=1793802814;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FHNrySZKENM7JMaK+qV6uCeRhUbtJ3VhJtVhRrPaO7o=;
 b=H6+ajCZe5AzME0jnLq3YIofRq/Ahw5pmUHrnDAYnfRlbsOepnsN+bCdUdeep4HcJBr
 cEIx8mqkqGBqeIl11bV/uWQO2dbjvwPWgOJKiSHRPC5NTjGKTGLPBvQBgGb9273JB1Vf
 7eiUQOazAhL4T05geGfTConQlNvovSCmpo/fCqpugZSTAyjosA/iI9ZSJHydACMp+0Ju
 MHFOPNAd3reihv/tLsVY+cH5EhZ2k/bVZpg6UsAebAZayjjizzsLdhay+LxG//zQAzWn
 MPb4M73GUAlH5SUZ29+9bOs6MuyEub9MhS4wRQJK4hk9Q/X/aXxUbSwYwpoGTckjJ2YE
 8Bdw==
X-Gm-Message-State: AFq9FYKjFBvpS1LjH2EcYM0J1TiS2CN5XMEsEIFJ7/6xkNqAL3uE2Y6c
 yc3iVEwH5GoE+1DCdGb5ssXfiZnejWwKgXJKwQ8DfMhLBgN0SRNqPcPIS5F8lGXzgvHOWasaIcH
 OLx5oWsf0fny930yM+eHlRFRd+NPsr9yPI5W8yDcWIgbw4Kk33uwMGIXd1zbxba4j66BU
X-Gm-Gg: AYBFou3WSaVNiqdxxmp+2iONlpMUpk9WvYngepmFJKTPyL36ELeyyzaUJogZ/RceK8f
 C8i4lKOISv+TmQuml5BY78YP79+8m9F70yB59Jiqz6CBxhIpIxUDm/H+NCrD9U+m2nlXr9k/eOa
 nW8NMuojYsOfU2gcDNkVGdQl/7UPcFcKaEy/IiTtjPawvEcDpeRytIj8KfjMGh6SFrPDN667b0M
 9hLOvQm+UofpznoG3GBpjXyeCB4Xw1Io45UbcFjqzTkdA7O6GOv4TDt54l7UA0MYLy6yezQMp24
 Wo9EUuWuzaS18vh4AuqAuaIykIrx/ADafWMSOeujwt5arzsdWcakBYlr6oA2DRoeyf7CNrTZvOE
 tamp3d/61AIiMnJXb9B0hRD8yMbiX0jdxojBrJkCEWYwtFL/t76lKziKtyfm2hnYc5mUd5VxJhV
 /XrT+Yh+fp8vtI0WWF48Jg7VjPYi7IWg==
X-Received: by 2002:a05:620a:462c:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-9440892fd22mr359231585a.12.1793198014392; 
 Wed, 28 Oct 2026 07:33:34 -0700 (PDT)
X-Received: by 2002:a05:620a:462c:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-9440892fd22mr359224985a.12.1793198013796; 
 Wed, 28 Oct 2026 07:33:33 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f37csm23447939f8f.8.2026.10.28.07.33.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 07:33:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 0/6] tcg/riscv64: Fix vector immediate handling
Date: Wed, 28 Oct 2026 15:33:24 +0100
Message-ID: <20261028143330.6518-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vRJ55ihBSnKGfkF72lV8qO2d9n53uJkD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX+o10cGvwzJsP
 wj/mlR2y68kv6mAVnVICemI72Ub+H4M5jaqsPYgGZMwTG3VCDRbzWI4xPDuT9hn1byFBZsDnakr
 Rnt68wORAOlw/96d3KbO4pmBy64NAJQ=
X-Authority-Analysis: v=2.4 cv=Tr1zFzXh c=1 sm=1 tr=0 ts=6ae207bf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=hXZgYZo4AAAA:8 a=1pMTofLOsOuyETur9yAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=37BJPeUnzxYkbV1yBC-1:22
X-Proofpoint-ORIG-GUID: vRJ55ihBSnKGfkF72lV8qO2d9n53uJkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX2h2W6bX/mL5w
 6389AnAL56W9fx6q4QwifCj3YYviP3V/P2WgL0bMzBXo/mf6/OWJ4lCKcIIPzvEnE/fQ2aIGadl
 isHlM3QIaymNzQp8D6hO8MWZkrVe5u3IjRpDmIIvuZli1kRZB1IH0Rkkzt+g0fwpHJ2II0x0KsS
 nEO+9YXRGkbD0jq2OfP8gqEreorSDrCdPHQVq4qibOpr23PZhO2aw+WGcAWFNjp9iuySDOazhlp
 WIgC7FJy9ZqHYL5zwWqOAecONk/mUScOtB1oiQ0aB9ZJrMzKTK2uTwcqx0d600Atghr4NltKnYM
 Y4q1cldTjaNVaRnFKELV025nlGXx84LBc0zMqB9uz+4NeTqjm7my0sKK0Y7i3wPXLobgWtZ7OHu
 TcmXhmAxkUUjcoQ7KYciQf2udV/Hm9aWn1ao1X0weGaGuFqLMWA/IFIdQDE9L7GgqUbBGHbr+zy
 3O3AHGm7lboJA05HtWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The riscv64 backend mishandles constant operands of RVV .vi forms:

- logical ops apply the immediate at a stale SEW (wrong results,
  since v9.2);
- arithmetic, compare and select ops encode the whole replicated
  64-bit constant instead of one element;
- shifts take uimm5, but the encoder checks for simm5.

1-2: add a uimm5 encoder for shifts,
3-4: extract one element (vec_imm()) for arithmetic and compare/select,
5: follow rth suggestion of adding a new constraint to pick the smallest
   element size at which the constant replicates as a simm5, and the
   emitter switches SEW to it,
6: AI-generated regression test.

Tested with qemu-aarch64 built for a riscv64 host (debug-TCG), run
under qemu-riscv64 -cpu max: the new test fails or aborts before the
series, and passes with it at every SVE vector length.

[1] https://lore.kernel.org/qemu-devel/20261010174742.3552498-1-aurelien@aurel32.net/
Supersedes: <20261010174742.3552498-1-aurelien@aurel32.net>

Philippe Mathieu-Daudé (6):
  tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
  tcg/riscv64: Use a uimm5 encoder for vector shift immediates
  tcg/riscv64: Extract elements for vector arithmetic immediates
  tcg/riscv64: Fix constant handling in vector comparisons and selects
  tcg/riscv64: Fix logical vector immediate matching and emission
  tests/tcg/aarch64: Add vector immediate regression tests

 tcg/riscv64/tcg-target-con-set.h |   1 +
 tcg/riscv64/tcg-target-con-str.h |   1 +
 tests/tcg/aarch64/sve-vec-imm.c  | 233 +++++++++++++++++++++++++++++++
 tcg/riscv64/tcg-target.c.inc     | 116 ++++++++++++---
 tests/tcg/aarch64/meson.build    |   1 +
 5 files changed, 330 insertions(+), 22 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-vec-imm.c

-- 
2.55.0


