Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D88CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbytm-0006h2-4f; Tue, 23 Jun 2026 07:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbyta-0006de-QQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:02:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbytW-00066G-HW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:02:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NAsgw83582623
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VTGkAAqPBzGluCPiab/B5v
 MxXekWkb9qKi/y3skYJ+E=; b=hfD5MwmRrq5FuO7EEDoa+gFf4MHU5e6FHygclk
 rIf4TqPN/taFTpGXW8H8i1/MQABYFm7A8XceCRuuVEACMFvxqhozyJDXAXOfBF0V
 prhxV948cmfRoGqfUas613wUDeQDaLjlsHELr6tmjrD0V8NegovO7EVZyvG6Iokq
 VAloAK29uPN3GKxc78LhE0y+E5Gk2wOwyat7Ob3AEXO80hK6tDb87TA+SiuWdHKG
 xyaPvA27IRFAOn825xuFZK4HKScKgvB9wiOqR8agy8kfmQyjpxvE3z/8ZW2XcyJf
 nghbi/vsKu/tvIBvyuusmVSeyqkzIWoYWAGX+xhDkEBkH0aQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729v3fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:02:16 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6ec7ce0b2so4243114a34.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782212535; x=1782817335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTGkAAqPBzGluCPiab/B5vMxXekWkb9qKi/y3skYJ+E=;
 b=BUxpwoQnUJUzLke1Ob//3VlVC/MqVU/LJ5W2TCZRNzgFMR3YlGmznt1Kj04m8qysG7
 U2nDaszmgHJcUb2T/173CHK6JRduHsAZ795yoYiCQ2Hi1Emyn6SlcX3TE/dF7mrb5Oir
 zfvAGxR0GSYaF19oJQI16y4VEF1+VIO34DA7IJ0cdDH/8CJJGX5wEXASuA0AerYBig7S
 gOAFe8LFeOsL6OH5whDapC6ZCm+PiCOYCg2E7P04OA8dDPTqePmYnTuudZ1hxJ1jJmSq
 xcbsXvBJOaVWQPbBzSILWXsoXMaGvbsjYA2omojb3PbzR3qOkrBjpsJIbFV1I6tkHf5y
 RaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212535; x=1782817335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTGkAAqPBzGluCPiab/B5vMxXekWkb9qKi/y3skYJ+E=;
 b=JVixPCys5EGY7ZSrdEh6X3v+jBE8emLaeESIsf5jGjH8qk+PRGH0RPkWKre3LIjJoG
 0c2gqJzeW5N8OutSO0Lnp+/H6PF634Do6Qlu5oy4TyZkybZ1b4ycQ0YmBytH8XsQTiQw
 WQNVgkszxRxm8XUks/0/88jx+7k93YXIZgo/o0JejWDUXsoaclf5SxYYM9oYDzl84BWV
 8lEEp3F3wD3yH+P3TuwYHrzrfPRIzSMOZLC5sQxb1wBtDFnFusasNnQhgJQe5GUzp3y/
 4IVUAbcIejvxLcpgf8ZSVGXisZVJ3wzloi8CiNut/YGHOket18uIkgDuGFgCs8shxnT4
 yGhg==
X-Gm-Message-State: AOJu0Yzn59PaIU32hrbFyu4NoZVPcZSfxfwikmQKhuwvmJKHlOnJeRYS
 lM3L2VFBLw6R4Efz/k4zN+5cK3VoP8oFZ5F+dkRap0kR+orDiti6EJVmLO68S8F2k9Wo6lSV0Bg
 yPK57NkD5urF7ii8zlUJoSwMHhX3Rwss209xPCoRAjKGbstNHbThfUGunE/RczYg1HZ8+
X-Gm-Gg: AfdE7cknZCosbbQWk24g75evGYnQqi26ogO95yjFJ3FsqMgjJ/Gu+qt71wYgHtyMb5S
 P5yTGk23mhIDTokzWek2GucwnxhIrB5lo3eJ2TO1E6CPJRwmUUgDH4V4aEDIMm1as11k2bbZHGb
 TQjb5eUolIO3IwGdLnNs84dSpUa8PLSJvyeU7vg9XnsDsyL7ji3k7tmjAzGkHFf4r3L8mxhU7D8
 NLkzeSDB+p3f79SF8mPXnXvtNqk6wg5HWaWR8wQ4WDCOaxO8qM2KRtiTqcO6oLcHDae8mC3IY5F
 AScNpw4Q3B/l4Y0i046ZSPNHNl/vwugMyaTNJs6pYemt+xwZtJ4zmy8iBbLZvObRbd+8UKYz7vR
 LzHtDnvIw6CfaL5AClfg+WlI+LGLBkd/tUg2QNQ==
X-Received: by 2002:a05:6830:6d05:b0:7dc:d587:af3 with SMTP id
 46e09a7af769-7e97998fc31mr1514668a34.23.1782212535481; 
 Tue, 23 Jun 2026 04:02:15 -0700 (PDT)
X-Received: by 2002:a05:6830:6d05:b0:7dc:d587:af3 with SMTP id
 46e09a7af769-7e97998fc31mr1514610a34.23.1782212535002; 
 Tue, 23 Jun 2026 04:02:15 -0700 (PDT)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5ddbsm36315212f8f.12.2026.06.23.04.02.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jun 2026 04:02:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH v2 0/4] target/tcg: Rename some helpers common to various
 targets
