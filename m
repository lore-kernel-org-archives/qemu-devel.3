Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E8C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtz-0003Ux-LG; Mon, 06 Jul 2026 18:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtk-0002yE-Pp
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrti-0005cq-Ax
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEJV41639917
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=njAQljBk1So
 Zq7jlFoUvyfKmwhJk7Bxyl++64i6KDIU=; b=EmJwOsbjuBiqM/BbDkpw+MWpAhb
 0FQksxyweNfBEZZAFIkBeaDVL1BksbF932Q+IYS5HBXuQm+52d5E6q04k74jyMga
 QbVwXW1eY5QN8rBHsYVj0fezs44VRbmEALkaKuEWYvoeezuEI0Gq/Be5Yzxe03ur
 ILfxzMAaot76RT0KOT8iBrFHCAKdaEjHaVNfozXxnOtTQ21joRqNStM/k94ma6Hi
 Vs+PqquHtDKT7So7bKP93OiCOa6+yhZtOcoKn74Ws4Kfig5NgravAeYCgxujxE+6
 6b3JfMeDWaq+PXUSsczvxIXoZWHSuzYrQiMKYRa8KKc3pBlVqU+3X97tsKA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r34sn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88da04b719so2800164a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377270; x=1783982070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=njAQljBk1SoZq7jlFoUvyfKmwhJk7Bxyl++64i6KDIU=;
 b=IhMXlr5VIREJSjxsElCe/24RLEgWiZ1+CgUKzY0OOo4FurlbWVLbITYu62wpZylQKh
 VyasZk32lUk4Ke+BtSyHOcM7OLUQG8GvZJDPAlcc+v+YVtXdof6bbNppdStOwcCUZCVG
 W1JDoe0nFUyYGX4hzPlrQWSAteAr3T6RVddXIhu6KEUHxsNBlM/7ne+eKW3E95yra3Br
 GpQK7XWXEdnMiws1L0zA9PuoMExtREhc9Fjyk+KWVMbHjjqsuZ3bGbkwe7Y81pxKWsbS
 Umhqlvjbwc02vx2fsGwCcfWZVf10Qvcr+L+ItqeJz0lO3E83FNv+b2Ve1oEQDPPO520e
 tbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377270; x=1783982070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=njAQljBk1SoZq7jlFoUvyfKmwhJk7Bxyl++64i6KDIU=;
 b=Gk3PLmYy5KrD8uiYmRGzxE0xC+hP+qbMZNwms3Kw4SKq+Z9mqcqVC16yOCwfNL3H8x
 UXz4dTmafpQ1bvr3PkBTixaKhIOAGY1imAkRT4JFCni3P2zII8xdwkK9ul3zcrveZwkz
 vCvwcAjcMT7epaCCSkGik/9oNuj+Q15q04hvs3Ra5eg02tcj+faOQA2B/hL63e1rFajv
 y834dacuC0AVb+ziwIDLjci+PCvHSfA0Dkf/2DTlvsXnCa1V3YWzXJk+za6fL7uw6LFS
 O8ZFLnx63okezpfsuMv6m54RhRlqgnsjdP4Avn3P3fsD8dDiQ5LCbJx3Y0E7mk60lm1p
 TbQw==
X-Gm-Message-State: AOJu0YwycJrqrjJIzqLlQH+uwjexCCfBnv3OggQeWxUE1sT1L1Ge/bef
 xtKozbf6oar+Eo/5+G6vFahQsfPUMLb8vhOmxV1pCWhqls9hbJZGFZW7wvi7U2KoQjUlMtc5Z8A
 3s+Ne62UgPkCKIsNh23ReV7w081KeiXzUURDDtu4IsQltlixhJLn0nu8G9jhUyOTJgg==
X-Gm-Gg: AfdE7cmY5tKxvLvY8TmEWMTQqyfLxY6lwIInHCF4HSLqqUMqZG+nt/3bt8PKYLzzU9D
 Y1QackXWWx5Ik1V6KKpZwSShfUtE1Y7a0Tjr+jAEeB7hV6C6lR0W/mD4Xb7fr7ufNLMEItcgA6k
 cl2TG+TC9vdcPXwPob+63W5uiOGG5v9/ZPt8xPw5P5i3PEeYaij4IeO74GGruaad9UpIpP1WdOy
 RGRrXbczlFb/tAxJAuITUi/9c+sAsW2wVmq/5SAowCGRaGiPWV3Iou7iLdtqIMei++iWLGfwf6f
 U2vBwy7Cx3aXCPMxntc0e6CIGz2tk2kmURLVg61hNLQKmsOTuqVwSy0ajeCcOgevlSKniKr1421
 1ZHOWSXAHbpj4SHaJGB7KJ7lu3h+o4+dvETNFKZZ2yosFNoQqabA8LqMAgYSYSJTKQbuKcdzjEK
 2ETv4IXw==
X-Received: by 2002:a05:6300:389:b0:3c0:9c19:b27e with SMTP id
 adf61e73a8af0-3c09c19b36dmr52432637.76.1783377270416; 
 Mon, 06 Jul 2026 15:34:30 -0700 (PDT)
X-Received: by 2002:a05:6300:389:b0:3c0:9c19:b27e with SMTP id
 adf61e73a8af0-3c09c19b36dmr52407637.76.1783377270000; 
 Mon, 06 Jul 2026 15:34:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 24/91] tests/tcg/meson.build: move gdb_arch support check
Date: Mon,  6 Jul 2026 15:32:36 -0700
Message-ID: <20260706223343.988769-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1cD31KUEGMDw
 2IeM6beoumiAy5l35hU4g2e0b361hvUUDyGky7Bbsj3LeWc/g+uj8QmUSs97Q5B1QIQUJlPzH4e
 DLX/U6pshHK5MpMwdWVc56+mQyJHshTJG/LsdX5iLBu7Zke6SoJtTQFdfg6VHZgsLvyq7JmHCoa
 FRv30LmE+Q57VZLal1rQcmHxyuPOKvuaEDbngLejpnkTIZPwsIr6t3B/8ldDBJRS0WCvsqgpUry
 wvaeaLBvR9G3ReTLIJZg/fYPgyzfRganXe0woGxAcyPHVy+jyFN8lAQSCUNYZeR4ZUWvP87bJFR
 Vr6D90xJyE1wtqOsPCIlrGhXZAM0AAlsZa3NhbfygFXXOtWeBoxT9CDs5P9j6NJLBcAYoHc5APR
 LkeLm5ngUNywCJgYDIbe7GuysO1h9IB3d9j9Xg2FwYvf66bbN8R2sYW52qBRyFkoBkxMV0kjIKi
 KPjtwJtxdtbxW9A4M/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX+uF+pj7J/acd
 PDkEJTnqkE68HaavdFeI8Fh/eo483tT8/XPV4UT1y8EUN6pI3ZjMGq89UkUtdlAF9C6HcbktBLB
 u+i2+bqCwERk8EF880Fx/A9f85RmvPA=
X-Proofpoint-GUID: FinSe7IzI9IhJTHOt0FWnXzpu-RA2gM1
X-Proofpoint-ORIG-GUID: FinSe7IzI9IhJTHOt0FWnXzpu-RA2gM1
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2d77 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=5V58qdowex7Z-1UmhXwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3b1c72a0f8d..b6b7302ffb6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -139,10 +139,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -285,6 +281,10 @@ foreach target, plan: tcg_tests
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
2.47.3


