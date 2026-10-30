Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8612606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjsO/iqS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KFNMHvkS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqjg-0001vX-4d; Fri, 30 Oct 2026 13:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqjU-0001qc-Vh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqjT-0007Qx-AK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERBtF2494578
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSctmo2X4RKZ4rSu1Ym24oiJOhiT3qAZ0tJtWfs5UrQ=; b=QjsO/iqSBzRwwUIB
 1KHKPj0AF6XBaDxhAJ5OvznGno5CLMBYCAmu2nBp81viMKGysM0K1HG6Af/CiIPu
 Tk8ZvRY18JNyziZI9jQr7+zYPSXiMzeox0rok9Ose307uMUGfqfYs16t2F/9vGy4
 t6S5tWOEyOGIYo9GiXj686N2SZ9OK64BWHZBWxSJrVanqjcZmJJ72CBxatJB0Ys4
 l3/FzJGcoZ41aTNTPX0T2eomCKRZP+WxgUtl0AS2QR+CMJ8Yj3e7K3kjFil7kZYL
 ZxEm3uSL3/+ahNe7oOwsN8OXSloulVkNuEguQeaMD9GOK9xT37BlE3Fbkd7qOIbg
 1jMFlA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4b7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso115392285a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382578; x=1793987378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kSctmo2X4RKZ4rSu1Ym24oiJOhiT3qAZ0tJtWfs5UrQ=;
 b=KFNMHvkSlUuRyV+1QaMkFwsUPC3lMqFo3VuXqZDYNI0Hpy3cfz53km8h1mY0upQtjw
 h4DnNqWcqR/8pW2x3vkhGeraNLGZKsrxUcoCYsqvTPvs6FChLju+3nrtj7eBct/t+A6R
 6PAiZ919ezfJ/Wu73xw34WlbbdXYEA92gAiyTb8nHgFvpJmHasiuR8L2FA/5db+zfOW2
 /2O6yzl3VmecKruaCGDGyyYL38e6PqtthpAUPUfQOzudJu5anfrFemztnB4V/O9Kx9ly
 vrAUrDzumMFyQDcTJ41IANDlL8KUy3Yot/j/8btt2IlR2oqRFYdC4nnADct+gLdCcsFF
 XFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382578; x=1793987378;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kSctmo2X4RKZ4rSu1Ym24oiJOhiT3qAZ0tJtWfs5UrQ=;
 b=gHyDZZbq+CcgyXj73zQe0cDGd+A3o6KHxN9BxxlTDwahLMDA2ALeqqEb8FyVpbvk5H
 jOieZNFcvPlVMI45cwOeq2gsPzPUnWudvV6UVhVnHAUbpDoazm8RCuprqt/byfQsaUVV
 VpT0iQk7gz9b7+8N4xsOPbAP12YxB92a6WnWY436lIXezXy6AhE5AmpSi2MN47AANnc9
 onsU0xkax8mvV8ii9kCZp+OyQc24RqCVBywAj14rvsHHJ347YdRJgCsuNhfGZzhok6Wh
 122j8youl0Dp0Ef+5N51tqn9B4itxnD74nBRwholjtIz+FRcUetdUKINhpxZYbX3CsZq
 vhgg==
X-Gm-Message-State: AFq9FYLZ0kuOpaTlkJrKJqpm6Y+W39vIk6dFz6tcTfO3U9u+kSNZkQkU
 CSK67vXm4awryf+2uFKQw7SvOCQe/E8d/JCbO/21c2Csrg+J94jolo8WkDMJKGTc83EzZKTlXWl
 Y383roCKMAJ5xdnq6ZRCXzjg7/vr53Zn+EuHQg3JbPItP/eOpjj0I7BUr+dHkd3IOZGtp