Date: Tue, 23 Jun 2026 13:02:04 +0200
Message-ID: <20260623110209.26861-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfXwzUkibiui5TD
 Z8SMWe+RmveeRVzfeUlYWvj0VRnNHDwfJX8SpGVD4QaE3rTmHuKyrowHptuCJnLROY3EJmFik1O
 7E9cgXbaXJ2DxRucWBJMz39ZSlMbLxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfX9FeGBJqtBFfP
 eWic9xOcs05cfH2E/t+v52i9MFu8E4ecsj4I8GstCGMvOoRn4r2xaA/rfsXvyg4oCooXJOifUvY
 RQ5dfuqxAtkt5fMFsRaJI1/ZK5ufv0keCseSpe6+M9djeADx51y0D3hgoDhLGtvUSVZUwOGVKr1
 L+kRWXtyzMs6AE4eJZNFBeuZ5FfRluqka5tshUgbr2Jr++2UmOznoJwIX5lbAGdH+YqCVdopGpI
 XLDBLfa9u+5X1tj5/U/g2mThjbCyTGP4lIImllW3iyy4mNmjVJbRngWq0/tFzF2W/zn7+XYa4g0
 acH3oadxJySUTtN27DReoKUa8MYWc3QiDHB7svrz2LoqI4UO8UIAgybukvdIPTUnb+oKFbg/tPE
 n0tIdCymx8byteh/Pcsszq96DmZRYCR3M66mhkRHyBbWFycJTy3/jZ0nM5aetFJtdMZXxfR+l6Q
 HS4a2XfrJMdw68Be80Q==
X-Proofpoint-ORIG-GUID: A_VOw_nD2HdUBjyb5wD9AcLBCaSjcIyg
X-Proofpoint-GUID: A_VOw_nD2HdUBjyb5wD9AcLBCaSjcIyg
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a67b8 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gCilnUSdiZWjTjviJ0MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

TCG helpers are declared using the DEF_HELPER*() macros
which imply global symbol scope. Unfortunately when building
a single binary (containing multiple TCG 'target' frontends)
these symbols clash.

This series takes the dumbest approach, renaming the symbols.

There are still around 20 symbol clashes (usually FPU helpers),
but this series is good for my proof-of-concept.

Since v1:
- rebased on b0df6e2f2c6c45df8d4d286933799c623e124d98
  (Merge tag 'pull-riscv-to-apply-20260616')

Philippe Mathieu-Daudé (4):
  target/tcg: Rename bitswap() helpers
  target/tcg: Rename crc32*() helpers
  target/tcg: Rename raise_exception() helpers
  target/tcg: Rename set_rounding_mode() helpers

 target/arm/tcg/helper-defs.h                     |  4 ++--
 target/hexagon/gen_tcg.h                         |  2 +-
 target/hexagon/helper.h                          |  2 +-
 target/i386/helper.h                             |  2 +-
 target/i386/ops_sse.h                            |  2 +-
 target/loongarch/tcg/helper.h                    |  8 ++++----
 target/m68k/helper.h                             |  2 +-
 target/microblaze/helper.h                       |  2 +-
 target/mips/helper.h                             |  6 +++---
 target/ppc/helper.h                              |  2 +-
 target/riscv/helper.h                            |  2 +-
 target/sparc/helper.h                            |  2 +-
 target/i386/tcg/ops_sse_header.h.inc             |  2 +-
 target/arm/tcg/arith_helper.c                    |  4 ++--
 target/arm/tcg/translate.c                       |  4 ++--
 target/hexagon/op_helper.c                       |  2 +-
 target/hexagon/translate.c                       |  2 +-
 target/i386/tcg/excp_helper.c                    |  2 +-
 target/i386/tcg/translate.c                      |  2 +-
 target/loongarch/tcg/fpu_helper.c                |  2 +-
 target/loongarch/tcg/op_helper.c                 |  6 +++---
 target/m68k/op_helper.c                          |  2 +-
 target/m68k/translate.c                          |  2 +-
 target/microblaze/op_helper.c                    |  2 +-
 target/microblaze/translate.c                    |  2 +-
 target/mips/tcg/op_helper.c                      |  6 +++---
 target/mips/tcg/translate.c                      |  6 +++---
 target/ppc/tcg-excp_helper.c                     |  2 +-
 target/ppc/translate.c                           |  6 +++---
 target/riscv/fpu_helper.c                        |  2 +-
 target/riscv/translate.c                         |  2 +-
 target/sparc/helper.c                            |  2 +-
 target/sparc/translate.c                         |  6 +++---
 target/i386/tcg/emit.c.inc                       |  2 +-
 target/loongarch/tcg/insn_trans/trans_bit.c.inc  |  4 ++--
 .../loongarch/tcg/insn_trans/trans_extra.c.inc   | 16 ++++++++--------
 target/loongarch/tcg/insn_trans/trans_fmov.c.inc |  2 +-
 37 files changed, 63 insertions(+), 63 deletions(-)

-- 
2.53.0


