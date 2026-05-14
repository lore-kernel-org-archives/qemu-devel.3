Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156C4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc0y-0006fF-6w; Thu, 14 May 2026 15:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNc0F-0006Xi-CO
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:45:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNc0C-000701-Oe
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:45:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpc7P718282
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z492g0DSsM/
 a0YlmlQ6uWDNuHpYisjmu0AMgNAbIJ9M=; b=OcE08fu6teZ27EuTkTPNuXsfCPE
 s2TjbQ3/jr150oUJLu/Cm00+d4R0Tm8CXe7DXPR4VS921VFGLd/ey0gPQKH/XRj9
 iPfVjpGYMfKN2yOReq79+/cVnk+XJVcdc2EWAiyig72R+AUmFOv+sVpbDdaR8QMh
 e70b+Sib8aUMEX8WLyaJbkV50309I4lp7ei8zYGGuEz3wzbXbWv6DCR79s410qzx
 fBe5vPxCs+B0bvG0qAP1fOr88W8OvUt3uK4PUaGrZ982Kr22dTeE2JDDjNYBKQHd
 iuiVnUtEoBdKs1gLecHpmCM4qh7F7ZlLd/rTVxCXczHgxwXGKnY8rmwexhg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1x057r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:45:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d890580e1so145308151cf.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778787946; x=1779392746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z492g0DSsM/a0YlmlQ6uWDNuHpYisjmu0AMgNAbIJ9M=;
 b=GLrmeIGK5A02YqlBbyC6Bx6bQ1gUGphiSVwSC3a5U14fVMpz9IPrHmOzbkUctoTdW5
 J/QtnG3NwzekNBbMu10D38NBZX3PzDFUSimNW1do8wW0DkzSW4lpCZ6g8Pb2RvpvPnNG
 /KS/LfdACN9PsrEwQECZssJ0hi6tTOqbQPQ6sLTNtJ5txEl6UzkHM3t2PO0XTDszbwUW
 OrwCYbiVfiln0RC8/E0uwI6qFHzw8Rh2ORvHAl01FcjpBeWT/HZb7qLeYFQbuz1wmjLG
 Fi7G1s7+FE7HZKbeuq4yq5/f1edjmlPCtfmW2NI/8OaoQICa9ONubodYk6OLEp78pcjt
 Dhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778787946; x=1779392746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z492g0DSsM/a0YlmlQ6uWDNuHpYisjmu0AMgNAbIJ9M=;
 b=VkX10AbX2i28zdEKaYvXE6RKDyyWrhhuqUbTCmPN88Qzbn5FjxOiCfKomsAKA1AmzY
 Up81QI5hhIlJN/k2eEZBGoMc+0LJ102D2mXs3MJesOiwrxzOR9PFQjtY9AwpJKymIyu1
 K4NaaXdHkx/DYxYGP9/usgUnDlJ7YvOmHL9Uzl0NCiTXqgp7ajz0+SaaJFrLY+u9Xrdt
 VUnHdRRZtMT01XXshoaJduDPqbR1owrKKEjhqdqwCUfgFqdYsF1rvrYojuOq4mDCfhuq
 7mjd53NRWPhlM5yQZp1cRqVenuFBax90eFnky3czuKxDlG9awHD2lriLW5wh+kOaMKur
 Ei7A==
X-Gm-Message-State: AOJu0Yw7lP874T20ldr3yF8ZqwwMcVIzGQ5VKmvOBz2FQ1Plaf8hB8/5
 9FkWvBVwvzV7pJUozSq0loW7NT0FcWF2W0U/zrBc4lTH4ZLwAgQAwGhU8ZhcWwtbZVyqHWQbDoZ
 iipriGYu/Y1nqTvA0mWvSotgIw4SVcSG4MinJ3CNC/7Q0fACaMS4lznzT47WYlpeveQ==
