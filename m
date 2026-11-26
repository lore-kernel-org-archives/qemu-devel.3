Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844C606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k0XnD/BH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dWsP4l1s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj15-00043Z-TW; Thu, 26 Nov 2026 18:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj14-00042k-FW
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj12-0003nr-6W
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:37 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwZsw2574688
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OD9CMOtntKdYH51TLfzUuXfvCfmzFXt1EcBrUXIZX9U=; b=k0XnD/BHXKp1alSZ
 kF16ZxUh2AapblOzWv7rpSNL5I8V4Hqk6dvjYaTanYVgTRrDRf5DfZKJa3QsfomK
 eP7L4ldBsg+HrYUWez60eXRNJqZTXjqUCDwjjRYmsjw65ijK8UibLCBBF1lSF3fs
 +50d0ZRzZSNrg9EG6leXLnk3bsYb5RzS8sQxfDaiR41RqDsPnQYaBg7f5ouxwRYW
 YEq67qCN0wwMptPSJP8hPm+40jI3c77o+T+4V7OMT8aka9JoRlpXpThj3vyAfMuC
 84wtvkLL7yPxdTZK6Inaytva7WxYxp5eA2fCDyx0mCtTOM2/iMUg28JmuVlEmwAn
 F8LjQg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u498fnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949b0d322fcso1242739585a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736183; x=1796340983; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OD9CMOtntKdYH51TLfzUuXfvCfmzFXt1EcBrUXIZX9U=;
 b=dWsP4l1spPkWUEjrM7iIWDAfxZfil5RYbmz9zlYWqxHmkkcQQJazTUrphOJIYTHITV
 96ia02kCiDEsH9A/qDXOP8ngZb9BCSwFC6+Fmh8cCTtXsclekkSHHvpEe8a1VxrtFx2y
 7KDmLXgRNjfoxpC+ZmyuCgTgsEcwHNI1l+WF34G1bNZ6U47J/wlFAO+M8lDuthuqU/ig
 R6lfx9vWgC4FbLmhV04p0NkvuguZPP1l/Ot1KpXuspprOMjMH9srPXlmU/WbQPfYn0IX
 A/PGda3PEtD6TGQ4PSpHYoJPv4bN0Shb41+PtjwKhgmvRXILoM4E7mkPZTVxxIPK+d5L
 /hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736183; x=1796340983;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OD9CMOtntKdYH51TLfzUuXfvCfmzFXt1EcBrUXIZX9U=;
 b=Xj9OXdrPV81pV5iOaZALlCBjf6zy/XlPQNgZhdPnH7COD4ZJd0wszHtRDN2f4JrlwP
 9SNUfBCC6J7ruIUpiGw7COYE5MByNJG4ENDLtNaHbBjoiMwP3JbycuquZR62gPoEjeE1
 QKkuHxEU3UJG8tZKuc5bvtNMyJ14RXuSz2YxosrwpZvm5hCKjxb2oqObYuqPHSfHMckd
 Y3w9W4yMRgF9dVECtFkBqsPK8b3y8XujHgi3o4q2sZRVJbSGLXUsj/YQY6j9QZMbtfQb
 Celz5omCZZ5OyyeCR7sgDZTJ8cJQufN5esRau3WyfeQHqrK8TFad+Qb3urFeAcz19HNN
 YLNw==
X-Gm-Message-State: APuU4Z+C/XCdBWg8O0QOcwP6hxWraQkr/6nXHkcskdx8WeODADStcxRe
 kb6HSbMHwt2SGWjdV8wMpa2rny80EK36kKjwrclWNhwTwB1NAxItcIPS7V6bhfD8uyAbn1LEJye
 IHr6npUrqUxtjLF4lEjFzTJDl7+jhHwTdjGHsTAAFpPjs3m0W0Dr9bVr+2/KX1s/xBA==
