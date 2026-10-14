Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEC2C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3fv-0003vd-JI; Wed, 14 Oct 2026 14:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3ft-0003ub-1S
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fr-0001zW-9y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFpbrR1672259
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nFp+X9OLINT
 6Z5MzE292MRwHrrBxfz2pKqiPs2xpHk8=; b=KzpZEj61tZijDVpioFCgOBarBky
 s486/t22eN83HwV/p6tbSdxFPwtmuZPquPhWQZOaRuUxMC9kRt8Ghv1j6mC4Eu8N
 CIxKWsxiHzWCEpjcVZqm1ElRTx4P5L+kzBeq4q67pWhYRpHjc0H226LQfNOMKw/+
 NANCGhxALmDHaDLESrHFEqwLWfBptK82lVgYCnxhT+lNvcg00OzkMiEWqRPl8KIT
 Ff6J3vQMjDCf5GOJYUD3AXoVXdDMzcfSI2J8S0O7eeafR7dtjqA1yfwaFhTr7mbt
 q3ZxMIE1vS3Ts0hqEP5wRu44zvCpuYm54hj5HV7TdY6IOQSXbVwecW3RP2w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh8m23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so5376926eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002357; x=1792607157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nFp+X9OLINT6Z5MzE292MRwHrrBxfz2pKqiPs2xpHk8=;
 b=jWMCu7n97uuL9kucY1uU56GnJCZFrLBAiWqFLHXoDNFeLU78b43CAjatzpEWeggQra
 rWG3Mf9iFJBMN6yqlhjlQ6WmVuzNDN3c+M424ysw4Prp//tuD7l3l13dbSpIj2v+3QkG
 SzonsYw28lRbWxMPfYQw9VRvCEWlBZuFOVF1MGcyDRAOBCJp7NiFlvy82RlBvXEFaCiI
 HggBCl90qmnrMBfSj0Xmk/FT7BvZPI3JEIC3ALxfIphvHhB8RdOuRgZ5iRpq3A1vuc2n
 /dnE6FmicRNu8tV/2kv28GLoHmm6+ajYixWLPCD5ftWNITv204kXZ6Nju1zs5MAFd5S0
 EIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002357; x=1792607157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nFp+X9OLINT6Z5MzE292MRwHrrBxfz2pKqiPs2xpHk8=;
 b=K/Ql8LAamtHnm32rFQNc8lAVFMKzFvOUzfkryDIhZXUTQc+0AOnf2iISE3xYFp1ODN
 LDXgKQncLftNY2Q5rHdxofT7INrM1t0E5sOcnxF100M+IjWNZlXoYUNlu/QI3MjNdMDK
 t3kyinFHl8bwQQgpsDlLt01BRKK3Od8ZrkLOf+I4KhE0nDkTOEdTCHZTc7Bme7adlpzP
 R3SNZVa14YD+P0rdyUNq7LOizI28ZFiyqBvQ/hj/0WiGqxrZ/xZleyfZtQblFxHveHYe
 34llOy5sRXy9Ddqt5rcwUPfDhEPt/1bjxJGxvU/5LEEYdj5vzFaz0JUTJDM6aFxbVAiB
 FklA==
X-Gm-Message-State: AFq9FYKZpuAp5TOQzDpf6mMecPQoG04VXkDPo1rF6BoogOGH03v5ej2t
 tGSfXirE0ZN5ASPXjYiVP0MJu7DZ+7YlW4vn/Dj6OlXrcD1t8+KXhYM7dr9NLyafsA5SJI7cNDE
 IftD0YvrP5XJ7gM4tJ9zttirlSy/pm2ACZNVZHov1aUptQmd+w4Elnn6AIcCsUwMPzA==
X-Gm-Gg: AYBFou2AO7GcmxTS+D+dNT5yDYPm0flIDuMZq9DhIg+BoiVbD1wGpbMlyN7aHnOs8Xf
 dltFM7uTpKLn4cO8OSKGqmEGb6E7dMo8YTI7uVeTPLfPwxmil4XCOmguO8Lzpu1emytdrXeOJAD
 7egU2jXHyLo7P6S2eJ8sNqiysLqxWOOA3ewFjj5ixxJa161njom/0uvLyR9+srZyhAwZ2yw+lF3
 MbhV9D4ZYhjQHPdJF7Ju2ctEgx/02xNHX4pWB6/BO0rz0VGENUljl4EfA66TALzLyV8Ze6Ma4WW
 6xk06D5Ad283Rlg6P3kAZ1u9eh4qSI5YN1ziYzHBkl2f5hDAaS+oYLrFXoFi9CkLX62Zj6Ud31u
 uvPWovjWS4FqoQPXtOkz6Als1K0IHUFtxF9yrwu2JCIWrK07djTYQ4DO09f6P
X-Received: by 2002:a05:7022:296:10b0:153:4a27:4ea5 with SMTP id
 a92af1059eb24-16a600667a0mr20980812c88.28.1792002356972; 
 Wed, 14 Oct 2026 11:25:56 -0700 (PDT)
X-Received: by 2002:a05:7022:296:10b0:153:4a27:4ea5 with SMTP id
 a92af1059eb24-16a600667a0mr20980753c88.28.1792002356069; 
 Wed, 14 Oct 2026 11:25:56 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 04/11] hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
Date: Wed, 14 Oct 2026 18:25:36 +0000
Message-ID: <20261014182543.135965-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MpoGgry6j2xSconMTJAK1F4ytXJ0evlA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX52iT7ulNrxz3
 +NZf3VUpFwAa8nGeWRkV4NqR277szwCE1Lk7iUU6+jrW5uS7Biek4pL2466rOOAcl+TuoCAa3eT
 Qo9WRcOG5F8l/rveSRHN8BerYtZM8zE=
X-Proofpoint-GUID: MpoGgry6j2xSconMTJAK1F4ytXJ0evlA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX53P+kUv+wkMc
 W6f6MmNQcJwfq+OWvjSdiErEhbaMI6g7Ho5AvSJ9UdmB+682Xi6AtpjpO385yTtQuBsaem7PW7/
 WNcvSdhg3wWNCkRhIWm+T8xSxHNvrZEToIItXYZloduXWmkqCGSdk6rND23ALoXYED1DyQ4uSOn
 iUxqZzZXDkmaqNB5t0qv3hfaQcFxUvECvafOrcwsm9m1TySrkx9w/jwnAtzR/hjnfBowqU2f+CT
 i5/is8b6QdWo7Od5/nYCmz8UWfvJPTVIbjeofGdZEMoo/cEZgc4OdClthB3H6vmmfJnUfeILUhm
 8KM4OY9xi3rlqAyzh8m0J5J8PMOZ11vhtfaeyVcSxzHyS9RGTk0B7ccfKlyegsOt6LVVLRFxvdx
 QW/zg5qBN7cgNTvmr5Xo/cGYNt9Q3BTsrPKk1ETid62F3FSo7odOK584niM4UORsxYd9pMRWhYq
 m+LUqL9fMGy4V23yUyg==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6acfc935 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=m6vfh2jtweNnR3fUmdIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140073
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

We introduce this since upcoming semihosting ops will be in the same
ifdef.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ae66f5e33e3..76801444a16 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -183,8 +183,10 @@ struct CPUClass {
     /* when system emulation is not available, this pointer is NULL */
     const struct SysemuCPUOps *sysemu_ops;
 
+#ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+#endif
 
     /*
      * Keep non-pointer data at the end to minimize holes.
-- 
2.43.0


