Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277B606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qyau1z3t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NfWheHIs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTCK-0004Ur-8q; Wed, 04 Nov 2026 00:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCI-0004Tt-Sa
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCH-0002B9-0s
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:06 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40R7sC1191178
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Q4wZP/ShiuYZUn1lGH7YdU9moBHfpBcSJIBbthl4oA=; b=Qyau1z3tayqjnPSf
 K18JZPljmfFpWB4eqfhZ59ea2UtJGtg/t6Ka2AlXHuXVcdsSzsJVVL1lFZsrnhfA
 WFb5sTuhz2ulf23+FfCz6cAlVm9JLkhxQTM3bpY+MI2B7VNn2U6VgL5cx9zaXYq1
 fB0r6WKcxF8pXhUVnz/YFdG+RTXLXLFqj13GhENtEGM4K9GqUyyon+kRCOSbgJ/k
 oC6M6wubF09vCxSIEM7lcVE3oJvbVjNJ25Cm0htO52FUPzPRW7zhAoUAXJjCWjyY
 LFmnRAfE1guY1PGX8EhR8w+bmZzTg8ufiN2iYYkNCNpsK4E58LweFu3QUKGdvQ6i
 hj1kiw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pjbfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36c98e5ad40so49435eec.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768762; x=1794373562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Q4wZP/ShiuYZUn1lGH7YdU9moBHfpBcSJIBbthl4oA=;
 b=NfWheHIsAH6aK2JHgawPCbcDMMLTS0qTpFiDPaqrsq10MGiOyBge4klzz+Fe8oqsex
 OmhAUs8UQ78JHNL7L/8LtQWe2MIlpRwmr4AacfUMrmmoEICdgNH79ZrKj7qan2+JBzLh
 q6Btiv7WTf9Cj7BelS9mJglna6JoFAhiby356EN9eLyb7BK5a/LF1oiXeBXczfrLMLMT
 RpmOWMxz77bHprlt4l/mv0rgLW8R2rdG2iZPzwJmqerP7/0FHc2m392faXBhc6Z2Vkx1
 rQ6y/riEtWZs80I5NQAigRA260DIb6yn9Wch2acqmpT3A0cMIGkJiw8oUNFQb6fbI2/h
 +sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768762; x=1794373562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Q4wZP/ShiuYZUn1lGH7YdU9moBHfpBcSJIBbthl4oA=;
 b=Q36BmJO52Eee4hx0GTxAZEICfaCOYiBZay5lTR6vV0fLo+7IO9alnqW++IWrY67uPe
 yXhl1kWR3SgmbqoympS0wa/x+l7jBs3U+mHD+BAOF+o7QUIQ4FJjgFT+LMK+Z7YCMv0M
 SCWZV9rIIybVvUMIibC8uGE1RkP8X+eHaGIX7oZk9r+a6Tsu+bAGSYd2IzFvvNrp98Xz
 887fxYYD2VkTIFoJu8JhpaVXi5+hAewKL8SQT0oe1pBJ6XvrBhyKrLnyD5fK1BmXfu0D
 U/QuIsyBmAdq5oOXbS/jaXD4TGC7rC3rySNU0/zR/3y7m0DxZgNEfS8yLpubTKzHFQTf
 zdiQ==
X-Gm-Message-State: APuU4Z8IcXFvR43HSbl6nHeeW0NNEmmuJIkqJ0+bH8peNEY194n31I01
 ZVr6Fapl4H+UMXDUjQAbTOdnlsP67wPyvJYYVqgAwkHvPMjgOuyGRWsQ4suqOIxxVC9fKpGdjMC
 BSTPlLG6ABKxi7Nmuons+MSkWcPfYV8ORPY3nWSwdus/E6yNgtBjOInlS0+KE7h44jQ==
