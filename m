Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D603C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSS6-00032E-NK; Tue, 29 Sep 2026 03:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS5-00031m-EJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS3-0005o5-Tx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TnGR2570882
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WNcN19cWVdUkrWuhtUrmsUh6O6lQGwuVvTKH4mMjRwE=; b=IJEXw4IuRayOxKS7
 YKivdpY8dzXjevRx3rACKDfRBUgm00Rh2gvJ96103CTN2SOHsxXx9EURyUtzBfiJ
 4QOf2ZrwAPbWVBM6HEEL03O2o9nzfBqVdAb86Pr9vm6q9bYbCyRKuD3YDL+CaYgW
 PVozu5fIM93vR6S9uSDofhD5wGRQgV3y2Mv3EK/C9fSP/U0W/N3TvQ6C2ccMFV1J
 8ZafobxY2URIyVekdigThcpQLq9y+8WWF2CydEQn0z8sEOqq81mkWUbea4ykDVkd
 +HkY6PVeDLsuRRlJsUHe7B2CJLrdmnPp+40JaQi5rw41VkZdzjx4/KHXQk+qZr+k
 FMkxcw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9f8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-349ffa249bdso2683831eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667633; x=1791272433; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WNcN19cWVdUkrWuhtUrmsUh6O6lQGwuVvTKH4mMjRwE=;
 b=WcVLZ/284JeYdMnTAD81j/dkuFciS/u8L+NAIrQnD24dVJP9Nmivdirh8O3nycuBHc
 AVx1H2Iyrv+5A4cViato+TiLMxaCrGNcxRkROdyZvrcqDEVW0EdqU1zcrKuJ8xiltg6a
 CVqpQHYlamxwIpIbLFRU3nMvfDCyJ2jS7qaNfkpIobShaXvtgD2gyu5TAjXSaonoxfSu
 /gIUvuoaNyeI3ttkbsLTKz6LhttZKQiEY0DpVXPvZyvpSPC/3KL7LGQFmHVL+XZiiGwp
 XjGDeSzb4EAkcYVXux9m7TWxcsPrh5dlm0CiTFm/xuSBwXHCdOWHN6IDbWZMoG5oJru2
 YjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667633; x=1791272433;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WNcN19cWVdUkrWuhtUrmsUh6O6lQGwuVvTKH4mMjRwE=;
 b=1bsZQ+5qjtJPt2JKdTXRh+RpJfyc5gO7EZD9BP1Cb7O1t3g+OBpAKqBgLZixYCiL4s
 UWgvvVEKPJ5ZD0/4HUVpurg8dGKqWRL904+HFFVa1y1YO7KTXSSZ4C4RlJvk+u4TrPvq
 ITwDSYNTfDLtDo2cZXwbIncXbIlsD58mzODnmPPTok7/HCquQM/e7XyR0EIzY/c5rJhm
 P2kno6MPUdtjUydgLKSPYbM8Osw2lc9QML5gAHjeofzxE8AsePlqEprPalP1QWAloD7o
 qwTxu0wodFL2gv8LYq8r655j4s+2vaPsXBTEuX+MHloD1moQM1mfk6KHEbzHRM2f08Gv
 ScNA==
X-Gm-Message-State: AFuF++nIBle4GZMKj05t5D+nrjL9xhiIk90wwC5CWCGW/kdYfCKXLcAG
 mI2K88ZJLoyPd8cR23MuKpFU+rdKDQKBR1qyVUEbafZ6m0acx2ttQb7Mun/sZbUl5mYekC90chD
 3BsVP6Ck54AiFo+5yMi3yT5TVAOSgwgcvLBC241G4MEAUeDMgyH92zhch1DreejTI/w==
X-Gm-Gg: AYBFou2SWNRcD+0gS921viE7tLFAS5jLrU88ZSkKcXXgjoCAnfTsUk2prCnuXyur6cX
 iySPPpBtwnZKTCzxbMibd5rvrLkTPLPPJCE3w5zldccwuJDbSgiRy9Mhkg5mZ2xekdPiSZu3UW4
 +7X/tzCH4GfaPsOqcUraffKe4X5S4LlaxKNxCW/xH0TQO/WTLtHKwjNbIAJqSeEJQlkcQpXYU22
 Uj/H1gTG8tiw/Es7FRocWttYyB358CJ3pUQgBq64zlNqL9VNFW+RnQtA0kwwPZpAfl3cRiQI5Lc
 1rq3GI8HicIf44r1cJfvuh0BTqEXvwNzXzMg7A0lmQk2T+gYO6yumxZkje8c150xj7lEwLoOTVB
 sL+1/1FbV1wbm52c1r/cjhz/Ada+Tvxd+KYNOVl84SZKiIhdcvjTFBqTUrQ==
X-Received: by 2002:a05:7300:8189:b0:342:e7a0:2829 with SMTP id
 5a478bee46e88-342e7a0534dmr16610089eec.26.1790667633200; 
 Tue, 29 Sep 2026 00:40:33 -0700 (PDT)
X-Received: by 2002:a05:7300:8189:b0:342:e7a0:2829 with SMTP id
 5a478bee46e88-342e7a0534dmr16610056eec.26.1790667632690; 
 Tue, 29 Sep 2026 00:40:32 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 02/19] tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix
 compilation warning
Date: Tue, 29 Sep 2026 07:39:50 +0000
Message-ID: <20260929074007.118970-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb6b71 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Ja5cgveAd_IYRmjxbtUE0mCFc8JlPjtP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX8ZBxmnGHRdZH
 f0U8cmpMED7UMv6z9nCzXDN1CZ2plkWagFrWKHYwbrPToOXQ2d/VtyANxQGDY/Ud57xvIUbevb6
 dNwBTaTGU+zum8i16E9falrD1kMUz3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX9d8WFGugHmI6
 MvCvGJbTFdG7g7wjYx7H4VHfbgCL0dBnluFgf+beYFe71H3tyHJdv8vu12oxgRYYNGm8b6IL8OW
 Dujyf8175SpJCzESCC6ua3Jxyei61nK153/iOfqAVOwfTlkZ4pClzTyt4O321QvlYMb4To0qdWz
 +E9NHgBtuXZyRtGYWMJnS/VIbo3+uz1atEj9XtFoniIsgIQuTa32AUdtheJLyidE5xmUwCU32qN
 R6AZbOu7GCQozCToKpZENWljPbnRly0Q5yXqQ9O6S/jpspkEsdEHNrxqhctXf+Tj5mf9Hy0kpf8
 y0IcZOIkhaXx/rqtza7SC/1UQi+oXmr7S6oUT5AkA/IesZMQQEmBr5LhyjHgdwky2bPUnq3BeJ2
 Oczyn8aSMk4CdccPflFTjoC+hgKsw9XljOE8s4i8Ff3QayeuvUP8fbZRpzwcRnxfCljilfYs5WD
 dEERuXjZQSta6wTpK1w==
X-Proofpoint-ORIG-GUID: Ja5cgveAd_IYRmjxbtUE0mCFc8JlPjtP
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

../tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c:13:5: error: ‘dsp’ is used uninitialized [-Werror=uninitialized]
   13 |     __asm
      |

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
index ccceeb9f4ce..10c182a54b2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
@@ -3,7 +3,7 @@
 
 int main()
 {
-    int rt, rs, ach, acl, dsp;
+    int rt, rs, ach, acl, dsp = 0;
     int result;
 
     rs = 0x03;
-- 
2.43.0


