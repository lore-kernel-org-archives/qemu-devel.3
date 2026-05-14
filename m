Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813A7CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc16-0006hw-B1; Thu, 14 May 2026 15:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNc0G-0006Xz-NE
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:45:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNc0F-000719-17
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:45:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpHJ24020724
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=n1s2CiM8pmB
 j1c8z53v9TL88NxuqzoHNU834U6m9e5M=; b=XDauWz4/Hsg1bZwBUNQItL0z3+S
 it3Odo7HvbEwCzudyB3vY6Mp0AL6ZYMYl/WJ2DnMj2FPqjG9OIx8d+PdBcUD02iW
 hTAK8CNnggnTS1zPTldr6CUyy2ikEzkZKS7MShmjP/sx+jkB39AQMycE3Metc309
 4QKpUabD2lIc+1XKh334VhFFFDUPdAsQVMlSjXnDDyHhPnH2PZ76eG8K8mIVMgRT
 aH3VZse8tsqMS5dcvWnMPJ7IUGHUuSWSg8PciackdglUteDhytm4oA43m0P31M6Q
 QV5+o4b2H+U0BssGnWQ83MQ9YHs0YtKTxPxhp4SRcoafgEWiCF5pispRqGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rr5vn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:45:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514a182b90dso73641161cf.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778787948; x=1779392748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1s2CiM8pmBj1c8z53v9TL88NxuqzoHNU834U6m9e5M=;
 b=hQnF20PRHbSB3EY+dRslsvg047OVoZZDcECURXTx9brsq4D7nZA1FRHdlJl5GgSJbC
 uSgVbumoJSG+NzF1Eg7xweGkBZ1C9RyULRHQ/9MGgms1+z17PsuLx+GVFp3rXMXDD9V5
 h/ISNKo/pljJS8YZ3tagJIzbNYSRz2Q6PtiV9z5e1WeEtTCQLQkaXlg1SBBJfzZRvrsj
 rMU8IcSc55c3U2kz6dN7H/zHLUrdnyqXfcdQ0Og67dKornVM3xroS33rYBr75gfJPps7
 RqhyZy9/s1YP/RQZLSumncpBwwc2iau26perYdzT8hVwHA5k9nrSjpOjCUa3GVgViR0b
 5pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778787948; x=1779392748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1s2CiM8pmBj1c8z53v9TL88NxuqzoHNU834U6m9e5M=;
 b=lrqCsRkIgUWu8k8/fDOpCFwjEATSE9cQM1wng9G9ssaYuDWZFhiK4LbRswc35o3eQd
 SiGrYn2h24rfS7XsBvU/wKKo3xwQnWkoeha6eBh2u/TtUDkMtkKUVxLhlqImAdIPU6z4
 ZYtpxHSkTh9AhTZucKWxKzXzU73bsi6s/DM1kPdYadX+kOvepxGMAE7vTg8L6Z1qhtjt
 C999BJfdmJ4lxkbjJh0Cl7OrDvQcggcD8aZclvz6ka3sWc4OlOw1kXo3OmfA9Q3AUiiz
 +5jfr5S13MYxWTM3OLgZB1FZF6IAZ6BnWksRePtCyYxrA1STy306zOqGuE4/XTWy/nC9
 LM2w==
X-Gm-Message-State: AOJu0Yw6iKq9bYg4OMuwhWgMR0C/qvL6tCA0wbdqffyi92y7lzijjxUs
 AHQ9F4lC8onuu/jUzpEAYe2S8ZDSeJoPHss0NVLiZhMz3BickOC0MNS1LvCewAJP31V3co9mRFS
 kc8a1ZTZOKZYDRrHTMVeGQobDIcayvImVgbe9itF2OfX7VX8uCXpg/Oo6hXV1KI9naQ==
