Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4826BFED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGLwL-00063I-D7; Fri, 24 Apr 2026 15:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwJ-00062V-1W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwH-0004L4-9N
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OIpaFc4079198
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=gnGzfrXlh4bg+Rgl9Cl9U2/OQ13aR2fTtFi
 8jv3dn1s=; b=JXMn1yJcJbcXBM6kFq0kJ8kIJ94k4qU1Gkaa+xUadnNJmvYncTJ
 JjvCbl+McYrbal5XexaV53lp37xSA0bnDl40t5xmLMwJlH8CahIyM/HZxHINaFAB
 BI3U80CBOdmR6dWyjraoYH0N/w+l1USiTECh0RkrC0RlmKMO7agVx2bg7nChFLMp
 6K9gudgFBNJV5H10kaWZjsR51u2J8vVJA0JDKBUv+NoKLIlwgUbnYKmn4TYVVSgp
 QxoIhX9zC0WkEzO2nsheopgH4bEBwbmI61QgKIPa6Q4jPeVdKT1Rr5UnCW+Ih78v
 xZZ899JxR8hTecqa3P/7DbYzWywkkzsPp7Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dre5q824j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d5107ec672so2009189885a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777057895; x=1777662695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gnGzfrXlh4bg+Rgl9Cl9U2/OQ13aR2fTtFi8jv3dn1s=;
 b=Ka3K9240EtUtDAOVBV7CfHGRxfDEVUrrFpaEmIcmUwvOjY4/RdNbJiGuVuxrJOiUJ5
 NDVep6z877rQThlfD/RLi1pEFOHVHgAAVVp4j/kOQ2R81DiaR2Ge+BCBeitZTOCnbnnP
 JYNCn2wwNacKMHCeieBA+w7jOJcPv4YRoFdptdFlod2AEg0G5r1cGdvQWohyT5ARx2Lh
 UPmn6brKiR8Tk5ImThi3BT1Qqn3NJJiSQcFxlaEQO9B6i1J5Mg9/lb+E/XVMMt+bk1rg
 dUv25bn3nJiX5wuTBFAKljo30LwqBtxVIy44YWLYHWpwWhE3WdvECHmjYmEmLtDLgrm/
 rJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777057895; x=1777662695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnGzfrXlh4bg+Rgl9Cl9U2/OQ13aR2fTtFi8jv3dn1s=;
 b=CRlD9t39mm5VL64ZOg1gxJk0wuES05Spi3/koiVwjX6ZX2pG/oRhODTrkyqLBm9pRv
 8N45Og34pZr5xzvNbcgJdsESci+B0uKEip1iNyo3w9vQRlzc0hcuYbqP/Dka+sXxw6qH
 /X7xzE8sOgI32NOiZOUiJFcsrN0X98pMLYItUL+qsWpzUyJabYYrTiIBbkKIDwgZyBmp
 3dY82Y7G4dmF6tje8HfxMk23/00xsXOi3HdyX6LYcVmTePUG/bHZffZDTbS/m0U7TkFy
 NKRQm6TKwcmNcQSmKeYRRwwS33lIxa8Nn48a1iTqXHpYUqh66sgBG6uEbVSGVWj/8OxC
 iE9A==
X-Gm-Message-State: AOJu0YwAzdfxwBKvIYyirIm4Mfr2mwQ1O1tiz7SMJDNX/G1G32/eqPo0
 VNV63lg8VDTSR35Fh3EG0lOT0gowTuVdg9B9X2QcaPrWhVTy0U+4HuXpyvccWwOmD+J9BZBxP0v
 88PoIB/86zYXixI6vCR2CdNyMbo/9QciX8vydKnXQHpiJe3xGfxALFCdJRp4QxGIF1A==
X-Gm-Gg: AeBDieuLPqCbyTr6t4vwAHag0MpBAQU4ocR4J8ZZVKfkS8rENFNbRaD5ss7YhMbrq/3
 uYriEn+T7VceL2IXETrSu6cRTysdbUGWRhrtDBKp1Xx+2Ph0LlB9bqtjtTlelWFb7TY6Q7wxeZ0
 RLaAF2PLnf9sdsPAmF4le62hw81w/icD4ydFXEuvXR7st/BjUZ0Vje5+HLARbiVamNNUDb1CfL/
 tmEizE0C8gQkmOUrIcEe8DwkcoxtBKk+3RnL+aOgNa0kM9DjogpgAKlfncdKb1xG8kqHF6K97tH
 2yhoyO6hIbKA9clT2tcl3vDnYCA6CHEEneChOh9dBvDiXCIIuLX5kTRdXMudzT5WDFU67BI0dvs
 6kmP+1Xkh2kyCVjM7nKACXAptDcIDL/3I4FPHgzH8j+G7+nhu1fmvOm24uksf/5OE3IK1z78=
