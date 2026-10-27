Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SMie4OiF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wi9fwVWq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmp2-0006Pt-Iw; Tue, 27 Oct 2026 15:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoL-0003uG-IM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoJ-00028W-KH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHbY71917511
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 itoH+sO7JOg91PehhfpcY22JWZZARwJdCRkM2u1G4BA=; b=SMie4OiFpx0oMFaJ
 wZzG5Fo9RA3ELxI6fFGHqVMv6+4EiqObatvA+SAjB/URj3cAfxLNFC471vN239RF
 /A44On7PYzCxKcqIJPn7MS/7+UAtLp//648rf1DrF0segsvtykvy1gommnCNEHYe
 9qFpXej8WjuFxWO2N9k91RxMIi2QxDHc30fGQ4ONOwNKjFkgxyCkCLnc4c3tIClW
 o1aKks3fJbPi3WN/sofzIgHFvRvLvClrt2lHgiXFkBCwJrfm89lfAmyFfHfVmGxw
 UvDc3GOuPiyW8+zKQvyi3ZU0ehlfgYsC8HJXGA4hMmjCyG5qPiKOaRvaAQprKaFT
 Xu/r4w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99uxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so27356285a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129174; x=1793733974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=itoH+sO7JOg91PehhfpcY22JWZZARwJdCRkM2u1G4BA=;
 b=Wi9fwVWqLgt3e8P7bA6mYLQfs6mIiY0yXqpk1jvoLMKcW153zreIgmIb68WeiEhbvr
 l8zaz0D12DGtqjSbH3GCFWGMGN6SrgR++u7fk94N9shLOxGmpjkHMjfxGwVseL7jqyJa
 /oiJS4a0PIKC30+a1mIMZkXyhaiQptVGqjNT8MSmJOUGp61/2ebsbz0XIa4beJ51X4+8
 mkvfZK+FflO4eJwOEL8Z9wUAsApiYUOnhIfWH3rO7P108l1aIALE8jih5gddryRH2IFr
 rPQfLDJ4gBbc0udW7uIYU82EsU/xcujVPwSHfVJ2Fi0qwZ1HVPkfZecByEAil/tzFswC
 yrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129174; x=1793733974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=itoH+sO7JOg91PehhfpcY22JWZZARwJdCRkM2u1G4BA=;
 b=SCAG6Gub2wyogYFWLKE0QGj/LPhYXRmel4oagBBSyuUaBTc1PdbLnJpohU8RNPIqkK
 f7SgOrKL6M2CuGbXdAL+gVbsP2FgxRgwLjhH6tGZaM4fgzhS/+ZlvgXC0v/xBoI9Oy32
 LEQmPS2GPqqyzEVHouAuGW9t3PgCnOthPdCI97wEKyx1E7jfF6scuNDMvdKgAiBVHXpl
 iyAAS8G2EiGsAKBLowa25wcs7KFwP5nay962v1CXeBwMiO/x+G1vo5eVgChnZyFeQWgW
 Wv9jqWgRrOYo0q4WNinOtfVpTZcixEeU2duRG6GrDS+5Ke7XK9hZRzbRXw4ThtceDQen
 7Hrw==
X-Gm-Message-State: AFq9FYJASXateu9M1cwVCn5PN4GGTfckm1v0rHS2i1YowQd5tSFLVFLf
 llZ8ViQxw2sSN/C6bOl8odMmoiiB55vuzPIykIZ+SkbPxXYEflf/CtU0UFWCB29tkf1J0fMMMi+
 qr89Mk9bbQ0z3C6NDzBtaClfM+snKU0SNb1isC2HVehQD+i0FjnWdrrZO0wN07OngGQ==
