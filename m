Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70DFC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2zA-0007zd-2i; Wed, 12 Aug 2026 03:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2yr-0007xO-Md
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:02:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2yp-000102-VK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:02:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62DOV2992703
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NaClFsqxS+TPXljZw7gIEM/IeT0qj7A93m7IQOhOzMA=; b=Uvyjnn7CNrAALnwP
 +Z7t/yMxd4k197YMM/bho/jUKp9vHpfcGmGMn8y/Y/ic8QKk87XJSDG1hL3kcimO
 hguXT2gsYxfT2OsQM8VhGvDNmUL/JKJk4/fyAL+x+K38pPTbv4Br74+9SEGahuFc
 dJ2V7SZtPNqI3ScuYlUiV+M02cL7rxjscqk30itXE5FG1IkpTSV6tcpc6RxDQoq+
 mjULPp6c2mGLMr3KQ3rx12ZcnwE55Cc891I25yBeS0dK/dAZak+vtmWuRM+rkaYZ
 uLLPhKI1WVjH+5OnkQVEu5O6USeZL+49XPwloEsFz8FVaR7z5K+aJMLrHwTL7Ciz
 69Q0Iw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049dkxkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ceb3d20b7cso1833595ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518145; x=1787122945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NaClFsqxS+TPXljZw7gIEM/IeT0qj7A93m7IQOhOzMA=;
 b=GxRJvjH+TOmykFylK2JuiXmuOFnDEh3//0q4d1H68gHAIGIZDgTkjKgIKosRfJkcmR
 AUCzrYuMU/KyCWofi8NVOAy54XcT4M83HjuO1ccFOVRytQ3d0X+RL36MvsnyjBFxIUM2
 14MZ5rHxUO9EIBIj0Nz8yC4SW49nut5Ak1quDibp2r9ArLQaS0va2i/eqfuJ+BRZthmW
 OdRnJoxOQ46iqjVqyipJFo+P3TsaYDPpRWZOfXUS3IfY4335Cjuogg7MtoBtsLfSbPlF
 U+xk7+QOaHFlSOtCr9SSZzbdLe7NUbP3khWswHbPYG0ICk5a5JHSTRN3KqaO0ixR0cyE
 F3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518145; x=1787122945;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NaClFsqxS+TPXljZw7gIEM/IeT0qj7A93m7IQOhOzMA=;
 b=BIkr6/s/EpWaQMjV1LLnwMpDwxue+fA050cEcIKl4sDSZv4HAfAQJLhSWUHmulqZbT
 RTGM2YIlpmXbBDc3ETZcS2iVLfsbdPb5hcnN2M1zvzBFW0Bee1F4h3N6dzpZ6L1F3Zr9
 Axrt1Qxsljn8tiEuYgNquk49OmKtI6MfkTSNSrOkng/F88t/ursrhri8p05NSAjL1dPZ
 AWukiqP9WguVJnfJez9gQxFKqGHSx4iYL2X3UInDyvdbqVWdwUA5PNnE3wGrs0+I6LxN
 93yncI3LJyBEUEMx/FII138zoyfgkg32IDocqfXl+6iDN8iuG/FH7qJUfeL7/Ksf3Q/D
 LoYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQ1MFEXUWW6lZj7fx4WcvQm+ni2xVCCqGr63FdhXCdwtlsfTS36afv+E2tdv3q3yO8nSfFr5JXS8i/@nongnu.org
X-Gm-Message-State: AOJu0YzGctvcOL1Ppc4kb1rFCIT9oKbQOzuWGuvR7GY81wsow2uhSPw5
 3gA5xbBvG7c1IG4zFQ9Mg3GwM0F1dc5TmzfojvuxQPVmRqPr4ekv6+R5chLpTHJKUmpjutgx9EU
 i5ujqzR0XhhoGD2Vg5Y8frbp0x6C+zH1yXDtWnIJi1fK4urlhniy9X1tc/g==
