Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80449CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8fz-0006wS-N3; Wed, 14 Oct 2026 19:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fw-0006vs-Km
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fu-0006Q5-72
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENQ9ZC584445
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=53stulzU65xHIpKL9pXmh6
 5q2cstW3gHk9e4NG53Emk=; b=NjB2h32Y3J7LIGGNkfvw7u8mY+/dA4zXHdKBKD
 9yvlbbAuJsmSK6sdicr3toksIQA76K+rkTd0Bzy/kDY50CAMKUW2ok4UZSsCv31E
 8L8J4vPUUtnCGqCMS73b/eoZCYbdEBhrjMNjA8w3Mn6lldGGwGiyYMu+YymQqPaZ
 X0CQmi43T6Q42JLmXcsBzrKLu2dWsiUY/QvpJyb0hl+AZ3iTxeICDGXwYKBGTqmp
 GqmzFQdYOJG/+y2InE4Q+I7eSZ9mXOaISJmgZ2XvtopkKYR76JRxnHLczlKMB9BR
 RQOL/+bAmUzKz2PYE8Jta9aHqqRuVa4Am7vQfP8gxecq6lTg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakder1wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:19 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-155a75f91e1so1011959c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021579; x=1792626379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=53stulzU65xHIpKL9pXmh65q2cstW3gHk9e4NG53Emk=;
 b=a1jCTQ3RK2baYyul3aLCH7Ngpwb47pWa8INAssR3SiMZ/WNJjjBv6mf+eGyQ763iMS
 zL9jgPloZnNwDqn9aiLjQpogbZ+PqWxClD0lRJ9KLmU43t8s979B7kUAXSyLSKQP0pON
 U6RiYCUoxWNDCtkUCZ12rBHw9dcBPknasihTSJXZVbKKbfjuLmfEADOIGKOCGy7JBr0c
 Jk59gKRwbdW5n+v6c4jYmS7M/CyNGwmj/8UMm3XlNLfNU+rixSVzdBWpfXZNmWR9RYQ3
 9vHTd84Wwjii1IVge8J8YlsZaak53HIpOwuMvNB5VEPZ66hALwXPfwAUL5I50OiBe9+z
 24sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021579; x=1792626379;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=53stulzU65xHIpKL9pXmh65q2cstW3gHk9e4NG53Emk=;
 b=p8Hg200UGTUvcd0KK8nyF4JTcOb+/5gwqrVPjyB5UQAiX3y7I+qpwZfJJivmM7c11D
 GEOxvsBHJ1lySzvIvHywhZEYFgdVF3qQruJCouHnjFdkEcFOTURivAwU+8uSMeOAfVVz
 MgoNzIUkqFfHUgixna5BYxxJuka2rJilrsdSjcvSjInW0Q7rUO8KqCOPy9trrzpFBvD/
 g1Wf0p4PrWPk8WpS1Ic1XpRFMR5KjkepVYQ9gNO9IbUUARa3VRolDl/e9z6wVLsIkBKy
 aSn8WLDLw11wL/7jeDiFfs4PL97Yvb1erndZJqnSyqO30IbQF1SDcvlzOew98wDhQWmT
 RWhw==
X-Gm-Message-State: AFq9FYLNwOhMdF0dpC4UJ6wMbau8WxxqbIslM4ywvQNL36/70dt5tWFm
 RHo5l/AT+M/r/99bTPCO/gAiquNngOIPf4TJO2WNMJ6PopRlHZQGWGsVtcpmn/e0FIZIB/JbaLC
 jw2iKCBVYsHKy9xxz/aLit0eTst/vHdFc8hqbBWSfJ0uTcfY1Q4cR+Q0WBTsBXR+RfQ==
X-Gm-Gg: AYBFou0LkbqA0lfKAhF/MZkXYxVEPT65Kofc++MmvpycRJtKfS1b+8gSvb+WtnI0FlQ
 GOo9J24kty8+iJZmjqP39ZDq3YJu1VGdRt+PT1Htpab1cywNlI0PUqAlSEVrCdXMgm2Em4NZFkZ
 hWwOlLs+eW0rRu7lRkR9cIqXVQcpsYZPISaKyjXI8ltubDbGtNvJWEy/mvfqHeSwVBBFoNhhE/Z
 q0kj6UJXBEBTZUFz9juQ7KXCHatNfalf5Kj1a22wyz0GcpMc75mLn4y0idSXHzi0XoXnT9Y7ESD
 2OQLobmvY/TCQ0C/LR+U2OZlsMilhAHGrvp75KnRtfWZymO+Rj5h5cmbKdTHUXFeHs0Dlj9aBvb
 K8nmp09uS1dHd6Trlt38sg3KWIeJmaaxyz+n2BalGBcKrWIw5c6c96z+NVWb/
