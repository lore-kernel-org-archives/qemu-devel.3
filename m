Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB513CDE012
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQvw-0000kz-Aj; Wed, 24 Jun 2026 12:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQvu-0000kL-L8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:58:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQvt-0004qa-0c
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:58:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfJOY3300966
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6AQESdGL6UwPhpaHQNOytK5n+lzvEYAcwr/ByHAWGA8=; b=g3syGyWA0xj1MdnG
 qrLLJOX4QlfaasbIPiMFRNCDoQVswzhC8XT3DzFstS/rpZKDLA6NrIFqwmD6APsO
 U3sHbUTeEriFFR0HZQWfac9+IRuldPY3NJdZI6f2OPeoKIBQBDPy3u/oGXjT0BoK
 TtCurgsoPK9aC69MEw3wRJU8CrettdUyJ1br96EVy1hyLpskK42lHQoB+x3XqzG7
 oxNzNtRx6IO7N6NWh5+TuG2TjIEpdwsMHK4Duan5H8j9n0i29WjsHyjzErWKABMK
 Yn4sTiv5kcX7dpiPM81yIwqSUY/qJrhWAbTqQV2ky/lhg1fKWGXelyqiTdajeKHE
 JK/grw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aqbbs0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:58:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c62861b3bso3176569eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782320315; x=1782925115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6AQESdGL6UwPhpaHQNOytK5n+lzvEYAcwr/ByHAWGA8=;
 b=ZNM6gPRiYcYJxo6tsjcrRWdNv7zmzYoqw2RAv1nlb7MRSADiuGLEI8wkIx7AkNmtVZ
 T8e1dtWYyb81QZNYqxZ781JnF1HI373IRE/Zxd/d8HzvnBKe2/21a+w/vR9JuAzHRm3f
 7ftTKkusckYt3cy8z2CjaSwuFzXGVLU1T2Yzg6T+JzV5oRuXNY7ennhzetEyUvrPq6CJ
 nHYdEGcp5fR0nXO6T7AHjxtyJOb0wckr0r+Tk0F92abgnrVxcPfc0jp42orm825ZmU3e
 SUeQUEeGMoD0iHep5Gii+sXt+rUNjlMRYxTPHDNSH3gbloT5Q9yOTO+64EnQYeuTrV38
 1ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320315; x=1782925115;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AQESdGL6UwPhpaHQNOytK5n+lzvEYAcwr/ByHAWGA8=;
 b=FoVMOOlF9DQtGCEpNrDlFfOAJXNDsh6ikD+FOBxE9ZmH+f4tT1j583YHbJNvw3CqGp
 hkDffm6FhhSDY1r6GIvYpaCeU67srhrr0oMIVA/ahvh9OGyncqff2jhYAhhccjwKUW5H
 mm13g7qpIaKiH3cWFuEBcy1Slr3iwXyIEJCrBQrEmoJhpnVoIiWrLwgiRuOTqZy012XU
 klpoSHSfEv9sVVWzKDDbSnpqdko5Dxg9k8+lC6UyO0tlANRyLwr+Zdj6+xAOC5qMKP7f
 qLA6cGja0mXOWDEXwzF1pTwkkuxgZ0Bj91+m6tQyOi2nTFhPWWnFDVWYgePY21O0vbX3
 +yUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQpxJhFEirDGLt3xU0lCMp02UkhPc0DBFkHarx5trh6GGKxdGXwrunVHHMMt5cFxnJkOPGLNzpuzZv@nongnu.org
X-Gm-Message-State: AOJu0YwcgkOUfkzx+P2NUBkFqQnAx1n6JBSZ9pXsYryFl+L4QPwUeCqh
 I/9yCHX2fiuqoHhx5Af7HLe+E80mjCvoOQK+Jfnb/Y+stYski/FpDWsv6Hu3KaI6veI0Wa8F3lZ
 JdJOR/V+JpQG5JxGRvLtHj2r1xAJi6XsI6sG1IpofzVCj8+VfJMYVZrQJUQ==
