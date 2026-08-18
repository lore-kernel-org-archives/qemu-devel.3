Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0502C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPb-0006fd-O0; Tue, 18 Aug 2026 15:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPa-0006fP-9g
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPY-0006cN-Hp
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH5JH3003297
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=; b=XzQIPMsldX4GPhtA
 3C8QmV1mSjRa6AaaFm3bwFcKtxXZRBYjS9LpRckGURXaOpttqLrpUz5AoSkaKhcT
 RJ1aCYGdD79PuEojK8BUJfXVNCGpGiaqSl0bsthO+nhWww7S46Dyc8Nzt604h/h0
 VEl16L84Ad4oPwKz9AkoNNLN/gRl1GPIua+k9GIaYmnBRpehmDxDZAgdF6Ryw+xT
 zJC13mPQKJ0xTaFro1f97VmOwNQbl2ttV86Wyzj77AxrhzcSpAx6RRwFynwYOK45
 WUkL4wkUjNgRKaH3Iz5RuA43xnHN9K27v6njwyKou0uLhaw/8PzG78pYveIzSz03
 g4FrfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv3ck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so374779a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081016; x=1787685816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=;
 b=Rj5WrO64zJ2RAZJF6YKDSnS5rGjgRRp8lGYX68nV2WyFzXvQvn6ZECdPzjaKkA9+wa
 R+nwMRZY5X2qrXuZ1T+DuQfVsBPdG+pUrrraAz/sASRkpO523JqsnFOMF1FXVGn72fJp
 7ui+ZzLyBIAVRkWY3NH25N7GFJd5ellPQYOOSFs5DdOFZLM75nv4oklBxT2ESuAG6C6z
 VtGZnWJjGGn64+nfsvj9KtZqtxMBsja4OR+pXR+OYEdp8x3LezWzUj7kQMSMrCuy3Iez
 ABOOgyEbLoB8EvzgusyocaG4LuCcwvsFqU8qSI8U64New23hPlEe4tN1TJuG9IuvnGI3
 Svaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081016; x=1787685816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=;
 b=jieIZcmZdNql1zDHsXo0efjogOd+omz1eU4mj9csuNovo4YV7vfn8RgwqNnAJ//6we
 iDIEwxvCt0fozdq2PWRfRoyJ8Y5vjbDkU1Sj1YeDtNuZtKpyEg3IPfoIcrjkZUGc3HhH
 HOlz6+awdhFvh1fptk8RdRbwDDRvjwq5R9VOu4zUwlQgEcXOpVA2v4+MMqiDI6wHpb7x
 6EmSJ1Kpstl6siCZ4KCHqTlS1VxuOegv3bEuQai+H38iaxhSCPtE98orlKYvj8AD5VZR
 UcMIvrjDK5X/dYxvHREj+jaHgovp90mx+phWUMtSqlojo9h0VXQhyDTTAoSb4Mqr4cU9
 dhtg==
X-Gm-Message-State: AOJu0YwrwuEIc4kUyFUuHNzBrkvYsu7xsR9syjma/opC3LXZebrNPzp+
 Tyxogdh6Ds3v2ZS/wIgDn1dNQZeTrpCvhF2T4UUfaGvh8LuKiDGnCtkFjIamNApi4a51b6XzZG4
 YhYqj2GubuY6b7KvCv+OSTDUMrgAAga2zdI3Gamnpls8riqFgh2sW/ij1f26bFADzng==
X-Gm-Gg: AR+sD12FN3SKgmX0n/N6FzSVN2yTQVnqu7M9h+U/jJB4LYR9Ktg5jgVmhWCwbP0OnNS
 iehwRoKCwLpxu5th2ZeoBLXkvi+UO8Bn1xrpsD8sLT/pJQ4Ia/o5dMhYbMwnRIpOJqJjmQb7hvG
 p0N2Ai3BbIZyC0Gdf0yOwWbS6zRZUL+mCOFI01gP5Ypwk4fsadRT7cOUv5KlGdFZ5pajzF/rstl
 mske4reNSIdVnV9sdp0L4hMO5V/nuWkH1c51xgmY9nOOufIQ4VRQkdGqQGcjXy19JsNupwBqYTv
 kq5boaNoAs3eXPRUadKX/vNw99CiDWKiAnGn56JchoqNb56S7VIcAEyKWAlFSp6C9cE3Je87CRz
 ctytRC+ap4nr7ZejC5TO50wBaKBcbpoIfTzhUFqmZ4bnbGAT/lAlSFHT5WzI=
X-Received: by 2002:a17:90a:c2cf:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-3957b359d2dmr23644a91.5.1787081016116; 
 Tue, 18 Aug 2026 12:23:36 -0700 (PDT)
X-Received: by 2002:a17:90a:c2cf:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-3957b359d2dmr23551a91.5.1787081015710; 
 Tue, 18 Aug 2026 12:23:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:35 -0700 (PDT)
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
Subject: [PATCH v7 012/104] tests/tcg/meson.build: introduce plugin_test
Date: Tue, 18 Aug 2026 19:21:36 +0000
Message-ID: <20260818192309.22169-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9BdlNE42Ot/o
 3iAFG0ZBT9PbqCT+3xYExE/m3LKDj5Aj9b4BOwB8Ncs32I3SmGQqd9+jnXQjn5F2UAy48XUYWWa
 Mu7R4CZzdwna6QUVkLWZITboULoBLPN06x7qNOS/ELd1qYjkvb0nFpbeE0ftypuQ1jsy/VL5eco
 A7Wmo8S2VbXnsRnRSsxVD8dlXOIH94v/LcJVNxAUUZABeDzjsv781iHE/Oee696k92FrKz0G1Gh
 gDeb9W+5ongAfvunZo7/1L/nVGFaNzDfXU1vTy7Q7gaDtEfaPK/5ytgSE6M0fHLpqeG0fSZttRy
 c4Rq+WSLf6pSHkzYLuCxkYeoYSjZ+FoxBKYGPt9+CUFjiOe2nds+61elPvQvgz5y1jJCTMUalWt
 RdJGTPCT80Qvcazo5j/Ycc/opZTevi8+BmdklT2SHfocksMu3d9wmtZzkilwLW5/9lFFxw0zxsz
 MrtdEmboBfEgyzcg4+A==
X-Proofpoint-GUID: rFB-R78OeuFxlaGezNyQgu7atxEw4PzG
X-Proofpoint-ORIG-GUID: rFB-R78OeuFxlaGezNyQgu7atxEw4PzG
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b139 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=f31TsGN4npWs9EMxSNoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXz88om4wgwHdX
 IPumf932Sb6R2sOaI2EDgmA8HNg7kakRKbruXrgHQBHwfIysjoOVPHZN7j+MfMCQ6XGjglJg+Wx
 eqT56QfjGieMWs2o8jZbOooy9Ge4QYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9940bae80a4..7b51750b016 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -59,13 +63,29 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+                   'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
         endif
       endforeach
 
+      # return a clear error if user misspell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          allowed = ['args', 'plugin']
+          if key not in allowed
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src +
+                  ' (possible: [' + ', '.join(allowed) + '])')
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -78,6 +98,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        # remove 'lib' prefix
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -118,6 +144,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.43.0


