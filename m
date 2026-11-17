Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4F606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XpHMBEGs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BSaP0iMv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTEEO-0003RT-HG; Tue, 17 Nov 2026 03:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTEEN-0003RC-39
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:07:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTEEL-00055Q-HS
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:07:54 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH449H51699357
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=u0NXhMIsHtXwraT8LQ2S6Y
 B4eCZYINdYE6zIfRk9PBo=; b=XpHMBEGsQaNfd+PfBtqzfsNm35zCn5KiLmmpmu
 ewwyT3Dignv+ClhaImn1WFrPfX54BcSHV9mWDOSMeZ1NNmzTyaxgMTjqalplw1E6
 lKZV3DECvoFHF3T53WVM9RdAALL9Bfh/Dg8EszmDdf61u/Q5X3FKqL3y4D9fadKa
 YFsSz3jtd0hJkKAtEBDQoXhoie6Ji/YMLV+rxYIssxoNsrwkbnCtMQasqJH1aTz0
 qR2G5mMCq6UfcBKZsG8Ld39sUxCE/XqnjCXMFJEkm/zMaSbFX356uIk2dgduhTpv
 od1nusfijJvPc0rHoUMVBoyb9QGAouL5+mJJJ/003E9fIvtw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0fjugsxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:07:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so770071485a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794902870; x=1795507670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u0NXhMIsHtXwraT8LQ2S6YB4eCZYINdYE6zIfRk9PBo=;
 b=BSaP0iMvFsf5OjZUGZ5KndVHxLYZWBcmFL8Wvc5ALwaz6s9tltNtuONOWkc3v7h0Td
 TPalAUmqzBvDXx4mpucdkQzXntJc7Bx25b4l8rf0pFJboq1T+guhZxDGLt/JX/T6+cyZ
 9THTH+QYlnbbjjbSzS0Rd+1iAlvwbpsy/NkLCQhnK6NCpDXNL9kc89PrtBG5uK4rwNQx
 9nAqhy02PskDRuxfaVJncg1iLDMqxh/10P5qA27j6nhhKTwEe2lVASfHVcNtgRFcR2jW
 rPH/dcrZ9flnhaeGQXDku323ZyeivXb/6O1dEJXaVmSpLBlgC5H6IYQnHmQ87/tt3zQw
 uBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794902870; x=1795507670;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u0NXhMIsHtXwraT8LQ2S6YB4eCZYINdYE6zIfRk9PBo=;
 b=iKm6fPHs1Zse5fN23ICRf8OZ4z7aoWNZtQdOT9+tXc5hIjnTORxtxmIW5porZkCSpW
 1EByKkLjMfHYaGfPzHXfUsnUgPbG82zoCKSLa0QC+Ds763bAGEz9yhMDvxMFbHAoIQwJ
 pX8wFGIs746o89QhT6NF0oReU1ML2un82/L3RvwPTRcZtHZfAwxYeu3F9mulFviO27/2
 +C1cPuuqzMmQ75j2e/OcWG5J9uR/mBHF6w4cNNld+izQfx32sKlGEA6RIUDdUGHXnmI1
 AtpO7XDuDToVhJoCjb+EfuVQKI7nhkgp8n7FqteqZT+zfEyuK2du53Jpu1MMBejZTmTX
 Lh8w==
X-Gm-Message-State: APuU4Z9Mw8Jj6F/+4BUhB/mDowg50PlTY+1yXJGUUpZBTZzK00vx21vK
 ecjCW0vxfwS7TVS7+Vu9aA6CbsXlpzrUJJF7qZ63or0mnaHGfzGiiWKpotcP7ssmbBhLSbuvexy
 Q6gXyLdjopu896IIbGrOkNpyUW3DVAC6/mN+XYRbvxibD/HTy0Tqc0AGbss8dMXd1Ew==