X-Gm-Gg: AZFdTZcGgGH70vV863MWpGqorHPJiEchftqwAklcPrWJP6ccLqrGAW5QsROJXKO7caT
 9yYLKjsHz5LED3wetqONVsGV5zD7QWWH9u5QOyBwEiHcSfgmam1hfhOWFECogN6BF3tpLFGCB+f
 sn8vCaSmBoRUbq9Ep1sb/uExUKJKKHQNWzleN2BkyMuKtQ8Cc+ReyexeMlhXn5upZonoYLQs/b9
 01aFonjc/jj8gllvdSRIoJ01BvSdu+IkRRWKb+ntXoCzrdNJrmP57amnmPucbmxKncgOtJRs2VY
 afHGPPEQPSqcfAuQuN1/MmIuEn9LfQ9zSxIYu8p/PJZ9s0ht0IygrGpZBqlqrGSfs4xi7NcRwQL
 nEk232HGO5Frvyt76ifTCR6EubSXsq/2nkgicXVbVlb0OTIIKIFmFRVitgFlH4MDvOWzE2w5r04
 Lw3dPnaMs3Sh3rjw==
X-Received: by 2002:a05:620a:448e:b0:949:696f:c997 with SMTP id
 af79cd13be357-949bab480dcmr3786829985a.80.1795736182734; 
 Thu, 26 Nov 2026 15:36:22 -0800 (PST)
X-Received: by 2002:a05:620a:448e:b0:949:696f:c997 with SMTP id
 af79cd13be357-949bab480dcmr3786827585a.80.1795736182324; 
 Thu, 26 Nov 2026 15:36:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm699284395e9.12.2026.11.26.15.36.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:36:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 02/24] accel/tcg: Update stale TranslationBlock::jmp_lock
 comment
Date: Fri, 27 Nov 2026 00:35:40 +0100
Message-ID: <20261126233604.67722-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D7aGdwAFLJpWrAyfbaUq4DoCVglk7VCg
X-Proofpoint-ORIG-GUID: D7aGdwAFLJpWrAyfbaUq4DoCVglk7VCg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX+FJH+W5L/Wv6
 WUaZ6bCxfW4FzbAi5rkgpjsRXbRrNNvaWSaBqrhQm1mBqljhuRlDvNZ9MK0+5ohLWIWvQZ+aee0
 Dc7KZFZ+ZJVZItrFWe11uoRGTHbKn9Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX/kizQ9EgP8Ys
 kiw0smr80x9FFgKDV9Nxan277AEWYQEvS+dINSXG+CJlK3Zo8ewtZR/8vdV30ctNMkZm+W50We9
 xialrkz5Bz0vV7+JAKRWHWfRc0L8LZXMUO+vH7ox53oGFG+GB+rpiOoO8Q+xZOlPA84/BG2CCEV
 QDDRxZ+xTV6S0mEJ3NEyuOlKrLeiS76DGT+XBqxfNdFTlr73NW5pdecaB7nWmxVxNtGBXLlTMAa
 I3/8Wj5NBMZwSFB6IYdUV5yzNh59fDKHuHZnQNv1W5UuuBs5U3C0w5FQJeIZnQcxHI5x0ekxHFe
 2JdRXxesSozms4obc0NTn3EGuS+rhm6FR8y3sr16zIQULk80gfL2P2zZZ+SmzacVnRBJUum0SNy
 q70y2004uS2ffj3z70kqj5X5gTksV3Ea9AsmcdW8ls3iOeU5RYi6JAKzn4uFRGA7EPNEbFNUrWh
 y0ztad6JTS0siNDj2oQ==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b08c277 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=wor0a0PqxOc_1PWZJ9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

jmp_lock was placed to fill a 4-byte hole, but commit 9da6079b2695
("tcg: Add TranslationBlock.jmp_insn_offset") added jmp_insn_offset[],
so jmp_lock, jmp_reset_offset[] and jmp_insn_offset[] now take 12
bytes, leaving a 4-byte hole after jmp_insn_offset.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/translation-block.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 5a7a638b087f..f61e8e4ec0b9 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -113,7 +113,11 @@ struct TranslationBlock {
     tb_page_addr_t page_addr[2];
 #endif
 
-    /* jmp_lock placed here to fill a 4-byte hole. Its documentation is below */
+    /*
+     * jmp_lock, jmp_reset_offset[] and jmp_insn_offset[] take 12 bytes,
+     * leaving a 4-byte hole before jmp_target_addr[].
+     * jmp_lock documentation is below.
+     */
     QemuSpin jmp_lock;
 
     /* The following data are used to directly call another TB from
-- 
2.55.0