X-Gm-Gg: AR+sD131D5eGUEDuOKdihr5uVvZ8qvSyQ55Fex6N78GNn86Tpcdmx+o+4WmWYw8mrvL
 5i8S18Hy/FVAFlc5bxHu4ROROAmgAxzO66uffy0OtGe56Li6HMYcuBn3oNhh7yzkglAIIgNhdJ3
 Djv9LFjqoEwWLwISaNu5b4C4ZBRkdtpE+dwPCk8dK6eGTR002SLXmBh7oi5RheoCXky3DVl5Shz
 Sl3EWD/h68J24KJILWoY1b2d3sc5d78nEydSogcs2QAwzASwI6VhdmPe+MAKeF0dM/17exZdCCR
 +0dTq1Wf3rN9PjpfuLowI9WzExnotb1lYE9Wfd4oQfjTzlkgJnNhvZ90f2QeBXYaK914ZtNGOSK
 cJNcyJx4Th2yHye1STMLx9x7/X0r7q/QqzXWRwuzzCeLlc4+9XVlhDx1zKkMsIX+GuYUJZwdt9g
 4FH/eYYQS8i+R4i+/a8Z0ZW6E82noRKsI=
X-Received: by 2002:a17:902:cece:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d34568ea34mr26747275ad.3.1786518145347; 
 Wed, 12 Aug 2026 00:02:25 -0700 (PDT)
X-Received: by 2002:a17:902:cece:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d34568ea34mr26746865ad.3.1786518144899; 
 Wed, 12 Aug 2026 00:02:24 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf3c08163sm6796627eec.7.2026.08.12.00.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 00:02:24 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v6 01/10] build: add optional librpmi dependency
Date: Wed, 12 Aug 2026 12:31:23 +0530
Message-ID: <20260812070133.3059679-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX+Jbbo9mnTLt2
 0l0nrjnzYpAUqAgR4aCzL0AUJ+xysT424vbCGrdUbq1UYrf5Sd/iFU9iZPW0Hdz+S9HIXCNSSOS
 ALDuTYFEKnWjEYSn8vp2iSIRFanx0U4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXxbE25oNciOsn
 CcwVzRnViRij2lKNFztJHD6zgIKm3bmI4+/HHkqhtMmIbWA4g6NMqVczFZPebQdMEFbhY6Bjr0J
 wBaf1lX05iHmw9LZxi2wHomb/9YcllbqtPTp7Tj6xeuSDR+Ce9HLap2kcyyIwfuhO81eWkRR6VK
 S3NdutRqr/s8mj1PTPajMHjsZBhnKlfVNf8waNRuBvhtTDmlTVgeKuey0loajFL2TWP6IjzmdWt
 eBlPIdtadIpTmaYgvD++a2Dl69jKwUox0IQ8OFokSAiVEvKeV7msdJHd+hCZaSlWlLGzfpv8XIL
 ws5QXPd+ph4XN6c2fGOvcdqDabpKVant97M6QcqeGkmXB+pYd12kFnnrctxhtoXZtUp8HNfhjN6
 pHWa8G5Fdy+J3461K+T0NpDOgRGWWFcwADznHctkBTfvbF5f8NIj/aA0J9yKoiDWp0JFos1vn7g
 3Dr8w4ay3axxTQ8FjIQ==
X-Proofpoint-GUID: clv2i_lcnYh3IDD-2eYWuC8SdDv4xXvN
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7c1a82 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_6tmRKQHnRYSWcN6IbQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: clv2i_lcnYh3IDD-2eYWuC8SdDv4xXvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
index 19e123423b..272872602e 100644
--- a/meson.build
+++ b/meson.build
@@ -2005,6 +2005,17 @@ if lzo.found() and not cc.links('''
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
@@ -2427,6 +2438,7 @@ config_host_data.set('CONFIG_LINUX', host_os == 'linux')
 config_host_data.set('CONFIG_POSIX', host_os != 'windows')
 config_host_data.set('CONFIG_WIN32', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
+config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
@@ -3258,6 +3270,7 @@ host_kconfig = \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (librpmi.found() ? ['CONFIG_LIBRPMI=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
@@ -4971,6 +4984,7 @@ summary_info += {'TPM support':       have_tpm}
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
-- 
2.43.0


