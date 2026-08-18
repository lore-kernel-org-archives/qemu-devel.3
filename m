Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E6C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPs-0007Zq-M2; Tue, 18 Aug 2026 15:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPr-0007ZH-NA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPp-0006iU-U1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1Mj1872763
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=; b=kjfvLLRODuJ5DBHb
 suTNTrLC4nidMVLOAn9kpVVZJSggaCrM2DBSqDsGhAu6ZyIPo8XpqkSbBIvShm/y
 /7IgO/Yizt0jTsxB8mehV5bIqbgaLBKEB5o1zDqSNHyPmPPM7PXRBt7Ds9eDxHWg
 l+bb1T9viMYpGfZ8IlE+FhBkR3uSLfhC1uQqiQxK3ZhFR3CoI8JAQmZjUn0XKPRj
 ZZqovy2LAjeT80WHm8F8iymDLpbs/IBRuXUHvf6fENoaTlgCrc0PJS6LIvPr3wOB
 7PrcHZAXfqMejAjrsXgeshNvtdEj2LrDcn0UzHOzwqPd8CBtKXti7gvJ0Gxy5utl
 LNDy6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1ag8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so2998095ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081044; x=1787685844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=;
 b=L/DcDDb9bdWwxUELUz6okBeLdzAKzlhcfhZ3Hpej5tmoCbJD2RjmeaH6DS579ms8rt
 Huvn5s2/6nSROlY4buKGROILclYBUbfkj8QdI4b6nAVlzAbPa661In8pZWO2mWBw/rOw
 Fa3y+3pAItmdvGRHb82pHYJCVuupEU23jSZKUcM2AK+8Nw8U+mqGI5SCloaUuiL0fNmR
 PO7QMUU+NH8yBmD5SZFRzcV6uCHFDcccTxhwX6G37EsX/p2J8JDY9a5pwpFB1pcSlF5s
 0Yx3och37q7SVUozBcgNNmchW2u9BWBxuBxw3yxRhPMa8fbm+f+961GbazhZYHSo4lft
 uL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081044; x=1787685844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=;
 b=ZfT6wG71cqA69t1ZfjgITyPvsPrnndMe2jWFWE9dQ8bVIPmcssJEOTNPVtsdcU391p
 63rPWqt3PC+sYV+QFvbkU8qGduJqfdHYymU5dHKYeHqRtNxX2tNMGu8D77w+Ur/B92/7
 3vtzrPWhVukpB+b3A2XgpypBMI9CaYiE1z1IMCgGwEdCoDExw5edGRoo7bnKZeIfeXOp
 Re7aJMdJYO1QVGoMGX78CH5pym+4i8srJFQlJsAtOZho1ZorM3/Xk4bx+2QdgItrCJTo
 +A6jk6JOZQs46K6t83Qa1aNCiIqwoTCLuE6vbq8ITiJoAG+Bb4GHgHzDRGpicdOA2vXY
 ltgw==
X-Gm-Message-State: AOJu0YxeszfuJ95bvoQIyANlL62q8x7wh1mYzKdQ5Sc9M8yWdtokdp5U
 ofF6eZhvNhnm9pYcYcwZma7Kpoh7IwJGZxkQ2+Dq9H2taDRRDW3ykKZcVDjuDjgY3vP+P3XZxKH
 NosnBJ6stY8Fj+NrVfM3xb+VjqJbHqdyDwQkljzCJp9pR7yEAK+29XxsvP6hfmiwoVQ==
X-Gm-Gg: AR+sD13JtpTY9IcGeneBvu3kc8bCPK+VbPyvSJyrxCESI5gp8V0LoakdI0wpfvG3RrR
 +7d29y7FvaNl0eoUQa6qJ+XPvI0DDLgqQbIm1WKMFR7fLS5C8NARJ+dzNa7PQT6FQTUfCKkgLbr
 zgRnkUiW1iXARr7bw0C6ssJex3Lus1tJgghkBd0Arx4DAb+/RkOAf8O+rtE7l3M4ZJjGxb26RXF
 2NI9HQ/rSp+n3+gG7Gkp98cnLHBwmB45rCsJEBsD4wGfERr9Gyrw9WhA6ZD/jvjkShxwmALvlOz
 b4zHXjap8cdqtYWuHxI4g0aNZRonP9gt7EQ1uR5O7bPIAtJsC3DyAmiRLdL2MjKMg0OZJq2LxMP
 LtzP/QB6vEnnbnZWaorjfYXFSIApUTeC9iKJyyrpEjqDzJ/b1AKtlhVOW4Lw=
X-Received: by 2002:a17:902:fc4f:b0:2c9:ff29:3f91 with SMTP id
 d9443c01a7336-2d5f6a609d7mr2940215ad.6.1787081043918; 
 Tue, 18 Aug 2026 12:24:03 -0700 (PDT)
X-Received: by 2002:a17:902:fc4f:b0:2c9:ff29:3f91 with SMTP id
 d9443c01a7336-2d5f6a609d7mr2939285ad.6.1787081043420; 
 Tue, 18 Aug 2026 12:24:03 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:03 -0700 (PDT)
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
Subject: [PATCH v7 032/104] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Tue, 18 Aug 2026 19:21:56 +0000
Message-ID: <20260818192309.22169-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX68y+U7YSOZOE
 8IWERrY166ezhHkFEhYZP2v9lXL7syupU5WDfxVw8friXvPYNHiGLtllaaGp7NBqt2XWZ165T2g
 iimqr/1hbWV4gLlVb6Zti494ogx8IkGSaDlWqLQcT6akrOOuVC4SCOwjQXSTPV1vZVxF4ge7xC9
 UcJb78PExm/TK94MNB7e76PYwXsGlSs08PaaU5bqnctNh6mpz2ffcihjB+q9iQ4VQRPffZs98vN
 FANP2Sx394GbmmLBIDDxPTEVgyeLmUiKv9lVL7vGtmyL0/5meSoac45gRu75+4MtoCiVAJdD6Yq
 dCeEOeuFoAFmDmscpajNNdCFq/dzP/aOmOh8od19TN9y/bpbRb8mbzvU458sy+Bl1mSekSiAmHa
 82l2b/j3/bVOQzTgi+mY1DFT57NkewnH2FF6Xoph45eCF1WseZ1dRwvF3gpZyN6EJkYAZ5gTI2L
 kpwN3zjaL7jeMu/qqvQ==
X-Proofpoint-GUID: VVfRHBMLbG-EGW22Ir6pcBirPX-_MZeq
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b154 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=WK-hs4OApzzqMslTwvAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VVfRHBMLbG-EGW22Ir6pcBirPX-_MZeq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+59FqoIFV89G
 FzMe2UqcMt6MygJp+zt2RL4ptBJgpQVcDhz7OncAY91vcPCYipj30xUsSAhK5HPnf9DfZ28b6Um
 WyxrsU87z+x2dOhSSJDSvJc9YjRO3G4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add a target to rebuild all tcg-tests at once.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fe382638297..d16772d498d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -89,6 +89,7 @@ test_plugins = {}
 subdir('plugins')
 
 image_targets = {}
+exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -298,6 +299,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
+        exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -381,3 +383,8 @@ foreach target, plan: tcg_tests
     endforeach
   endforeach
 endforeach
+
+if exe_targets.length() > 0
+  # finally create a top level target to rebuild all tests
+  alias_target('tcg-tests', exe_targets)
+endif
-- 
2.43.0


