Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05306606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AKqWzVpc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DIP4uJsr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunq-0001n8-2f; Mon, 19 Oct 2026 17:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunW-0001iK-6s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunR-0005jN-Jo
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKFCR550297
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OeZZsauEYak
 EG5v7Qjzqb13jLrlbFapj4d+QgIInzw8=; b=AKqWzVpc1U8auhOcfE3gBHJfZ/c
 C4JLTJrcUrUemLqRyLANsOcsl7PwgZZEGnKMg2zC4DbDwZEE+qAE2hfj38TuNil/
 g0Oz/cwJG8fpj1CsWXpt5midv7QuFpb+v3urfJidC4Hz0V5hvuMco69mp76lJ7zZ
 lwWv+gY4ykn11+9fse15J+QUnwINmUxzlHjoOzLI9CdRZjJ3mrwu+IXutQPRqFXL
 9US6epfWCbAxL1ftkgNs5FTnajgKd6GO/bZosvw0Nt6UMCO3/9l1OgBfjoqdho3l
 JHzl0LjO/zwWd+dsVWsrCXZ9OsfSPwhglbs5pgtd/NHOdSAxCjLbihBQ14g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kc6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1185122a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444888; x=1793049688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OeZZsauEYakEG5v7Qjzqb13jLrlbFapj4d+QgIInzw8=;
 b=DIP4uJsr1IfPyw8dy3qlpB+spf7RIi9rjz93T6/KwkRFkRMfaNb4hd7zob8IC0Y1bK
 KYx1UoUhSVjdgvFZHXib7/lXboViMZA+bpWOx9/n6hadye9+6eMRafc8BoGE9AqAgvvU
 Ha4h9N6TyfLKMR5hGRy5eE3Xf2BgBnM7fuR2F8QBwGoWuqKwQ9Rr59V0se3lp3AzBNRQ
 dcrjnMjNDdPuTApD4wZp/DZZT7aJg8xAEAVdMM2/sLHnzvpI5UNf/CAV3E2XVormhGBN
 JQTXOEHWYShyP141Mz+wOCxP950zqTGriCjAv8/eBKIJd7d2VnC8MnYrfcw6yVOizrPI
 NgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444888; x=1793049688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OeZZsauEYakEG5v7Qjzqb13jLrlbFapj4d+QgIInzw8=;
 b=E5K9ZTp2Mn3V/vHD3mgxDE2Q6Aw+8EY2LeeuRZubL77pZ1az6SSH8VTAZNjRi6oUCY
 pjYI9z6iw3wQJ8Sd5043LB32Fy1kSmcS9QSXN5CyqrvPSDmsO2nVb2i9F7h4hxBjB2h/
 an0Es/JQPk/It7395OQVyQVOz+OwJT8ei1tgnTtv9CGmHEBbPag+vu5sDlWZTv3Xc4a/
 hGEseAgmPX4GGe5rWE4unwgdxySQYcLQEn/BBi24SgUhccbCIeAtfyVHgmwZs62BkLCb
 4zjMGZo9bm68PcT9N9HHuRKu/3tymPk4+Wr28bzJXXz92iOigzB7ls0azPKwgmmsOIwX
 5GZQ==
X-Gm-Message-State: AFq9FYI5xDAqc1QH6AQIfL0t3aZlkZADo44x3PrUakZYZfTWiA2Oh40E
 XPVgVssclnt2035wxXX7MEiUN0j3bqvSpR34c7xcfMYhSJpeZcdw+jfJll2Sv9y5IbBUTx5jtB8
 /m0FFea8J4Woxx3lVN7miA3pyKDwvzOd+57xcofTAhKzEl/8NzSf9wqlsK7P+RrxVIA==
X-Gm-Gg: AYBFou35C/QFpPGLXm/bRjaNomYvANgKPz1OIgzOgj3guwTovw4oxqvVLeyt47sNj6u
 vnf1jOrLGT56dvKWDyyF+tfJCJKaP5DTFCdIfF/pmV55eoC+LvZG30JihhY42a7Pt1+1obUiPD8
 ziEgkVQrRZyDqKMA0Oydfkp9zGLqGE7FzAfsLi2nGo6uGnqArf+nzloPY0lIDMGVdwZC7Hyp8ki
 26nEAb4ap6ytDaX86n2/e+XXZTpRABKbXmcZdxJqrGe7A9oooYnkqC1uFyGFtBO7vIo/lPWnA77
 PFMqJKyGE3ned4xAtiKg23wOGXrcPRNYqDMQr00aGHpkp0/JgSw34s3WnYljqMS9QMERMhseYui
 9nDAQN6BtFdD4sPU8XYho6zw3g66eOOmtHgKWVr1NMWcvhBKG97DYxyXnHT9bciU=
