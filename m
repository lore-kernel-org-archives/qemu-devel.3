Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F7DCA5FA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdd-0007Qp-3C; Tue, 29 Sep 2026 22:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdX-0007PS-OQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdU-000341-6S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQ3861138146
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nrMHOvvpUSp
 /4hXrtzIl/fHBOj1u4IhWbHwKa/a0T24=; b=F9jmP6tYcmPJW02pPmM3hu6/Azc
 6syJP4+cdqUVGSkvzao5A/ylmx+Ba59LVfGNBTFDKa2QkaEKt/5WFSyRwVyCW5Xl
 T3ooH6ljWnhatCvitcM3BYuT2eKnE+R61vP9A7fNR8EaI/3HYEJziSdnovJfZYDP
 1PnDCHqekkojkbNcr0Kv+bdBIMxK4wjLpDeJbRv6bIwEhu89a1+fSp5b1ZboK8HR
 qVTm7073/j6/b+znjM0WT9X0nQDIHfAQOU2bPlPI/VSKLB6LbTXSCAK/svyqSRbH
 E9as25Yyd0l6Izhc/WNPryMFmClpQrHtyrmLWDLmr5uMxe3wSKWhTKu5AnQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1kn1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313d1015161so1276810eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733690; x=1791338490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nrMHOvvpUSp/4hXrtzIl/fHBOj1u4IhWbHwKa/a0T24=;
 b=M+koCswMKBbVOuypUpF3J4asLuizDLjkWUpH5X72mXjVHgIlejvd4fkfvweBBHFBm+
 UzpMvLQ5i0H7H/IKmD0Rqr0FfE9uzrGdSTUORaBr8y/ApkcjBEyNwTLsLNO+0t0TrhEE
 /GyFA2zXKj8dJwd9bP2LrUm9BvVysQ1K55fdJwZyCQRjAg6hYSxBjyRV36pVrVzSIn6i
 uM30OJQiJVpTr4GniHQYMWCmXfW/sXktftO9ST5+5sMWDg+NLKaYdgtHlPSpdtLZQcEC
 mP5j2dqNnhDxNGf+lUyPx2g98qa7yFFnOvS8IQNb/pRGE0huugqUVtek5Tgd3iWhQY+C
 d4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733690; x=1791338490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nrMHOvvpUSp/4hXrtzIl/fHBOj1u4IhWbHwKa/a0T24=;
 b=x21mdavT7HpAZRIvofFVzR2rxczsxwYfWiI5iEKLYvUpDRh21c73JEMNvf3I8icdWx
 Z19gSIxz2iuSHCjkWaRJaFrJakzmlzBMcZQicM5NIhCQYea80IM93fWe6xzNQT2czVsg
 5OITxHs5egkUg3zyXf4QikucMhGU3RJ4oMuCIjBdI4c6FFqw9d9SOmGCgrILkDvFJwNh
 axIftdL0XCqvNFKXvOyeraJSZF0uJ6Fp3HLx8qEC/cYcEfJUEW8OB5tyaFAWVaxBj9qR
 VJdHKfR8xmCc4rZmOEB9/VeHpZeP7jz+O/RuGxjjAMj3zn9R8MbkFLjdIPTL/l5nXCsQ
 zW+Q==
X-Gm-Message-State: AFq9FYLcDnRZlVB2HHLyvpVIyGkbGL5R7X/9NOHPE/cA/I/OmYvSB3wx
 3AkcuyRrpxm/fWGNl6DDazNl7HteLgg2XkPAzsPlGStgHgm8d+LS3oal5W3NTZXstvjf+D9dwAb
 ADobLcBwfhS69Mmv56Q6nqrZhxHuW2uJQhDgUKZqe9bubA7euDL6SrA3vbNhnQfhGCQ==
