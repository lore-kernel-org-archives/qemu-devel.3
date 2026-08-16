Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45043C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEA-0000xl-KR; Sun, 16 Aug 2026 10:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcE8-0000m1-Cr
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcE6-00021e-0W
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDmCcw4145024
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L3FrBga8j/P06fU/Dp7c6hT2rFtieRXEyRy2ggU8xKg=; b=JDqn4sryIedvZ2bd
 ox1r1uNyjEmu+F/MwhO8wl+U//sLjmoDKeCQGajL4XvFzRXILkUbB6MhACCu3rzX
 +JfcfNC1EB02mwMwSjlfhLerRJPGWNSbGl2P57GGKp0+GU+OTTYvqgNUpEd9daKu
 cnNSLzdW65tSrQlAFPg+i8kG3SxrnWclA3KbZz1wGpBbBxXyjPH44B605NWiTq7w
 RMgvVJs4FgzM/usCd9FxIUUL1X7cZuj1GlzOOa451DK8aiQuzPM6aWw7lNcK4pIi
 2FasBD8jUlyOWoPP88/qIThaPOfWCzRjV+MCm1Rh5nHUPGN7HP85FrjRATm1ip++
 8i35Og==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwkkkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso25873426d6.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891959; x=1787496759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L3FrBga8j/P06fU/Dp7c6hT2rFtieRXEyRy2ggU8xKg=;
 b=TTYY106Z9I/lQ1qUWclLjsKpGEaP2HYkPUBW66Baap6gZZR3Hf4ISc7vIwkt0uuq3g
 dyLqJefXtixu5HPuHcSKO8UG1HE4h3KOBK2LgM7An2vXtkD0VL7atoo7pGWBlehn2zys
 qXsLxFV6xmJG+fN2LfHT+bTR5o1OwI2zhMx0QYRnGnS0xhaX68ko7RfyvqHpj3cZdz/R
 pM+Wx0Jfyb10wfRf5YupMaB/plF+neNPka74RpFZf1kt4M0bS7B4sEGOZH/UJkqxOYp4
 Okb/zjGFoaeRnIN4Zy6fTRac6MAPfsNSBVDeDvYAGSmIgjQ8WX3joIFCX6WLqj7Q4Mfp
 unvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891959; x=1787496759;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L3FrBga8j/P06fU/Dp7c6hT2rFtieRXEyRy2ggU8xKg=;
 b=d4zUevTXAj6tHwI2M6Xn38bOAFrvInD5Jfg5j8wqneMC5AOeIY6YeXnSfLmw59aJKJ
 kASmRxkCIaWDTvdy6aeifCHG0AMEl84gW3DrjCDYN/OdoQKPmULrwkwNyGcSZIs8ATZ1
 L9BzT1A2WVoYICRymcnpaaSMAbBzH9/WAAwI2M+mtaeInAzaZGCAwqSTPN2Shh6WoB8P
 CY+slSc0xvKlDqDLfdfqL8nOo7SpVYZBtATXzZm1mAsGJehcmcaI29u+i+0E3H/kV7ZF
 F47yrsIyutfRdrmVKoFLmRtw8mU9WwkaNp6m48STl3LEyov9y707cN7H3vPVfiEHN4uz
 SUAA==
X-Gm-Message-State: AOJu0Yw0Rpg+fmNjocVm3e3wklMKjhmfo+e+sHLhYQpA2hmFgpeYH0/P
 v2ffti2FJfoniYH2yGJ5R+IC9lYOugQGoJdM/QorG/7ZCCuPHt00x7iDrBI0IAPwf1k5Vig7UAU
 LG41U4zruqMlRXzCCiQMst9AEkoCdI8Mkjk13i9s2uopVuM5/J3UWdc6E5C3u42u82w==
