Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29143C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOC-0006Lb-Qe; Thu, 27 Aug 2026 18:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOA-0006Cv-Eu
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO7-0006AA-Ft
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM4DM1803755
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yBasRKZLoUgUCra8VLFgHZNRrhUZ0qHuH1I/Q2k/dnw=; b=J+JodHPJ6q6Zs7st
 DabRqQyzWbfoIVDJaEyOyoKXtfNvcKd5lpJxcIUvWvuEbroLPqL84yKCk24lr8nT
 PhSm2ohJRISlZlfcZF1uqPFHq10E4ByPuhG3KDWUm/VTb2CugD0DZodfsObhPE32
 CIur21uaRAMiwbWzeV/R4rDiL0IpX7R4bRo0eaxeDsl+kTkpgNO4JejH5HP/OHsc
 YgdC0Efkv/ifncQmv3391sFohxhOXbSkuDemHNvyTQ4OOvDr7GqggQBcQ1iB3czE
 8Utyus8xLwEDJwgz4oBjdgvaqM6+asFfuvmiS9vpqdmARhE6dcJwsLpJv+WorOGj
 IvYmyA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgv5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-85602449126so904235b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868947; x=1788473747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yBasRKZLoUgUCra8VLFgHZNRrhUZ0qHuH1I/Q2k/dnw=;
 b=RqrP0uygLlGpsRBgwabBErrgL/E77ndzMmc99k/ShMLmPMWWKTeC9KM38iCzyEnDo8
 RKh47vrPn2ynJm0eKGRgPsAwnXQ27SBQvtkoyDhJQfLsusMOjfqzXlQDS2PHNmdB8d/s
 ni+f/CTBIZWnHbsdSlGAv/9H5j/njre1Hq/hSAzJgbZvOHa+ux9U3Yvm55TiMuZGkB0Q
 VXxevq2/eDd8i2sTulyvlNx240qwR8/WXkOgBIdZPdRvGau0K7GtJUYK+s8ECHdBOwao
 KVgIUZNA8bPRbMHYML6Q6IvQYsa6d83Zvs/KDtfq3l93CVtGZrDu12ViT+9C1eE5xob0
 AHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868947; x=1788473747;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yBasRKZLoUgUCra8VLFgHZNRrhUZ0qHuH1I/Q2k/dnw=;
 b=N1ELRYxGgG9cjgFIeij7zbecGtirbMZUn9cHDiYhpQMBU53wOV5rvZtQbzKW0k8V8f
 QAFNUwVNeOGAfNPXooSpx20Y/udazEbrlwOC6hPJyu8eo7G1zOurIbz2FNQMprmkY6Lq
 hARE3ce89xkODGo9fTevhU6cZFHDCbFahdW1rsrys0Fl7aP8/v2FQjcXeTk0KnBMNEoc
 dCf/LMC8cG0pNyyAmiS0/MMui9iQ/U+2YBKUHxw5Ai1yCNg9qs9EClLr6g84IPhLcOo2
 umMbJy+x+wmzpAPOVikiiux5kXhhoj/Li0T2IevuAPKc//zTPcHfUBD69xmAyKNNI3to
 W9lA==
X-Gm-Message-State: AFuF++nv+JlXzyQc2UIzITTkW0oDuFewbKxay6BgHadCZ9aRDMTdZ+uK
 R3uvzFifBy4GScHvzsKsdZedVTjjBAPGnyHSbvkbxMrM9YtGDPY29mqBZBxyJ7iBHD939+zQB85
 FoMQLqFWL0H/KAgqLYkpIxikPjpvw2bbbC8P07IP5vP+j/vl282lvJUT4MkweiVISUQ==
X-Gm-Gg: AR+sD13OJKsRagKRaTGo81WBgh0sN0GIq9qtkn3wAko30vhu55iqiTZ6ZVniuKdhZRd
 gnY34xfGJX5M/A0chDpE79zArnqdMgODlPbFcjv2uzuZ2sFZYxnhLsLZOA4iDwXqUvuNCDtdXGN
 TZF4VYE0+RQnH/Bmzsj8G2PYmBdmxOryUY/jrbvPa3kAWFTyRxczQTDs1X2Zo2tgOMsXtMPn2E3
 5aE/FNpcmmQzJWomaxSmyd+xruy0jy/EtmkMxKT6Fo2oIF1/bqXSM6bFVNPcpd0YpJCMje9Cn0g
 /ZUYMKfz/JnAyHoGDS8sjd0uQKkqj9BSX59lXVs2/fP+9WBhus/84EYghLu437DgS+Ujb2ruGTV
 /1cXmIND19c/VodGh+OkiyV6e+kuyW/Q0mzUK1tNx2Frl6Lgv1W867IKtfh8=
X-Received: by 2002:a05:6a00:23c1:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-85627dbfaf8mr4083810b3a.3.1787868947519; 
 Thu, 27 Aug 2026 15:15:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:23c1:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-85627dbfaf8mr4083732b3a.3.1787868947106; 
 Thu, 27 Aug 2026 15:15:47 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v8 031/105] tests/tcg/meson.build: use full path for QEMU
 binary
Date: Thu, 27 Aug 2026 22:13:52 +0000
Message-ID: <20260827221506.91574-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b714 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qWFRroGzJIqWv3Zl38Ow_QWc2KnrkIby
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX1/T4xK/vumJm
 eM23C9OjaBLQdK8x04xKcx+cXlG0kRqvgzi8UtKOU0nUoU0uYpGFkVEHEE4ktiVcNMF3eIDujAa
 24yVEI375oXRLQPwXtpVRE5fzc05BfAnqON9swQSip3/UfBxPLn+DjMEPROX6umemokQogE31/R
 OQ7UByaX9r5M7pb/pM34wJBPcnXSr2VfhZ5EhS8KdD9YpLyOc8GGMHaqVWRnAE3c61t4ry4kIoD
 SicRk0kFuxkubTNi/ANxS7lw3CBIyEjhAqLGObVELbtEht9j62EEOCE2v8S5gR7x2XhDfLB6YTr
 Gh0Mu2Hhnew+Fi3U02RVuDJb5Kv6l+bC37hJiRARcQzznv87yvRShFjyJdcJYboB62I0IJmOdNZ
 7CPuRtsh2/KjJKo8IAS+96m47BxVXNsvchYxXsWTHcfdvsi6bREgwJpQdD+tljmqbfk+o2D88eF
 fWFlD46sUeG0q8FBv4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzVQY8vKYq5ff
 2SqfaI5wqQ2j9PKAFoBzrwa30R/nvOcQiyqd5eRC83mx6x/9j+xmMxCIFm42CAHFhZKzXwW/1Cd
 PO9NjFzOJol+gk12elj+YdeRlNcgbkE=
X-Proofpoint-ORIG-GUID: qWFRroGzJIqWv3Zl38Ow_QWc2KnrkIby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

On MacOS, meson does not find qemu binary. Use full path to fix it.
Also, add qemu binary as dependency for the test, to ensure it's built
automatically.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ea17a947628..fe382638297 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -323,12 +323,13 @@ foreach target, plan: tcg_tests
       endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, qemu_args, exe]
+      test_depends += qemu
+      cmd = [qemu.full_path(), qemu_args, exe]
 
       if 'gdb_test' in setup
         cmd = [prog_gdb_test,
                '--gdb', gdb,
-               '--qemu', qemu,
+               '--qemu', qemu.full_path(),
                '--qargs', ' '.join(qemu_args),
                '--bin', exe,
                setup['gdb_test'],
-- 
2.43.0


