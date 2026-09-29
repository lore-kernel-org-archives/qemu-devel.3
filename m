Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F21ECA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSZ-0003Fy-Gz; Tue, 29 Sep 2026 03:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSU-0003Bp-Di
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSS-0005s5-GN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TtR43684743
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TgTp1EwcwI6
 k/MA3iYHJKm5paG5T+wbJdGd0TWCqWGI=; b=C4cYclYP+qIqA9utajJhjDY1rz0
 CBCqdDpasU+rYuuvjPwLdqxwIS64A9GgpZzojacSnDqIs2qSPfviBATwSXT+0+ZK
 lcERmqnOp9MxPy7G0aeYmL+y61or0O9hqKcgeNCrQcyhx5dzr0WkRdWoeIHeiJi2
 ytD3HXpGA8d6orvnGNgAnSQplC1LeuyuqjfAMRGkaK3rFYJFhoODGwsu2muAavXm
 TmBr5Jjd3n5JlnS0lemrQBcwM28vySStgrubnzbCre8txWtp25xHSVupuVQxtIM+
 p2g1SWEia0DGra2F1pFHSqcrPFU/I8f9j8X5dfBpihW4Dzuxc0Mg+drrRJw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144sru5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30f1b904861so5564085eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667654; x=1791272454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TgTp1EwcwI6k/MA3iYHJKm5paG5T+wbJdGd0TWCqWGI=;
 b=WiUtCEccWzjXiloqp+ZA30q/eUSHrjl6u2vuUVzT//JHrFjiJmsIujagEPFwsr1Ojp
 xKe9CFpXm3UvWEJJNC5lmZCUfJijio11Ic3cAkncCwLHRjRWd4ddQNmzHjnoO9qaz/5o
 artmVK6Ou5pHYp/+YtmGI9aPDtkBmqa3Q5tzL2Ga8Gkyh6mLCxGwGG22rqKyj9kSVPYX
 7Kt5c7xOAXa1jA3VL5bk758Pj6d0BY4vJODSqWlMN598cs7b8ktvrMJvB4Y250p9uTXu
 U1hCPNsHEie4+JRmrlPyokwQbS7gMCHrZzVS+CXCVVeoli0Hp/12f2yM9MMx4pfCXMq9
 fy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667654; x=1791272454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TgTp1EwcwI6k/MA3iYHJKm5paG5T+wbJdGd0TWCqWGI=;
 b=eVi9B+0RPL8ZUQ6QRkXJBErTtVeMUwUhvhhJUHDau4GJrVyivfeD3Ex5JRoMWHXbo6
 h0fuYGhaZZukiakC/SgGgiPgKOVkYXdnHHyHENr5Vkzd9ATjYTAQcHBbXXuDI4/5A9zG
 dhn2QxhAkqlYWiafgUBfbGsDvV/PHm5TJuL6/oangYP42QqJsNxjxIk4d0ME3iq3/rRE
 iOTPdX+suUMSNYuZyOh6R1q4wspQ+UmXMDQxEdbEq3FSM/QC5zwM9wTPBvUiXHD+/5Zb
 pIYEN8ThJw7MOC7106uy82cHEobjVHgJvCVHSzeAIJRrH9gpdFEMTR+YXOI0nNcp00Gc
 Gsbw==
X-Gm-Message-State: AFq9FYK2rGyudBWV/46mWFGSz5oN6Eev+sBxjNkL15eYdO1srtuEosWa
 AqzThGuP/tQwopm+2LGknzikrb2O2MrGT+DL+sl/5XFVPI0xeZ/n/dt3l1mQtMf0OvFQbnp1xmB
 ogv91LSmifrIMCnc/8Z6cXCxXp8Cn+Ki22eZ1TOiLRDk2zf5G/JRKu8ejjxTRGJRqKQ==
X-Gm-Gg: AYBFou3wv/PKzWp5kVeywqaGJ+6TDr5MR0/Ct379dZy/65L3Pv/AIRGQXsIn7haLhDC
 F0GpdSEU0oxEtFh7xJ0xYF5tlMQ8PSgLw7MlD7ATRZBjCtMarBBvBoHu+SDJFHXG4me5iNz2dfr
 zbKzKn531T2rgpTxCMkLZj0rk1qllZONFI6XDpceQ+nJTN4RsVkvdd3ggHBn0jdnxN6J+YoG0KZ
 eZjPgJTXm589Trz4ddwuTO4JVivT7zWGaU/SiTlhP5R53QWwNBKS4bSnD8D8gNGCclbeuYnoLEa
 RgRLOxan43DXdocBj8cfW2g9+fwPkEHtqMFfZHrCYaEWpYvJwcBkbVzPm7LwHxAedadxozcNO5T
 D9nq2qFsQVTT4T8IgzRpU4Vg4c+bvrYlGLG0pew/k6p8o2pPmypOqCuKf3A==
