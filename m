Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2316AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPL-0006bg-6x; Tue, 18 Aug 2026 15:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPJ-0006au-6l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPG-0006ZN-8z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGi9Z1518074
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=; b=k617ma/KJ5I00B5X
 dr6KI+S0gR1xaayDzjBGluHMoKUWaKOA14RZ7CW57uUQe8y60W6eM8bVWFXDW3J4
 VXc+z+YDRw+yi2VF3NfRTR000Hz0PIFL1+rsov2qmS/gLecCVB5w//Vb6bAya7gx
 GoF0r/65ZHV5/1YPCxX0tWLNgVKac5xCz2fOw/7Aczf6Zgo+QXwy8ax6oj8CZCH5
 jRZOHIwF9jBn7v8CahzMRer0lkKqnwbk/cIAG/asEa2yXrAh4sSMXn4BwMcOOce7
 tkR1LwSAYIjTMQWktZJyPydjyy3LAPv4VljcOZCUdIH8Z6PTtlz+1T83vHEqjb3v
 +yQ66A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0ncb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so84743a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081008; x=1787685808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=;
 b=bm3UpwPMGrBzNSUejbficBM4Uw+DXPuiDPM0BTflDuWkXastfPiA25Lanu/WuaygLv
 zg/pOEviXSfZduSwa9u0N/oIpLM/dKdguzNrkQmITlqGhbt03Lh01h8PTidKIY58seL8
 tGWHezsldrPK7dxqxtafXXff8Ui2IRtdFy0/J3J733W3PLxHNL2MUaaxfG2kJMllEH5R
 puNmogPKsfno1OlgiBFw5I7xoHzI8tXosrXEHIXLEVQ0/A9nWVbFPX6rtcMQg9hdExRC
 lT+CdziVUrtjfexuOuCZ8VZTr94YwkchAoMeXZwvA1gwEMLAdxH8EPC2V9buri6iUDmR
 ad3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081008; x=1787685808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=;
 b=ccSlJu0l7i2aJNyyTDLhRUZXMho5/vDSe0AyfvYO9DuRkpuzwyM+tZOV/DrsRTv6+y
 UCSc79f+sBLekkWJQ4mwmcOZUDEPA3FQwxXGIuukpvgjMYOvdEDO9Imjnln+g9xyszgY
 gunxwLAxlFPbKHaOGsC7xHXzI0dCweYK4nXSYAehbjpYdmE1gyPkKtCjbCyAG6Jm9Glv
 HUMn7RVty2VPgT4de8+p2+gEUvIpTTZu7C2/ys4uYv6F2YkjIvPZGNHmSzb9A5k7Ra3U
 McitprVBTFh4LIF+GzQi77pJs7VpYGnhkZqFk/7CTKwXotl80+3gAoK5j7mYD5KHPOhX
 gHlw==
X-Gm-Message-State: AOJu0YyEGMZVjX76exvx/qB9a3hb36Lb22XqU3DGScs/Us+reY41wyg3
 iGLTZxvPHVwH0zfZRGiufA2HC8OK4mDkaQjM0H90lBYp5fPB0DmSL5l04Gbcd3F10kPQlVUN2jI
 gPS2aPUNn/HATzWTmvtzBxvYgPLUVzmuc8t02AkGQKUFgHueQL0CAziImJ5g7YAe1Ug==
X-Gm-Gg: AR+sD12TQ+yih5sLrpOPe1FT88HaheY8OK/nl1HJexIoh6+eVd+y8ID5KrBcUJMgaU7
 8DxQ+Om42c/12sCedxu3oDCu+HTXd84BnjBqT1XhLPFWihacU4nvz3P5pLzDabYrhwUjx7mVqf8
 ze0xXTcebwXlV72hq61asZXxwJlGgcvFyfTVTngPxfDlbPujHY4W6FP4CrpqcOvbIByG+QBLF25
 web0yzq7ckL90ESxwJqTuU95dJVHjw4H5df1Qxj9OsL5YjBRAfu+1g711AOKusVke37xP6NEPzD
 ihjVKUbBRpag/h/1nC/t5PfeIU/QNnOG3/n/7iXc9aS6pOwRkvRsdmohd5b4cXvyzN9m/LQLycI
 ykfMx3YfQUwH/lHcxt/aa8N//mUxcK08uLA27z7qizyOKwHOOBKQ30lCcdnQ=
X-Received: by 2002:a05:6a20:d28b:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3ccfec89780mr327987637.5.1787081007991; 
 Tue, 18 Aug 2026 12:23:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:d28b:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3ccfec89780mr327882637.5.1787081007462; 
 Tue, 18 Aug 2026 12:23:27 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 006/104] tests/tcg/meson.build: introduce exe_name
Date: Tue, 18 Aug 2026 19:21:30 +0000
Message-ID: <20260818192309.22169-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX8/o6XaEneAaV
 Q6KTT7v1dnK+FZqfl2w6rFp5CABbERcWjDFa+rT8ujA3OKdfUJfjqUf76j65OLyRRqLab3cAXUc
 nJYFG/AP9qB5NAriUAjD6aTGp6s/SNn5sjBlVqXw/aGKwiPfxfZwib7Q35GLo0bGpajkhf1+/r4
 y2aMTeA037BCEFYbMvb2vCORX1O+Da7ot7AVRKnQgYGuy5tnZH0Rcglm4MSz9ajzKh2Bd1Nkdb5
 EOKpTP9i0f4mjv83goNGtcAoscIeFeDnikhK9L87YjHxC4SHqj859p9nKMo/s/cgGJyRg3pt2zw
 YH/vFIQE3Jbah4waD0t7Npy1BuaWCw1UAzqT91oK7A7Yp3qGFwK9l3qlmpL0TxDlJAYdj8iCEM5
 MxUXo2S4hrIEc5fC/WRCpUr8Y+7HnukoxH3Yr8GSZXFIplzxLymzQR/gCLlaooAr5z65o8BFdDX
 sVPEhtVCv68Fseaf55A==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b130 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HdctNaLXR18zaSj8uIXb0eMBSWd-jBC9
X-Proofpoint-GUID: HdctNaLXR18zaSj8uIXb0eMBSWd-jBC9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX4tBOK6qc8P5u
 Xpt24pAM2bYtZYvnelGujcpCDwmDwTaGv5jbSfUhGB0yWSg+x9leYnxJHgJJZi9wZ+yo8GRrd6Y
 bdz4+GWio1hEIc7w37rueqXroklO+6Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5758c7cc0b7..697b826a382 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.43.0


