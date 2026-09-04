Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42987C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2aFL-0001wo-Kc; Fri, 04 Sep 2026 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aFK-0001wf-P0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:10:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aFJ-0001Tv-45
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:10:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HI6HK014871
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 20:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DtpCmTaBHg3BgbOiyBNpSQrl2R9kdgEJtHF
 y8Ey3UUs=; b=ThjHFexxCBHB4bofS2aLMJ2act1TIUcBhTc+B86mqx36S75dsYQ
 ojfF0kAE2Pgv2YB7+twvnXjUu7zXh3KAWmdAhhMEWqEEcggv7CJDnnYRIu7p58FQ
 sylDludacZNicnmUq5KLghIl3YpJHGTwD/Z97lr+OGDjTIGB7FJW/Gs7YXF4Kopo
 ZPoanQoE7o13z2RRqFtHcIx6gTVRFyT9+BHyhbTtY5HYmjLrwXZ57nCA8IsI6Qer
 EqsJ0WaGGwj9dzCqFnT12ly4sQr0TvyeFsJFlw4YswUKFuY1uGfNe3zJNZTTeJgI
 9iKJiBl/qjp8OJnEhtgUoYqaOmK2Nj2jK+w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yhgtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 20:10:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d7293f13c6so18847065ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788552643; x=1789157443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DtpCmTaBHg3BgbOiyBNpSQrl2R9kdgEJtHFy8Ey3UUs=;
 b=Er6ayClLBlzjIdMH+R7vKMb5hOubuMWBK2mdwAVkDoBNZ7CicfmMq96/rb/gL6HY+8
 kgokVzv6e9kWt4qWK8w/QJw8629vpk80DjTft5k68CWmpBYxqk2gh7nQjcwlNA9NqW6d
 jhRJmPmvI+U2tZBNSaULZPBcFv+qHVMWZ5DftMVH8Jw5SBBZnpFKUix2JFgVGvQw2k62
 P4eMCMaCpllwTbmtPPc1fE4JsXXz7lYAIe+G9wHlwM7R36QmfSFsc1OkdDuXwGGHAeoD
 OoT3a/zjtNHBALN1l7adzjjM0DWx4EAZ60GFOSDKt9A9/mi4Sxym03n4UjhQcib714Ea
 zOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788552643; x=1789157443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DtpCmTaBHg3BgbOiyBNpSQrl2R9kdgEJtHFy8Ey3UUs=;
 b=VjJFa5iUxbhOCah0nwD7Pe8a4LLWki0zeQ6asBaMM2MXVvZWORJlekf+CO7eR0qPDn
 mn8hrXRU/ILyoYVjzBvNm4vkNw2TFBQNyBT0WuFuJjLlHH/UhiPFb3K/tj6zD2I8juG2
 5DqzE23mZlgWhQ6bFMJxidgzubXBWxjQ0KBFkHU3itbRlp5pgaOSL+d/CwFD0QL3wgvW
 yERDCZaiJSkvHB9nEAG0SyyxkcqEas901KMz9a0Do0FdlJFc934Kk/we5R6AL0i2VSPb
 4iudjwpyJCXGJIKzqhg97CK5Qyhb66tAbLA0b8R061GEeMcbCgMfWxCnRomgSSCGr2ym
 tpJw==
X-Gm-Message-State: AFuF++nB3WCivw79L3R5cTsCdN6yq3GbgLx/JzbHEnsHI3TK1TvMPof+
 /DbgXw09VgX3VFxXTIba9XPlXd7E+uo3PbW5R62shjaqaPmDtF/tA4GSZbHQgVNVbZwqCPmjkyC
 vMR4AKftjW/0u8+NVuosjaiyDbgcpffN9mHJbEPR94iZVT82gPNij696aPbjiU1HauA==
