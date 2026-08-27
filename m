Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79554C61DD4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOD-0006Q7-RG; Thu, 27 Aug 2026 18:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOB-0006F7-6h
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO8-0006Al-Rz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLbtP124878
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=; b=HXS/zvxLU3gIckHo
 qMaTK10bGSk8lxkPHjIVwWOqnMJbA5eMWW0FA27ueruTkm+lQN7vm/xDF5mIkZ3d
 h6O5XHxemybz5Ah6Bz/jxuA0E2PRaUJr6LuftCKmHALlvsdX9wc0ZlpaAgvMZ+yS
 oLwLzJ3Q5cOgIcou6BkiFGANFt3r10qDDrocieddeVSj/ODMhl37Cu/uTl02xpDX
 puHF8+95ATnDsiKVsP09H/0Txk2HC4xN2pr8r56nIhUQVvn0XWXUqyLtWmwylJsg
 QNazUXSSNXplqY2TZQ+c/9IPkAQ4uicFGGLJQzpfwtjO8oIWyqC+y9BLu69h4N7S
 T2dq3A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7tvss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-855f662439aso825839b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868949; x=1788473749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=;
 b=kgktUmWkb6CLnJqrckSdboT3Hvz57cFGnhZkz2zE0UdKL3FyydTCRR0tOIyQ2rPA3R
 mCuRKh/FzInJ+Bpr8nuU1inGqzKh0VF0bVuh99OcE50kBR80+Y6z9ZBJhOd6r8/+I/63
 D3pUbt5TbL8fno48iVtvYDde30zClDTidJz97vQB1C/S2+VFjDUk5v1RJNAdntjtbdd7
 2X0Hs2gB+LAaNTuaSsGGu4IpXRQtYuqHk9VIHXaM9wd/NmA5NsFx4jnEqBiGeatjOzkN
 tEfuf6u4r+/2BTMXbM78IV2A953fFXqfyD4pm2mYawn8kjO2nz/6IwGG1+0BPx8Obb1F
 9Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868949; x=1788473749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=;
 b=dymfbuxsA2g0f66viCddluFFs4Gc3kD7fNUx5az7l88JHsBzFkfWcR/mA4vUYDqUsM
 BrQJTNOtF7iPJFc0swY0ePPM55JQSUjJO625RGWpHcjcOXTBASvXJWc500hCC3aVLk8O
 AkZ9BHcq7oeWK3AWLjUyi9yzK5pR53UXUaP+8hGzyD1Fa3mC3DZqQWtJSfBCa6AtBjZk
 UYVxeGa4VqwtEU6s0ZYJtITpcSpLNvVrKIvz87xH9mGOE1z1L7yoT2oglt+wyuI5NhO6
 Fjd7YvPWlIchMK2zGyBgk0Uxr8s5ahWrUqrs1e9fb17MYMG71MECw2pANR4hoLo8rb7H
 jmTg==
X-Gm-Message-State: AFuF++mLtQPw1kjOkWESARXFrfO0kVoxAlaTyyDHqQsyGfa6zeONO/yn
 7MsKumjAVc3+Dc47mVIO2+ps8TsGsnoBVlzIUrV7tPWLlFF07/NTZ3tBh4NZaLqxN4tElMEWxet
 jwI93AZ8SE8jaR4vYmsyTiveHgTW+w8DYPKy3Ias8l361Op33VOJdVlj96cQYg/BM6Q==
X-Gm-Gg: AR+sD111U3U9SBo3ticidD6nnPL2SLC9D4ShLe0WzyhUZ/Tp3cYQjk2nWvgD37673cO
 plRWxhkGySS/dGE4G/eTwAJs+zRY6nhkHv8EV7sIpYHPs/Pio90QECcmFmKwAzn+G/xlowyxMIs
 S1t3bd8PJp49xiOdUBilsNHfGPIhi2zSQQSSc8bVec4jsOXM9SVMlSptgOeFheR4uPWVCaYWDEh
 cmgN+dnNxUZacR2I5nwRFQ+ojBkNo2Yp2TRUJ8v/6XNOlYzx3Nb5W0j8wXO3QbpLbxlZBkMsWHs
 t5W+/oLbhx9CNHxu0CYcUKmQ1PExYmWT3kuy2xpwZV9q/uHyKQ3HS1a1E5nZjNushG0rkimh/8t
 5Q4b8V8/PLDo4/L2MO9RqPb+B+bSh4EiPyJ4wobeEBGKDxi4Q+bOXvTmpSKA=
X-Received: by 2002:a05:6a00:4188:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-8562a5e70abmr4602519b3a.13.1787868948877; 
 Thu, 27 Aug 2026 15:15:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:4188:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-8562a5e70abmr4602437b3a.13.1787868948477; 
 Thu, 27 Aug 2026 15:15:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:47 -0700 (PDT)
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
Subject: [PATCH v8 032/105] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Thu, 27 Aug 2026 22:13:53 +0000
Message-ID: <20260827221506.91574-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXx3bOGpM+TbTt
 FKCS3ikOFA4GXF4pnZbY1U4qgwBlNiw4Jv+9Tu7U1iATJEoEESLYrin1462pdnFHgu1rF0Hz7gi
 QA/fCczj2wm4U07Ht0ChYtud9posfH1aO3PPNFB+UggxteD8CsPa8rg6whXAggJkV6I9sbivfs8
 1ASMUngAO15gXFEFaYNZlum7IJvknW5fqdWogGEoL3CA+5H8FJSSQRB87eIPUnUwNUeV196Du5r
 nfl9bJQK/yhw4ruqID+srvd0pfsqjhSjnzbOcarLqdxX6sUHYbMDMDkAt8UWC4Y+IU5fIgncH4f
 AY8oP+tyfxHoD2AoPL1O9d56FdS1dbb16pzrgTqXi2tRedyeSolwDVL+PObmIcA7OhIfYEsT6dW
 xwYDTllmuHFMq5m75T9rl7/F9cjV/QWlWbIu9VI/FXtOEKDgNDceQtk4PdilEcs39YHrj0kBkYa
 H6QRhnHl35r3OOiSyrA==
X-Proofpoint-GUID: lKe2hVlUiAJ2ob1Lp-jfuqWGJwN47xFb
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b715 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=WK-hs4OApzzqMslTwvAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: lKe2hVlUiAJ2ob1Lp-jfuqWGJwN47xFb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxTcyFSMRJWcN
 Oa1upa2QPI9SZQwYD/YtqolXd9NB27wFsu/EDPofM2v6mDFXjaxHKtib3YM8bKBf+c9y+X9EOyL
 alTQf8RrlBh19IWRiUR8wGtS9yrsVss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
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


