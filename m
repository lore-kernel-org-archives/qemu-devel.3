Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C65CE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIT-0003ud-M4; Mon, 29 Dec 2025 13:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIH7-0003eR-Cb
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIH2-0008Bu-Cr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:24 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTA50vL956291
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=yBD6K6PmyWWi3JSEkHMpA0HoOy/T5q9gg+d
 p/mI9dto=; b=DlHnSwFanpDTOVaUC8oUZ9NyTrn7HFkizY7Spy5Cun/FdvB/BP5
 XDcSnrHI+F0SGJQcijheb84L0mbslGyBCXUhTXn5Q58JOxeUo2//I/c3obxBXCdf
 5WeO1I41mJT7uspJacYcuYXWCXWqVSNnwnqH5ImJ24mJ29kYFfzxTwCoLiu+jRqQ
 0gUBKMZy5Zt55BlfyYFBln8GwTAnlZntn89HoaKIdMp2/ZJRh54YfRDwcZR4022F
 DgixwpmTmwE3/QI1kZaZZUUUuMCaQlHGTFtyMYKPpHRtrs7O/qdO1rtlQ7Uu/anE
 oDCSAxjJfTIActyTJrNYtl7OX4si+gDUkuQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk193xf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f1450189eso85736465ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034036; x=1767638836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yBD6K6PmyWWi3JSEkHMpA0HoOy/T5q9gg+dp/mI9dto=;
 b=K/VY0LmdIDwhTwl7rqkiLoBfPMuHS4fTxfOsCx2x6dj71K7hxQ1KasF+wfSDUpx9t7
 sBeAacGwPIm+nzkuSPzVqVCpXR99cqC05DxjysouIOFM3KK9N9rzagO1AVWuYZUvbq7V
 MzZjBKxUfoR2EQT/7DPvfx38WAS4ECmBWU9loPEdFg2tRBqcBWEvRS0xDSRbHL+4/ay+
 MN4CWXYq8h9XZO8s0eG7tK2Da03Vijk8ZDK78OLF4TPGKaaK7iqzI24MvPv424GXpSoK
 PzQRkoA6Efsa81TF43G1Nxg9kxHeidQl2qKzCUu8fasjgovLjjduJUstwkjXhX6xM7rh
 CXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034036; x=1767638836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBD6K6PmyWWi3JSEkHMpA0HoOy/T5q9gg+dp/mI9dto=;
 b=QqZ4hSC+W6/GCWJmzQnf98D58lR3M2gynXCvy3rI8UBhXE4DN9nDcKXgCAPcKEsjma
 SdVYBo5LkcjADEBKZcMxbf/KXPC8keQ6zp3SAZp0j0UdHO6INtIGF+GnY9o+O9oAukLh
 FRWGhWYO9CRsvkHZVP9FYj3AaEAXFfc6DuO7OlhnNWrnkRA9VoCLrRPAwX/8+NR1eUMo
 l8m5IdEwT1YPcYStF37yexLado2bZzO/s9X7kGRKm0sLNi7u8+hK1HQ/KYmN0iTA8zZF
 kRUYzFkPjm4PwqKN5UIbm0l2m1QSit/OYxdj44FtoaMA++Srccla/kHrOUkVUwr4/7gC
 P1nQ==
X-Gm-Message-State: AOJu0Yw6B1Qa3jLR6BsxAL6HzTtH21WCgMdAIzTewHqfOQhAoh3c9nQr
 c4TEfTpmUqRCQEjNB08IFeQsR5vvu2OtNEqqddIKBh8WIH6U4qMwqFOjKJrch9/xRLug1SmMIfZ
 Kxc/BC4b7vaMNwLrbfPMwNyU//k41lPzAu1DhcuRwkpMHIjMhduWmvOUTT1JwPk7kOQ==
