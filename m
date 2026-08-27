Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BBFC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziGC-0007ch-Pe; Thu, 27 Aug 2026 18:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG9-0007ZZ-PA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG8-0003au-3O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLuvx1117684
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=; b=jdRTOBGZQXw6UtN/
 hA87cWIcWhb7TXJ+/nwpg/ZLMFLPMmfhrTEeMa4lH5zHa/vbIelk7Rr4OFpRJ4bu
 Gsi7Lr9s7uXA5lIA0pKEl7RkiXMIyEJ+tes9wDq8BHNn2M5kgwk9FAlnSnNTbCEH
 4mi1WQdOafuQRSBc6m8kMqs0a/bo/UcYdZg7YHMPm9PlqxrHfS32AW/GYlTYQQ/x
 Jd/0G5UmB0OHhB7MmCPUycEFLTorkacIetla58RRhBIRhd+pua6XSu/PmlLUkdtA
 osp9ZxU3e2OYkYD21dWZ9+0RQCYPwQlQ51LkzU0jyWj3nT+afWn4X+dZfol2sgZN
 FahX1Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0heg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc132709c76so618472a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868452; x=1788473252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=;
 b=OKU511Y8HSF5g0An+pEaDg5YkGblYjBNhYFCLDiTcktr1Yoxs3kb2RwbBSVplfF/sc
 /T57KEerGXIld5iovtMDGwVm/RxEc7OPu8JW82Pg9Lmon51YjQlgjDIyUE03C8A2u6cz
 oSTl8iY5SarUGyA8QDG+tvj41z022jbi9hyZv0W349mVIiZBuUxEYdAMbPEpF6/J924n
 la0xHahfyQrJRZOxQgQ/cHzufrilgKVJbZyD5LVRyvcuJNqibpqw02XB0qrdxcKjYnF4
 mxl5r6zycqwNXeLn7/tDSo+wO6ZiMsiAlgwhtdaIgopZCsNqs53Em4G4CsTgNpKjyo5n
 iSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868452; x=1788473252;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tl1iP3X5LICo6HMODCVPKyujVaX6WFjnRPT/8FeoSzY=;
 b=hoYMbD629RSRnmFwvMO9IA42mjVRQawKqmT1cRVE2s2HHg+15HCIb6u/UWmJIBGrdH
 5qweKE4YEmNVK7J8DPkg7UKwRn8nlB0KBpB8uVXKU4k7o3AGTaBgKHLTZOsZj6DsvfML
 TwkxOoADitIjdLzA7qWbsFKeyDoiAgcUPUydcGpcLtZNvCe8iwypWtsHkPKhqylF5JPY
 eCya9X3Nk0lGq8FHhJglCVdmSYlPa2Copn51oyLORMvLo/rK4W+dcx3zJKLPi1unPjZ9
 zFGSEQlaxJR2w4+tHiWRvI2dz8S6VthvgLaSXrMrZt8yKslPx4/ufi9IlRza+Y3Wc/at
 8PPg==
X-Gm-Message-State: AFuF++k3WP3jIxSuBfcPgB/U7HaNWxCpxQORFvVCmbDcGNCGLh91pUd6
 JgOIXVDp2X5XpeQcFYy2rrPgT0QfxCAC7mYj78Qq7dOq6J62+g3+Gr3v2mf55iYpUvkyQDnXGuM
 0CmJul2U5b68wrESNQvWR/++emvWuAOA881pypUk90Cyo2SKbeYHzSDNZxBlPRvptww==
X-Gm-Gg: AR+sD123knCd3S+GH1efWgb90acQvnfe8rDhJEMBiTKPPuTKDVYPfAwj+QavyPeG8bs
 tbKtU7YBU/GFwrywlWbIX/0vPIuZgF4P0GIpet9TcWffP0t68DHKQu1zVF8I7NaiwrgZGQQ9djv
 FD0BadMuvhcW8PZsLFQK2lpVQ17qC8ilsgPdjYWKkS3fwrSoWcm66U1yZ9vgrH97jRXNoxtzsb3
 iVdO0nHPdQxT+ASXjNdNsu/6Pr2nSQj0Dr4WRCIBdXDAH34nFm90aH6c+cat8o3NvOTuSUM8MnC
 HeVXa7K0re1nYw2oGdRZtltv7rjI5iHJHzBapyAQqcHtvGg/J3hnQBof8JLSLNMZXhRPu0UDM/Z
 HeF0U4/RkmJSxMMnVu/0WOHk0V5epSIJS7RWp2BY9CtzIoXMifdaYSoQvKKo=
X-Received: by 2002:a05:6a00:2e24:b0:851:8baf:5b26 with SMTP id
 d2e1a72fcca58-8562a7dc401mr3326803b3a.14.1787868452256; 
 Thu, 27 Aug 2026 15:07:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e24:b0:851:8baf:5b26 with SMTP id
 d2e1a72fcca58-8562a7dc401mr3326746b3a.14.1787868451845; 
 Thu, 27 Aug 2026 15:07:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:31 -0700 (PDT)
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
Subject: [PATCH v8 032/105] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Thu, 27 Aug 2026 22:05:26 +0000
Message-ID: <20260827220641.84885-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2U5aJ5QK9k89
 wZqdY/lfnpot+fXBE3VMLZv8MNNGnpPq99KDn9UhT94Duh05occUJTbJTzPtmbGSE723E21sdYF
 2zGrJwgkNZsNjqSFQmkrrpQVDliGo7vbrvr6aIX8yACHDnk7epY2cwOe86LlyUBX/dgnXLLaTBo
 ddUbcgjQy7OzKciqlkwuvOsmVeRNxil+FxZYan+uOjR9yGbHEacBEjjkwUZbKkq/AlH9o9OfIYq
 QbFaHFZVF3n63dPpYienaHa6d/omxEwgkrBb7d5M5utUvm7W0o09SO8twn8nC7jBy3eazkxmN4g
 OrNwj7kLnHdnwgfKA4Xw9hDjieD0Q2cwQoa1An8qvo2CWV/fHzUYk5Sj/rY2nKcjAOjATSurUYj
 mssTJgnpVVKHRidV+p624eBeTARLPeOuSV2w3EAjIJQYBGSDWuz5Ry97p+BNe5lHJCMPIHSORvQ
 tkPP+FZoUMlC3i2gj6w==
X-Proofpoint-GUID: I1QC01gFsWOv7q5Q-guEDksyoW4ve3Jd
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b525 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=WK-hs4OApzzqMslTwvAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: I1QC01gFsWOv7q5Q-guEDksyoW4ve3Jd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/oES2RFglOJQ
 G5AIncrxgPq/YfO9+TxxBXgNdWa8Aq/CgRqmBKyFlC65VdT/lEjEGqRI4XGO1PVa74envx6TzYC
 XCJibXgTlIZn/CPPVc3CUOHtV0y3RXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
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


