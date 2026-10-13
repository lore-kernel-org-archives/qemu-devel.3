Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D019DCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeok-00069R-RY; Tue, 13 Oct 2026 11:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGeoi-000699-1o
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:53:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGeof-0006QQ-T5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:53:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE40w8615500
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /qFt+mGDLdk4ql19H9RAIaU1D/0E1otruS2+m0HtvCA=; b=YmWDL6qdq5Kdi6AW
 QAIolZnwjjyqJl/AgE6EfrPIMwgDaaZPCQgL6g+2xNgL8AOQ5aTcVv9FPunfUhUI
 kaFP77kG4h/X0+zSmSIAe7GCfHCrSnKams3RvYUlEvzJp3JPy9rNAZH35Y1iasLt
 jG9adXiX0oU5+2qAg05Z0WzJ3GWLmqvF2GFYOyFD40/Cn+SShuMRPIyTwCJYRnSh
 FGtBnYfChCpCil9F63Eyi6YZN8j5lzFMlgLJsX2qLSPozQy1bbuWN81JPkmgoX1B
 3YkNTzVvmbljPpN92C/IbSeSY20MBHYkBRWPD7mTgbnYaH1BBgkieYdxNJG/qpZj
 v8CYdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7jaxgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:53:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e85f74c21aso24746565ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791906803; x=1792511603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/qFt+mGDLdk4ql19H9RAIaU1D/0E1otruS2+m0HtvCA=;
 b=DhWAxHU5BjZdhBZe7SK2Kjy5JjOQl+SNkqgeVNczzWn+Dw+pkvijDsWAX5c0zyFP5O
 wGtxNQSQy3PuXrh1dpfWqFqlCKwTZvDOSnvhbZG9jceN3xHnwpx4iOzTik2JwV5xLYBr
 ATsgwnyF1BQPXoKk+9hUKvJqktj0FA0QvHX4xqml8wDM0sROBTzlBL//iAQQZact7km2
 rPGh4an34z+z5vsy71G8RYYtSkpM2nhQj0cxc/bQHs6niW94OcJZ+3dwynpAajLpH3K2
 O3DBYjHGo/kDU01v67XfqCZK6FFQ6Pm31yp7Swl3+3IiqU8AutPE79X/rTmIyHjzx/tA
 m2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906803; x=1792511603;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/qFt+mGDLdk4ql19H9RAIaU1D/0E1otruS2+m0HtvCA=;
 b=vJgiwsjbBWRO7V93CMo8kMv1dPLHdtV1FGqoTLziv86eos0TOGC3aEKc8XMcNP5ZCR
 8ckInTb01+iPBxJf9NVrdYUzYC6G9Z/aI0/qc2Kn1lN+6tvClSm7jOMv0hVfkXvZ5CkH
 oeT7u35DMdiH+ZGpkl9da4gXhiM8QDMav+EMeLWP5NuowKT7YMCkDl/fk0AGPpkOm3WC
 16jhVT3ip6Byplga0KVlcAWQv180DpziGxZW4NUBuCK/D/j+q68TcbLghGsUH0i+uXAJ
 d5rNgP+OIysTWWXkezy0A7c9q8jjXzOSbxA126OLB9NOSnYcx9QoP+7xTjyEge5ea9h5
 k69Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpUkU7+kosRgQbclU9bsx1Nrsbg4ZXboeBrZ3fwAge6imNI1KPwwzpbGB76LoMW1aeod5ON5ZWSeYl@nongnu.org
X-Gm-Message-State: AFq9FYLGUYxgIr1aEr6ghAQlEfuLXUsVbzXX1LnRfXZlwnXREDLM/Ayl
 8JYo7B7yIvFYaUFq8f6fGD4RFcZSaghC2pQC9/3Q+qz/na9mYc2ncyL76GWx73aVFaHwLraUYNl
 0rhSM+lTSP/4w3sMnbTjGkzaXeIgKhCuzpqZTbfBkKKdTb9FEH3VOLu84xQ==
X-Gm-Gg: AYBFou0Djv75kQjNWpYuJItAUJb8O8vbQu14xEzq5fw15VIi5MXBAuLyqHleeMvqPoq
 ANKez6tYe583rml7aYuF/mvQvesPwVmm8bQh+8qpE02883dg0Mbw8csYXaq9Ru0pTmETi2nl9Yf
 IatZfkRmIz16MEyCX1QnCTGMVPJAOLfnB7+/FC/mjS0I0CkJWcwpnMyZBj2XNysBgTeyDT/Hul0
 Rlqg249CZUHoNUP3g+NQYE3d7gOCXnU7axMXmK24t72+ELLVje+e9qmnJBDitgUzmhfWj5VV+Cm
 1C7C3sUXo1Ccr+cetpkFLCA0Ib4+9lgjxVrJ8vkqparClqnZIyxAHMn+nAJaZWfkGefW6BkkWzB
 RjNDLOEJ3+4u535ZmQwGEtaQF+0TkpaPUnMwEe+qn53DNGxa++JadAmEF9nSK8uSgArwSOA==
