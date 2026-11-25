Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EC606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xn0nGN9V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eFf7/oS0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCvY-0002Rd-3E; Wed, 25 Nov 2026 08:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvU-0002RN-OW
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:20:44 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvS-0000cI-LX
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:20:44 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mNqY555490
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/c8KOt3pZX8naevWJKnwHj9QH40Vq0onuaj
 Vg/XZDpc=; b=Xn0nGN9Ve0xc/FK1redET0z6AGFrKN5HF+IWCExqLcCn0P4qt8h
 xoOdXwabKZujRwp86UihXD9HmbOsRpdZ32TvycoIpRQ1qj54PwpU+bkAhwLs8BHN
 DdUZCsiYfLQLJLqVuYbjvPfNRF45SExkjVI+0MgdYrRdxdrKOuakn6GUCPguagFr
 UrpaiATEzoRuERnt2o1q/dVoO+y3/vVdzR4Cfo7yTETtKof0KVKT0MBmzEYL0cAn
 SWfTVzYdeFCLseFsRcxWOxM2u/Zwk5Du8PZtFDh0USF7I/luiVG6thuLrujlgcfA
 GNXL6UwFp+WHEml36rlEoFkeZ2KDntC/0qA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnryhq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-920f97bcad4so100147636d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612840; x=1796217640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/c8KOt3pZX8naevWJKnwHj9QH40Vq0onuajVg/XZDpc=;
 b=eFf7/oS0tHpMJfOUYLe9veKCbcKULRDau8FjvCayNhQY+GJavd3AuBh4Q/fO9G2d2Z
 ZTxRedOJB36w0cmdfAeeArxCl8384bgFOOfo2f5bayBKlsDVQf9eEc5o5XDrI3SoLCF9
 uuk4cjEDXjbocVO7uNglfn7yQ4gfv/RHeE3f/dYik9rlreHxM3+mPaH2szwwIAb7PpGO
 N0YIg0SgVo7SJTvPvowbJMBHKQhPJ+iUTxylDZE2zruuhGV3PkJ1WxZKeiC16emu20lX
 MtIzomVBrJWwTZDxum0/iH2Hrv5AV1Bwe2IWeclKiHy3ev3svoG9k+9uij9Ar2cDrg7e
 Ma7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612840; x=1796217640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/c8KOt3pZX8naevWJKnwHj9QH40Vq0onuajVg/XZDpc=;
 b=yweecA+c3UomglworYUg7KfQFMfwcGwB/hOstbglh5Dkp0AXy88zNXW++qCx7kk55+
 9sVVrB97qGiHiXCKFGhB4VrCHFAE+fFFG3Hi5UuuK7bLIJvYIGAw5nFPQzK/G4wIMrRK
 lvZSopO1u88wktAUqFkJWy6/mpZCQhfr8EsE1wzwwNx7JtPK8ber5IOy+0XIy/FMWerZ
 CBNpXxh4mncNRva7VWnzfja3Jexj/XpgZ/aek3USH5wwCuwM1I5HhN12UfC6Q6B2p1oM
 kFFWY8t2InH22C+1LgilN+UoDvrMD8xOcjLyunDdUzeNzjohg6JedRbolFRWi3xEqpaQ
 VS2Q==
X-Gm-Message-State: APuU4Z81KHH+JxmNKeYcckdWx9yHlXh25SYK515lP3VigKfewfuhWwYz
 ND71nqSKk85ziD0VNpLq/mfcy4pHE61pSaabeCmxjOAR8c2DHulPIYMso/Klnl9/mremzbQ54Er
 P2IQo23MKJ/2613KXnSPFa5/Pv7wH2Ujw5F8AnlEF3pSMIqarRl3R6WCyfNXjWeWSSQ==
X-Gm-Gg: AZFdTZdzxLrm3bGqPOgaynyTvjFxEwSeG/ArWoiH6LQQg4DgybEMelWFgUjWnPZI2Dg
 aYfjhvvq3IreWQxa7PoQhMhoA7vul5t+D+Zo9oTtPPzrUXPxe0vRlB3CbG7czzbZUHCW1+OF9y/
 z8ad/kv8gbRq1qoOTGs525Wk3XGaKwbSfc8ktMsbtSlb1p0eVqQIvz/6GLXmDZvm8OC8Dsht7Ze
 BVwTx7HkCFrqh6Ocl8vtKTgdnU7N2ePPN1kda3DOSAcV2mIdW2XYQJcmbfANSJVhUZsn9poMZlY
 ZiGD5qZj1hemt2/+NAm2NXVbUHVnZgmB4cqp7TgwJYNQokHl28fcvA+rHx9SdDYFIvz7UkvxK1T
 S3H+nGBFO4B35P74f1U5Ikh1qEnRWLIsedQ/I4cj/KFxEBNOf8gj1fH6Z67pDDLslvDFfffLElc
 AqkhoeJ9y3LQ==
