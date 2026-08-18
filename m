Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31374C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQB-00087m-20; Tue, 18 Aug 2026 15:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPy-0007lv-Bp
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPv-0006hL-U6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGeVC1517999
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=; b=P4eEXGRSC++MmFBD
 Ir92goiDLc/XR+znzJGHEsnmJymK0cuVnB07gC0WyI25B7NpBrl6zlrbkWjzppV+
 ACCXcB/HMENPJp92IEe8uv14Qf3JFfR9tKc9RZ1iJ6iy/Xcpa20MljLDz8lYX190
 gYM8fzPwqP6qhJrOs0o6KC2CCANnpE90zsi4ffEN0WBhD5gGf2KGQUxzEX+K09dM
 zJozlaL6jlTmB2gicB9zZuGEPN3epIEFllMrnhPE2/8ENYv90GD+lzthCz+YhhMo
 PnkZ76lJcMndNIlj0oVL/mTiOLV3DXPyF7D8uuKqcSKeDxfKUNxNQhkBbzczPNq4
 5DXiAw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0nfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso90985a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081040; x=1787685840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=;
 b=eU0vaBRIz+o22UqRS9orxSXaDgtwaT01Qyj5L2njjG3p2Q2RkIiFKEiySO+oG4sh+N
 EMWBVJjLlXnyuM9fM2M/AhYMuX9jAQDtNmuA+ciuub9USp27A4K87yeBQsg709ooUe6+
 NZ9k1a9psgQtAnpvCVb+Vc9deWc27oRPWrB3e038ShrSXblA+n0sHzPPYBULWntMPvFl
 JXFeCZON3UZ0hiUmV8nhkiFm4P/eB8iV2oASGs9Z/JhffP3CWWX8NhcB8fAPHpByFP7w
 xqCpOQL/LKEa9jGQq+HaSaBFdpXv0E/6ph1/yAgSnWb7WQ1nhUaWkn//V4uaG0wjbWI8
 GU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081040; x=1787685840;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=;
 b=rKspFw6xWE0BzDCMhWh5rUXuWC5la3tOnGHy6LH8q5pW2GlcPjPNpk2/34UMQKHSJc
 ygrx1nduyT8rla1vcKxqvrF/32XRVsk86At8zVXljWV3g1TMkqfFgNJ9+k+Kg2EYNwQZ
 NLxgx8hQAiFWEWO5aoIRO5JV5AHqtjgPU+h8PgMh1QaOxZTKxUvx+dpyQIuH/AUDrUs3
 axNmy7d8k7AWyedt6FDQ34LMSU2ynKIhhj7qi9xi/Gm+7XWrSaPRURa4zbYd5y92TsB9
 oSzbhutu0rx3OYD+3VQ5fg734AkU3K3cDLYAcZusnzzFmP+Xs87daIXSPLoc/x/z/1uW
 /JWg==
X-Gm-Message-State: AOJu0Yz0dNHvSZelnKGC0wIoG0FgGpfQJaehz5P7+SGcRY0S8xAe/fDa
 hKeSnoe5kQl6WUGRSpRAy8vLH6DcAgUBVj5QMkZHNSHPcreeZR6Ke3lJ/0azqXH6pw8LB9+YycM
 T/oNCXpGBLHxwqMgiy3F+cCFCU5Lm2DjPo2DopJTX8W/wRuATPDh3AxOBaZ2k9YvT+w==
X-Gm-Gg: AR+sD10abL8sKxh4PXjdGoPdwc065+q0l89O0UJNIR7a1rRRoUl/ekXMqFXurfWhKh1
 qC0OjIkBXAexafslGJGoAn5UmatGRFS/K/y5LfYYV4wQJPUlF7S8/QqEl9r4VvbQJRm1UGWSo3b
 rJhhWxzpshs7FZZiGYW8fh2/CdMH3+ng2Sra/LwHGA7wBQeW4I8U4j00kQZVWghfh3Uq6YTGZYi
 TT+YTLEe4RyBVrJ4DhY4BxjEY/JOKdOSFEjiELLXmnZe9GHdrBZDd8hHRlnrVakCdx4moURX2Ik
 DyM7LojnQtsCPvorJ5KRwITrLuQtdc+o6y8ynhkdzHYi3xa+fkqPxD6sOUpDZstWIPVALdW+Z3T
 uPXEljwrVDGZC9S9aEMFdC5mdo/ngE4u3/FZoAjjTBKH58kZr9DObWN3xxNM=
X-Received: by 2002:a05:6a21:512:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3ccff0cbce2mr151474637.20.1787081039700; 
 Tue, 18 Aug 2026 12:23:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:512:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3ccff0cbce2mr151375637.20.1787081039186; 
 Tue, 18 Aug 2026 12:23:59 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 029/104] tests/tcg/meson.build: check host cross cc is
 working
Date: Tue, 18 Aug 2026 19:21:53 +0000
Message-ID: <20260818192309.22169-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX13Wou7TZfEnw
 Nf0fZk3zhpJOt/sYXLUpIm3RUsm4H3PRQEht+dvLo4db0TpVyIP2hVmmrpoV2CNBMDQLvdJqwU4
 z/UkjnlkqBlGQrwcx+X6gTOM9tk80izlMO0efUcyqR24Jjo7ja8RASdAGfRbL5dqO+RaNGVLjQh
 tMO/AGFqE/a1sOcwrgqAW5PRVZQzxqTBfNYID+C8pNvW/4ZS2wz1dOpcIWRaBrG333rtuIYg7x9
 b8kLsaS31uEGw2v7OWIr+/7cvJRNrANapceXdQORQgU7jZHOs4NbGV7Z4rLh68HrYG2TDnnbZFx
 yKlNBTvN800xN0BRxsbrhZVAX01ogSJMGWSUP7q8MnBK9ZfnN19a5/PPF3yGD2nW/Yq0yogZAT1
 1C1rY8xRrXPW2yBguY6ZxMVctTo2fTj6kh95P9Dsx9UUk+hq9kwEZmRfQZCwUhTb0wpqRqRjE1s
 JH/XzNQuXarAEBLpb4g==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b150 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: Tc1Tk1slzyZ77Tb1nXmcUKRGq_k7dXTe
X-Proofpoint-GUID: Tc1Tk1slzyZ77Tb1nXmcUKRGq_k7dXTe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyh4kKqvsYhdC
 mXsqLK55Aucf76kXGIxLGolFal+HkS5YV0IiHcu8rmU6wVLJHAkYkZyGhzYkuMi1mH6q46bekLG
 5C8pG+DrIgbZP4caFJms1ARnxoZvnLI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 12 ++++++++++++
 tests/tcg/test_cc.c   |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 tests/tcg/test_cc.c

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ab7090a62fe..9809695f3b8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -109,6 +109,18 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-ffreestanding', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    has_cc = cmd.returncode() == 0
+    cc_from_system = has_cc
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..d3614a01fe6
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Include a standard header to make sure cross compiler provides them */
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
-- 
2.43.0


