Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E31CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gO-00072A-KD; Wed, 14 Oct 2026 19:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gM-00071l-Ut
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gJ-0006ST-3c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENQWrL584763
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+0udiHg6Wqe
 ca4aI0NMIgMbF9Nvq6PiPEWlF4J9jBDs=; b=UJnp1V9Y8rmokmHcxCW24SBZjvH
 FWO50yxUgm+nUb/oEZbKlv6E5Dtg1E2QVoGKtHATxhLtAuMUQ5mTbLy12QLoT0BB
 Bdoabn223bPq1Pkw9sVLDW+/TzZwbApyjoAEFrFU0OCmudzuCkdYTaxI57WipuU7
 /YTHlv81uAXAgIADEvLWeBd9zQy0dkUBEpL833D008IsZ4qsaQdSQAmE78SNjmhH
 LcSJkivIZz24qRSnafGdPrdX/EwIAbQewLf+KUpdxRLwaTkliZ9J6bh62y4IdnyF
 0iFCB4hRfR9n8kRSCXx6IBrZEqOPQ3KxlHr02AqFZNdArE3omshMJ8XVi3Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakder1xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so13061150eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021595; x=1792626395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0udiHg6Wqeca4aI0NMIgMbF9Nvq6PiPEWlF4J9jBDs=;
 b=cX4OWNXLkUZoQn2z6ww/yRbkK1IsAiygNMSx5+KllS1ZywiNjP+MmXfVZSuq18BXZV
 VOqb2kdvo3lwTkcdUjJnAZKneZERQYOnOf6DIPVAZuliRGiq8aQia3+rIaJbTec2fmFh
 08J0kEnIPMI3NUuqQUIjIH3nBl2DXBoHVl97bJk55nHVXmtFlZqpo8C7H+v8trTp36k3
 fWIKF2CsqioJPT+yRaEOS8C6jttQwRa6YtXRtDHft32kSe3IizMtboqfl8U/S6tnEIyx
 /KwFnY2yRU3JBKPwNRQ8ATjK2JtrLhfZkWyDT+HDx+ZcW7uy58q7K9duKWZs1NOZ59fX
 DbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021595; x=1792626395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0udiHg6Wqeca4aI0NMIgMbF9Nvq6PiPEWlF4J9jBDs=;
 b=iKtn9S8dDjCscs1VX86jas73La0pCaC4x0Nu5bRZbCSqrFHW8U0biJTvN2p8o16l2Y
 4qb9YjycJwsQcDjWbN8X3QB3ihVzxaPpmNc4Vbg93w2QBC3bGSTgrLeu47QEGI0mZcMg
 NBIsf0QBgssMrcVaUxtYAvIXqjyCSbVuxt4U0TRI92eEUYzf7figcaLObwBh20d26u/N
 VK313G4gyEAGVIMkitJO9C4Ik1FMKcMR5pcF5veBjkEdCjBoPXGAyqWAPE0HXjfQbn27
 0GO08Q6Hvly7GZqHAxQO78FNKt6y3xx1B/4kZ5FWoYvsgyJya4oM0PJ/GAX8HrPOli+K
 wzEg==
X-Gm-Message-State: AFq9FYIxfXXdo11adYilNKw53SwWRQhuCAC/9fx2m8n7Fl71TMi2ebDp
 Tz+OUDfaiAq8f5MaS6IKfvNoeD32we6XxWI70gbEd/agsvNffIhM08VpCbcdKw4I8BFyfqSQS3f
 t6/hd864nsdBLLPDFujDcaYS+R6EEx/s524K1esX6VdUVG0S0pHBz+GDBMHTgUbSKMg==
X-Gm-Gg: AYBFou0+m5WW1h5jeamgRlAkcnIOG+7jZgMGNswWrlaI3qgmoGlilC/f4blZGO8/FiA
 4vbSUvZ314SwUZ01RpcYFpAdvbs/mSx2fAxIsNQg4XXu1jVmUZRGKH01G6qlWOXLcm3JCbAMa3h
 VXFgR5plCIyplRsm8EU+NraiJHITIQxL3YUVJuaGchJVs+KSHaBFetV5YxSz/6upKeMhk6HosOa
 8wk4Vslq1XBfhoKEwWkhHy3upfwOpGq2HTdKyFYCStPtihCK/ON6lWTTLnTVbJswKc/q/1SrjCa
 2iUR0okNiHxC3P+d0aWugZ0mEjRGviG3TXxqE5l2///yajhx/9ZLlwxu3WLwCYXgYja9iUb+DX+
 RLIM1dItRuudNP4gKiRWigd41S8I/HoNMuFode16ippp98mslB29Myl100JMP
X-Received: by 2002:a05:7301:e0cb:b0:351:1e3f:812d with SMTP id
 5a478bee46e88-3537e0caeb8mr21587014eec.36.1792021595123; 
 Wed, 14 Oct 2026 16:46:35 -0700 (PDT)
X-Received: by 2002:a05:7301:e0cb:b0:351:1e3f:812d with SMTP id
 5a478bee46e88-3537e0caeb8mr21586967eec.36.1792021594383; 
 Wed, 14 Oct 2026 16:46:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 15/19] target/riscv: implement get_note_size dump op
Date: Wed, 14 Oct 2026 23:46:01 +0000
Message-ID: <20261014234605.209084-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0145c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=iWNE3ax2h5am-0Kx1xMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: KGVeRwgRQLaAg29SwTEr3O04aUuHHx4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX+HjupL4c9h4D
 NbIKFnd4uohm88AE/mF/DP36z76Caea2q4YNyA/wqA+GRwaNKNonBSGoQ+ZeGxWS94Q8wUZBJJV
 p8xsbXqoYqZkxxrRMeFE3F6r5GMz1EWzTtlHY8pvOdPyByP1+dHJyxFfhB81h1gOFzDOMYFTjWm
 PMMNSk1zAGIhoEq2KDiDIWetNmDyUeHoP5TrIMz60R/CJGDUjsrRoZ5cwReHz30wKQILWv4aiLS
 /KKmYfF36lkPcMpqvVVSLq/q/2zqo53NXD2TQ0AUFwaNQqCCjtpKrH3MEzE2FG4iPBcDBHmv/uP
 Mhszy67PWOwiShrJIDzW5iFn+c9FBFmxH+8fKsBU17eH/u9SB0xN8MYl0Qzm187ZsSj31f9d4g5
 LU3OOHahJfOQMDlXsm2HUBgjA/vWauQ3WNLuorw5q59gSCSMd6jh4OtQfP0hTGC0xHbRlFzOunC
 5ybIryVEXT1lHoRa5Xw==
X-Proofpoint-GUID: KGVeRwgRQLaAg29SwTEr3O04aUuHHx4p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX9srMFRt6NI49
 N7T/QPjaAbLiEFX1JVbafCDsGxJJ+tlEHL0cz24ARLxIEGiEfAGjZxvc/wsle7qgm1kz12WDmzj
 I110ZHXHlUjgJnWmma/quOkIygsGjYI=
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index ed5be83cbc7..dfe5093b44a 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -183,11 +183,8 @@ static int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-const DumpCPUOps riscv_dump_ops = {
-    .get_dump_info = riscv_get_dump_info,
-};
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                                   int nr_cpus)
 {
     size_t note_size;
 
@@ -199,3 +196,13 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+const DumpCPUOps riscv_dump_ops = {
+    .get_dump_info = riscv_get_dump_info,
+    .get_note_size = riscv_get_note_size,
+};
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
+}
-- 
2.43.0


