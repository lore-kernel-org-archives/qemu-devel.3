Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7D1C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNb-0004xG-IE; Thu, 27 Aug 2026 18:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNY-0004wD-OT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNW-00061w-W8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM26Z3848558
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=; b=Oof6nL2++zIGTBMO
 hYLLdL7e5j7zjfufDcXaH58M+/LMhArEk8RG9l1EQ1SFBNr+AeulMOu753PfONhy
 iKhvLf/EdYuqdU8VU5cTMU2dCSvrE9vrG3t0n+Ge4WMMQtQ6/komQl9MIraNjkE9
 VkRC9Ecia5kYgN5VVC2CWC87pxMLFglinBWSMMUBn49uQGh+5m8cC37kLklOiIdf
 JbLChjtmq6ZvhEX4JlM8RRmX91qgZBw8lhRMO51ojCLD/3CCAxAuNd9Z+G6IGRxx
 a0sO2dHghL9gScAer7xCOJ8RZrEBMgfGIzeZecskm1n0DIlE7RUQPVnWpQKMgqRL
 wTcfvg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0tv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-855f662439aso824744b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868921; x=1788473721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=;
 b=YEu1yMOg0Q22DasBE/pndWdaSq4GlXg1Ul7VOmIpMtK1T+PLzoT4vl8UagCtd6W3Q/
 weYELtdHT1TR2nfA1HOFnlQ+qVEh0Ok3W8zinn0kXG+LqyfSakMiqGptsVIEQAFYsRuj
 2xyUBq8HkqXVzwh86QkIDJ1kyx3tWJ/3sRn73CaXTRoZpybeH5Jq7ShCDPWJD0xHX9Gt
 1d4QNF4ymN2QUtwVkLi4KaVgQmeI/rQMRXuslAZ0MYNWfQN8LeQacOsN1hH9kekgil/i
 tvLIZb2jb8XcLpc7qm2UoR5bWZfQSviupRnQ+u0FeHDsJMWzRd1MxAF4zk8k8CwdWvQe
 V9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868921; x=1788473721;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=;
 b=YqMczni1mV+n5ANBmid7RRvVl4nCVbzZVCuGYfJA+EYjvIMb2BV4Ts/QVyLdeRdBUL
 woMJ3euqw9v277wRSKPVRiokhwI5qxuqomhdVcwpe7h5rP17j2COK6fDPZwKtfKIYYkb
 mEkpgSjjSfzqZX2TI1QY1ZD4cgYfq6CN6LJCdFIt8DF+hY51qG87gszJdxs18olFqlD0
 qST9xWxrplECzOV7ei4Q8PsrfS5NSzRLGsD3K62qMMdout+R3vDqSLEk6Q3B6xjUCBbk
 NM58YQsPvAgo4Lt5AYHCru8jtjrHPRksMCts2EGfB7BjxTn3OwFXoOBJh/iEGdnpFmbC
 O+XA==
X-Gm-Message-State: AFuF++kK5qWzIQ+II5Oj5UbcncH1Hg03xZO1YUseepykKDiG/dITK+Y7
 0AFP70zOerIPtCnxuFElye519T9mR8gWPsp+TM7kCck2OpO0FICKZn+2mmIY7AAQl6YKMAoK+dk
 a2vpp6DFLTPnF2JgpmLnmQblO8zpeQqBFuuT+5pbwGU5m9G/KyrFDTFPiMbyU3K5I7A==
X-Gm-Gg: AR+sD13kFaaqCq6sUzciIds4k1f4reV1RCZPTZp4PAf4uOoWni06OA5W4pJ3Umlk4uh
 8BRPIpL8JsKCpGxaD2Try+fz+A+0Ze5OpyVYbPkrX327ZXxY17fEADD9QB7KPRU9Ds3UGM+Ylag
 cJktf2vGYENc22CdfAv+a/7YeBR8EP6epsdrLDvuKgJDJ9fCzQoC+D5LSabbaZRNu/vTzN3HrE5
 TQGwqqdpLQEwidgrhksAXTALnokcQuPJzp48ryEktcQsJVLLz8kM+wmVhfNyA7FRMiwYnvHRS0/
 gKWcRUmKWdBO2za1VxOR8J+YKF9mqH3l0+yqpBq2Zis5qH348pEIB8YHc3SUXCiCbKoY04RTI1c
 2aGwN119nKNR9DmQbaFQ005W+IFnUxW1XOl0rzrHh4gC8gBgVrs88K0n/gHI=
X-Received: by 2002:a05:6a00:a21e:b0:842:55b6:f5a1 with SMTP id
 d2e1a72fcca58-8562868f7b6mr3665395b3a.6.1787868921017; 
 Thu, 27 Aug 2026 15:15:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:a21e:b0:842:55b6:f5a1 with SMTP id
 d2e1a72fcca58-8562868f7b6mr3665283b3a.6.1787868920572; 
 Thu, 27 Aug 2026 15:15:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:19 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 010/105] tests/tcg/meson.build: introduce env_var
Date: Thu, 27 Aug 2026 22:13:31 +0000
Message-ID: <20260827221506.91574-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwhQHZJzxJIV3
 xkolMlYdldEBpuU2rK9Vk9YEy/AUtEiPbqGPz1WSez9rjFpnlTY/7IaV59l/FuJU+WvakGdCwgX
 hBcL6jxxvKzPye3mbHFueWsizzj5YK6jaS1Zl3Xlzf0/HQYEl9EetW+Oci16NkeYXSBhbuSaPk1
 3i+RJtiHKZ7lsz/J/kxTC2dWz9Qk8r2l2+0v23gQ4gWIHbEV8qZLh7HO50Tca6rwq0ms17q63dk
 vymeyac718GOsY9fkEGMNJ4KoFgHDJfeemaNNETG+QU+7r0pUnMREzdZ+d8OX2vyPeOSqo9jI47
 3SaGejYSJrkWe7os5YjP6GG457XoUYYG9Vawj6m8AJcMk1waDACkGPw60E9XnGBaJZeV43z+l42
 0OWBNDTeDewyzrM93WlOGLgt9r44PWn+OYDom0g1j+7LkkcuIPgT+2n9dhQA5KJxjU9Uc75mAIm
 hjI3vVdrunbePX7ILFQ==
X-Proofpoint-ORIG-GUID: I3V_JGIh4qlaMu1EWH5MNw39Cq05I-WQ
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b6f9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzXEHtKJ5bnpP
 DdeF2R0mGNGTfZM0nIpwSIxMsbxUX3563nJXNaOqK8hkLsjxX4wdQnR+RBWOqe6VhPJ5LYUcF6Z
 kDuNI+tmW8GtZVn0JotsiOpnLufN4VU=
X-Proofpoint-GUID: I3V_JGIh4qlaMu1EWH5MNw39Cq05I-WQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a7699b7f62d..fbee86e6b4b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -57,7 +58,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -122,6 +123,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.43.0


