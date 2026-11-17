Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AC606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oWzBQCae;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYXQfuob
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTEFF-00040D-LD; Tue, 17 Nov 2026 03:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTEFE-0003zk-Na
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:08:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTEFD-00017K-57
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:08:48 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH6Mx9M3982610
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ahu3zqNkb4DPtLbvNtEe1J
 cb9HZPyEUUUoxbA7e4CPQ=; b=oWzBQCaemIK7eIREK0B4JlSbEIDvROjMSo0moS
 96d4czJ9mSBMePXhAMfCbYq5110DjVWHLXIGtpWNaDiTOfG5lF7YQVsAMS8L/Odi
 m7jidOFO1ltBs+5UC+dpqZMd6a9sNFW+7XZCE/NGAiImM+Ec1AdaSHMCyEvH+yT8
 tJGIXmFTTiHqhUQhVf++iYsc4GENLHHzZcdEKiQ7Ct1cpE2IV+rqSb4JmnQBZUAN
 sVqQH3Pp1gcPq7LtM0eq/DyXkQd2+ESDjUtGuTNQrlV8DMEO8jtYVpCx+2wvmKrZ
 /pCQtiEaC7BXWVKq9Ak4i6cpTOl5DBBGjdS3BmQAqIrn4Gkw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd0cre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:08:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94970ad532bso387176685a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794902925; x=1795507725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ahu3zqNkb4DPtLbvNtEe1Jcb9HZPyEUUUoxbA7e4CPQ=;
 b=LYXQfuobIQO7XkhO38dNh022VCNag0sn4vkDUP447yYer0m9Wk5X5Frit5fJotfzlf
 G75VzyvW+I1PPnsG9g8/R+ZD6+pku6f6HKmWVy2ek6B4O+MjbVsd/PDa2DUr1qOq+Ebp
 dqb5jEREyI6R8kNTA9KbquB/qK/t/PNFNxwyFvu4Qo/q4gUyTYDv3ovPsV08TEvWPzi4
 V9x3j3p75i+JuG8IWSGyUI/4cvk9eqitIgWsIbgKUsTLYwBnUSBuQAstYciUBo4cG1U4
 SOtvwjbuCbipn8uzxDP8OnaF9vkNOF8/WDNGlh6ihX8tk8c3peeIZBLw0AWHjQ75pTYt
 tdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794902925; x=1795507725;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ahu3zqNkb4DPtLbvNtEe1Jcb9HZPyEUUUoxbA7e4CPQ=;
 b=1ldUEtLk8rId/4Itsy8oKWxZ+bRe3Ozw8Lc/oHDj2wl3SPf2PDMJ/MqGnvyX36GvpO
 HHZo2IF+RC3foj1x/wAMKUbtE3RHqKMFMfne+YVdJ7OFn9IoCwwHHP0UsvAult3J2sXG
 YPGpPJtC3XGOq4zTIhxR67uwKX7TJ2AWnLL7t2w5/r0fuEaCXbVB+WgxM7TzvStHifsE
 x0sfFOe5V6XhVC5yBAk5IXuJH8YdLhgMcGof+McJfnattNnJQAlx2WaTRpxn8awa04FL
 vjeFXASXRCmVGtnFxhJ03PeRy7zHbDFn6bJXKp9W1GU8ilU9u4XD2mPaOcEhsfjcLTFJ
 e5ag==
X-Gm-Message-State: APuU4Z+BgGm8uQ7mfsMYkPgu0TAFXw/2a4G+qAvLNYElW81UaMbe/iog
 ejnASnMt2CYyhEbQenHEbgE+r/WfEoXzct2er65H5xoDGehCQcaFr+KIG3HBdv983XP23FNFM1e
 d0JcUSR0CQp3ITmlYOzDe1gNqQ1eslhM9iU6/tCZvA4XQRb6CSGgsfqRF0SyE+DTNNQ==
