Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C9BCD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZskr-0003ME-4q; Wed, 17 Jun 2026 12:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZskk-0003Kf-VX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZski-00011m-VT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:04:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoZcO1235878
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DHGZDPs6pcZHGbZ3+UoBP/
 yk9Ar1B3g2wubjLZFecnw=; b=hfacyXhimJ8x98O19yeSOPT7FVzjPEJImb5dqU
 xrsJ8Cvk8hsO3pkjP1DtBPhOGfV4LaTpycEcFodlS0LOCPsifGEGhQrYpDTwfmzI
 nW9/NXJuEyRQv37L83kwONaGHa2RVTlk5VVquAYazEaHohQstmDbk5DEo4VPcJd9
 0bDicjRfKTPlMql22Rgd++Cf/fymtFsvu3Gpu5JCmUcMVjH4XUikUyhj37cxqhzI
 9lF6oSC6X0qpZiT5NXuUCQdkgpsythTCcGXyhwtGaT9iYMEX3DaKO5Wc5RItZYSV
 zVifw/3gg1VLEU9iOkWyRs2wR4mrRxT7qy7Jsz1t2kzt9S4Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueepm19s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:30 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-48638069322so9001123b6e.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712270; x=1782317070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DHGZDPs6pcZHGbZ3+UoBP/yk9Ar1B3g2wubjLZFecnw=;
 b=geLwgyebIn2Kg2k5duqZ0a7N+mVuwZv6pjL/mKNqnl+bRQwJ4EJnyzg3Rzwnf2nQ2P
 5vEiC9c8z6dpcfEyj2yA8pUkSCtTfJ6VC5jsI/jlELclpsgoKQyOQv3GQxbZT3jMW6e5
 EvSSpgZZzTflYaOzHn/lcP4BHC10eBkUgQqNPG6Qx9eN2c/zENJqlEaVFdO4Wr0uRyEY
 HGWQu0BlZTnApxD7n1FsfkQ6zcW2jsj0IgFLqNnncCQrI9RkqypnYUEfDba6VxN9bKPh
 JYI0FiUV+hrSzttxDV/o1RVSPVbEeu5i5Nri+0jHoeibRHq7ohZj5Ua0Gy325rn3W1v3
 mNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712270; x=1782317070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHGZDPs6pcZHGbZ3+UoBP/yk9Ar1B3g2wubjLZFecnw=;
 b=JP6glV3gCteV1FzxEcFiRi6XrEf2g3zQ3f4iJhep40fejVZRlxcbFl5rq6kUoFI0Sw
 wf11ot3nOXRmEqi6fPDjsvkiaFUrzfrC+rLNHEtAKTFTudLt+aYLgRPBHoep7b7QK5YT
 9eADeqnnU1KVvISw/Mgo4dfQruYzNux5WrU3aDk2tsCAyj1Er2n9x6fHprQfGD6x5ObJ
 0+JzQGm8/pOHtvslnGR3u11w5KUdKMVTxLbvn2dk9SZs5gu6X1/rsryTMURVvqjLF905
 T5BYJBtRFouxBDwdh8VLhGy5kLVCDjbC9zux/Z6qZY267nD+w3ZSMdkldGeUrMx++0h+
 DCUQ==
X-Gm-Message-State: AOJu0YwZGP0P157v9PribfyhgCsxStonnLmeywSVbHKO8otRdrGU6C4f
 5Q0qcttwAgVZq1r01ta4wQ3tYAEuAtyLVX8xHulS56Bdyt8KgQmbzO9nOdPlTtCcJi2LtOtXMGo
 vYyazg//iKzp5/m/R8+XewmW3zlXr5I6S01BL4mLCV1scxoLq12Zj/GCi1AgfeSTb2Q==
X-Gm-Gg: Acq92OE7v+YPCvcSbg5n+7vm63RdCJ+DpYS8wlqAcCRxvhqX6xjPsjHObx37SwIuquL
 ePC5JXExSH6jCqY0/E6fLifo2dUlHWAEGQhHGmxpNkSeizEYuA3sXnqR5dG3cJQzD+6FeEhoEDB
 bKZDgAMszGQe/F2D6drHo75JuTPsBI3rfgywUjUON9ZEm23XV7uWBGPklIsSTEATI8v0KC8Yj0e
 ZM0miQD7GsWs4YhPAoUSowCJ+cwxg+6oaR+20Wa0erkaLcSPE8lTxElBRu+2om0Lhuc3fzg8Daa
 YVqjD8nbjtlend+pbsfwxkSOePoReo0zE2qmRWiGcICj8jsF90VvFf5tK0KWtyOxMq1FTXxPf1C
 p2kSjCJGznsuqrJpY56aLGtCXjOETFwrzR/NvodP1ncUa+jxwZVWR3o0rrO3GrlwRx9I/
