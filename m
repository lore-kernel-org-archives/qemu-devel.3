Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC31C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA84-0008CK-O0; Fri, 25 Sep 2026 13:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7p-00086f-I4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dU-AD
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0KWv1363032
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dYD4UArw3Ec
 pVHQGohdq4zhIKzMPDLO/NCvrIIHh9hE=; b=ea7BTda31xB5+gzGBH2uefaQbEe
 8tCvHwxDo9p0FV7xsIoTeElOnDRwCmNdYEURxfPXScSq0i4k3ja/A+7oospZAWFI
 YoYd8o+intYV6uauFSU8rzw0hTeB37NuCAJTftJogqpS5NRh3EYEe5Zq3qGBN1Of
 9Qy8niwvPolDvAwvhtuevK+UciDwGBXw4L5KLbM6UG+jI1oH0xHgB/LrOTOvQ6TQ
 Kx90mpK6jNqTPU2AdeCBtgnZcJ7aY4cNAu0t65NG2iIXNnSYV2qj0zNImrTlEqck
 qG/OcVx+mrRxqc8FrUo6X7kgNzi/lf67+ifR88SNl7f+kjWXxE6vJ52Wx0A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1868012eec.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358851; x=1790963651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dYD4UArw3EcpVHQGohdq4zhIKzMPDLO/NCvrIIHh9hE=;
 b=eKMGPialdTNhfBmB37u/yKRpCF95eGJyjTTNeuBJ/HwKKCZE3QIv0hNrE0T+Iy5gBk
 GY6EWxQd55OYxJ9lBCU4+BU1qw/J3mmaocwq4Gx9YM7AoFePFTPuaMC534Z603aYoQJU
 zCbNk990eZYRT91B8qIq25FGsfsHFarZL2j+xxtKpkcVMvaKpYqRwoHOm1X/nY2Svbmp
 Vj6gjWHb7YsVjEoA9c94JzZcQHyqEDnFVXUsalKljRI5u2fk1vTSQ2aEJ3Z5Ifjwt02P
 /yfWQoIYksNlxv8ePDP9sJwqTOrlUY+v5IrP48Pl4yx7ZdNMI0KpadvO0wbV7+X16HZX
 COUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358851; x=1790963651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dYD4UArw3EcpVHQGohdq4zhIKzMPDLO/NCvrIIHh9hE=;
 b=N16L7VQ0/wtqJPvR7Uu4r/93ZupmAjD38juyTQwhy3ZNlsVLAysxhqyXl+lRpPunLy
 dVlfVonU5uAP/d2Mx0QlIL1qSEwxMpbpcH3izlO3Wo394WeAqq1YlxIwsrvqf5I4WMHG
 V+u6WdoXCnY7tOD3HLAgxgLwp6flR/OKLHfWSOgL7+mDh+rCiDe1JrCiDDEESxP5/VTY
 EbeH3L3/jFm6MepAQfnlOmD/0Xc55WOP8ZAnYD3MzOp3D9lVsy4N+0zGCiKihlGEkK+O
 dLuTn5YoAz80kT4kxCXLQqgDn/9rmsjUMXq31q+SrqNLiEEwesfBNBzBkmlfeVU6BgyF
 fk8g==
X-Gm-Message-State: AFuF++kXh7VJ/Pc00QSNesrh4QAlW4SBYgU/MmB0rPnZMmbMBzvh+/wn
 u9j08ZCRWDW1E8odN9Mb9E/xedyIBVwzJ12sM4TDL83ZRQy9pymqrfC7DiwNINe4dQGyZakEvw9
 JbXQPSuezbpndnm4MOnyaQGR8EAi+aXltLRf1lkUzGNP44YVhvjOSg7S7NsAMcuQmpg==
X-Gm-Gg: AYBFou1WehUGREURGbr06U9/z4SIiYIUNqsvoIyshKmJiAn7uLjdfLM3DWlHbxjn4Ko
 oxzcaxaxGJ1vhkzB0ypCq6g0iaUeYMr/5KW0XpVvt2sW/ZyiJxcantAOrwFTEJ3WfahM+RgMXA/
 sGbmDvZZLXROoAKGzSSF3yxydEsLF3yKkS5/wZRu77qXZy18D/AXBf+r7UillkH7Wsnf1nU/No1
 AkYfBwLxxx5HDE1DFpNpNLS9NY1rhpF8KMH3setg85NDtbXal/xvKRF9H3pikLNqnceOay8dU18
 yOP9MfhL1LfgkjmXyJVH+fRwrotcl69NIiEw0VUZMHw9SWSCrQv5E7xZbd8iBEhMpjMALd7N74C
 lVfDZrLmSFgijBzbUelh2cnaFqfZeBP1nYv3IvIcYrv/NdW/RCrOvsWPTuA==
X-Received: by 2002:a05:7300:2554:b0:33b:de3b:8b09 with SMTP id
 5a478bee46e88-342730581dcmr899786eec.40.1790358850464; 
 Fri, 25 Sep 2026 10:54:10 -0700 (PDT)
X-Received: by 2002:a05:7300:2554:b0:33b:de3b:8b09 with SMTP id
 5a478bee46e88-342730581dcmr899753eec.40.1790358849857; 
 Fri, 25 Sep 2026 10:54:09 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/13] tests/tcg/meson.build: compile test with
 -fno-stack-protector by default
Date: Fri, 25 Sep 2026 10:53:50 -0700
Message-ID: <20260925175400.1897574-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0soegLtMQU-tLKpik7V17vcv7sN2CNJc
X-Proofpoint-GUID: 0soegLtMQU-tLKpik7V17vcv7sN2CNJc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX+zfQ3LyexZI9
 IwSMKbrUxRD/q233kDD++2n11gH1XSLUKgjQljFJ0n83fXwNijh2C5bcln760Oe5cvmKLyQ4XRK
 4YJ1KPnQx1aTMp+tF86IkR8fNLqdhv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX9p4DB6IJrn9F
 bHhYs5lyTaKXVn86EwjPwXXebCBM9xl1VS66nwbXH+mbW8sDgC5CYDufP4Bc4pyoMPuE8/5OSYw
 09WoaB4lhNY1UEyqILAk5AESb4gSoqYV+eRSEd7HY6g+VvKrJEA5gqBWkXfHhN+qsKeCl9UwH85
 v3a02/RipxmjkiDzoZF/K8wEdjtNleJZJqZo8cgAUv5dDsRO/8exu0dyHBxfTwQBkhZj73Loo/e
 p/PABQhoxKea4MiCS+sxm/Wvj2jBjtLv9ZrUMyyljf9fDE4U8EIF36gtDibCqCTfY2pyrnX0kKP
 h9X9dX074mZWlqSglbItbLoJAy/1LPcnh3r4CIlFv/FjsMeNmA9g6CgEMzrfYI7tHsANH5EoR5p
 m7mMznbm3XgQkZauvLvYEkddrocRpY0Clo7GShZ45aweCH60mYJu+7g4kGTlPVpu08/n2DYenr+
 srDZYLQBL2Ysg3qTbaQ==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b543 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=HeGbzLMS2XdAEp0xck8A:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

Tested-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3151c5bd63a..7a3f06ddcfd 100644
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
2.47.3