X-Received: by 2002:a17:903:350d:b0:2e7:4a2f:690a with SMTP id
 d9443c01a7336-2e8404d4c53mr81354155ad.14.1791906802853; 
 Tue, 13 Oct 2026 08:53:22 -0700 (PDT)
X-Received: by 2002:a17:903:350d:b0:2e7:4a2f:690a with SMTP id
 d9443c01a7336-2e8404d4c53mr81353675ad.14.1791906801796; 
 Tue, 13 Oct 2026 08:53:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8d9asm57917665ad.62.2026.10.13.08.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 08:53:21 -0700 (PDT)
Message-ID: <eb981fda-f235-42e6-89ac-d41a7439404a@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 08:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target-info: replace QOM registration with a
 constructor list
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
 <CAE2XoE8G7Pyu-UaoW0BRxHqEX2aef_ak29mAkwwssSS5Rf_y5A@mail.gmail.com>
 <578afeb7-d302-402e-bedf-43b29ef00d5b@oss.qualcomm.com>
 <as35QRodxSk16e-F@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <as35QRodxSk16e-F@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hGZ6gPLLNU5buznc04doqNc2H_CvSFof
X-Proofpoint-ORIG-GUID: hGZ6gPLLNU5buznc04doqNc2H_CvSFof
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfXwt8qVZM66MWy
 VsESmeeQDKendqrIorLMIU8/GPzWYuCwsuPaIty6Y0Mp/EAIa/oZ0n3Ud0/XY9um2QJmDpJ5P3S
 hSapuA/EHHaspP3s7wf4wBRua1yZ6YM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX9QzRJ1tRFLk1
 5YdrqELtoYqDHJaaF7LDIxXQqBi6uwxC5ulQx4WuNpDLzZrr+F34oH3LoG1bTE74RRA8iGFgPRg
 DK0ZDZMX9eXS07xBBY/OzEG+meMbn7HnohdOjOuEgwmp7d0p1KpWSTN/V1yT3LNSGMkKWYkMN9H
 HB9Tt6D3jxywPy5SwGUpCr91BNmjA5+/XGZHkB5NFru2QYwgkvsC7TAIJxOClUthOzo0foqxzUp
 lKlcIEXBYfwXWEqht48A5IHbebAleAbNI0EGpk6rsNP64rVjJ9YLnzl7VR9s1PzERCanF9nkXFK
 OYcelR41YbY6KD9bC19gGVhaSttwsfGe7W7a9mm43TJPMNZRmfrcNXl0xl6krTov35x05QSeklf
 oJTInoAbxUjo9f0Z8mB3mGQzv0brrysNcP2VwP9TH91I667Yxwh4fGsfiu/B5RSFPIPcTk0IfMf
 sJTmJd/VgiC/GohlgdA==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace53f3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=mDV3o1hIAAAA:8 a=uFdz5bWKA8w4Z2zmxB8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130063
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

On 10/13/2026 2:26 AM, Daniel P. Berrangé wrote:
> On Wed, Oct 07, 2026 at 04:24:07PM -0700, Pierrick Bouvier wrote:
>> On 10/7/2026 3:54 PM, Yonggang Luo wrote:
>>> My work is here.
>>> https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads
>>> I am afraid of posting 300 pathces into threads to flood it(and
>>> disturbing yours). So I'll wait for your work first. and resolving
>>> conflicts later, that's really time-consuming.
>>>
>>
>> It's indeed not possible to send 300 patches and expect this to work,
>> whether it's on this mailing list, or any software forge also.
>> It's also not possible to send a link, and expect anyone to take a look
>> at the 373 commits sitting it on top of master. My name is not Claude.
>> Instead, humans have to progress step by step, based on feedback. Yes it
>> takes time and it can be frustrating. And yes, I've been there (and
>> frustrated) also, I feel sorry for you.
>>
>> At the moment, if we want to make it move on, we need to focus on one
>> single thing:
>> "How to document/specify which targets a machine support".
>>
>>> I did many explanations before. seems my explanation is too bad and
>>> not to give a clean picture for you, let's delay these first.
>>>
>>
>> If I can suggest something politely here, IMHO, alternating between
>> genuinely human written messages, and AI content sent as it is on email
>> or commit messages is not helping on the receiver side.
>>
>> I would prefer anytime to deal with imperfect english (mine is imperfect
>> too, I'm not a native speaker neither), compared to read what
>> Claude/GPT/Deepseek generated that was pasted as it is.
>> I understand it's a good tool for helping on the language side, and
>> that's ok to fix grammar and sentence structure.
>> But asking "Please generate a summary from those email threads and
>> explain what the current series is doing", and paste this is doomed to fail.
>>
>> It also has a very detrimental side effect: it makes me start to wonder
>> where the code is coming from also. Especially when seeing boilerplates
>> with lengthy comments written in perfect english. My 2 cents is, use AI
>> if you want/need, but make sure the result has this *human* touch.
> 
> Although these are not yet final/commited, please bear in mind the
> proposed updated AI guidelines which broadly intend to forbid use
> of AI for authoring commit messages & cover letters:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg00260.html
>

While the AI discussion is on going, maybe it would be nice to forbid
that on the mailing list also.

> 
> With regards,
> Daniel