X-Received: by 2002:a05:6808:c3f2:b0:486:8a11:6e8b with SMTP id
 5614622812f47-4894445b290mr3267364b6e.2.1781712269616; 
 Wed, 17 Jun 2026 09:04:29 -0700 (PDT)
X-Received: by 2002:a05:6808:c3f2:b0:486:8a11:6e8b with SMTP id
 5614622812f47-4894445b290mr3267300b6e.2.1781712269044; 
 Wed, 17 Jun 2026 09:04:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm162206995e9.0.2026.06.17.09.04.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:04:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/5] exec/cpu-common.h: Reduce header list further
Date: Wed, 17 Jun 2026 18:04:21 +0200
Message-ID: <20260617160426.64461-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AY+B2XXG c=1 sm=1 tr=0 ts=6a32c58e cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=vp90gTg1GG_4JgwcMaEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: 08F5JT36giG4nQahgjqsjQt1vMOPo0V-
X-Proofpoint-ORIG-GUID: 08F5JT36giG4nQahgjqsjQt1vMOPo0V-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX0a91F7HczzK0
 W0FqpxzHLG4O2XV6Llrf5nH+yREanzcJe4che/vpMGt0/pWN1KyEIqUY7UM1zu3PYfHILraWRFs
 L/mgJUNf83CUuTvHa17EYOSiYMKYDDBen1GHrfZxcz9MU3orFsymkw2bh3rGpe855VvA2CNQmR8
 rGUk2fr8Ljz3sw6a/PbRFQhro7CTiMw3LqJpA0BzU4JewaCBFfWxVes5du4sgX3qUmgdz1HIVDW
 IgFhdPdXU7hRuXkpK+vOBDl5xulzu3ePqnkVT0l/6q9uhG/Vg+///gk9Cr+pmL1QGvvwtgwUkWa
 HutDUCdzTM9ImIE5aZLcaqTSSbfp4JTBJ7Ye0aX92ed5Ofx31iFYLrGUUgr+xH450QyyZvZOHoe
 rJHZm4TQntkXTTBA6c4o+NAKjdP/qGZGoxae/+M3nOrmn9zyWeiy3LW+oaE01wInijQliQQHURi
 u4QM/ywmHTCdY3K2MWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX0C7WL5uZ90R+
 BGok08QK646O1aziZsldSLPXCK16MIZWJXjF5iWAi5oUYDV7VmUzCmrHZdufhFbZFtC3Mb29bK5
 WRxh3RJWdsa3BZP2MZgjY1vd6vC0Pt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170154
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

More trivial inclusion cleanups on a core header file.

Philippe Mathieu-Daudé (5):
  target/sparc: Include missing 'accel/tcg/cpu-ops.h' header in cpu.c
  exec/cpu-common.h: Include missing 'qemu/thread.h' header
  exec/cpu-common.h: Avoid including unused 'exec/vaddr.h' header
  exec/cpu-common.h: Avoid including unused 'tcg/debug-assert.h' header
  exec/cpu-common.h: Avoid including unused exec/page-protection.h
    header

 include/exec/cpu-common.h      | 4 +---
 linux-user/qemu.h              | 1 +
 target/ppc/mmu-hash32.h        | 1 +
 hw/ppc/ppc_booke.c             | 1 +
 linux-user/arm/elfload.c       | 1 +
 linux-user/hppa/elfload.c      | 1 +
 linux-user/x86_64/elfload.c    | 1 +
 target/arm/tcg/cpregs-at.c     | 1 +
 target/loongarch/cpu_helper.c  | 1 +
 target/loongarch/tcg/tcg_cpu.c | 1 +
 target/ppc/cpu_init.c          | 1 +
 target/sparc/cpu.c             | 1 +
 12 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.53.0


