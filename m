Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A7CC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kxz-00060p-1q; Mon, 21 Sep 2026 16:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8kxh-0005qR-MP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:50:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8kxf-0001vS-Lr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:50:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKf1QV1613805
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 20:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vwFC8I/8Vuq
 Y8PXZs2vVtFUGpU274BL7KknFDb/LHZo=; b=Xp3sMY9jGYGpJNH0c7BPaXO15cI
 t1pEm8rMJLdp4pcwLIHdLlHYJ3XNchJvs2qw9jP1Dr7sAt9zqzjfbVaTDG2TnydJ
 mbJ7TV5avWps0gaWfMxnkpsdHU4nBwfXkkgaI+T1ZVMYp1kwPQNuHuwMlCm99b5j
 1JG0mplIJXEd1szbDhZQ3BSGHXNxxuiZkXyETrsJfgIXkxuibURL0USk2uNEOby2
 RDy62JU5qHGZzmf+R/QaxNX4rz3i6RlY7RId1bstR7HhR9N7CN3WlFm+jD8kv/Ho
 bzFt4EKAFkCS28fTo9eQ9U8a0U8tA0xAlw7FSZZe2YAUMjxw7HkCNl94zqg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj357j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 20:50:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8632fdf67dfso313853b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790023801; x=1790628601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vwFC8I/8VuqY8PXZs2vVtFUGpU274BL7KknFDb/LHZo=;
 b=Gysygxj+vIVeZLBMbMbY16mQTkEqoB0QfzipK7uH3KScfPc80TDhlHJvdLOf3pWYEz
 fKdq1R9wJln4P+LupEIBf/XHpccvS+bU1l7myTHxiaJMXBiPVzFTBMI92s1deqfF4PpQ
 6f4vxIyJHSMlxK3HlIka0pdBg7cP9WmhkRBYlq3X9jdpGNw1lQyqbWeECJrE8Gt2Iif/
 0QQUqbM6rmHVY/CjJQfCfXPEefbMmEgu2rENFFnWfGgR9WP8W0OiWyh8Iin1egf0MYvi
 GMTO8PK6B5jX76ONiKbdKV+VsGsThHeKNz2lUcpaOJ+ueVSuIT9p9n2ctV1NTqCP6r9N
 JCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023801; x=1790628601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vwFC8I/8VuqY8PXZs2vVtFUGpU274BL7KknFDb/LHZo=;
 b=UtDbUNl6vNYK0zIEo3vp9yH6oPMKQNRQRVPpAiSblNablKZHv9KrUL2SH/sFBRbjAR
 og0KN0Qg6ze3C99PZomfoeIfktVQr41TrXwFgM4mNLHGhtOw7KJJHs4+GqVN8Ny60gQt
 JgnOhyqs1JfXX7lT7mOig/LqYyRUPVyHHgtdPx7WAG72sU/hyFIy6FChWUSASYEWTzQ9
 8ILnSvboIIkCYLqThnNkw8V3cPexpZhNgZ59X3x51/4SIDgtJPrUdHZRd6cEBdkt6ybC
 fpozbmGJnrwIhAJ0dZVfX4WYKuF/7pDyPh9X/kDhenBO56Pvjb8faCyq/biS3xpp969i
 cdwA==
X-Gm-Message-State: AFuF++n+Jva31SKMMRqyFBo/GbjntCo4sIeQzqq042tWzwBTSuC0gbq6
 LbqRRKM+dTzJmTJTNJvWs8gaxnJCLkQWTXgK2+xwCx+SSvo9sRFONeh6wiZGumCXWo7CkxT6BVT
 K7F1FVd7JDMBsdztwx/Q6+NYvg8teVxO4TPn+Lrrl0n1whvs5uV6Nx0A2VgYudA9wuA==
X-Gm-Gg: AYBFou0kjYs27VKQMCcTzQ/WiQH+bfXvRG3bmtpJI4TdBCO1EQ2Jc4Fbrco9/VLUkm5
 RREh3QmLIK2jCW8Uou7yJIB0tp9prgzvT3C75bfRN5EzRN5/iD2m9X69n7XKjyeIQRvLsJnLUIF
 /RAhR3bQfkyWrvsC3GATbDkmdT8Md9HEuv/yn+LK+UNZW/pOg7eCdptgrtKqLDOieLWa7YRDB5E
 tWOar2zDYIKQhpf2ukytvdrPucQCeCwFUOOLrGzT5o6jD8dniMONz1SODF7UZ33GbZzJPWX+nHk
 OpHnBceydBotHJ2qNUZ702nL/fJ+9y0ncvdcwnKhoyUv39IeTlkI34uwZFwYOzbpTcCJxlpM8pQ
 e/p1GZPtadA4R4Cs0xMPqsZM3zl7K84eZn8CWm2v2JKHp21XpyOK1fHIieAdNpw==
