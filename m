Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611B2C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEa-0006T5-Dh; Fri, 10 Jul 2026 08:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41J-0002Ds-P0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41H-0007ih-Qu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n5Cs3802274
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VaD0AacToDf
 loRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=; b=MyOyKgUva+qZv2oU6USUwAxsYR6
 OvyxjHchK6qsSW1kTZZZIvZLrPktOGLj3ovX3H+dgf5tMSNSk8u+i/tzYIVnZSzw
 Z3GMlBkHG1ERpP78/jWuKgL/lqK3D7JoV0lSBBNc4MGH7dAo/pZ7n9EEuHrlmDzB
 /IUbVvCeVHpSMB6N5DIHnaFAGVc12//ILP2p+HtibLNIVJpw5mXBpiczNczYOeF1
 7hlkR+J2YREOyvuoHFD4uxBekKuZNdK38me5FNqjnb9d0UFHod0o5ct8uT4Yw+CG
 cIcLimTnOVFcAzCGDlwzB03hFdlobjt9HKo1Aso9n3sN9ieVh1WzbvosVrA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkg8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so164901a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662205; x=1784267005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VaD0AacToDfloRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=;
 b=Qlt8iTcXAdXxzUHQ0xJMq5CvV2pfKk4AGBMyzjaxpnIc62xlQmoSmvQPwvl1T2EUtQ
 7T/XvrEfF9StSMu3TDfokYrhgVoWf67oVG7PiGRPaDxRhuJV0XPNtb6gPG8ISpbbCTBy
 Q5JZPRTEAnxhGxS91CLxZvaVr/GlzC4o+WAGqjDxkqB+2Hbney4H+7sUhDOOAHeN/RV7
 dxhQdsgS8XfNQvWTLdDZndIos5JCUlPkJkd6Q5i9Esov07hNv6kYIMi0/koQm5HqTD/A
 cOijdA0NUibka6U8JoHHwvrFy+BBPzKdKyc7ycsvBiM92eoNu2ZlmgSY5q8MgPbmor6/
 us/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662205; x=1784267005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VaD0AacToDfloRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=;
 b=sQ06aCHupmZYf8jtcjw0XKlItA1Q7m11wtIx7WNiZ4t3KWEU15wqyYLKN0IC0tlHHN
 z6vVIyKuRDwBOx3V0Tkeh3CpqWZVXO280nE84K6qJAy2eT7egmdem1KTykPp/zuS9qtu
 WO1VbsYYvEd+ECc3KeJYPYpCxVzTCLaVcVs8cBCMrvo7hTInv/kQnnddfnF0X4UcrNsa
 9LB2EbEDBNLMJdNAh6wLm5+pD8uATAlz5Oyjh/mMvqZfRLA6h3K1Km5I3CGp2JdwEJle
 QGPzkfdZyh8imQCQlmawSq3nQXTPdR5GzGwfuwYaIrWNvqT4NOvSTSe4yYl2enU2XOyN
 NOlg==
X-Gm-Message-State: AOJu0YyPxPSPGYJhzUFOpGDVMRcHC92vl5zuz9n0uD0Lw+Vd0GbPO6Us
 ybPotvsbUbaDMoOeVQeHeHxi9eOOij6GIL/chiqo9chjOAWSlCFGsrsU6oknxFDN7Ue9g7/mpsv
 KReht8rJjJnYQwybH8B5/Kx6NGKgllJ5+/mAREmclolUmdkJ1Km9l6rQix7O8kHg4JA==
