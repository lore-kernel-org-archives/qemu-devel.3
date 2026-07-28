Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B72DC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlO-0004Lp-6f; Tue, 28 Jul 2026 00:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk3-0002n7-LR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjy-00029n-51
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46M5v1820990
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vmc6X4R8Hwii+AnJhflbzPlwTXOT1XjSvY0v11a0/jY=; b=DqXQIU/tip4JsRfG
 2Uo97xGglVyDmrCngE78VjVhNXazLbDZRJdUu/HexTXbvqkWd3TbmwRzD49zZPo7
 7tIBEKPLAyPHIgMuDa3tZjvY0Vrc3VPirBURAIAz2SwELDinI+NKIlTeRPO7H4LT
 oWRv8O+scRi1JBFa7QeUu7pJRON0g3sCCa5cSNUwF2Lb2lmHhkf95SMHaIuupWcl
 EM3N4zYbhB3DuqseTRuPdXnZuU1GVpGHj8Zl0khZPss74q4VGP9tUmtigGZdaOFH
 dKR2DNuPJbk+MS3s4HKN1gsj1bp6mGpfkKt+1Rxi5Q15BYZ7COhwGQMIXgexTw0c
 hQQcJg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y0400-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e63de75aaso5836629a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214108; x=1785818908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vmc6X4R8Hwii+AnJhflbzPlwTXOT1XjSvY0v11a0/jY=;
 b=TKkMsCkgxWhbKT6kw/4IO66qxxW8OTmnzvnOOH6FPGZa/peqKVj6+Vb1ZwP0sZAvsn
 uFOr/+FXCer1/WoaK8IQ0WPbPeUmLpsm/0fDbEW09sangshNdfGZXeXdeFmsNCttL/km
 i6thOutKAafl4cHV8XQG4hF6Ir+H3CIesFdnak9K4p7wdOVSkzUMwFNKhefeF/uAB3qk
 9yP3PioJN1fjLtIlpObLQunccrJ/CDMG45xzjzzGr1IuerRVYKh6TtQFmRYuuKfHGyNp
 ZCRrD0lh4e2LFel9sqFrOMmCEE/BAQi0xpCS8vtP8mGWve/zQU6jZJKCi0zlzq50Jtxr
 QGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214108; x=1785818908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vmc6X4R8Hwii+AnJhflbzPlwTXOT1XjSvY0v11a0/jY=;
 b=CtWPERRlDeFy4F5pa8UYoxLaJulQvdovYJ6mknEeRczCjBsVBaQRtWUX9nUo0vr/lL
 JZdfvKtr0y5m1/vD9xPZ98YLNb2JpKZg/qJ+EnBy+knmwkgW1ejNIpiCStrG4GqNLAgV
 tGQQYIp1lqCbPdHylXm/hf4nwzGh4bZ61QV5VNnsiXcyOioNBXuwz+03ReIMt535Jqcl
 HqhenJz9P3beZI2hkAveciV2IVYmrRzIz/dXe4F3Ij4uNTI8VuRpKlxyoCIHa+JnhNzx
 R8ttYJSZH8K3A+i+SvJ03N8CGwxJUvc4p27bqSKb0tlh6viRwew31yMGXyYyHoNb2TAX
 e3Yg==
X-Gm-Message-State: AOJu0YzlTMZXOIc2GXvlUyh+/uBH2+WkeDa+NQ33NwYT3uYdMr2SyGyn
 LY2tr41CvBFE1nZ75PjwUlr1mBf1rMWkF5MqZ5nqR5iHcTueDatj54YsqIslf60NArFPRRBlMkt
 kGWrXvXXd0GPxKW/UOfdtul3PHjauFUhRxg09fU/i5CXkU7QAfvfpDedz3WjDYas2BQ==
X-Gm-Gg: AR+sD11K8rz61RBj8WY+1UbXW/ZnYFnktVVdVsKHtYtmpKub8BDV4Tu/gLOsYobvAxv
 FMcNHNMN33dJ9/xvtioryPrHjUMbXkAQpy/b5SAJ4hm6P/FeoNxuFoboOZnEw7MYNF3ev43zXcI
 2gGgf4uGe4Vh59izKXcAeqdbaOCjwySKVMbXq35cJvjGUO3uj7ZzRMPODNUVeCJp2rj0YxunWVO
 wRge+5zomsMrjg+kxzkWsxXPSDP5jzUoCxxTDVptcphXEljMR9T7XwfddZlJCaPB25LBo7bQ6ys
 ybIX90me/UrqxYeAIMIhmY12stNc+mIfRRZRN76XjvF4W2R6ywy1E0KwyhOstfcOUr/FIqsiD+y
 g4J7xr4Mk3aV3hFt1sRdiTBWZqtPCWCebkb4sdfeRGYLnQ36Gv9ZQPWK3e83ay3ZthfAvgTg=