X-Received: by 2002:a05:6a00:4b0d:b0:85f:1941:a9eb with SMTP id
 d2e1a72fcca58-87bbfb6c53bmr605336b3a.11.1790023801274; 
 Mon, 21 Sep 2026 13:50:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0d:b0:85f:1941:a9eb with SMTP id
 d2e1a72fcca58-87bbfb6c53bmr605319b3a.11.1790023800767; 
 Mon, 21 Sep 2026 13:50:00 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87bf5781b4esm51692b3a.3.2026.09.21.13.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:50:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] hw/xen: use stub_ss for xen_stubs
Date: Mon, 21 Sep 2026 20:49:53 +0000
Message-ID: <20260921204954.50529-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921204954.50529-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921204954.50529-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMwNSBTYWx0ZWRfX4V5R/u2tosa2
 aA4axywXnBQEZtSpNuYDs5rSIhRe+iSawvjhe8fJgdKSzp4Kr8AVkFRhHobITKNpqGRByphC9dE
 8/ogrtIJvu2qAmPDDTix5yJIQbcNIVA=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab1987a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WoShrNVHzPVctHG6VJEA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: _kotO-sk-pzAiFtRMTynzdqqU0j2JFcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMwNSBTYWx0ZWRfX7B46SoORzYml
 ELomWgnkf0Wed/f6ckPx4gg0n4K+zoCYSR5ATFWMGlraYQPrsA4qU/3wIRxh55NMrp0hlf0u36C
 mOB6FUechKwKPP1aWpNnSj45di8WPZJgEnexif2J5+mGCTBCrA0ojZFzHPNe2qVlpvDm4DHl8dM
 J2+YfPAluJxQwjxRSlPap5/BwvwHhfRQixhWLTBUnSvBfHWxnvGn0bQVA8q/Bqak1FOtOmzzM/v
 WouDmifMTIMwdIPN2NLRktNMbDGWlcYYv1+MXrrKfIYCU8IXZnvHw2agFMFvCSVkCyAIE16ywtl
 +c7uviubYN57mieiKY4XxmBCwg0iUX2tngd6GZoIJZcRveZYTUP6vOu56MXIdgPQeZR+cmXp1lu
 d0n6hMPW7ezchp5nIzgwfGPnbRD1xrUUAbui8WxOk0srxXLJSWVKW2kQ8P7Mfz5Ow+/J0vKtc4B
 TrnZetnLsSIbaljK48A==
X-Proofpoint-ORIG-GUID: _kotO-sk-pzAiFtRMTynzdqqU0j2JFcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210305
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

Solves these link errors on aarch64 hosts when linking
arm and aarch64 targets:

/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_hvm_modified_memory':
/qemu/build/../hw/xen/xen_stubs.c:17: multiple definition of `xen_hvm_modified_memory'; libsystem_arm.a.p/hw_arm_xen-stubs.c.o:/qemu/build/../hw/arm/xen-stubs.c:25: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_ram_alloc':
/qemu/build/../hw/xen/xen_stubs.c:23: multiple definition of `xen_ram_alloc'; libsystem.a.p/hw_xen_xen-hvm-common.c.o:/qemu/build/../hw/xen/xen-hvm-common.c:39: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_mr_is_memory':
/qemu/build/../hw/xen/xen_stubs.c:28: multiple definition of `xen_mr_is_memory'; libsystem.a.p/hw_xen_xen-hvm-common.c.o:/qemu/build/../hw/xen/xen-hvm-common.c:27: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_map_cache_enabled':
/qemu/build/../hw/xen/xen_stubs.c:34: multiple definition of `xen_map_cache_enabled'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:86: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_invalidate_map_cache_entry':
/qemu/build/../hw/xen/xen_stubs.c:38: multiple definition of `xen_invalidate_map_cache_entry'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:664: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_ram_addr_from_mapcache':
/qemu/build/../hw/xen/xen_stubs.c:43: multiple definition of `xen_ram_addr_from_mapcache'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:538: first defined here
/usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_map_cache':
/qemu/build/../hw/xen/xen_stubs.c:54: multiple definition of `xen_map_cache'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:468: first defined here

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/xen/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index dcd2b7e1df3..62767a5ea21 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -29,4 +29,4 @@ else
 endif
 
 system_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_common_ss)
-system_ss.add(when: ['CONFIG_XEN', xen], if_false: files('xen_stubs.c'))
+stub_ss.add(files('xen_stubs.c'))
-- 
2.43.0