X-Received: by 2002:a05:620a:4456:b0:8ef:6b87:5c5b with SMTP id
 af79cd13be357-8ef6b96ab05mr2013379585a.9.1777057894535; 
 Fri, 24 Apr 2026 12:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4456:b0:8ef:6b87:5c5b with SMTP id
 af79cd13be357-8ef6b96ab05mr2013371185a.9.1777057893963; 
 Fri, 24 Apr 2026 12:11:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90afsm2319567085a.3.2026.04.24.12.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:11:33 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v5 0/4] hw/riscv: Server Platform Reference Board
Date: Fri, 24 Apr 2026 16:11:25 -0300
Message-ID: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NiBTYWx0ZWRfX4t8lekp/BCuS
 PGLyk9w0vRx6tTbkyVvDsU8G4x5n0wf4stYQ9nKaw/h6HVZ3wMihM8Fau/lS0HrNNynxhfBdApK
 NgmmtnYUcaLL0ZP23Z1KvJVTqZnzBA+9AGruC7l3brhsLgPnptpcGhNG1ExgunQpv3mOwymoZJG
 jrywF9oKMrQMuYcyOFP83XUSF+vbCO7UmrdT5r+PFHSTjfSGGGkBJlEKvuRXCQd5x+6IULfVaJC
 r+Cu2RMCY1A6nN5qt+OrraPPstWhVO0Twfj4Kb2uKQW6knRUYuXIRy8kqhtb2bjtKCyHVtwABQY
 VMLzbP3UGPJvtjkVDhlInsKPXY6PsluhHQpeAqe5L9wdNTI3QGPmSQIbv3RxJWqiRlHHqmTe6nz
 rYjfXLDPVnCoyf5fCpPX81E1MHflaGee1Mg4bFE+0nif0kKZAd/onwMZnu4SUkicrMUd4BPutlN
 Au2tJttZ2KHTdNpHcng==
X-Proofpoint-ORIG-GUID: s76zNTlfiHuT2gkYLoF77vjaJiXWTZbT
X-Proofpoint-GUID: s76zNTlfiHuT2gkYLoF77vjaJiXWTZbT
X-Authority-Analysis: v=2.4 cv=eunvCIpX c=1 sm=1 tr=0 ts=69ebc067 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=pGLkceISAAAA:8 a=WhSmBARFAgjbNTCObPUA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Greetings,

In this new version the main change is that now we're no longer claiming
an 'experimental' support, like we did in v4, because at this moment
(well, when sdext [1] is upstreamed) we have all extensions required to
support this reference board.

Another major change is the rename of the CPU and the board: we're
naming both 'riscv-server-ref' instead of 'rvsp-ref'.  We're keeping the
"-ref" suffix to match what ARM does with its reference board
(sbsa-ref), but adding a longer name to be clearer about what the board
is.

Patches patches are based on alistair/riscv-to-apply.next @56bbd4f25c,
plus Chao Liu's series "[PATCH v6 0/7] riscv: add initial sdext support"
[1].  For convenience this series is available at this branch:

https://gitlab.com/danielhb/qemu/-/tree/riscv-server-ref_v5


Changes from v4:
- removed 'experimental' qualifier from the board description;
- changed CPU name from "rvsp-ref" to "riscv-server-ref"
- changed board name from "rvsp-ref" to "riscv-server-ref"
- former patch 4 ("hw/riscv/server_platform_ref.c: add riscv-iommu-sys"):
  - squashed into patch 3
- v4 link: https://lore.kernel.org/qemu-devel/20251111182944.2895892-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-devel/cover.1775959096.git.chao.liu.zevorn@gmail.com/


Daniel Henrique Barboza (2):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  docs: add riscv-server-ref.rst

Fei Wu (2):
  target/riscv: Add server platform reference cpu
  hw/riscv: server platform reference machine

 configs/devices/riscv64-softmmu/default.mak |    1 +
 docs/system/riscv/riscv-server-ref.rst      |   31 +
 docs/system/target-riscv.rst                |    1 +
 hw/riscv/Kconfig                            |   15 +
 hw/riscv/meson.build                        |    1 +
 hw/riscv/server_platform_ref.c              | 1371 +++++++++++++++++++
 target/riscv/cpu-qom.h                      |    1 +
 target/riscv/cpu.c                          |   12 +-
 8 files changed, 1432 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c

-- 
2.43.0


