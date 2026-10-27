Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48391606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nyl0r0/C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P72bw3Pt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmN-00016u-7Z; Tue, 27 Oct 2026 15:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmm3-0000xl-8n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:23:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmm0-0001m1-PI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:23:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHRjq2639280
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SYnvCRTWeVvqgqCOuRt+J26szjQXnl3iQtZUxla0j+E=; b=nyl0r0/CGfLpktGc
 2aZO/0NOCZQ/pnTAGeD0JoVQP7klKSP4WyH/KXSWEyZcG1pAi6Re/zD6wbMuX9+1
 CPE1OD5TTYV1ihfaP4nEcRhXtlg3aZpJ7gIB5EOilegtwAeMeqAb+1HXMd5sIpMD
 aDZgih62d0x8kLbtFdi6RHaVJfckx5SOwKCwwVq1witX9+8v1C1BHSg2BYf1ulXi
 +j+GhYEZLz0J5t8vJKcsPqRu3S4JblcUhMG1zXDXAp6UzggV9sFXQl3fNpf/gfXp
 QncyFcCZxL37MkmhhDAFWN72Ps86KLyAY78dRj8f2/qP/1FdvG0bNbT9fUNYabsM
 Xp+rPw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5u1gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:23:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337b591609so4707931cf.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129031; x=1793733831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SYnvCRTWeVvqgqCOuRt+J26szjQXnl3iQtZUxla0j+E=;
 b=P72bw3Ptwjjvz9l8fQUCPaKJZPjnfuVKMErLUyfLCbChbG8bMuzAI84J3EfdzJlmfb
 JhgxuCE4ODKKooUUsa4SSFLYZjB0z+sBETJcE6NSuDpYoY3d2SxLVH1UrJmhLbjevc73
 qV3abP8WT3y0TcJ2txlptAwwCAlPW1TtfrXp7lmtl29p/mKP4r1cl6wIvPi5NEvFycbt
 /4P/RNTzUc0+5ZpcEO8S7EObgxqo86A3QkU6ni+90exepRwEx2g82Wh2/F3+M+bOVV50
 uyCMtGqaMXmVPB+mp95vNrB6s88iDiVWEzZqDkbFBbcAAeJyLPIbUaNXYw9axdXG3vPQ
 4g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129031; x=1793733831;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SYnvCRTWeVvqgqCOuRt+J26szjQXnl3iQtZUxla0j+E=;
 b=GlbZjxSAavRVsokeIySAGGPnFkbGmd2sKNDvPC2jby/sYSGZcp1Di6s1nwY+rkE/f5
 mBGHQBliGkjlDDSX2/teY2KhOq3VfqwdFT+T8SURy0Zl8/m+ZujvnkV25jK+rpLQtaAK
 onF8Msp9uMD8SP55xs618Mlb6VXD6XXfNqhbLQGQd9ZOZfIqQ0nqZf5qlQO5eUgrlF0U
 8IDIUsA5w2c+QROID3vbSbpgDqDbgBT5AXB3D5ZYDiCRM82+AV4J8ZDrw4vW16nsQb8l
 XeCvhLrGn0+4tr84DsVzFcij+prNYKRMobsjd2zB6bryGR1BK1ZXrp/O5voTBV65LuP4
 VQ0Q==
X-Gm-Message-State: AFq9FYIhghxwL1/AdXQPKbhO7KoqyBhaNooW9rvH/PPRR8KoBZyUDpzN
 ZlndXi7JrTSdX5JpzU0df2nCSNFQvt739q8sQxSM/2EVm0Oh+F+tD68KqIv448I2ca1doH0uTSq
 VSrxO9EN4AyjvOuUNAR+KZGt2LR9KJeeQwW2aaIGm5dTil5kgQbULT8iAE3XzCLXIlA==