X-Gm-Gg: AYBFou06IW7/qlxeEwnAZkvpNTI7di/pHVpufys5wiOshCcgKJ7C3Ksa3wIxIsKZuow
 vO8G/B3htB9SdzFOuSVjxxV2vYpiUOjiFvBTGxX07STzOn+MVtq/VHy1087Ye9bQmCmCpTnDcoi
 7MaZMgrQPncOhBmVtDd+LQ5MFQjmxJgqS1Ynv4fVFIYp0EOaaR2P7ck/Ir5Q1eXHAOcBX1rbBQa
 9uGLMRpbaPdqRl87quno/pk8up+3hO+rMSdc19BV2guRFkuQG6z/iSInqNMQLWEP90uKKblMUQd
 /zUGpH5d477J0dPRk423ZJagi8nOeIQjJ5Pn5yzTeOZVLDkNTyRHqyrdE1ScPlKznscWQ4lc4+k
 09SF/fsixwsJOCZ6B0IR7g6wUkEvrPGjJtJlpCwvVR2qav4XHCPwefLzCuhoB
X-Received: by 2002:a05:7301:1927:b0:34c:8c69:529d with SMTP id
 5a478bee46e88-34cdc0d20fcmr98878eec.26.1790733690104; 
 Tue, 29 Sep 2026 19:01:30 -0700 (PDT)
X-Received: by 2002:a05:7301:1927:b0:34c:8c69:529d with SMTP id
 5a478bee46e88-34cdc0d20fcmr98855eec.26.1790733689488; 
 Tue, 29 Sep 2026 19:01:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 02/21] meson.build: subdir system before finalizing stubs
 library
Date: Wed, 30 Sep 2026 02:00:49 +0000
Message-ID: <20260930020108.217892-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX4VPnTkcMUEhs
 0ak+C4C9YIJVh4i78/kWogfIILPw1pym1KCKVYDtIkhXL6+OFZvcincSdvmSuqy1dNw4SM9rOZP
 A4xazTMzXwsypDthgtBc6z4lQ4DKpj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXxsLj/BrpL8GK
 51tZkwNgIGE8dPMhqwFE69olV9cdSTGNIixKrI9Gp4gz/UiHjCAAhIJnCupcdyx1JUBggGCGBo8
 YkHLvTJTANQ/Htw9jA0VU0+/WHBEYtwyd2/Ec36iXNTeOGNgCG3OafocM1D4viztpf6iYczNUWD
 o66ecWzMaD3HevjJghSYTNHFqnUICYTGkTpbtnhRkj415IubswL1v1FkcLwWG9go8MR7GIjiQt2
 Iu+dtlPJfHY6Uv3d3GDG7+TB798i0QgnIzgo3BZF2/yXkNLPZXoflG/GXcnqBcyMwohzTUW8Umg
 4T2KBqOhu7646tYystOFaNpCQ4CX0ThclQWtJ8T4Ul1ho4B0n6abwb6Upb3NVE5h7tKq1xalXpI
 UcwubefotTuh2NbIxdhCnFdmtl82+Z/pFd9aB5YYc47F2l+0cgRl0tppMMsb04a3zlT54rhvMkG
 w1uuwHe9KSM6GI0w5hA==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abc6d7a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=aH2Df2vFxuOnz0hcSDoA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: FE1Cbk8l2cLlIcz4TyfnCx68aRm28-1k
X-Proofpoint-GUID: FE1Cbk8l2cLlIcz4TyfnCx68aRm28-1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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

This allows to use stub mechanism for system/ files.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index cae1591cd28..0eddece72bd 100644
--- a/meson.build
+++ b/meson.build
@@ -3768,6 +3768,7 @@ subdir('ebpf')
 
 if have_system
   subdir('hw')
+  subdir('system')
 else
   subdir('hw/core')
 endif
@@ -3849,8 +3850,6 @@ common_ss.add(files('cpu-common.c'))
 user_ss.add(files('cpu-target.c'))
 system_ss.add(files('cpu-target.c'))
 
-subdir('system')
-
 # Work around a gcc bug/misfeature wherein constant propagation looks
 # through an alias:
 #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99696
-- 
2.43.0


