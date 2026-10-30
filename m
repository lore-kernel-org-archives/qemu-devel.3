Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AF606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pjIVfGz7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QEbhU6+r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnzB-0002t0-EZ; Fri, 30 Oct 2026 10:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnyD-0002Av-Sb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnyB-000698-Po
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKEv4141733
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSctmo2X4RKZ4rSu1Ym24oiJOhiT3qAZ0tJtWfs5UrQ=; b=pjIVfGz7B03zG3Kl
 r475QDIGrC/1UiSKfEr1XU4ZRs/LUKOTcVgx5nVAiihTQGdhKWbszhAm/zPR+dmu
 pTEgTfiMadS3QIVqAbJRR4wcAWFYblFfDLHSPYgMmQe9/Hb4dqe9E5BbEAglBSww
 5l1tv4Mg0a2cEfUNmAiJZmfgrc49z0aNUqW210qDwv4iNBb9SWhDMFtvy0eFP2h7
 W73onhG59q7gSTWInyS6eeQzCa+Y138Gy4lKNAfHyiIrYP1e2PC/AhG4gGV3qpaI
 w4L8xzyLCVXFcvRVLja1o7si45jUjGQUqTnuCU0NvhkGJfEHa6XfYkcofomgue09
 v0M+vw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6quj0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac1e41c2aso239516e0c.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371958; x=1793976758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kSctmo2X4RKZ4rSu1Ym24oiJOhiT3qAZ0tJtWfs5UrQ=;
 b=QEbhU6+rl4pX2CZu/c+8YAbzNJonmuxnJzzWF7QN3xoyXlOh+r0FeVXvYwbAB9Tx2F
 qkcf+0IsLuv9MdgqqcDywDXA5oqiJpXtwv9ezrCvxX1Z11aTdrs1k0ZZUAB7nxMMocMV
 u2zvts8WfBO1WTlehonIU8hatAPtlKfMlEkEWwz99hXiB+uSVTPOfXkpKj+z4z1JJEF1
 JlrvIRNrZjHZltUfym5q5x6ZTP64GJj0h+fFiCMW1Fpg6e941JHWnR8Z2sj2KlY/+Jce
 ReQuZF2b6rObpe83g/UJrA+Z7v5HDtP8expHEuqusi/5VBpysmuV3NUOH9wHjGWwbVU7
 7kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371958; x=1793976758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kSctmo2X4RKZ4rSu1Ym24oiJOhiT3qAZ0tJtWfs5UrQ=;
 b=tn6Q986zw14hQc4FTshYG0pa5Fl3sDNkPVwkTD3PaTLOobi1ybQ59lM5UymqvM79wc
 PU7g+iXyIFc9dpUyHpBX3Y0c+gHQwFOd72bdNiHuXjVRQ04gTgScSD1m/4Er3vHc/BCK
 Z8GmK2uJt3o2BQn9PpB/wVbEUheBYU6iNRlyLWjnHfxB+yJNaWHnXl5PbIenZp4Uc/Jj
 YCCwhK+SKmXujZxccm/QGiG9xZFrvNrua/OmJWSCd+WloOmjHOiEsbdUrWXm8YiaexUR
 8b8BFWOzIsU6SjmsvP3j7qCssP8mXm6KAQZVLdWCn9DtNqpGwR/jeyw1thC0QLO2aLco
 RReA==
X-Gm-Message-State: AFq9FYLhO1wiKv2pBokL6l2C3V6sTgrptjuQeEDFX5/TUddriFeHaKfv
 pBpFaQHUgnkzWpKz2NG0hKNcl5imKla8tkcJExDhmO+pg4irQPDVxaVASE+Ns2wVF91vFrnRqFq
 87B7gr/JbD0O8EoLIDIeI3Jv0ogw+F8iMRUxuiGj7fC/Nz7b0EOffWrqqrDdzVoiH44Q6