X-Gm-Gg: AR+sD12ih6WSdYG9M3rRgNrZZXMvJi6y90WggmsMW95SKKpMc4HFeYABfKTHKMpHGXw
 gMdS5RaDSSHx4k/ih53d+7YlS+pfTMOVGi/LpiXRIeX1y8WAZYhsDtTZxIzeebEZn5kdOCog4ou
 NaoKCy/5+U6krg5HkUQTbhsHF29/rT/tw/xpLPgp8JWxrC7ZX4e92Xsv/vwW/9CMfD6yxhWRyNp
 LhS4SH+CuoivBX3qw74/93j8ypelGD/p9BFV1yLcTsPOG3EzEPIEijtNnAmme9LNiUHD25H+sTo
 HRf97d9CW/BYTxRWSbWlQcun0jwcjyxd1Sz541SKR++SmXh1hsriayllcxUF9esvwlMW+FrEIYZ
 d5sP/VdFsXLXjzVclt1sRG6iUJMBH3D32+ufD47hqQw==
X-Received: by 2002:a05:622b:92:20b0:52d:86ed:8394 with SMTP id
 d75a77b69052e-52d86ed894dmr122054261cf.36.1786891959124; 
 Sun, 16 Aug 2026 07:52:39 -0700 (PDT)
X-Received: by 2002:a05:622b:92:20b0:52d:86ed:8394 with SMTP id
 d75a77b69052e-52d86ed894dmr122054031cf.36.1786891958725; 
 Sun, 16 Aug 2026 07:52:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996113beesm50163865e9.11.2026.08.16.07.52.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/56] system: Remove unnecessary 'monitor/monitor.h' header
Date: Sun, 16 Aug 2026 16:45:46 +0200
Message-ID: <20260816144556.69009-48-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yiCXnzSLmt4cSrQX2Tll8DXXpoPQgj_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX08SZzKPI0pdX
 Vqg2HHjaqQgoKXBHWLktbry2Zj6DIVoTbYoL3PBfiiaOT91kXlKnmKbVvvYZPF6GFaP1t0a8mME
 fxMlWJPT0ZcZyB91kJKEXh0EbTfXhJUXzAq4ObV2vohnxz8Euu0SWpIYplHm/4muOtvodHJoT88
 vJb2+byE0GVbmvfrtSTlqjGPTqRY2+C8x1AKYmCl3mI5WjwyiuYeL+y36qirxDAPnqfEDJ88TLm
 0QuYB1MMAA9WVVjeJyeUJv+4fqXRkKFacq+4/4l1I3i3F/kjQDGXkfHKlY07/ZQ6IyJzNoX3vrS
 t5l/I9mqXTF6nbE+Tjh2Hxd1oKQqvcrv9VtCs+yVPxSjwHDOJp5ic1Puh8Vc7H++Q4z/tNLsOPg
 xJySk1odX1JdG+Zyl7clzPU2aQUsduNyKqDe9SJ8fIUZS07Zd8ss/XEezt6ZOW9HROSabT1kIlU
 1xTdjv/8WiVmLRH8GWQ==
X-Proofpoint-GUID: yiCXnzSLmt4cSrQX2Tll8DXXpoPQgj_S
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a81ceb8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=4VRd78mhg-xsesdjslEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX7sGm4JBPst1W
 Rfvhug6hpMmaJkqwxHFDxLZu2/UZ1oDdRtO1iJXPVj3lDSLuhaRcVxO1xfatEotR+UKD5wbtqS9
 HhWkPyBWeLybIqcUeyDg+rInCUY+NOQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

No code in device_tree.c or physmem.c require declarations
from "monitor/monitor.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-13-philmd@oss.qualcomm.com>
---
 system/device_tree.c | 1 -
 system/physmem.c     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/system/device_tree.c b/system/device_tree.c
index 1ea19629841..48365435ea0 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -29,7 +29,6 @@
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
-#include "monitor/hmp.h"
 
 #include <libfdt.h>
 
diff --git a/system/physmem.c b/system/physmem.c
index 2f37cbeb071..362a00f76c0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -84,8 +84,6 @@
 #include "qemu/mmap-alloc.h"
 #endif
 
-#include "monitor/monitor.h"
-
 #ifdef CONFIG_LIBDAXCTL
 #include <daxctl/libdaxctl.h>
 #endif
-- 
2.53.0