X-Received: by 2002:a05:7022:170c:b0:145:5c7:7185 with SMTP id
 a92af1059eb24-16a10f299a3mr21909192c88.5.1792021578485; 
 Wed, 14 Oct 2026 16:46:18 -0700 (PDT)
X-Received: by 2002:a05:7022:170c:b0:145:5c7:7185 with SMTP id
 a92af1059eb24-16a10f299a3mr21909165c88.5.1792021577853; 
 Wed, 14 Oct 2026 16:46:17 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 00/19] multi-target: remove dump functions duplication
Date: Wed, 14 Oct 2026 23:45:46 +0000
Message-ID: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0144b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=NzbRU2VOdh9feMWdkocA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: IGNOgmvKVYc0fLcVCv4Y8z_02cZeCdWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX6h/3OCZWezjK
 ZtK93JvV/eG+bDeEvgI7GXECJVVkcg41XKSCiUIR/tsS3c6RkpGmJp9wN/75gYmfJGJKnZhELIA
 Gnwv3nrWvoOFMwOqfPSseYYwFLtzWkeYoD6bP+GD4A05FhkvY/U2GyYSGfjcIZFWzj4n7zDWgtu
 S2useF7Ip+gfcptdBMe6GAG5KzZwfgeNZgfoP6NcB4sUH5e74rgryVrX2K+N69Q2jZ1LJP/h4zc
 qjEy6cP6IAgckzKiItB5Xblx6loubrgNUz1/5XWRGJFr7hTaCLol13MIXiVFkze5F/+/3W/N4Hk
 4Qh0kX41SKwNNBBtQy7yc/YBCjkESLsDceRq7PCZz3UnUxD2qHEUAzLnAdzUaYUsE6BfwMRf/fT
 yy8Ym3sSc9DC2r3xyuGFN7UFmvbl/5iPWjCDvF/FxhSKvJslKI0aiDZoII8U3DFgyD1t6QPEeqS
 nwQPIYyDeLDfcOkY3mg==
X-Proofpoint-GUID: IGNOgmvKVYc0fLcVCv4Y8z_02cZeCdWu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXy/hlwn2Zb9RE
 bv7/fYdsZ198LMIBYtB9fVdn4gCrscIzRsTGm4h2R1NVgXZ2xJmgQzMbZYn1BPMPGmP+Jw/GimL
 khlXnL9W1j7csOUvgtyvu1eUVnqCL9I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
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
  hw/core/cpu: declare dump ops
  target/arm: implement get_dump_info dump op
  target/i386: implement get_dump_info dump op
  target/ppc/cpu: constify cpu parameter for
    ppc_interrupts_little_endian
  target/ppc: implement get_dump_info dump op
  target/riscv: implement get_dump_info dump op
  target/s390x: implement get_dump_info dump op
  target/loongarch: implement get_dump_info dump op
  dump: use get_dump_info cpu dump op
  dump: remove cpu_get_dump_info
  hw/core/cpu: add get_note_size to dump ops
  target/arm: implement get_note_size dump op
  target/i386: implement get_note_size dump op
  target/ppc: implement get_note_size dump op
  target/riscv: implement get_note_size dump op
  target/s390x: implement get_note_size dump op
  target/loongarch: implement get_note_size dump op
  dump: use new dump ops for note size
  dump: remove cpu_get_note_size

 dump/dump.c                    | 21 +++++++++++++--------
 include/hw/core/cpu.h          |  6 ++++++
 include/hw/core/dump-cpu-ops.h | 31 +++++++++++++++++++++++++++++++
 include/system/dump-arch.h     |  3 ---
 stubs/dump.c                   | 27 ---------------------------
 stubs/meson.build              |  1 -
 target/arm/arch_dump.c         | 26 +++++++++++++-------------
 target/arm/cpu.c               |  1 +
 target/arm/internals.h         |  1 +
 target/i386/arch_dump.c        | 18 +++++++++++++-----
 target/i386/cpu-internal.h     |  2 ++
 target/i386/cpu.c              |  1 +
 target/loongarch/arch_dump.c   | 13 ++++++++++---
 target/loongarch/cpu.c         |  1 +
 target/loongarch/internals.h   |  2 ++
 target/ppc/arch_dump.c         | 22 ++++++++++++----------
 target/ppc/cpu.h               |  6 +++---
 target/ppc/cpu_init.c          |  1 +
 target/ppc/internal.h          |  4 ++++
 target/riscv/arch_dump.c       | 24 +++++++++++++-----------
 target/riscv/cpu.c             |  1 +
 target/riscv/internals.h       |  1 +
 target/s390x/arch_dump.c       | 13 ++++++++++---
 target/s390x/cpu-system.c      |  1 +
 target/s390x/s390x-internal.h  |  2 ++
 25 files changed, 142 insertions(+), 87 deletions(-)
 create mode 100644 include/hw/core/dump-cpu-ops.h
 delete mode 100644 stubs/dump.c

-- 
2.43.0