X-Gm-Gg: AYBFou3fGdOHwS7Zkq7nZozoNe5TkJ195POfhEqo22EmDJTo8nXdz4r8BwiHJHJeqv+
 7Q4X2bGM9caLy9uLkFVUzYzLGp/kdoIEg5wYrhxTkwuuAHevyt8b/+1Y9cEuEsfb422hDbjXHJ6
 9ESAeBLpNUzKHe00//4nJPO9aX5fFIkEuqFQS5tFUnBjkwEEjytVTfK/QRiacR8quBCl71G8GeS
 2BbX1bmwAE3Il6TliTUyDfz9Hg4pmhLAwg7Fbb/b8XcM22L6TyJ9C9iqzzfm4YE69zMUCNd2BSP
 FARPSgYoL/Y1fER3bRZ76A+zTFgZbltvNh7vjILpAkgwfWF9ULq6PUsegu9GQKiYHr7OeAHcdZE
 P6kjzdMueA8V36rZePRgZldXA/GcFbw5LcYqPNoLhdslRlTh9mA+QQE2rvnXMmxLgQ+RW+Myw8y
 JBNGBbgFSQkJyE1DG1WQ38gE4bO17Bow==
X-Received: by 2002:a05:6102:440b:b0:7cc:2b48:cb1b with SMTP id
 ada2fe7eead31-7d07271c804mr1260275137.35.1793371957794; 
 Fri, 30 Oct 2026 07:52:37 -0700 (PDT)
X-Received: by 2002:a05:6102:440b:b0:7cc:2b48:cb1b with SMTP id
 ada2fe7eead31-7d07271c804mr1260236137.35.1793371956467; 
 Fri, 30 Oct 2026 07:52:36 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm3588522f8f.29.2026.10.30.07.52.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 07:52:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/4] tests/tcg: Allow tests to report results with TAP
Date: Fri, 30 Oct 2026 15:52:16 +0100
Message-ID: <20261030145218.58385-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030145218.58385-1-philmd@oss.qualcomm.com>
References: <20261030145218.58385-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6o_CqVVVquYQdB_LudGJX6GqKD7mTmd0
X-Proofpoint-ORIG-GUID: 6o_CqVVVquYQdB_LudGJX6GqKD7mTmd0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX5iz99XZ3HiHX
 e+IiCWpzQGNB8chzHlkmT8WHi82stzsrKekYNlWqCEix9kyxGwlRf7qsdhyLZSaCP3/87CiLdT/
 V4v5TijABsd0epEZA3kE4hzfg8MP/DskVxtIhxHrdWwg1PVFReGIDjfc22c1SBK2ugnvW9qUgOy
 GTjo4qPUFsfdeTQLwlaceAdx70Sy9lpDjO2gTb5llFlIxyKE74MOjgwEjInpGzB2PY68Oqa+zbl
 hd9YV5yiKZk6Oyer38CoXTnPlnjHKLd1hBxYNCxebd0ONh1M46lcQu1xCB4P3nhIPUFUONH1sZM
 rBCoJ9jpvHe9dfNk+zc+/Kmal/ANt1av+eGeYdMeovJj29fTpLkOM6uHaF5dMOXcqxDxch8O9qw
 /sIUsAjLIye9krLQEmFA8F8QMQ88RIJ+WKUtkI7A6tAqbSS7OPw0AB+BtqYyUaOhzIYzCDnvTQZ
 wLXfjMF1Z9cSGVSWonw==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4af36 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=T39o4DHrYQchOh_bDjYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXyOPZYV6Mz3fH
 eVKRTwmEFg56yrA4BcJYQhz07PQRVrmGvEU9JO7NGGI/MsrghpMN2usMZVk5v2fHkB4NEYUtkkd
 B7Aj9Wqnh/vzMdO5ujofb1Wuo0UBpHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an optional 'protocol' setup entry, passed to meson's test().
The default stays 'exitcode'; skipped tests (exit 77) are forced
back to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 06f013fbe3d8..b61ddf805148 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -42,6 +42,7 @@ tcg_tests = {}
 #           'gdb_test': ['gdb test args'],
 #           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
+#           'protocol': 'meson test protocol, default is exitcode',
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -323,8 +324,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
-                   'test_name', 'wrapper']
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'protocol',
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -520,8 +521,11 @@ foreach target, plan: tcg_tests
       endif
 
       if skip_test != ''
+        test_protocol = 'exitcode'
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      else
+        test_protocol = 'protocol' in setup ? setup['protocol'] : 'exitcode'
       endif
 
       # Do not add a skipped test when compiler is missing,
@@ -530,6 +534,7 @@ foreach target, plan: tcg_tests
         test(test_name, env, args: cmd,
              depends: test_depends,
              timeout: 120,
+             protocol: test_protocol,
              suite: ['tcg', 'tcg-' + target])
       endif
       added_tests += {test_name: true}
-- 
2.55.0


