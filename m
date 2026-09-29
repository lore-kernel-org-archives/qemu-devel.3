Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22515C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSA-00033o-IQ; Tue, 29 Sep 2026 03:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS8-00032l-UP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS7-0005of-9X
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Tnwo2570942
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lYjOHj3mPigYzWz2aN3Q+uwdziKKZp6wJgRHeU4Kwpk=; b=lMrOwzxHPFhUXfuH
 KaB0h1EpEg4Qe6RSPNOn/vKUggaNl2eq5xGfxg5cECjUlLUF6/T0ewVaznPMqUCM
 /koRyDVFjnb2zdrTKdd3lVhWyp1agTIk6BTGYNpusrtH9c8SfSV47r3zPP/qy7m5
 TB3pRifKapB5CQr7KDGRGqej2v4+l9DbAXNpK558PqA6M2nT9KOsllZqEwEQxR3y
 7iCHnL50mGIT76BFZK90o4/PfCnHBaphSzJ2/4o1vrGjVjfbcxn9m0F800DXWN1m
 QJpL1Aeck2Z9KHpIrWIQiWjtNcJZU/2iH1dAC0nQ2rZUZ08d19kPBHEaqcAf3kUW
 vUgT1g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9f91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so8007530eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667637; x=1791272437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lYjOHj3mPigYzWz2aN3Q+uwdziKKZp6wJgRHeU4Kwpk=;
 b=kLmBnBdwzXvRdW5GxDdyOSnsWahKymo2uJMm/Q2sY9Zzvhe41s3zITa/QI+b/Xgb26
 3qr8VSTaMli1PSZvPndwOlCUlj9fW/tqar5mQl9zLzVURLf3vKP35H5zzRIuwXCyjguT
 5vT9RnOdMgot/cI2NZjSyz3a34QyXgzHaYlhql1ebOmBLWv+N6W+tZXUuvpOYkRGFbt2
 x4x6482bYZEpF8/6SccURLa0r987NiCGP4L/xBhYQYv7LeJAncepJGMw0N2mdm73d0qq
 snTbZbNGLnzxM5BuZ4Bx5270MaEoh211ajC9fqLJRxojYs2rcx//RGev3Y0eG1Uh8hC1
 8YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667637; x=1791272437;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lYjOHj3mPigYzWz2aN3Q+uwdziKKZp6wJgRHeU4Kwpk=;
 b=eXydNyRGt3GUHzoAvOdOxFYmsU4Gu6sCJVBfMz7b8YHGkAUCbRGXSl1KC7V9Ql8//H
 2C6/7Wo5s55aZqb9I1jlHdbRfDEk3UOjwn8NoWCGjkA7mOTXlhqnbMqbx3tJeexZOQDp
 TpYJbUeI8iUYT76fR6ziGMLxBeU+wEbUTNQCXTDWzDaf/mfzp9SIg8ypS9yAAGaDmtf3
 4KksohoIDH0HuB25T+Dm2znnVRy4vH9dj3dFfDkwksZ5b8CGRIRfzLm1IcJvbu/SLHVB
 I7ob4NPLtmtd2LQuSrD61+BKib3WAcbcWFFS3NUFp2oBa5k72SN02VsdbmHKobgrvxsM
 PKbw==
X-Gm-Message-State: AFq9FYIISF0CawO3m3Ym68heNEFLk4QF2QoDsFZXa+x6BCdxrQ5bBBFI
 l86o4aPlJS0DCyLFWv/4sAcFwag1Ut18eAjUcD30vEUZ+BTjo4QkWQHAlwYk9NIjCPupczkk3Ky
 GuqBG6OGjPgMpnZP7OL21e/Twxn+BOcWrP+le77KAeR1M/32AChr65pPBE3aosFjaNg==
X-Gm-Gg: AYBFou0R7oBI+27nMzkbNJsJWOqj3x0sUSWrq8iVS6UquK4/5yvEvkLaOOKH3vINgqZ
 WmzI3c9JTNQX6FjLC7ZxvOYI5AfcZOwK2hyIU5EKsRq97POmQipASBI1gdQXk51tS9TR9gFjb4K
 5HGRsBqIwyJoFrPRJufY0qQL1ahUcysBuNbngOC5k2vhjqxfJyo/FOtIFmpYc9KhCiP7MIdcFSF
 OIXue+VzWhWjuHIFZhPuHTekhMq7VyLaz0Xfpp1ySMagMx5tb2MERA3qzl7f8Q3gv4FHNq8zNmS
 LsQvFoHMeDtNnVSqk3FlphbgwNFQveVunvylRiMwBU6vb5Ax61q4Gi6amORwImW7ZCMN3Odc3ms
 RVzaE3Don9yzLYTy7UdD+qWVXpNkJVAGfgKoiZSHVlNCeYn2MFRDfGj2Q2g==
X-Received: by 2002:a05:7300:238b:b0:33c:e8f:5700 with SMTP id
 5a478bee46e88-34272c5729fmr17728827eec.33.1790667637050; 
 Tue, 29 Sep 2026 00:40:37 -0700 (PDT)
X-Received: by 2002:a05:7300:238b:b0:33c:e8f:5700 with SMTP id
 5a478bee46e88-34272c5729fmr17728791eec.33.1790667636511; 
 Tue, 29 Sep 2026 00:40:36 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 05/19] tests/tcg/mipsel: add multiarch tests
Date: Tue, 29 Sep 2026 07:39:53 +0000
Message-ID: <20260929074007.118970-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb6b75 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: -M_FRuqBx-gAMPR8_gWLTNHbWq7pbJ5Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX2FadBTOvCwys
 8uf05fINGDfqG3Aliw/N0lhOPGtZOkRGJ8E3vEp1eBBJU8V63J/45TlMileq4yEesXUvnXyftNZ
 WrQLIaYNCarYTiYxReHYbK5AHsnmS/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX5OemVzZV/bA8
 gQfPqh1xfQqxdyseffhKo+RI6SEpRodGg7SKReuL1E+V5SBzXNwZ0Wbj+btVvX1xGVI61Hv9JYv
 MUA68hzOaBjEeQXXflWejytnKVKnF9UOannVO7WYtETEBjQ58G7tLZcw81pSZ/3lYUHOPyiHRjs
 07EUc548bLgkeoSQQEfdXEArpl2dqjwBcb1w8fkCV/YWmX9wwomPCnQNL3UwX+FkjjTDITHrYLT
 hZzUE/RiAUlD2eS7ysyKmPy6kOMOsQb/0izJHHeWEFHM+TcHFykxhkVj79q5VKyw7CGNfH7rtOd
 GlNjUr7GIewyMvZx5kDXELYHU7+ptrctZey1aThlck1inOBDoyNL0w7y/8v5WdAaLOWcHscemgg
 w3OeiQDuW8f2PvLKafp8gK2RxGXyXIWjoAwkuKw7FU5Z3ISPX2sqgdp7xcTGDPOdlS5kvrjftQy
 aaMXWZI4iL2Y2XnRIBQ==
X-Proofpoint-ORIG-GUID: -M_FRuqBx-gAMPR8_gWLTNHbWq7pbJ5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0bf7e840a7d..a02a4bac289 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -1,5 +1,8 @@
 tests = []
 
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
 tests_dsp = [
   'test_dsp_r1_absq_s_ph.c',
   'test_dsp_r1_absq_s_w.c',
-- 
2.43.0