X-Gm-Gg: AYBFou1Y59EKgl8fDouGcqeXIL+ZBBcuOaZPjP3XgUtFTWWDx3acWyzG/AG56fAlPnE
 czYHSZozmT2QKYa/EYHlBp+7/Co5rHkWEqdljHSdNTfhP902BBamYBDe4WfymzK+gZyKbLnk795
 KBeL2MJrDc0R3yBgICuZSMNobsn+2ojPUJ9dG+iKVRFXmPxwJ1tW/J5YsSg7cLht8ES6fjjdBxr
 ZGMPF7V8eGFLBi4FRkxR7Aawg/k+b1sIrNV5hJbKKhdxpbveO6WIq4S5w/9zDcTXKdcvs7Oq2VA
 IywuXiNuA3roorhOXNHhpHpAHY/A7RzQwUSLeFMyoeuhtqQYJOLcoRtfBlR/qQ8BIFLC7Z9i5OK
 OjW+JxUUBuWU057proeqocupUJ0DO/YI0qI3efgB+pEEOWwTibQBHiwl9rhr64gTFbEuU2DBgzY
 vDbFlTMMBmf4vYqA==
X-Received: by 2002:a05:620a:a508:b0:949:5e26:e929 with SMTP id
 af79cd13be357-9495e26ee5dmr1447653085a.33.1794902870424; 
 Tue, 17 Nov 2026 00:07:50 -0800 (PST)
X-Received: by 2002:a05:620a:a508:b0:949:5e26:e929 with SMTP id
 af79cd13be357-9495e26ee5dmr1447650585a.33.1794902869978; 
 Tue, 17 Nov 2026 00:07:49 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a3ad4ecb62sm2655245f8f.57.2026.11.17.00.07.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Nov 2026 00:07:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/m68k: Fix TB_FLAGS_TRACE* definitions
Date: Tue, 17 Nov 2026 09:07:47 +0100
Message-ID: <20261117080747.8035-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMiBTYWx0ZWRfX9YnjHxx+Te6r
 3mGeP4bgoFZeIHwJXakwL5kpzWwNw6a+aIB7aE3+gY/Pzjy//k3iszWLq4DgXa65EXIvVt0vXmF
 MUTc+ZO3JpAodu0dNR/Zml08gKOPPsR/WZmviHt2J93Rn4mvQAGgmlQ/mWWpzDcqaXT/kD5Mnhm
 EwvHETgrg1W26R4hvF6MJdHyrTImCpE4FWgjyIN2bE29raLNm/3PYtQT1hVO3vesky/rHe4Sa9B
 x4AkKWt8xOtghB3QqGwOwL6rVgjv0NzBP3vROrByvlyisCwReJ9YCsMVAYxmhvk/ixfjxazCCG7
 UcRucOYyd4oQBnSozVvpNvYc/9Z5rhjnj5qza+75OFdpgT4FOzWRtoDplrq2iPbzoJLxLFYi57D
 xqbNMNxqEPhHWrouCTZ5/tdE1PbEhoREI4FqcCYR/u39fiLUPVhE7Puo2e2M9Wn/TYyFsA3EnO3
 FCnmHVvd8xzIcQGMIyg==
X-Authority-Analysis: v=2.4 cv=JfIpPkKV c=1 sm=1 tr=0 ts=6afc0b57 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1CssDuedKba-MjPSEX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: _PXfn0UNbqfujJ19_Bzuo0QGUId8a7Fa
X-Proofpoint-GUID: _PXfn0UNbqfujJ19_Bzuo0QGUId8a7Fa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMiBTYWx0ZWRfX0rgryef3MJ42
 xOETPcqPNu8FJDmkhIoC1tk4cUQe6/WvWPjRgUvVuwkmwtNOb3ZbZRPVF42+c+VGsXsZM+0V0Sn
 cxchMVQwT47pAHPR+NZSTVkCVqy0V70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170032
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

TB_FLAGS_TRACE and TB_FLAGS_TRACE_BIT are swapped.
Fix to avoid m68k_get_tb_cpu_state() set an invalid bit.

Fixes: 5e50c6c72bf8 ("target/m68k: implement m68k trace mode")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/m68k/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 781c98f78400..5adca8ed49f7 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -606,8 +606,8 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_SFC_S          (1 << TB_FLAGS_SFC_S_BIT)
 #define TB_FLAGS_DFC_S_BIT      15
 #define TB_FLAGS_DFC_S          (1 << TB_FLAGS_DFC_S_BIT)
-#define TB_FLAGS_TRACE          16
-#define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
+#define TB_FLAGS_TRACE_BIT      16
+#define TB_FLAGS_TRACE          (1 << TB_FLAGS_TRACE_BIT)
 
 void dump_mmu(CPUM68KState *env);
 
-- 
2.55.0


