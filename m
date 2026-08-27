Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2620C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFR-00077a-Bk; Thu, 27 Aug 2026 18:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFP-00076q-D2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFN-0003AV-Na
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLta0848970
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 07rOxmN3l2DJ3nrkL9bTVDcLam+4ZtmCCBqbOlsQTho=; b=aY2GFx3J2S22aPh6
 pAFTjHDFMZW1yJOAXjyOQZcsRD29rCsPNqdJA/gIp6Y5EDYMLniHkXhllHbD6avp
 ujSIurA+my8tn0thWbq+XJjkOiX7f1a1rtSt0ZwKu7m6YxGW0KwYea41FpqKZhnV
 EKm+Y6U5CchR89bcYqd0K8jI1TYzmqIuzaRG0cy9hWKkGkLT0YyR2Ps0Rg+X7Q88
 B+vmDXrspC3rm/g51s7PjpQRRQF8LudvbFIsFUd4+ak0JXPClpBCd4/2kdPJULzU
 qKNpRBLAi7xA+RUq4NCuehOtMMYxhC78gszFAjQYOWoqwYbqVHvUaRFlUgXQQwOw
 ZRtpfg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a61j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-853d0d87123so313669b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868416; x=1788473216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=07rOxmN3l2DJ3nrkL9bTVDcLam+4ZtmCCBqbOlsQTho=;
 b=WSMTvzKXtVgt+9XNwgjvkng+ApJIzbu0+xc2QvLyc9vKt5zpls0UWE/wDt9peXDu1y
 1JOqJ7IFtIeGov6O5tbnIXgbQ1n3hkOMJg8DqtVKjnHsDFLXgilnWqID60piYoWvULyN
 nfbEtE/FBIrmIZ1W6OZHei/avhk5LdXC1C2PhCcE0VH7DT9aYHA9SMNRgsn+GVFvcY1S
 gYxYzt93U6rrbHn0VWMxpjAXYtZNa4qqldg9mE7HrWLtRz6q81FZ6eHudBs4vXYYqCjm
 ZTGrTuvnSnVOKMx+JwAD23jmeBLEKGSuxC/z8siE8P596FYxbCJXkrJ8m/1pqcoKHYDH
 1fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868416; x=1788473216;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=07rOxmN3l2DJ3nrkL9bTVDcLam+4ZtmCCBqbOlsQTho=;
 b=pUBzFSHHZFwNiOimQTLRBbRuCK/gWaStsLztnXFRJHnWab6P5W92UAmiis+CyQzB7n
 5htxlnmyff1LXjfTdOATf+W7psNC76F9w9uobCLX1NGIfwhWhAS74vF7g3qKTwL40iur
 3edo8x5JqGlf/+wq7bDo1Drm0ay0shqDULlhve8Gjlt3rWE4IyILwmqmQAR8iIlSeF2/
 QpAQDMYQ2gqHir/IiBQXQxPNqa/rhp6T8yM1Ou1LJgp0gj4UmQqXUasrrPZzRRPCe+Tt
 kyLE9bIA+POBffVC9PTbvI3oH90h41KgSbqaogUV3Q3dogRTfTY1D/CVR6xPKvjwjP2M
 58vw==
X-Gm-Message-State: AFuF++lTQLz50l73nOOfKpRmQb74pdUgw39UjbtDHv3vvLlTgXAXd7oY
 5yQLoDBzsbQeVET/VcSlBxt11B4z8UZ4/Z21whAs3kZbCcIMF/RjWEmgnQahYvGG3lxt9vY7NKL
 ujDUFlaUmqALJu5UGv4HYcmMFuP6PnzzAVoQ3JtYp+Q0SWdsxrXcMTKzkmjISz7pwvw==
