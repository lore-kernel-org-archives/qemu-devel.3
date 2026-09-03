Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C5EC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24xX-0005EF-OW; Thu, 03 Sep 2026 06:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24xM-00057m-0C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:46:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24xI-0007f3-Us
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:46:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHIoQ162960
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h9RIWx6x6zRqaO0k/EMmEuPQdfhJn8c7lVHPbY/dtr0=; b=Ymu34p7NDVN4rETw
 q1e8WTEjA+NBxt2CmZ3vOvIY4EpXraN/EcCcbgHw7DiooOHXQ2uSr3o0WhKKHXCq
 rjOe87GLH64bpUNukq3Up5X3wvYS9dvIp19gcOxoQzB22SkOHq+08jlumcDNKukn
 1DFLI2W5FJnC6+yrpjdzNItrsH8UUOeEOItw4CZUgZOOAHo/i7JKJDd6QE7yVrFT
 JM25XXWGuxrDrhrZuotLJ26SEUqREkSfAF4Q5HFxp0cXKHyT2iGvySXTRUq2EZl5
 23LL80BtIooELRn7RBXgMYbeml8O9TbzM+toBd3ccv9Kc1WRPxvQzY8F72B/EEab
 K/yTJA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx0532-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:46:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9396e0515dcso59117085a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432363; x=1789037163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h9RIWx6x6zRqaO0k/EMmEuPQdfhJn8c7lVHPbY/dtr0=;
 b=jKlXJk2gy5P7fzpa++Aq/XuZAyRtveeFD2emwMPplrkfL+WZJP2XQiTimmpIT8BE8R
 OZmAzwyzJ/IjPAc6uFjo0BE40JeYPorX4iLwT5sdMAoRVD/L7df4Oh2LenTYPyi12G+B
 vKLbUyjYcva0O/Ei4Zjy/zWR4uLN/83Vztztmadsf1cPCFjTlCirlxEdxCg4iKU0y5OZ
 3WaTDPkomJAIGLfN9EWRfVdbpNFuURF3h3Xj3tLeSMowOGcC4VaLO9D0U1pPvW3a1Vn2
 qgSGFIy0Xrp8co/Ry3agTscpkEiIMFrWn8GV9ZSdsHP7i+N/Ogo+vwHq2PiCKffJChXp
 1vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432363; x=1789037163;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h9RIWx6x6zRqaO0k/EMmEuPQdfhJn8c7lVHPbY/dtr0=;
 b=HdHYhrcPNC320GHubk+ylp6gyYgmTT9gIyxTFqVHxLXr5Dfu3JSp0PhI1BaIX/VzA9
 imNE/Y51EqEl7iYn1aCO31GlXOhnmyl5zokPu+8/gMvyRTIHmyUg0BO23W31El76DCd/
 u3GAoOzR1Ulu7P8qamGEqvDnhzfZXPTBHm8HDY9/xjxABrmZ9A2ch2FYQqfc9gEZVfcD
 PWmoKkrySONO/ITm+w7vMJQF6Po3ymShhJ1lNo+drpTZ21/GIfcLEL1r3TdAwb9xY6eD
 laACjj0mekZcFzRI7cIoMD/sEmC4lrWPWbHqId7a9Pb1P6JD0NPSvamIsym2qqB+MPtO
 D43g==
X-Gm-Message-State: AFuF++kJU5xQxsOhnzF+sQ6zPqjTjQpllThi+vrnkfSs7vwjLkzvvYf2
 phuz30fArXGvApHir2Zaz1kZ974lpegAJcz7Co6NVHGHMsG/5H2BS1/Qjtt4DB89bgwT2ACP1cP
 yKQU3z7EPGvpAtUmeNZucoLktWZ3gmEE2cFQ0rKYVvBWrgjWiWP787aS3woDPuL+XcA==
X-Gm-Gg: AYBFou08TkkAm1g3VVaFjEVqbUKNg7OnMXfsJZHWfW+POc1X3kSbzzDJ/rTc5yReaP3
 CrUqY3sGYnS6PLs1oCalq07Iy0zML6spmC9+rVUYauhu8JneXZEXEOewbJw0bhHFxx9uCMGq+IT
 KOI8PyxZOO5D6CQy4lDTtor+7lU4sf3xdAPly6SBF8hqozqI91qbX5oytkMivMNGK1Nu7shLWrY
 9lHOHfdmF/7v8qHhGuVfe+NQIDYoarSzarBI/0A+eKDNJSVLE065FujBfOJiPwHxwmGFNTekmRP
 sE0TDtUBOV0Gs4gI6XMO476wzkzZeGwXq7ZIKuKY9pQJ/eNfJ4YNy+2pGwNFAfgGMh1Eh03T208
 wnQGoIFnS9CCF6+LHogALwp+xWmIbW6xBJvFpRh4v
