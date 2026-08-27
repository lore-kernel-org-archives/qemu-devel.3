Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F72C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG2-0007VA-KW; Thu, 27 Aug 2026 18:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG1-0007UR-GK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFz-0003Sv-Of
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLv541117690
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jEi7+9wXPIv
 iNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=; b=nR80SlobzMb7FwbFdzjTgSckdug
 7AbHa6iVjz/AVd+XxccfA+iiDCsJFDBJEK7C83bejqHr7/P28BwfwNixRNuFoste
 RToL4eHkNLoJi+9iBAtMa6uI0Wna9R3rFXHUNENM5rp8Z/7deF9CMBpFRzRDggva
 lDFaF1T6azBJXQGW4Ky0e/v4YfghLYo0uOf0jVjZrWyx7cOG9+zoaMErX/1WSvKN
 0POK/lwzO1xYhQltizWLr5uHk5e8YjJPzYpqeN1xcrzJksuwP4yRrbdP1EkxKXGs
 kwleIEP64mIG4RVoeDpebrXMQpejuS9XvUn/t1VDE7qou4N9qrLmWavz7SA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hefa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so228040a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868444; x=1788473244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEi7+9wXPIviNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=;
 b=XJ9h50PPLb+LI1Yu2SckyX/JaoYvHH3IXT3k2XPA+SfVJ3lyotjhcoe6vRXnwvUhOC
 FdnTTojyfwoprpqzZNfvhdCuYtM9lER5ZNj6kOXMMJ7/K8S1vAMzDo11A8LlaEAoYRR/
 3ZIJ/r9sg/FzKi4uL6Y0ta2zHQPrxXVYjMR3DcZpTLvBn8OzxTfP2eyGKaEIVnp0vPfc
 GGy19RR4Iv5A9NHfjsZeihqlA779Lv9kBTbHpLKRIW9cUy1jAOWJLgnL5VRU3rw6qCHC
 m//Is6prlx8gqFraYGsbUE5A2mxpId3d053YflrhldeGq0I3avs4F7CX5a0PAy7AMSPw
 fl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868444; x=1788473244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jEi7+9wXPIviNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=;
 b=Xli3h6zcw3sVUwNPFZwkX+bkE9lZ7OFVPZyEtIYk+GhtYupBvdCyqF5iqv3aRsGMs7
 SHA2qs6O9jfnGq2IF2E0Nq1apBazdf3OTwMYSLBJFITPcXo1Az/88SsTbM6sTGe5z1TH
 FqgE7BmqXtx3GBIlhLfIyWSOAIi9nP6Q7RGaPbesEEZAWJm1cFpSd0dCcnF/F2eb94Yz
 0ttC+BEXrsi9lO30OqxLasysSc3FFFvScwu4+GyaZvocfvSOGR4xPAZK/P3LH2FfHQQq
 sInkhvrC0XM7pl7ixwX6tRNAtdpVvVLeR4VRfChtxgiubP0Yo0N61FVTAX7+64WZTdGC
 wOxQ==
X-Gm-Message-State: AFuF++k4wt7ezWeTrJfpm70zpiLU6XUqwut1Kz7zjmVNAvkcC8YwEVPB
 C728OgSE+f5clGSMJB4AbZ3919oELnpMQk2ZhiEwkFPyu46bX0YJYb2GuCGLMrxSYnlIg6RXSVK
 vGZZa+XaJYKLJWICtKZHXc6wpafFhz1FOAiSEatA2wOgdMlWWbexmf2GrVP+Fd3qxsA==
X-Gm-Gg: AR+sD101waPr/c6LA1EbMpKH+3oZf3+3E/kt+o5cIyhUhgm19pBrD1f/0rkAhfK0Qyc
 Ff95UhzyGUaDnBY4Fl22k0STpbEt/9CheOLyU1++gkPIMDD+i1PEh/lGG4KLnJ989N0ho4veCy9
 tYQhVKqhyF0oOdZyM3CktDI8zGVv998u1osSFdVPu8IKKZXhJ9s7vfFxxD/ht82Lwiusxq6zzxT
 sebV4W4GT5vvF9QExb4/tmRSgBj2jU/I/Eu7DfM3lyfZOemvyk37033lJ8FZybnOQledeClpx8/
 K/65dw4eXo+CEVsbhuc5plSrk0Ud91ZDBObrbsek+KcIsHO1zS7tIVTiywz0dgKJJmiIcjECL5N
 GJGs08TBUiWQsg7dRuKa2Pe7rq4iPVWyl1fr3bKhaiRYPkQazlkPn3bHx7Kc=
X-Received: by 2002:a05:6a00:b46:b0:848:46a0:3d74 with SMTP id
 d2e1a72fcca58-8562b499a1cmr4312164b3a.9.1787868443844; 
 Thu, 27 Aug 2026 15:07:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:b46:b0:848:46a0:3d74 with SMTP id
 d2e1a72fcca58-8562b499a1cmr4312087b3a.9.1787868443443; 
 Thu, 27 Aug 2026 15:07:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:22 -0700 (PDT)
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
Subject: [PATCH v8 025/105] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Thu, 27 Aug 2026 22:05:19 +0000
Message-ID: <20260827220641.84885-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXyh80AyVzuunT
 2iHqkL0VA/CSP+X+CjboJ2qDS3QzoR3rUc3KRhU1LdwHLjtFfgbeTaFQbdqGTodBf8BZweus61u
 GhVVeC55DFr6QLk+hxd/PbHjUVg7ETT0Ypx8jpp3y815oF3LnXwoqv9asZDVgF92ICmhFCk4RoC
 LIMU3v6GeVwXWdrwKcuV9HJL7KRpiUo++tHAEmUPbvs9cmrPFrSBP/ttlpWqXOmoFle9FDEy/rf
 6C+hpgYXDprZHSlxeCYHnMKK36QuITyVLpj48tKXAdIi7N/AaCpcF0cd33X7NQI4d2/gPPgjqPF
 cyxOCYxai1m1IXMPjPEJX4d4t0lugujkZf3B99aS0MMHzZh1JqoEJ6FZ3GCs8/pF1kafq3pinZJ
 1y+BpHbritv/FiQ2J4GxVCLw04yZkeCBHk/pYieMzgVng/HTBPaNtyJQTYtKNp0D+RW7CS4payq
 r7xcjm21jTIrM541UTg==
X-Proofpoint-GUID: qKkI_Co1EfgMgslDZp-CIJa_KLfK3Mdb
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b51c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=tvGfH4KSH3m2s3Kz7-kA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qKkI_Co1EfgMgslDZp-CIJa_KLfK3Mdb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4ilv3u/uBsfL
 FoJxVOh2CgGALnDr9N25X5h60OdjvvGEKyj7/ycM/2fUxr4ITzGpE3nwcYUMKAzTf/jCcynEFXg
 fkLr1NV0KROZdh+IT67MdzX2SYIRzGU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c227bb52381..9c00d21f059 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -19,7 +19,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
+                               cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
+      if not cc.found()
+        skip_test = 'compiler ' + plan['cc'] + ' not available'
+        built_tests += {exe_name: exe_name}
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.43.0


