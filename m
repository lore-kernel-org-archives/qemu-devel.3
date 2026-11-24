Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291A606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXQd5B2H;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QQjOCd6E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvgi-0002t7-4k; Tue, 24 Nov 2026 13:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgg-0002sS-1P
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgd-0001Ip-58
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:17 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXdZ82132850
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nLoHQtN8m6YW5SdwWflfACgXRoBJcSLNpMB+8RIAPEg=; b=HXQd5B2HCwkObORY
 UcD09eCc5gchYeQXcF29gblnPRvH/iNJVk8ezs1V29xj0kyHEg8ZblKiZZjuBJHx
 nlBumnd281OUvAgHcp2FppeOpeCoFCjcEILqiTfCS+ybpfhO9xZ2dHCagYiddP27
 anc32PCF9pWhJBHxzfwjDZyBNx24fZT57XxNKC2abGpHuFqCHIYLUBOmzPZdnGCV
 grr20EnDHJEkuujwmm0cIw9UKYc1569qnDBAm/n33LtlmYSSBtfHigVM7zb2wMO2
 EfwkwfCPUERy/Kwv3BBA6/UJ7NQkQ7kXes4GbaUN6ee5+bCAiBo6sKA0SMBRqve5
 uN4EPA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b801pyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so953525485a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546573; x=1796151373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nLoHQtN8m6YW5SdwWflfACgXRoBJcSLNpMB+8RIAPEg=;
 b=QQjOCd6Esm3P97uZZsH5aVxJGsI/3q4Pd3pgcxwxp5bf8UniFl4xj3GZy5YbZiq1Ca
 6GMn7SsSiHwNncEtSr5H3P6T/hLlbyJOHLlDiscxNv6nHvrREB0QLtu2+rYmBqbF+WDH
 SU8pu101+19JjaUreXb5FHiCXCfdT/BProIriDiCVCOoeGxDGZKVL0PAfHvhegFb30CP
 p0R66oIt4bQBSUfJp7RB/Id2wHXuoDdBhyMp9Kut7jLcX4hMqwPdDIIOxV4GKw28QfZ2
 LT1BspntctO1DEwKwvW7IiRk9bC7uljjeLgVbsJBsOKk41UzG2t3ttxuAz64HVhCu9j3
 PVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546574; x=1796151374;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nLoHQtN8m6YW5SdwWflfACgXRoBJcSLNpMB+8RIAPEg=;
 b=arpwZKtm013Q0Yjxw491xK6q6Pipbb658/nH1XImd5q/r4qrAffB+BAn+xASOFi1Ss
 il3x1BXud0i+yIPpy8hwnuQkXBGgEsJAyEBChYDGTV+dyRz59OnDgn8zuVlGDOHaZYb2
 dIHNhRG8cEolmmmTbLZoCiPHI4SbDqX2uvzZ1IU9t3T1tl+fd3E+FDMvP/P4BQEXIBzl
 3+BdedG+CNRHmL4t4AdNuJzGyCiR34x5OzkjHeIC1Ct9/XeBx5GcIxYB1+mkjjzXuSqY
 ae0eUVxZhCLixF7WY1/vRPbDxGVWAJKUi8uizZJKn9MPmvAFcbI7de6KzWtUanHCxtsq
 z4hA==
X-Gm-Message-State: APuU4Z9MZEewzeVCFoVNak74k/8FPBwzh1hCPFUmTTGiBjE0FPy0twUS
 5bOg3XFP/iya0PsbNOorZPdSBtcNeiM8BMrWjB8/L1k5hpxVTVKUY2XvKnX6DftzimlEAfg4jH+
 qCLkzfdESVco75gpVb6qPgpCGpjzu+2+Vb9XQ95FPZzc0l0UpOvYy9XufQ6Xu7jpDdd96