X-Gm-Gg: AY/fxX6s8Hj09dIu2QSfTyvsCVvztqwh2L6ceJCsKWRJjSDtq5S4dAKaOc3Smc4ixUj
 kgTKQa60Zhf6fnIkhEqF30fGm+klqDhH8gmARHdwg/lWFFKIcyMYkks5pdBqNWKjlHV/qeL5dXH
 beLhLUwBlOdy7FO6KB/S/Z/E+1iy2SF9iXzgejGQVgdGpoDxglcHFeqhGavYmVsYZ02nS0Oha+9
 iqAhGyFZ1e9zH1yLpOIfjMiQNV0nwatttUHgb0IEUoU8ggdvnlXNIn2dj5veF5WLHl2mq3YLm4s
 KBOnBf0OJ4BI/Jkmx/kixuPfTRfMqpErHlhskkgHhrJJW5stSU7L79ntgf4LM4ykWkkOiBkfzyB
 /z2BzDnqumrv7tSQwK+d1DZQ9YRNBKl0dB4itdSEhCCZhYxs=
X-Received: by 2002:a17:902:e74c:b0:299:bda7:ae45 with SMTP id
 d9443c01a7336-2a2cab60b33mr324061755ad.25.1767034036164; 
 Mon, 29 Dec 2025 10:47:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVcdyrkdaE0x8BcrW2k8B9PTlhUN7HD10zWycZPwNBGZ+YHGoiahpzHsMgxlWSu0niMCEULg==
X-Received: by 2002:a17:902:e74c:b0:299:bda7:ae45 with SMTP id
 d9443c01a7336-2a2cab60b33mr324061585ad.25.1767034035307; 
 Mon, 29 Dec 2025 10:47:15 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:14 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 00/17] hw/riscv, target/riscv: initial e-trace support
Date: Mon, 29 Dec 2025 15:46:39 -0300
Message-ID: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K6JjhUih1e1-kNWbxJF5F3uQcr_rE0jm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXyVwfv07azxh/
 4+2QjS5tsHw+8/e5BENC+6te7xu372XCPwYWzY3KnSa/C2ATYDMJcCCboPTC9qYMLGHdlFpaC4H
 +97rLbqf+vbBjpdznjp1ph93c0rm/lKp2kREaMlBnA7ZxXEEYxt9zatlspLerJ1uidWqYI5LJ//
 Vt3zLc9dYHg92BZPzhULMuuSSasCRACYNmuU0lZf9LIWZy3vGYDZA/bP3C0DZ2ju0S7Vd18SMp2
 WTu9FYzHs01EkB+pYgPhcYuCzgmvwvMzuvSwDJDmJy5YdsDs+swodAhAdgpSyAabQpTZrBKQ83f
 yjVoA5q4KQ9QTrKKMGbCsFqKUB3luaWQ/Cp2xCJBiCOvnq82fLVrBmACFzy0+x6yHNKqvEY9YKG
 8DmdBK/W9W3+XgnPPMw4c5jFtEFYcVNfn9HkGPkDMilTyC0AQkvHxdv892Tcjmfy1bwnYN8nQm7
 WTucaumGlPkLvAJ+YXA==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=6952ccb5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=KJi5ZG0fWOfivDUFhOQA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-GUID: K6JjhUih1e1-kNWbxJF5F3uQcr_rE0jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

In this version I addressed Konstantin review comments from v2. They
consisted on fixes in TE_CONTROL and TR_RAM_CONTROL fields from the
trace encoder and trace ram sink and changes in in the e-trace message
helpers.

And in case someone notices: an administrative change was made w.r.t the
authors email addresses and all copyright for new files: Qualcomm bought
Ventana MicroSystems and it's now sponsoring this new version and all
future versions of this work.

Despite the big changelog no functional change was made in comparison
with v2.

Patches based on alistair/riscv-to-apply.next.

Changes from v2:
- patch 1:
  - changed RSVP5 TE_CONTROL field size from 4 to 5
- patch 2:
 - changed RSVP2 TR_RAM_CONTROL field size from 2 to 3
 - changed RSVP4 TR_RAM_CONTROL field size from 16 to 17
