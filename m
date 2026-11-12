Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED988606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o99/An1G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EIHe99bl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVSP-0000yD-I9; Thu, 12 Nov 2026 09:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPy-0006md-H7
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPv-0007Wj-Bk
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:45 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACBEVxf3893540
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Szxmyh6AHSFS/1ZMahHiUVQVJ6UFuz/SaFCJMKqS+LM=; b=o99/An1GsIl8P5xS
 7nJtTcSno6AdLHGZgJxS4Clw6g5QnQMrS7xVXre9VBq8krA6OV6Is1sRxeNclI1K
 NNVfGORJ394c0pai3kZsewFUEYfj6eWcXcNhoJ8TuFnzWviEEUgN/k2Pgemsx75F
 twrNRZBBoo3PoAGn/t8lvd526aPvM+Dr7pcBvDHPvnLP1warGWEGZ3Ncm5ZX12Gk
 YPuMfU5cpK0gHphvDcuV6pfADKHkD4t+vgwHjne8K0kbS0TorOneYZ9PKLU3FM7o
 dv0hPjQVyfaa3A8MeZ9adiBcSZM0IUREFdP0WOLuyiSW/b1H4NLTuWPnh8bgEGFa
 vrVX1A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re1w6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ecc172164aso3194717e0c.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492281; x=1795097081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Szxmyh6AHSFS/1ZMahHiUVQVJ6UFuz/SaFCJMKqS+LM=;
 b=EIHe99blfaX0KGceux+LLsF8vnYZBmsS7/lAciF3e6xRVPUTLeHJrhuRsrvxj7MC87
 1sUmHyWHENX2Fl6rFyybMJs7KKwJWXudE8bwl5T2IlmEBN8ph+7iVmyTdxpjDuJX+6Kf
 spq0AGo18sDf7SlxriHtbTU8Wi5lsI7vqyfHVdt61j4e7jR5VvQngdtc5QiZI7sEpYFk
 kcLk8pyq9sl6EO7z3ATCMrv/lpy8iHaKXgP/5uGzyOVx8AnZImSMGlaDdyEvKVFSO4Nt
 9g4DM1DEXixvMvhYF3VkpNULqVYH4Ae9QjFnIulDzaC2LMkV3jOhahBXXbZ/cnq4xvDF
 hXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492281; x=1795097081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Szxmyh6AHSFS/1ZMahHiUVQVJ6UFuz/SaFCJMKqS+LM=;
 b=A9/yFXeXqS2xs7t5GgcBZNXZuUNoz2wbgqjddfF+Zce2UFvb5mlpPXP7fxzWBQo48P
 OnPNeWkIApAEMM0kFrfeTjazpdGbEJB+08Eq+A+Tw4I43nhavwg3ryPfkQYoV/I6dmO7
 CWkE7pLsQw/TJYrLpjdKzRcqWJEhhSMLNUA4HojS0/Jup/jpr8IMRJ95DA0Zblk8gETv
 HL2g11CrIKjGNWq1dpo8XHOD8eyqltfQqVdUK1K41k83VDUnFrRtnwzV+mGhWNLNWRe5
 DvUduOs1N7Tw/hE7pXo7jvgR57agyGMv1oVARFD+QUGlIDbdGmHS0CaDCOZu80d2yMxM
 nM1w==
X-Gm-Message-State: APuU4Z/mg1WPHQ1/sLnwdeQYzBVpVXWkCmRJxQPewEt/zqTlmSErdlv7
 YUAkI0XD9mlus5g8nC8WzWbomoQ4pXNz7rq41XMzvaTf+BYZXfwWOqDtduTLmzYUtpL3ax6voHa
 8rZ4z4DU4jsjMMGRlTIT4Kn5Wpbt1jzEjxIxMHtrXsIk5Z9EWSVVDDpmiVDH5B74MnJwt
