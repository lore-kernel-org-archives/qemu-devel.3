Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1A606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aT4WA72m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H3ElBPE+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNpx-00054j-R4; Tue, 17 Nov 2026 13:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNpq-00051r-UR
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNpp-0003cm-76
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:14 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGUIRo1140032
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +WbODksxA/40vvkPn3EgDFz14x6jC6OEeGTOSNDyt9A=; b=aT4WA72m7eJckqj3
 XmHAlub5smDunPCCn4OfFA8y+0hO7vdSXFGjNlgV/25j+Ye2xH83ESgd9PHEt/8u
 Kq1RQ9e3XrJEaqTxeS7LwFhdxFfKmdYjnq2d9HZ/ZX01u+3gSyUfU7/BO/0wSKHB
 sy9uJcxAiI8xkrmcUmEpY5GAuBYuSM/Fz/WyxxoH1U1MaN9iUSRtI1GBV4tYpAfR
 i8OoSuZKz2Eb9BJeVu/jYJC+hI+K/TXR2HYgvjUdA3TKMZDr2uGPixKiQxR6+9hO
 Q11fipURK48lR7m8DEMm8c81tVe1MI/j5OnD1XwXOvhy5hJg+oiYUr4xkO/RpupF
 QxnNuQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd30fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b3a9ee822fso1800a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794939791; x=1795544591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+WbODksxA/40vvkPn3EgDFz14x6jC6OEeGTOSNDyt9A=;
 b=H3ElBPE+2rbcAHKFKyO32orubK/xiCdtdRk5e+i3jjj49u1+gU0tvH8bzcu+mhj+Kn
 iRMQsXKC7LeiRuDgXYB2xRCkcnGbbuOITqXFd4tVFCsLp22chnmMYpVrQ5fjMTBOA8/t
 RebBwz/5mpRZqnpNWpbrewfVNEYIpcuUMSboIl5Ez/005Sbfe/Y4dx1fvVE6JEU0wddw
 cpDmWgpINhgxbtZRTs6QbuxSJ7xnGPvsVQWFCx437C0rB2kulCfKyTg2vDTzfvNwQJY2
 K+QkTQ1lcWMPLZBn3T4vT+1ziTgPCivu12jeQBWz/4LLV0I1UeunFtW/pzzfcOpokkrU
 oQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939791; x=1795544591;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+WbODksxA/40vvkPn3EgDFz14x6jC6OEeGTOSNDyt9A=;
 b=QgEKjeO7UDf0gqy8qGQIW1NuPWsIi2FnMRPUsMY8w+vWoXzW6xCAAFlMuURGlCZq5g
 5kdRXv5fQH98dqLvOUVUoVinLUBSEcsQFNcqg+TRJ65kysgdFe26yjuh9daho+MzQRvc
 jDbUGJHBCuUAI9RUuQ54J1SEHincvludJ3lM6Ls2xT5yjCMrYPGspVfX6S+QywCqk+nZ
 JUoXWt9jI1kmyzsGtxp1hE19z+jaWQo/RvlnjZYbLeHb0833yLlM7x/Pm5i7a6ykVBo3
 tkqdYHOJQ+x9VRINkUx+04hBsQdT4scx9d04gtGfw+YwckN1SWYkzv1FsqXUBR+tUQkv
 sWUA==
X-Gm-Message-State: APuU4Z+7NI7AwuuPIM+qczAe8XVuN4rqKB1CAsEBv2QNVpc9pPQgicn+
 fr9Q51nfXCF0VhF0UYVPxAHnbuD14R0VHzOR3bWD3bEch/pSU9dgHD0WRreY/5gKT1E1rkKnND7
 ewTD72c91xnABgo8m4gJDaEN4Ss5SbzMApRYOpsqlnqNykQIMLpuiDN5FNeteazWTww==
