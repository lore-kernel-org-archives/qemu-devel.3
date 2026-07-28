Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75DDC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfD-0004bh-5c; Tue, 28 Jul 2026 00:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf0-0004Mh-V3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZez-0001a5-FB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abKP1527466
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9GVrHpTcJmQRamduFE2CH7COe32mNk2XPsk6WVe64Q=; b=IBXCN3EvfHeRufHC
 MI6RbvazmLJ31ZuqKZSE+qr0aGvEm9/2Y0CR9UztCBhUywGEqkvFfqserXVgjozb
 Gdx83EDCf49Fy8pppXgmvrqgTpSZBxMS+PUDGm3RVWCdWCRD8HXIXG3qQulKemRB
 OEpDUdOpVys2jLfDyKvIqtK2t2VUfKsuDeTszQo+eT/B7mgte6XqTB7mAu61aSTY
 16cYRIqE74jJ6cmFIeSk049ZQxkGLAXJMJ8u8RkkZdF9GINIDZaMQtNdsi38NsqI
 GZsmI2EjTpQ2WXJSs+pDCqVQ+3soWZlH8LTZguKGmnaOapkh5IIA5t9v+mnh0C2O
 zUKHhQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso2651486a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213800; x=1785818600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H9GVrHpTcJmQRamduFE2CH7COe32mNk2XPsk6WVe64Q=;
 b=DyCmuPu8bPn2tx6tYgKjyuSlEl4YVRN0/YRr7DUAr7+tl3AIpxnDvGKUtBq3pzsfS7
 nS9VRf1tFm/BR9R1Rnyh1mRAUsCv5z/INC7gHXDjpDWOtZDGL5B69P1kF6LQe72vtdb1
 hnLaJrdeeT2nQGuFl4pYG+ijYdHnSCWNNSHiBtrSsiOIldbx4VcvuVTooOi24b/l45/Y
 rRhCaLfReB1pwA/7IyFErZ93PBFNwkMA/DfbZkaVAxv4ok5cjCYwRwsFhDYvd6lgUC91
 0QShBzsYkRUTmTWD7Xqj7uvOMO1l94m+cYGJhIV9Pf3FRJAVkWqgcqtkwANHOnHiPPRd
 7UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213800; x=1785818600;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9GVrHpTcJmQRamduFE2CH7COe32mNk2XPsk6WVe64Q=;
 b=rxEerGjvSmSJ82fhtxeVX/yQLvj8jSDqle8Pm9orZTYE5SJ4CfjA46GODYMQbhosG2
 g4lwvDJjXD07hT673OWLO7F1UKntNkfPQk5NChpMRN/rhPe+ibHVBthXwceGxtEvqjn0
 opnrzlrMexzYayv+3HEAMeS/F761KZI1FYoRsdsl3dKSoV/7FGVCtAjAj4UjQuSnTzo/
 KTygEfImuH2zX06ScW3IeY8DyBRsXmTLdchvpg7w3RTtgFiDaU3AJy65qH92kZ8rHQQD
 1NiVLbApTwuBjZaoKI7a3SgMp1NNzOsIM9pHa16fKuiukzyiS5Hwwckw2Cqgjfb8IFBX
 1GWw==
X-Gm-Message-State: AOJu0YzkudgroHudSHaMfRVT9YZIKdFlfsmM/bRNIUbbnqana8RfG33c
 MuEdn0m2MkZUT3jrX3NMhpAn99/3IfO52ORR8hjcpHFUpSYREXjBZ11+/89+4o0MqYIRyZpTUBm
 /LRZGXkqEjfSQjksNKh7INZlKm+di/aviL32pwlW4ZmI+/JrR//tNFMvUfOt2mcsnyg==
X-Gm-Gg: AR+sD12Af1isZuxqj48YdND7G3GsExK0b33Cv0orICDf/3ctZDPibQC9BKQajNUmVK4
 GFN8le+5b5Pa5Qy9AXCC5JadhWriQiXB1Z+6K6+w13YWuJa7xFw5BkjtKOSoqK+OjcCaZzX3Fc+
 BvZPdaJncL6rWXi8Zpt7vfIzaYV4tx/qBaYAsDoLycrHnAnvN1x3rGzK4CzOQQB2Hag69g3hKfU
 8B4rLcbql3FwjuaVX8exL5HSzW9kCPlnvcxSzVv0esgqQHITSTUnPSveuVgZIMNW8Zp3J4Q27AW
 vEv3z79AipOa1hU+3RUkJTNGCUcKijqOmn78H7OnbyIF2OoAYQPwpNK0eJ/O4K/lNes5+DkM2fz
 z17IFdP0PDbEoPfWR4ackIh+uwz3qXmIbA70PCiC7A9p8kGCeCaWMTXDTjZpprgQPTNwk2uo=
X-Received: by 2002:a05:6a20:939a:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3c8ac7fd04cmr1133675637.23.1785213799612; 
 Mon, 27 Jul 2026 21:43:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:939a:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3c8ac7fd04cmr1133650637.23.1785213799193; 
 Mon, 27 Jul 2026 21:43:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:18 -0700 (PDT)
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
Subject: [PATCH v6 011/103] tests/tcg/plugins: build list of test_plugins
Date: Mon, 27 Jul 2026 21:41:15 -0700
Message-ID: <20260728044248.137626-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4wuX+OBFqRwy
 LKkY7V4NZU/SJhwaAJy9dsRweOKMAV9iW7wBVDDWrctXivjwxL4AkDrOdi7DNO4cM5kZGOZHhN2
 M55lNtlN94BH0ULEzB3OKuk62UtyzzNLG7P0xIFdr5IiHHI++HkJFoiC4p+kqPN0Thinst99J/0
 I8EOORan3NtA9cz3QKguDMawBAyJjDwf6X8oC3N9wNFRhjZGVGAzvyRbrS2StHnZiiCqdA60Q3r
 usLW+AQs0bBy8+NL703XkxVmQJM5ZMrrbxzv8LuI8QFcKs8QVEeMlBKOME/I1v3K9id/jaI/zs8
 zTHqvuz3BsKaU9psejuw8DJn655jgCWwZ3LL62DQcLF77pz4CsG75FMVpcozGg2SHomPx5JuQcL
 NVYpVymkq4LRMLMcuiyhJhlz18mXhxgRwsm3y85CL0SwI/YebyAtIvVTwHQxBjXXao5+o543cei
 9MFYINu9lXeOSL8Nd7w==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683368 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cZw-p5Nuj_z1dlMfLdCj-6YIC5eYcl1F
X-Proofpoint-GUID: cZw-p5Nuj_z1dlMfLdCj-6YIC5eYcl1F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9jOkdScdA1eN
 PWFCvd7rzDbodvFsx5Q/v5CzOtvjqAl84HC726hcKp7EuoRNCSr3ajzNmWypUyYfvzmkekXv+8c
 dEhCBhdvQDEkTKMrdrvpMULjXfSjbvk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


