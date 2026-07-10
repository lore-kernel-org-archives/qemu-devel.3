Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B092C44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bT-00016o-KV; Fri, 10 Jul 2026 02:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bR-00016E-Hv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bP-0004WU-R1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mjVG3898570
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VQ92xz8SLSVnFpt24YwwRSeT7/OUX4DPms5C8Y4631k=; b=mr7z866qg5y8flhU
 nsdwpmPqvaLfr4PxfvhdM/zG2LvPyWYoa5VdhOcZkr1heK/h+8JZw3/3yVEpGCnl
 QSi4DVPgCrQ9NDpSatYcbQ8y6GR5TJ1hVrM0ThCwKqGpUm+D8pZ9BSyuJ8uFCWMO
 MTpBXB0jdSOCCNTjQAXXsjm7h8tP0Xi7x/EHpBI6vKcVvoGPv/uUqCnAyweUeWSJ
 6mHeR31oDt61rrEyJmFXDVPuGfeRaVZwT7EyDaQGdjEg11UHwTxOTJfxS5hWx6Nu
 NhO4YlqFqa/mAsfHXUunQPV5JihZCL6jwMt1YyuGp7ONa6vrsJuIbh7EF/FX/LcF
 8Gj4Jw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3k3q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8895156101so1010868a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664445; x=1784269245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VQ92xz8SLSVnFpt24YwwRSeT7/OUX4DPms5C8Y4631k=;
 b=QoCVyDkyYC1uI9IY2fFKxv16UYZYJtDTjDDCl1kUYwtJVRWgS2zLhKLrcNLFnXiY99
 unbJJ8w16yZANyHYh59/n6jz+SfIdK4Grjij7hJOsHFRqAI35yzOubp7zMU7xRuod1WD
 nsMPujuJQk7O54GcUjnKlC9vJUb7Q1vXJFQ7n9RNJJ+4VapZzZ7mdboxYZqhEclBYHc7
 VHJxD5tXByOhCbtD2TpVx0QNU9F+1jJXcZ1jfp66qLlqURjgwzRCparhU/74hdp3jF63
 FwiRz8n6n6kfvbl5b5B9t4sP3mrIcA9arAA09mXvjcd7gTPdMytI1rSkqJu9/k0UMr9Y
 QvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664445; x=1784269245;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VQ92xz8SLSVnFpt24YwwRSeT7/OUX4DPms5C8Y4631k=;
 b=iOSFwbuqA+LNGICeHMstCHoazKYb3scbdf5M8loO4POTavSLF8U76uVua4JrTmlIYF
 gN7hXe0ZwNDYgZK2ORlqme8uen2lsM7kRNog2myBtcP1uBmL2f8yOzlF3JiSvSQX327h
 G+H+yWxsm//RdOrO0XXHh2VPof15PiAwt3mvGBzCBDfZVLLjFVqGZJ+HognJs06eeGln
 KWQJErAEdv41UwZ5uEeUTHjd/T4rg6Wr6PBhrgf29y2ZpdL7P77gOgsCv+vBXu1702ki
 R5gU1ZrDrnRcdJuB+/whLmgIEXak/vNynhJpqKgHaoDpS2tABXL6TXvcTXe5AdSJD/E7
 4auw==
X-Gm-Message-State: AOJu0Yw7iAd2Aq1gFenD4Q400Hqd1uKQI345zzot2qxW42sXjULacBhW
 ARct+7RxW+xhQhdTWTuHpsZYRD1tFGjz4rs7XAC+xtW6+NWvbggAkMGOCPoKKwnmrO9pFqfeAgP
 JMKkay2d3qON6AQrcm/u9SstXXpdfuFikMFcZQ93VWMjp5iVnPzqqiv0oF+PbCa2zAQ==
X-Gm-Gg: AfdE7ck09j5jqZgTGAY8CmCnsHqzPSGQes7BbmoB0854OpZ08MlkB8rmFDP9EySy7xF
 8fcMXvFbE0tQUEW8CZRMjSD0rAieeU51N9jzF9UYqKDHCcy4hINU8IkYLk45prWFNJoBok+SWMX
 gBMkN51WvG5UV4vLf4zD6luKICpIyKfX+RoCXDHRI3ufQJ2Hn+fwHqfusK4eDH6A+D28TP+4wfv
 /FjfH/D0+6d1sT4CI5lWR1eXO1Lds8OraiGAYwAE5V+mtcSbP7Z+mWjLCu7YB7M9cEQs5JzAWk4
 l+MKIYR/56RrknSWWt+2ljBPLnBk+zkhhO5IGbBVv22CKc6dHA1kOqjheAVC5e4fE2XwSHW8YdF
 Uf69SXZ6txJGea/1YL3SFZNvz/S8V4BnLA/RoBNaVApsSEbN46LOcSVH9ngDAJfmIzdE0HZqbVv
 be0bZAKw==
X-Received: by 2002:a05:6a21:e8b:b0:3bf:6c08:fb87 with SMTP id
 adf61e73a8af0-3c0bd30e1cdmr11823506637.55.1783664445459; 
 Thu, 09 Jul 2026 23:20:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8b:b0:3bf:6c08:fb87 with SMTP id
 adf61e73a8af0-3c0bd30e1cdmr11823469637.55.1783664445022; 
 Thu, 09 Jul 2026 23:20:45 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 10/97] tests/tcg/meson.build: introduce env_var
Date: Thu,  9 Jul 2026 23:18:48 -0700
Message-ID: <20260710062016.1818125-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0VNzbte7Flit
 NfWHLFeaGJJduupUcTeiSCaz0mUZp1XkWk0nTxJXdmsY4+lFNN582n+m32cnliVEZcloxOoBq+l
 Cow7qixgSjky62IGX9YUUSypNPWZYCcVRqbXFLFcjagURQSUZU5PLwL4t9Qid7hahUYxDlJFXCU
 mTFZadmlKBcG1jxLNwejQvRmx3vzkj5WAJEbMerkI191MFH4NeKm/si+lLzguyqUP3z6xD8pYDb
 WNkkl1kTU52bcJ/575RKwvdvenIap6nGsnJVi0joD0j8Q2Lpwm5XThvwB1RmllBBG1G4RspNFMq
 hoS3eHRXX/eZripK4jQEMIp3Gc5r9cT/vSSYy/E657MHI3FzQy8DCVQCRDAn/NbjSmaBamiEKTj
 MLSy5Y5mZdWDKYNCpENKQa2KdDTT2JqGVal2nLxUw4AKGOmY8v5xicYbRLI7OTcu2kRdSw91ZPu
 bRe3qv3v7Itw05/8XqQ==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a508f3e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3dHxtQYvgyzm
 kQZKw0rEUXKRTS3EcYiayOAWwTcqae0EHkLDW9xlaGaZar8zzQ6j+mPvEThRxqb1dRwVzOJDPiG
 8/e1BnUs2VvXMnYYpqAa7ABP5C2zpFA=
X-Proofpoint-GUID: 4hhKYMiPjqeclbfbFPjthMN_WQFwEXxz
X-Proofpoint-ORIG-GUID: 4hhKYMiPjqeclbfbFPjthMN_WQFwEXxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8c82a49b3ec..0acda478198 100644
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
            suite: ['tcg', 'tcg-' + target])
-- 
2.47.3


