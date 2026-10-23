Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21329606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fATeKO26;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D6FaTewk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwG-0007AG-2F; Fri, 23 Oct 2026 12:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvi-0006n4-Ez
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvd-0002Mk-RG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3n043811775
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 whmiDBCYFtk1aYI0J1wKkIRSGWXQoWkFP17+e9eDX+I=; b=fATeKO26BUs7bUB7
 FFhxzl/TEHbg1gtY32wLXeAcjwor1BLWZNh916KrWrxLeLDz0twsRkVIDLXauTwJ
 CjkCDxiSjOgJCTPEU++Jy30K7J5Y47ICOpG47sq+Z3e1tXO94//AY/evxuenF+81
 IHOBl1OKgqxW3qQfLCX43/fvFgCTARIm7b8wlaotOsqic20hn7dUpIMwN2rHI/re
 wO18Tf8u0/88XIcSAVU/Ya19GXmjUC94SQMLuy9IGZLuL6C1q0LJMl5zh0dMb/C5
 H1OXrxCDCsxf40Mz2VKY2js5fsv/RSaPn3GpICXzAyYJ/bonNCMEglIBKDW/KYeX
 kI2ijA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas881kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so209009585a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772134; x=1793376934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=whmiDBCYFtk1aYI0J1wKkIRSGWXQoWkFP17+e9eDX+I=;
 b=D6FaTewk2MxHAftsSvapPWFhF5d9epFvmdfmVEWTOeybkatdh7VNW/2gT6A8dOMN9R
 Q3Esg/xgoagSKgtVqeUgZbu9I3Raz5rieoX+o1UpN08MGwPVjZiBPgDDX778PyCHKAig
 1f2eWtmRYA04gYM3zVCHYTqn9HymSOzOtvf5FXw+Y71ugQiLaGAuMeIDwPGPWzdhXsb0
 CICy4iO6oq5OyRgl7pJx9pyiTPYVxl8uYMoE/ALwwYUstzJIQz1271DhCrP1ujUzmXSV
 GZyXGuZxuIw1bE++BVA/lqOhcvU/W+2bX327n+6PsjuZ352kFU6zWgoKq0bGfgBDPmnH
 lGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772134; x=1793376934;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=whmiDBCYFtk1aYI0J1wKkIRSGWXQoWkFP17+e9eDX+I=;
 b=kK8CDiBPL3eS+iRtivAEkTg4f+D5j3HNfFC+F057nCIdUA00InnFHc/hH6g8rjgkQO
 MDWISlWP/NhZ3oxXru49IsBUviFk2satio7olBUlTgnVqfQqJErItM6bP36Z7d6wC9rT
 wjk6Fu7hHCMA2muVb57qztUCxJ6+OenA0p5DgqFue1p0YuzkyB5d06BrcAlbEqbuLC5l
 +D0B4J/KzpG4krEwOZbo3tVfgMzzm6Su4lESGU8kec19Ufd3iHxiJTtGn2m11uUTabo0
 8PB20CvBHOG4uiJguKFhBYlFwEkZgjyaPEqfi5UpHlK4WD0oTqwVwyODZSkZl2qj4klf
 5JeA==
X-Gm-Message-State: AFq9FYIbpkYcGgFo5haBE+7JOQqEA2G7cLokeVO/SIWUSSTg+5fXcc8r
 +tOCYKEsV6P2C4IqB6wThhbLJ2CKA3bXcABAEl+I1iNAJ44F7LB6mkBvO0UOX0Y3WoguIalcYHO
 fzAGJIanvFkCzwJ+9jcB3h2Aws2KK19UQUmy0nTmV+iByoX7yVrc+LOMViMZ62RynyfML
