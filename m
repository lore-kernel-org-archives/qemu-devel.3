Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931E0C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x74am-0007hL-9U; Thu, 17 Sep 2026 01:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74ak-0007gK-FQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74ai-0003zB-LW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H2IBmK3238103
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9u8hm9OXCNsOjii0Vsxtf1al9O3Iakrbq+pZflTi7ns=; b=d49LU0yTmJGMi967
 1bZY+yHPgslVqwI4RxcbEXUEOhGBzh7+QMKvM0TIjA18ffhhOEEP8Pb83mFQPE2u
 Xz+Zi5usW7X+zxIIp4WoblLxbZettS+vnQzG2w1eXygkBec9sKiw3C0RPh/UaB2s
 tPEONMCgfwuzf8cqRnO2fj+UVjkCTH6HpWgzNJ/KtlLGc1ZKIP1ZrVUnkbUU0TPe
 2z+rhXgLGjgt68xCv4gWC2KrwdrIOvo/wP9/5hEqUzCPrZmm5Vf0V5vMW0gchl3/
 /jGMeKIwvh6fiHLvddfwY7eo8eXnNA8TZMI6Enjt9fG/dMwr4CcZh5ySoH23hqQd
 uWggqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqyga2cy6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d0e306c7d0so1265245ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789622601; x=1790227401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9u8hm9OXCNsOjii0Vsxtf1al9O3Iakrbq+pZflTi7ns=;
 b=KGTbA5nr20ZDzRdcxdUCOZGAWZyiJBmzpOmLxzV1r0RWVHTnWmG06Qzh7f/NK8bTfY
 +2z2bYJ/Lgz+zi5EpuF6z9gNyKGJvO0/cnaqXA0iMJCOkZwKiEXDT0txf7bfgQ8SFUhs
 lea6RVNUG8Gjx7M8dpUxhUUcCFw1IxAdQArXm0rnsKbHNNmCy5rb8OSj3qtHySaruy6s
 ZHakWYSotGfAVuvoDyql4FJIiWUezunVV4ijZ/u9nWXX2CAos4Fe0DKZT2o6mZcsbQ/g
 opMaSE3OClaZ13itWIc+n3iUVrON15cQ/1al1Ej8jFJ4Nuor2Ee2sajTc5is21s+b5xK
 PYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789622601; x=1790227401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9u8hm9OXCNsOjii0Vsxtf1al9O3Iakrbq+pZflTi7ns=;
 b=WLUyNiQJF142pS7mvX0xIlK+6S4Y4d99N3fadLggCXYtPV95HgHOz72ee6rkIDVgMX
 +Ehw4UTcS/Ni8Ah/rMtYiAGjcgu4XdB/mbzKuqQkhsOpgRsjkyK6D9pdjicXrbre5hNo
 2dnU8EMRGYUBt74WZcPXZmb99EShfsbK7eYdgvBbqabs5C2j4WJeM8k/PauaFAGzVOGN
 6CU0eGi8MVLzSulmPFkVV5biQeaT90ll0xusvqeheyWtRY5cOGf6QkbUxnMa7Htt9A4f
 45/DHmBYmkHC7vcq5W1KNBNTKJtyQ0Ssw3yQGGvljYdkt2X2XF0Ez6QiTN62aQZchHB6
 946A==
X-Gm-Message-State: AFuF++kUVNh15dxHieO7mowxNUlGaPotrS0OnAl7ikyRt6ByNrgg41DY
 1Z0hwTnwGCuW3z3M79xcmSorYJfdEpfMHR3nusQvkiZ9hfOYoWCt8kJ4Gu0TRFlbxBhunONYdlh
 vrqZhoZZMFpVuf1OUD8FE40kVGJVQv8xzt6SknY7FY7nPoJ046weTcD5gUZYDt16ffg==
X-Gm-Gg: AYBFou1GArPL989LcgFzfistl9n8UMjSHn/BFTdSxDYUv2+7kZYHsfB3nqReLpZcTsD
 7I1d3IRrfMfzR0WDeViL2pDYa64MvyFwPme9mIJNxrrpLCdqOSHw5RCzpVqmjH67ZcgpTnFOu+W
 QLBPec3j+WCakQtxHpp2uR5/QxHCbNX3ExEsYJtQQLse235fugly3jKGLUmDYqN0eBBNZK3jCsT
 8NNN4ggqUVGj7bF+IIWM7xlN4WwOOPsyZsmYP3lT5UaOcVVMlONUQVVDsoUMfP8QXc6yu08KFyt
 +qVlg/EE39rjTMpy/y/nRSa5uFq/X1E51VxeqYjQxapEJkGBbmKILevrtosLFbqwQAjpGJeaP9b
 DbXRQGbwpd2q61eyDzkgVCONJJ6K/331LMGVauA572AJ6DD0Ul048aDUUN5tOJjewQx/XBLiSNY
 UK8jj4xQEnD8LpTwnO+pLctXoEv/imsFQ=
X-Received: by 2002:a17:90b:2250:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e1e5285d8mr7859177a91.5.1789622601284; 
 Wed, 16 Sep 2026 22:23:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2250:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e1e5285d8mr7859141a91.5.1789622600736; 
 Wed, 16 Sep 2026 22:23:20 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14256187eec.24.2026.09.16.22.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 22:23:20 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v11 01/10] build: add optional librpmi dependency
