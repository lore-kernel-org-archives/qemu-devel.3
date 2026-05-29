Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070ABCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CW-0006WD-C5; Fri, 29 May 2026 17:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CQ-000647-58
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:57:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CO-0000WY-IA
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:57:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2LOl2998031
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=lgvy0LNWMCE3vVev
 rSt95Ki2z96VBLH5i96J7QwYtDsevG6JyURcaiZg02gqrzkxAqwwAXN41Xzaa06/
 zk3nhfxzT4DtdbbPRPimF9M0DWOlssVjJ5N3sg1b7DbOw5TzEcQ8gJ/fcbneSU4+
 QEWrNd7OoLbto2qsfLBtBbnbNvOjvvHQ8ybp/jDkrcxKwdTFFAbDoQOCQObTWN5h
 orVOyjTwr7g1vZW1fUwtX/Q6HsCtS6R451VJuIZAsCgSiw/rmqmddeI9Vu80si6y
 P183thdgUgauZ0I9/wo4zZIEkItk8uaCO9AAsfuI5YrOPJZxCzgKVUqXfM2MCh5V
 3f0FSA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4ens-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f1820babso1364411eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091809; x=1780696609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=VuySI8NOBnijeiBMtymAHviAeWrS0wtuV3TyMhdDoPktVmrtj2PAL8+t2UQWx5TaVP
 kRvMtg5ZZfH6Uk5yYa03xs7tJgOu/3PEzDMRYpF9jM1NxjqmBB0EFmllXo7Sz/BXEHaB
 HqXhxGRQNZ2Fv8IranOyV8SzsUJCHys5CwpyEU45t5m1Flpj2lyslPW7fCwqik17ekP7
 nqPryCdPUaxYwDbLKWfZXwd4ui2o1WWNZnBd+qnRjKkq41nP3bmNLaOQAFoJYCQ+szQS
 RSZDCIyF54VwN+1gzP/wfgCHphvLzx/i3Wzo37GmgOfPPk0/+uSpdvbjPWBytxb5F3qq
 xL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091809; x=1780696609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=mvTKSd43Y/cDX3G3tVI0+h5/payvO452x8ZzvWwcM0HrGnhJ6pizjgai+dMSOp+BJO
 kkJF97X2F+j8IDVA5l3u5vokzEv1nJAeTwzYywh0SjfjcHXwM7/mYTRz6H35641YdIao
 P1gPZ8cGfU4nQAyfLgw1DYsNwQZrNnkVd/ieDz8NaviAhQ4kpc7dJJevaHZRwwUbZYLf
 MnRHzpBFpOZF85NUsGNp1r6ErvFzjmYbm3n7rO+TgZ6jOGLdE+geq2ueJlhfa2vv5cE0
 2tfkLwmW15MlNI7ogIl/R/EtBHIz6Eeg20k9bhwAFVrIs5js1Y3RN3kC3FtAdLlg5mZh
 2VXQ==
X-Gm-Message-State: AOJu0YxQovdRzL9QfkBgKIhjWZ/f4y119+Z8oa4FTGH64/wZNJxipVA6
 /5vDIJNBuYOasysYh0fNuAiIMdp5WMzG+2TFtmYPFb99PfAQ5rcylMaRlcoPpZdZGu98IL2Pfx9
 cKONxWSN788Css8XuXCd5+QkRgXQiJr7W0jWro2oADEDorr/M+xX35QxWSKTzCHntQg==
X-Gm-Gg: Acq92OF571qin0U5wF304bPkRN/hLRkVxpF695nt142MGA2AmE2ZPwt4KMxXuDND/Q/
 Ypkew7rO9Iw+UJZQDdIxkbwtKA1rFVDBcpyAakpcua2XYxOMJfxsMYMNjJ0WjXVOYsgTpcaVt0l
 S0bnhWfS1yaz+wHGGcVKd79cAdJLCpZSwPLnqmGv3nk+C26JLA0FONW90Oa7jRiX2doQUTA3IsT
 AFXmfbZpvhlSTEUr9ZQrOCvW4LlY/gmUf4dn/hVveNKFTaqGS0ZgeW4r2coZvLGmm38Gm+guZ9v
 bGtWLGw9CdnmqM4u4yj0QV4e3jt3VZLjUDjzU1qer6kv1ON1/Sg5Wz2E7pqh5NfNHFN7sbUJ84w
 6l1H4Thdx6q+vRIYljmPATIN3marLLY2yXVA8vaHU0Q1joo7Bsnvt1y9Gk9Ap3tcrUuK79WILQf
 6CJI4g
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr789650eec.31.1780091808641; 
 Fri, 29 May 2026 14:56:48 -0700 (PDT)
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr789622eec.31.1780091807901; 
 Fri, 29 May 2026 14:56:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v7 30/38] target/hexagon: Add representation to count cycles
Date: Fri, 29 May 2026 14:55:46 -0700
Message-Id: <20260529215554.606133-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX6GvOA3O/OROQ
 nIzef5n+KE7UsI3igqOaNmuay9rnahbNgc0LaMM1Eg7bcUdjmHI4uzONMMvbWj4n5ig64ZGkXDx
 QAdjSRPGaqjObzIjG3KzJhrEJ7xcEnJyeg5KQHvLplQKsOB5U5WCtGN5TU86PKqn6aegGr/60QB
 RKERWv3EMt4IY6YKclHehPPfVmUBYi8ZN5iv5xHmYj0h3BxTxXT6G1ffNywtbE0L1SA4x0azyiz
 XgMklmQZC7cnP5GfG0UYaqboByVkzsJcbfPYJIpYALMBaXzRNe1qCUV+TyiQYwVvoi7f85S9hrA
 0DaUswfr4pxM/kqrvn4V41DDkJuifL7avQAdX7SuNVqGn0h/cS4FAtgXGJdfZtNC/qaRkaY1ziw
 nikYc/AOfLXmGcw+ARFMR7sDcWgoxBLVtQPfyMFRbjzCM2A+lk60A0kfDz27VSYyNv+pHKpta57
 E+kDx49HKnATiVXdGcg==
X-Proofpoint-ORIG-GUID: 7MCETOrhav4-QlgRzshYzQtJ0J_Q3r20
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0ba1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 7MCETOrhav4-QlgRzshYzQtJ0J_Q3r20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

