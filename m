Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A6606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gZt2eDcZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Il55BpFx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj2u-0007u5-Ta; Thu, 26 Nov 2026 18:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2L-0005ya-26
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2I-0000KA-31
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:56 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwkmp1712721
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 09A23D50GCUghpZIAElgfBXaehDJ6G6eE4GQ3ukLVKY=; b=gZt2eDcZ2nWA338u
 ODeSsTt+aULfqT8lyAfbH/DIiUmKkl1BpmdcGyIZ9oEXhfqgicBICYzxutdcmDJO
 eF+hIHy27Kqa8bfMve332HLkRwGNfjqvlUFNuQ+ZZL/ltqN+D0i6EEIm90cHmgL9
 zbEgyCpXN5QPuVbTZrBIa1mF8Uf1Uo+TG7IX5IcyDK4+r1aGnu8L1Q5x3cjgjB3M
 ny5AKpdo2cz05UY6MSj+0zOSZ8iWe4HnFF4PDTyAlLxCALhfSJIaTD1/uKPbOp3y
 PWhVH+5ZNBISR6mk2naeyTg+iI8sE+P7zkoiO+hzbXESeWc1RLTFSQlQt9/OT2XJ
 D93Ebg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2u72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so107695886d6.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736262; x=1796341062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09A23D50GCUghpZIAElgfBXaehDJ6G6eE4GQ3ukLVKY=;
 b=Il55BpFxzL7IL3IKHVagEcGs0mbeXpOk/fmF35bFAs86NH7q2FlrXdnS/fEikxwbps
 L7cWCf+uUhK0BEbLRVvxftVvX3EWVDkgdfF1vjMSMCjV2rv6PK3uJhbF8sKgUKhzsYH+
 arkVYq659d7DzpivvOXeKRO4ddHPEip7Gjb6FWtBzBswLOuPAcOwSFz/iKejgb27+HRo
 OHkJxCpCtaJx3nC+p+o2Kj6uALcWNFy1xdGVEvUpZ6ZTfV0IxBXhz+d3yWvx5Us0XKph
 tzFlohLvTTEzzt7N4nDtTpXhbFQGFC286Ajc75o7PUDnEtEySNT40LuBhEfSNvYlh64S
 xIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736262; x=1796341062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09A23D50GCUghpZIAElgfBXaehDJ6G6eE4GQ3ukLVKY=;
 b=qJmuelhMn7IaSBYixbajiiYQLkXgJMvzKsT0iltV7zHxAxG9TnE3TocyvL1EThckXr
 MU3BkSOxoIsPmsI53/mAFr4SNmluJ29qU3hEyOsVb5owyim+/YzP6iC0Wx2jpHyqZJa8
 SfVZ8aitTgxsYL90vw6rXvtfdpmIDt5ZrN/5FR+gwxf77XC3rEtdccfv58sYfSIKfys2
 8glwpO8Va3izFUq+5eY6Ykyzc55vmQRJGzEQZtDp84fHfdKxxgywIxSFREHRl5Lppunr
 AHN9cDYnegY1Xo4aSEsL9gZ3mCgEZBhXP7JilM1ozSwux66eSp1hdwihDKNKV51Ynjco
 AWZA==
X-Gm-Message-State: APuU4Z9mW+kZ2zQn54cYSC2x9k7fIpnpl2OKIvhxidhp7ghonsozS3Kf
 MP3vGPERxFlQEA4tc/iu8D5elAzCIgzPrOsnsz0+0oZ4k5sEFpoKXJBbAHIeb8PjJgRMVI6LwQB
 VRw6Hg4EzujEzKnz4DRsA4bbXFF3qxhBuR+L58f1phO5YMVfInKXWMpMYevq54G9QuA==