X-Gm-Gg: AYBFou3xBpN9GB8M70Y/9wBYba+Xjq+U9pYvD4D1UXttNk4tbS3hbr6UwX46MC1iyg1
 HpmfG6bgze7FeNH1TN9i8tWg4CFelRBlcYZ4htkjcaFUEXjvVf1UeggJJKadZ3YEbr4sSzdLxnf
 3uR2xDX2DhHRLpvQ/RylALy2urqIJH8mU5NtaM0/itOdMspa0dhePz3rWQ0WrIYyU97pVUv/V7Q
 i1pVu8dCzcFdMv6a7mdwGiOHjwdb6AJEb4adLtwxq2V6Ng4Yxql7pjB6+CxkoBEKcORMTG8uSA6
 LgTxtdpH7GnPwlnC/ekZIFbZEU6YIx0ua5NMfFgyFyU/+bTw+tWlZ8UU6DhjyACf9/X6jwVbidF
 ppoWcegXDepWr6NUhBgRbenKYqWjg4ecQUHwt/R981byzu8my0gzEU12M
X-Received: by 2002:a05:620a:2b4d:b0:93f:32c5:69b0 with SMTP id
 af79cd13be357-940ef995d64mr1618348885a.60.1793129030925; 
 Tue, 27 Oct 2026 12:23:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4d:b0:93f:32c5:69b0 with SMTP id
 af79cd13be357-940ef995d64mr1618345285a.60.1793129030389; 
 Tue, 27 Oct 2026 12:23:50 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3bdbsm20024947f8f.19.2026.10.27.12.23.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:23:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/59] scripts/checkpatch.pl: Don't complain about spaces
 before Fixes tags
Date: Tue, 27 Oct 2026 20:22:42 +0100
Message-ID: <20261027192341.9197-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfXynpVZ7w8TZMH
 OuT7HPJWh9YfsoOF6SuGUFStdfeJLZUagl/F9JFL7K9vsz3MqXs1EfLfAW/5vYCs/iZXSgg3dSK
 HZuj2WFwmUtipX+vQ8EcOwGkpPECzA0=
X-Proofpoint-ORIG-GUID: MGfvt3AzC8SprHIqfXQxgepMXpaalVAW
X-Proofpoint-GUID: MGfvt3AzC8SprHIqfXQxgepMXpaalVAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX/LfJxL+yCMoC
 bMjU6eCDrcRWAiB6qQEE0CK10sEdWKMMzgkuYKSSNQdirlnBHzDMG4/obo7Lj1N9IK9Wv5mXwhs
 5fGisW5juIvypQXktmZTy6NwzK5Jy8WinVew1xWtkGTsbJv7NkjTGetlyeZUHNWsuL9AYSl0iM4
 j+XyOmZdddJto9xm/+RuXy0Ia6SeHhVp2D3fdqhrrdfLLaDlKF/KgwXFN9JUr8H8VwhE7X2jSG1
 iFRY1xBtvvgsL49roaaCgFmTmL4SqUi+DJk4W2r9WpVCo9k/MLNacL3XT7lD/JnpeaWgZNZgoYz
 yykLS/uMbrp+3gyR1OsR2rCaxLAEyOnbLZLOl3xBwz/ruNgI3SW6U80AOS4iEV5XUIGbHxmF3Bm
 YPkJ7gB1eXNIZFEBT+12hlvtIFHW755W4w2JxqgA2R9oKuZdwvddJiaNKYfufl/TCnh3nHunTBs
 PKolbH2RBYjsPFqpTiQ==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0fa47 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=D_gin9fTjPLjegOP6woA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The checkpatch.pl script insists that Fixes tags are at the start of
each line of its input. Although this is where they ought to be
in the commit message, it is not where the script will see them
in common usage patterns like

  git show <hash> | ./scripts/checkpatch.pl -

because 'git show' prefaces each line of the commit message body with
four spaces.  Allow spaces before the Fixes tag; this matches how we
check for e.g.  Signed-off-by: tags.

Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format and commit ancestry")
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20261023152357.1614817-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5df266acb172..82f62f602125 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1889,7 +1889,7 @@ sub process {
 
 			if ($line !~ /^\s*Fixes:\s+CVE/i) {
 				my $tag_case = not ($tag eq "Fixes:");
-				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
+				my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
 				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
 				my $id_case = not ($orig_commit !~ /[A-F]/);
 
-- 
2.55.0


