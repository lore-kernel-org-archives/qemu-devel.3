Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6282FC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SAG-00017e-9p; Wed, 23 Sep 2026 14:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SA8-00016g-19
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SA0-0003Yf-NR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTuo3596183
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iosFe3tOZMB
 oWpCgd3gG+3JESIHOn3dFQ/MARSxCGf8=; b=euJmlQpX5EY5RPFIDa+wkIdCEd1
 UH5pIBjHvokYlVMb0n+VVpKNhc0C6jnxfYP0nC5ZxvR7aOwGIHN/ASvrqCUUR6u2
 IDOrBp5F+96T25Jku9FxhPOS6E5xRQdNkRtZ0ft+p0ewEkOOhRyyB16oMzAFQlSn
 +cH3gRNfz7vzrOq/lrKyq+r+h9gWpkwuXBsrfC2t7qcoYBf2bezYF/Q+QFgpIoMZ
 rBNApfrYFWdR/ieXK+HubtbEgTGUwsOz5ev/lFH3VNHyJa5VsWxeYssDStmbMkHC
 b850sCazakaQp+ESZ4mcVQMjBPtQK4kW/E7KFskLc78QQpnRsqzoI//eEyQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxshj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-331b2ec616fso438201eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189859; x=1790794659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iosFe3tOZMBoWpCgd3gG+3JESIHOn3dFQ/MARSxCGf8=;
 b=DtYMQ9DXHd7WUm2L3zs1UB3nBnb83ZIt1oVVdbVgPV/7xl0UT4py3Kls9LEy67OS5G
 JK/yV9zdQQhjbbey8SSBEoTvBdwmlC8vhd2Nyvnlf5pTgc1SLx6vbC9RTlyGUwtPcTI7
 7lWLJVra0z0CZMzMLkiAWMeo09k4biFOHg1CSjPrWGo4J52d8GTlyVqr7qn+ozwP+Fdb
 1Nss8L9ANz+fO4LVWZ6zumupf6DGJeOA1HbtYtafZLYgcMuK/JY/OADFcz9cqjffnJmR
 sy03eYauAzrxYq8ib0c6B9rp750yyvRPVzO4Of2O40zBsvZ6+60sFE2Y6gn2YE7BciGE
 rxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189859; x=1790794659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iosFe3tOZMBoWpCgd3gG+3JESIHOn3dFQ/MARSxCGf8=;
 b=h4MUAAKTnOvRcD3YvpIQDdjOyjm3A9CDZg/EdD3M06fNVIhe2CLmZiDY1AtM4QYFsa
 OrOBcR0eeX9x9Rx9tL+IsmSFXukHjbAKcue2pr0Bp5hUg32PLD9jd22XB8CcpQD4P+KS
 dxvsY0cslBapQdJ+F3esbwc98cHZbhOzWgOJ7QRbeykOoTxAWZ/491+6cBlV5Tx3gKKT
 G+pO1M/wC7gqPKZdyaT9ISUdOB2Vxw0n7119j7bZrIctRgK9aqSAIPlaZPpWFdPVOoVM
 8RicZ9efHtNwfmsbbISl3nYmcBp3VzSOvHCXknFXXTOCVmlTcjdKvIIdzKBbpevai/nA
 EYPw==
X-Gm-Message-State: AFuF++lkhI9xrQ7m7M/u6eVeL54V0ZNYaZh24R61Ieu9tx9zy/GN0Wel
 u+dmqYIA++ybQq5QK7AzKR2endbdk7t85AYxuva+udG0MQUbrQYhsvu2e4Qz6Kmb9qXOmRIx8jo
 5a9W7YU+l5hoDgDw/VUIBXYe7GsohepLc746ZOurT4yz0An9bLgqqTRdYeDJ+cH6ZBA==
X-Gm-Gg: AYBFou0+91fPC8hO9DaPitJnDgxAQkyNLL7evE5wf+sTtD+mz3Kaj8j6xAHRsYX4Xrw
 xgxtODmrFX0A01VQU/v9PqrnGoIAsP5UWI2kRA96jtvrr6orozNkFdrQR52zlripqadS0HpENIH
 pWZ+cbMYfRSGYiy/YfXl5tEzsLkwJ4sh6IWyBHr04XXqDac0XHDXwZByt9s91iR6exbKBZy1b01
 pwypdXFl4b7CpchtYY677boJ+HRBZQs6Ruo8nK00LbSia6c1XeJhe/Hy86X1ZiZc5OzZf/XPDDD
 BeH5I5McQRQ5xKkNoIjCRSn7VOwL2/QMBx/kq4cyTNrGgflzWGb5cJZ7TzrpjfaHooF5+JuqguP
 fG8SmeX8WcG13rrJxigtD+/oNBOtipo2wzdnL0NlS4V9FmdfAwcO/LF4k6zjjsR8CmYIp