X-Received: by 2002:a05:620a:a20e:b0:939:3b56:c416 with SMTP id
 af79cd13be357-93960ca35cfmr1270682185a.8.1788432363217; 
 Thu, 03 Sep 2026 03:46:03 -0700 (PDT)
X-Received: by 2002:a05:620a:a20e:b0:939:3b56:c416 with SMTP id
 af79cd13be357-93960ca35cfmr1270678385a.8.1788432362638; 
 Thu, 03 Sep 2026 03:46:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm88537205e9.3.2026.09.03.03.45.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:46:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/51] MAINTAINERS: Update PhilMD's email address
Date: Thu,  3 Sep 2026 12:39:35 +0200
Message-ID: <20260903103936.62355-52-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3XTfT3AHjt--JywAugLFfvtf6qfD09id
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a994feb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ID6ng7r3AAAA:8 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=S56xvJB5AAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8
 a=jqTOf7lJAAAA:8 a=hXZgYZo4AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=9u_AbM2CAAAA:8 a=up-X0YpDAAAA:8 a=K92WTf5yAAAA:8
 a=bgKrIEmzAAAA:8 a=gPJu0pBYAAAA:8 a=r_1tXGB3AAAA:8 a=v5NkL0kxAAAA:8
 a=FyogFE7hAAAA:8 a=Ixn1CAxRAAAA:8 a=ciZXtekWAAAA:8 a=lB0dNpNiAAAA:8
 a=-c9VzbpeAAAA:8 a=0FD05c-RAAAA:8 a=RBb6cmxZ0Hc3-IgbcVcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=AkheI1RvQwOzcTXhi5f4:22
 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=rFolWk1O-vXzQ6QHWabK:22 a=37BJPeUnzxYkbV1yBC-1:22 a=BKQHd7vISpuzHE4vo7dZ:22
 a=86FmjZgct7XXK6GGpxvI:22 a=X9ok8FpLfHEzVMsE4qxm:22 a=Ifulqbl_J-1aL42CD9IR:22
 a=AlIIF0cMT2hfDT4axODj:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=KW0dtVGFZSnqoMbxR4e2:22
 a=p2WyBLmlf5vdw_nX_QRo:22
X-Proofpoint-ORIG-GUID: 3XTfT3AHjt--JywAugLFfvtf6qfD09id
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5kHOCnaf1v4g
 EeKTCnioXMGF3s6SIY4fVKT/2Io/fklgD6z025YhHqOqEq+FWx3R2tkmpntw2r8R2TqrAz2b6xn
 wWRS3k49fwEDFe+8U8sOt5GeGZMBFoOvBGnU/ZzovEYWeujMCDlvNIvR4SSLF+iVW83h0MPq2Ue
 mKwl6+wQ2YJX9WXuKbvrU0cV9HBqmquO33Xd3VFUAP9fcoOaJ9BxtiwGko1eEb+/FBtvk/QG58j
 X2Rmp4X38fRhJzpwDjn+mHrfydmKEUlKNMi7IKjWvxiPBGDWvZ7QV++jHrZmptLjUNr0jnb699k
 7UwuqMHXxrrVtafN7ZxNUKrXY4OYcQ7zdA7l6Iuyb2/nyYWfl9roCMtDnKVgN4ac5y0MOyiFK8D
 gcCRSiff6O0E9LXgC33x3UAK4m8JnwSvDvj8oEhEQ6JKh5y64o4agT71EQJqLa+DQrepyhcWwLf
 t7qvkbZNvrLE37tEsbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/SbNPN2zhk6w
 bf5ERU6Nmwjs3F4HRg9+xu5fGyKgQuF6hcx0quLh9UX+ar0TfEZ7nYvoxufg5ik0gfuNAAr+GVU
 QJay6QFDccbdvY/MMeMDU/0Fl8h9vxg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@mailo.com>

My personal email free service doesn't scale with qemu-devel@
mailing list traffic, returning distinct STMP errors. Dispatch
to work email instead. Update mailmap accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260902155211.32399-1-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 56 ++++++++++++++++++++++++++---------------------------
 .mailmap    |  9 +++++----
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cff90141f7..f524d905236 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -68,7 +68,7 @@ Project policy and developer guides
 R: Alex Bennée <alex.bennee@linaro.org>
 R: Daniel P. Berrangé <berrange@redhat.com>
 R: Markus Armbruster <armbru@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 W: https://www.qemu.org/docs/master/devel/index.html
 S: Odd Fixes
 F: docs/devel/build-environment.rst
