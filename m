Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4847C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLK4-0002on-BO; Thu, 16 Jul 2026 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLK2-0002nw-Hx
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLK1-00077p-5G
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBj3TS2622222
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xkIcgkaglkv
 u8MJa4e71VTaUgHHqAhF1ueh5GEJz5a8=; b=V1h2XD0EHd8b7I6fPjEWK/oaDZx
 kUw33P0sdob/nz2dcK2Rb6JzMrAlosW5m5/vqaBShHUTT0g05rPRXAkHtn643w6f
 r+8F9MEZwk1fGJKBtHunEHwayGmWQBPzx1idufj7FwygWmglucXqGGvwlnUyLDGz
 tPIjnU7oT9edCRQLye8qG0FUmScIAHzUvuX/t13VT4p30Chsqijs5N38ZDWhkewU
 Pchn7kwg0GUgJ6qdqmTBft4pqx97NJFyjLoJJhJFNbFvMk1eGE3j031wP2pOXcPr
 O3WBOvMWSx+NaRMlAmH9CgK/1f+Jub0t6vy/EUncqafT2WrkjwTR75bZ5CQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqktrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f45dde7595so38300016d6.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205372; x=1784810172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xkIcgkaglkvu8MJa4e71VTaUgHHqAhF1ueh5GEJz5a8=;
 b=QzJl4tJu4mp2vIa/5qlrRD/mtm8+2gMDtz/8NSdmgo2xH3ZAvgSCGlq+kGtchUJCyg
 MPBfxjvJOnvaarcUHVQD5BAtAZMcj+Kfjmsm9j+GiQoy78bbxP2uHQKa0MoW82dY2Yjp
 vMLAUs7tioS/c3f3E0lFWX9PraOZBaS4+8ZpJw6Ypxh0MUU7ikaWqC42uf59Kd6jJzMP
 H9aEQX+D06iDImhg3OYSkh1D5Amz1qJ6R8tLb9Qr8Ow7VhW9HXWUkOcoPaDjmkRy1s7c
 yCgjUr4pfAXXlUmyT3b5Hqx5e797y7RsCznjb+BtN1n1b8T20KqtHldmZlCTnt+jyxks
 RSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205372; x=1784810172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xkIcgkaglkvu8MJa4e71VTaUgHHqAhF1ueh5GEJz5a8=;
 b=FV96o5EHTrkjf52odW63j74vk9ZHaKb1u/xwf8XSejQSZAp2Z/1XRNAUKgiQujUT1I
 qHqupswoiW8NPX0lD9lfkhuKk9DwNCYl112vvxhl96fBH6nT5juwO0EGosEFWUXa/BR7
 4hK59/m+xSKJEIda7DJ7iPcgTNP5EkNnEQBCvimIvl22Me1z7xueu1IELtxgGtaqVL/5
 qoxdKeoQTCLhDF4CIc6vbmpvgu/RjQXyFeNIIv8TpDtuhmfIoScNYM25Cr6bZdju7rga
 OwrfCwkA54z0iJ/mFqs6yBHmfaVna4kmg0jdghJHlPpSNwssRQSYrnQWRfa0uwRgVYnX
 idxw==
X-Gm-Message-State: AOJu0YzxqHV5EbW9OYIBa8HNRAnWlcu0UPcEqEhAdT6q/6P/91f2wNSt
 dR0iyTgYysKaYCrcvNu/RiFqDFLsutzxhCBrQi6YMgZFGxgdjpdv5u0x6Miwa8OdxVbsLYoo9B5
 QsXj5aqE9OFBKFoHCK9PDK1vTXgo8sgIlFt4TPhXFZVcRKd0tbwJHd7GlNvYwRrjKGQ==
