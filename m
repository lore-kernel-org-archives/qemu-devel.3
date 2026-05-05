Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDEFFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 23:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOqx-0004XK-0P; Tue, 05 May 2026 19:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOqw-0004X3-9Q
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:06:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOqu-0002VE-Fq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:06:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645JiiY43187637
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 23:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QcrzCqFlvqL7QgZj1xuUqzQdM1Ng3VPnXFZc9RihYEk=; b=babLKybHMQmCAcL4
 Fbg5v0d8mv2ArIkKU6oynDVLjbDczuujpLnCsyaIimTGxZGNCVPxWCZMsu2DX9Ed
 iOKg0VyB2tUq9bHDSXgn135Q8vCEkd1ckCqZKBxeTqtxuuVKqEjRslczyInVOGyB
 FtvaFc+OIkVBPDVODxFCHrRp9gljp0DaLeOZN+G4dXwUbEXlHMqHuQyCZKzGyY0+
 AQnhr8klmHqAVCZFCe+u95PG49eMAEPpgpjSYkE4vpVDp0AyQXDNLn6+z1kdHDcu
 w3pNzO38OyKjWtMgYU8ECTiiZmRua1htbs5ZP1hLfLtzUMr4bmKTPuU2UkRfl0Pb
 QXJ1mg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkbnyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 23:06:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c16233ee11so7742295eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778022413; x=1778627213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcrzCqFlvqL7QgZj1xuUqzQdM1Ng3VPnXFZc9RihYEk=;
 b=FHLM/H+QK9Ju4r8taWV+GINdKOUb1AiJGHpceyo4aZPbR/jvNOtq8rwAkQ2/wJWcmo
 ej5eAr20a/Sotl/YN4tOm6MfuSJSEs2bgILPNxoZ/k7W3YAD6Y6BX5JBSctY9y/03U0x
 DscpP1M4Rp4Y1LBu2XHDypH/KE2mFKbfHq2GwqZb0Wb8DnO0/qYi79l4PDWsOpvxf4IJ
 hHguehJwDWpRaiQw0vYIi05nWS0dhPpbjmrMMxYDvYpl63xoSQtPVrTijv/rfHUCa6EG
 qK8K/1wdIQQtmCN6PpdJZjk60Z6DgrrSMhGrhMsC+VUas74YLSiZpFlL/JWMaE8kSrDw
 ZRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778022413; x=1778627213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QcrzCqFlvqL7QgZj1xuUqzQdM1Ng3VPnXFZc9RihYEk=;
 b=HNjmuVIzvYQHnSRgIRsGz4JYYQk3i72eqG5cv4yY2SrLdjo1SpsjvAuv+kulCZu6PH
 TOH/yCtQrHdWDY0VnPOGjDti1xia3BYug3hGU5jg288W+HIxJ3yEc4P94vamtvrlxX6q
 F7WDpTQ/1pBkS6n5LPGwDvc7ynT4QadudhxiiTz7lhdgLzyrQTESO+XU7ghCZ3O37hFC
 BIiSOIzDihxhMIJ8bTYONIjhdiM2YMDD8C/pxp3FURvt/+6rgI3r6obwU7uqDVAf80My
 tEiB7XRk9mEImcggizXyTNegsboU6Wf8wEcgnWsSInJncK/1OY4QxnBmwC9YY+JNOAlv
 lF9w==
X-Gm-Message-State: AOJu0Yx9NCK73gw3Tz6rEGA3EAGSLGW0J3LgOmYj3WOcyMJ4RGo5Q8hk
 DWoeubp9wzzoI4kqbp3AqZwQ/+qLa+S7SPxcapkL0dA0Sqz3Cif+HIMa7g7NyLfJ7YEwIU01Jzd
 z+5SQFXhCMYuoIj81uNyTfdUJHVdDLDOG1SuXDL6ErMKrcAoC7JxWqunbI17ccOsDktQW
X-Gm-Gg: AeBDieupLS/8X3otCbjnBEwMaueROE/VoA7nW+dlmm3fC+AlxdlIT61ZFQH9ni8X+ss
 GWxjv03CEYHy+7Cwq0AWZX1yx7jLZN6gkvMy/l5acg8z21wM9Qi0Dj8q+Loss4WdwfAChOzyKEy
 /oL3HZg0Spweq+dxZI94rQZUtGPajNZQP1i1HYZQSJlcL0t5usLl5IC/b5Rk1d+VYpCevpnMs5s
 xq82GmM87Qa4HcQ1tFh/Jl/e22KSRkdCpdeqn9qJkMOjcp2+cTk4YzxSfOI6wUANS/5tJnxueUX
 ZSlPU2zqk0yAUTkOrYnoyVQNpy4IjEgcAfLQqse5QvzmNfGP4DMm7918CVEZy7DEjjuBjtWOF60
 mTWDYYtQg682zsOljv074F4VEnUN3XemjQrh/CBZAuPgWcDVKCnTCGrG7gEr/724R9yBOdP71H7
 9jU9gniXrZGgUwNpcU
