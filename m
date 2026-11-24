Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A825606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sure2J7V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NfvFbVLl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzvE-0000nU-8I; Tue, 24 Nov 2026 18:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvB-0000mk-I3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:27:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzv8-0007cY-J4
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:27:33 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMabGf3520034
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=D6msyt617spH6Gtajz2G2b
 8YNVW2YwlH1ongOBBWgdA=; b=Sure2J7VJ9KZ5LDj9dq/dP1XqxuJN8SHRid0np
 SBIxsVWwxtdgtBxA7o9nz9jS1LatcHuGyGukadGQILw50uTqhTXolaATq53kGaEV
 1m97nL9d2PmABc0rg5dy4nGgyhtTI42kfp579zWuTbQlQK5tdt+NaKiz8eak3Dw4
 nKLzUZWb/CZGXw8WsFDMCT1d+MVcFSsp1bY4BFSC6W5YT/GTjDrYoL6pXBD7EWEw
 VisdJja2UbpErWB3tx7ax+cHBxyBKs7Hi2IcQmiCIxVBbKQAquUzW1d5K9xz26/y
 FDAMZ+GHd0TeQkqcPJOMFPseCALsXoDm8L06DqmJexVzN5eg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00h9bs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso589845885a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562846; x=1796167646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D6msyt617spH6Gtajz2G2b8YNVW2YwlH1ongOBBWgdA=;
 b=NfvFbVLlDL3YS5c4GwEhJycZXE261oqvVWS2gj0IaHXzTeA60N2WVQvrwzI6MMno3x
 hz7CR0e2vxMaSxKQgXL7N9ivz8B5wSFYLoVi+mhOXMlXpKyaxYXfNdPPwWur7zo6lNLA
 CPNIWmPoHa4nNPDnXfTDURC/bEDdYY0QaQ/Q+uu93RVHwxevwAoS88L3r5aqWC6CEx+f
 OxgCFVRUw6DI1LBLB6VwJYLcEUaue4Hv/SEzGSPyKhQOhmKYEX6rAHuKPVjCEcob+MmT
 zv4jjHMcZNdTTA4/s0gXtXr3tMqyWoMy91nIe+opZ2fkNtOvLSiTnTRLtziZzopf+UM7
 OaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562846; x=1796167646;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D6msyt617spH6Gtajz2G2b8YNVW2YwlH1ongOBBWgdA=;
 b=T4B+gYcXBMIibC8UiH7MivNIh3IIZMlt/g4B8TFu89ZUIADXl+6z04IA2VjY2yzpPc
 0NBTbvHHq4v0UOxp3dIPXBNZ+ER2uV7qqFUSW4JdSnhJth36WzBiucFUCTu6wD4+iQXh
 /WdRmzK0Ah2qB4QS4qVs29YMXc5h0lxhAlvA6djh+SilZFXraZ3w3LyXElxh2fzZvPZQ
 3zgYs8n7HY0uPmwTrHsHQpJ+3kYLMrE0NScb+y6moAmjJzTH1BWmxgYB9aJ02buqPmTU
 0xIEuO5i2fNBZVdWaBPoCNLF7i9Rm777eEDKYugHMcFOj4pOWlAeIUaZNMc/jdWH8WZi
 Km3g==
X-Gm-Message-State: APuU4Z/npc69zelo1/Xi28ZmZPO626f1IoopkanLSojZjL3P2TX+e0Mi
 OEb92jm88YUQlnNcELZ1OBic0QyUtE9uK0ZtV5YNQjunv34PBYk8G07654ypRg/YtPOado3pqyF
 Pp6lU2SRySMpI+AMYQaBHSVBIGwyi+Y5ls6W2upuEmzZTtxXwOocdvJ2tQhEdIcgR7sWs
X-Gm-Gg: AZFdTZerez4MpDcgPw8G8s5CUdAqEpsPidIq7jnMGOA873m+SDd99ALniG0AztKunpg
 JDya2R9u9u+RVg7lQPN0TUsaN++6AxBT4CzHb4XhoSqcJfcywwCiNmI8eb9BUsNTBQZgt9ZyKpK
 Nza8cYLEWQNkjTTYVrtWEvyUs3snQQ9YOF/FMYXuy9SYztZSHyJgoM/o+QGQFxCnYMShVS7WcGk
 23DqBJpUPzqKBN4Q7URZVZqHv+jOC4VX2VtVLL5YeqZuNGlifqLUhtb6C9DxhHD3yfseUedjxtV
 4vPBjGPfrYeI1wXJm8RUF6CbMeUcMjtvB+MwJiGJPfv04wIt1SPuQ2+vcsxErWuc8jxoxN57HkF
 evSRBxyUzTRgvNZPeMESgo8maaCmabQz+sOaeteZgIFuwZ2Ohes+ee42DwnsMsqtQs3bpMH2AOr
 126rylbk6TzH4ywg==