X-Received: by 2002:a05:6a20:7f82:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3c89caf1fb0mr1139904637.0.1785214107363; 
 Mon, 27 Jul 2026 21:48:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f82:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3c89caf1fb0mr1139840637.0.1785214106395; 
 Mon, 27 Jul 2026 21:48:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:25 -0700 (PDT)
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
Subject: [PATCH v6 070/103] tests/tcg/or1k: add float reference files
Date: Mon, 27 Jul 2026 21:42:14 -0700
Message-ID: <20260728044248.137626-71-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68349c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hvVdSBpYFhMJYavZuzMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXwOUzDs8k9/Et
 dBkI73tSvPTYqAgitTihYAwKyqwU4CjNlkOvADgc0f1BoviVWOsuLQx2THNpm6IfB9tP/2L5qfm
 AyHvbKZjN53CYSHO0xy/060p1Z7E9QA=
X-Proofpoint-ORIG-GUID: L-kXv2fdvdjgYAGeTF9Uw2gnLF3AoL-k
X-Proofpoint-GUID: L-kXv2fdvdjgYAGeTF9Uw2gnLF3AoL-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX0R8/N8qwWQFJ
 ksx1epW3cCRMdctokU4Nma6V7vOCiLcpekxXmbwWZzfSb9HrMcSdvch1LzMpDqxMXunZbU3kW3+
 SMc4+tw8gFldBRM8bxJhgLqQ4MO6IQgafRYYhfgvGpTDPBDzUnN9YvYHe7r57Neczir+3YcWeg5
 P0fyBbHgkifFKa4esSDXCJ0gtIjDzVzvP5DV+VDM+XezrwcbKNPvoi+wgkdI2mXVsPMQAMya6s2
 sCqchKQKrlpika298uPFrzcoz2e1/aFnv1r1FpLgtWr3KPnrCKcSY+PKJmM8QjbilgZnPNwNkuV
 3YMAj3A5XihaifF54qqbAsWSYyjjI1GN3ghZZOO9vDg9qQOuuCE8ffqjty3uNXbpub34v6Qaemw
 XA85briHqI1eJQCFMLszjhBHrIaQhPwKS44CUsvVh3TwHJQo3qPL/QNZewbtzJ/7HV2drWqXagp
 TDPuMAMjln8LFVeYDNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Makefiles were skipping the output compare when such files
were not available. This results in arch being very inconsistent with
some providing all files, some providing no files, and some providing
some files. There was even one case of a misnamed file that result in a
skipped check.

For consistency, the current series adds all missing reference files for
all arch, and make their presence mandatory

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/float_convd.ref | 247 +++++++++++++++++++++++++++++++++
 tests/tcg/or1k/float_convs.ref | 187 +++++++++++++++++++++++++
 tests/tcg/or1k/float_madds.ref | 192 +++++++++++++++++++++++++
 3 files changed, 626 insertions(+)
 create mode 100644 tests/tcg/or1k/float_convd.ref
 create mode 100644 tests/tcg/or1k/float_convs.ref
 create mode 100644 tests/tcg/or1k/float_madds.ref

