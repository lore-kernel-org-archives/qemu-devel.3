Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408ECC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNj-00053x-Aa; Thu, 27 Aug 2026 18:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNf-0004zO-61
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNd-000647-B1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMMrR1804239
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=; b=TrM6NF5ObttSQUz/
 tYg5YauAM2J5KIXpgvUDRvlFDBRwo26OpFrvVC89w/PorOerWdy+IW2rx5xrWWF6
 bEoZtbO/GpCnrSmwOXPVGcXe62fUA+Uv/ZvfXRPE31nRtvAJIfLPpLjvjtIsv3LZ
 mMC8FpdQbS+jQ5avuta/owZQm3uDiPBovEX5cPwR3HRvjhUTN7uSZAWb4VG6rcRp
 4mI1acFAHWnN8mmQPWXPPV5B5IrNvqEsis1ObgE7zp17LItjr2LjYIKWOGS1luuC
 qDH6yskma2TLkrggAnvhtS7nFUDxQuWz8XjNaefMpAl54bbmoD0BRhi7kaQoMYs9
 mkyeMw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgv3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84842381150so472072b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868927; x=1788473727; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=;
 b=ORFA7lkF9MQ2A5QppHnNIpe9do6Qq7JresrBpX9kItYG6cjHITu0bUGlZew2prxkNK
 46Jt3BILcEZF7W0j/97W2nGYkifYz6dsdF/Ypp4M45JrfLPgKLVFtgJ9RMZzBB5XhwWH
 bPs70frpZny/2k4yWlYj2LcxF7Yw7hGvnJkiErM2a8bKWvlxUrpS15LvAhIuzgFfbLDd
 tIAdk2t2vkhYFuZv5IVLtqdknflNhXzIGh5xX7L8eaScnoZMnpkwuK1P4zIFvOCI/sip
 4paPZE5/6FaSXSdnDkJbzw9PP1utdcF2jfLNHNtGny/yFHhwwTIrun1TChGOiOEPSldX
 RV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868927; x=1788473727;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=;
 b=O1nYt0jEerxsX7vqUnLgOMEg4f6Ge6zVCR/i9apd6iy3crFZlwpGvVAEwu/Y02FONh
 ZbF9F458iHlIEzW/jXhHfK+xddOZUbQ215bceJ522YFppdeywEVeKmpUspX1mpLgZes3
 jd6sjbmZp2Kp02eiF4Q00pbXsQIzfTNaSSLuL9U0wFF3AObf5T6J0OzF4J28ddWxKzQf
 lrqFCtL5Cz4KH4crcQJe/69bhYNeUFvy9emwti/HlTO8SFo35s0+1A5T7nvf4LmcyD9L
 QoJF7ZQJwyYwHy8Qfmjs/GqeJB7EuAJydFsucNHdWHllOLFFsoKlwUOQulH7icCEY7Va
 Ew/Q==
X-Gm-Message-State: AFuF++kqbkjiXaTd7fry66CVQcKUyclrFCmV8O5chyeECVvDVbQ7/RnD
 MELdKGkDRNVr4wZa1NzTCs+d0PhUFm3gkYFJXrh+iUxm44Cei1fPSf3S5+rv1oRkQK0jSDedwl6
 Oxv0SDy3RQ19RUQO7tk948j5JKGgaBQl9qLjSSplBC3+VLi1uMICEbukH/f2EQJLBtg==
X-Gm-Gg: AR+sD10a1x2WZvz82zlMgw4fUF6KDrylDKfax9AFk1f4rez8H+7Wkvu6psl7vZC3BFw
 bhhMNVLeQWuvExSPgMwRItXFGVpelCpu5OV2gxbFnao2JBCZfo1nnPZqHeMaU7xIqRfyb02JS7/
 LYPy3TU8qkA01HLWY8K5H5aGgIfMJcMadKx/LJuE4t0dzH5gqkR22zVsEVvSiO/caLehFPgD8bL
 DVXPoMi+q7JHFpQeqHz9Mu0UzQxw/A+/+yf7hSWunj0Zs4umsk3JH+uZjF2yKSeNI7uuPObOU1P
 SJJZmZ1twm6evX7yNifVEwLozKZJd2SJsNQK47nLnJsh16NqrQuEtwILeQ9qADspsQeMzm8FKQ5
 1BkjZdFXZdWrR08D6tkajStt/HdhhCzSEV7xDY9LfSf059Nl0sCEEpMKzZ9Q=
X-Received: by 2002:a05:6a00:b85:b0:84e:2382:f4f0 with SMTP id
 d2e1a72fcca58-8562839d75amr4326718b3a.4.1787868927297; 
 Thu, 27 Aug 2026 15:15:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:b85:b0:84e:2382:f4f0 with SMTP id
 d2e1a72fcca58-8562839d75amr4326612b3a.4.1787868926820; 
 Thu, 27 Aug 2026 15:15:26 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:26 -0700 (PDT)
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
Subject: [PATCH v8 015/105] tests/tcg/meson.build: introduce wrapper
Date: Thu, 27 Aug 2026 22:13:36 +0000
Message-ID: <20260827221506.91574-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b700 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NC2emROsuJ00p6e-phvnYLOJaw93EPpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxKUcB203Ry3B
 APSozRDWYUyT08d1jZAL4E5O//lE8x3TNrybs8s5pdJPSECGDCOXA4FlNdQyLpYqjY9Ow7eq2ep
 OnmOduUdFHclBeLGkRWVCdd4nLNEVRdqMiLTWWuqKL0C2s2Nyp4ZC/10UhmyMpbOWEQG562zwOc
 vrUm3SJuKQl3s8QWSnaD+e+PKmwSDt/CHVpuG+I9Csgx3XVdM+5JtQOcX+lkqX1gCpshLkfLH9P
 mcYLGZSn3bL8xwg2RnB35pmflEUFhGUQSvfobiSgG4Y/aNfURMvDgAWDZabw25f3qoltvJ3inKC
 bUqRSQ350Yq6AZgm8PvIfWja6T6+2UR20UY+qZajyIQEXWllATQOK8CKTprnJS1AdnxU1dbTXQF
 GE9iODgEJQgwq2/f2ibNULMHjSyp6Ww27dFCFaLohzsKpMMsh91adZlJA9tuR0ZkqUw+gdzkXM4
 OHHP8k6iP+4jMqx9zWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6KXcBIwcR04C
 wgOQ/yk9frgNFS7A7Olnum16eti/tElmkk3l8QFVquppxzaZFLCJR7EjsowS5h4sUwvv39fsFlL
 0hlg3wYZkctmwdANM4chGKlhIUHEARc=
X-Proofpoint-ORIG-GUID: NC2emROsuJ00p6e-phvnYLOJaw93EPpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76375615d0b..0311b2432e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -25,6 +25,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -86,7 +87,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -200,6 +201,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.43.0


