Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37066CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBavt-00015p-Vh; Tue, 29 Sep 2026 12:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBavs-00015g-3N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:43:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBavq-0006iF-Cg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:43:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqfUW1577264
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VQsRL/l6jFlN1r3598ou1TMO+onKFkGc+UMGlX9n+zA=; b=PYg7SapqB7C40UAg
 ilGgCJYQIr38bjx+qdwwGaYqs1xBgmCjCHDGvUYpoL6NvwVocKfh1c0B91Uhb6os
 B+NkNlf0gjRd+aRa/Q1WBOyW2IKY9gRHUDHhqzFHAEJRO7LdWLOyHz0137kAw9hx
 GrKCtq692RFPE+MQTlk2+i83jDEJc9cATVwo4Y98y3qgLsMYxMJoayyVj4UHq9RE
 AwkvbkuAGycslfvP2v0leP+hbss6WiQW31dzeKwuI1ZTOtxokg/teZGubcttT/rX
 PynyWX7Zb/LzH65nxi5mTZmarJuRQq++gxWJaUARstZL78fYoIuEnmi5r0YxZoIn
 gZqE5A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4t53s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:43:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6586083eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790700231; x=1791305031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQsRL/l6jFlN1r3598ou1TMO+onKFkGc+UMGlX9n+zA=;
 b=LhMDbLXaGqI9rd/auNnyk3BuI0xiTOJvDJfZNIY14kdv7td1X0gJ1AkC7YfyopwNvB
 4y+l87wi+M8lKRrwm5yH4fMO6OcSRhXk4MEwaFdcbpcCDZQLx7Dbm6xlJz/XbB4yLaOl
 hFxtTCLHJ1+c/B7Q4dUVEPb+xGThMy38gmnNkhZXepc7/KSBazlO7SVdqm9JmmmzWsDW
 13eNyxuXMTeIpMKEoWa9qe53a/sSnvH0ZIqtlSBabeV5VZbLMDzxtVfCWAG9rIMPEQI1
 KeTsos3nqrspkX7tzz54U9MFtZqc2aIaCzJgnWE2pmhEQPLTBeoLbP36tNh8/ACV++pl
 26Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700231; x=1791305031;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQsRL/l6jFlN1r3598ou1TMO+onKFkGc+UMGlX9n+zA=;
 b=O0RQa0bRYPkEtppg34CIDO+bx6eMcuAizztam7cAzG/k8pbLeFe9unp8rDgM82El4I
 pdNN5m+eIWxMtgv4VbZbYrHDQsF/MrIHQlL7j1V/45ic6HR+E1SRWhccMYBOTdaV7eU+
 ScOFGxB4iObHHZP70LzoxfCKRIWe9W9vaBYCoFOsKIi+jhc+Toiy/SvNgW3kAdvF+H1f
 d/60Kr8QO/5HCsIkT84rsszLT/4pGmdQ67AnIXIwGsQ+0C04IO8fSw6D2KJcI5ENmk86
 lxTZrHeRoSnt6jbXG+yBWLCsV7vBQKSh5XlKKiKB4H9LNISdZUDitSz1jVrDqfqPVeVn
 W8uA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcFQVx7INJRUqCoLSTpK67jsG89uu38tLMBkc1dVtnpU0+78v8twqo/Y8wsWnIt2uFXV6ZoNw4CETt@nongnu.org
X-Gm-Message-State: AFq9FYLN3ic6aevqoUqIUZ+9zquK0yTvnDPloPJ0NxLtmHF8dZpHR81C
 5slOh3Xr/ieGfXyel/Ombf+8oS7cypKyFmKlQiWMOEEUdn6CST/mqTHtTtZj6Rk1ka0Z08/2nFm
 zE+3KPbgjlt5KvjnOBXzPg++2kqiavmLrHlzpR9kL4XJoySyq2NoiWnLDhg==
X-Gm-Gg: AYBFou0jvQqks3lVX8byX/ylr1cO50f62lsuYKwkcqUyX+3QLsDuVAshtQwChqzqHZt
 uCkCkmVp7CzKPWqACQNR7f/RDtfy/0Ez37tulUtWOCN7InmkMarHAB/9Y9LO8KQZ+o4KUMJcXrU
 ddN3nxlPWwdR++m6fkc6Hp7rLwgGRyjJUNvmJkPuDw4uQI1s914wb2bUISnJzU09ZFNFXJlSGqN
 hFctJmSmUkq8rk5X3ahTFA7lozyNKmuiMTRAU2Hj73VKsndauIVjihwWtxxY+n/7D+Wt1e1Y/A4
 CK0lOyaPfVK/lqWvd5dmPXOY6IHjw3Yg2xZRN//aAOndBtXK3vP9IP4MwwsNKxiko6zXblPsBE3
 ccao6aY+dSDk+ZSnt27Z58yHSHQzkKf8I6U/r+9ty3tSJLW/HoBK4EK0Ul8OxqaxrJAPc7g==