X-Gm-Gg: Acq92OHHKxtX1S3A0m9sk2+VUvBewzmdE33sbv40kK0/fPKh3k0JOUV0O3d4akzPiT9
 dPFpgsAyg1hAjXBBhwvZQaWxsr7Ev/bsZ2AlexVtC75bXrvwcN081DZBGmTWLAD8avUopWPD2QR
 B49eZk8d0uZQQ8buYG5TI5AKak3w05heyVFXQnw+CCK7KTkm/yCD4/zawSByQza5nODPkdm712D
 fV3z4UkZ9sjor5rZdmRquUuPgYJP5d/IXwRoER2kD4O7uBHlreQ9B3rvrL0smatIWOrBwuxLeED
 0SxRmNP13sEu6FcXfsktcJMVUgYf2SxCkWvkDAeycH7TdG44jzOUfabaPdSYYCBxFmyqZz8fsV+
 AQZl4TDl7WdnZwqCXtx579GIf5kUmn5iNoAU7sc37Ik9k6Ge4zU3gzOC8m3a2YiwRBSjYbWs=
X-Received: by 2002:ac8:5d89:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-5165a01227cmr10839021cf.9.1778787945839; 
 Thu, 14 May 2026 12:45:45 -0700 (PDT)
X-Received: by 2002:ac8:5d89:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-5165a01227cmr10838601cf.9.1778787945302; 
 Thu, 14 May 2026 12:45:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5164581aed3sm24430151cf.23.2026.05.14.12.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:45:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 1/2] target/riscv/csr.c: do not allow mstatus MPV/GVA writes
Date: Thu, 14 May 2026 16:45:36 -0300
Message-ID: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
References: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX8Do36NVqoHdl
 B+GxC0tFa1NwHqHlyoSq9bautsCOpzmNtfDQbYrUhcnsu0x74kQAZip8s6+59mJnZczRcjLT2ZB
 mZdxBf7DG8X50C7R581p7p5rbtby0XK5z66raZtH5ysA7dJYzFQsvMp4Bx/Vh5XvW5GnWxe6D6f
 +rT4S/bLIMVPsgBKcWEgVBZO2TU6XfbwEXIoRyG+JKli+4WOg2iLHK+fY0D3D5VG3Xe9yC7Wr4R
 RhIL1ZNtp/UhWEEHHFW/YYWuImmNWu4NjbnaftiboAu4Q4mEna5j/wKV/Z8N8NjkHcOzPdKssBF
 gcwxyGHvG5YwNVf2NcwQPn9EgB+zd5w+ucwCkvji3rpk+Oq5YrVFq0hX4aw5R4fr/9EPzyS+G4l
 aHB+StafsfsOlXPhlPRSpHbC0dzn+ECJP4EN1iQ61slshoXjiAqeCrQrfrUMt5XnM0zxNMWBamq
 /929gZJLRs/4okJ+iBw==
X-Proofpoint-GUID: qGfO6GwFuF1J3uo-gd9c4xGTznYjB-nK
X-Authority-Analysis: v=2.4 cv=GL441ONK c=1 sm=1 tr=0 ts=6a06266b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=PzhdRgvD5jmBYmvSnGgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: qGfO6GwFuF1J3uo-gd9c4xGTznYjB-nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140197
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

The priv spec states the following about mstatus.MPV:

"The MPV bit (Machine Previous Virtualization Mode) is written by the
implementation whenever a trap is taken into M-mode."

And, about mstatus.GVA:

"Field GVA (Guest Virtual Address) is written by the implementation
whenever a trap is taken into M-mode."

Both are written during riscv_cpu_do_interrupt().  They're not supposed
to be written by userspace.  As far as write_mstatus goes these fields
are read only.  The same applies for mstatush.MPV/mstatush.GVA.

Fixes: 03dd405dd5 ("target/riscv: Support MSTATUS.MPV/GVA only when RVH is enabled")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/csr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1cd4a299c..74f5f868f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2040,9 +2040,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
-        if (riscv_has_ext(env, RVH)) {
-            mask |= MSTATUS_MPV | MSTATUS_GVA;
-        }
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
         }
@@ -2079,7 +2076,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
+    uint64_t mask = 0;
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-- 
2.43.0