@@ -132,7 +132,7 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 MIPS general architecture support
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 K: ^Subject:.*(?i)mips
@@ -315,7 +315,7 @@ F: tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
 F: tests/functional/microblaze/
 
 MIPS TCG CPUs
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
@@ -545,7 +545,7 @@ Guest CPU Cores (other accelerators)
 Overall CPUs other accelerators
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: include/exec/cpu*.h
 F: include/exec/target_long.h
@@ -707,7 +707,7 @@ F: qemu.nsi
 F: scripts/nsis.py
 
 Darwin (macOS, iOS)
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Odd Fixes
 F: .gitlab-ci.d/macos*
 F: */*.m
@@ -1013,7 +1013,7 @@ F: tests/functional/arm/test_quanta_gsj.py
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/raspi*.c
@@ -1324,7 +1324,7 @@ F: include/hw/misc/avr_power.h
 F: hw/misc/avr_power.c
 
 Arduino
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: hw/avr/arduino.c
 F: tests/functional/avr/test_uno.py
@@ -1473,7 +1473,7 @@ F: hw/microblaze/petalogix_ml605_mmu.c
 MIPS Machines
 -------------
 Overall MIPS Machines
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Odd Fixes
 F: configs/devices/mips*/*
 F: hw/mips/
@@ -1490,7 +1490,7 @@ F: hw/dma/rc4030.c
 F: hw/nvram/ds1225y.c
 
 Malta
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: hw/isa/piix.c
@@ -1504,7 +1504,7 @@ F: tests/functional/mips*/test_tuxrun.py
 
 Fuloong 2E
 M: Huacai Chen <chenhuacai@kernel.org>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
@@ -1528,7 +1528,7 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
@@ -2113,7 +2113,7 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
 F: hw/core/cpu-internal.h
@@ -2137,7 +2137,7 @@ F: tests/unit/test-smp-parse.c
 
 TargetInfo API
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
@@ -2373,7 +2373,7 @@ F: docs/system/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
@@ -2408,7 +2408,7 @@ S: Maintained
 F: hw/ssi/xilinx_*
 
 SD (Secure Card)
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
@@ -2890,14 +2890,14 @@ F: tests/qtest/launchupdate-test.c
 F: tests/data/igvm/*
 
 LED
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: include/hw/misc/led.h
 F: hw/misc/led.c
 
 Unimplemented device
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Ani Sinha <ani@anisinha.ca>
 S: Maintained
 F: include/hw/misc/unimp.h
@@ -2905,7 +2905,7 @@ F: hw/misc/unimp.c
 
 Empty slot
 M: Artyom Tarasenko <atar4qemu@gmail.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Ani Sinha <ani@anisinha.ca>
 S: Maintained
 F: include/hw/misc/empty_slot.h
@@ -2984,14 +2984,14 @@ F: hw/display/apple-gfx*
 
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: hw/isa/piix.c
 F: include/hw/southbridge/piix.h
 
 VIA South Bridges (VT82C686B, VT8231)
 M: BALATON Zoltan <balaton@eik.bme.hu>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: hw/isa/vt82c686.c
@@ -3056,13 +3056,13 @@ F: hw/intc/openpic.c
 F: include/hw/ppc/openpic.h
 
 MIPS CPS
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Odd Fixes
 F: hw/misc/mips_*
 F: include/hw/misc/mips_*
 
 MIPS GIC
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Odd Fixes
 F: hw/intc/mips_gic.c
 F: hw/timer/mips_gictimer.c
@@ -3188,7 +3188,7 @@ F: audio/alsaaudio.c
 
 Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
@@ -3426,7 +3426,7 @@ F: scripts/coccinelle/errp-guard.cocci
 
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: docs/system/gdb.rst
 F: gdbstub/*
@@ -3440,7 +3440,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
@@ -3503,7 +3503,7 @@ F: tests/functional/generic/test_vnc.py
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
@@ -4067,7 +4067,7 @@ S: Maintained
 F: contrib/elf2dmp/
 
 Overall sensors
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Odd Fixes
 F: hw/sensor
 F: include/hw/sensor
@@ -4620,7 +4620,7 @@ F: tests/vm/freebsd
 
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/testing/functional.rst
diff --git a/.mailmap b/.mailmap
index 08f0fa9e118..bd8bf07feb7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -113,10 +113,11 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
 Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
-Philippe Mathieu-Daudé <philmd@mailo.com> <f4bug@amsat.org>
-Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@redhat.com>
-Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@fungible.com>
-Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@linaro.org>
+Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> <f4bug@amsat.org>
+Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> <philmd@redhat.com>
+Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> <philmd@fungible.com>
+Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> <philmd@linaro.org>
+Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> <philmd@mailo.com>
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
-- 
2.53.0