X-Gm-Gg: AYBFou3qjDHuTzZQKBnEBCqaB4HJHmFFjC/gfmJu5kwLZ+F8Yp80VfBnU+gmGG9C7sY
 Zmkd0oxX7C/fgfgSdIhHgtXIbGoLYkG2+MeMP70dxHYWvX8cOnoSdIZNKTlHK81YSRw1ulP9YLW
 k2kO//CipZeTsavzX2F4+mrWqtzkvY8mtuh3O1PasLiz+BR8tw0gD7akvHIgFzu1RipCdx9uuBp
 lwqJHSG4uPMC/MHeoeuH1ci3bQQ6hBsQWFTK38T7FUQjOp0MPTzHUFTKttX8SK2ABwuMBwfeZzH
 FIA1jVUx8l+i7AKQoV08F7/7gz07j1x7hJuGCBXKO4FjrMI+lzThzujvFSkgjXtLkVfx+Sy9hJF
 0PsQzgDD+Fj+hMW7CFlEC0vgrqjot0YZ/nYIEUn7X
X-Received: by 2002:a05:620a:4402:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93f6f7890cbmr488818485a.25.1792772134107; 
 Fri, 23 Oct 2026 09:15:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4402:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93f6f7890cbmr488813485a.25.1792772133530; 
 Fri, 23 Oct 2026 09:15:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cdc0d1dsm15441035e9.12.2026.10.23.09.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/83] target/riscv: Replace gdb_get_regl() by
 riscv_gdb_get_reg_mxl()
Date: Fri, 23 Oct 2026 18:12:24 +0200
Message-ID: <20261023161332.60153-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX+8PZKTNRj+gI
 tdMeRUX/LPRL+cdDXPOP7CIxTBgZvwON2Gw+Jug72TkQMjhJ89iHix0UdUZGhSkc7gNvWMEbZRM
 IuIa+Wg8qR/98McvrnBHGLUZFadnoL0=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb8826 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=hwDxwncWfiQWgMtNzUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX7Auv7Iq9+OpI
 jS4i51nGevITOKedzeiUNxedOGlxiWnGV2l3zU6AGP7qQYYic6SiS3cbCTLcm1cEPdfKLS8+NiF
 G0Aa3mqAVzl7pAoCLAvMUjw59PSbRq4oo2Zk0Pr7pb/1EjIGeXJfHdahMF6Am93RAssjFzq1f+N
 A5w4Bn7nJ1lL8mVeg9YmLyOJhFl8zdr/b72+0KBRW+owt+xz4ofALbyNhY70vNl/BwzXN6KmP+H
 eA4MR3e9+39sWVoGQho0vuCHRapPq2/B0XMOHpLSc53m0EVaIULgDdm85KJTCX1WE6qricZEi7k
 G6Lzla+E9ngPxcsjWGTd03QXVbaV/ccCyr8ew9mYR4rrpIOb+iflVG6IT90pcvXXkb6ZPp0J/Pw
 SQ38BpSZ8bqk/t3cDel0mnrex5A4Zn/mWclOs1/cGkhKFHasMLtS9OFUvH57tP3ReCYkPpibcvy
 wrGk5w4lAbI6FF4t3ig==
X-Proofpoint-GUID: sCZKCyIZ_BxXalA1Zk-3WQ1KaiVPM3xT
X-Proofpoint-ORIG-GUID: sCZKCyIZ_BxXalA1Zk-3WQ1KaiVPM3xT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

riscv_gdb_get_reg_mxl() picks the register width from the CPU's
misa_mxl_max instead of target_long_bits(); use it in place of
the deprecated gdb_get_regl().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261007232326.66240-9-philmd@oss.qualcomm.com>
---
 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index b3c11db5397..50e834e367c 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -183,7 +183,7 @@ static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
 
         result = riscv_csrrw_debug(env, n, &val, 0, 0);
         if (result == RISCV_EXCP_NONE) {
-            return gdb_get_regl(buf, val);
+            return riscv_gdb_get_reg_mxl(cs, buf, val);
         }
     }
     return 0;
@@ -211,7 +211,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
 {
     if (n == 0) {
 #ifdef CONFIG_USER_ONLY
-        return gdb_get_regl(buf, 0);
+        return riscv_gdb_get_reg_mxl(cs, buf, 0);
 #else
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
@@ -219,7 +219,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
         /* Per RiscV debug spec v1.0.0 rc4 */
         uint32_t vbit = (env->virt_enabled) ? BIT(2) : 0;
 
-        return gdb_get_regl(buf, env->priv | vbit);
+        return riscv_gdb_get_reg_mxl(cs, buf, env->priv | vbit);
 #endif
     }
     return 0;
-- 
2.55.0