X-Gm-Gg: AfdE7cm9e0LSpuHuYAyuc3VtxepGRsBTbj0QO/zoC4lXrAshd72MV6S3JTvyo58Cbm+
 3rm18MSse7VzTWOfuPhfYX1k6MbC9C4el6nThCdQ4b/RYLezKqsItVT3A+xmUiv21krtB5sgr33
 lynNGanBrKec4xtc1mXGIJQBowWo49WT118Nj60obKz5y1MjFpEXZp7VoLLw4gK6dxLo1G7AblP
 gvrElq44k+MoQbm3I/zGvY180uF/O3Mm5TOE4n8FuVNrZMYfPEIJ5Qta9I1ThxIBnAaYoC03q0g
 iva7DiDaPGv8qyXR1chUXGCUub+5jHL0pZ2WQiM+70GxIemh9MXeb8oQmI6H6sEFPskiY7Q/7d1
 zJvbyy/zZxz31UhuW0VZKHyZXOn7+hp9+WFc=
X-Received: by 2002:ad4:5aa3:0:b0:8f3:6c2:222 with SMTP id
 6a1803df08f44-903fec4e811mr252348266d6.14.1784205371666; 
 Thu, 16 Jul 2026 05:36:11 -0700 (PDT)
X-Received: by 2002:ad4:5aa3:0:b0:8f3:6c2:222 with SMTP id
 6a1803df08f44-903fec4e811mr252347736d6.14.1784205370990; 
 Thu, 16 Jul 2026 05:36:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:10 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 11/17] target/riscv/debug: Put mcontrol load/store
 match address into tval
Date: Thu, 16 Jul 2026 09:35:28 -0300
Message-ID: <20260716123535.3709148-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58d03c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=1fLd1apDblQkEOP04rUA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX9EESY2Vt+Xk6
 2DlDjXxjtTIf1xouSVrW0ld2819vxZMNKjwuj50fsjjmBdRIx2bg8DznbOmiVlxiR//NSSiiUSl
 nJLrGGpYEimZGrboyQV/xEMURKFH0v4=
X-Proofpoint-ORIG-GUID: Np96Gy5Iu4z8pkGsXMZ9YD7_iwuT9KHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5cAnlALHNR51
 5m3d8ybNRju5B3QfY7XCpfOeGzF1JKWUsJAsW2eeWx5yEbbaIw5mTi8yFP7gARMteV3lTkWQTnY
 iRtUuidQT/53oAgcObVKtYzFxKsZgTSE1UzV7iqVSqzbD57EzDT8N4l6H8cKNaEjEz6XfnVftB4
 VStBSLyse0MmH+LJxLJ2M2InCHu78HRGfej9xXCKMIoNkLYAhv4ZV3kAEDzxMmSIGOtDXoixvlY
 5PbtCX2Cvel93MgZ2weJuC2jxidodi8VvwVylYWcEIc4MgdGj/dB50PeMVmZ5FfuyD9SkLNhVAa
 QXi4G35VQBpBmQfu1LCu9Zx29Sybk6lgD5k6Z9FbrdLOJG/jnADj2VBkBI6dqp2mZ06siHqBniL
 wzKge5Qg/FNaYTyg6e0RUA0BV2jynagpNpNMH3GXvZerbDW1poLEdx8Zrt4UDBX0t93kYfaY//n
 9ewSHB6kAZSLpbU2H/Q==
X-Proofpoint-GUID: Np96Gy5Iu4z8pkGsXMZ9YD7_iwuT9KHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
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

From: Nicholas Piggin <npiggin@gmail.com>

When an mc/mc6 trigger triggers on a load/store and raises a breakpoint
exception, put the matching memory address into tval, as is already
done for exec addresses matching.

Tval for breakpoint exceptions is optional in the spec, but it seems
more consistent to implement it for load/store if exec is implemented.

Fixes: a42bd00166 ("target/riscv: debug: Determine the trigger type from tdata1.type")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index f671ae67f8..7ecbe01fb2 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1077,6 +1077,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
                 if (do_trigger_action(env, i)) {
+                    env->badaddr = wp->vaddr;
                     return true;
                 }
             }
@@ -1095,6 +1096,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
                 if (do_trigger_action(env, i)) {
+                    env->badaddr = wp->vaddr;
                     return true;
                 }
             }
-- 
2.43.0


