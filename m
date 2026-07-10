Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39C8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEf-0006Vh-86; Fri, 10 Jul 2026 08:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mk-0000Xg-KR
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mg-0001r7-CY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7dauL140860
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VaD0AacToDf
 loRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=; b=nCZQmjTzNnxPlDFjQQPNpJdxteC
 WGu5xykoSG7D4Te5LUJ1PcvE7bKhHCUoVhjdSaZEV6Ts41JJS6xPgYHAdWeo94ag
 NghVrmJd2LCpFYVrJpvdpd50fDYhiNFe9A5S2R3CafNrsqiHA/in0hoMSrUJLeDh
 juPbwaaHRUt++qVSdSANzyOYK1kxlYsb9aSdTIuXx8N4+byEAlqfm05AsbIr7iZa
 YMV75A5MYLjYIbdvSpVOr60tLwBhwX48kn6XNc2T0I4kvk+xPsWGUPNhMcq4pbUM
 gqbVkpIJAGFWjkpI76//+SGg1NxtS5mD/vXSyOwJTWrVw2Dzop+sAvLAWCA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpm5jk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388277fd89aso192704a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783672815; x=1784277615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VaD0AacToDfloRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=;
 b=QY9vPO1S1MLUsOiJcIYHX7KpiaVEzLX22FEn+5dAwH8/w7//iiCXD7akNd7ZulOBZD
 eTY8n/HQeOK1sxC1DtHpLK2f0vv0aG6/pnA4UarU+hGgp+wxOazhxbC7UgA+YWXL/P6Q
 7oC9XYiAps5q/Bve38QNrmiYeF1lfVGIzdvw2YBCpcFUkjbCfpgg8eNznCEH0C4BvLCE
 ZtYzFkPexnfIrm9QQsZ9vuPEOhgEe3zCCKI3/KzIigIG9eCKiOXm9j/9UPTqkMp2rNDZ
 nXkzZzMMlZmSKJu6TA/xHdhKl7+mqFh3nvn3lVcuYm2KY+h5pI2kicJFjzwX3RB0UWhH
 tpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672815; x=1784277615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VaD0AacToDfloRwmZ9rCEJAESLcJZa4/t4f8anAA3z0=;
 b=VPwzpELK2bnlIV6LCWWFuFgQep0gvgWUs4wePbWHmdl9FCBLJfSwnXGDtWsy6tkApf
 Lhe37+06ts/L+u/pUNvjjuY8aiSq6oAId0xgh5gwYMvuIpiRN/YrDpp8dCWTDK62n/xH
 XD8iC1ov583WeN7Yv6D50UPXnj9SsgtEP3lasfYOV+Xfj5/EZ34etRhfy7KbIvbfeyob
 cwNeLtWxi18CR5sRIHsTtB3V3wRzJopBWxc6KufVApSjFiMOcSkp0QgIoaDJZoc9DSMn
 TcLU/XndTbI7qaJpvYjykHLejcPcnY//N4vlepZHKsbk6R3n0iR81K8nKmyZWQyGJdrh
 NBZw==
X-Gm-Message-State: AOJu0Yxl9JcxOBaUAIU8RvG3cX0448g3+3uD5biXYLdBjet4rkM8R+R4
 h4H8c0uvTHTCe+iOZCwIrtomCc4MdIkwnOUlDr1j26zDGcQBzlYiUPbNNXUGu8uE5t98PDy217i
 VMwJ/tXV8xd5DF2qIE0GOVMcSv6aCSVIFPub1bC16jkt31/HLEv/I+F9J0A==
X-Gm-Gg: AfdE7clhPdOF65bBz6M40kq5SVZdDwWXU92gtO7277Zy27YxzU9Y0258laU3PW3NwmN
 l90iEC4PSvri6E6qJF38w4LMc1EObLG2aCUyZxz8G0LyjKiYsdrDyd9k5JD6P17DgVYFji7CpSI
 xiXuhJpDBIT2sQgItzqz6oCkUq+/bctU980MmYRjMYOAqCNwF5QowCT/bI6HRCptrHMc8itbI/V
 b20LjmPGyHIWUFI2xUf6LtYR+fu4cws0nDvWcZTO8ZCydN67f2JRo9eRjsipYZQMf+/JFVrCPRn
 zmvJlbRvYBM9tuY0TYtb57FCJ+5UXOiaqvwHRykuhr2BPz0e9NJoDUnKDebp+hUyjsGf+VTiBTG
 r81pjJ9WNoKCq8+a4Zd+BxF2bTXcl0fByXZRtuEdxsgZhXPKdSMUytEggbh+JoGM0dchM+e4LUw
 M7uYpKwG31ZMzm1z5WPd+LWaZlxAwP9E2W517qhsiAuA==
X-Received: by 2002:a17:90b:1d50:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-38942b7d8c3mr7837429a91.8.1783672815066; 
 Fri, 10 Jul 2026 01:40:15 -0700 (PDT)
X-Received: by 2002:a17:90b:1d50:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-38942b7d8c3mr7837398a91.8.1783672814543; 
 Fri, 10 Jul 2026 01:40:14 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm29164925eec.20.2026.07.10.01.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:40:14 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, daniel.barboza@oss.qualcomm.com,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 01/10] build: add optional librpmi dependency
Date: Fri, 10 Jul 2026 14:09:43 +0530
Message-ID: <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MyBTYWx0ZWRfX9N1t2SnOIZ7l
 TkqU7uDhrdiVOBXkZaOmRpe4WOcIwK03IL/x81sZN2TC8buNu5bObzodEvIfVOmu22gMsIjNQRp
 bQHmUhkmdo+bmiSGF8BXu9cq7Z9WgEku1MmmgEZUvBvQCRbvKHS62mtKd2e+cNGoJyf1KgfWVld
 IKaADxf7cza8Xi/EVqc39Hp1b5y1LuusqRh9ZpiGhGJqOObLHN/4PVM5h7JAbP5+PT2ac2wlHpm
 51+f/2ak0wfc0rqTSijIQxbyryAwtWa4T46OmFVijOB6/and84K3n3n4VNIglMZBR7ksNMrRCXi
 DmoUzHi7f0zUbLHmBC3d0n7BDpxEd6AcvGxzjOAxCmOG5xlHeitWMGeKHB2iOzS4oEEvZXQ5UwF
 N4w8cvwjXVKOKWg2/IHMb5iDuVhd0THj5lcNnvo2Hg5BIY65tDu55+enbv0YL2Ylgy7w0bqeZyS
 +18dDdfoE5Vt8d3fKiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MyBTYWx0ZWRfX9HVdnmaxJMOo
 Y2y7pFuhA/WhAViiiHuVJHr/l3em0DhzYnk2h/6hWOyXJKaHpKBJClqeg9hlZduskenYDGjOxly
 Vbsx5rFxkW4tn2oKtmulFh/ioGkcvA0=
X-Proofpoint-GUID: eXMrgZYfvwxw-aKVdbcq1p3BfUPawM6d
X-Proofpoint-ORIG-GUID: eXMrgZYfvwxw-aKVdbcq1p3BfUPawM6d
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a50aff0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=_6tmRKQHnRYSWcN6IbQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100083
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
Message-ID: <20260710083943.Huw0a0wNnXlCX1fZDCYE-JkDgI3V8FXJTkqErFLcbiI@z>

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