X-Gm-Gg: AZFdTZdH5d2tnSwSr3Fl51PzGfcYDVlJPYngqUbG7Pga9wcFwh2wk3b+H+jxPQ5yteZ
 aSLBXGFvOSqLk2MZaI6OzWvLnn3XRLBL+Xa5ypSvCj9SIUGnSAdA46BgVJgVk57P1ZtCja8GZy4
 EkO9IWnN0MpbudEckToDnfge74v1aekENqAZo52m76UOer77sXa1+pQJcq0IprpPeTjIC30ZACh
 /Jy+xA+6pbaS6Qr+XaGItXhr2WGvKGYo/qQWAQp7NPeNViRJZgi1gxPs3UEOfq7RxsZ0pJMeJIW
 09p9lkWlrqqEpb1wt+hGE+7a+3eyNq1Vp8AUOrITuEdPj1DQrJo++yt9/mz7lMhIsJdfVqysRoG
 DxGMPDxLJX2YCJFZn77yN5/Y3jJoFqaADyw2aGMI5EHszyDGXImPd6Y4bJwZvlyAimK5EGUiAHO
 uRzuOGTr8CS7+p6g==
X-Received: by 2002:a05:620a:a807:b0:949:caf1:ff98 with SMTP id
 af79cd13be357-949caf242a5mr3039582885a.28.1795736262367; 
 Thu, 26 Nov 2026 15:37:42 -0800 (PST)
X-Received: by 2002:a05:620a:a807:b0:949:caf1:ff98 with SMTP id
 af79cd13be357-949caf242a5mr3039581185a.28.1795736261978; 
 Thu, 26 Nov 2026 15:37:41 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c4353d6sm41842501f8f.56.2026.11.26.15.37.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:37:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 12/24] target/microblaze: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:50 +0100
Message-ID: <20261126233604.67722-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08c2c7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ave-Op1XRNZjfpqMpIUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX+lusLgZyEDlk
 dCVmc8fh8vdIpQ3llmUHpjlu/sxV0oJfBUzZFQ0hMuiW3H9JrOYIbT2J9KB1zcBaRqF1u88CTzG
 pqX+/G7GZh0FZt2hiV5WrQKeKjEn+lOIFiTqEVC7e2SaIojwWvU5s4PzEUpU0YYSsQDVmTHjtcS
 psiKnCr8ecKitwKtl/yZdrKclgofZV5I1B1DmQdcZlxx5jcpAYIa6ERLVEyZpxdVppR8QxmFkwu
 uNvjbfcsyqzbRj+5M2y/Oi2mwN5nIwtZ3nRKC68h+Ecs0FGYr8Ywx+JJeWlonwhpNqMwMWA8TP0
 j/LBwuwX9rydeZjYiY8u6yNy5Hx8m4e/L2auyqn3emjyQrubdCkCDmYphFDljEDKKRtYsaxOnSA
 YSmbeoaCqJ/xdhjYc8uhsNTV5qmX4fC3gM/Eu2aeoKPbd7lcr9JAP64arYRrkJhjVsVl0VCu72t
 0ATtsEiuUZoGY5HFI/g==
X-Proofpoint-GUID: PJLhPq854O_AUocbtZ-3qB5xzN0QU-or
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX/xyWtt5vTa6p
 S3KQgYi6O6eLGeb82nvjHc+Ea7x+8n9AKXGVrD4aQotXlacze+8g/TY62Zc7knUG6PFpq3IOwxX
 Z/85iioPd0K740PWovIRAxrxKHQmO9o=
X-Proofpoint-ORIG-GUID: PJLhPq854O_AUocbtZ-3qB5xzN0QU-or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd4..4c869f77f5c0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -68,8 +68,8 @@ typedef struct DisasContext {
 
     /* Decoder.  */
     uint32_t ext_imm;
-    unsigned int tb_flags;
-    unsigned int tb_flags_to_set;
+    uint64_t tb_flags;
+    uint64_t tb_flags_to_set;
     int mem_index;
 
     /* Condition under which to jump, including NEVER and ALWAYS. */
@@ -1668,7 +1668,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         /*
          * Finish any return-from branch.
          */
-        uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
+        uint64_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
         if (unlikely(rt_ibe != 0)) {
             dc->tb_flags &= ~(DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
             if (rt_ibe & DRTI_FLAG) {
-- 
2.55.0


