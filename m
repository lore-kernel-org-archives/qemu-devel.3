Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3702CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5E-0005TO-9l; Thu, 15 Oct 2026 17:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4D-0005AK-SS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4B-0002Q6-72
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDpTo2678099
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ERITuk7JhTz6X3yYuyn4C4
 PBHn6u9iRjv18DmeLWu0c=; b=BtLCm1GnqSrS8Gi6yZk9qvW4PAbZeFmPcTnuQK
 SOQWdljSCdsNRWq+vFd77LYJn5RiBrIdOlZQMRT93zkz/zpvhGIv79XUBpuoVF1y
 0KEImrIU35w96GXtjOJfVbt2V+o+Yua5lm8nBsB4Fyylv1HD8kLMfOkuqcIZddgP
 Oevn/AStwJMPyPtaCbRnLDFROUWOsgu0Esaq2O0M41vfzQ22vx5RZJBzCVJaZnOu
 JR1SI+egprcFYSyurB6As/+wI5UJJ/GG5fsYAhFl/H09MuUZUHpeFs1JUOao3RId
 Yx9K8T4eOuYLT/1wcZ980SwV28MvNTsfp9Qv9t0O5AiDjH/A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t9ed7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so402316a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099964; x=1792704764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ERITuk7JhTz6X3yYuyn4C4PBHn6u9iRjv18DmeLWu0c=;
 b=OJRgexKLB3N2ucILhMMIgZvfSSq7NuX87m1iG3EfMPwn0fLQ+aWtFFHbi2CdJgWUZq
 yiAbAuDaqt2+QVvEUUSEeTcVUsEjRQco7opEnRUrtSf/Sl5/O0U7+2FQy/FtxBlOseGI
 6wh1YNrvboVbksXrZFQcu4xN9G7Jwu82vqYxp0oZYKQMWZ8MMKTxFl4hvfDt61ThSzPK
 ttyg32Dmejlc0dk7mAoLf5dezgl62go2hbpVCKRHAhbzlhrhrwBbyZDCCyVpV3mKA76+
 lvqzTpWbb4DDHdz7izHXpKMHgLIiaHFd4WNtes8q42M6Mldeaddb9L8+C0K4ty5x5iyf
 L/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099964; x=1792704764;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ERITuk7JhTz6X3yYuyn4C4PBHn6u9iRjv18DmeLWu0c=;
 b=sFZAol1NJaMHrXmDZmMEvbB6LkJJyy2cA8NT6sTZeG9vlr4dOp38CkEOiF8MltxwmI
 qRF1XwFHK9qaEjBKoKRMU52SUctU1584N08eZiJ3yL9suRdqnZCd3ASgBzFDzqU7rljK
 hvA/MLryXrST9VMVRAOmqBaIoYkr67Pn9WtB9gptAfKykatDDXfM6YQ4QKaNNIVac+N7
 u90e7unm/ICxViTkSVBWiN1Su+3+G06vPvZORWMsKKY+J6Yh82NBf9d1xLfb5lV2IV3z
 hyAd8DACL4aYzRbGqDXxjVqsUiltlEKwG3MYOPrp50Ux+3Yv8BPkulfWmjhmhQdkP97/
 vRKw==
X-Gm-Message-State: AFq9FYLx7MF3zVGKT1LU2P6o8Q6ckaaQL5uBqz9eAu8AKl/XeiZBNEWW
 hKnK6b9CPm3AX3U+E/bkiUcW8xlXjZ51U1QEjtPwnH4zvJEEG1+7E8+HjJbriOiEyTj7CaPutHF
 UJwkC5rXmDaWVnbWdEtjfvKiLvThyvwMigM9p0yrvKdtzzsRCzxjtMGI0bSwPoBkm+w==
X-Gm-Gg: AYBFou0z7e92lADWMi/zwXBf+qKHe6B1w0pWuJa+PNndpoEit0Wge+tt2kzScMcnKIA
 7feBLFrNCD3Wo6BijEKDqhdwmf07XteGnq002gwWbK5LkXPDyj1f1cfTNAAKy/k35zel4z2Ipun
 iYKk9tg1F2KCKB1WfE10Efb9TkXoW2BwyTGFUl3lzyNsex2O4ASgh3vwHX1wyKYGOx6SzS9voO0
 1EnSIqquuVvaZ/wbY1nbyKR4CCjTGJX1NLuyymtP4R+v3eGuisGrI9U/oBQ3EBWxhlcu0hzeFky
 FqxrKp2n835K9JOgZCqh/0zG40dMJLihCF6NF6+XA7W/aCTNGpodfRUHugYkdzQsqdUP71C8Adx
 tHMu9B31gTT/PJGO9OLsQHRaJqycAi+AXpBiSQ7mxVAKqLuxOrW/deH9N7mO2aj0=
