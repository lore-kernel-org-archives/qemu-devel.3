Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C811C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY1m-0002W7-Ni; Tue, 14 Jul 2026 03:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY1l-0002Vi-RQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY1k-0003bR-AA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E7YM9Q4102008
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yiotWj2VIis
 s3eyZxiMecku3YKV14swuwd5EFw/M1rY=; b=ngMglVpFzDo0QpmlmzrfgQUIdIx
 ygjhBQ3/VP2feumd896DPd2YozzbDxB67tfZMtL3beQGePvpihROqpOA6h1AW22a
 WXT6+mjOxJC2EECtpKZXCJwb4v5RZ0l6kwWoyPkXNDirVHWce059HCb7pVwSUuuu
 8TbwF3vK0zJbtT7wg+cxrvkPE4i4T8mk4YrIcfAmDvgm6RirWHDH22StzrA34ePx
 ORZmIuFwIsg+cMNI+iOzfm9RQYKlxqZ0oEtdsguZuOH5p7kp65LFW9CLkREvsV63
 lkPF49rxAJBNxIHdfmDHnXxzx82ZJENEfa0ZBs74+qmVGqiUL+36VnoqFsg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudg2yc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3883dc4ad23so1484911a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015882; x=1784620682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yiotWj2VIiss3eyZxiMecku3YKV14swuwd5EFw/M1rY=;
 b=MI3dBI3s5lJ2K8yEZvwtdnGVFEuxp1kIYZcWNsA8iP5aRzxq1ncKsrv2mdh0x4S7hj
 QRb1XWgLjJaJjip9PYh59lNO5lTKLyQ1kxwRcEljKRnZC2i9/HLbqd9ZCIu8O8kjqua4
 tG2eaGV+CzDHJ1qNPMA37ygkn73zHkn1AwCS0UBdRs1z8kT1mTChCct193llYZkwfCtu
 KnRoLkuxZpdebihjwz4J+RXZh3nanXqDy1fhVzuZ01jJkoB82beawabu4Rv7Ta7jvj3d
 +CL7JSTWzeGvEx/29WMKj9ckFto5z3ym0/aI4dRpqMfQlSaNP908/q9pzHq4uUtsx5d8
 7+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015882; x=1784620682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yiotWj2VIiss3eyZxiMecku3YKV14swuwd5EFw/M1rY=;
 b=oipZ/53Qiy3Wwh7bvlircVr3bZrVHFcUVBnHDB2ewPv9l7XSJ02jJYWCLtLViKZyCt
 5v4YZyykGyOPX/6MKbbpAOXytogqpWNG9S5Nplo8TJ0yG7GrnGK2kph3kFIJMAT5AKtS
 MErbnoKeOzrsbB+Ox1P53C1swZ8pQq/1s8akd2nUAxae1NRRbPAfkX8KzJrrmjLqLSG0
 KoU/IvwxKDLrM/X6UloH+anl7t2yqAKhgA3A5VbyzTqnWw+bTS0oAGKmxZsckYUvJBlh
 9s4QpuXJprj8LVOeXgRrYAt6P+Qx8tOBBxdEYdED4lPcM7VULI0URFm87GmpIG6d3K4o
 GaBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVStN5Yq128HeiLdvTje9Be73NXL7qHoPVwe96Lsu/zcASesp2rm0yF32Y1YTf44l25fcDh+9bLyYu@nongnu.org
X-Gm-Message-State: AOJu0YyEOT1fHoWVvUm0sMadRTZhyaD6EA5wZW3+IyBAsg4nl4J+sFo+
 L4BxaaUTvmXGcrNyfndfJyXa5jHz7lldwD4DxYVwDBuPB9659fqZ4/eMoWUDH5D1zUiqRAiGq6B
 ygu+/fpY7IIM+9QoYObLhn0ay3BQKtpnPRLJn+6j/Gxzg5iTfgZ62He4xyg==
X-Gm-Gg: AfdE7cmvLRvZS9o7G95C1OaZBe/fxR6j/diYy419QZvrNsb9sN11FcaaUfTYarz9wl/
 Ijtf97AMDpDemqHdB1te7hCib2NUjP5gWjdk7iUa/4qg/DbI9e92aAeQbWmml+ZE2LPh7tCyTCU
 oBUWS0RXLSG/cpo/CNQwSgbsMm2puhH1Q0i7DYgWXNSk5SzMh28VCzhMpZbRDinC2uv/JYY184Z
 T/Q/q+c6zmgDLsnJ1eEGOXXRb4/9Fkg6LfAeHMIW0Eyz5Id4SS/D5uPbbKR3Mw96Rs4+cuhpJgn
 97akLcAfipGGE9cnLcmkeQPM+SpH+mrAcYrVyagOdzhdyxpa4y5YgwhepMm6XYr1W609nU5y/ar
 EngmiLgM9NQztwZy/ctw+7g+Wh5MInmZztamaABKGYquRTRNZRa+af8sICev/wLmpP2vyBRNpKU
 vBXfHpsqYttcVZP3C9/9LlYZjLU+mbFNIMa8H0oNyLzA==
X-Received: by 2002:a17:90b:4b84:b0:381:16b0:55c5 with SMTP id
 98e67ed59e1d1-38dc7a978e1mr8984270a91.2.1784015881769; 
 Tue, 14 Jul 2026 00:58:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4b84:b0:381:16b0:55c5 with SMTP id
 98e67ed59e1d1-38dc7a978e1mr8984258a91.2.1784015881290; 
 Tue, 14 Jul 2026 00:58:01 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:00 -0700 (PDT)
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
Subject: [PATCH v3 01/10] build: add optional librpmi dependency
Date: Tue, 14 Jul 2026 13:26:50 +0530
Message-ID: <20260714075659.2258023-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X9XynENKYzm9mYwr-eeyKUwngOb2wc1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MSBTYWx0ZWRfXxeseTZPnn6Vt
 9LffwcdLb8hob6LxK/XKlRpBJDUb0xP8LJeTFl14/K1DPgb/ftczxc9Vf6tFzUfwIaL4IH29o5C
 ukDkQ2znNHumVOPXB7qiuQXWx0Fpe+sE80qmj9XWxPwQ6QnEILvgQHBKoPy9LoT4jRgjHsJNLEr
 m6cMAkZmQy7sJ0aKwej/8bITHQMTlmjAB9em5aioKjzh3SU3ZsNAI6TlMxPjA4uSa4C0LZN44ft
 jPXXF8RmVfLXjMc6IHvs3ikzZgt2zblHOZkmmEEca+rrsBbeh215X+GoFFIDjM3TMuJLT2EGAIS
 wQrnmxIGez+3y2Lbs+wuSr9R+h7aPhP0Mbpl6A+VTUGIjecFnVmYJv7lz8l+k1zr2lx20bPmQP1
 ccdAEoOyhzimMeZdF4DKSPGK572Hu0G17G6ySDg4Laf/oNpt2wD+Md6X2Lq0zG4PVI1eLOT+rUq
 NM9CD3HLnOTiVkTQXuw==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a55ec0a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_6tmRKQHnRYSWcN6IbQA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MSBTYWx0ZWRfX4vuVNUP2E2Sy
 hVG0+4I9FUFx+PepjkaH3N8eE3oDeiWfaER1Qy5IrioBlpG/s+s4ps00CLMFKv9tJl0PILK2/PA
 Wl01GWj3cmxJLLP7MVyubEePp8Kpi3M=
X-Proofpoint-ORIG-GUID: X9XynENKYzm9mYwr-eeyKUwngOb2wc1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140081
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