X-Gm-Gg: AR+sD1287Wz+vP8UoPy/H/MFLe39znyhOQ2IUY+m2d4HxGEQhwpSakWnMOMeLjW9i3u
 SZZ4DKGIbH/e19tKakI37RBXuXa6KxrtSUOR4vSMt9co/k8G6dGoGHkzpzeTsgoYwLzyKLji5CZ
 JMVtGrUWck66DS/9PgrsjSyfcYHQu603f8rxIEHrvAqiD3SslR3X7Y990MUw4nu8AkGPhpTVBjq
 endaXkKlh4V/u+zcNs70qIIC6pNuPvC8qmCnCIxHM6V2VuNlTXxYWNf+rdcJLG9+5Nz5u5xtU+T
 GgSkmrZvqlb6FXCbLUVO+ua/FXT24pcOLs+9VbWEiQN7mFabKOv8GkEEQFVks8rGxko/SV0rqgv
 OYZVuT0xy7Is6Sgbn+o+1nCo+Z3BOGUG7xwhgI+JkJa/1hB1N8Nz/vX26PF4=
X-Received: by 2002:a05:6a00:4109:b0:847:7f3c:b5f5 with SMTP id
 d2e1a72fcca58-8562a6e1024mr4355905b3a.11.1787868415594; 
 Thu, 27 Aug 2026 15:06:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:4109:b0:847:7f3c:b5f5 with SMTP id
 d2e1a72fcca58-8562a6e1024mr4355799b3a.11.1787868415090; 
 Thu, 27 Aug 2026 15:06:55 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:54 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 004/105] meson: bump minimal version to 1.6.0
Date: Thu, 27 Aug 2026 22:04:58 +0000
Message-ID: <20260827220641.84885-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7HDqhaDzpJdi
 Nz8Ig3or4tlisIGcbqukPDtt+kU4F1Rg2jAGIX1X8jV2tr9Hc8jQBFX/0lv6HY7QLP1k0dzLTQj
 uStENkfCkkhWSvTnCFtCqLZYYhEpdPlJmuKEJrcR2fRuOOlcB2nUhH9V3KzjoX12RQX4LOH1tuO
 m2o+H1axmipxXgq/6fydibXn0PLDCTl42tFo1CoyPxoAiTIC/HyFXP1cxrtKbgA0MFExaOiadYY
 f15DVZUuXhnkP6Ry3+uTla5wQUYTdHQpMBdJnSIe25AcMyJdkJSQu+bbzlkwp/S22VhCQcH9zVy
 p8B4hTqRSXRoeEcMiDBTm9YZKUMx5j1BTgVcE5p47GFqx5MnEoP/QPKXrWvS2JbMvCpT4bHzmT6
 RCSovA9yWtFHbKAdPkSJzwJ+LN7TvQyTF3lwfZ1qVfS6061PGSTua5EX+2fz0LRFpfyNG6owbJo
 JZvA9GOTQYjatbEwQww==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b500 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=v7Yl3Ntq-7vvpjXoxa8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: U2DJ4bYxC0M-zQ7RUYT9_ZHgS2lU-iOk
X-Proofpoint-ORIG-GUID: U2DJ4bYxC0M-zQ7RUYT9_ZHgS2lU-iOk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXykZVTVM0/CFq
 Zrf/WxB2zs5gk3YSk4LTad98pRIkeOZo4HazimUxC/2xaLqC5TPep9W3FLaxSAJAm+Cj9GzB8HI
 PpF0OQLe7KQ0ki5qxChaZMWW2uAbnLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
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

Without it, we'll get the following warning:
WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
 * 1.6.0: {'test with external_program in args'}

Which we require because of how we build iteratively our test command
line.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build     | 2 +-
 pythondeps.toml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 6dcfdceb507..2c4cfffa728 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
diff --git a/pythondeps.toml b/pythondeps.toml
index 061f0cff0c4..fe2c50cdb25 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.12.0", canary = "meson" }
+meson = { accepted = ">=1.6.0", installed = "1.12.0", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
-- 
2.43.0


