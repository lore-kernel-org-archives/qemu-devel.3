Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D97606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B3N5UeTW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lchkuylk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1Rb-00081w-Ab; Wed, 11 Nov 2026 01:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1RY-000812-Ij
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:04:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1RV-0000W0-FF
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:04:24 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KPAO1386446
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Q4wZP/ShiuYZUn1lGH7YdU9moBHfpBcSJIBbthl4oA=; b=B3N5UeTWYhMrI8i8
 w82KSVFn3O+4ciHoPn3vIzDmwOvaXMY/MpJs0dECoaXWtXxB2yq6nzo2t53PvRJX
 QAdX28hrab/zt+SO8EIACnoytJBWykBSFZJtkx0RBOJ2jUcwv7aq/LCAwlYnqEp8
 yW7Aay/jfPTiigaKslJ7iMZuaOaUt5jS415Qh6+xSe/XWUEffIQ8CCXPL1trtwTz
 Ps7Bpf/EVtBlR8guNYAuan+qybBBCoKHjzy79Y9/5BWMixZeayIVU9+jyjDhXc2y
 AcuhsEf9HQA30FDDk0vR/Ip6lA8bTa8SMhGIigTPLm02ndaQrPiKR3TrEar2rqHl
 tJAsXw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm9344-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:04:20 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137ec776b84so13602c88.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794377059; x=1794981859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Q4wZP/ShiuYZUn1lGH7YdU9moBHfpBcSJIBbthl4oA=;
 b=LchkuylkMeOGos6u84n6AP3WgFNxuHNM7sdEwFVliGdga+N4jGkOec04+tBveeVb2K
 EctsPvWnPSdOrG8fhwMdgEqenba0+nwCocEAUHiIvt3GUqeVGoRYa/AUIwsBcw25D5a3
 fJyviiUZw7a3qGewFpXI+3SFAXmI8Si5uYcnU0RhP16lKkzlvI328bUu/7i5RSIYnNJ/
 VmMFfbH81Vt5srxxpo0TTKh5czV/F1Iis7EzxI+aEuacjC6Zab8KvA9oQGlZ61DN2fY5
 Ou0LA+3OojrJhvZ+ss5f9M5zgEbtmOBrOT/8q+g+qXeXVQ97feDqW7cL8r2v3F2TfaGu
 017Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377059; x=1794981859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Q4wZP/ShiuYZUn1lGH7YdU9moBHfpBcSJIBbthl4oA=;
 b=SIX9e230MGkiT2VnnBquO3EwDzyr4I30gmyyX9UlEL5X89/7OYeo2SICss0svO08we
 h2fNYlbJ3HqebUomxN9SSRckihTiVaVzzcue1dANbVQyxn8Wo4d4RXQ5ZdoHbuWVqhd9
 EWZ3IOo8GxgvcN2N65k7f6x00R5TxgxVOzmrl2xCwITTpGjXbx/bSpuO725bJcM4wcCP
 HiHul9hc//WdgsGHrO/OY1HFSgpUB+3f+s7Xerf/5wnsfr2WHI4x1rBLAK4ipkRfMtI7
 llkl3JB2kDqwgBUywqRAhzjKkX/CpWvRxUaTfUCz/ysa+7F8K3blDtZ7PNMbTKuEgiDD
 D3kg==
X-Gm-Message-State: APuU4Z8xxVNREgauYR9HwZxAvMkiiscbUPrt4ccOtMKSw8n/1UUw4jlA
 AfLpnnXq2yi1JSf1EeieJO7KEsrjDJsa/lqq+eqaB9sInG2fEd3V4EpkabIHbjeNBj+hTN/YOjV
 Ug7VGKUnqlqilmrvS76zQRTnrmUwH9DS5ol3wW9XqgZsrXSpdJDeaFm/OG2mS376cTQ==
X-Gm-Gg: AYBFou1gEzeaFpBOmS/im64jZMmjDgENXvVTBrDDU273ddssVVh3xO76cBvX6FkUskt
 jP7Fc1I2+6EUIIKIeKlNCCSqA2XkGHgR+NSJuAmdPDAH+V6zS0dBfBBTUQkH86W84if1Txg3ERB
 5hBUUBreGhXCgyitpdKRdWyIE9gY5OMWYmmb8EMf4px/1u3SLVLS6V3rpdIiF231EyoalWek75h
 lHRhjGWRD8MiMdsgmK7+tSbNacsbjubh3j/InL8m2hC3mSVqdl6wzCV0LosUslCsChThVEMQsnC
 8GrUz4LUaT7Fxw7cOc/FfGl25pH1Ga483Wp1rsriJ1nnHB9o5gucP5Ww4e5cwBnW+34Vm9i0WD4
 9dMts98crqfWoKqc7zs7cyLMXnKhlmGnbDt87MOg0TGo27OA3BcL/kuF2cCzJWCCCAzKoq+Dd0L
 1TLZCIrXP3Ybfl4CLL3rvhyS1SLwNHM4VUJf8hpmkTus/whRa/MLQEOa475l1sjKklw/wOYDsdX
 yMGWTQ=
X-Received: by 2002:a05:701b:291b:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1b3c02d01e5mr2000810c88.1.1794377058763; 
 Tue, 10 Nov 2026 22:04:18 -0800 (PST)
X-Received: by 2002:a05:701b:291b:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1b3c02d01e5mr2000778c88.1.1794377058111; 
 Tue, 10 Nov 2026 22:04:18 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2ff3bsm15067990c88.11.2026.11.10.22.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:04:17 -0800 (PST)
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
Subject: [PATCH v15 01/10] build: add optional librpmi dependency
Date: Wed, 11 Nov 2026 11:33:53 +0530
Message-ID: <20261111060403.3777501-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8ARUBjOOKbxkpC4bOw57uk8wLyuVkWVy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyMyBTYWx0ZWRfX7u9EbpxbGpBT
 UQVshOyECNQ+CBaSgm4Xn7Z7t7FW0FY9/Ldq0TlZ+oc8R88R6nZ52r13QE9FlKTe15Qkf0embRT
 SEXUjsjglzGq6f6Vi2+xSLKJHrsvcjM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyMyBTYWx0ZWRfX0QZOJMyndRXa
 hD9N+AqV0UHpwIN7s1JXbWK7z1oi6y1+SRPp1G2Mu5cg8wYoUbGW+16MCtqReA3SH6reqNXalLJ
 ueAGh8L3/g4BVno+bK33hThe3yS9rvQoxKoBDGxT8hNG92BLPgG0EwmPtOl90WXW8yE8RULSzm7
 vCi4OaRkUKgvlHQ1yFubdjOWYdrpXQ951CJUZKn6i+oWL88cdvU9/BA48g1y7zVlGyJjX7JvCIT
 NCxXa63lbZkgnAP2XoIJ5gvx5G1mcHEwA2MoRciaAWDIFG6EJ3r5SUs0k5FnRsKMBN94bykjilg
 8fJ39lc3Zid8CxB01VguxRf5y8BZKt8ruTAH4APXUxAnXbnTNOJxIl7hBIdzRjq8S7kKduc2zan
 P15tXKyCaInbL57aYfKFcJ6uaqsqUVdg0k5Cq0zJlpzy98AAnvWvU8iO5mxH7JW+L2k4F/LqFCR
 cpafC9yx0loumWbKKFA==
X-Proofpoint-GUID: 8ARUBjOOKbxkpC4bOw57uk8wLyuVkWVy
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af40564 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=1s-lSuUWbzXNuijj7TYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110023
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

