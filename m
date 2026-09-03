Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639DAC79F80
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CDu-00017R-TA; Thu, 03 Sep 2026 14:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDq-00016N-TU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDo-0001aD-VI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683ICiYn566369
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+f49h1tJYraMoXjtRTeg18HHfqujCMQEdXK
 SplLEisU=; b=OhzZdNLfNeSGz2tcCvFACpA3YBup5g2XM5XX83RIEYF8rVCWfNM
 nS3J7AkM3pGZcy9h5u4Ol3s/MQ50nnXuI5s8f20dVOBn4yagQPmMlkzNhOyNCIoM
 KGXlRtPmpvkD5LBBQ8JbqbzyhsAbvO4NJj5Lw0mwB3ifYbbHPuFpEpXjTbeONtQD
 0AbFwFO+j4r9obI1Ew2rTjNTnkLf/aWtZpxbWjFIbxzlsCDxgs+FdH1LVE5ZIFkD
 tkB13Jzooq3dtlqEBCDw9tBHqsnl9C5gTzt2fmee8iOjX7tEw93+lfokIVhk80fL
 ts7+tODK10srN4IeUiRsnz/xamiGjoR8GFw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyp02sr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:31:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cddf4f59eso2961406d6.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460291; x=1789065091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+f49h1tJYraMoXjtRTeg18HHfqujCMQEdXKSplLEisU=;
 b=TW54qO7vhnuQpY85Gh1N6ClT4TPSJs6SU+Y7IB+KULR5hbm0Is6uo6CWWzlkRc1pFS
 SoIU42Wk29ILyLmaw97Rb6qWDOO0xXaMam1/YGqM4I5CaHJJq2TliIDtwmSCpzE+Zg4U
 Fpa/ScNd3dwUA2mJNAiuvAE2aP/9GCoICUkDdwdlP9LmC/kNO6QxnZW/9ylvwn480tbS
 sETfXcNv5STpyYYKvmnKBucggFA6m4XTceYLcTkClSXNrfAeqLWEy8wy7f9obkTPqTvV
 rZlo5PzNDeJqhxedhLDjIpXTjFv1hGqVNeXuSV/D6kZytFPr3Hx2xZsPa6OXfe8NY4x8
 bAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460291; x=1789065091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+f49h1tJYraMoXjtRTeg18HHfqujCMQEdXKSplLEisU=;
 b=ULwcwWujIwnYAFrZuSwnRkhsFFD515e/v7s4eIp+yncJH8LF77ys3j+aUCjI+4QsTW
 Yn8dAIxpvOeuruMW3LlcOC2wSzjXvAesHvaAzIH9hVErZJWLWcUZZrQV7SMjbcCzBUBV
 Ih/GEQlYgcakLQ6ta1pkRRsFbAt9Rl8c2Dd+bBv9d5bUC6m6wvDdTudFxabJ6cwGzHVQ
 CDz2a1h2yUNgpEdQMT+dh0884amu3SSX0lZtLDibqA6i6z/XM1TOP2LbuDhX7SKnP0Ed
 G4I89rBi9IwYU2+YdCYHvWqnkKUikX8+h6nPOjNMpsce1/QsjnVvhQnytuYoIj/mcr+O
 MJOQ==
X-Gm-Message-State: AFuF++mgsUyt+JOcAvf6MbH45ivnrh3IG2mRO2YUQ19SWjTlP62Vde/s
 kiBFehVmX83WtmO9Hyf01cXX1QQMK2oHq2eZeT8PAqZfu98jsNaTzaob8GJNC/fsnPPvYP50OWR
 rRUZ1poXRnJACvLl577Od5cROZZHY08PSMw/9tWtzK2/zIqCKSONF0RVhoqbk1+GZvw==
X-Gm-Gg: AYBFou2QLmE3IBfqaZw0uRMeJwHjqyMNxZlZs0p4rvoosOJGLxWb00edOPj7eUy0pPG
 JuM4GPherfY/vtqzTOXeY8PXY5uzyE5UxJItkTDWN0SD2QS4+yNn5VJ/79A/u2OlT0gXqYbQNf7
 KrbKvyh6PqqO16JXK4EMRfJJQLB1skT6YQlZqzd4nI6+m8ybS+2spr2gsKyI8rGpFdvTik1N/9M
 KqVs5Ossm9YL1i+chWP3AT1JQaKvUZccLwWXoQbWlam8LiT9sUgsVOm55VFFvhs51g4/iKkj+Yp
 iMbLTFoOTboI09O/gslk5dKB8PMPb7Dl/+ROlxvaZS9pk8ABMoXeGtv6ylkJ0OJT5LsUqsdPVjY
 ULiCKbfsZVr8KpkWcOG6sBgz5GLqxU87NT0GU