X-Gm-Gg: AYBFou1ElWC/UqeioqorpMGGsFgNoeaaaR5y+agpVfNlaVBHiuvh/a9U3KcjpM6kkwF
 oFa4wlAJqNoJhqkrBd8SEVxEMio45B5fj3fLuCbXXCVrAZt+/bi5aenLzaJouZXcJ2mdDQyecZP
 uARzTMP5LZAVEzrRnzmE6IuDU5Mf4eAHhUDgymcHR7cHGv3pcg8q4JhVXhFaelKcKFLd51jErew
 I/rm9+SmjWILmR53mzjtURE5cWNu/X52KJAmxDtflIGoZ+enyRpU0gwHhlU2qDk7fthgHAEX9fR
 V+J9gs/tvWP/SuBLMQGxKh0O/0hUmStr3wpGeIvSJJ99GVEXTWcG8xwBF8DKzWWSr46KwQStp1s
 jYdf1SSDRyOKeLzlhJ8XVudkfj8Sk4j3YgbtSb1it+a0TJxMR9Hy08KR5z86kVa6a+qmyk9N50x
 7nhq/IOuia6BGF5v7sHGa9eaoG7IhdLg==
X-Received: by 2002:a05:620a:4112:b0:93e:9627:533c with SMTP id
 af79cd13be357-944216fefe0mr500012585a.50.1793382577582; 
 Fri, 30 Oct 2026 10:49:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4112:b0:93e:9627:533c with SMTP id
 af79cd13be357-944216fefe0mr500009385a.50.1793382577122; 
 Fri, 30 Oct 2026 10:49:37 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm191341375e9.15.2026.10.30.10.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/4] tests/tcg: Allow tests to report results with TAP
Date: Fri, 30 Oct 2026 18:48:53 +0100
Message-ID: <20261030174856.98759-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030174856.98759-1-philmd@oss.qualcomm.com>
References: <20261030174856.98759-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX1XbbEVPT5Rsr
 fFwuZCLrgIBlrow561TYBrI07Py54PTJ1HXjFHgn8vUBu4YBh2E8xvLae3xtmX5+Oa7MXFNbS0D
 PAgkarZ300cBZ6lTONZBrpE8euFf4aKMLgTZJTc1BQLbbycjlcUrjRc+B7r3EmSAStAxF/WJSmG
 9LTjrmV7m9tSi7auVWSqtd+QSK1/Xro8Auau3c2oLdcjUKooy3RiDdL66EiWsUSxxegLFgzwdL3
 y+iWaEKo7npNI6eubm0Kg17JnI2AEhIJWZxVi9flM0Hm3uOgsTK7ImTmKaJfFjlRG5h2K4vpwwM
 nwHkss8zZ8pTVh2X6PXH+mRNvb2R7wanMZzRKjKPSTMI0OgBm2f6zTbGJSG1AgxSIgxeSFHbvoZ
 PhmK+KsqHaLPWSY0Kp0cFJPnQWA9iURWo3aFw7RxWX0FHmZw55cLPI3yng1cTMPRUreuHtzPL2D
 7ZV0svdDHZ2u9QDHxRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX8qAMbzwAJhBz
 e3o5+x6pnoXASfstCOUojDD2hhGtvFl4IF/092ol9k9kbRJOG4Z6dqZFEmIve+cfCCLgUinxMK0
 Fh+2PbitVvlGxcrFP3E9XzqXLCIFBks=
X-Proofpoint-ORIG-GUID: siS4SURUafgvPSDNG_mhue7y3szmx9GZ
X-Proofpoint-GUID: siS4SURUafgvPSDNG_mhue7y3szmx9GZ
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d8b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=T39o4DHrYQchOh_bDjYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add an optional 'protocol' setup entry, passed to meson's test().
The default stays 'exitcode'; skipped tests (exit 77) are forced
back to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 06f013fbe3d8..b61ddf805148 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -42,6 +42,7 @@ tcg_tests = {}
 #           'gdb_test': ['gdb test args'],
 #           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
+#           'protocol': 'meson test protocol, default is exitcode',
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -323,8 +324,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
-                   'test_name', 'wrapper']
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'protocol',
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -520,8 +521,11 @@ foreach target, plan: tcg_tests
       endif
 
       if skip_test != ''
+        test_protocol = 'exitcode'
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      else
+        test_protocol = 'protocol' in setup ? setup['protocol'] : 'exitcode'
       endif
 
       # Do not add a skipped test when compiler is missing,
@@ -530,6 +534,7 @@ foreach target, plan: tcg_tests
         test(test_name, env, args: cmd,
              depends: test_depends,
              timeout: 120,
+             protocol: test_protocol,
              suite: ['tcg', 'tcg-' + target])
       endif
       added_tests += {test_name: true}
-- 
2.55.0


