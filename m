Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F03C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nG8-0006lY-VI; Wed, 02 Sep 2026 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nG7-0006lA-6U
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:52:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nG4-0006WQ-KW
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:52:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZKI12177523
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LPiZ5oSOZDPRCNUwpqYm9S
 UGPSGm1jHZ24CXTCSgk2o=; b=jeX/aBSQbd3XDl5nXBNpj5664OMUS5PJy1FhvT
 ml3qYgprR+im+8IAxsvgxnXBtrPu+91QuATaeuyuD1j93a2iGvAH28hDyb9QcBGL
 P3xwz0a/betNi5YSWYKgQBkWmOuAvR/mU1DK7CvqF9SfFnnm7fh8CjYAQJ1YAFe8
 hiQWq5cKS8IssgT6ekczUrPkN5/4S4KOFxAJsUmXtGw/1lNiXemGf228ZLhI/EDI
 aEILvfNe7gZ1wh6rdlGJ0JAW5cBwmLrGTRAW+TLJVbft/osir0/Oi7ec7Vd5pjpy
 LFPJcNsYdeV5uaDBzCIOQeAoxvuFfAi2lNKj1tA3IEB9lsag==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh8k42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:52:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec3146553so359129185a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788364334; x=1788969134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LPiZ5oSOZDPRCNUwpqYm9SUGPSGm1jHZ24CXTCSgk2o=;
 b=Ead513JRN1WKLfBUGDyrLukh10mo+FcaB/MmWNF8fbL7obiWGOHZikUboVODvLz/8K
 bTtRasCSFsAhxwZgZqMGtf2uocNHgsujDUTrwBD2k0XB9Bs9kvPSCCD25Va6CPrweQ9E
 i9pY5opbWUBZ854ONPzZznUMiWr9KeOq+4f3SVF215WUS1tm1ZylQ6I9Lp4GacP9Q167
 Wksm/8HYPZAUzDK9bHBWXIqGCB9TWFEPHBg/8bMgu9h94GvQrEZMG2CACfgryJi2Im/u
 LgjSCSIoZp0cHxwTSAGF/g0inARaELBTUNsWTR3dzrK+HpFTsszrWXYs6xfR++HVcdqe
 HzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364334; x=1788969134;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LPiZ5oSOZDPRCNUwpqYm9SUGPSGm1jHZ24CXTCSgk2o=;
 b=MTWYCnRqSm4BnvLY/PHzk0IuWI8jmUhVmfUd46Jp26zryTEDlGwikN56ECVAJxyrny
 0kCi0VBC5FK3hTe8p1xw8OhD6DwXY8FIcJbBAENjlMwb7vCrwIgF7zu6qblogql7DyI3
 Y0LESCkR4de0t6AQbMQ2Mfey9pt5iW2G2vSkl5TEbUwJm4hI26AqwB15am44neNBboFw
 vcgwolt93E7Z/m5yw1yScYwskzW3qcQOVH5Hk9qRfUYiAreKXK7tU7ajk74CY/+TL6Qg
 EOU2a4wwnF14/k/i6mx/zQS5BbDV/c7+biL6PQAsr1g+4N2pVhKeOoUee1KGHbOBnfBQ
 QDOg==
X-Gm-Message-State: AFuF++njGYif2NuBfJQmmcqvZz79cgEb3mcPckj/a6cEZNRg+iD6H3Xs
 CbPib5t2P6OL0pfMAI/W00CCpqovRSJGsZgUBLEP+8ORHYl3swSMpJoyAScWJJNw2AunZ7oGCPY
 JwA5kVgXZbqLMIgEKXC1Td7xdtaSzEvMobsVW8ovYQbzd/4IuvTMLSqUHHmw9KO5aKA==
X-Gm-Gg: AR+sD12CE8eqRpiEJaVjn2uKIT8YWPpwNjJhAgxdXgxdXeKqLbGF1n6of8KqO8rRy0g
 Nw+T5VDyvj1LvZjkCcIqhLcpXQ8+PYOKvrWr5g/uKcWSAiOwlYd/7u+p61VvaGAHfI6FV026bQP
 RHDjbioZRWve21wOG2xVld57HOSdPZVOrC5NZ63NdNfL2VFI1R7L1KNrQeANG/b2R0Bl+Dbx/Os
 oPltH15EFtRaj6M4hwEiLY8njWMe4u6q+IOHF8UwG44SDTcAkHYeogrSnRkjQMExgV48TIGaY0S
 wH6jUif4OwgkjHNvJZNd5YgawxqeD31Q3CdHd0sBV2xzVWJxI7estaDgeLGUbRPchagW6noST/I
 971CBjxtGaboUuwhUbqyKLb9X3kTHHO4ulho8qHBL
X-Received: by 2002:a05:620a:f15:b0:92e:5d44:73fc with SMTP id
 af79cd13be357-93960de7599mr664020485a.12.1788364334000; 
 Wed, 02 Sep 2026 08:52:14 -0700 (PDT)