X-Gm-Gg: AYBFou3rSh6WbBfeiuI0X4vzWBMMhNtH+dFhUJJJS4o+XyHoAzbMuP9hrJmthby3vMQ
 lfMvbJHgxI0oxkzSTTDZ6rrfp5HgjqH3vX69YsKffNqHF7kUnFr0Axk1Pw+YVtvqMsNhxwhtZK4
 /MsX8NbKFYgzTR1/k89kFW6KMI/o2y66hHEurucYR5CSkIO73gsDTBmMLTDYmGY3uMCi0w05AVr
 c/H+XE9XCsFPj63PpH18cLUxPWwL2eC0f6CEuSLOhlx/dTpGECnxpc8iqLIcrrOxjW8VGOVk6Lb
 h3L3OVa9xbSoK2rZPM9oUWEqFqSEpBFPoVw1O1MkOMsj0nG6ddFePG2i1rEzhZ+SIRRkFNHaJlw
 HYP+pd2BqBaOV/9tZpz8M6HukL2F/1i33NN4KrH6cITR9WNkKZpq4rvWl
X-Received: by 2002:a05:620a:390c:b0:93f:3358:3ed7 with SMTP id
 af79cd13be357-940ef9710damr1727777885a.54.1793129173996; 
 Tue, 27 Oct 2026 12:26:13 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93f:3358:3ed7 with SMTP id
 af79cd13be357-940ef9710damr1727773885a.54.1793129173493; 
 Tue, 27 Oct 2026 12:26:13 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c021080sm2887485e9.2.2026.10.27.12.26.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/59] hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from
 config IMX
Date: Tue, 27 Oct 2026 20:23:03 +0100
Message-ID: <20261027192341.9197-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0fad6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=7JY1QF16XQypgiAIEP8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: aXgXBdx8ctdxe9DvQ2xcT6rDYWLGrts8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXzDor5TcFqTIZ
 lGoJp/jLPZIxI6knVnHS0VQl2hTbc75gwySM9c7DSNXFJK/pC1T/mv0KBj63j1/DcvdGS1uJqAx
 ecbYuCEddfOrOsyT3UA7X7S8yYYjDfhDRmw946/OKvqAIPFpFiE2rom3ekBi+3ZR1/17FELnujB
 QXK1mGB4TVQfgNCvzDCouNoVGfy0w9dtV4U/hEY9gJjG63jnrYqsmceadHbh7fPqL2TjYFW8rUd
 pV8FLk5q86Sq5A+nA04HCcDRxvzwy2BB7H5djt2VOzKjeI/4t8cE6zEXmwXY1pz3LvKP2/B3LJu
 fp2zYkQDfZEJis9YdybZ5yJ0mPYaY/8Inc55WQDhaYP87JTQj59zaTn/BZHCOLoD+KcHhuZ03+L
 FsRuL7vkyKTgXG5pHwkzqFhpP9ltcIjHCtOB6hVHpZEJcWjTbDDJmikXjd27UlINCy+FTYDtic7
 n+Fkjumn4ttcmxugT3w==
X-Proofpoint-GUID: aXgXBdx8ctdxe9DvQ2xcT6rDYWLGrts8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5rI+HB8h43jO
 o1FguvVcp8lRRJojY9uPO0WzyiuJIyKW74xtjh8VvEIinukmnOaQwkw0qGQVs4ld9XkscFXGbdu
 4b27vwJKYieyicUePN0E0IEHk8+7GYc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Since commit 464ce71a963b "Kconfig: Extract CONFIG_USB_CHIPIDEA from
CONFIG_IMX" all relevant i.MX SoC models select USB_CHIPIDEA such
that selecting USB_EHCI_SYSBUS became redundant in CONFIG_IMX. Remove
it.

Fixes: 464ce71a963b ("Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-18-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 7abd22869a47..8cfc390afd33 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -93,7 +93,6 @@ config IMX
     bool
     select PTIMER
     select SSI
-    select USB_EHCI_SYSBUS
 
 config FSL_IMX8MP_ANALOG
     bool
-- 
2.55.0


