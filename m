Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7084AC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gi-0001Nu-Nq; Fri, 10 Jul 2026 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gh-0001Mz-7Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gf-00061a-PH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nEkv3752799
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=; b=lnaFqOQIwC3mwv5i
 NDlJn8Sglay9+zgqOLTjzYQ7iCYyvApnDMhER67rmDCocX0fdxUV1Mm+6IciD5+r
 7dcXAijXeAZStSx1pTTtBH6Nc1F0+OxdkmWPFfSpM6x6GvUHKUWBToz+W5CZkz3m
 Nwd7iRWLEO2m92cQ2AuWsAf24Z7CMCvUAfj1Bor7Y8J2OmWHrgBpEWEQBnEVmZV/
 mx9lVi53Q1JebY9MScaxqiQO/aSxsD91BvFCKEAQ/i0SEEEFXOu0wa3gV7h0ojsY
 nRDH3AYw3RkzYZQnqLji3/t1GCGePTwJYEgcVLF0jUX3duVys28gA6Ufv4S54suS
 0RUZYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbabr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so1089977b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664762; x=1784269562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=;
 b=g+Thmxo36Nja3jdOu/jmGyT+BHMQnvGSbXFhHIHsjk3NHbuBrS1G7U8ki+rVeCivpo
 CK+d5oPPS90fSUN2M2Ex/m49Z1Pg6MM7B2LEETTMbBRYtHz2ljcHunAdHt3KhWisUpMN
 O/+GBv5eO9//tYS89i/aYhe/wmOjjRM8LO5A3kQSqSCuoeDM6lY4hBHOYO/ptGE2fWg/
 R4qz9kXzFgVoQB1an7+1C4qBTvAH+1hP5gqi3zYVEDdyKYXDjZTxb7+IlacxZs2mmywC
 rw2Gfxh/XBqo6+49RqaGVDurMPsnUcjabzzm06hPhzuWNjp0yolP+Pf+8W6h2YJ9zKDA
 emeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664762; x=1784269562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=;
 b=ngkOUWCECq25UPMMCVSyCRYouVysw7mh7brvy3eNUIuWiDgkRadr5caYrv1HwwT53g
 19QL/DBN3LQU7sSVp5dW/PdGvaocqROqLDML5p9WrNKdhDbBtjE35Yf41h0ki4ctIlxj
 UHk/YqbD31sTYKJ7PZN3UHoBXNHs8HaDjjjEkui77Umor8RX9sckzH5l9QvOIHvTVQRP
 8TS+wGnYejK+SqZZp4THneMDnfwgAMd1lA/3Cwya01yC2equ81fk+SKClo5XFKpEYgTu
 2poZdqzn8ML+Kt9zNBBjXoJ0pkOcrvmH2Logc1sttuACJdk/DHsX94edmVsB9zGRGNNo
 HVXg==
X-Gm-Message-State: AOJu0YwetyS+KfRBofqndsR5OLgdFeNi7TW38Y9YGUpNaO8hMCEqSYCD
 /ZWfxk1QWG/Uk0rkFDBsTbtDVFiT+3kV0c76iK0OoxyECVvHP8AAUn0o+a4xtOUVPE3fIhr0YMo
 h1EntxZtMjKh3Sggf2cZ34nKkK4PdoGgDBJ2Qz3RTUmwN3T83cd/FlxO/n+GCT2J09Q==
X-Gm-Gg: AfdE7cknMqOv7OtQb69JuFZsHSIbr14m12ywo4mrs+2xpnrOM9C7suAqjEKM+wudV9A
 1wNnKXGKsYZVXAqOMSIcEaYHZkJIHftNp/7O7+8iG2r3+lelsfLpx40DNTb/Hz/qPiIwC+r4jkg
 CtHoAKiAd+lfP4KcFBZe92eCv6dD06Cl6tYYMbSbED4Dod7vZNlQ3lJD62dfZUN2jKnEV6QUwDg
 LR7e3zgXG6quLdcQVgS4qE3ysNOuQ79tZ+7meS4X1/xTJ+Ao/KqT6/+4Fe5IgXHRpz3FwFm49le
 Y45QA8HBXneI31m5NUk/Q4Jwbua442CtegY353Tk0jkpsb4CjNJCneKzOBJNa8dXeqd0uA9w1Gk
 H46NLS3bJfETWCbJmeyyJIVblowGD62O+ZWTanWlYpqa68Vf6qhyRpYNZag6uxNYVlg72SM10W3
 PmGryvuA==
X-Received: by 2002:a05:6a21:495:b0:3c0:9c18:d5a2 with SMTP id
 adf61e73a8af0-3c0bd19f15fmr12648490637.63.1783664761736; 
 Thu, 09 Jul 2026 23:26:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:495:b0:3c0:9c18:d5a2 with SMTP id
 adf61e73a8af0-3c0bd19f15fmr12648440637.63.1783664761207; 
 Thu, 09 Jul 2026 23:26:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:58 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 66/97] tests/tcg/or1k/test_addic.c: remove unused variables
Date: Thu,  9 Jul 2026 23:19:44 -0700
Message-ID: <20260710062016.1818125-67-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX423adB+duN7c
 Oa4Pd9ZdMz085R4qKcBQtxcnAvnuXxSVa/zVnFDVLtrmAT7kEnlnLcujzXnqV8YUOc4QgPvQS+K
 qEzYJ7rFXs6xPpglP01r9mbPoUw07hWercehI6WEX4cfYV0bqXFIea6w4ReoOPN/u2gxjOsp+9U
 FsU+BLgUyZwZbTko2kq1NrhiTvmSuLS40auP1woOXv4A6Y2B413VViAZ2r9wp6ltWc1gxGDFon0
 y7Xzers0r1+JGg01rTii4X87sU4kzgI1X6Pw534ZDydlTPQvwxFBwEVwHXMMAXwOdrN1f3jOFu7
 XHaqvItsLgNOjbZ3vdG4O9h1rMVZCcfZNC6DMtqyZcW0xcXju9bdbiEeR9vStZV+WaFxN2vZTo1
 E/fBJVdtcsf1GR2cVZteKFNDXa9q7zd3cFkRcntYLlCaujj5vwBCQV0jif8wq3NKxbr0FZj9PAV
 5u5RACs35emhRpa05TA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50907a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PsIqEVpCGnkgeXyWkhrHZOKKb8PXQyqZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX/yYdYS7r3xnK
 qa6Kp5sN+RHegosBGlsNZ3Q95DrC0vspzOzkPRQ7qSaBuwNDypq+puFmFFjw9GtjBZgCcFqzwC4
 gb70OiQWW0yEmbN/yc6Y5TGbzgUbGvM=
X-Proofpoint-ORIG-GUID: PsIqEVpCGnkgeXyWkhrHZOKKb8PXQyqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100059
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_addic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/or1k/test_addic.c b/tests/tcg/or1k/test_addic.c
index 857aaa13302..27939c64ff1 100644
--- a/tests/tcg/or1k/test_addic.c
+++ b/tests/tcg/or1k/test_addic.c
@@ -2,7 +2,7 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a;
     int result;
 
     a = 1;
-- 
2.47.3


