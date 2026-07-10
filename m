Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9CBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4le-0006QG-Sm; Fri, 10 Jul 2026 02:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lc-0006MK-KR
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lb-00075L-43
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:20 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n64A3661828
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=; b=AEECz7cTZJlkkkNz
 pQfp0RSxtnfUgx8tTpriC3OnjB9IslCLePoWZ8IaipjThRd+Z4iHc2U72GurpXFr
 8ceYWw0Lrl83o43ypoldZj1xVA3tybYHmAytp1aJgQOqpXXGPDOyZS5UdQL5dKg3
 6nnV99YvNFJh7jpDOYZFIFTvYkm78Z1r5wA11nElmhSrh+1+NvdcjIzMmLEb6ryn
 cH8GZnp78pjmqmeg4KoOBnvd2I6VFcNPktcNZxJ2ApfebVPlw2gF0XZnFyRD7j1U
 T+oGfa+OQK6pPZh3Uv1dOkApgtL5Mn1dB8zcUKKsyV9J90Ei3CdDDOrSQBmkBpAM
 4Zf9zg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24txbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cccfa32670so7930085ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665067; x=1784269867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=;
 b=LKsv+5FokLCCoYSTdE1V1xYQequGFdBWXtzur0ua6rw6nPzXDl33VYNeGSz/Bw6P3T
 puOE7si3Exh88lwwogWTm8Yq1zG3rkKTFGc4/Dg183A+Nbhf0zP+BJlfUMdwfD0dRaoD
 LeUFGR7N0+6KbnTP50agwSafSM7GkuXNRS1WKytR+yVE2mCsSbYwoTGueRmg2NVG32v4
 QAFtVzlqexzM5aCc1Itl3e8W3Lz4a5BoHVVZTZ3fp1EAQiAumuX4peHWurlOpsYXiqVK
 H8gPUTZAJfof9h6O8krwal22vCydF4lvPxwVcWWGr/LNTGOVKP8j0Cn2kSKjto1vTvA7
 CACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665067; x=1784269867;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+SiHtRBNrFz1LBCwuIViSBLrkRHrJcYuv2aqDvTqCI=;
 b=L//VdDnDXTGwvHxZuR14oT/3V7PBdruNs14MsfYhfz83tLcuWZ3DXgd2zllVtTGSQp
 hd2NUHfafXH6oZwVE3EsU+Y7bGAuFj22CokJAj8op/IQQfVKMZN/gBJ00VLCGLNLaZUB
 2Y1RlO0wRHnf+gATNhy6aU+v0sJwx2WT9YwZdjsE9788RQSzuv6Wags5ZzRvdb7XbID4
 CKirwBPyjSzIdfhjSOrzPyiqdWweaFUS+YUh+Yuid6f1mSJPcEanbmq81mLTeuvcUllg
 mCCFc4msONnG4CbSEhwa3ixBmZgKxOWHSzi3icse3ygSUbr2UpF9cOqsIzGug1c2RQg+
 kZCQ==
X-Gm-Message-State: AOJu0YyMwzQKsI+3QX7yNJMn3bD9rODv4tyvO0GubXaRXtcEbomA1LH/
 ukBzY53933tbta2d0LF0cIsns4pFfNyXbHzU45cs0e5cK4s58woOIjZT1M8orvptNbz2s1Ln19M
 L+DTSmb/lzsZK2tXXIj/5QuEJXRw2z1DA5Sv2fHTp/X4cuUrDfYCdXorAcvK7BIlabQ==
X-Gm-Gg: AfdE7cmY9dMcn0L9BZQrTdzSBYfxLLSEhQeDdxEGNuH4RdHw6uYH+mgpNwg7g5YG/c6
 jmWt6WEmEn4i4HlisKnAKPHkugWmMFz/ccJ4bvbXfunH2ZZikG2f+ZTbGG65HYITZadjcpmoJUC
 NLoXBzVq2GnGaeaZt37Mv9TJ4SYKRm6OMDV2Bl0nAxw/46Z3o/lMxHuycns9mUClkhy7LtPzNlz
 Jh56fVQFy64iOM5+hGKWiASweaT6ViOeOy3ZEdeaLOLr1SiB1+itsKeWhj3WKb4mEBGlFDdMA/C
 Q0NgOuWU0JIQu8CbZejCPyPALN1THz1TcPprTsmmb/RfsRj0+hkmqfPI/kM5OP8/iSEjeDuvc0I
 wRoOU/hz6+0a0QpMCA+7N1DWto5BXKEx9H/SLvnbbbFxCqHcNbH9obCffNXI1e5kz5R0AtIcRXK
 dJRd3xXg==
X-Received: by 2002:a17:90b:2f88:b0:36a:c4b:76cf with SMTP id
 98e67ed59e1d1-38941acc562mr11313636a91.23.1783665067163; 
 Thu, 09 Jul 2026 23:31:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2f88:b0:36a:c4b:76cf with SMTP id
 98e67ed59e1d1-38941acc562mr11313615a91.23.1783665066705; 
 Thu, 09 Jul 2026 23:31:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 90/97] tests/tcg/xtensa/crt.S: align .text section
Date: Thu,  9 Jul 2026 23:20:08 -0700
Message-ID: <20260710062016.1818125-91-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I3WN48up1QErLuDTJ1g3Ud8vkjO3O61g
X-Proofpoint-ORIG-GUID: I3WN48up1QErLuDTJ1g3Ud8vkjO3O61g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXzWM0kj32682a
 X+iQZrSBqOL9FknU4/s3Q2iKW/Vw6kW7qtbbVtnQH5ToTAWIMyaqWvqzrmca03eqXFiFBWYgkSr
 dHjBz7a6w3zmEfs3Al4SnsMzm5fAWow=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a5091ac cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=5InQkvVgWux2XAX5AMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX3rvHd5yTMU0a
 R3SXR3sKs8IxwOElxt5mNnoAhsjc5ovlp9U2JFStADDdhXwmPPJkEA3kjs3gFEqf91pwJ7RJ1D6
 bCVVJea/f/Nnplg2VXmAUkfg+hH+Pw512PHnsXHo62LdlZifVEARgfQ8p9igQrWiKcymvCLBzXm
 s95+iwZaaXmpN1Q/cLQYJ4jMbtFBMoPyFVnUCweZsZwA1/G0laZ6X0cHZ8c+gfC7YXqlycSDIi+
 PpXIZJ5M/keEyK3pUNdLGYWW45vvs5tADDLBExi6zCjQs4uF2nW+rCItWVFaURv3nuQ8zR7fN2c
 Nv9wm+h9pU6H1N1qrOmCLlpzvuqivSSR00+REGQ98XaT5GRgUUuNtxpXBL9GAm6tiEGssZVLvjf
 mvLr4iRppRDeD+MJZbDmLXS9CoJiIPTWbw4hUn1rkVI9pJsvLPPsp5Ysz/NRWpisl4a45J/yzs0
 c50MEQt+f7vNBcSiFDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060
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

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/crt.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
index 909872cd385..de8fd8c1cd7 100644
--- a/tests/tcg/xtensa/crt.S
+++ b/tests/tcg/xtensa/crt.S
@@ -6,6 +6,7 @@
     jx      a2
 
 .text
+.align 4
 .global _start
 _start:
 #if XCHAL_HAVE_WINDOWED
-- 
2.47.3