X-Received: by 2002:a05:620a:1308:b0:93f:2ab9:728c with SMTP id
 af79cd13be357-949bab2f3cfmr2816159385a.71.1795562846014; 
 Tue, 24 Nov 2026 15:27:26 -0800 (PST)
X-Received: by 2002:a05:620a:1308:b0:93f:2ab9:728c with SMTP id
 af79cd13be357-949bab2f3cfmr2816155285a.71.1795562845443; 
 Tue, 24 Nov 2026 15:27:25 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm177147325e9.4.2026.11.24.15.27.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:27:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Mist target patches for 2026-11-24
Date: Wed, 25 Nov 2026 00:27:04 +0100
Message-ID: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6WLpiflpMDgNWEaLTxXVpRQVSN1JB9-9
X-Proofpoint-GUID: 6WLpiflpMDgNWEaLTxXVpRQVSN1JB9-9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXzMNV5bzzonWM
 7weLFZYGbb3VqwAxJPulfO8xCZmE8bpGYjlyTY+92ky2I99C+slqQW1IoJc1WYVVrUesEGBeUE0
 5rmWJx561QJEX26wrLccOvVE4Omk8TY=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b061d5f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=BQJTiO58KWaoi10Hfi8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX+zqdciS8Hj5h
 3zAiajT4JbPLFvy2QYWVi5fnr3QSYaD6wGx5OSk6vsGqAmztC3A/d4FQtmq5EkknAQ+FC0aQtkf
 wX/HcHNAFKQSaz+ukZy3/Aqza/3HAhHRyi0pQeQeMI7pvwqdwrwe6c8aj/9PxoU1MCcOlFPrpVh
 cZBINXHwT02EgTWBER6O9xroJJ1Il/x5fVAZevcdYHBfuE4XCK0RGvwX5Bp+6cdhUBKriGjFmgX
 9em4PLv4AD0c9Qv7PD195datLYb6HEmLUyhcQ0Qjc0mytLa0U3A+AeQmYRD+SkyBPhc+Nu4irsF
 eGCrKv0vTXN64kJAE6cwFlG+JhSu4FBTDff/Z6pG7R/EXYNvg8i+sgbmhpO+09HYz6emF6HWuge
 2UHfjThdE25K31GJMrz5HH9+ajv44YLrBOFElEWKyI6AWrBHKE/4ETGN8kIqWx23oms0s7EF/+b
 0TxcbwxL8XJULedk99g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:

  Merge tag 'pull-target-arm-20261124' of https://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/target-misc-20261124

for you to fetch changes up to fd25fe89996688623717b485654e26a0d7f46c62:

  target/mips: Do not sign-extend partial LWR results on Octeon (2026-11-25 00:22:48 +0100)

----------------------------------------------------------------
Misc fixes for 11.2

- TCG flags (M68k, PPC) & icount (ARM)
- MIPS opcodes and exceptions
----------------------------------------------------------------

Philippe Mathieu-Daudé (18):
  accel/tcg: Check current CPU in icount interrupt handler
  Revert "target/arm: don't pass env to the sev helper"
  target/arm: Kick other vCPUs on SEV under TCG round-robin
  target/m68k: Fix TB_FLAGS_TRACE* definitions
  target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags
  target/mips: Check for MIPS II when decoding BLEZL/BGTZL
  target/mips: Require rt == 0 when decoding BLEZL/BGTZL
  target/mips: Require the MT module for MFTR/MTTR
  target/mips: Enforce alignment and 64-bit CPU for the DSP LX loads
  target/mips: Fix reset into microMIPS mode when Config3.ISA is 3
  target/mips: Fix microMIPS BC2NEZC POOL32I minor opcode
  target/mips: Fix microMIPS CACHE offset used for ITC tag access
  target/mips: Fix nanoMIPS BPOSGE32C branch offset sign extension
  target/mips: Pass the right instruction size for nanoMIPS RESTORE.JRC
  target/mips: Fix nanoMIPS BC1EQZC/BC1NEZC always raising RI
  target/mips: Pass the nanoMIPS BREAK code to
    generate_exception_break()
  target/mips: Decode 6-bit bit number of nanoMIPS BBEQZC/BBNEZC
  target/mips: Do not sign-extend partial LWR results on Octeon

 target/arm/tcg/helper-defs.h              |  2 +-
 target/m68k/cpu.h                         |  4 +--
 accel/tcg/tcg-accel-ops-icount.c          |  2 +-
 target/arm/tcg/op_helper.c                |  6 ++--
 target/arm/tcg/translate-a64.c            |  2 +-
 target/arm/tcg/translate.c                |  2 +-
 target/mips/cpu.c                         |  2 +-
 target/mips/tcg/translate.c               | 35 ++++++++++++++++++-----
 target/ppc/translate.c                    |  4 +--
 target/mips/tcg/micromips_translate.c.inc |  4 +--
 target/mips/tcg/nanomips_translate.c.inc  | 26 +++++++----------
 11 files changed, 53 insertions(+), 36 deletions(-)

-- 
2.55.0