X-Gm-Gg: AfdE7ckOAGfqWvSIUPyI5mQ2xxc8D75kUHAPuTUMAnG/FKAnwhYOFokV6IUU3JnD2Ke
 y4Ry5XUQUW9twug68qdiN6VxZQN6BSiam9X5+W+2xaULVSJ0G1mldyTV3CTWmbS3pHx0mn8zzld
 h58bBN1gORJ2dYMynId5WsSl2BG8q4jWBnZ5bb47XKOSu7l3IZ7GdGpkOWvBU2ywaeKyoY30pQ+
 fwgZgQD1lIitc53yGqDy0sbXNP7iB13AsrwgK5Uj78tMMV+XkSIvIjvS764cCVYlS9c+hX9DRlz
 poF5bDLNZBpfP/kLgYcq5JM1P8wTBcEV2QyfDw6+DnF4hI+IU0ox0ZSpc+/JZ3DXkXBAfVYu8qO
 D8+uvOMxpmXD7qHAL0OutEMqMG/gK+h7xhTnTDaLCuFWQcMcPFWB7r7r7dlNzZgzLf1GkOpxx6H
 Z0WH0=
X-Received: by 2002:a05:7300:5b9e:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-30c1dbd221fmr16010536eec.22.1782320315123; 
 Wed, 24 Jun 2026 09:58:35 -0700 (PDT)
X-Received: by 2002:a05:7300:5b9e:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-30c1dbd221fmr16010514eec.22.1782320314644; 
 Wed, 24 Jun 2026 09:58:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c9e9214sm434771eec.20.2026.06.24.09.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:58:34 -0700 (PDT)
Message-ID: <2c537f53-2ddf-4a80-9914-0adb23bd569f@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:58:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] gitlab: greatly expand captured info about CI
 runner environment
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-7-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfXxOsb/6ve7QMl
 7b9tw0u80qZ3Q9aEUHXnPxCpjCDvO29oTYgdQ7SX3JtKcvWzn+NporeS2nYXx68x4ghGOEwmWKp
 JuLN4eyntaOfhjDvAKDgV35OrhC0NyA=
X-Proofpoint-GUID: 7_HaCMkDntDie6jhCKVMux5a2SmB0f9J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX1RaQOYaSF6y/
 0AXxgsyLphpDnH1w7pIMMQE/VLzM2Rc70tutB0rPtKn4AmCvgZu2NzarEvSGoAINc4W1O4wT+sU
 WPgMhvvA86/bXOS80uVLqfb6Q02tFj99ghk4e4F/nDQ385qC0vxJXOCpUTO2Yj1twIWTx7kWtNt
 9KuGK5x8OjvnGUUFjzuMHSxXZZkniNGIWWEypH53ptGkYS+/9sQjafy/LNWQK3oLTJL9tdP/hwJ
 F+v6pMVgxmNTHbLFvkeVJo8auCUgMcsC6UWgB8qrCV2YY1DoWyCEGSzrjdMRc2kGt1Z2rCXjSw2
 a0tI7wuNVGFPPDYepAgrCcj72mjUpsvAnfYH6tR96w0j2CBXdGkj/6M7rQzG161m1GC/+Okgl+s
 Wb5n9LEqsAeglHBOsRcbyd3HHyeI2A==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3c0cbb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=FLyp8ZMiaQvIgIjuunMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 7_HaCMkDntDie6jhCKVMux5a2SmB0f9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/24/2026 5:46 AM, Daniel P. Berrangé wrote:
> To aid in debugging wierd CI failures we need greater information
> about the CI runner environment. It is usually container based
> and can have some unexpected characteristics that significantly
> differ from a developer's local environment.
> 
> This captures the mount list, CPU model, memory information,
> device node lists, kernel info, user identity and all environment
> variables.
> 
> Since this information can get quite large it is not emitted
> directly in the logs, rather it is exposed in job artifacts
> under the "ci-runner-env" directory.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml               | 11 ++++++++++-
>  .gitlab-ci.d/buildtest-template.yml |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

