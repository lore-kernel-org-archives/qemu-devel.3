Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7912C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFb-0007B5-2d; Thu, 27 Aug 2026 18:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFZ-0007AH-Kg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFX-0003E6-LT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM5tf236421
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=; b=nL9Xkq1CcMjJfqUK
 KQS4QWaz86L1lRUGoGt48CvgnLYByJam6+6iiHL7z+BrY7NupZxWsmkVeVHvw/8j
 /g27dVoBI93J595qRfJdHFVcAAr/pMRZIocVn9AyXgw4qNmtp9vZaJ923tu5w3Wt
 47LIE9wG8fR0IZ2OzkgIkYN5vOfqzR8YB0gUfkKiGMKAIpNHMMcBVcFwg62zw2tL
 ClVrxHwVw8e94Z+1nfegTJSptJbrNEZswogiNvPvSZwJioShsCNxEuFAXnrwLI2z
 vfjGqrVgkDsOhDgIDQRZ0IfIdRICn43d//uSn5K2o9Xmfb3KpQ27M+VDeBE82DI2
 75YDjg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgsu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso201277a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868425; x=1788473225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=;
 b=TVe72r00S/I8LSK/6Sw8AwLyq3Xv/GBDrX3M4OTSHGVPgMs0Ja1eKhKIlujT4e0D3n
 KJ0NzYNDNbbrg2P7IcrAfKTJyNR9Mc/dknYS0nZmm+isg7Z2iyz1zEAFn5btr29DuF7/
 8HYO+XpNdAwWdtIjCuPKY3YCyIhzSytd1fA1+s9TSEMhPYUShyxOH4M5K1LJ+g9EgSNo
 9q5+ObflljuQodPy4fe+ZoMzAkTH+8uJ5MqSE2oLbIpAQCFHEZfJnATzSMVysoEDK/cc
 Ia2hoy6LFtZWneAmV1+kjnVDQJVbBM57C1VKJf8JRDOpygVeY9mbZC5s0Ll1q4SC1U9j
 oQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868425; x=1788473225;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=;
 b=cnMeJUMTtKGSPjH/2ToTq31Q9mj96b6XAkcGcW3V+DKKh4itRBgd2oTj+o9LaR5sNr
 1XIOfzm1pBoy2lPosv0kY14/acsYIRFO80+gqghG7pXRntgtTfG3buFQXJNTCYaBl5GL
 FeY0CEPRm3o915M743nBp6TD2grhNJXdcRsKABf+h3ENjikQBtjhCLYL4OIhEeP8rprY
 sloPLe2Kk6KOVLLxCsSmKcBEPR6zcZkTjufrh/6aMhNi7t6g6+oJ5ppcIK5dUKkjYDQc
 RG9bQRoR2BRXYh5M684AIInQo+8AYznezP9iJEbGPm8F/fRDlOoqppwzEfFliETjJxSx
 jMWg==
X-Gm-Message-State: AFuF++kEpmcSKMd6CSGjdunlcUyTYME57gNEYwOPc4QB0l7raHCw55XD
 +R+9cENCCTA25zLQF4LeqSbMvGETD6KjEqs5SxQIqQGfPoOzVPV1OCR/oY/yUo/C7p8sCy4OWz4
 /ZpVfW7fwjDS1OUatrM2x4BoQkVCmTUCuPPGWo40Y1Ci5cKTVS1muBXPbTQmanKtH0w==
X-Gm-Gg: AR+sD11BlJpeFqsH+ACKylOiaTMhqTkvnRH0slWIhrZppBfMViNjZAaX11+uq2JRxJj
 EDssAJh0sGzpALYdH5aN2sgRozUEVSs+amKJwAS1BEAq0tqXPCv5utk/VGZYUNqI9XazEHLOJdH
 o95tHeEHv61mquMIB8h8cWUJI9b4dAFqr9nM0y5VjxBdsnMPE4zQULUNhhaVfknAGvmxeahVCcI
 KmOAsAB8mEKvnEPkcnqzAw1Unc++o1ZP26TtczpD2HzjyMZaoq2NULjLKNatDtmhWKZIpxS5DFR
 vbVxTjkXDJkGDMYRBIjSYmBzbLmVFucfIJIOqR4y8NoP+6PMWoP+cVh5DBjj4X4fQs3NunyhRzW
 yp6s2q+pGnN1325DWT7uGYk0BnpfouurbIoogpoo86afMF1rIL9CVQsFyr+E=
X-Received: by 2002:a05:6a00:4190:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-85629d0f13cmr5309764b3a.6.1787868424619; 
 Thu, 27 Aug 2026 15:07:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:4190:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-85629d0f13cmr5309675b3a.6.1787868424200; 
 Thu, 27 Aug 2026 15:07:04 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 011/105] tests/tcg/plugins: build list of test_plugins
Date: Thu, 27 Aug 2026 22:05:05 +0000
Message-ID: <20260827220641.84885-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rfUEXLFKLCF1GbLmUBUElmKD105ZeuDb
X-Proofpoint-ORIG-GUID: rfUEXLFKLCF1GbLmUBUElmKD105ZeuDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0FANymPJUPwi
 VPzhV0Nr0d2N4aYag9WA+YacH36X0cRflgMKJRFwWq793u7ItSueN4dzMFGWXBQSI9aIHVPhd0A
 NYh5oEUqDut5wGBXlQj7snBMcDwhVHgz2WugIOdZtAVz9ompMNKoaAsRkfJPTpyOb9SbgWIF94L
 9/Gt62Kgvtb3ppSJ+RUFqugipH3gN0AYqSFCm5QsMRm3YIoVUnP4qVaGYVSwbS3ydlr9o+wWHBg
 Na2G4+WC0ksYpdKDF/71s0vKgyJw8X+LRbIzC/NDYGQPbTNZFZ7R9h0ANnWfj5WDguRZoypVWcC
 JVPnumwrAfJjub1gngGmFoUmu5QoIuwn0Sm2PVQGSI4e83hv3xhvk7iDnzmpYaynhpjciRIrvNu
 me9IPAqF4GUl/8X5g2m/pYh/xYpzzYw5VzcHzuLd+EIuXJF24Cih5zwLkjxVjp7OsudYBcnI3Ng
 IwnjFPVcnUI0BryKvsA==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b509 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2HqmRLwham4X
 mMXYdIhRwGWCe1E7/PGR2WDTq6NgVtu6Ps0Hr4hqDMlo9/o8nrmBeBeC7UQmj+O3kR6EXeAtIPp
 xZe6TdU0ORTz0tsHw8ZflQV+NZDiPI8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fbee86e6b4b..9940bae80a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.43.0