X-Received: by 2002:a17:90b:4a85:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3acbb68a0a3mr842082a91.3.1792099963653; 
 Thu, 15 Oct 2026 14:32:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4a85:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3acbb68a0a3mr842058a91.3.1792099962982; 
 Thu, 15 Oct 2026 14:32:42 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 00/19] multi-target: remove dump functions duplication
Date: Thu, 15 Oct 2026 21:32:17 +0000
Message-ID: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AwcDrpEFD1xBh7HwSEyQJOFB-6QsiqlU
X-Proofpoint-ORIG-GUID: AwcDrpEFD1xBh7HwSEyQJOFB-6QsiqlU
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1467c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=t-vqde0x9FpBrNXOGkMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX3pwZhr/DNlMM
 z0rmxHE40RX1QdF+9gEgBU4CXUB5ctM5JuzKEvTCinrAAJK9fd9B+XeaWEfc+HH7G+rDGv5lStw
 YML8HMMhuoAgaF1P2YftCivIZtec4p1hhs573BEhoRHYTJbo60VeRlFS1VfcwEcB4WYMuVB4BMh
 nv9+FEEsYZTLbP6iCyzs0ebBUbTfufS2VzvSFHyHZZeRSUHu/z5czki9ufraO/S17aE1upZhRL9
 6NSp1xOs1fNJQkvg+2PrOnRTOaYiFUoOaG+F8WM5MspfgfqXkfRcj1JBtMyZAbzHwh+Vn5ov4Pb
 CA8kbYE8sNPv1FmJv31FO39DpnlGGfLpg/uD0oYr2PECnWG9vrEr5+xa0ufmwllBMNpT9nh8HIT
 y8tnAPuSXTMSGFN9J0neMKlFQQvt5nmCiKo3RPBzy3Ty03NinS1WBKSk0sStgSBpVzz5SBtTz0c
 ymW0Z1paDgk4l9NE8Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX+vAFM3wZy+Ht
 /LgjwJjt5mrLhAfudK39UtX6yd56WoYxTIaFW9R80VH3ptWu6ZTXCb+y0LtK0WVTM1YDMerFCC9
 95T9ZYIKu2onTD21Z4rkPFRyT34dyRg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
target. For this, we define a new set of Dump operations for a given cpu, and
implement it per target.

Existing implementations were using first_cpu, which is what we continue to do.
When we'll work on heterogeneous later, we can revisit this to either forbid a
dump, or perform a dump for each target active.

Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
"[PATCH v3 00/12] multi-target: add hexagon"
This base is only needed due to conflicts with current wip, it's not important
for this series implementation.

Pierrick Bouvier (19):
  hw/core/sysemu-cpu-ops: add get_dump_info
  target/arm: implement get_dump_info sysemu op
  target/i386: implement get_dump_info sysemu op
  target/ppc/cpu: constify cpu parameter for
    ppc_interrupts_little_endian
  target/ppc: implement get_dump_info sysemu op
  target/riscv: implement get_dump_info sysemu op
  target/s390x: implement get_dump_info sysemu op
  target/loongarch: implement get_dump_info sysemu op
  dump: use get_dump_info sysemu op
  dump: remove cpu_get_dump_info
  hw/core/sysemu-cpu-ops: add get_note_size
  target/arm: implement get_note_size sysemu op
  target/i386: implement get_note_size sysemu op
  target/ppc: implement get_note_size sysemu op
  target/riscv: implement get_note_size sysemu op
  target/s390x: implement get_note_size sysemu op
  target/loongarch: implement get_note_size sysemu op
  dump: use get_note_size sysemu op
  dump: remove cpu_get_note_size

 dump/dump.c                      | 21 +++++++++++++--------
 include/hw/core/sysemu-cpu-ops.h | 14 ++++++++++++++
 include/system/dump-arch.h       |  3 ---
 stubs/dump.c                     | 27 ---------------------------
 stubs/meson.build                |  1 -
 target/arm/arch_dump.c           | 18 ++++++------------
 target/arm/cpu.c                 |  2 ++
 target/arm/internals.h           |  5 +++++
 target/i386/arch_dump.c          | 10 ++++++----
 target/i386/cpu-internal.h       |  7 +++++++
 target/i386/cpu.c                |  2 ++
 target/loongarch/arch_dump.c     |  7 ++++---
 target/loongarch/cpu.c           |  2 ++
 target/loongarch/internals.h     |  7 +++++++
 target/ppc/arch_dump.c           | 14 +++++---------
 target/ppc/cpu.h                 |  6 +++---
 target/ppc/cpu_init.c            |  2 ++
 target/ppc/internal.h            |  8 ++++++++
 target/riscv/arch_dump.c         | 18 +++++++-----------
 target/riscv/cpu.c               |  2 ++
 target/riscv/internals.h         |  5 +++++
 target/s390x/arch_dump.c         |  7 ++++---
 target/s390x/cpu-system.c        |  2 ++
 target/s390x/s390x-internal.h    |  6 ++++++
 24 files changed, 112 insertions(+), 84 deletions(-)
 delete mode 100644 stubs/dump.c

-- 
2.43.0


