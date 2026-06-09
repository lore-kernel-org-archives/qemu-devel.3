Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4648CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JK-000780-NJ; Tue, 09 Jun 2026 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JA-0006sE-TM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J2-000880-QY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4hpG3229320
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eB9gQJ/zqc2
 gdrM6hrfSlTTB/7IAR6F05AkQt04CkDg=; b=CXK00vSYW2JOdwH+a7nKx/MUXua
 /AGsua1e81SCPJ9Prd5dm3zcX7fvU5usTYhu3zWxXN3iggpxPWATrHc99djoB/TU
 Keh39tjknWegEqmQeat7x2zYInC7lvBSEPy2hfeL9gSEb623E31yN4+vaEUDPhxs
 RIGhm3HMO/rmEK3cYjxNLDaxzJs6TQE1GP38ERP1AlGDCWXBnVY/VWc64li0tqSW
 NRRGNUAo7g1k6RQrh/YbapTr5H/2nBJ24WEEt26NxUi+V7kiuvKRhKQDYXfjXU2Y
 Q5tIMlyk5H/T9ROgCKBHDx7CGhkmES6FT2D4O3QxMCbls6aRAE7HA0XdSVQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13815cb1507so9024894c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041689; x=1781646489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eB9gQJ/zqc2gdrM6hrfSlTTB/7IAR6F05AkQt04CkDg=;
 b=SKD5qqf3ICjM2CWLuDxJ8g0LC7tJc2slEa62O1BXP47o+aA4jd5abMsiNmoUj4z0uC
 0sdlpYRJrEaW9ctVVSvWktbgDWXJkvnmPXD6g93nM5mQpHTIGPHf/XaYj+EjG5IuR+35
 CjucUtJn/DJthdlHGK+5ZYF8UKJazhgcHrrUb+lg5WBavBCHh3ZfbFymWoFBAV0dtfIt
 3xqK3DTaq0KSu13WDGIr1AGwfEp07GMpb1/mSlWs8ZrSardP3MPGVHZ1TQYF6fS79WNY
 o3unASQxSOUeZIIKT07q8+4exu8B2CZa1Kx5cHft1IL0uNyrLvfjLnFj8hW1eEwACi1r
 6Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041689; x=1781646489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eB9gQJ/zqc2gdrM6hrfSlTTB/7IAR6F05AkQt04CkDg=;
 b=RZCd/M1C08VmryaKhK0r0mB6RMSJSO1RviDKnONdgkHwkZqg9kSa/A0PMddp+44Lzd
 pWciNm8AHsXzS4NaRD3Irp3+qN4ZFUg3Crv1hjnCaEMvxrE8L3PUvY6CvDhuUWwAc+6g
 2uNPlxvVImPAUcHiGvQSXz34SNbe8pC+PXL19nTeN3tIk35WOpR1gmeO6KZmLaHjzGIS
 Fz+DdJgelktoyTka/bz8KaWMmcN6TTO/fuo9Dq9NUYuSTLFsY/eLXK6cadcCNxaol17J
 EMawlCrJKcUEIAkvwINsBLNSFIlf3P207gGewXKMFR4JbUG/4KtZ/HMuoO2WF9h0003i
 KoDg==
X-Gm-Message-State: AOJu0Yyo2JKHFP8USfcZPSE8mwqStU2dr/whktDVByGOmNAKU5XmYT+0
 qjEo2BwZM2dEcWoU72fwSTvUyJXdr/W8siXcJDpeOS6ikJMLrRJZy5z2OmqjddzKPpXuVZmjDm9
 chfOWBHDDuUfsCqqBnW9hCEDmxlh7wsW7mMWT1hxIfaCjcaHMn3I6t7/YGZj6VmUfzOzI
X-Gm-Gg: Acq92OE0+DlyDQAyudNGWzflhn/bVkzG4TlRVqgtfZh2Jg727SjQgTaRt29WETuRPcD
 xowXyxRNHFRPJ1LP01l3fSdbC+hJ53IGArHtxzcJQ6w1yyJycE8enA3a9MoSXHtrBCaz5UwrD+R
 SOp0C8wKAoUBmh0Gkx+l5sjRrRmM0ZQE/GqHEXzEQV3La55W/g6QDiFb0sX42GxzUHObexJxLXs
 eJahcHFwPLVLSopekQcExbTvzzsCgsvbcsw1pKkqVwNfBi1Cmu9GhUVlXmgd29ufwLT+5CyY/x7
 eOD9a2AkLxmHB6MwwT7FLR3DBal8rUiws4fLLdn/7Y/is9UoOFrQa64Pw+zv9UCNMInczcvNpKE
 al2HCQF9+syUUs2Wro5a71bE4hX+T1MmIrubBPHHzvuwOnsiGjhidFqwOhdLgMH6LsQcobVQTlf
 NyU1jrhmokzfpu1Fbf
X-Received: by 2002:a05:7022:f50d:b0:138:14dd:16c6 with SMTP id
 a92af1059eb24-13814ec5acamr5581094c88.34.1781041688796; 
 Tue, 09 Jun 2026 14:48:08 -0700 (PDT)
X-Received: by 2002:a05:7022:f50d:b0:138:14dd:16c6 with SMTP id
 a92af1059eb24-13814ec5acamr5581079c88.34.1781041688195; 
 Tue, 09 Jun 2026 14:48:08 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 15/27] tests/tcg/meson.build: introduce wrapper
Date: Tue,  9 Jun 2026 14:47:33 -0700
Message-ID: <20260609214745.772536-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX7Vun/L+SU0Hj
 2HCB/CWGhSXtQKvMC8STLOpqNAZ2h8omE1SZwaPs6N8OIW3pIGYvwmq3D+yhfUClOdUKp+6ZXze
 FS1WhdRGxAvk60d6mXVuyiQtBJi2yFw2IkRSNGR3Q0/YIgXpoP+AqVezRVkv5Hh5s5ExJ4Y3uPh
 /RwAajm2ZZNqbyfFEVY46mr3V0ovXKqB4RNw8vwemySNBQd0Roxg+Mqx6sTkMIgcqkmhc2Wi4nY
 T0mEFxxCCyuDL7hRGrE4rRWjdHzRh1PpmZvkkKHfYHpklJv9BNLCHiDFQUp/F79gdYB8JiG3J1O
 Y1P5tR9CZY+0Wz/XluU2/x/WSnNGETsPgIzym+vExBkTOlVbIJbjodrxSpGtixR7sawF+mGvHfh
 pK7CXQamJm/gBRIJ3TDgxfdsnw/IUj5ubxP1Cki1a2kEFiBu4I9ywFdwcEWF+mABqU2wgqbAhuO
 NIHMBHpZo9kx/OSPebQ==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a19 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=OYW684dsqC6DhUYTEDsA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: Jf01CwndYKc0JSaw1ukBR-WTaf12EAeR
X-Proofpoint-ORIG-GUID: Jf01CwndYKc0JSaw1ukBR-WTaf12EAeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index aca59933d71..5380a360830 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -85,7 +86,7 @@ foreach target, plan: tcg_tests
       foreach key, _ : setup
         if key not in ['cflags', 'qemu_args', 'gdb_test',
                        'exe_name', 'test_name', 'env_var', 'plugin_test',
-                       ]
+                       'wrapper']
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
         endif
       endforeach
@@ -196,6 +197,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.43.0