diff --git a/tests/tcg/or1k/float_convd.ref b/tests/tcg/or1k/float_convd.ref
new file mode 100644
index 00000000000..dbd5379c4d3
--- /dev/null
+++ b/tests/tcg/or1k/float_convd.ref
@@ -0,0 +1,247 @@
+### Rounding to nearest
+from double: f64(nan:0x007ff4000000000000)
+  to single: f32(nan:0x7fe00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(-nan:0x00fff8000000000000)
+  to single: f32(-nan:0xffc00000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-inf:0x00fff0000000000000)
+  to single: f32(-inf:0xff800000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
+  to single: f32(-inf:0xff800000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
+  to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
+  to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
+  to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
+  to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
+  to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
+   to int32: -2 (OK)
+   to int64: -2 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p+0:0x00bff0000000000000)
+  to single: f32(-0x1.00000000000000000000p+0:0xbf800000) (OK)
+   to int32: -1 (OK)
+   to int64: -1 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p-1022:0x008010000000000000)
+  to single: f32(-0x0.00000000000000000000p+0:0x80000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p-126:0x00b810000000000000)
+  to single: f32(-0x1.00000000000000000000p-126:0x80800000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x0.00000000000000000000p+0:00000000000000000000)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000000000000000000p-126:0x003810000000000000)
+  to single: f32(0x1.00000000000000000000p-126:0x00800000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000001c5f680000000p-25:0x003e600000001c5f68)
+  to single: f32(0x1.00000000000000000000p-25:0x33000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.ffffe6cb2fa820000000p-25:0x003e6ffffe6cb2fa82)
+  to single: f32(0x1.ffffe600000000000000p-25:0x337ffff3) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.ff801a9af58a10000000p-15:0x003f0ff801a9af58a1)
+  to single: f32(0x1.ff801a00000000000000p-15:0x387fc00d) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000c06a1ef50000000p-14:0x003f100000c06a1ef5)
+  to single: f32(0x1.00000c00000000000000p-14:0x38800006) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000000000000000000p+0:0x003ff0000000000000)
+  to single: f32(0x1.00000000000000000000p+0:0x3f800000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from double: f64(0x1.00400000000000000000p+0:0x003ff0040000000000)
+  to single: f32(0x1.00400000000000000000p+0:0x3f802000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from double: f64(0x1.00000000000000000000p-1022:0x000010000000000000)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.3d5054450ed000000000p-1023:0x000009ea82a2287680)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.5731f750864200000000p-1023:0x00000ab98fba843210)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000000000000000000p+0:0x003ff0000000000000)
+  to single: f32(0x1.00000000000000000000p+0:0x3f800000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from double: f64(0x1.00000000000000000000p+1:0x004000000000000000)
+  to single: f32(0x1.00000000000000000000p+1:0x40000000) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from double: f64(0x1.5bf0a8b1457690000000p+1:0x004005bf0a8b145769)
+  to single: f32(0x1.5bf0a800000000000000p+1:0x402df854) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from double: f64(0x1.921fb54442d180000000p+1:0x00400921fb54442d18)
+  to single: f32(0x1.921fb600000000000000p+1:0x40490fdb) (OK)
+   to int32: 3 (OK)
+   to int64: 3 (OK)
+  to uint32: 3 (OK)
+  to uint64: 3 (OK)
+from double: f64(0x1.ffbe0000000000000000p+15:0x0040effbe000000000)
+  to single: f32(0x1.ffbe0000000000000000p+15:0x477fdf00) (OK)
+   to int32: 65503 (OK)
+   to int64: 65503 (OK)
+  to uint32: 65503 (OK)
+  to uint64: 65503 (OK)
+from double: f64(0x1.ffc00000000000000000p+15:0x0040effc0000000000)
+  to single: f32(0x1.ffc00000000000000000p+15:0x477fe000) (OK)
+   to int32: 65504 (OK)
+   to int64: 65504 (OK)
+  to uint32: 65504 (OK)
+  to uint64: 65504 (OK)
+from double: f64(0x1.ffc20000000000000000p+15:0x0040effc2000000000)
+  to single: f32(0x1.ffc20000000000000000p+15:0x477fe100) (OK)
+   to int32: 65505 (OK)
+   to int64: 65505 (OK)
+  to uint32: 65505 (OK)
+  to uint64: 65505 (OK)
+from double: f64(0x1.ffbf0000000000000000p+16:0x0040fffbf000000000)
+  to single: f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) (OK)
+   to int32: 131007 (OK)
+   to int64: 131007 (OK)
+  to uint32: 131007 (OK)
+  to uint64: 131007 (OK)
+from double: f64(0x1.ffc00000000000000000p+16:0x0040fffc0000000000)
+  to single: f32(0x1.ffc00000000000000000p+16:0x47ffe000) (OK)
+   to int32: 131008 (OK)
+   to int64: 131008 (OK)
+  to uint32: 131008 (OK)
+  to uint64: 131008 (OK)
+from double: f64(0x1.ffc10000000000000000p+16:0x0040fffc1000000000)
+  to single: f32(0x1.ffc10000000000000000p+16:0x47ffe080) (OK)
+   to int32: 131009 (OK)
+   to int64: 131009 (OK)
+  to uint32: 131009 (OK)
+  to uint64: 131009 (OK)
+from double: f64(0x1.fffffffc000000000000p+30:0x0041dfffffffc00000)
+  to single: f32(0x1.00000000000000000000p+31:0x4f000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 2147483647 (OK)
+  to uint32: 2147483647 (OK)
+  to uint64: 2147483647 (OK)
+from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
+  to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
+  to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
+  to single: f32(inf:0x7f800000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(inf:0x007ff0000000000000)
+  to single: f32(inf:0x7f800000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(nan:0x007ff8000000000000)
+  to single: f32(nan:0x7fc00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(nan:0x007ff0000000000001)
+  to single: f32(nan:0x7fc00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(nan:0x007ff4000000000000)
+  to single: f32(nan:0x7fe00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
diff --git a/tests/tcg/or1k/float_convs.ref b/tests/tcg/or1k/float_convs.ref
new file mode 100644
index 00000000000..ec7fdf975b1
--- /dev/null
+++ b/tests/tcg/or1k/float_convs.ref
@@ -0,0 +1,187 @@
+### Rounding to nearest
+from single: f32(-nan:0xffa00000)
+  to double: f64(-nan:0x00fffc000000000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-nan:0xffc00000)
+  to double: f64(-nan:0x00fff8000000000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-inf:0xff800000)
+  to double: f64(-inf:0x00fff0000000000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+  to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+  to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+  to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+  to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+  to double: f64(-0x1.50544400000000000000p-66:0x00bbd5054440000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.00000000000000000000p-126:0x80800000)
+  to double: f64(-0x1.00000000000000000000p-126:0x00b810000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x0.00000000000000000000p+0:0000000000)
+  to double: f64(0x0.00000000000000000000p+0:00000000000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000000000000000000p-126:0x00800000)
+  to double: f64(0x1.00000000000000000000p-126:0x003810000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000000000000000000p-25:0x33000000)
+  to double: f64(0x1.00000000000000000000p-25:0x003e60000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+  to double: f64(0x1.ffffe600000000000000p-25:0x003e6ffffe60000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+  to double: f64(0x1.ff801a00000000000000p-15:0x003f0ff801a0000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000c00000000000000p-14:0x38800006)
+  to double: f64(0x1.00000c00000000000000p-14:0x003f100000c0000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000000000000000000p+0:0x3f800000)
+  to double: f64(0x1.00000000000000000000p+0:0x003ff0000000000000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from single: f32(0x1.00400000000000000000p+0:0x3f802000)
+  to double: f64(0x1.00400000000000000000p+0:0x003ff0040000000000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from single: f32(0x1.00000000000000000000p+1:0x40000000)
+  to double: f64(0x1.00000000000000000000p+1:0x004000000000000000) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from single: f32(0x1.5bf0a800000000000000p+1:0x402df854)
+  to double: f64(0x1.5bf0a800000000000000p+1:0x004005bf0a80000000) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from single: f32(0x1.921fb600000000000000p+1:0x40490fdb)
+  to double: f64(0x1.921fb600000000000000p+1:0x00400921fb60000000) (OK)
+   to int32: 3 (OK)
+   to int64: 3 (OK)
+  to uint32: 3 (OK)
+  to uint64: 3 (OK)
+from single: f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+  to double: f64(0x1.ffbe0000000000000000p+15:0x0040effbe000000000) (OK)
+   to int32: 65503 (OK)
+   to int64: 65503 (OK)
+  to uint32: 65503 (OK)
+  to uint64: 65503 (OK)
+from single: f32(0x1.ffc00000000000000000p+15:0x477fe000)
+  to double: f64(0x1.ffc00000000000000000p+15:0x0040effc0000000000) (OK)
+   to int32: 65504 (OK)
+   to int64: 65504 (OK)
+  to uint32: 65504 (OK)
+  to uint64: 65504 (OK)
+from single: f32(0x1.ffc20000000000000000p+15:0x477fe100)
+  to double: f64(0x1.ffc20000000000000000p+15:0x0040effc2000000000) (OK)
+   to int32: 65505 (OK)
+   to int64: 65505 (OK)
+  to uint32: 65505 (OK)
+  to uint64: 65505 (OK)
+from single: f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+  to double: f64(0x1.ffbf0000000000000000p+16:0x0040fffbf000000000) (OK)
+   to int32: 131007 (OK)
+   to int64: 131007 (OK)
+  to uint32: 131007 (OK)
+  to uint64: 131007 (OK)
+from single: f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+  to double: f64(0x1.ffc00000000000000000p+16:0x0040fffc0000000000) (OK)
+   to int32: 131008 (OK)
+   to int64: 131008 (OK)
+  to uint32: 131008 (OK)
+  to uint64: 131008 (OK)
+from single: f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+  to double: f64(0x1.ffc10000000000000000p+16:0x0040fffc1000000000) (OK)
+   to int32: 131009 (OK)
+   to int64: 131009 (OK)
+  to uint32: 131009 (OK)
+  to uint64: 131009 (OK)
+from single: f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+  to double: f64(0x1.c0bab600000000000000p+99:0x00462c0bab60000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+  to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(inf:0x7f800000)
+  to double: f64(inf:0x007ff0000000000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(nan:0x7fc00000)
+  to double: f64(nan:0x007ff8000000000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(nan:0x7fa00000)
+  to double: f64(nan:0x007ffc000000000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
diff --git a/tests/tcg/or1k/float_madds.ref b/tests/tcg/or1k/float_madds.ref
new file mode 100644
index 00000000000..2c7c35c8b47
--- /dev/null
+++ b/tests/tcg/or1k/float_madds.ref
@@ -0,0 +1,192 @@
+### Rounding to nearest
+op : f32(-nan:0xffa00000) * f32(-nan:0xffc00000) + f32(-inf:0xff800000)
+res: f32(-nan:0xffe00000) flags=OK (0/0)
+op : f32(-nan:0xffc00000) * f32(-inf:0xff800000) + f32(-nan:0xffa00000)
+res: f32(-nan:0xffe00000) flags=OK (0/1)
+op : f32(-inf:0xff800000) * f32(-nan:0xffa00000) + f32(-nan:0xffc00000)
+res: f32(-nan:0xffc00000) flags=OK (0/2)
+op : f32(-nan:0xffc00000) * f32(-inf:0xff800000) + f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+res: f32(-nan:0xffc00000) flags=OK (1/0)
+op : f32(-inf:0xff800000) * f32(-0x1.fffffe00000000000000p+127:0xff7fffff) + f32(-nan:0xffc00000)
+res: f32(-nan:0xffc00000) flags=OK (1/1)
+op : f32(-0x1.fffffe00000000000000p+127:0xff7fffff) * f32(-nan:0xffc00000) + f32(-inf:0xff800000)
+res: f32(-nan:0xffc00000) flags=OK (1/2)
+op : f32(-inf:0xff800000) * f32(-0x1.fffffe00000000000000p+127:0xff7fffff) + f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+res: f32(inf:0x7f800000) flags=OK (2/0)
+op : f32(-0x1.fffffe00000000000000p+127:0xff7fffff) * f32(-0x1.1874b200000000000000p+103:0xf30c3a59) + f32(-inf:0xff800000)
+res: f32(-inf:0xff800000) flags=OK (2/1)
+op : f32(-0x1.1874b200000000000000p+103:0xf30c3a59) * f32(-inf:0xff800000) + f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+res: f32(inf:0x7f800000) flags=OK (2/2)
+op : f32(-0x1.fffffe00000000000000p+127:0xff7fffff) * f32(-0x1.1874b200000000000000p+103:0xf30c3a59) + f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+res: f32(inf:0x7f800000) flags=OK (3/0)
+op : f32(-0x1.1874b200000000000000p+103:0xf30c3a59) * f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) + f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+res: f32(inf:0x7f800000) flags=OK (3/1)
+op : f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) * f32(-0x1.fffffe00000000000000p+127:0xff7fffff) + f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+res: f32(inf:0x7f800000) flags=OK (3/2)
+op : f32(-0x1.1874b200000000000000p+103:0xf30c3a59) * f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) + f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+res: f32(inf:0x7f800000) flags=OK (4/0)
+op : f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) * f32(-0x1.31f75000000000000000p-40:0xab98fba8) + f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+res: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) flags=OK (4/1)
+op : f32(-0x1.31f75000000000000000p-40:0xab98fba8) * f32(-0x1.1874b200000000000000p+103:0xf30c3a59) + f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+res: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) flags=OK (4/2)
+op : f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) * f32(-0x1.31f75000000000000000p-40:0xab98fba8) + f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+res: f32(0x1.0c27fa00000000000000p+60:0x5d8613fd) flags=OK (5/0)
+op : f32(-0x1.31f75000000000000000p-40:0xab98fba8) * f32(-0x1.50544400000000000000p-66:0x9ea82a22) + f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+res: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) flags=OK (5/1)
+op : f32(-0x1.50544400000000000000p-66:0x9ea82a22) * f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) + f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+res: f32(0x1.26c46200000000000000p+34:0x50936231) flags=OK (5/2)
+op : f32(-0x1.31f75000000000000000p-40:0xab98fba8) * f32(-0x1.50544400000000000000p-66:0x9ea82a22) + f32(-0x1.00000000000000000000p-126:0x80800000)
+res: f32(0x1.91f94000000000000000p-106:0x0ac8fca0) flags=OK (6/0)
+op : f32(-0x1.50544400000000000000p-66:0x9ea82a22) * f32(-0x1.00000000000000000000p-126:0x80800000) + f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+res: f32(-0x1.31f75000000000000000p-40:0xab98fba8) flags=OK (6/1)
+op : f32(-0x1.00000000000000000000p-126:0x80800000) * f32(-0x1.31f75000000000000000p-40:0xab98fba8) + f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+res: f32(-0x1.50544400000000000000p-66:0x9ea82a22) flags=OK (6/2)
+op : f32(-0x1.50544400000000000000p-66:0x9ea82a22) * f32(-0x1.00000000000000000000p-126:0x80800000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(0x0.00000000000000000000p+0:0000000000) flags=OK (7/0)
+op : f32(-0x1.00000000000000000000p-126:0x80800000) * f32(0x0.00000000000000000000p+0:0000000000) + f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+res: f32(-0x1.50544400000000000000p-66:0x9ea82a22) flags=OK (7/1)
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(-0x1.50544400000000000000p-66:0x9ea82a22) + f32(-0x1.00000000000000000000p-126:0x80800000)
+res: f32(-0x1.00000000000000000000p-126:0x80800000) flags=OK (7/2)
+op : f32(-0x1.00000000000000000000p-126:0x80800000) * f32(0x0.00000000000000000000p+0:0000000000) + f32(0x1.00000000000000000000p-126:0x00800000)
+res: f32(0x1.00000000000000000000p-126:0x00800000) flags=OK (8/0)
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(0x1.00000000000000000000p-126:0x00800000) + f32(-0x1.00000000000000000000p-126:0x80800000)
+res: f32(-0x1.00000000000000000000p-126:0x80800000) flags=OK (8/1)
+op : f32(0x1.00000000000000000000p-126:0x00800000) * f32(-0x1.00000000000000000000p-126:0x80800000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(-0x0.00000000000000000000p+0:0x80000000) flags=OK (8/2)
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(0x1.00000000000000000000p-126:0x00800000) + f32(0x1.00000000000000000000p-25:0x33000000)
+res: f32(0x1.00000000000000000000p-25:0x33000000) flags=OK (9/0)
+op : f32(0x1.00000000000000000000p-126:0x00800000) * f32(0x1.00000000000000000000p-25:0x33000000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(0x0.00000000000000000000p+0:0000000000) flags=OK (9/1)
+op : f32(0x1.00000000000000000000p-25:0x33000000) * f32(0x0.00000000000000000000p+0:0000000000) + f32(0x1.00000000000000000000p-126:0x00800000)
+res: f32(0x1.00000000000000000000p-126:0x00800000) flags=OK (9/2)
+op : f32(0x1.00000000000000000000p-126:0x00800000) * f32(0x1.00000000000000000000p-25:0x33000000) + f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+res: f32(0x1.ffffe600000000000000p-25:0x337ffff3) flags=OK (10/0)
+op : f32(0x1.00000000000000000000p-25:0x33000000) * f32(0x1.ffffe600000000000000p-25:0x337ffff3) + f32(0x1.00000000000000000000p-126:0x00800000)
+res: f32(0x1.ffffe600000000000000p-50:0x26fffff3) flags=OK (10/1)
+op : f32(0x1.ffffe600000000000000p-25:0x337ffff3) * f32(0x1.00000000000000000000p-126:0x00800000) + f32(0x1.00000000000000000000p-25:0x33000000)
+res: f32(0x1.00000000000000000000p-25:0x33000000) flags=OK (10/2)
+op : f32(0x1.00000000000000000000p-25:0x33000000) * f32(0x1.ffffe600000000000000p-25:0x337ffff3) + f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+res: f32(0x1.ff801a00000000000000p-15:0x387fc00d) flags=OK (11/0)
+op : f32(0x1.ffffe600000000000000p-25:0x337ffff3) * f32(0x1.ff801a00000000000000p-15:0x387fc00d) + f32(0x1.00000000000000000000p-25:0x33000000)
+res: f32(0x1.0007fe00000000000000p-25:0x330003ff) flags=OK (11/1)
+op : f32(0x1.ff801a00000000000000p-15:0x387fc00d) * f32(0x1.00000000000000000000p-25:0x33000000) + f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+res: f32(0x1.0001f200000000000000p-24:0x338000f9) flags=OK (11/2)
+op : f32(0x1.ffffe600000000000000p-25:0x337ffff3) * f32(0x1.ff801a00000000000000p-15:0x387fc00d) + f32(0x1.00000c00000000000000p-14:0x38800006)
+res: f32(0x1.00000c00000000000000p-14:0x38800006) flags=OK (12/0)
+op : f32(0x1.ff801a00000000000000p-15:0x387fc00d) * f32(0x1.00000c00000000000000p-14:0x38800006) + f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+res: f32(0x1.0ffbf400000000000000p-24:0x3387fdfa) flags=OK (12/1)
+op : f32(0x1.00000c00000000000000p-14:0x38800006) * f32(0x1.ffffe600000000000000p-25:0x337ffff3) + f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+res: f32(0x1.ff801c00000000000000p-15:0x387fc00e) flags=OK (12/2)
+op : f32(0x1.ff801a00000000000000p-15:0x387fc00d) * f32(0x1.00000c00000000000000p-14:0x38800006) + f32(0x1.00000000000000000000p+0:0x3f800000)
+res: f32(0x1.00000000000000000000p+0:0x3f800000) flags=OK (13/0)
+op : f32(0x1.00000c00000000000000p-14:0x38800006) * f32(0x1.00000000000000000000p+0:0x3f800000) + f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+res: f32(0x1.ffc01800000000000000p-14:0x38ffe00c) flags=OK (13/1)
+op : f32(0x1.00000000000000000000p+0:0x3f800000) * f32(0x1.ff801a00000000000000p-15:0x387fc00d) + f32(0x1.00000c00000000000000p-14:0x38800006)
+res: f32(0x1.ffc01800000000000000p-14:0x38ffe00c) flags=OK (13/2)
+op : f32(0x1.00000c00000000000000p-14:0x38800006) * f32(0x1.00000000000000000000p+0:0x3f800000) + f32(0x1.00400000000000000000p+0:0x3f802000)
+res: f32(0x1.00440000000000000000p+0:0x3f802200) flags=OK (14/0)
+op : f32(0x1.00000000000000000000p+0:0x3f800000) * f32(0x1.00400000000000000000p+0:0x3f802000) + f32(0x1.00000c00000000000000p-14:0x38800006)
+res: f32(0x1.00440000000000000000p+0:0x3f802200) flags=OK (14/1)
+op : f32(0x1.00400000000000000000p+0:0x3f802000) * f32(0x1.00000c00000000000000p-14:0x38800006) + f32(0x1.00000000000000000000p+0:0x3f800000)
+res: f32(0x1.00040200000000000000p+0:0x3f800201) flags=OK (14/2)
+op : f32(0x1.00000000000000000000p+0:0x3f800000) * f32(0x1.00400000000000000000p+0:0x3f802000) + f32(0x1.00000000000000000000p+1:0x40000000)
+res: f32(0x1.80200000000000000000p+1:0x40401000) flags=OK (15/0)
+op : f32(0x1.00400000000000000000p+0:0x3f802000) * f32(0x1.00000000000000000000p+1:0x40000000) + f32(0x1.00000000000000000000p+0:0x3f800000)
+res: f32(0x1.80400000000000000000p+1:0x40402000) flags=OK (15/1)
+op : f32(0x1.00000000000000000000p+1:0x40000000) * f32(0x1.00000000000000000000p+0:0x3f800000) + f32(0x1.00400000000000000000p+0:0x3f802000)
+res: f32(0x1.80200000000000000000p+1:0x40401000) flags=OK (15/2)
+op : f32(0x1.00400000000000000000p+0:0x3f802000) * f32(0x1.00000000000000000000p+1:0x40000000) + f32(0x1.5bf0a800000000000000p+1:0x402df854)
+res: f32(0x1.2e185400000000000000p+2:0x40970c2a) flags=OK (16/0)
+op : f32(0x1.00000000000000000000p+1:0x40000000) * f32(0x1.5bf0a800000000000000p+1:0x402df854) + f32(0x1.00400000000000000000p+0:0x3f802000)
+res: f32(0x1.9c00a800000000000000p+2:0x40ce0054) flags=OK (16/1)
+op : f32(0x1.5bf0a800000000000000p+1:0x402df854) * f32(0x1.00400000000000000000p+0:0x3f802000) + f32(0x1.00000000000000000000p+1:0x40000000)
+res: f32(0x1.2e23d200000000000000p+2:0x409711e9) flags=OK (16/2)
+op : f32(0x1.00000000000000000000p+1:0x40000000) * f32(0x1.5bf0a800000000000000p+1:0x402df854) + f32(0x1.921fb600000000000000p+1:0x40490fdb)
+res: f32(0x1.12804200000000000000p+3:0x41094021) flags=OK (17/0)
+op : f32(0x1.5bf0a800000000000000p+1:0x402df854) * f32(0x1.921fb600000000000000p+1:0x40490fdb) + f32(0x1.00000000000000000000p+1:0x40000000)
+res: f32(0x1.51458000000000000000p+3:0x4128a2c0) flags=OK (17/1)
+op : f32(0x1.921fb600000000000000p+1:0x40490fdb) * f32(0x1.00000000000000000000p+1:0x40000000) + f32(0x1.5bf0a800000000000000p+1:0x402df854)
+res: f32(0x1.200c0400000000000000p+3:0x41100602) flags=OK (17/2)
+op : f32(0x1.5bf0a800000000000000p+1:0x402df854) * f32(0x1.921fb600000000000000p+1:0x40490fdb) + f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+res: f32(0x1.ffcf1400000000000000p+15:0x477fe78a) flags=OK (18/0)
+op : f32(0x1.921fb600000000000000p+1:0x40490fdb) * f32(0x1.ffbe0000000000000000p+15:0x477fdf00) + f32(0x1.5bf0a800000000000000p+1:0x402df854)
+res: f32(0x1.91ed3c00000000000000p+17:0x4848f69e) flags=OK (18/1)
+op : f32(0x1.ffbe0000000000000000p+15:0x477fdf00) * f32(0x1.5bf0a800000000000000p+1:0x402df854) + f32(0x1.921fb600000000000000p+1:0x40490fdb)
+res: f32(0x1.5bc56000000000000000p+17:0x482de2b0) flags=OK (18/2)
+op : f32(0x1.921fb600000000000000p+1:0x40490fdb) * f32(0x1.ffbe0000000000000000p+15:0x477fdf00) + f32(0x1.ffc00000000000000000p+15:0x477fe000)
+res: f32(0x1.08edf000000000000000p+18:0x488476f8) flags=OK (19/0)
+op : f32(0x1.ffbe0000000000000000p+15:0x477fdf00) * f32(0x1.ffc00000000000000000p+15:0x477fe000) + f32(0x1.921fb600000000000000p+1:0x40490fdb)
+res: f32(0x1.ff7e0800000000000000p+31:0x4f7fbf04) flags=OK (19/1)
+op : f32(0x1.ffc00000000000000000p+15:0x477fe000) * f32(0x1.921fb600000000000000p+1:0x40490fdb) + f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+res: f32(0x1.08ee7a00000000000000p+18:0x4884773d) flags=OK (19/2)
+op : f32(0x1.ffbe0000000000000000p+15:0x477fdf00) * f32(0x1.ffc00000000000000000p+15:0x477fe000) + f32(0x1.ffc20000000000000000p+15:0x477fe100)
+res: f32(0x1.ff800800000000000000p+31:0x4f7fc004) flags=OK (20/0)
+op : f32(0x1.ffc00000000000000000p+15:0x477fe000) * f32(0x1.ffc20000000000000000p+15:0x477fe100) + f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+res: f32(0x1.ff840800000000000000p+31:0x4f7fc204) flags=OK (20/1)
+op : f32(0x1.ffc20000000000000000p+15:0x477fe100) * f32(0x1.ffbe0000000000000000p+15:0x477fdf00) + f32(0x1.ffc00000000000000000p+15:0x477fe000)
+res: f32(0x1.ff820800000000000000p+31:0x4f7fc104) flags=OK (20/2)
+op : f32(0x1.ffc00000000000000000p+15:0x477fe000) * f32(0x1.ffc20000000000000000p+15:0x477fe100) + f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+res: f32(0x1.ff860800000000000000p+31:0x4f7fc304) flags=OK (21/0)
+op : f32(0x1.ffc20000000000000000p+15:0x477fe100) * f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) + f32(0x1.ffc00000000000000000p+15:0x477fe000)
+res: f32(0x1.ff820800000000000000p+32:0x4fffc104) flags=OK (21/1)
+op : f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) * f32(0x1.ffc00000000000000000p+15:0x477fe000) + f32(0x1.ffc20000000000000000p+15:0x477fe100)
+res: f32(0x1.ff800800000000000000p+32:0x4fffc004) flags=OK (21/2)
+op : f32(0x1.ffc20000000000000000p+15:0x477fe100) * f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) + f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+res: f32(0x1.ff830800000000000000p+32:0x4fffc184) flags=OK (22/0)
+op : f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) * f32(0x1.ffc00000000000000000p+16:0x47ffe000) + f32(0x1.ffc20000000000000000p+15:0x477fe100)
+res: f32(0x1.ff7f8800000000000000p+33:0x507fbfc4) flags=OK (22/1)
+op : f32(0x1.ffc00000000000000000p+16:0x47ffe000) * f32(0x1.ffc20000000000000000p+15:0x477fe100) + f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+res: f32(0x1.ff840800000000000000p+32:0x4fffc204) flags=OK (22/2)
+op : f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) * f32(0x1.ffc00000000000000000p+16:0x47ffe000) + f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+res: f32(0x1.ff800800000000000000p+33:0x507fc004) flags=OK (23/0)
+op : f32(0x1.ffc00000000000000000p+16:0x47ffe000) * f32(0x1.ffc10000000000000000p+16:0x47ffe080) + f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+res: f32(0x1.ff820800000000000000p+33:0x507fc104) flags=OK (23/1)
+op : f32(0x1.ffc10000000000000000p+16:0x47ffe080) * f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) + f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+res: f32(0x1.ff810800000000000000p+33:0x507fc084) flags=OK (23/2)
+op : f32(0x1.ffc00000000000000000p+16:0x47ffe000) * f32(0x1.ffc10000000000000000p+16:0x47ffe080) + f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+res: f32(0x1.c0bab600000000000000p+99:0x71605d5b) flags=OK (24/0)
+op : f32(0x1.ffc10000000000000000p+16:0x47ffe080) * f32(0x1.c0bab600000000000000p+99:0x71605d5b) + f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+res: f32(0x1.c0838000000000000000p+116:0x79e041c0) flags=OK (24/1)
+op : f32(0x1.c0bab600000000000000p+99:0x71605d5b) * f32(0x1.ffc00000000000000000p+16:0x47ffe000) + f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+res: f32(0x1.c0829e00000000000000p+116:0x79e0414f) flags=OK (24/2)
+op : f32(0x1.ffc10000000000000000p+16:0x47ffe080) * f32(0x1.c0bab600000000000000p+99:0x71605d5b) + f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+res: f32(inf:0x7f800000) flags=OK (25/0)
+op : f32(0x1.c0bab600000000000000p+99:0x71605d5b) * f32(0x1.fffffe00000000000000p+127:0x7f7fffff) + f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+res: f32(inf:0x7f800000) flags=OK (25/1)
+op : f32(0x1.fffffe00000000000000p+127:0x7f7fffff) * f32(0x1.ffc10000000000000000p+16:0x47ffe080) + f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+res: f32(inf:0x7f800000) flags=OK (25/2)
+op : f32(0x1.c0bab600000000000000p+99:0x71605d5b) * f32(0x1.fffffe00000000000000p+127:0x7f7fffff) + f32(inf:0x7f800000)
+res: f32(inf:0x7f800000) flags=OK (26/0)
+op : f32(0x1.fffffe00000000000000p+127:0x7f7fffff) * f32(inf:0x7f800000) + f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+res: f32(inf:0x7f800000) flags=OK (26/1)
+op : f32(inf:0x7f800000) * f32(0x1.c0bab600000000000000p+99:0x71605d5b) + f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+res: f32(inf:0x7f800000) flags=OK (26/2)
+op : f32(0x1.fffffe00000000000000p+127:0x7f7fffff) * f32(inf:0x7f800000) + f32(nan:0x7fc00000)
+res: f32(nan:0x7fc00000) flags=OK (27/0)
+op : f32(inf:0x7f800000) * f32(nan:0x7fc00000) + f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+res: f32(nan:0x7fc00000) flags=OK (27/1)
+op : f32(nan:0x7fc00000) * f32(0x1.fffffe00000000000000p+127:0x7f7fffff) + f32(inf:0x7f800000)
+res: f32(nan:0x7fc00000) flags=OK (27/2)
+op : f32(inf:0x7f800000) * f32(nan:0x7fc00000) + f32(nan:0x7fa00000)
+res: f32(nan:0x7fe00000) flags=OK (28/0)
+op : f32(nan:0x7fc00000) * f32(nan:0x7fa00000) + f32(inf:0x7f800000)
+res: f32(nan:0x7fc00000) flags=OK (28/1)
+op : f32(nan:0x7fa00000) * f32(inf:0x7f800000) + f32(nan:0x7fc00000)
+res: f32(nan:0x7fc00000) flags=OK (28/2)
+op : f32(nan:0x7fc00000) * f32(nan:0x7fa00000) + f32(-nan:0xffa00000)
+res: f32(-nan:0xffe00000) flags=OK (29/0)
+op : f32(nan:0x7fa00000) * f32(-nan:0xffa00000) + f32(nan:0x7fc00000)
+res: f32(nan:0x7fc00000) flags=OK (29/1)
+op : f32(-nan:0xffa00000) * f32(nan:0x7fc00000) + f32(nan:0x7fa00000)
+res: f32(nan:0x7fe00000) flags=OK (29/2)
+op : f32(nan:0x7fa00000) * f32(-nan:0xffa00000) + f32(-nan:0xffc00000)
+res: f32(-nan:0xffc00000) flags=OK (30/0)
+op : f32(-nan:0xffa00000) * f32(-nan:0xffc00000) + f32(nan:0x7fa00000)
+res: f32(nan:0x7fe00000) flags=OK (30/1)
+op : f32(-nan:0xffc00000) * f32(nan:0x7fa00000) + f32(-nan:0xffa00000)
+res: f32(-nan:0xffe00000) flags=OK (30/2)
+# LP184149
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(0x1.00000000000000000000p-1:0x3f000000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(0x0.00000000000000000000p+0:0000000000) flags=OK (31/0)
+op : f32(0x1.00000000000000000000p-149:0x00000001) * f32(0x1.00000000000000000000p-149:0x00000001) + f32(0x1.00000000000000000000p-149:0x00000001)
+res: f32(0x1.00000000000000000000p-149:0x00000001) flags=OK (32/0)
-- 
2.47.3