X-Received: by 2002:a05:701b:204e:20b0:13b:3c3b:8dbb with SMTP id
 a92af1059eb24-14503fde4famr66685c88.23.1790189858681; 
 Wed, 23 Sep 2026 11:57:38 -0700 (PDT)
X-Received: by 2002:a05:701b:204e:20b0:13b:3c3b:8dbb with SMTP id
 a92af1059eb24-14503fde4famr66666c88.23.1790189858090; 
 Wed, 23 Sep 2026 11:57:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 6/6] tests/tcg/x86_64: speed up compilation of avx,
 mmx and 3dnow tests
Date: Wed, 23 Sep 2026 11:57:25 -0700
Message-ID: <20260923185725.863311-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KX_wm-B6DKIyUE91GHnNy98Q9iCGzygp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX+M5urb+K2C/Z
 XjaCX0+Nbc8wRqou7KGjDYdvtRsPiODj/Rhfst9v//Wgj1ZqhtJTOn8c25EyA0r/iNnoS6CTvkh
 8ACPjFd9yZH0OSLqWJ+/y9hwOHL9QtSxEGJf3T5l3f02dVbNgeEDJrYBhLf2tkx8pUKeYxlWO0c
 wQoszglffXFmrVLKPBvORyYbNEWwkVeB4jlKkK2KuIY+RWMIysjYi6UW9q3rhYgCjMejDyxoJdY
 Vy9iRj0RQhuBe1GlfkRCdvfbrGE00L6ga18yecHgySmKn0KKRNOU09JZRUk139Y1x4AfaY+M0xl
 zZdjrIEUN5ACiYFlk6TCcsN9H+XMkJk7SGAMZ+UccJo7kAga8unN6J9SsJJvPhP5j7e6tPznP6V
 Va9PbO8Mlaai/421lI0Qj1b2xRJND6D8n+Hhu59dAqxO1XN7Nf18EcBsJ3v3HdNZ/uzmJ5yBhnE
 S1AKOGfOVbt68u/qBIQ==
X-Proofpoint-GUID: KX_wm-B6DKIyUE91GHnNy98Q9iCGzygp
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab42123 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=jkqx9o6u7hr007S5IisA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfXzqpRojBVVe9V
 dGUdie2TrHwQov6GNlMllpeL73vKimuModVbzJLEniju6x92WZ6OFASf5YcJenW+SiMAjzg5ydE
 CouVA0+8uAKEh11FuvcTxRmLFF+4Wug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230075
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

When profiling build of tcg-tests on aarch64 host (compiler running
with qemu-user-binfmt), it was found that those tests were the longest
to compile:
- avx: 1min
- mmx: 8s
- 3dnow: 2s (normal time, but for consistency, apply same flag than
  others).

Compiling with -O0 (default), compilation times are reduced by 50% for
those files. Since they use inline assembly, result is unchanged and
optimizations don't matter.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/x86_64/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 787a2ca61b2..cfeef1d969c 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -31,18 +31,18 @@ tests += {
   '../i386/test-i386-ssse3.c': {},
   '../i386/test-3dnow.c': {
     'cflags': ['-I', meson.current_build_dir(),
-               '-masm=intel', '-O'],
+               '-masm=intel'],
     'depends': [test_3dnow_h],
   },
   '../i386/test-avx.c': {
     'cflags': ['-I', meson.current_build_dir(),
-               '-mavx', '-masm=intel', '-O'],
+               '-mavx', '-masm=intel'],
     'depends': [test_avx_h],
   },
   '../i386/test-flags.c': {},
   '../i386/test-mmx.c': {
     'cflags': ['-I', meson.current_build_dir(),
-               '-masm=intel', '-O'],
+               '-masm=intel'],
     'depends': [test_mmx_h],
   },
   '../i386/test-i386.c': {
-- 
2.47.3


