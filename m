Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA5606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GUOczB0F;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bpfg7f5g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmCE-0002jp-TX; Fri, 13 Nov 2026 02:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmC8-0002j5-4B
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:36 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmC6-0000BQ-9s
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:35 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5717W367205
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VGV1KWy6owz
 cRo+p6zTE0Oo94CDkgww6jTyroYlmkBY=; b=GUOczB0FLPywA+BUWqLKt7n4HMN
 eJs5mmYwhqP4szqnOTFeRk+2PNJINliVR/SEvlFTZT7t+W2+EYdA9UE/hP+/wipq
 KCj+IMrBH+1H4FKrKMgf6vDYprYm5tEf/YjI00vsNbCQb1D+TwC0PapbiQE6k2v0
 FlNvD8tQYJCijD+lk0xQwR3XmGIlCsJlnwzbkRS3DdgLvTtB1UKrnhGNhdhdUGbu
 mHEH+/WWXwVwUyd5DWviAkY87fG9VEXQFTIl6owY6lCKIgkzVRPaoUg/Kum/c+jo
 v+rH3cX6Bmnz3m0XTtngEE0tfxlJaUmvmXvjFRyW1mz9ioVOvQO3dLy8Zjw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx344pq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37233fa9a08so19012eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556770; x=1795161570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VGV1KWy6owzcRo+p6zTE0Oo94CDkgww6jTyroYlmkBY=;
 b=Bpfg7f5gIoa8iX07+ahC1Qeh12TTqjSTTTqXuPuVqdjSzJ/K/1M0i4N7iV0tVEuy22
 KmWqnAvw2lKrdW0q0yyDZGUsHyPzSkdN+d7UfE+0+MTPz29apbZiR+5vPVETIy+EAdjk
 qcpyllPThuSmjUmzMl77gSK6ksQoBALeO3i6UyehxNwYDVykhf0lFQhGQkC2Yjn1IfEt
 ocFuvuL8DS2GqtVF9eaCgGC9bG4beYJYimf1AJyR/CyKySvTCzYN/ksp5qUM/3roVYxq
 lKQF0DgaTpf4JHmWck6jicm6Zwl3rLBiwOPTh4BbCZMEnPbA5Jfz+UVuhvVQ77KPpzYL
 jOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556770; x=1795161570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VGV1KWy6owzcRo+p6zTE0Oo94CDkgww6jTyroYlmkBY=;
 b=DuEbkBS/RasS8vpTqrBuDw5cF7xDvstnlF6LjHITEgKt3bwAWoHprKJsZkLAJte/KX
 5OC5+R00on0bRyBkMcnoTvcsemJKn7HSQgH6/wTYotz/zs662uga0Xo5Nw9EHUU9em/S
 Shu8/7xm16GqZ00PbaePBYK412hAncfCmvEWZ5owsqqA6IbUiT3vcINyfMKYswxr9xJD
 qACLDyhevxM5SJBBHvwfPhMg9skHM1+jBYqNPYWJjH/+obJ/vuKQfVvMFgcprJbUNFvC
 iJu50hrF8QfX8OVAvGdgxqBBCxX4dEIWH1OPWxeBStuJqmhmATWHMevv6xpOjOIZzT4U
 4H5g==
X-Gm-Message-State: APuU4Z/VRTBO/8CmcfFLKOjH0r9dbVApTFiV6T3qSeVOeKTH0j1v8myy
 gFTDjJNlSEX+MIwk+7PUhr0AfDPTYDrdL9yGVGu0712gZab4jQO7SU2THq1MRcQ/oxzTbaPsHZD
 S0adqknL+0K83BsCqTHFn7A/GGQY5kfXS21g8RTRvJ1o/mdv9g24fEx6C12TLtkQEiA==
X-Gm-Gg: AYBFou18rw3WQA4ndCuw+csiDqSDhHoV9tP26QKM/0rSeyLknT3RN/bUzYzBRmMve78
 KZPgF6N9xraOTOKnBBjX0oWKtVaN5xtxlR/amZpUr3Th1Ioqnc9GFJRxbLvkXaQzdLBM9+32R+M
 7zWyqkb1sIAh5l7TiKWxYm7fk0ubXAr9hLDCwmQUENABrimwyTzm58bXO368pqI2/9o4YVg48az
 pdUp39iLEzr0ze/PRvh6hS3DaSpfmojggcVdDYt2AblLlLxheaOtPh7ryww4G5S9fkrF91PO9Re
 KHEgDMgMEFWJz+M409I7PuSQCVOFfgKJfjRcW3PTqeRm5c+ujUt+rgmIVYcgYzzgmwEhiZ8jKyW
 yQmpMS0FYccitqhK1FNGv7fsSpVNcgG+tnsbbqGZk2Bv2bpN6mWAbqVrDudJb12E4jqxLxX2b7l
 bfTTEzXPMIW2AD6KFL7YwTy2D7aZG+6ECcNs+rVnFUBXG/sZ1tCiFtvHIbL2B87tIAIf7jivhgC
 Np8QQs=
X-Received: by 2002:a05:693c:83cf:20b0:376:6ba5:6090 with SMTP id
 5a478bee46e88-37964e03109mr2913911eec.1.1794556769721; 
 Thu, 12 Nov 2026 23:59:29 -0800 (PST)
X-Received: by 2002:a05:693c:83cf:20b0:376:6ba5:6090 with SMTP id
 5a478bee46e88-37964e03109mr2913867eec.1.1794556769132; 
 Thu, 12 Nov 2026 23:59:29 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm5213376eec.1.2026.11.12.23.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:59:28 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v16 01/10] build: add optional librpmi dependency