X-Gm-Gg: AYBFou0zs4zrrGdGSmJOYCl9urkmuL3wt88OXh1f3k8xeb2dsvBPMrrEqSRBwBtJ4dJ
 wXdkejmGAKiSWJfxBk2bRQsgm6yMRuRPXfiAl87c5mV4qoHeyiJcKC6X2PqLnvfTUjDJYBYTNt8
 w+K99Pwt+6kxtvCw48PKvEDJSzgAgUepDS1XFMadVJKjCQtBAit3iXXvBt+TPLMLntBjpy2g2Nd
 Sdb8ySMrLWXvX9EPUqpBGHLUPBWTHAaH9n2RNCrjIsuYd10LLYVoupjXYbyrgUtbQs8uztRYz//
 K2+ZEnPtByzPPT9QAO22V7T6/8E9SctKpLupPG1/5pR7Ac3Z2sXIL96be/5nnmnMe1puy7QnKgy
 CuX20B/aBxFIt8cArYVHHpUjuiAwgmDEHFUo+h7VtreuhU+Gq/i8fOlWbVKyy1wPGXThL8VuAj0
 YCbaumvD4UaEpJhw==
X-Received: by 2002:a05:620a:4016:b0:93e:c12c:9b6d with SMTP id
 af79cd13be357-9494bcea6ecmr2286999985a.72.1794902925458; 
 Tue, 17 Nov 2026 00:08:45 -0800 (PST)
X-Received: by 2002:a05:620a:4016:b0:93e:c12c:9b6d with SMTP id
 af79cd13be357-9494bcea6ecmr2286996485a.72.1794902925036; 
 Tue, 17 Nov 2026 00:08:45 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7840b05bsm74726905e9.7.2026.11.17.00.08.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Nov 2026 00:08:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags
Date: Tue, 17 Nov 2026 09:08:43 +0100
Message-ID: <20261117080843.8314-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afc0b8d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9DTOBkR8E7TezDvMqSwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMiBTYWx0ZWRfX3qyAN0w8oH/X
 R7AVcRsTJf+wKgzwKCcGgz4CbA8AQsrAUFBsUdxE1/lHbX9ONabLZGKLxL/f8mKmUURmu1gf4yc
 4tSnvzMY4AvE71k5tAIK6KEpQU4oe5I=
X-Proofpoint-GUID: cV8YcUKOsvbgzpwZl7Q6Pt5GNwofWyGp
X-Proofpoint-ORIG-GUID: cV8YcUKOsvbgzpwZl7Q6Pt5GNwofWyGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMiBTYWx0ZWRfXyaaiHi6SGXuh
 Mslg97R6/g9ubgo2966+Vi+yPU/P2n4psQZ9J+7F2/Vv+6UxwWFomeHQKMghpPp94nPNMQjSPqo
 VCVIoYz8z7NoTv07A/puiV1ezWNEZQMy6CrOF//+zBBXfPjo48Yvsf7K6WovlVkktjYNj76eUDS
 E103Ntc+nBrN8onWqywo6D8YGn0RUA9W8sM7FHdwKGomoHXjZgyFO2ZQMkdZKKgmT8o2nHvTtPy
 zxYtWfpn2y1Hans+3j78TX4sizqCI9b3OywMCv6dG0Gl5wivYIcniLgnxHuMplh0YK3SmsuO5tY
 YfdmukBX8kPXQfI4qFmJyNBsUT4mfQu5CUDEHv2lZZW2IEtrp6QeaIaIPIZMgfUfa0JxjIXA/Dd
 gT5xGB2F6UtvqLfH/B0JqYEkM3YCvpOPOCSW5qHwA/E2D9rIIezaJ52PqO2bhdkjn/OfNNKnAw6
 hNzwzl1LBj1BN0G4coA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170032
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

CF_NO_GOTO_PTR is a TB cflags bit, but it was tested against
tb->flags, where bit 10 is HFLAGS_SE. Use tb_cflags().

Fixes: 46d396bde988 ("target/ppc: enable PMU instruction count")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4ec2..dccae25bb4ec 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
@@ -5160,7 +5160,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
-- 
2.55.0


