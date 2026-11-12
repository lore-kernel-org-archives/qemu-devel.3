Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E5606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=erdGgyOW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WZXNfiLG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZGH-00020P-Q8; Thu, 12 Nov 2026 13:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFf-0001Nk-8g
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:10:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFd-0008K6-Hn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:10:22 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFaFFG1112704
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Szxmyh6AHSFS/1ZMahHiUVQVJ6UFuz/SaFCJMKqS+LM=; b=erdGgyOWXQpWjs+J
 qtDxve+5y35dZOI9DF/Y2Iv4i6IZ+o42r2AGWkJhBMi+DEK8i5qO3H5arF4xqtQI
 agONPZrq6MijPQWOLFPH0spMFAUyCkRAvDZwDezFs4Wx2uCOx7oNPeO5IUYg3WeD
 QlRen6LNy8lL4WhHs8Nz9xzol6+U//o8jEOY2NsTTJjJeAYqCggF7PIhQxGYrgiz
 BiXsQEgwCy37SESj0nS5eiOdCkRNJ4wa1rfVrdsN1V4AEuAAeBI355Yz1JvAkne5
 DaX53V4+36A0y2wAECyHZRkXycsn3/nbdrVfDPtljJ/2CHUcX+e86j7YfGwyDHYT
 NPbmEQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re2wp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:10:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-990ca9607c3so83556241.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794507019; x=1795111819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Szxmyh6AHSFS/1ZMahHiUVQVJ6UFuz/SaFCJMKqS+LM=;
 b=WZXNfiLGy6hWVRZKh9XDH5ne6gEv6SwuU87QK+lWv2NB1hjgQTPhb+rwxJMi/zr+XF
 dMA3WybMtTxzxkmCBJUfo6TVYXtIIcD5Ptk+r99Vsiy9kSkC28Q/7sN22Jz/W4TbeVoT
 6f1a28nha4F25cEib3Arf5xsIl2wJ+r3GeLZojJ/JUhvsTUVnxgTpO92OkAPLbq8rKTV
 eMZ6Z9/pdN4pXGN5HjVQ20ii6JRjp8ZVwL8e11rEqa6XDOU2ZImZAVJJGpv083PKk5CD
 UEG17DQaEsZq9o1+g8BsTqcOe2WRTK7aW2t1lGJw+PxdJzinTIchIYdBn5+I6xLWvnit
 tE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794507019; x=1795111819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Szxmyh6AHSFS/1ZMahHiUVQVJ6UFuz/SaFCJMKqS+LM=;
 b=OMiwFxYN2Ffu+xyr68gc9eautP55Ap5EP+tmGzVa+SqrxvXL4i2Do35ywDJe7OVio6
 82Zr5L2aZU9R9WfV67arLRI/+SylfEmrQIkSmx+msuqAFw/90n4qIx47JUjTN0Aw5b7l
 EkJNK0daQqqilvgyFLNFgHDoja8hHRMMTUIYy5EM5kEq8vkxLyYhpUXI0UQjaTVZSY7N
 EKDBQCa5qF1xhuzh/dnjpBhUbgk/tEet1FstBKiB7ch0u1BRYZgAtRUMHtwXdkfV8Wlu
 9HfkiefW3C6+3OLLi7sj1QGePIKRIXJ0G+4Yh4BKJ2ycGtOh9/KHmth7TSSwrve0W+0R
 9EPw==
X-Gm-Message-State: APuU4Z+dPMkLp+4GWYz5lChN3fIA1/UUdmgjF737vT/9WNm74HBbiCk2
 qWpFhnOWERQPHxY4VejOHE6zN5BZClZL1P4opvJo+RxyKgLvsAMc/hGDNpYigegshwAirlHEPcq
 V0MC0C7voaqCYdO8zGCvLJQguWC/bjSxaY0FTNEn64PEeDm7z44syS5zXlClR3lXfTca3
X-Gm-Gg: AYBFou37XTsZmDgu2oudvZHcGS9bVIzdXftuhItHbq3tAiYzuDFLGY8LnjX6s0jA7cC
 btwomVM+ZnqqD+XjJf8qazCB0NM7JrfQ0c+n5rF3m6bt3FQzDdhZ63jOhQ9XXS5hsIVfqY9VV6w
 Mx8XLq+P926QM9FpXayh9M0VyBhN2xHR8AouXcWvfBBDP8MTrLESwZ5RaE645F6iu6tJryw+IiU
 GT7KNH2nKMfnq+XdzE8P7QhQaBC/i6j0D7OUznGQNqWMikbdYYV09x5HlIugkZfY33UJ5WjnjrD
 TJqHhRh21Nd1+VD3Tr3kq5htWiusELtsjkCJU4V+NpbnoBDw2O0a4s2SEwiP0Mj8kOeJGzt2Kuu
 E9LKDisr4bMY5qsB+3epB2ZrIRT4WHsfstCg4Jw+KxNhP3z3nYQEdskXKRf9o7pqE88dkLlBYRV
 qPRJzh8g6Yo/L1GQ==
X-Received: by 2002:a05:6102:84d3:b0:7a7:198a:c2bc with SMTP id
 ada2fe7eead31-7d50624a2cfmr2480727137.36.1794507019109; 
 Thu, 12 Nov 2026 10:10:19 -0800 (PST)
X-Received: by 2002:a05:6102:84d3:b0:7a7:198a:c2bc with SMTP id
 ada2fe7eead31-7d50624a2cfmr2480712137.36.1794507018661; 
 Thu, 12 Nov 2026 10:10:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e57504sm121259335e9.2.2026.11.12.10.10.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:10:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 10/12] meson: Support Linux-user executable aliases
Date: Thu, 12 Nov 2026 19:08:56 +0100
Message-ID: <20261112180859.85380-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AQXVOtQgKlMKCFUohyjqHqnGhTakEESV
X-Proofpoint-GUID: AQXVOtQgKlMKCFUohyjqHqnGhTakEESV
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af6010c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zs-5URzUCjn_2RNnlE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX8b756yX+6lCV
 U73fjjAsvwkz3u4KNCti+ybbSYDyhE+2tOPKM2W6pJlTJKVWJ9y7jVK/s7zAff92AZxHQSMsDo7
 lidWDDw65vddfS1dbBEAbqIL1sNetPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX2Y2gBhJkHDZ8
 XuVrNg6FMh9KMrYuc6MOOW2QzlM6v1iT/9II/CAEreGLOqj7mHFuq+ghwSVmva5bVQiCa5j3TZ+
 wgPYdhQrTdf7Umw6KEI4rnrGFY+lOmUBFbqw2gacdujX/iTs4OM3saumSelm6Y1FxkPb82VJxh4
 bJeORE9i6ES8z1MmEm9cDv2oRehGiXbfrP0fSJOq87V3X0z1mXJTX51SPgXKrnZkJb2jK6e/Ftq
 BRGE1MNjdieaJSl9zuAw53m3DMgj8j25jxKSTXyiGfijV7gH8FBgRS8hpwsByMPG9PD8duFkUhF
 X9CLSOdLYPvWQxGzeltjckhyCkWsSw+O4QSIv78zZ4w5V4Z8WRIhYMDkT1n2s/Y3ACS6cSXdS4i
 iasNLYcxW8Wf7niCY7+IicpX9/qUwqIcZGiass/Aw9DUK8yU7aS7i+KqVg/lNLidZoIlC2oa1Ar
 fBLlfx7OlzmXaBmQCYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120072
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


