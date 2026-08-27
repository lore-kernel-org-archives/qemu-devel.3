Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B316C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSY-0008Jm-Gq; Thu, 27 Aug 2026 18:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSJ-0006jw-Pe
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSE-0007Qk-HL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLecU124903
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dl53/BWuodp4qGhuZjydculMY8dKMlVjgV+IX3LSxOU=; b=I0Sy/N1tcDFSG328
 rSlYx8QQEc27LhEefgfxgKzPwSZxCTXtI/Hox1znqKtDNuywl4H8sJCUFCbanWpC
 yVsmRky4A2Mi1lBvSa7sNFWKyVPK01q8qRvTInSq7Y7OSERzU5l5POYbt7pL4UhQ
 UbqdR1i4gYPhGWiclKDxKxhJTYFQpSixjIlegtJXUKsitcovOqUg+QgLUIbWKca1
 o7OwUlXIDo87aD7r7Uzj6nQluLLTFOtkP3Z7nQgocDL0yMY84g4cVcIrOfsB2ker
 87i2aR84Qi/J69fH4r2LhFOwjqVNKMwpOtVCc+A8D1Pdprn6qJu3x9WG7rtVT3Nr
 bMbgGg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7tw77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso555717a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869202; x=1788474002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dl53/BWuodp4qGhuZjydculMY8dKMlVjgV+IX3LSxOU=;
 b=QxoQ6jnJpHP9oudD+2JMGunGd3Q//FQ2JTrK/q9xU3YdhHp+az5gnZIF2rnCxNr0bK
 nVxUBm6AbkjY81uto1Z5REr36kXuW0kMYoIEtYDWIiymV/X8EYP5Vjz/Yeh0R1NXiUzA
 W38eYcJvu/XgkJciVYlBMh5/3jEeAOh2d/bc0fzADnwwr/2+SAFirSVT11Q4DCxu0Vg9
 20VEoVjvlSpHCxGcsC4FbD+EKIbTGIErdJXOdMHNALvCczqX9Ewj34rF0Rqxr76sNoki
 zYqPnWJ2GtuULqlpjP2y1GT+7L7GpmsUHEL2gSAyinPcX8gY3nj/jiebhP+eha1tgUTR
 MkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869202; x=1788474002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dl53/BWuodp4qGhuZjydculMY8dKMlVjgV+IX3LSxOU=;
 b=Xlpd4+bAmD/gQplp/D3Pr3IEaqJe3tKwV64YsuhqroS2lYj7wPHCE5fFOycT9KzeNm
 0MeAj+pRFl9egfx4usdEi1FkD7T4CUiG+SOTg2GT07o0DP5i4VdCzftDnnQiCeEj8IoZ
 VEJQTApLRI4L6f5YtPPk9tmm7Bp0TxrPTnKYpMKxC+gRr75wTH8usqdBZP4gTBfXPkgR
 gHSBnKrA6Zl1ZOnrADFSXxJ60fNFaesEleKrPP6+vUKx23msK0BxkPE8VMVYUCL/us3i
 hPAlbenQUWin/Xv40FoiuQ3hPGqad1a8tAb8jLyuBuveMmDsFB9JqXfeVh1QzeTRRIPF
 uRhA==
X-Gm-Message-State: AFuF++nhJqDng7hUVZNCZxH+064nez5mGeDGPzrxTm8i1mf2ataqL2Yt
 ObWANrPKElB2gyDdWwboYzd7deeJJ9EX7AsHWQnccoXvw3K3VylRE0XJYaSd3thu/KcUD/H/N7W
 Bu8Dw4GLLnkRc2jD30h7dt0uLcNw5uhaDzkhp3DvKjnBrOha1RG7qBlJ6an7DV+Ybiw==
X-Gm-Gg: AR+sD10I0WtSBLFUCDAp5rqRIhS2WrTgA4aYWRxEjd0ngFPv6w4s0sMQL/ldqY1s0H3
 TExPVDGPuYPIOTWE6Z3sjLTVM4H1Mg9zBbWNVDkxgQw0CMSwLBDbcYqtohy3/YvNoDEuiZCzbEG
 YBauCmYoAST7+46SSGt5CrvySyAroev8LQOvGYY3Q6xY5MqjlIPzaPMkyGP1lypNtn/mna7KfJn
 Fe0LGBx8P35US1dnkB924KwkHy7wgPeThWfrOfzwSHcoL+mCk/M/DEpdM/lom/ZnhkKww9yk8CK
 nWLQNQhBQZpuqWJUNoxDGlRNg0EdAqbABYcJAgNHZ6N+NH/iNSrijYjC9PFYzw9w9IicaAXHvpu
 Si4XPQ7vUYVXaiRNlS4QauM9YZc9owUec4373xYaDuHA214aS/TPk5RgJ6nY=
X-Received: by 2002:a17:90a:e710:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-396d0fe0d0dmr4861276a91.15.1787869201723; 
 Thu, 27 Aug 2026 15:20:01 -0700 (PDT)
X-Received: by 2002:a17:90a:e710:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-396d0fe0d0dmr4861058a91.15.1787869200648; 
 Thu, 27 Aug 2026 15:20:00 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:20:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 071/105] tests/tcg/or1k: add float reference files
Date: Thu, 27 Aug 2026 22:14:32 +0000
Message-ID: <20260827221506.91574-72-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX92RZ9zcpD3tx
 fyK1ZvKn/4zjXu8mBmTnYYw9LR1CC1ZJmqsAdodraDd129LZ0Uq16qJzUhgh09XvJzeO0Q3zFaQ
 7/fWkPYNqm/lW/vvz0KVZCbWj2yxQjQ2QhoC87wY/mhdYM0bWPr+YQZWI0ty6CcSyK5stt89cIl
 7K52qw5r15LuKMgd/N+n2379s1BXre9cLjt0tVYJqUaeVmgspBGfacaWu4OXzdu+ChAInM8ZcRf
 +uqNvm5p1vk4XbWr5q+kX7MvkwT+mckOUJSkdyRTzfVXiitNG7jLcws8OZBfk5RNN6GifqNVWRg
 pvfTNTxphHqpYB65qfot1iRh0qj9t6tzyIpFJJsColse1VXDs1MG6cyCh1f0PXHrEnR/lLgEAsL
 YBXVtktHcJthUIuU7O8mWSgevsjKawAwosQmrse/4SKhxeohjw5DyDx9H2321md/MIW5pIp4mj0
 sslaZ9yO+xTv5l3CQzg==
X-Proofpoint-GUID: dSYeN4KFWgaQKFmjl1oXbk2O5AuGh3Fp
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b812 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=hvVdSBpYFhMJYavZuzMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dSYeN4KFWgaQKFmjl1oXbk2O5AuGh3Fp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX9I9vFiikw9p5
 6Fd3xE7QQsvcZb52aTuHKEQSUYohWSCcAdplcaz/iBt+4tIE+Vwb+tzJDcaxXq0VsIJO0LL44Qm
 VHgF1qMaODZN0OMFsO+k89Qvy8yRWsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Makefiles were skipping the output compare when such files
were not available. This results in arch being very inconsistent with
some providing all files, some providing no files, and some providing
some files. There was even one case of a misnamed file that result in a
skipped check.

For consistency, the current series adds all missing reference files for
all arch, and make their presence mandatory

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