X-Received: by 2002:a05:693c:41ca:b0:33b:fc17:e691 with SMTP id
 5a478bee46e88-34a63cad7d7mr6170602eec.2.1790700230978; 
 Tue, 29 Sep 2026 09:43:50 -0700 (PDT)
X-Received: by 2002:a05:693c:41ca:b0:33b:fc17:e691 with SMTP id
 5a478bee46e88-34a63cad7d7mr6170570eec.2.1790700230359; 
 Tue, 29 Sep 2026 09:43:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm433384eec.20.2026.09.29.09.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 09:43:49 -0700 (PDT)
Message-ID: <b43e5e2c-cbba-425f-bcf5-89202f6a401e@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 09:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/tcg/mipsel: add float reference files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
 <20260926010053.2840-5-pierrick.bouvier@oss.qualcomm.com>
 <17d2b653-e32a-4c0a-b035-ada9e9762360@linaro.org>
 <ba38f0cb-e9a7-4aee-9d10-f6d5fa22c333@oss.qualcomm.com>
 <960b62a4-7398-45ed-a4a9-f11c639ab702@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <960b62a4-7398-45ed-a4a9-f11c639ab702@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfXz+/84dI9Okpn
 qz4N+RUFt7Q+psDVjDgdLOgfe4uZjdl+T4qKlAwfUQO0TmER19hHMFtv9+IXi9Z100Sk8pMApnD
 UdamFiT84Og8l2ljz1eJAtvsoU3cIEA=
X-Proofpoint-GUID: JagR_RV380NV3s5PXq2hgHhmwjGGMxUv
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abbeac7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=SXntkJYlQqgfLYbr4TEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: JagR_RV380NV3s5PXq2hgHhmwjGGMxUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX88fsE+NmjxE3
 6XAybTujQ7TQJPUfCfCZ7L4/H5njSvjG5tp22rMItiKumwIMV2qOO09EHd/biJ3eM3pJxExikAi
 WYtynJrlzyLFpTU16GF1sBvQTDk/ycMihoNCSZGsobqMBXf/5Z3RTxq0mL+TgUB+QQX3LIQHt78
 NbADVF3kp0sBP9y3PVM4fjp1YNuMl82dT0QQkQ2n4r8eZVpzIEJDXFLfHuXiY/J7CMH1NPYgz7j
 wuhVLwGhStXIrqE4vjoJf2ZpzHUjcYQgPORD3twke4qxgSASIVklYn7iv55DtZVNvp0L1ExOqn/
 4Pbe3ib/aXI77Eoy7x5rTuYgVe48BKMrNBY3IEUAI83j7DtmxgNeBrtRL42aDAfVyVc3aaxK1+1
 8eQq6gdGDEYoTw3ZJhn4wZEuvG8cwlQrB2H23cZNBFQgBYpa37cb772d33hpHUEJbFfMO6zQtIQ
 +4Kb62yvCFGbcENIACw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290066
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

On 9/29/2026 2:43 AM, Philippe Mathieu-Daudé wrote:
> On 26/9/26 19:22, Pierrick Bouvier wrote:
>> On 9/25/26 7:35 PM, Richard Henderson wrote:
>>> On 9/25/26 18:00, Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>    tests/tcg/mipsel/float_convd.ref | 988 ++++++++++++++++++++++++++
>>>> + ++++
>>>>    tests/tcg/mipsel/float_convs.ref | 748 +++++++++++++++++++++++
>>>>    tests/tcg/mipsel/float_madds.ref | 768 ++++++++++++++++++++++++
>>>>    3 files changed, 2504 insertions(+)
>>>>    create mode 100644 tests/tcg/mipsel/float_convd.ref
>>>>    create mode 100644 tests/tcg/mipsel/float_convs.ref
>>>>    create mode 100644 tests/tcg/mipsel/float_madds.ref
>>>
>>> What are you using to generate these?
>>> I noticed that you did the same for other targets.
>>>
>>> If the answer is qemu... that's bad.
>>> This really really should be from proper hardware.
> 
> I concur. To test emulation fidelity, we need to compare with real
> hardware output. In the absense of such valuable set, testing against
> QEMU-generated output still extends coverage and assert we do not
> regress. It shouldn't be problematic to re-generate when fixing issues.
> This series (and previous .ref added) doesn't make our codebase worse.
> 
> Maybe we should add metadata to annotate dataset gathered from real
> hardware and what is QEMU-generated.
>

It's possible. However, we have no guarantee that all the previous ref
files were correctly generated from hardware also.

>> Yes it's qemu. I understand the consequences of generating this with
>> the tool we are supposed to test, instead of real hardware.
>>
>> My point of view is that if we can't get access to this hardware,
>> having a self-reference is better than nothing. It trades correctness
>> for stability, and allows to catch any change to review them.
>>
>> In case this approach is proven to be wrong, and changes are too
>> distracting, I would be happy to remove them. It's easy to isolate
>> concerned tests in a specific list, and include them only if target
>> has the reference file. Just saying this to explain that it's not a
>> decision based on "it's hard to express in meson".
>>
>>>
>>> r~
>>
>>
> 