X-Received: by 2002:a05:6214:4e81:b0:921:2e16:c325 with SMTP id
 6a1803df08f44-92134aef10dmr277628196d6.26.1795612839827; 
 Wed, 25 Nov 2026 05:20:39 -0800 (PST)
X-Received: by 2002:a05:6214:4e81:b0:921:2e16:c325 with SMTP id
 6a1803df08f44-92134aef10dmr277627836d6.26.1795612839304; 
 Wed, 25 Nov 2026 05:20:39 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:20:38 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 00/15] target/riscv: gitlab fixes super pack
Date: Wed, 25 Nov 2026 10:19:59 -0300
Message-ID: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX78eu+0LSmABK
 njqshdCP6FYjYYXNSbLyDAkjt+xROWD73F+FD/Aa5KN/U7M29S0XojI+mP4FHO2zRn8+jajQ5Cw
 OaPSNrTl/waCJz9O+wPjiBJ7oEglNti00MSEmuawVjAJCq+TFBJY15NnaLFEbSOCWhmuER0yYSo
 Zpsa07JJH7D1eDSTl0gGrKaT9VOw4xSkI048ZUYYiUtYv90TMUyX2FBvG66go/EJZafj/j1+f/S
 gNKvamL+Sy8m070nKa7UT5gdoV4jXioLM2mx2bnteCAaSPfBeiTPLKO/TAJuwAzHNcmAkm3ZRkG
 Nljt610P8DClT/+CBG6/mgPT5EbINg9LnAS49TI8UlIr4kxa52IXcVIsP6iUVmJNBz2Z87rFcMj
 J5IxMGvvMaceIcS90u06e/3i9rfVcvqk8lDMSWExsFPQhmAfwkO8YIBRKkYu3wARECSLDNQmA+Y
 Ip6RClmqJYhXOS5L9gA==
X-Proofpoint-ORIG-GUID: EbgrUUc8OsQ4gtpakIDVOO4UsoFv2YtS
X-Proofpoint-GUID: EbgrUUc8OsQ4gtpakIDVOO4UsoFv2YtS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfXwZ0WZKmsze/A
 Rm6Kdnvra9vM0I0nY6U6C1u5GpT28lwDDCQZzr6vfvyjB1qEqX1DdNITbL6QjHpvp9Yl/KKeJrI
 nQVajpnjSj/xgVmKUEsdzi+0m6M0MkQ=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06e0a8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=CFW21O7Hy6Q10OLQpGcA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250052
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Greetings,

This is a collection of gitlab fixes I've sent in the last 2 weeks or
so.  They're scattered around the mailing and, to my surprise, they
can't be applied independently on top of alistair/riscv-to-apply.next
without generating conflicts with one another, which is quite unpleasant
to deal with.

I decided then to create a super pack and send them together, hopefully
creating a better upstreaming experience for all of us.

The following Gitlab issues are fixed by this series:

https://gitlab.com/qemu-project/qemu/-/work_items/4821
https://gitlab.com/qemu-project/qemu/-/work_items/3526
https://gitlab.com/qemu-project/qemu/-/work_items/3133
https://gitlab.com/qemu-project/qemu/-/work_items/4592
https://gitlab.com/qemu-project/qemu/-/work_items/4591
https://gitlab.com/qemu-project/qemu/-/work_items/4593
https://gitlab.com/qemu-project/qemu/-/work_items/4596
https://gitlab.com/qemu-project/qemu/-/work_items/4216
https://gitlab.com/qemu-project/qemu/-/work_items/4826
https://gitlab.com/qemu-project/qemu/-/work_items/4811
https://gitlab.com/qemu-project/qemu/-/work_items/4488
https://gitlab.com/qemu-project/qemu/-/work_items/4827
https://gitlab.com/qemu-project/qemu/-/work_items/4818
https://gitlab.com/qemu-project/qemu/-/work_items/4680

Acks given for each individual fix were carried over.  Only the latest
version of each patches was included.

