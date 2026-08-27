Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE00C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFo-0007EU-4L; Thu, 27 Aug 2026 18:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFm-0007Dz-Ab
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFk-0003M7-Fa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM5Ga1803759
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=; b=kBi85TukzCzSLUAw
 POvbzt9ixaZbFDtE7lJteN3f2j8PrLYr7hp7TMzsUXfM7z4le8x7rfB7zFe0OwqA
 q8WoA62NGde/Q8CuRcpqH32Huc/fkp1Vf/Mgr/ymNgUmQNl/hcDYlV61ena6FjGy
 Z0IPmZtI93qBGTZRaFOyBV6o7L6dNMKvJamcYHBTaSBM3Rt6jxVS4+rdld/35CyY
 HtxjY1L7EPMzjU6jPlnM7TCS6uWmwLblhtnW5hHga60E1f70/FRAMhc6QUwDyRTw
 LtFwjyzGtTu6LG4C5ZeMbqOGip/PKaCNjiq98ocRycLblaFTSTGp2enyNWXMGczf
 GtsbQw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgu5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1c5810451so490392a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868438; x=1788473238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=;
 b=P7NyZkLSE23d6fh4JDQIrBhRn9O44GKzF8oCJHp8+UNen0DWhn/6wnK0QdSmjIjbk8
 wdkPjjv0bgJVIQuYEcU7l4x/SbWlPuK/TJC3oITquJiZ6ckj4zR9T0EGE+CU/cTgsPkU
 Kzo3avTeMw2sCSuzIMysmpIZQ/x4PU6V0i4OqoJHvUsq9X/H6GYN+zGA7ljCiIePsCow
 rn2XfnT1nnp4yTFzFm/EVk3WdBUgAKTCSluBmeILRXjKKbsWjpLU4Pf8H2gha4I2J7kh
 HNVXywWA4mEFeT/lCfi0/q7GLVnw/+DyUlvxkGKxbRnB8QHN1Tqo2y0vNYgoI4L2iHWt
 4jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868438; x=1788473238;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=;
 b=f4hTcLg/b/I1/sDKizMJy8bujZNle2EoDTA3gTHaYmCQ8BhnRlL5g/cMiaGjasHCVL
 AkWgSQDHV/jcbC+s8JOINfOOUJMpAWbtmhQidKhcyzepzA6WHEKJ4FSlXL8F0IbuIUWH
 XYluWsmlMC2kTALP2/04wYRY6gZXQQJ/YPxclJy52IKGJ4wQuEXycTjTnswLH/g5VzJf
 id6HANjMraFw9BBnN+aDm+s42UEkulfcbEXv+d4FTvjAep9YJE4cbK0gRPxic60yEI/L
 90tt1YlazbF6d9kU2ernBxDrNBNZAdP6UhBJYZNmzFULPUXq2jSCeIQPvmlieaxwvPb6
 y0Ew==
X-Gm-Message-State: AFuF++kpx/1bBy2A7SSz1X64e1TTIZxcEgYpp7ec1ZY09YlbH/Wa7C3q
 DVECn4f3xKLd/D3IN3/El6gK1/j0CclS49gBbXM8tig8Kby8Mbh7Slldd1/eq4aSAfPAYeZrgaL
 VWQUhIr7wujnXkvVNvqyRjhjtqvJ7YdLIDu5W8Oye17dmRyCWM+e1lptw1RBG0gtkVw==
X-Gm-Gg: AR+sD11xO6snbKXacLGHTAbo0n05eNSdQrIUgFAPO0WHuCM17BVeZbkNED52nQwL4ad
 Sn3LC+QM8fLfpaDaStRe46jASyosKyKRrExsZ9yHQio5QVmGc2ySApdwBKfksPBMbekA0PVMiRQ
 PJTQTHcmPRN7Ufuekk7ihwAi4SB/iwnPGCyfxeuZRop6OA0xCccTnhb0J3MS+LWy9bmdj+eOlsw
 2P2aLdhU4SFsjOTRiyW1tCvKmpu48P2s5MpSKsJlo1mYzK/PcVkYhhOP9+l0AcDklvLW9BaVBJH
 6WXgv5wfDLYh6MKsDKQPJJ0H0J/uf/yy7tzcIQz0UnwPVti6TWIHbMbpUmQ3EEoreuoIQmyy1+I
 uAuNpQVPEtHeh/EfvgRwn27OiICqj7Bzrjve8T0I+BXvuP3ut04MsCP9fefk=
X-Received: by 2002:a05:6a00:9512:b0:848:2eac:bfb2 with SMTP id
 d2e1a72fcca58-8562ba7dbdcmr3855645b3a.13.1787868438403; 
 Thu, 27 Aug 2026 15:07:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:9512:b0:848:2eac:bfb2 with SMTP id
 d2e1a72fcca58-8562ba7dbdcmr3855572b3a.13.1787868437979; 
 Thu, 27 Aug 2026 15:07:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:17 -0700 (PDT)
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
Subject: [PATCH v8 021/105] tests/tcg/meson.build: add logic to skip tests
Date: Thu, 27 Aug 2026 22:05:15 +0000
Message-ID: <20260827220641.84885-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b517 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 41bl4g4hM2_WvH4ACs5GNYVT7EbP8BnN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+5E9cumujNUm
 MhVJzrTX0ZcJTmVLF7rvm+LKmk+5av0nkZHMZ5xjptuswMWTvA4pYskVcIqfpWjNehqSsMli7WA
 U7s+rnQltWIxj9DzwVAfPUcLOdI6XGEzEkuHQoRfhraY0nFbBzaXXOe6r9pVy4Oi81T9vkBKIei
 ML+Ls4y7UpfNhFWAFsjhMRzeCd7SU1Naj9o88YzeQ23p79fxk3hhIDvcmgi1CXVn/cwb5lr7QSs
 +7fIXj3BvxWJphla1XCbDMusPn2kliCEkQD14Cg0Iqeaj+lFrmg5YYbnGFP7QST478e4mgUXOBe
 MJ6SxR9MHRBUMREZDuVQLx8lGxZ74a5AxQm1LiIskSf7EpCh+E00/2ZkrC1145f9Y8E/Sxc3gen
 mGPjaQg4dTz/6MyRK/2DZWUDGk/Kh2kIRpGAH26F9P35rB+6oUEm983/wdPNzcP5wZslpP62pJw
 lTr2l5iYH90kpdnEIFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwPaogq01GQge
 NXput8p+WF9ag+a86pjM4ieAnApmt6sy54zwaDSm1YEiaI8EDPOhehvIqSnTr6q1MOqwd/n8WNz
 6pHAuaxBqR0eqL8kWkm4jPQrt7lZOvc=
X-Proofpoint-ORIG-GUID: 41bl4g4hM2_WvH4ACs5GNYVT7EbP8BnN
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 779f9043abb..7b60ea53825 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -114,11 +114,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -226,6 +230,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.43.0