X-Received: by 2002:a05:620a:f15:b0:92e:5d44:73fc with SMTP id
 af79cd13be357-93960de7599mr664012585a.12.1788364333310; 
 Wed, 02 Sep 2026 08:52:13 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e6f604sm7251297f8f.2.2026.09.02.08.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:52:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Update PhilMD's email address
Date: Wed,  2 Sep 2026 17:52:11 +0200
Message-ID: <20260902155211.32399-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pU7ULGQJvxIuMUKWvIIQY81IGNRqrTaZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MCBTYWx0ZWRfX4PCzrEvhqqpm
 DD2/7rLP7Z9Wj6tJ2U8hXVTV3v1s2khSw/FHXNu+jqgDus/jKgEFVLpzpkSy+CzS2N2M2OJElwM
 HIPhvCvYd4+bdZ0GT61gcQua1HLx22lC8fpjU3mN22hoUpm6NoHDAIc7MrcB+QCkx+x1YgyEEkE
 Lpo2f9Nd03ggYSejqexAdeN5ZWpVxlY5a8SSJbSEOA6XBqmXfH4m53K5JXI/QMq7dsU+rBhPwtC
 Erv5gMkIhI1B7sT0mt0qN36XnUi2G+ElukO22fX7IWjMoksxXDaMdtKTYZmMUmJU5TRqFTeTgDG
 577ZEeio/YrNsXai8IgqoWbgIjr9+W+qp706LNGaSKOoE52kuz1v+hHD0Z2OHTUI1a8i6rJ8MU0
 RkFXjvwgIXch2nAjuB3QX/9LigBeXiKDt8XZNQLS3O0vpvcl9wAaGWGcNcdcE0fjWbz0ZdhxMU2
 w/PmmfV/zCmzLvS+vRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MCBTYWx0ZWRfXzFtsulETYf69
 O7wITQzLi37Mw3yHxKWPAzGGWVz+tMsZ1Ga+yb09O566JyjLhOy5LftzvygRcV5iM/BLbW98fmQ
 jMmW4CmbaVFtBfvVgitTmdQl/a+c0nY=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a98462e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ID6ng7r3AAAA:8 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=S56xvJB5AAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8
 a=jqTOf7lJAAAA:8 a=hXZgYZo4AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=9u_AbM2CAAAA:8 a=up-X0YpDAAAA:8 a=K92WTf5yAAAA:8
 a=bgKrIEmzAAAA:8 a=gPJu0pBYAAAA:8 a=r_1tXGB3AAAA:8 a=v5NkL0kxAAAA:8
 a=FyogFE7hAAAA:8 a=Ixn1CAxRAAAA:8 a=ciZXtekWAAAA:8 a=lB0dNpNiAAAA:8
 a=-c9VzbpeAAAA:8 a=0FD05c-RAAAA:8 a=cbmL4FPxX1N4hFPJLr0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AkheI1RvQwOzcTXhi5f4:22
 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=rFolWk1O-vXzQ6QHWabK:22 a=37BJPeUnzxYkbV1yBC-1:22 a=BKQHd7vISpuzHE4vo7dZ:22
 a=86FmjZgct7XXK6GGpxvI:22 a=X9ok8FpLfHEzVMsE4qxm:22 a=Ifulqbl_J-1aL42CD9IR:22
 a=AlIIF0cMT2hfDT4axODj:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=KW0dtVGFZSnqoMbxR4e2:22
 a=p2WyBLmlf5vdw_nX_QRo:22
X-Proofpoint-ORIG-GUID: pU7ULGQJvxIuMUKWvIIQY81IGNRqrTaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020140
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
 .mailmap    |  9 +++++----
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1830cdad15..cf05783668a 100644
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
@@ -2407,7 +2407,7 @@ S: Maintained
 F: hw/ssi/xilinx_*
 
 SD (Secure Card)
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
@@ -2888,14 +2888,14 @@ F: tests/qtest/launchupdate-test.c
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
@@ -2903,7 +2903,7 @@ F: hw/misc/unimp.c
 
 Empty slot
 M: Artyom Tarasenko <atar4qemu@gmail.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Ani Sinha <ani@anisinha.ca>
 S: Maintained
 F: include/hw/misc/empty_slot.h
@@ -2982,14 +2982,14 @@ F: hw/display/apple-gfx*
 
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
@@ -3054,13 +3054,13 @@ F: hw/intc/openpic.c
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
@@ -3186,7 +3186,7 @@ F: audio/alsaaudio.c
 
 Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
@@ -3424,7 +3424,7 @@ F: scripts/coccinelle/errp-guard.cocci
 
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Maintained
 F: docs/system/gdb.rst
 F: gdbstub/*
@@ -3438,7 +3438,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
@@ -3501,7 +3501,7 @@ F: tests/functional/generic/test_vnc.py
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
@@ -4065,7 +4065,7 @@ S: Maintained
 F: contrib/elf2dmp/
 
 Overall sensors
-M: Philippe Mathieu-Daudé <philmd@mailo.com>
+M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Odd Fixes
 F: hw/sensor
 F: include/hw/sensor
@@ -4618,7 +4618,7 @@ F: tests/vm/freebsd
 
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/testing/functional.rst
@@ -4674,7 +4674,7 @@ Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
+R: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
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