X-Received: by 2002:a05:6214:5543:b0:90c:e762:1f86 with SMTP id
 6a1803df08f44-9103f0d3e3dmr12562166d6.30.1788460291393; 
 Thu, 03 Sep 2026 11:31:31 -0700 (PDT)
X-Received: by 2002:a05:6214:5543:b0:90c:e762:1f86 with SMTP id
 6a1803df08f44-9103f0d3e3dmr12561196d6.30.1788460290572; 
 Thu, 03 Sep 2026 11:31:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693aaasm603596d6.34.2026.09.03.11.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:31:30 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v9 0/5] hw/riscv: Server Platform Reference Board
Date: Thu,  3 Sep 2026 15:31:20 -0300
Message-ID: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WmgIJENPzARCg_uUaq4SLKtvp9vjZtkc
X-Proofpoint-GUID: WmgIJENPzARCg_uUaq4SLKtvp9vjZtkc
X-Authority-Analysis: v=2.4 cv=Q5XiJY2a c=1 sm=1 tr=0 ts=6a99bd04 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fa7AMr4v2K1-DDA7kUMA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfXybz6g9anDPzJ
 p64ABFGjwd4CIbbDkzSvWvJ1MvmObVjIE1wxFRdRRCbMftxiezyz94+WacjLLpy/ZGuERpUVwaY
 xvKu2Ul8UkluwjVPfMq4pSRKTG9XHItFsdJXPOHUecJTdpyedkOwzKyuxe1r5hYMaj7Gk7ubXn2
 uOHO6cj1HyIDFH+h+bH7x14pVqQ+LyyNBZZpeg3lR6SB543QonhUuVOfskkILIAieDx2o9y65vZ
 RaQnpFf7PirjGeQc573GnSyG0B1zW5noLj0BXWuzjkgQf+8yRrxo/Vm1zFahrM9UwbJBSVNm8c+
 TRbpIOXDiYYDv8qpgi0ep7w80RQTCBXH2jB0AwAcCjMK2TtaBPfv88NsgS4/cfPA81VBFx827Rj
 6+SGT+GLSRGExZnbd1nhwjpd6Ovrp6jml1M68J+CDi68dkmD7c+4ypA5iFA4/VgqSwlpaPXVM/y
 37UDWaOed5yMGtU2RAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfX9EXEEKTAzgvj
 dViD3gOgtYVtuTfq2pnmmbCX4t9vJyhOmd84qYvJXjfyjBol341RLyR0xYhYzM+YqRaALMbvIBA
 JPK1LBWd28CKtIsmALlDULouWofizt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030162
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi everyone,

In theory we should wait for sdext ("[PATCH v7 0/7] riscv: add initial
sdext support") to land before pushing this board again, but there seems
to be a demand for checking the current state of this work.  So here it
is.

The changes from v8 are mostly based on previous work done in the RISC-V
tree in the form of FDT/device helpers, reducing the amount of code
repetition between this board and 'virt'.  In v8 this board had 1477
lines and now we're down to 771 lines.

I also squashed the 2 TPM related patches, that were already acked and
reviewed, into the base code.  We're now carrying 5 patches instead of
7.

Other minor changes were made based on v8 feedback.  They were minor to
a point where I kept the ack from Nutty Liu in patch 3.  This means that
we have all patches acked.

Patches based on alistair/riscv-to-apply.next.  The series is also
available here:

https://gitlab.com/danielhb/qemu/-/tree/riscv-server-ref_v9


Changes from v8:
- former patch 5 ("hw/riscv/server_platform_ref.c: add platform bus and TPM support"):
  - squashed into patch 3
- former patch 6 ("tests/functional/riscv64: add riscv-server-ref TPM selftest"):
  - squashed into patch 4
- patch 3:
  - using decimal instead of hex for RVSERVER_PCIE_IRQ and IOMMU_SYS_IRQ
  - updated mc->desc to "RISC-V Server Platform Reference Board v1.0"
  - use MachineClass->desc as '/model' in the DT
- v8 link: https://lore.kernel.org/qemu-devel/20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com/

Based-on: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com> 
([PATCH v7 0/7] riscv: add initial sdext support)


Daniel Henrique Barboza (5):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  target/riscv: add riscv-server-ref CPU
  hw/riscv: server platform reference machine
  tests/functional/riscv64: add riscv-server-ref tests
  docs: add riscv-server-ref.rst

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/riscv-server-ref.rst      |  62 ++
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |  16 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/server_platform_ref.c              | 771 ++++++++++++++++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  32 +-
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_opensbi.py    |   4 +
 tests/functional/riscv64/test_server_ref.py |  88 +++
 11 files changed, 978 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100755 tests/functional/riscv64/test_server_ref.py

-- 
2.43.0