X-Received: by 2002:a17:90b:2d86:b0:3ab:33b6:2c27 with SMTP id
 98e67ed59e1d1-3aceefbf369mr7070432a91.23.1792444887558; 
 Mon, 19 Oct 2026 14:21:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2d86:b0:3ab:33b6:2c27 with SMTP id
 98e67ed59e1d1-3aceefbf369mr7070416a91.23.1792444887094; 
 Mon, 19 Oct 2026 14:21:27 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 24/26] target/or1k: remove explicit target specific prefix
Date: Mon, 19 Oct 2026 21:20:43 +0000
Message-ID: <20261019212046.149572-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -jna5YhTQkY_eiZ5wGPPanQpiqdROA3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6Aq1wGVaY717
 juqQNdEYWKc0rz0mA4tx8yOtRSK+7VQwPtzyGnZ7lBPkt7SWNwxz45nYNhjJ8cYZbopzY6OGbS7
 GbMDUsmkp4HeerdkqYtO/vwkl4dI8c7eHkIYQsXZXxrBMOMKtnS+i5K3ZJZFfyFnwNS5fNhV4xS
 Cm+JNF1O6KPrfyjdNJY/s262JygOvOJsjkiizYXUPXBOPHnYVyUeiJGRR2Y1slyYLI9jBu1F37y
 Zgm5z4EFdHlXTWtbju/t2yz9dD8Zr5UBaHemY4Q1voTU+UwsS3sN/UzpQmTgcfakSFOMZcl0nId
 AItZqbHow46+gZQxWD91WnuIyJN+NyFpa9B9Rj0Zwta570HU9k4W0WPZa0iDo9mCoM4ovgJ8yhV
 WqySJqdT8chxUPTOdERhJ2yN0zPm49lkmfpiC2shn8mVxyLfUqs9Li22sKJlcCOmca1jPRGBF+G
 +tqTJKfdIS1+TbUpUTg==
X-Proofpoint-GUID: -jna5YhTQkY_eiZ5wGPPanQpiqdROA3Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0ZFKdAX1FHGM
 VQOrQGx8XE9J9Y41pcpKYGydKNO1d4Dyo18yxHZfqeGCXxB8dfKBZG7en2lLB8jw7vcEIuUXd0l
 1mAhKfS4atOB7kVXXnXUJ3LcDi7zykw=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad689d8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=s0g2yuqVZqAqKHCRF2MA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit f24061e40d2978a51bf15d7c6fcd7576c709c099
"target/or1k: prefix symbols conflicting with other arch"

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/or1k/helper.h           | 2 +-
 target/or1k/interrupt_helper.c | 2 +-
 target/or1k/translate.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/or1k/helper.h b/target/or1k/helper.h
index 9f74bed93af..e0a8d402271 100644
--- a/target/or1k/helper.h
+++ b/target/or1k/helper.h
@@ -59,7 +59,7 @@ FOP_CMP(ult)
 #undef FOP_CMP
 
 /* interrupt */
-DEF_HELPER_FLAGS_1(or1k_rfe, 0, void, env)
+DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
 /* sys */
 DEF_HELPER_FLAGS_3(mtspr, 0, void, env, i32, i32)
diff --git a/target/or1k/interrupt_helper.c b/target/or1k/interrupt_helper.c
index 91dd2227442..1553ebc71b0 100644
--- a/target/or1k/interrupt_helper.c
+++ b/target/or1k/interrupt_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-void HELPER(or1k_rfe)(CPUOpenRISCState *env)
+void HELPER(rfe)(CPUOpenRISCState *env)
 {
     env->pc = env->epcr;
     env->lock_addr = -1;
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index 6972dc7d630..e00ef45b9b7 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -1110,7 +1110,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        gen_helper_or1k_rfe(tcg_env);
+        gen_helper_rfe(tcg_env);
         dc->base.is_jmp = DISAS_EXIT;
     }
     return true;
-- 
2.43.0