Date: Fri, 13 Nov 2026 13:28:56 +0530
Message-ID: <20261113075906.715870-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af6c362 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=b0ZNuq6sR8mh__2TUtUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX12AuQQEWEfTB
 HeeplGpWkOTBsnzoWu8LYu60Ov9HSO+3v96QYWBixhb3LNanq1uukhY/Ces96Er4ei3EaKtoiY+
 steYIcu0F/ddVipGFHuk76uPe9Xox7ATq/x/RwMwkhCuhORBZqQELyX4i4o47x6YRk0zdXjrcCx
 QNqnhyH0mUUYT10oMSa1TPCWNvGd2KMnlAFg6gTVXffSQUo+U9Aeg//3MIFnB2ojEERmkNrYzeQ
 9owQIXKCqudzRwFKv88EBwDbtEnyJYi/itWC4gb1SBUCmFfcm8zKjIqYwxoxnPftl4yqqpMJHv/
 DBffJTl7v+uZAvl9Z6tlcyBjtUPmuroUWgEmvZAdfpjR8VPA4dgElGXAyo9XFlruhvjiWH2VaVd
 VyuFMBv4PPA/dPigM6yph+5jkW8CHkgaGnuQqo7UMYCuay6XKJqzU4NglT1zM1CEhHNkKMSIZrV
 /LXLxwukjAN6gsAAg2Q==
X-Proofpoint-ORIG-GUID: nHZWrAcCWcGwdh0KZ61t7v6zfLxIl8au
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX9cTawTzABohE
 bi4Gnj1UeHkUl3NJt+4PEXCRZhOtfY1g4cVflsCSdmEj3PIFx5KRurc8H1sF6nT05LQ20gJsP4a
 wKy1rUskkmzprk+ZRVUIYJ/XesL7UcQ=
X-Proofpoint-GUID: nHZWrAcCWcGwdh0KZ61t7v6zfLxIl8au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
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

Add a meson option and config probe for librpmi so RISC-V machines can
opt into RPMI support when the library is available. Keep the dependency
optional so default builds without librpmi continue to work.

Require the System Suspend constructor used by this series. If a found
library lacks it, warn and disable RPMI in auto mode; explicit enablement
still fails with the unsupported-library diagnostic.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 Kconfig.host                  |  3 +++
 meson.build                   | 19 +++++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 27 insertions(+)

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
index 71f135f053..3dd63772e7 100644
--- a/meson.build
+++ b/meson.build
@@ -2026,6 +2026,22 @@ if lzo.found() and not cc.links('''
   endif
 endif
 
+librpmi = not_found
+if not get_option('librpmi').auto() or have_system
+  librpmi = dependency('librpmi', required: get_option('librpmi'),
+                       method: 'pkg-config')
+  if librpmi.found() and not cc.has_header_symbol('librpmi.h',
+                                                  'rpmi_service_group_syssusp_create',
+                                                  dependencies: librpmi)
+    librpmi = not_found
+    if get_option('librpmi').enabled()
+      error('librpmi support requires the RPMI system suspend service group API')
+    else
+      warning('librpmi lacks the system suspend service group API, disabling')
+    endif
+  endif
+endif
+
 numa = not_found
 if not get_option('numa').auto() or have_system or have_tools
   numa = cc.find_library('numa', has_headers: ['numa.h'],
@@ -2449,6 +2465,7 @@ config_host_data.set('CONFIG_LINUX', host_os == 'linux')
 config_host_data.set('CONFIG_POSIX', host_os != 'windows')
 config_host_data.set('CONFIG_WIN32', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
+config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
@@ -3286,6 +3303,7 @@ host_kconfig = \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (librpmi.found() ? ['CONFIG_LIBRPMI=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
@@ -5036,6 +5054,7 @@ summary_info += {'TPM support':       have_tpm}
 summary_info += {'IGVM support':      igvm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
+summary_info += {'RPMI support':      librpmi}
 summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
diff --git a/meson_options.txt b/meson_options.txt
index 9ae8e44ab5..62c9eaa20b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -208,6 +208,8 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
+option('librpmi', type : 'feature', value : 'auto',
+       description: 'RPMI support')
 option('pvg', type: 'feature', value: 'auto',
        description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0f8b56bd7f..1c2ad8f0f4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -147,6 +147,7 @@ meson_options_help() {
   printf "%s\n" '  libkeyutils     Linux keyutils support'
   printf "%s\n" '  libnfs          libnfs block device driver'
   printf "%s\n" '  libpmem         libpmem support'
+  printf "%s\n" '  librpmi         RPMI support'
   printf "%s\n" '  libssh          ssh block device support'
   printf "%s\n" '  libudev         Use libudev to enumerate host devices'
   printf "%s\n" '  libusb          libusb support for USB passthrough'
@@ -390,6 +391,8 @@ _meson_option_parse() {
     --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
     --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
     --disable-libpmem) printf "%s" -Dlibpmem=disabled ;;
+    --enable-librpmi) printf "%s" -Dlibrpmi=enabled ;;
+    --disable-librpmi) printf "%s" -Dlibrpmi=disabled ;;
     --enable-libssh) printf "%s" -Dlibssh=enabled ;;
     --disable-libssh) printf "%s" -Dlibssh=disabled ;;
     --enable-libudev) printf "%s" -Dlibudev=enabled ;;