X-Received: by 2002:a05:7022:393:b0:12d:de3e:86b9 with SMTP id
 a92af1059eb24-1318eb4a50amr641867c88.41.1778022413373; 
 Tue, 05 May 2026 16:06:53 -0700 (PDT)
X-Received: by 2002:a05:7022:393:b0:12d:de3e:86b9 with SMTP id
 a92af1059eb24-1318eb4a50amr641842c88.41.1778022412610; 
 Tue, 05 May 2026 16:06:52 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57038c644sm911290eec.29.2026.05.05.16.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 16:06:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] meson.build: define stubs library per target base
 architecture
Date: Tue,  5 May 2026 16:06:43 -0700
Message-ID: <20260505230644.2710049-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyNSBTYWx0ZWRfX6gN0LHwmqpf6
 38lAxfCl+0XC0nbao/FoQ+Vj5RzOOKK1nKeYpzuXn6HE5e3pY6WlLtQ/qJZee1tXAh1VROgVTTd
 JNygnhsxaKYAxuiuFlc3M//Bh4fJt27D3FmhADEwwoESgfylKF55ki4GAw9SmYki8LIlELk/mDz
 muFbEV4pWj7HiADlnC5WafxB2N82fxD/CG1MnNCdfByMoAPCen+IHGqius5hePMp9aqMt22ILh4
 sxwh6HxRVnSLk8uRFb24nUx3/5J0cABDSP9spG9gSfFsfEOnJsIm6nx0uw7MtlP1Wy6qPH/9p5b
 nAHl7J19xALhfmrPDtwMTcBvdvePqHLemXyinNMV3GOR8zaoUAVg5Fo/KGl1qW3tL/pzYrilhpb
 5YRX/kBXnlFSKLwKq9eI5U/SzAnFV2Dw6rC+j9dNrtlSyjt5VGCDNodqBuBSH2euiynIYUGYUzx
 8Keszx79q5FUU4baurA==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa780f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=vAAjUAkajoglRl0kLfkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7jNWo5xr5wFug6Zh5QrdXQe-931mnBZF
X-Proofpoint-ORIG-GUID: 7jNWo5xr5wFug6Zh5QrdXQe-931mnBZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050225
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

QEMU stubs (from stubs folder) have a unique feature: they emulate weak
symbols. Weak symbols are not supported on Windows with gcc. This is
achieved by defining a static library, so the linker can pick a file
only when one of its symbol is needed.

The problem is that common stubs are embedded in qemuutil, which is
defined and created before any target code. Thus, to benefit from the
same feature for target code, we need to create stub static libraries
for each target architecture.

To keep things simple, we declare one library per target base
architecture. This implies that stubs are compiled only once, and we
choose them to be system common files. This is not a big issue, since
stubs definition have no specific behaviour, out of returning a default
value, or stopping execution, which makes this safe to link them in user
binaries also.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 4176d020c21..4dfa73576dd 100644
--- a/meson.build
+++ b/meson.build
@@ -3738,6 +3738,7 @@ target_user_arch = {}
 hw_common_arch = {}
 target_common_arch = {}
 target_common_system_arch = {}
+target_stubs_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4143,6 +4144,7 @@ common_all = static_library('common',
 # construct common libraries per base architecture
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
+target_stubs_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
@@ -4202,6 +4204,15 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       dependencies: src.all_dependencies() + common_deps + system_deps)
     target_common_system_arch_libs += {target_base_arch: lib}
   endif
+
+  if target_base_arch in target_stubs_arch
+    src = target_stubs_arch[target_base_arch]
+    lib = static_library('stubs_' + target_base_arch,
+                         sources: src.all_sources() + genh,
+                         include_directories: inc,
+                         c_args: target_system_c_args)
+    target_stubs_arch_libs += {target_base_arch: lib}
+  endif
 endforeach
 
 if have_rust
@@ -4361,6 +4372,11 @@ foreach target : target_dirs
     objects += lib.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
+  lib_target_stubs = []
+  if target_base_arch in target_stubs_arch_libs
+    lib_target_stubs = [target_stubs_arch_libs[target_base_arch]]
+  endif
+  target_stubs = declare_dependency(link_with: lib_target_stubs)
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
@@ -4406,14 +4422,14 @@ foreach target : target_dirs
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
       'sources': [main_rs, files('system/main.c')],
-      'dependencies': [sdl]
+      'dependencies': [sdl, target_stubs],
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
         'sources': [main_rs, files('system/main.c')],
-        'dependencies': [sdl]
+        'dependencies': [sdl, target_stubs],
       }]
     endif
     if get_option('fuzzing')
@@ -4430,7 +4446,7 @@ foreach target : target_dirs
       'name': 'qemu-' + target_name,
       'win_subsystem': 'console',
       'sources': [],
-      'dependencies': []
+      'dependencies': [target_stubs]
     }]
   endif
   foreach exe: execs
-- 
2.43.0