X-Received: by 2002:a05:7301:1f15:b0:341:5da1:7851 with SMTP id
 5a478bee46e88-342703b8346mr17787778eec.12.1790667654230; 
 Tue, 29 Sep 2026 00:40:54 -0700 (PDT)
X-Received: by 2002:a05:7301:1f15:b0:341:5da1:7851 with SMTP id
 5a478bee46e88-342703b8346mr17787739eec.12.1790667653729; 
 Tue, 29 Sep 2026 00:40:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 17/19] target/mips/tcg/translate: add sign extension for
 srav
Date: Tue, 29 Sep 2026 07:40:05 +0000
Message-ID: <20260929074007.118970-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX7GioVsshVSS1
 BZi9WtcGiqxMSPLwPFat+nOjxfgh7zoILrodqbJoMI0zJZYL3w2i83WZjM55HF/A5QSQPWtHTqU
 KLtluX0oTKQxUyo//fPA8y4s47L3oH+XBM5DttUjTs7Rri0TUIy3YtZIjb4ru8jjwd6QAN7ShhY
 0qzcetiqCOTAs82bcudtjjRbnCIaK/3PAOTfRER0KDMex90iY0OsT4I4TZF0jtdevT/fuqwQpjy
 ul3Z4zcflO7zO5SikEyVaSKCpSXqMbSGVDDIacbWjeublyNK5L/AYulzrPFdLhzykODUVKc+SRN
 5lwYm33GuKvQl6tkQd1RXc+JCpIlwlA+RwCoB8MLyo8mtnOcu4iG8KtPBqQINIz2hW340dX5BnH
 xxupizOQX0aVkiKdq3zL8sPoVvRNHzD0ef4VDl4093b0bZs0jgGH4a4JC0LofQlBiwtbAPJ48aV
 Eomc73F+lJgiRl7MphA==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6b87 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1w537DJcHzpE_TUpQV8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: pISKB3PB7uJYV0Pzsqb_w7VELRTIzNqc
X-Proofpoint-GUID: pISKB3PB7uJYV0Pzsqb_w7VELRTIzNqc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX+14Rt2KWVX1y
 MoS4lFv+WIcPVt3Ca1wa1wEaieSA/5AFGEeM444Qvg1Sib7K7KEsXEa/lVStKTdxlp5Hl+WRPuP
 ifLN02iOLMAow8VlOlywgz4yXB40m1o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

In next commit, we update references for failing tests.
One test, test_mips64r6_srav, has an output that is not reproducible
on my host. After checking, it's coming from UNPREDICTABLE case
described by mips64 reference manual.

```
Format: SRAV rd, rt, rs MIPS32
Description: GPR[rd] = GPR[rt] >> GPR[rs] (arithmetic)
The contents of the low-order 32-bit word of GPR rt are shifted right,
duplicating the sign-bit (bit 31) in the emptied
bits; the word result is sign-extended and placed in GPR rd. The
bit-shift amount is specified by the low-order 5 bits
Restrictions:
On 64-bit processors, if GPR rt does not contain a sign-extended 32-bit value (bits 63..31 equal), then the result of the
operation is UNPREDICTABLE.
```

Current implementation takes advantage of restriction above and does not
perform sign extension on lower part.

Given this definition: srav(x,y) ((int64_t)((int32_t)(x)>>(y&0b11111)))
srav(0xaaaaaaaaaaaaaaaa, 0xffffffffffffffff) = 0xffffffffffffffff
With qemu-mips64, this instruction returns 0xffffffff55555555 instead.

While this is not wrong following the spec, it can be surprising. To
have a more predictable behavior, always perform sign extension on lower
part. This will give us the advantage of having a test output that can
be checked on any host.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e3467d15251..936f8c4eddc 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2853,6 +2853,7 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
         tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
         break;
     case OPC_SRAV:
+        tcg_gen_ext32s_tl(t1, t1);
         tcg_gen_andi_tl(t0, t0, 0x1f);
         tcg_gen_sar_tl(cpu_gpr[rd], t1, t0);
         break;
-- 
2.43.0


