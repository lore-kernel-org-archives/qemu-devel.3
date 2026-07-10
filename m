Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ11-0004rG-8q; Fri, 10 Jul 2026 17:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0z-0004qy-Qh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0x-0003OG-Qp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3WBj1752857
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lXVGlYz0DTP
 EroHroj86/br4bW/BfcatYJoHWR5m8SY=; b=YTw0hxzHeygihMvNp15u5T/3jNM
 gA91H4nyLFTNQZkU3kK7okgqJsP9hcqgLzG2WHk8MoKEn6/ZS+V4IQABDbeLE/yy
 9BjLy5JfN538RJNgGTkbIdBpdNhUAmg4YwJ1lb9eiIvnwfk3G1y/9FiRyjPVJr39
 REmoiUwc/N/O8yoTibe+kDwFajxWTobreDINo5ghJROIrTT7RZWlZA02Eax1kyN1
 AtBJePBtHVaVlsj23pTTUujxae3VrqN4qSbPUWUVJEFTPTu7wWHIojZymmKCBP8F
 9W+KIqwI2p8aXQYPZMFseW9a4inQ/qrwUEFhudB/+YF4KdUUp3JoC9I/tpw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8895156101so2004434a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719846; x=1784324646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lXVGlYz0DTPEroHroj86/br4bW/BfcatYJoHWR5m8SY=;
 b=Y7JU3vpBt0lu7xV0jiPVWFmhmL3a9GmZkUFix16puIaBz3cMYrAr68UXecIBMFG/lK
 hOTx7BxIkAGi+iW8tInqcDP9DfHDCxCcRMFsUYjuDflH8jJRN/3PBxU+Elu3OwW4JOO1
 8dqUZ/GiDWnAWIgfNbnuQvx5uYn4OlMzKB/sb+1EuHCpNG5fWSrZ4PpL+NdYe0TsAB8s
 ewUOrJdlkffbcgGnn4ZNQ0QVdNchRi/alyZghQIzIjsnW8QCNaliUbXX+kG0tGt9oX2T
 Thxs1/cPjfy/jEqQHQr4jj1+Dhzoap057MruQTsH7SK8PQGvGglqatRi8PVKxOcRzuKz
 Actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719846; x=1784324646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lXVGlYz0DTPEroHroj86/br4bW/BfcatYJoHWR5m8SY=;
 b=HuBlB8hHcECE1DurQwxPWVlhRO9yYvV3jSM7pcFegWhl979CgVpMXWMFua0ZWyuAhC
 Jmy6cALS8KS6AtinlA2/PtBAhjvlb1pjzrmGBzp4FrsQNfy1RGykCgNdpRCfmnPfdt8u
 LQMlDOJmy1zGj3iZ0PrmLG5JuJl2TuuOcyd5uGG2ZRFY0vuyMTbRTIX0jULrmOk+v6D4
 3Zd9f5Jptnufg0i1inM5i6QNwBpZE6a015snt166OvHpfUmrgA58GDx7pI0RU1WX5+pf
 CqmSK/i/BghMcPnXXRnTAUoLOJG1+P2fuz8lPe9i9nsx2S5i6X4FwQbRXOLFZfu1gIG0
 g1oA==
X-Gm-Message-State: AOJu0YzratwJuJ4pMlRIFQaxZXTda6p6BbpWSKCSGSLvZViT9yO14CWN
 o0mSXK9pEC+000UQEEW6o6cfLKIfSXiRhTjyspx5gOrEjDwm5eeEfyE9ZE2X39fzMdOZvz75K0V
 wU2/WqT5TQVbMz1piL9YDUTvPB0JQps8PqPChmDwEaBJUUWSPQ1YM79Tq9oisIU1LcA==
X-Gm-Gg: AfdE7cnsUFFj2trhMx2Eoxu45GWylez7rEWVG8aOVuBfg4MDoJd39MX9FgnwG//myP2
 gu39MueKkObz3HhdoxKDUa1b1pNzd/kNO1HA2wq+hK0aEid4JyA7dvN9qAsI33NK+KZU8jfZzQE
 3rCYZGYz+cmLg03fgLNbTZcwk3tp53IQ6rjVrlMBmRvkY2gg/yWyObL6AEYVWnqCyOV+M6Novhm
 V6GK8zNXyNNiS1bBXR8x208JYwuXCFOuFpgGpQtM+quXzG/JD6RNBMGkczh/lm1F7m9lkzjdnuH
 8s2/Nx6xH4S4xIAHCKCAnADCWE9mg1lFKcu9/t8tWJO/uy2Bw6ZlYe/w3nBc93z2TI9V0jDKgbO
 juUtKw7095gXmI2jx1pe1gASioZtnPD2fdffPOCRObpD715tPL0wNMUEZkZBiFDC3BR0NvtdqCa
 zL7A30ew==
X-Received: by 2002:a05:6a21:9203:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c110a778d2mr702863637.75.1783719845767; 
 Fri, 10 Jul 2026 14:44:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:9203:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c110a778d2mr702825637.75.1783719845175; 
 Fri, 10 Jul 2026 14:44:05 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 04/98] meson: bump minimal version to 1.6.0