Date: Thu, 17 Sep 2026 10:52:40 +0530
Message-ID: <20260917052250.1041262-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FtCSyJyVCs0ho6VE3AO6jvmfT-WVAorN
X-Proofpoint-GUID: FtCSyJyVCs0ho6VE3AO6jvmfT-WVAorN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfXwpQGgGrf00pC
 J8aSbvZhsyV6h2XAQSv9Km5PK+8Unnt5zCwXqaWzL7FdjVu3I7Ithk2NOdFsOlak9n516dlugNT
 VwzlgbKXi3uIW29unbeBBzHISVFuQ8M=
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6aab794a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=8ots_n__tzfDkp_RMYgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX+EvfyaWrN3zh
 2ljJclMUbik/HFCiVtmcbbGSJlClDu4hyUotFQmM6JkPyJnDB8q2hXlr5kMpiPR9T0L8YH+4uVk
 /k/lC//6v4qqPkHzZLsGkl4fDe8c3K0dRLzXJV8D18iVfjAPaCtnhnT7DlHzIwXHsGcGH2Btv4V
 BJEeVgIxAK459DCSJHJLXTOb2rownPQq/LHuwmOdCUIUoPXupyyhYEZ6aYLua+kT4lrFK6Y3Zwo
 qrgz2K20oEldMt+bh4oNdrAgGYj+YWIQDwSNEFbNQSiN4QVbLPDAzTbh5W7wHxR3Z6rmRCXnJk6
 o+LgZBr31jThK5HeyKRueCOnH5NslTgKUCw5vj+83tbvvQaOc2zIgPvGG6cVXO/7b6awka4j/rY
 v8z2cv356LZ2K5f7LbBv80LL2PEdEcigOjYXxtTTS2ZYnowUr8S5a01rfaf7OiL8/anlOVf112W
 2rS3aZVTcP2k7Of9Bag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a meson option and config probe for librpmi so RISC-V machines can
opt into RPMI support when the library is available. Keep the dependency
optional so default builds without librpmi continue to work.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 Kconfig.host                  |  3 +++
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b..6f98dadb2e 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -8,6 +8,9 @@ config LINUX
 config LIBCBOR
     bool
 
+config LIBRPMI
+    bool
+
 config GNUTLS
     bool
 
diff --git a/meson.build b/meson.build
index 6dcfdceb50..1e1e19e655 100644
--- a/meson.build
+++ b/meson.build
@@ -2018,6 +2018,17 @@ if lzo.found() and not cc.links('''
   endif
 endif
 
+librpmi = not_found
+if not get_option('librpmi').auto() or have_system
+  librpmi = dependency('librpmi', required: get_option('librpmi'),
+                       method: 'pkg-config')
+  if librpmi.found() and not cc.has_header_symbol('librpmi.h',
+                                                  'rpmi_service_group_syssusp_create',
+                                                  dependencies: librpmi)
+    error('librpmi support requires the RPMI system suspend service group API')
+  endif
+endif
+
 numa = not_found
 if not get_option('numa').auto() or have_system or have_tools
   numa = cc.find_library('numa', has_headers: ['numa.h'],
@@ -2440,6 +2451,7 @@ config_host_data.set('CONFIG_LINUX', host_os == 'linux')
 config_host_data.set('CONFIG_POSIX', host_os != 'windows')
 config_host_data.set('CONFIG_WIN32', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
+config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
@@ -3272,6 +3284,7 @@ host_kconfig = \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (librpmi.found() ? ['CONFIG_LIBRPMI=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
@@ -4988,6 +5001,7 @@ summary_info += {'TPM support':       have_tpm}
 summary_info += {'IGVM support':      igvm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
+summary_info += {'RPMI support':      librpmi}
 summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..a65af0e633 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
+option('librpmi', type : 'feature', value : 'auto',
+       description: 'RPMI support')
 option('pvg', type: 'feature', value: 'auto',
        description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..12179f6024 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -140,6 +140,7 @@ meson_options_help() {
   printf "%s\n" '  libkeyutils     Linux keyutils support'
   printf "%s\n" '  libnfs          libnfs block device driver'
   printf "%s\n" '  libpmem         libpmem support'
+  printf "%s\n" '  librpmi         RPMI support'
   printf "%s\n" '  libssh          ssh block device support'
   printf "%s\n" '  libudev         Use libudev to enumerate host devices'
   printf "%s\n" '  libusb          libusb support for USB passthrough'
@@ -376,6 +377,8 @@ _meson_option_parse() {
     --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
     --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
     --disable-libpmem) printf "%s" -Dlibpmem=disabled ;;
+    --enable-librpmi) printf "%s" -Dlibrpmi=enabled ;;
+    --disable-librpmi) printf "%s" -Dlibrpmi=disabled ;;
     --enable-libssh) printf "%s" -Dlibssh=enabled ;;
     --disable-libssh) printf "%s" -Dlibssh=disabled ;;
     --enable-libudev) printf "%s" -Dlibudev=enabled ;;