- patch 6:
  - add an enum to store payload size macros
  - rv_etrace_write_bits() returns the number of written bits
  - use "/" and "%" instead of bit shift operations in
    rv_etrace_write_bits
  - use MIN() to calculate 'byte_bits' in rv_etrace_write_bits
  - use deposit32() to write bytes[byte_index]
  - rv_etrace_write_header() now returns the number of written bits
  - write 'flow' and 'extend' in write_header()
  - assign 'addressLow' and 'addressHigh' in 'payload' declaration
- patch 10:
  - add TRAP_PAYLOAD_SIZE_64BITS to RVTraceMessagePayloadSize enum;
  - assign 'addressLow' and 'addressHigh' in 'payload' declaration
  - use the return of write_header() and write_bits() to increment bit_pos
- patch 13: 
  - add FORMAT2_PAYLOAD_SIZE_64BITS to RVTraceMessagePayloadSize enum;
  - assign 'addressLow' and 'addressHigh' in 'payload' declaration
  - use the return of write_header() and write_bits() to increment bit_pos
- patch 15:
  - add FORMAT1_BASE_PAYLOAD_SIZE_64BITS and FORMAT1_PAYLOAD_MIN_SIZE_64BITS
    to RVTraceMessagePayloadSize enum;
  - assign 'addressLow' and 'addressHigh' in 'payload' declaration
  - use the return of write_header() and write_bits() to increment bit_pos
- v2 link: https://lore.kernel.org/qemu-riscv/20251111114656.2285048-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (16):
  hw/riscv: Trace Encoder initial impl
  hw/riscv: Trace RAM Sink initial impl
  hw/riscv/trace-encoder: add trace start/stop logic
  hw/riscv/virt.c: add trace encoders and trace ram sinks
  hw/riscv: add e-trace message helpers
  target/riscv: add initial trace instrumentation
  hw/riscv/trace-encoder: write e-trace packets to RAM sink
  test/qtest: add riscv-trace-test.c
  hw/riscv/rv-trace-messages.c: add encoded trap message
  hw/riscv, target/riscv: send trace trap messages
  target/riscv, hw/riscv: send trace ppccd packets
  hw/riscv/trace: add format2 msg helper
  hw/riscv, target/riscv: send resync updiscon trace packets
  hw/riscv/rv-trace-messages: add format 1 msgs with branch info
  hw/riscv/trace-encoder: send branches info
  hw/riscv/trace: update branch bit in sync messages

Mayuresh Chitale (1):
  hw/riscv/virt.c add trace encoder and ramsink fdt nodes

 hw/riscv/Kconfig                              |   5 +
 hw/riscv/meson.build                          |   2 +
 hw/riscv/rv-trace-messages.c                  | 340 ++++++++++
 hw/riscv/rv-trace-messages.h                  |  40 ++
 hw/riscv/trace-encoder.c                      | 609 ++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  62 ++
 hw/riscv/trace-events                         |   9 +
 hw/riscv/trace-ram-sink.c                     | 263 ++++++++
 hw/riscv/trace-ram-sink.h                     |  83 +++
 hw/riscv/virt.c                               | 135 ++++
 include/hw/riscv/virt.h                       |   2 +
 target/riscv/cpu.h                            |  11 +
 target/riscv/cpu_helper.c                     |  26 +-
 target/riscv/helper.h                         |   6 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  11 +
 target/riscv/insn_trans/trans_rvi.c.inc       |  15 +
 target/riscv/meson.build                      |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |   5 +
 target/riscv/trace_helper.c                   |  62 ++
 target/riscv/translate.c                      |  19 +
 tests/qtest/meson.build                       |   2 +-
 tests/qtest/riscv-trace-test.c                | 120 ++++
 22 files changed, 1827 insertions(+), 3 deletions(-)
 create mode 100644 hw/riscv/rv-trace-messages.c
 create mode 100644 hw/riscv/rv-trace-messages.h
 create mode 100644 hw/riscv/trace-encoder.c
 create mode 100644 hw/riscv/trace-encoder.h
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h
 create mode 100644 target/riscv/trace_helper.c
 create mode 100644 tests/qtest/riscv-trace-test.c

-- 
2.51.1


