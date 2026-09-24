Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81936C9831F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pvq-0003eP-8i; Thu, 24 Sep 2026 16:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9pvd-0003bO-8z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:20:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9pvb-0002gx-AJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:20:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdXTq3152417
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 20:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=p4POoSH+Or/eMeYrpQGVKLsqrCMBJ2agU7N
 xvmqomII=; b=DyNmVpfJr6z1W29M8PNnkZHUNpOnECQBJPQZRtzphQ/WR+/1zzO
 zng9SKvcob41sIkEQiAWHIHSRVSuWCplf65/sdxu28N63Pq/N21qpoNSLHLpubT/
 nmldFnhcZAwpdIX5xd9hp2sJFZUgn0ps0yEi4Ql5g9g6e7rHw5XGDa/sLDVYAGlN
 a2IcT8KoDtz2RqD9/7zQ/8ZRC1DBYcq0hTSqoPamZFU17/kLEMRh4cz+/ynzpTp3
 4rkesVCvxxNq32hnGhgIVxFv475RW/kn7/CHkmFCWfuH6aSMna9Dry+pFCRIyg8U
 vHZn3+ROaIfLzsQRy+RbkD1JfH0k5UF7Y7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898rr7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 20:20:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-313d1015161so448831eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790281220; x=1790886020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p4POoSH+Or/eMeYrpQGVKLsqrCMBJ2agU7NxvmqomII=;
 b=bR3bW06soHQmIhQqk3Cs20cQUhiRSKVNIRhJ9fu95tvHRw/HA3bNeAJfs1YlKms149
 PgZFc/9bsKEwYBW+zWzO1rnMLqzYvoZCDrTv6uxkYTFkKN7pL8hzfVGtl6hAbDE6V16k
 nf9ZuY5NgEDjSVK6yboy6LsbDfKWLqDWMWUOv6YSU+wxHEPWxVdrw7Wlpu/PCT1WRnpy
 p7ksaLG4dFVXG3BM7BemP3801utQqi2dm31G1lOQZie7d28+80fKNCi+JQzwqEwhrSSf
 rRotihuxFjcbYf7gls2+UxcdeMZbs0P2rYjPSWydNhYJzlb5/msA6AFjmUUwlcqM30fE
 QmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790281220; x=1790886020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p4POoSH+Or/eMeYrpQGVKLsqrCMBJ2agU7NxvmqomII=;
 b=G/e59ZcfTpyAeAP0p4zWjLUR/wu8zsypxbBDhPqx0DA9y55rakNxE29vEG4/8uE5kP
 BgqMZZINdbzXaGMZ7BdavmytPSOQJBHXLdn5ou9Yoa3u1k8FGiQ/ISWRZX7eg7CMB43Q
 jNqF9WwFezc30clZ8CalmYbE+E4KUaUFPNqQra7q85TbyCpUN0UsQbfUOXP0yXulaU9c
 6rwCucXKVAAshiGzuwmx0qdZBz7n6hG211Yfy1Y0K2BKG7F6bMmyGoT9ntwjv1OwoCvv
 N3uyuxk3mE/eYjvNSXGGRb7sF1SG77d1+wK6anRSszwHYFl0Ivl/8ak4S/6yoVdx5+Ez
 GAgw==
X-Gm-Message-State: AFuF++nr3VT+/p7ak62LB5PmFmMHzbKOdablr5weUfynifTD+x3hRAvG
 BMp2v5KIuRp+rnLt6AOny9TaUjNk31BZyUZMWenTQkezcN203zwPtgns514KIARZB0K45GuMeAk
 0DaGAhdr9COKGy5KCv+jf6SyOA07LxItbqClh98gjTGsw/4oCoa8CSjR6/qpx7SqTNQ==
X-Gm-Gg: AYBFou0EY2JAmBXnH9qyxT8pICqdPa1G6N23FJrKfPywm4ttrFNu+eJrlgs4BXi304M
 J977+5ygQJksfNYUwRHZjaomIzY/Gk+SnQxnkDbkMWCL2oxKOWR0qYMtqmrM/2x9/M76k4d+U5x
 clP7Wr8E773MVQ/emsNbPJHzXTjNbTi1YHD3v68X+4l2cQwHN9EBvs29UyIOWgv+jCvWgPnDmIx
 /W9k5hPQH99shnwPDkQy5nYwOtVagH2IbbXKo7eW3M/3G7wV2UfxrI9dPOGNbkfy4OhqL0OpSCJ
 TdWnnuIN/3RRo55ehN1yo3QT0WQdzwrc3+MWNYlJjRhXXc8J25HZbFyWN+4CwJK8ztBKiy8IQ1X
 OW32ywuHGqfxSPuvlYDP1oLOFV+AEkNk+c1ZnWdUT/AWLArEGwZfTn6LuBw==
