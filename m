Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91300FED3FB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGLwN-00064B-8a; Fri, 24 Apr 2026 15:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwJ-00062y-RZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwH-0004LR-9O
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OI37JX566712
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JbhSUbgVqgv
 S1jVnX+VF6Dv1JOy+tx+uSXFOTzDolxE=; b=lO8hglQsCqTOdFAsgqlEmDdRWAI
 2ZPLv7m3SSDV/P4nRLUF6nbXP4DvhqsO7xZAA8eGjWxs0Ll1YmsAinhtOPd99Vdh
 yKtIeU1ND0TlaGMDR50xqsYmhOR1R9m77FLsLwRKiM8IqCAIbJ9TVSpgatUTP7Mu
 IaWrkI8QtXXk5dNs/izCViDyDO5+s3m9PbyEQ6mLvvIHhXXrNgMKYIBo123ECePe
 ViN1KlrUqz9sGsZgH2e6Y3149SbUSK0qiYpj95S+I/Nr7bnd7ZdVjRA5OkU+hD/5
 5DSpurGdW0a2yx3Tx9HLE7/o+j4xz0lJvYmToh9vHgkgWI1InzLFWtjnFgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drdf486x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb706313beso1028804985a.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777057897; x=1777662697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbhSUbgVqgvS1jVnX+VF6Dv1JOy+tx+uSXFOTzDolxE=;
 b=Zs7fDclm/oL6BQQpvGvuxoNSCf0P5CdmbDTLUYo7kQ9tk6Rw4Gs/mvewfx2IB/co1d
 jRxHawJxC8NR3cZNJfL4/nSfw22WcujgV6awBg37CL02sMBS5T7/OTxaiYcTwj7Zrkmy
 VUo4gt/2YF5cPfPCRm+5CM0XjRUV1Z/WhCQp9LwQipkNGlSuff50v7Dpt6H4wpgKozAP
 w6LCggdMTCWKLj0w5zMegZObzsjsprHbcbw9rY3J50DTfaRq7egmcbJfREVzXzIPmsNZ
 0pFaM9LJmnRE5LTc32DzUIhVslISIAVUaxRp4GluyoDANXO82ndk+HMsFCKBI8Hkoyx1
 E6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777057897; x=1777662697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JbhSUbgVqgvS1jVnX+VF6Dv1JOy+tx+uSXFOTzDolxE=;
 b=EPWKE5Gd8/7ceDjxk/gwrCbQvC9YanbDSeWbMjSsjQGqUAER8afzN5Z1w+nssexceP
 +GdBRoyhtWRq1cNOnfmH70I3YpPtp+AVi6Wpyd6s2VxacMdqsyjrMec0Dd8hRY3JeK7W
 BLxo2SX0oVzk4ktmgl62OF2SzzUdNsvwYwE0PCPthcEsOl1y7dC3tC7wqFS000Fb16X9
 +Cd5/0ycWUrinJaVj/DAJihdG/jw09gnVYKbHWdbFZpY0x9FwoNo/SUAUZQGXT8vA4l2
 OUoV36Y8HNVd22SfR1+nNz/Swgg33ge0rBWfCxlpnFekjio6Zb7XgO8rDmxLqPr8txPs
 jjEA==
X-Gm-Message-State: AOJu0YxMgkCjWYErufMVoQU4WokPnt47zsifYzC7FyIXn++6SVeUddM9
 2y7BuuOeVjM4+dHXPVVPPyOv7om4GAECt1g1Ft/LtdObPW59d6S0fAuV+Goc7ps4AYVwxjtS7l5
 9dSQ3WB/nsJ95wKteFx91OU7bTuwV8CFjF0Drt6EpagGBGWaFwcyaSrItzPWbQEY2pQ==
X-Gm-Gg: AeBDievnODIclFErAm4Gt2Q8hwnYro/909CurBTfPMdJux2ei1TuCP3x+GaBsNy2WLA
 yRMPKUpgtBK1SH7782Nk/V8vbuhIFBWuZC8xXlBbXWVxQxFGDtrW76QQBApwO3oHElbepQU00Iz
 Vu6Gn83fpRn3noonv2nSQvb47LweqjtxpOpKljNvxy4bhv6zISo79xmvR++fef+VfGU+IPxr5UJ
 MdIFHh5H2rD1zgUz+TXSiP5Cn3Hcg+vl3575WHCDVbB7tC2y43PnieGJzxfoYUdOUXuKqEimAIe
 Kp/6Y00B82Ifws16vMuhgKHWFeGfPnvcpSwzEfuBbJ9AFk+grMIE9vUBpDkXZi6WjmxDQCWerM2
 yjDkKmTRMasSbf6dRVjs3tyTf70mzQzt6BWKmj6gqKnOGadlozLmqZeGfddZ0cUMzap6kcO4=
X-Received: by 2002:a05:620a:4694:b0:8d6:2beb:9470 with SMTP id
 af79cd13be357-8e791a98e3emr4511435485a.40.1777057897066; 
 Fri, 24 Apr 2026 12:11:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4694:b0:8d6:2beb:9470 with SMTP id
 af79cd13be357-8e791a98e3emr4511429785a.40.1777057896520; 
 Fri, 24 Apr 2026 12:11:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90afsm2319567085a.3.2026.04.24.12.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:11:36 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
Subject: [PATCH v5 1/4] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Fri, 24 Apr 2026 16:11:26 -0300
Message-ID: <20260424191129.1494381-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z4vc2nRA c=1 sm=1 tr=0 ts=69ebc06a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=GhL2bEVCvcqOW28JNKkA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NiBTYWx0ZWRfX/qC4h2MpL4bx
 fCdvsTmYEVnFRfhRzEjfUL8oa9QWeVCwfqQivpeQ3G83mc2z2zZg0yY84nn+l0isqw0HrzFqGuv
 H6OdkFcRq5vGwn9W4LGhIz1FCkdb5rWTQ6vWld7Hk8ULMWCBL2kWWxnwBfRuNzQqfQN1QnFP0EC
 e180ZvBMjo5FUZXIR3Gbp6vFzhvZkgNTH73znfJaU6Z46F5wUshcNUNOh7N5/CqI+qfTNev00lb
 5B6NzcSsQYyaGf7mpwt3FqToWgw3y4zxUIqJFXvL2qmlUOUs/UKEQBKHMpL8Sf0RjAY/7eAeCt4
 bACyxBsZ9Tvlshx9/XpNPcDOXnf5LS45n0NHKwlNTAOq3r3Vii/0jxKfVv94cbeLT5hSQRDktO+
 pcDeuZSxNn9zwLlNgAjKErBuaCg9XoLqemBupKypPORdMHGdRM1tMOr90TuhrAQzF7oVgFI+2RV
 it9IqWlPVVbHxNtD9lA==
X-Proofpoint-GUID: b8JEBS_gx-ZgRzOId9f3CSnjkL7_aRjr
X-Proofpoint-ORIG-GUID: b8JEBS_gx-ZgRzOId9f3CSnjkL7_aRjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a81485981c..586683b28a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2863,7 +2863,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