X-Gm-Gg: AZFdTZcmmmCt+qj4aH45PTOYB89kkKUnQ+zNERuSAy4gXpqKoC6YvdfbaurXrySolOK
 zGIXKzVWaXFrzfdd+TrXP2uPuFFdbKdyAGSzCQlcv1KGfxgNBo/qCy6DGgiAo/YXjDRZJJiLCV9
 Xy3Mqp/PKEiCbxR4RJjgabPy2pPylFkQTgnvC07KszGPZEuYO3d7EaxDv3p1tesklGxxIsVM+ci
 m7t6dvO3NiuDA/i2Xgw2czXk1RqzTy1NWB0TcZB9Bx6PaOoZvJB57tKuI6/icByQke8xkGrf0UF
 IoxWvO3hiA1rzlkJzDFpfTFRSm9QFV+4C6hv+oAb6Tb9ZVYBTYLACBXKF3U6pkBqGct0fpM0Vb1
 GSVsjweG31OTt98wG+N1nzuBshAnJRO4ryiJxo9/nHjSyOvSGZmDuW99Zu3MAIRatc84UIhZohe
 E29eARAWjJ6X9VgQ8c1JRARrR6Ge/COb2BSyLK
X-Received: by 2002:a17:90b:39a3:b0:3b0:d0c5:c10e with SMTP id
 98e67ed59e1d1-3b3d07a2448mr260706a91.17.1794939790889; 
 Tue, 17 Nov 2026 10:23:10 -0800 (PST)
X-Received: by 2002:a17:90b:39a3:b0:3b0:d0c5:c10e with SMTP id
 98e67ed59e1d1-3b3d07a2448mr260678a91.17.1794939790303; 
 Tue, 17 Nov 2026 10:23:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d19a32ccsm68045a91.0.2026.11.17.10.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:23:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] tests/tcg/riscv64/system: remove exe_name as it's already
 the default one
Date: Tue, 17 Nov 2026 11:23:02 -0700
Message-ID: <20261117182304.3261165-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afc9b8f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xXatPaY6A71EF1Dc_LYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX1LfQfxBkETYV
 3lkqpWjhYZmY3hkprEK1vnWhf4uB3Ms7+YXnTxqMOUllWWIXMOHk4Ca90BlfoyvxDnIH3HOMwmq
 oU/xtaueUl8WVqwVaOwce7UEm1wg+S4=
X-Proofpoint-GUID: clk_iNyGqtNffBYchBXMHcXJ29SmagAu
X-Proofpoint-ORIG-GUID: clk_iNyGqtNffBYchBXMHcXJ29SmagAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfXwejbS2NHN+zD
 AF8BHXI+i5YyzVD7WSucFnVPs/sotzc2VjhGi77uMYsb9jLku3WAXIKUlUMRnllN7xlBy9GA2sO
 Usk3h6nFrnpXKLjVbaIlsyueZ4KnbkfYgAuTc8C5sbtYNq1RMkQxMHvamxc0g1+84k5EgcRGkDa
 wRnt9Bd7fHKnCF1P5YOe+/oBGKLS/VTZmdtn33OarE3PiLuKkY3NOiXu26gGTVb6aH1Z2w/jegL
 uVvAzXQdbqE/u38lcNfPcraYsP13wwXyCPK8oTklgpztUZw1ffVw3xan75N7/d+UH4P5bcexTDa
 lyFRC9NUuXdqpp0cspoEyliNw4PVg8d/Q1QBFFDsyXPmzXdZe7KE0uqsJDZQKseZabSI6Rpafy9
 lEyW+uQjkA8Uy7RPqRKl0X2IDGAxIYtVNnf8YWSAeWJkgpqiBWivJAYfT72Yc3v/qmiL9fxpU5v
 rlHtGmGM5wwbfVSe9ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170073
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

Fixes: e723a1e16319 ("tests/tcg/riscv64: add sdext "not on Debug mode" sigill tests")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261116232140.2758664-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/riscv64/system/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e9..9edab1fd7ad 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -76,7 +76,6 @@ tests += {
 
 tests += {
   'test-sdext-sigill.S': {
-    'exe_name': 'test-sdext-sigill',
     'cflags': cflags + ['-march=rv64gcv'],
     'qemu_args': ['-cpu', 'rv64,sdtrig=true,sdext=true', qemu_args],
   }
-- 
2.47.3


