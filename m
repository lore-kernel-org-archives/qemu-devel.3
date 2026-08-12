Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CC9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6Ih-0008Np-Ck; Wed, 12 Aug 2026 06:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6If-0008KG-Ox
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6Id-0003LW-Ol
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9fvNA3357816
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NaClFsqxS+TPXljZw7gIEM/IeT0qj7A93m7IQOhOzMA=; b=JBFTHvPb8PVA2O8T
 gAeYLhkfoSfhHG5+M33AM+dXPQQKWcdi/z+5FI0YEzb8QtggNuueBb7uNv/+jXsr
 s7Mw9f3X6YYU4ooLrF3kZ5h+vM+JGGnFKg9cVzHubNiCMsvn3XdPKIp/mJwPdSUl
 iB3uavHERj8UJMiHJfThjoB/OnZ5dzSqw+uv4vDSW3OMmxPnF+54mwABnYjp1u8p
 fk3fqbcrgT44mYSFZX+dDfOdUsFn346T9yGe8+TahX4Gg7iTR8vbixdwG6CkjhDW
 JDgaByJIsCJx/UixmmVif+1n/F1wGSk4658l02vhQvjW7K0UBUxiO8IJ131unu1w
 7AlY8w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1hd3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d0563db6bcso3696595ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786530905; x=1787135705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NaClFsqxS+TPXljZw7gIEM/IeT0qj7A93m7IQOhOzMA=;
 b=UeA74VxhmF/KjAqiI4F6Xc1C55EZ++v09fuAp9oWMA4JBNhYPvTDF4F9XhmygeM+6O
 uK68NFCWjydWDrQBAyb3uCylgb+j5uUcqWru4PVTezx/gfJ+kqr2HdrgEXLvxOyWll2B
 gpyqO9HFjFnrRA2m8U+TSPTqeIFbwUz0AN1cBh1l4N1w0zaVRTcrPmhrcbOlErwpXgMk
 wNga9VInd30SeDc8Ix78HeJmv6PYePT+wfiI5pK4bJrpaRR8/3VfeTQoCWqgb90P2p0n
 dnPxKARx0xMAQzc2fL6JzD/Ll2VAytJzvWILf7V93/nAkjpDtARMTGXn3rzj1ioJZcN2
 yiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530905; x=1787135705;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NaClFsqxS+TPXljZw7gIEM/IeT0qj7A93m7IQOhOzMA=;
 b=tIpjf9uKCN5ViESsGM2BSCAIzL6bXM4eXt7jLVeqLi3V/HXaGjbSbRKy5MqezptNHk
 qZRtkWxw54dDZZ6HU7d1pKqYUleeDXnueIIbrSPFV1Zp9cU/N6pLj5beq5u/74nfD/XH
 Fh8nsjOBn7/OJFb8hfLuvBHnt5qB4tXRkcvuwB2jUe/RMghcmuNz8jBunnSMDTXbBUN7
 whciBVfyWBmdhf4f1q+cHShfD+qzFihMxzGmnqRMKqnZ9qdhpJs93xnjA5yHKlDRDRS8
 UNnx9H5ONM5TKbvaYJF6mB8T6VB5Q1qBEK/aQ8MnVa0Pa+dAB+93M/T66d+u2tMJdNtu
 J5MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH1hGh54rZSU5fkevHOoEjpqTlirQiVk8WV/Ot8OhrnmJ514vprSDRYfs+A5SOUNqpSmjWmsu9PH7M@nongnu.org
X-Gm-Message-State: AOJu0YwF21+N57ov0vswtviIYjTtS6lhhvW0ZaEqsXiC1T2A2WsKN8CD
 skSiD41CT5yB1p8s+G9KW6q3XlYupBbozjlJDWLYPfeAZ2hpKtG5H53x9uEOYgNm+6PHMRiUcnf
 nl934B0KBt5aa3OZoNbKkGX1D1yst6T001LfmCUTS1UYMyCK2y0la08N8KA==
X-Gm-Gg: AR+sD125K0QJkteV40NNl8m7es/siHwAJY1CpEZwLMfWAhvNQQ71ek+SFhHmNjJQvFC
 HzxFuUk2UgGg+N3hKdfElzSj3pYuPeTNhriHUt2yD7Jg8NdFJXoM9T5BKY3UJGPQitnaver6C2A
 bHqgE6QuK1qeJU4S+HC27noxFZRFSczS2HBXJ2Rmt/6Rti8YRzrOkVHuGNE97gRcBzjWSvu71TF
 kTO4mcVQfJ/GCrjqFqpuqVRJqSk0bwfirZjbpBRJgUAJcxVsrAmKN+5t90PbEzIefjLNbXT7Q6Q
 z73TVVVEQ+nOepF783NuSt6a3Xbl9+ThTq/vRKxzAwFhIDQZZ5LWLJdY5rnl9B/Sh6Wa+twRHCB
 NFjeIrIKruMSL5ajDZp+kVcNiPyc6vpu5eCSZbbAEvtds8a1E63URDBvv2MCYgsi8AtzLP/ZOEY
 oeCk30PduMApebSKdC/9Zu4qz4rpGXWc8=
X-Received: by 2002:a17:902:cece:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d34568ea34mr35773545ad.3.1786530905207; 
 Wed, 12 Aug 2026 03:35:05 -0700 (PDT)
X-Received: by 2002:a17:902:cece:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d34568ea34mr35773185ad.3.1786530904757; 
 Wed, 12 Aug 2026 03:35:04 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31d6aec3947sm6910326eec.17.2026.08.12.03.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:35:04 -0700 (PDT)
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
Subject: [PATCH v7 01/10] build: add optional librpmi dependency
Date: Wed, 12 Aug 2026 16:04:35 +0530
Message-ID: <20260812103445.3451960-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l2pQjMKCw1CP0mfZmfGWgXq4rgylzWqy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX7B3vRczGMzIt
 dPqe6GzZ+tzp/4gY5BTsAe/qsPt1wIJ2p3u7Wpb4bEUEOoW0AfpLlO2rRl0wOl9KL92SVS3Rs2Q
 8KrRS/mJjxWNaF440ZxyL9IzRCT9kjRaatgPk5OBEgngyF1gcqqQAekbAWFImzYbFGXXahkjlR6
 w3roS5V+Sd8wM0ZDRVZqCiJ2C72zhwxVNdCk+xk/NMmWTh4HgBmmjIrHQjeD/QAOu7FIIkftm5g
 p/Iib6SjFkLUKSgRmVpanZjkyomK/HIsjKd4gm+VaIuT1+24ISS2kdhNsVB735IL58JOSWh5Rza
 pQvxRzhqkUwrXXFEM033EUc1NhMKIUSzBIUb5yLtIwh0t6fmZ03WPl0T3ivE5SR4VqGi6wM0Rso
 ltQPFrskYgTAgXwk+NUuFbZ6o5bdA5khAKPeM1rnCYRA5FNLfc1+SNj+3FEEchJy2ljcg2BNBOI
 wQ2NCwzkyjAW5AITJdw==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c4c5a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_6tmRKQHnRYSWcN6IbQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: l2pQjMKCw1CP0mfZmfGWgXq4rgylzWqy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX1oemlZ/tnVNG
 J9k6770e+7gK7AoIH9QoTH2I0A1/hTsar20KUlnTv7vQp7a74azT0bFLZwa9JuUD0OwG8khDh8X
 lec5TdS2jOx6ZR3ApAb5+gKpOruTxaY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084
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