X-Gm-Gg: AYBFou2rsJwZ0PiDBht6YSftRLvrGIyG3dLs9D0kRfNPZfi7SoKMmPwNDmlUrXwQGdR
 tg5F9FzooZWoSuBQHERz1sT6UG9u7DtZUNbyb/eLfIP8u+aRLow3wCeIqkq16/OqwSPuTr61zQZ
 9GG+jfnqFhV3e+45pmXAMZQ6JZGxFlECqw0CTKgkE2b1Boo2JsDk4KHpOIlLEi6Wo7SnZXnGAZb
 cC6wol9acWg5pZedd/Bj7u9pXMC5lE9BBKJFThEeVDXMr9rkxrFl2xMAdUrOC51qnok5VlnADTF
 rEucNJEx5Rcg8w3eJ8J+GVzTek3Ua5WNbIhkE4uLWFp3UHf3idzLGCjTK53o3hxNY0Zai8dcOhX
 N4PgGeG8GzXMOqpUW0HqqaPtzsHWMWdZMsJT2srco7wEE4XPZhen5ihmUzEUzpH9cmiyX0P4MaB
 hhBsqYD8lIV0Je+o7Y2PDAFMRXQ89/DRdvt5EdVpSSPfv6WI+nEMA4tLtRNaUwQbGeP6IbDEPm4
 FK/X6+s
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr29516969eec.2.1793768762213; 
 Tue, 03 Nov 2026 21:06:02 -0800 (PST)
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr29516914eec.2.1793768761386; 
 Tue, 03 Nov 2026 21:06:01 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:01 -0800 (PST)
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
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v14 01/10] build: add optional librpmi dependency
Date: Wed,  4 Nov 2026 10:33:14 +0530
Message-ID: <20261104050324.733555-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfXy2YumpCpJ1J9
 +aZASTz9PrQHGhCxzXqTCbWKuwg1kINlUSUw46Yh5GKs3YIXHS9SUHgCvDVhowmc+pq5Oo4aNAa
 BtGsQeBcp4LR6RYhPovwCR2MmFHUmAsTkVC++hTOKmsO3wfCyQ5cusV6OYGNO8ZYpEjPXo2tsvm
 Rt6SzC97Ip85voyiWn3jZgdedmByntmhzSrFXkejFVRm2pVAcUTX4floPG1qoTROLCOa0SuRPMU
 FNJTPwCF00O+Y9/HtuAeNPXTqFfMYSVNcd8fXZZupDlPtEi94vGwj+y0yElPUt4hrZQmsshFXMa
 hNtjO+Ral8h5SzxdjhB1iTbb0ThsPtFurF1HmpZS9QeL71dNUxv7KyDgBW605xlzWgtPLGOI/L9
 SI7hzWeeBMG1CWq68nrp0zIjQDYGixKAwiXwdbs3BwzEZn1fYhlR9/urpWLWHYGolZwQLQT0THi
 RLJ0g8xenqLfW3q59ng==
X-Proofpoint-GUID: TBtBVjnu_AZZ4tM80KDDcG53DPguQTMs
X-Proofpoint-ORIG-GUID: TBtBVjnu_AZZ4tM80KDDcG53DPguQTMs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX3HG7p6qi/mth
 L0tl67gZNu8JSkchoRe7Y1xtZ0HeVe3V0+KbaLaWL6cWzDsZkYVK0L9pDsgutpClgb6AR8/eVbO
 u9A64Y3HO7W1WcjeE4RiophqtWZj2NU=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeabd3b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=1s-lSuUWbzXNuijj7TYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040020
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 71f135f053..434a193efe 100644
--- a/meson.build
+++ b/meson.build
@@ -2026,6 +2026,17 @@ if lzo.found() and not cc.links('''
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
@@ -2449,6 +2460,7 @@ config_host_data.set('CONFIG_LINUX', host_os == 'linux')
 config_host_data.set('CONFIG_POSIX', host_os != 'windows')
 config_host_data.set('CONFIG_WIN32', host_os == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
+config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
@@ -3286,6 +3298,7 @@ host_kconfig = \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (librpmi.found() ? ['CONFIG_LIBRPMI=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
@@ -5036,6 +5049,7 @@ summary_info += {'TPM support':       have_tpm}
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