X-Gm-Gg: AYBFou0yNYQoZKvCs1/djgPPyTw9SZidBztfnZtYkga7kpD+NgwvYynAuqOwpjLLYp/
 PH97i5vQaZZX/J5eWlTbmAq1ks8w5bPLst8Frqlx5+eiBWFpDAIVPCMQ7CLhuw/Hxoam828Lkc3
 1tDHJolVz4EAFnl4bZ4adKaH/BrLe+4lqN0lgrgDaFWqkrunhVnTsFHA7No3NnW+uOC9W2Nvybm
 sfKWKmxy1IBLGC9adhLvKCKgGHZpWQaKOTMr0dmcmSH8iZaVRN5+KC78cpsVX14WiH1M6xL7O8E
 yrai5G1YAJ7mMfpLzxock2IAtJRAHFajweykc9zUFQk4Y7a0wdci2vP/9k2HapM4ELge/x3a9OT
 L85KsZ8wQjgZ6/olr3Sk5se3YVCMy7n+kIqOw5JOjj52fYNGu6wScP3b/v6bH9sbZXU0A1MMTLD
 0=
X-Received: by 2002:a05:6122:d24:b0:5ce:b65d:22c4 with SMTP id
 71dfb90a1353d-5ee1c41ab4bmr2728224e0c.16.1794492280497; 
 Thu, 12 Nov 2026 06:04:40 -0800 (PST)
X-Received: by 2002:a05:6122:d24:b0:5ce:b65d:22c4 with SMTP id
 71dfb90a1353d-5ee1c41ab4bmr2728154e0c.16.1794492279919; 
 Thu, 12 Nov 2026 06:04:39 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e33ae5bsm66292385e9.3.2026.11.12.06.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:04:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-12.0 7/8] meson: Support Linux-user executable aliases
Date: Thu, 12 Nov 2026 15:03:42 +0100
Message-ID: <20261112140343.61634-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xTx8jZtgjW2LhrRtBgFh6r4ag5i-2y-j
X-Proofpoint-GUID: xTx8jZtgjW2LhrRtBgFh6r4ag5i-2y-j
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af5c779 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zs-5URzUCjn_2RNnlE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NiBTYWx0ZWRfX2pRUORRV3twp
 QsvpLmhZLjC5Zb4LeZts3e5oQ88zSNrgYfDdDounKqtDRwqCJ8X0eB270WKO/H/b0csEN8XP4Tu
 BKtwPYXPbmf9H6v3PSYMGMhj8XEzAAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NiBTYWx0ZWRfX+L97Qcu7MBgq
 KZqIw4fXiMBZiDVSVq5dZwx1qrNZyCxyj22U3h9rhltxdc3P3TsG54BxGWt15Ksp33P7GveIbMT
 FH0L/qrDWohTq05p1p8zdyfWROwLUVXsiizBMSs2WV3JepyUUf7UVGhvJsKBxDOl03Fhk58hcol
 lmGUxMB5LmVXFYf/swXFpVxRTCuteOteAXCeaf8uju4A81+y2lBMs5aJycr+R62aYet/nkDR8fd
 ehiczfqUBMvz4Yz1wdvFJ3t/hgxR8FCVK2QtJmVdAhLdcE2n9AW9DMbW5xfuiGRA+LKQDZJ4Wl4
 B5R0+UCXUlyAj4Ae7fvE3bh/Smdb7bSGgQUHZT9QUHNgV9rw22J85A851UehFpgwlpQj6/9U9mZ
 PDmR4iJohoWdTAzYVOnDT3C1lBdZCrdpdi6TdOFJ01PLEzvfaIMIZ9z51h6cwPosLSJVZDQ4AuY
 PRFeKtiQPCcseP+5ElQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120056
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Accept TARGET_USER_ALIASES in target configurations and create relative
symlinks in both the build and install trees. Depend on the canonical
emulator instead of linking a second binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson.build | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 04cf5d77f188..86b942640abf 100644
--- a/meson.build
+++ b/meson.build
@@ -3297,7 +3297,7 @@ host_kconfig = \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
-ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
+ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_USER_ALIASES' ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
@@ -4580,6 +4580,17 @@ foreach target : target_dirs
       emulators += {exe['name']: emulator}
     endif
 
+    foreach alias : config_target.get('TARGET_USER_ALIASES', '').split()
+      alias_name = 'qemu-' + alias
+      custom_target(alias_name,
+                    output: alias_name,
+                    depends: emulator,
+                    build_by_default: true,
+                    command: [find_program('ln'), '-sf', exe['name'], '@OUTPUT@'])
+      install_symlink(alias_name, pointing_to: exe['name'],
+                      install_dir: get_option('bindir'))
+    endforeach
+
     traceable += [{
       'exe': exe['name'],
       'probe-prefix': 'qemu.' + target_type + '.' + target_name,
-- 
2.55.0


