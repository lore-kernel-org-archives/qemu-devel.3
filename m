Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F0BC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAqy-00064g-MK; Fri, 10 Jul 2026 09:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiAqo-00063u-J8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiAqm-0005zY-Qn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAnUxe429998
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VaD0AacToDf
 loRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=; b=gWaZnAObmCgJE1xWr8vpt6u3Gjx
 FVtVffqZWksyRHTvCjkI/yI+lLVicfnOe6smNCBflrbJDeGB+VuuTKZzuDYMJQLs
 uF8UVxi8eHIc30ddCPVOUGlWiBnXM3jtYrO2GltlHd7ixc0TiLOlQ6hiaOkQf0dq
 CHG0RI5yzKTIeYYnhzmasywoHOyl0S9DjfbDu1q+Cn4/r41uEfoXnusU2t5ZXYbP
 oi7vlZvUpFQsWeyiSmgGI5dUjQFAWo0zg6OOKJurLlf+XSH6UsRgVWFW1KnkC/H1
 645rNd2vIxjOmlUYLUvp5h8yKl7IUhmQ1JoH9f7q+YX9ej6EcKqnGm5ZiZg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24vajd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee882c4so92460a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783688462; x=1784293262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VaD0AacToDfloRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=;
 b=VfX4Mu4L+jImot1/AXDLv/Dr+GGA5Lu4jgksVM5YT39rQtXL+fIib0zcPIhIJZjpR4
 1bllWiPJ8PrpE8hZns6hcst3S/0zXkf2HRZlQG1jI25M9260IE/RFWAkhJfyHHjzQJXr
 9jb9p3jx0auwxW/+v4a4YxH6uHDbmaMfpWSdDDHUI0qNlxot9kcfdYfMUdJfFOV//JTV
 CUoA1d8yejvm09FqoRyrKIj6UuJfXSSs0oYk8PZsmmTV2HG/wHKQoSw3PNOQfb8UFX9Y
 cS53TDynO+wESMlk8oILZ27Uzz931F1o2V3jBfiKXvAQsripLmqtvYyr5jSdt2kpYk81
 c6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688462; x=1784293262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VaD0AacToDfloRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=;
 b=l9c6+XoMVREhPgy00bCvOO6jlC/KF6y4p7Dzwt3K0NLZjTyYag20aHzWH5H7rEFGtf
 gLBl/mP5piSRIAuiBn9OOsUxN0w0MHGa2uPu7K9UQH2jlGmsV4z6UNj7nPBlXL0jPMVk
 fWzdm84oUTQuqx45B4KOgm0zvWMJqYRzfSdHKxhzVv4Ltl5KBe9BPO2cmEsfiTOmli8R
 7g/7CdE+fa5HSknj856/vrWt+/WW1DC0DRQfu1nWpfrBnc+UKon3ZYqwE55leYLwbDIb
 YagWEI3yOJzebidf+bAi3oR3cxR0NyPjMO6tN1/Z3g47E2IGwHCltCCquXdFXfZZMJiD
 liEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPRPgaPNypuLY9mNxsn7p7rVkp6lQgyMyn2Yck88Xa5CboSZ6WyS0aDUjl7unWA6QGUW1y4QKDo7P6@nongnu.org
X-Gm-Message-State: AOJu0Yzxeo0/wc/Tika134OPh5qML5xnaPy1ustjhExKH4evWtQBEwd9
 VbLyEO+HXualD6aUH1B6sxKc6MzhC3VNdNn4ddwWtUeg/b8SxctV1B/P18HK47tWtOFh7oizeqo
 5rzHCwHIZ5aq0HJ8fZIDICapgARKiI/8IkVJg85h9S1Wq6mk379RYnskdwg==
X-Gm-Gg: AfdE7cnhU0Wg8NcnTgji6mNUzwyG9QzQDdK/1RVGNFIMNGy3nHL/Gxk+ufAXi7FI7kr
 qg34CW2c2fD8JJVPxG4goM1vP/55mcURu5RAeK8Tw0goxUxEEANleqsn3GRAxN8vA5RjLRiXiJX
 YhubUhcJ0ceYSe215RhPN54TD2f2/gKSDd2FNHFWgP5BHzL9RP8OvbkMdwWc6AoEXelSGy9QIhO
 IR72obiGQ5j2EDi1+03EAONSV6x9LAxWpTMpmoFl3X4AcAOWwFTnojCh7n5VGhizBt01Xxdwf0P
 mXbjitlzx0Qe3idCYpazhprt8wv0cEqxyZ/50Klw3SKkwld5eVFNoDiFCwhcD8AlJos4xXxlLka
 JnVGxkWuv83k5WA9P5k3c4F+lTONT6DCI2drNXFQa3iNNtw0ynu2GUgWbySYkj1eZxdZhdaafSJ
 yu/K2Q7xwFQgCKk/XOistBzYRlf0z7Ckb1uA/1pXYTBA==
X-Received: by 2002:a17:90b:1d50:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-38942b7d8c3mr8457907a91.8.1783688462160; 
 Fri, 10 Jul 2026 06:01:02 -0700 (PDT)
X-Received: by 2002:a17:90b:1d50:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-38942b7d8c3mr8457863a91.8.1783688461482; 
 Fri, 10 Jul 2026 06:01:01 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm9611839eec.6.2026.07.10.06.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:01:01 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 01/10] build: add optional librpmi dependency
Date: Fri, 10 Jul 2026 18:30:35 +0530
Message-ID: <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EvgJz0EH6VzsS-dZsy510jjKe9Xsm46D
X-Proofpoint-ORIG-GUID: EvgJz0EH6VzsS-dZsy510jjKe9Xsm46D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX2MfUMEbRE+55
 vW6HuuXT+uR8v/96aG9fwTHIfTnrS4FE4Ex/7CSUe7lTHQ9oCo+J+MiNhEfeFHRN+ZYjap2vFjq
 MnD7oVPdE12r51FVv25XzVYSDfOisHQ=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50ed0f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=_6tmRKQHnRYSWcN6IbQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX3n5w92XQY2Dc
 hHmiJ8u2IpZ64MBC/gPQ2c8xczxOmDwM8NLrImXOgltIPqK5igbO9Z1CzeC8zlcae0xLI+uxS9H
 omb92DoJCfsXU62XEerHyLAtVImbeTDsxZ33Biuu25IVUvEHw3anUK/qFOwpRCkrUPhMksKCXQf
 ytPZnGjiLdkceMYjVbOleW7CtvQYDdGojcUgyFgFFgZZEMnxgmo4SGPwZksrFfpyRMKEIyXn2yg
 TQGRHlTsewpdyhrOfjREDuS/1tgRmWHj8/TsFonQew3TaDQg4LNTHCxIqZK4in1gLeigIryd96Z
 ymRW2gXvIkriKRFl+NlhRY489tJgtHT+UOvlyuG7zgKmVPnpnmvoyBsMlAoraWgayGwFXbf6FI1
 s1w5xauUj8QpLCi0QqSl3KW9IhXccAV+L52v4kl54idDAoSvZUVflAScRe7vNlpJsRQVOlm+XAo
 +j3yF7Xllx3ayy3PO4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100129
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
Message-ID: <20260710130035.CvimOJJzXvdUn_WPnKVEwqjwA5hYG8OSFGR-CcmWw-I@z>

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