X-Gm-Gg: AYBFou204Y9TDmbNVyjKOn/ELrG/WK3vKOcHjp2jnzwTe8jfG1KINWnhlU4p2PiAo/p
 IuZVtTiVJ1jIcLd2KWtqBzEufF6J0fR/vID2cHMy8w/+KAmkfyt6T063CwUntOTkDGs7NN+V8/g
 ZxA7jdfeX1o09GNAC8p6trQefW2oHothDIs3T1ME2ekWZE7HqnzRdkpw2zu3GM+tQD7tnm1X+CD
 T27BQqNHf3wnJsR7SGoyqbfX+491F6SP9GIfY65P6t8FwsRXZIBXMsGtsK2poYxXwopMwd+I0fA
 RLRorI28wtakI4/bMFkLNDPR7r8G3kcbW1+XL2Yo7FKv+YL4hsMXj6QVnEODMS58h3LPAR+jYDf
 OKkasg/Ua5kEzOFcCQdmb4xeaomiOuqJHbl+DVfFYl93FIMMglBt5NuBJk/c=
X-Received: by 2002:a17:902:cf42:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2db125c3108mr140030505ad.11.1788552642628; 
 Fri, 04 Sep 2026 13:10:42 -0700 (PDT)
X-Received: by 2002:a17:902:cf42:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2db125c3108mr140029525ad.11.1788552641981; 
 Fri, 04 Sep 2026 13:10:41 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm10117751eec.7.2026.09.04.13.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:10:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] TCG tests configure hotfix
Date: Fri,  4 Sep 2026 13:10:33 -0700
Message-ID: <20260904201034.2811585-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ttMcnteoZwTnTbF3SustR1TyTHumGXwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4NSBTYWx0ZWRfX8pVkhNzt4L19
 umur02uOt4qfyN+L8SrmH9wuHhtmIZPUq7S7pO0yD0MtYsa4w57gCACte3t0EjkaNF67PzhjKyK
 juonY886+/TtyM9mDPhlEHOh1y177z8LkaIFQ19bRGZHACBKmueqhlDX8vdfvfDX4hNmX9CuuB2
 q2QFheg4zvh5aMbxM/A6Oy4ihuOBguNE7nRxOx1kTj/nCgPWVqGBqsOPd3Gro90lw9fVyDRtwFH
 uJFrqtMbAGQGW4bcVtEM749x3iZzfvWWHZHCFwf2PNEuRNUvh9Smes20a1sgUP6hfAwHN5DiE9D
 sEFSgDu3RXA9n3m6U8ZJaWxEMTca4c2Kb6ER+KNgUVbTToioJFc+sHz9jcN9l/+lfZi9U88snVC
 0A6LOitRB9kpMrXfH9zRObAp1J6xPl0YDHY627+6E4w63up8ool6pZNX9dYmTMFnNhznvyutnuJ
 Ci5YL1QEZxDYsbLYR6A==
X-Proofpoint-ORIG-GUID: ttMcnteoZwTnTbF3SustR1TyTHumGXwD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4NSBTYWx0ZWRfX15vBB9a9Ql+x
 6P5djaZcuj95Hz/XVmTz4i/uTmxKlrjkMgCGKX2ijd7gJGU6if0EQyuHqL3vZnPuERGhfDt38eo
 B7UWw1QWoml7cedOyeXKoUlzw9hNS0U=
X-Authority-Analysis: v=2.4 cv=eZcNubEH c=1 sm=1 tr=0 ts=6a9b25c3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TI8C9Joj2H5D9qa9n0wA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040185
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

The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9bd:

  Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/stsquad/qemu into staging (2026-09-04 16:52:58 +0100)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg-tests-20260904

for you to fetch changes up to f7b7d7270eed9f22110f2a2c0d4bb74b92f991f8:

  tests/tcg/meson.build: fix build_test_depends (2026-09-04 13:09:16 -0700)

----------------------------------------------------------------
See link to series for details. It might impact anyone having
docker/podman installed but no cross compilers.

Changes:
- [PATCH] tests/tcg/meson.build: fix build_test_depends (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (1):
      tests/tcg/meson.build: fix build_test_depends

 tests/tcg/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