X-Received: by 2002:a05:693c:4159:20b0:33b:e529:4446 with SMTP id
 5a478bee46e88-340045916f7mr3117955eec.5.1790281219415; 
 Thu, 24 Sep 2026 13:20:19 -0700 (PDT)
X-Received: by 2002:a05:693c:4159:20b0:33b:e529:4446 with SMTP id
 5a478bee46e88-340045916f7mr3117929eec.5.1790281218725; 
 Thu, 24 Sep 2026 13:20:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144e4a6b9sm801963eec.18.2026.09.24.13.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 13:20:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/tcg/meson.build: compile test with -fno-stack-protector
 by default
Date: Thu, 24 Sep 2026 20:20:12 +0000
Message-ID: <20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MyBTYWx0ZWRfX3MAcpSYksByQ
 w+DDTCMggWSJ4W3LhQHv1w+PeBVZEL4/2O9zSrcmWKZS3Mok62UScDocvr9yZTFvwg3kyUz/Bnu
 UHzCBda07L3J1TZgPXVWdQXXRtvYMeo9rq9Jfohwr2GGvpYHZeNxfeNAyhrhx2IhTz/Fd1CiPSD
 JUyqKBnvNv3uyfamgb3LeCtMuk5x4wWVsf9R4Zm1kfZvzJJ+RWLES0bnyvN+nTqIsax0HjURb8s
 5nzw/qoimOUeHJaivheODABuKto7zwbIpXf7xhwruQQXag6EvxRsXAWQFkBPgHjbxrMGUUoqPzD
 di/rmOAqHZ+BDd4cPDvOs7ZdFJhVfqSq+Zry2Hk86S2V+pLpe3nm/uMSnSw3w+NvSdeNGwFwKNq
 znXsSkcQzwpMLC4ixuMhkKAjs12kUY3M1DR7L24QbA8IP9PrFmp3aoVMjvsK5Ef9u/i95JPHFaI
 X/4q3oBsC3VMUu7xGtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MyBTYWx0ZWRfX/LH/EFdIF7BQ
 Kkea52D62J4JI1cyussCLwywMpL9ALN7g2kZa16HLBwHD/mekZio2sJg0PhTH2L7nfL0afNUqf8
 4oKlwUFlQ7ZZrMR+RQV2kz2CA41L5cM=
X-Proofpoint-GUID: bzzpR0o7oSWFettWDAlSjybEpCl43Zz9
X-Proofpoint-ORIG-GUID: bzzpR0o7oSWFettWDAlSjybEpCl43Zz9
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab58604 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=HeGbzLMS2XdAEp0xck8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240083
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

Some compilers enable stack protection by default (for instance, on
archlinux). This produce a compilation error on some of our tests:

/usr/sbin/x86_64-linux-gnu-gcc tests/tcg/multiarch/system/interrupt.c -o tests/tcg/x86_64-softmmu-interrupt.test -static -MMD -MF tests/tcg/x86_64-softmmu-interrupt.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I tests/tcg/x86_64/system/../../minilib tests/tcg/x86_64/system/../../minilib/printf.c ../tests/tcg/x86_64/system/boot.S -Wl,-T ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
/usr/bin/ld: /tmp/ccs11W6S.o: in function `print_num':
tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec): undefined reference to `__stack_chk_fail'
/usr/bin/ld: /tmp/ccs11W6S.o: in function `ml_printf':
tests/tcg/x86_64/system/../../minilib/printf.c:136:(.text+0x549): undefined reference to `__stack_chk_fail'
collect2: error: ld returned 1 exit status

This flag has been previously added, but was removed when moving tcg
tests to meson, with the goal to identify which systems require it.
https://gitlab.com/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec331f1ce51864c97
One of these system is archlinux.

Thus, disable stack protection by default. It has no impact on tests
results.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 75f0a52fd22..35b3dff4ef2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -426,6 +426,12 @@ foreach target, plan: tcg_tests
                                       '-MMD', '-MF', '@DEPFILE@',
                                       '-Wall', '-Werror',
                                       '-O0', '-g', '-fno-strict-aliasing',
+                                      # Some host compilers (like archlinux)
+                                      # have stack protection enabled by default.
+                                      # This results in a linking error for some
+                                      # of our tests due to missing symbol
+                                      # __stack_chk_fail. Thus, disable it.
+                                      '-fno-stack-protector',
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-- 
2.43.0