Patches based on alistair/riscv-to-apply.next.

Daniel Henrique Barboza (15):
  target/riscv: do not write SXL < UXL
  target/riscv: avoid amocas.* x0 clobbering
  target/riscv/tcg/csr: filter bits when r/w HVIP(H)
  target/riscv: fix hedeleg writable mask
  target/riscv: clear hgatp bits from write mask
  target/riscv: allow hvip.VSTIP writes when (m|h)envcfg.STCE is set
  target/riscv: allow zicbo insns to run without RVS
  target/riscv: filter out reserved (m|h)envcfg.CBIE value
  target/riscv: sanitize mnstatus.MNPP field
  target/riscv: do not write RVG in misa CSR
  target/riscv: do not clear mstatush after mstatus write
  target/riscv: clear mstatus.MIE if mstatush.MDT is set
  target/riscv/tcg/pmp.c: remove no-op in mseccfg_csr_write()
  target/riscv/tcg: refactor mseccfg_csr_write()
  target/riscv/tcg/csr.c: add mseccfgh CSR

 target/riscv/cpu_bits.h                       |   9 +
 target/riscv/tcg/csr.c                        | 187 ++++++++++++++++--
 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  |  15 +-
 target/riscv/tcg/op_helper.c                  |   5 +-
 target/riscv/tcg/pmp.c                        |  62 +++---
 target/riscv/tcg/translate.c                  |   5 +-
 tests/tcg/riscv32/system/meson.build          |  30 +++
 tests/tcg/riscv32/test-mseccfg-bits-1.S       |  69 +++++++
 tests/tcg/riscv32/test-mseccfg-bits-2.S       |  56 ++++++
 tests/tcg/riscv32/test-mseccfg-bits-3.S       |  56 ++++++
 tests/tcg/riscv32/test-mseccfg-bits-4.S       |  55 ++++++
 tests/tcg/riscv32/test-mstatush-clear.S       |  57 ++++++
 tests/tcg/riscv32/test-mstatush-mdt-mie.S     |  55 ++++++
 tests/tcg/riscv64/system/meson.build          |  62 ++++++
 tests/tcg/riscv64/test-amocas-x0.S            |  49 +++++
 tests/tcg/riscv64/test-hedeleg-write.S        |  57 ++++++
 tests/tcg/riscv64/test-hgatp-rw.S             |  61 ++++++
 tests/tcg/riscv64/test-hvip-read.S            |  41 ++++
 tests/tcg/riscv64/test-hvip-vstip.S           |  65 ++++++
 tests/tcg/riscv64/test-menvcfg-cbie.S         |  82 ++++++++
 tests/tcg/riscv64/test-misa-G.S               |  51 +++++
 tests/tcg/riscv64/test-mseccfg-pmm-clear.S    |  63 ++++++
 tests/tcg/riscv64/test-mseccfg-pmm-reserved.S |  63 ++++++
 tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S |  75 +++++++
 tests/tcg/riscv64/test-uxl-sxl.S              |  59 ++++++
 tests/tcg/riscv64/test-zicbo-umode.S          |  98 +++++++++
 26 files changed, 1437 insertions(+), 50 deletions(-)
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-1.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-2.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-3.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-4.S
 create mode 100644 tests/tcg/riscv32/test-mstatush-clear.S
 create mode 100644 tests/tcg/riscv32/test-mstatush-mdt-mie.S
 create mode 100644 tests/tcg/riscv64/test-amocas-x0.S
 create mode 100644 tests/tcg/riscv64/test-hedeleg-write.S
 create mode 100644 tests/tcg/riscv64/test-hgatp-rw.S
 create mode 100644 tests/tcg/riscv64/test-hvip-read.S
 create mode 100644 tests/tcg/riscv64/test-hvip-vstip.S
 create mode 100644 tests/tcg/riscv64/test-menvcfg-cbie.S
 create mode 100644 tests/tcg/riscv64/test-misa-G.S
 create mode 100644 tests/tcg/riscv64/test-mseccfg-pmm-clear.S
 create mode 100644 tests/tcg/riscv64/test-mseccfg-pmm-reserved.S
 create mode 100644 tests/tcg/riscv64/test-mstatus-mnstatus-mpp.S
 create mode 100644 tests/tcg/riscv64/test-uxl-sxl.S
 create mode 100644 tests/tcg/riscv64/test-zicbo-umode.S

-- 
2.43.0


