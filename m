Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F15C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFs-0007Gx-5P; Thu, 27 Aug 2026 18:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFq-0007Fb-O1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFp-0003RC-0n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM77q236425
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=; b=BxCfjrH3sjH6Oyb1
 H+LJYOjRcQUSncRrUBYto+k0ksQfJsooSb+dUuSBNdFk6C/hV05xIDcqW/nl5gFW
 kFre7gYhLxkmqz9Hdlr6pSWfYHkc3W5hUAmHj63TddxKUdqV23BPegHrFa8KLeEB
 lRP/E0tlYym6bcymcAWsW2Pd/ajBzhwgOemY8Oap+jUHKM7364gxnDjbdbSC8rOX
 kTF3srjkWUOMY+7yKiHm1wC98eSiB1JGwdsPBSyrOl1d9kmy4cLfXQmgjmDd77sy
 +ID3L5IbStJHU+fFiK7wa4ShAYll344LtYKG3MriNlyuWQLI8GVeuKGhYh0EPYQx
 AGhowA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgsvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-85602449126so884045b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868443; x=1788473243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=;
 b=ctI11sfQOASS0+BeSTPMu1BqFunccwHzNSwgnGWs4ScBeWIw0T5GxbAQyVuAa3bw7g
 p7HugtltKXFOFGaMI/H/H7X6LO344Wm4/kU+UL1ILWgF4Rp3J+HWrpuAr1XTixIibTKr
 Bpiv8o/EItSZPbXVtqVDvY5/UySAGEPulTvBBZyf959IxtkQaRxJPeXcQ/NFHuD7rrQI
 jxyaa6400TgwSR/JT5Te1SgBZm2WTTGVwVrma/Wmk/O+FKRGg6m3Z+OkfEDfhUl+i88r
 CNwiEIT79ao3tef8hF6FLRZFN/A3AJGtskonDKgzdutN2zqxwRKodG3nMbNZNSIWEEsO
 Azuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868443; x=1788473243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=;
 b=cstmrn68YTAg69JGjwvdKMX2ZKMe9YVJZSBLwq3tCVCr/66bWXyRaGYHHghzGRVixW
 RyIgVi2UHDhEWouKPxPCFYfahYr7Nl+tJ/x3Lv3mFh2eZSK2NqhUsXyUA0OyopozvMCq
 fg4x3UmJIsNbJGUyp90FEGooohAgwuOvKFQW/BCRDDJ91u5lV/+El69dmxSS1gUMzboe
 NE3QlqrquXJK1X0X54Qn0C+JUUu+lhIQBwBZV5Ve2mLmQB3lwXxzG5ZTZJ9dA8MK73NE
 c8TVmlIOKcX4+CoUgI3NZRu3sOdVszBRtPhn9zRb3jk4gXmLctcksVvg/2SxUaNNFOE+
 6OmA==
X-Gm-Message-State: AFuF++nUdf0uLsBzTm7oKXWBShogjp/RlxjGj0Q+gemNG7Wzv9VZvxzL
 ziAtxUKt4oBf6K6p1nJGa59ZkQa8J+5KL3krY413zRO75NVd/7xklXWWFJ1mrWElZORX2WO+P1v
 yWipS3oqdJUYm4VazgJDG+onzTwGNy5W7Z45UuSdiS1t9Mq/yZ0iOxMYMknOBeGoXrw==
X-Gm-Gg: AR+sD11KHn3+iH9BB+QHxOtracnKK1JkHITKSmpC3Ziumcc1EUdPRZ05wfcs2buYwPK
 /KWE2RZfEc6UvAyulDdGlTVwdw+kHpsTYVmqmC5HA/Wtbefsv2TYySALBmi1EJwjE7fkq0X4DdF
 KAQmECU/ChNsE5dxc+jSSc4y3Z/OOnKG+ovs7Z9Mi2NhAI4isS18CRER7ysKz944w43nxIMyioP
 5T+vO8Q0hUmGE18un/yYMGCCgLUiGs7dIL3cosjvDnWcG/3LMhk6zCT4XO58isl+OnXHhVcrQtc
 WEQO1LjGxggc2z1dR/RDsE9cLH1zQoA54GBQVW7MmJJrrv8yFS4tygModrqyw+8pjt3wmwo06Ia
 NQwYNa7veGjEREdaXGkcDF+yXEQDu0r0zi4cP8NP6LCBLszT5qHmibKYymzI=
X-Received: by 2002:a05:6a00:8019:b0:851:d12e:389b with SMTP id
 d2e1a72fcca58-8562a8d4291mr4824765b3a.14.1787868442852; 
 Thu, 27 Aug 2026 15:07:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:8019:b0:851:d12e:389b with SMTP id
 d2e1a72fcca58-8562a8d4291mr4824665b3a.14.1787868442379; 
 Thu, 27 Aug 2026 15:07:22 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:21 -0700 (PDT)
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
Subject: [PATCH v8 024/105] tests/tcg/meson.build: move gdb_arch support check
Date: Thu, 27 Aug 2026 22:05:18 +0000
Message-ID: <20260827220641.84885-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5ZVV3ULnAs9loDXaKxnkO_0sYc-OfyNO
X-Proofpoint-ORIG-GUID: 5ZVV3ULnAs9loDXaKxnkO_0sYc-OfyNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/Nv8QwItM6sx
 ReNuqitKOY71EpYrn2dh0OsO7lB4rUu5nOZj8G4jRXZhdFvl4dKkC+2x4P2htgtcjKOlLBbWVcU
 DafSXny4pOYJRHC7MPVEHOxx6N+06Tv1lkNmQmBjbAWxa645IJJ05pUEJUXMeuTONnhmv1KOghC
 jWrKJkhHBCN6RJlnnz/a5bSvx7uypmicmVBoukatvLKuhL+s6cDuTuhcFIebOm4FVNuFCrqdH5n
 vfvb8SbX1AeTNBFpP9m1CZ5RnrDNhiY/x7JkjaSYJod/4ifYtijpqff3Jq/TVI2kMlXppSW0DDX
 xX6kpfSho7bHjqT1fCEqgJc24KZ/BeY3MVWrMIZTNlw4kf6qfazlNx1WJh/vgWV1zOTIhkcifNE
 xOeqSbrfHzanbHhTBFHleOske2EF41cCqCy45x8Yd9zqcdwqHe0dI+q4zAbCgfAV6wSzhWw2NeS
 zWJSjRvxhAYLsn7nbAA==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b51b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=XzjeZAZuwW6bxlwlfogA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6N9s2KdeRGyh
 ku4//tXfUSvSSE3ovj5imJQalyvzmUS0dABfZzCe1Fz4hAfh4H2x7JG+FwLZhP8sbup68vUCXaB
 srTKETHIlx9QWsf2zRJX7tAfOkQAvYs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7384786f7f8..c227bb52381 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.43.0