Date: Fri, 10 Jul 2026 14:42:08 -0700
Message-ID: <20260710214343.2065491-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX5JEdZ+B2l+Nf
 2h3DlmZu+3BJXOo0LlKke5KbDDnIpRI8pJH3PhINsO7q7ui/oXYdn6B0sy8L8wfEqm9Q7Mx8Rwq
 CrjwzLsqVpWD0W7nhAf6JH03i4GlBLsow4OQ3Fhc3DM2RirIcBH0zEVrlhNZsYfVEY9oXNKGYUp
 LkYqX0PAMaj2aC8fD1yCvYbrnX4ZqFvLlKDSYm/aOa/2ITzfrW7g68ZvSDsOITf1Fu8k+1neqI/
 18yFJt5a4qaqQUehy9786BqZM2fQ39G8f5AD5Osa438YUsNMoNUmmB+OSMaOAjrM2LhOqWiRhOa
 IpCRnhqDoF4JQ5RnAi0lK3bANW7eMY2f7yWj/NIdDorGdWwY5Au0sJZd4neOOEiHPhMmkpfAzzk
 aJRudYtJDs/Mn1kgtzc8TuiIbv0SLIG5l22QnZpnLqxaF476R/xtAfDQnNbdxd63b3u2KBxG4xL
 ttLWAghLfGQaMIRNlRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX2t8qOG/HMtGV
 WUeKFfFGm/YCgKp2cJVztjoRU1l5aWgIS6n5weqIX9zrIOjV7sN1U80rUtMIyzFVV5UXw1F5frO
 imQhW95P3WwlrsUnFIympyqS6ybG9+U=
X-Proofpoint-ORIG-GUID: KJLuHcg0GLefxCX5OMgrHyV8fLkn2TVB
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167a6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=OdLkAQov_zCaxSa-YWIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: KJLuHcg0GLefxCX5OMgrHyV8fLkn2TVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

Without it, we'll get the following warning:
WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
 * 1.6.0: {'test with external_program in args'}

Which we require because of how we build iteratively our test command
line.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                                                   | 4 ++--
 pythondeps.toml                                               | 2 +-
 subprojects/packagefiles/anyhow-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/attrs-0.2-rs/meson.build             | 2 +-
 subprojects/packagefiles/bilge-0.2-rs/meson.build             | 2 +-
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
 subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/foreign-0.3-rs/meson.build           | 2 +-
 subprojects/packagefiles/glib-sys-0.21-rs/meson.build         | 2 +-
 subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
 subprojects/packagefiles/libc-0.2-rs/meson.build              | 2 +-
 subprojects/packagefiles/probe-0.5-rs/meson.build             | 2 +-
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
 subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
 subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 164328ded83..fbb7d4ac6d4 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
@@ -1382,7 +1382,7 @@ if not get_option('zstd').auto() or have_block
 endif
 qpl = not_found
 if not get_option('qpl').auto() or have_system
-  qpl = dependency('qpl', version: '>=1.5.0',
+  qpl = dependency('qpl', version: '>=1.6.0',
                     required: get_option('qpl'),
                     method: 'pkg-config')
 endif
diff --git a/pythondeps.toml b/pythondeps.toml
index bef88d49a6e..e2ee450ba68 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.11.1", canary = "meson" }
+meson = { accepted = ">=1.6.0", installed = "1.11.1", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
diff --git a/subprojects/packagefiles/anyhow-1-rs/meson.build b/subprojects/packagefiles/anyhow-1-rs/meson.build
index 348bab98b9f..e82b1f20bb4 100644
--- a/subprojects/packagefiles/anyhow-1-rs/meson.build
+++ b/subprojects/packagefiles/anyhow-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('anyhow-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.98',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index 00733d1faab..267357fa912 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('arbitrary-int-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.2.7',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/attrs-0.2-rs/meson.build b/subprojects/packagefiles/attrs-0.2-rs/meson.build
index ee575476cb2..9b76fe0f73e 100644
--- a/subprojects/packagefiles/attrs-0.2-rs/meson.build
+++ b/subprojects/packagefiles/attrs-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('attrs-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.9',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
index ce13d0fe80f..4d4c9bde404 100644
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
@@ -1,7 +1,7 @@
 project(
   'bilge-0.2-rs',
   'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version : '0.2.0',
   license : 'MIT or Apache-2.0',
 )
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 04617b875c5..57bdf30ba05 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('bilge-impl-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index 04c96cc5fb3..d869201e43e 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('either-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subprojects/packagefiles/foreign-0.3-rs/meson.build
index 0901c02c527..80e68967ab4 100644
--- a/subprojects/packagefiles/foreign-0.3-rs/meson.build
+++ b/subprojects/packagefiles/foreign-0.3-rs/meson.build
@@ -1,5 +1,5 @@
 project('foreign-0.3-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
index 8c5483311ed..b9ceb12463f 100644
--- a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
+++ b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
@@ -1,5 +1,5 @@
 project('glib-sys-0.21-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.21.2',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 2a3fbe9ee5a..3081639890b 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -1,5 +1,5 @@
 project('itertools-0.11-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.11.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson.build
index ac4f80dba98..d1a9da194da 100644
--- a/subprojects/packagefiles/libc-0.2-rs/meson.build
+++ b/subprojects/packagefiles/libc-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('libc-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.162',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subprojects/packagefiles/probe-0.5-rs/meson.build
index e6ea69533b7..1d33800cde2 100644
--- a/subprojects/packagefiles/probe-0.5-rs/meson.build
+++ b/subprojects/packagefiles/probe-0.5-rs/meson.build
@@ -1,5 +1,5 @@
 project('probe-0.5-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.5.2',
   license: 'Apache-2.0 OR MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 8ba558e1330..523572173c7 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro-error-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.4',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index a85d7c07143..85f190e56e0 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro-error-attr-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index ba7de070292..7cb4f93bb08 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro2-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.95',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index bf41fad99bb..fdd549e7648 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('quote-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index 3e6dc318a9c..a7baa6feff4 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,5 +1,5 @@
 project('syn-2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '2.0.104',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 11a5dab97df..ee483e13423 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('unicode-ident-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.12',
   license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
   default_options: [])
-- 
2.47.3