X-Gm-Gg: AfdE7cnXqy4zF9jUXiGopgzP1qZBOEwXYtES2U1tr/tDfAsSgXGsrUO2MjJT0/mCqFN
 xPKHSLw2K7jEUKV6QAvM3G72Zux4Aun9O82SHHu+emIlgC1hsVDjnPXdp53TYYDRXLsxcxX0OAk
 n/qeQk6f5vqReK+aVIEg0iWMLhAdMlTckrnc9+7rgxCfX9+NBUOetG5TrxEKJnmRLH9UaKORek6
 7EySBOe/iGasWg5rFXoxr3hdgXGFhogaMHYSJn2D6l+mKEowxOOZN4E0i8fHG3z7QYpMUONUyR4
 PuHwV47I8xwEOHmQsKru9L6gFoBFfAPqBhy/VpJx1O5xTz2DNifBnI76Wf579d6EusOTgCWEbhC
 cwCnk6O1a11wDDUpT0+MUkUCTJRD9HI1900LwlHZ5K3RKwlYrKXr9/gfvGA2BmjKvLxsdqLD95Y
 MfUg5+NWZvsNukkaHjEkD3CnmkhFt44zbJXH7vEOW17A==
X-Received: by 2002:a17:90b:33cb:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-389419cdeccmr7431403a91.4.1783662205355; 
 Thu, 09 Jul 2026 22:43:25 -0700 (PDT)
X-Received: by 2002:a17:90b:33cb:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-389419cdeccmr7431373a91.4.1783662204774; 
 Thu, 09 Jul 2026 22:43:24 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm39112785c88.11.2026.07.09.22.43.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:43:24 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] build: add optional librpmi dependency
Date: Fri, 10 Jul 2026 11:13:09 +0530
Message-ID: <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX+GV54gvLFHUi
 LleEE5o9Y+jjpPWw+pW/NzPC/fUsIrEsOkkmgSj6J8LOYaP8h+l1maL4ix8Lo1mwZdYviSmx2u6
 zax/vR7YdZvXnGsNTEfxj1T8c06nV9k/n6Ssh/NGISn8p/cf0+i2WkSa+7libKdODsgtpFMi7pr
 us4vjKESIij+NUWnKcJLTBH97VT2dYxHaCF0Bu0uRzt4vsWIK1YldP3U0D/5uF5faM/3skmI1W0
 5NyV1kEWe0z/BivAgIgKa/Ii6eJk6iCog5thRuxaoZ8uw0RU1hGMkxg/MaeYwbYrbt8Kk3rjuTS
 U+Pzw8AlzfEoWoquLBPiF7RtgzcGl9l73rfh1M3isF5wU7VgX6b8k2nz/nyiE1uPUd3enFeESBd
 qq03i8PZKIWdrclrdtbkUgyZjl2wSbBOnXddOiC1H/k6Ycxu9it2ttLz2Dq9X2VB+RE6PmoM0bj
 KxZSgh6u3RTOKRtomDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfXyHXu6sTyUBnV
 1OId6anWInFvNKcabwFry8j8A7rg0bmF5p8T7KVnvze2HrMEigGHUXI8Pj3YELVYZjpTRxwNovd
 mKj4q05yaJXVVXV94I1/krY5IrMrYbg=
X-Proofpoint-GUID: G61EANEg83iXEI9DwS4mASvOiSmqGHnk
X-Proofpoint-ORIG-GUID: G61EANEg83iXEI9DwS4mASvOiSmqGHnk
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a50867e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=_6tmRKQHnRYSWcN6IbQA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Add a meson option and config probe for librpmi so RISC-V machines can
opt into RPMI support when the library is available. Keep the dependency
optional so default builds without librpmi continue to work.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
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
index 19e123423b..103b4649b8 100644
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
+                                                  'rpmi_service_group_logging_create',
+                                                  dependencies: librpmi)
+    error('librpmi support requires the RPMI logging service group API')
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
+summary_info += {'librpmi support':   librpmi}
 summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..9f773a7886 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
+option('librpmi', type : 'feature', value : 'auto',
+       description: 'RISC-V RPMI support')
 option('pvg', type: 'feature', value: 'auto',
        description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..e8a20068e7 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -140,6 +140,7 @@ meson_options_help() {
   printf "%s\n" '  libkeyutils     Linux keyutils support'
   printf "%s\n" '  libnfs          libnfs block device driver'
   printf "%s\n" '  libpmem         libpmem support'
+  printf "%s\n" '  librpmi         RISC-V RPMI support'
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