X-Gm-Gg: Acq92OFyhqrqV3WRGpiZ0F/bx9rYfqIaQEXHUzC+s7YIHgktt1Nc+LhMH519s+yZVfq
 9Ewi4qn40jYWZva5Y+6YkyLL+IDDiPWh/2f9gCnQy+kk5ZVkI/AtL0W6IqVeczGHAdxMK8SoOXV
 8U9GnnSTIR6UMdSCMsQPCQau1XiokiHB3pRWQGYhoIXBOUbMr9lGtPuEQYhCZ/r+wSwD7AaOOZ7
 BPBwy53JKFNTu0HsqJEBvb8TT5Jjvep0pYr/Ak4j+Vx4XLToycG3iZxD00H8oPHup+jfysM6udP
 PiUJkuU9rKJgXNzPCVxIqPe1EZ8Aw80CV3HT6PWvK5mg2AGaFWL7Y+NBd33ljoxQ2SIj8AXiYlY
 t05mFd/Wo4FmZPseZ6KjoGMaBp4fZuzfLQ/bBaxPrN3kWOIyrV+vv/o2OzfEt
X-Received: by 2002:a05:622a:182a:b0:50d:9931:7054 with SMTP id
 d75a77b69052e-5165a044bd9mr11629871cf.15.1778787948390; 
 Thu, 14 May 2026 12:45:48 -0700 (PDT)
X-Received: by 2002:a05:622a:182a:b0:50d:9931:7054 with SMTP id
 d75a77b69052e-5165a044bd9mr11629141cf.15.1778787947804; 
 Thu, 14 May 2026 12:45:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5164581aed3sm24430151cf.23.2026.05.14.12.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:45:47 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 2/2] target/riscv/csr.c: fix mstatus.UXL reserved value
Date: Thu, 14 May 2026 16:45:37 -0300
Message-ID: <20260514194537.2416243-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
References: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: id5uFtF8jI36NlkEAcptKUe77-v4dvs3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX4zJ8tdDgRTk/
 54KaZBzqS+jFHIBv5Fyuh+bhednRSqVDXoUiW6+bQzeWfkOn7wNi8oRrsUtpOJr55cNE74GByRB
 eoz+UK4TpnwJtPCnEj/TT7fMeSlf4di/ICvNxcIJxRkH+exWNizdFQq76vPICBOJA/sWVKsewUq
 mMnPZPrUaWuAJsuXZ9LL2pERLw7IMmS/PFyLlhw7A/zDShdnQcKg6mr0NHyzMSNZeJALz/zCOqx
 n3n802K4NClBLJR1DuEl++WJT1HHA+K6Liu8GQ0RdYQaVhcslqQozewAuB03mB+F9G4jP+m5UBI
 2zGJ7T+YWJ0VIbyhKEsDWwv93thuMJLEzjC8aZ50Y1WGBvfvZx1CJtvPvDjXcAPD1yrHz/XmpZK
 0wVdV13c6ZACDIxkcmqUiH9lLYZBwzMltTfK7kthe2eEGYu+s7TIn8R00/5n8+Qdi49li7YlW7j
 u2r35sGyW6sX9qE/xtQ==
X-Proofpoint-ORIG-GUID: id5uFtF8jI36NlkEAcptKUe77-v4dvs3
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a06266d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=R31RJeB9WGHZhYVQSUkA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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

By the priv spec the value "3" is marked as 'Reserved' for mstatus.UXL.
Handle a mstatus.UXL = 3 write by writing the current 'xl' instead.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3367
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/csr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 74f5f868f0..53bbecb617 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2041,7 +2041,17 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (xl != MXL_RV32 || env->debugger) {
         if ((val & MSTATUS64_UXL) != 0) {
+            uint64_t uxl = val & MSTATUS64_UXL >> 32;
             mask |= MSTATUS64_UXL;
+
+            /*
+             * uxl = 3 is reserved so write the current xl instead.
+             * In case xl = MXL_RV128 (3) write MXL_RV64.
+             */
+            if (uxl == 3) {
+                uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+                val = deposit64(val, 32, 2, uxl);
+            }
         }
     }
 
-- 
2.43.0