X-Gm-Gg: AZFdTZfM1HBu8O+ZByko7yjSq0Wvj5H33Zsob9C9xF5SwEFz9/hJyO2GBdpJEKAoNym
 /ZeSYEDZzk8IoA7nyXTXkOLdj0snC2o0NzQhWhPpWWDASh1/clJgqmt+TpkhsPHQ+OJqsMwmuB4
 GMusWcPqw7kl5dB5f/K66xXddBBCWf0EAShUvIg6dJ+qZ1yxc3DoFBllUOPKZ2IGv6KORIwfuxt
 R4ixpXEc+KCdFhKCn7ftEAWm6DTCJ9Bi+sJWgoeO7++B1Q/2KvPmu7Mnl+Vcv7ph/PIzuEbndmr
 rhxdhphcipoekh7CAHkTfBZ98OawPq2fXue92LXzFWGymSL72pWbaObpOADxayihKFXbAgSOMpr
 Y77xr58aVALXlNrded+dpiuVexgHz3fdl/1vlJ/Xe+QaCbxm5iKO2FAmZSWQ5e/z0jPpQGS1f1r
 SEf6W9awNJbaNyoQ==
X-Received: by 2002:a05:620a:199b:b0:947:1d0a:c8b2 with SMTP id
 af79cd13be357-949ba9a9672mr2757484685a.45.1795546573371; 
 Tue, 24 Nov 2026 10:56:13 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:947:1d0a:c8b2 with SMTP id
 af79cd13be357-949ba9a9672mr2757480285a.45.1795546572894; 
 Tue, 24 Nov 2026 10:56:12 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f1489sm272758485e9.0.2026.11.24.10.56.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:56:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Subject: [PATCH-for-11.2? 2/3] hw/block/pflash_cfi01: Allow zero-count buffer
 write
Date: Tue, 24 Nov 2026 19:55:55 +0100
Message-ID: <20261124185556.81132-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124185556.81132-1-philmd@oss.qualcomm.com>
References: <20261124185556.81132-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfXwY4EzgCqOVxd
 ke40C1RJx6XfJUM5Gd2rsq97VUlvWRrCDGkGnROBFtqif1Aw4sKB9htIyHX4SQ8ZXfhWPHSYdhA
 WrbFJML5Vzb9BFmRulp+vlc2B4upX5UFPtxPoSly61+KOJPoF9Pyrx+vNe/sSkMULs8xNEluwzo
 3yJIevo1oVKWRg0tkxGtf5/DuNUZqAJSiG6cESGVCegCu1UJFPXA4HUvGhgz33hta98AC9QbVSA
 6pD8KkuHEISTA3vZzNJKh4cclBcJ2BCTMAmYZxZp5aeNMkJQV1iAfIbWzlgb3jS3EbOTnu/Mkmf
 nhFiKEo9SMkeZ9xRh0ovVSh76/h2sFHWuOTfxcQLdE5zeuIoEqHs1dkx9vMW/ui8BcOaHzeGU3H
 4gpRzRXlG+4V44r5jz/7qQodYbnzcu1vBXTm7qZxXCA1Ho2R0EAYgAuikr3ykisRqPyt1GrDPXm
 DUbMkjfr3kl+b3EZS5g==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b05ddce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=DDtf8uVxd8VoVdHOe-UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 1P8w05GCADcPosUzoDBXXTwC_8qVL6Z3
X-Proofpoint-GUID: 1P8w05GCADcPosUzoDBXXTwC_8qVL6Z3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX5XLRN2zsFJoE
 pKBPr4kzMfsbwFctSUKIphDJBiKuBOBlsfBjB2D0nn6QISwu0NCiiJiaGaco34jyZGV1KWBpYO+
 h+ZDn6SCzWelXsBVGMZs9n4dJl/hG2U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux's Intel CFI driver emits a zero count for a single buffered
write (one write cycle, at any bank width). The block update buffer
was only started for non-zero counts, so the data was rejected with
a programming error. Enable the block update buffer for any count.

Cc: qemu-stable@nongnu.org
Fixes: 2563be6317fa ("hw/pflash: fix block write start")
Reported-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Suggested-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4111
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 78cb221ddab0..72c544dee8d2 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -605,7 +605,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
-            if (pfl->blk_offset == -1 && pfl->counter) {
+            if (pfl->blk_offset == -1) {
                 pflash_blk_write_start(pfl, offset);
             }
             if (!pfl->ro && (pfl->blk_offset != -1)) {
-- 
2.55.0


