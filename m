Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDACC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlL-00043A-Ek; Tue, 28 Jul 2026 00:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk7-0002nU-Ax
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk4-00029Q-9L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bA6l1062923
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=; b=UR7n66Z8SSljTtkO
 ppaECEvia3KzJMdSwR0m2yRSX6jp0kNlf3DhBTi9X9Dq5F4dDF+IZmHdz6XOEwbF
 041Ii73RLCvXu9+O2ubTmXH0qqWKrAddkCXkX4K07VqUchDlGs/IZofqOO7uJmo8
 h+XB4wewfAnPh3RevfGJVd0Gv05+h0VYNWvnYJ8LNC9zcnBABgvB2+ZHAPTQHthY
 0CMf2K4WI5l9jgp/EuAboViWjPf1sh0lDLKJwTrCK5R+SHIiIViSmF0/ByD3pnai
 LvkI3fuWk/DlT4W74heKeVmdZVYqHGJJD6KVPTH4AgrZTob2ksMXUYiXPXlBM5H2
 oyI0bQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6chcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so9592635ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214104; x=1785818904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=;
 b=gRdpQofTly5pKSRDBrfiQH1uI9d7yavUsTCglYW2DMYw7olV4qoh+CoEps2cll1T5V
 p6eHn9A/Auv8slWcnWk+DO74j6oRCYUUPCSljE+MnKSUy7Kwka3MSx1xUgGQ6Tad5JEV
 TsE8UEMkUwlfC/B6eO7YMsKS2SwbQtY+vPyWzNFX/zh95OIFtNtp+uLMEAKah/WP9Glw
 QV6D7doZhGOZVoi3084aNEv/JvznTmtUXDHnHV+HBC9EHCmM1AMjkDkcsGChXc4qjKE1
 Pf6wCfd+GAPuzxNH+4my4/ANKrUM5KQD6wpmZLiEke0FTJ+i3hzig1kEvFtvTKvAR9Dc
 WkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214104; x=1785818904;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=;
 b=sHgmD9P/cHIicJ4khUFsgI985L6CWUNehQZsxj0bmKf5wphBg705aCTlH/pW1kNWz9
 UsMZRz6DSoCs0UsWcw4uIuMsSy0Yk/8YSvq6sitwG2tIJKuuv9Vlnb+g40ljDJkwpky5
 idw1fK+Ghu20lAM0GGAsBhe17Ans6bLfxLxMgSf/qvkxgwS9kxjIAMXnnslZC42FxbxN
 GYH+wtRNp9Yoo46ZQxogNdcUYML6fjzVAg+HjvVsTNhVdpiOZGzVr4/QTxwva6AN5EmR
 7yNE1UktOJ8iOx0CHoKJYkqMD3vxDy6tcopKv5K9dlvTAwYH8X2P2J2wEm1pQC7LHedM
 ouyg==
X-Gm-Message-State: AOJu0Yy+6M73tfMWnnYuYsnfVZpaHUWY1B3JZlm8Og8yj7d0lw1rZqbA
 /cuH+ZvNM0jkPAk3oXqVgkhXNKdw/bkz7vr1IEIHT7W/R2IBCFmgDO4vQIFbMKANaw3e9SAZeO9
 BFbdIcpiTxbWnewo8pEkYwrG7qBdQw9Me8RDFJlia1gEfqkT/4e+lRYkP4biUQDt8jQ==
X-Gm-Gg: AR+sD13hhAGzwQXSaN5UEW1q7JnF7maYQQ5vEhRvhVal4sHXR3dao5NKXnQEta9H768
 X/5dTomZakvMspQdMq7sus4zotEgRD8gcWnexQsrlkiIlyI9J1T3h7U5coM6ojN0Uoc/XS7u1Pp
 dzF6tzzh+UwglOE+IBDjtQAawGUeLZDkcIi8a4K5xkUObKugMPx5wjVWAh2p50d8JTJgglEkXHk
 hxhnnHqKoX1cFAhzlikHvVH/Us3PopzX3Yb1fafTECi52teHJVC5sq3baOcO8yZV6q+9YmYQ7x7
 ePger6HlV+dEhKITd9Jvs6/FEPNpZw7bU64YM0pld6HiqWji+CIoyzj21Y75G3La7IpwZObVdkR
 HwO+dKjCO7sLBAa9CfC7liKfM6TI12xMoj/VsAM0N/O8X75CdiT4nvq0p3v1e2GVQNZbiJqk=
X-Received: by 2002:a17:90b:4b02:b0:38e:9784:dd47 with SMTP id
 98e67ed59e1d1-38f6a1ffe0dmr898150a91.1.1785214103766; 
 Mon, 27 Jul 2026 21:48:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4b02:b0:38e:9784:dd47 with SMTP id
 98e67ed59e1d1-38f6a1ffe0dmr898136a91.1.1785214103319; 
 Mon, 27 Jul 2026 21:48:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 068/103] tests/tcg/or1k/test_addic.c: remove unused
 variables
Date: Mon, 27 Jul 2026 21:42:12 -0700
Message-ID: <20260728044248.137626-69-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX7g7KARRL2YJt
 2DDW8FMfgTUPICJtSyLQK3+t+LN97Lh7koUQsxPxKq3dg7du01T613T/cjWu3D/2UajvsPIJULd
 apm5cnqpxYElhlEyRwYhZOe2KyVRPzo=
X-Proofpoint-GUID: tuK6iwM3wNsRfLNt5etzx4UhQHEfKWJR
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a683498 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tuK6iwM3wNsRfLNt5etzx4UhQHEfKWJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX3GO2NZHPM1C7
 v8yptjn4KRj+4soj868zbcRjbEqRAMP9O2AgbQSvnyjXyd/VAymYgcWjTM4nMwejTjfS65wl9OK
 YYYJP3IVB+8g3e6xo4xdKnH4zbwLAmtQQShp9kFT0FM+fb+KkqI+sxgWUznPIwqVsK68s9UdmuS
 WR5H5kiGpbb7pSrcAlm88Ymx0Mx+ZVmRQRKF3k8OwT5KFMafJDjaDhBJBCMc6+0QyYzamDI1Beq
 yOLRU2jfSEsL/YQMqVCjVqipQYEj9TEVASlM4t4PmrKMxnfxi9Aa4FEW1wwrXW4TxgWBNgadw3A
 xsVM/OQ01tNhWZu5Z4dWN4t6bTmGzaCaqPvhgufiOSKmb8Bg+xQWXQb2DpwE+YiLvefdG202unS
 VdtFpOZMLFBmFFNqXFPsCl0jbGHuff5IMKg803ui9OLtXrQtW9LgS67se15GKZHgie3vull4gVd
 xA3iLjLzmZRf98GVS6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041
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


