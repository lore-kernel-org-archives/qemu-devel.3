Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4E606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gNuRz/Ab;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WHeGSmqG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJOa0-0001GD-V1; Wed, 21 Oct 2026 01:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJOZw-0001Fg-7X
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 01:09:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJOZu-0005CH-03
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 01:09:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L44bhn3355738
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 05:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h9awH+xLvUmar9+FshTXVkJ3DpA2ZbVyJfPijqijccs=; b=gNuRz/Ab2Ky7lVR6
 vyV7KJ0PBrIX09zud429M7mcXIX7emqpG6tx6h7/bs2+QNAHYjRi++C3rEr6+H+I
 QOm6pW5wf/1o4OcgXhIOjKZXtNPWt72xWHtPyatnrSD3AEusw/UHRU4wraSYBAoI
 ZN/Lmcnc4IThNE9xgrTcfPb5tEkkI7HXQ81jRapHyDOfTVdLs8YUPoYnQLwBVgyY
 8T1QYkLJ3rrrgrUH5zRk4Nc67EBhHi4LYrYEVBLarzUyYXfIbHxg73snuMaZNifR
 KfKFDaGs5b3nBlm5SpV3FNPTN5c2cMoc/nKC1spXqbFU9MC4Pqlg7TRS6iv8eG21
 0qHmGw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9ht2r1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 05:09:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e95f8543c9so2861835ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 22:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792559367; x=1793164167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h9awH+xLvUmar9+FshTXVkJ3DpA2ZbVyJfPijqijccs=;
 b=WHeGSmqGi12eWp58FCtaWq7vqkvFRXYfYpxgsCZIBRfIzFymw5a61cc6KlYN2F0AUm
 +EW3g3bdZD8w1FHDv3EK4CcD4+HmSeQa22Nkf0O5qpb92YsnZ0wsLMtM8QJHgjkZC0fA
 4cTMAzr561xNXocSNfE9SnMbSQCx+tDe7XQUYRWMUfupOSgo3hkTAIYPV5dOTBfhY6L1
 LREcj/saxlq/pgRN1MTucBNumrxJm16+PBZBe1JQcSfVAKZETg9SsYLHS7x63EV+Z14T
 U7aFC4MUmsHlklfRvON+DFbjTvAhIgtk6iRLBazGUaIYkz66CndtfrvtMjuZBSLcVZOP
 Wfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792559367; x=1793164167;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h9awH+xLvUmar9+FshTXVkJ3DpA2ZbVyJfPijqijccs=;
 b=R4wcc3VWQ0a5h+gTAGmybj5n0/0Vy3N0i7h1HG065+lPbtDOVF9v/Skd5LPJGBcUHa
 Z7z56a+XhXfsTX62C3cUO1bOlqL3Bc3dir4XRoJgFVThUM+0ftzOAZRLaB6o12V6mpop
 ORlnvWLqx8V5rvY6+8w6T5UEfU7+QyCKJb/UmyeSq1buc5/9IL//eo9qBjXm21/0V2SL
 U1OC+lI6wVvUqhFG2oWGIJ021MlIvQ0pQa3g+ky/UjOaPYXpv0Jihmg/Vh3XFLVygFTd
 6nmTKrFt5UHoibHVLKozCuzq4jYONZHbZIYY/SMPENygO81x6IBLLEVlTO8p227NzW9J
 W9vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwTileV1TcKnLhWtQmmh0AsBtw4sTHMLxvR0DL/KyV0/9gY1MUTJZuV5C51VUasPCH2ZkCS2Y6hDoA@nongnu.org
X-Gm-Message-State: AFq9FYLrb/7neLiDkOE4+JTOAM4a1M8uflvjvQpvU0gCgWSIJ23hwIql
 mezDjXifhW3JNRDSbrMSfsr1DFWhO2Cn24RgeeNoVHPwr9lfPxZMRg8jC4l/xJt++FIrBgPdbP0
 qpsAUaBJ2/UhYXUtg95PjfBN5pWjTva0dspJlpk3a05RqzZEn/FX99fX5yQ==
X-Gm-Gg: AYBFou0WsIydQ/AQWb/odr9FSLb7t6fMbvOmI6f1IjGcUul7qrS+9EVfo4QBs6Ax+jG
 R3G5np8ahP4RDDOwpizvP7YjTzNB7n5JDql6N0dvZWij/4L4l3+yIk9qULguwciDAB7hLlMOYOm
 XMlpDNTvZlpV4X6hq3U7VQR7kNus4RECjs5fnU9Mpfieo+VqxlMUSXfYI2tf1Dejtn5W5ulRopd
 afo4H+eOqI2CbFJAMsfUp41EmMhX83qG10Zfg3GCYV5MuU4Ye/Qq3QbLONeeSXIjk2nMWNdg1tf
 mNECapysaCd2MIxgtwtWnBJ27rIuIxfaWCnekXn6MLB6CYkF71I1OYawItt9x0aAGRHncGzsgz0
 CtlUMrIR3rABW4ZYUu9VKR7bxhDs/2Ad8Luz4ZqRyhtu8Ifgf9DHJvU4O
X-Received: by 2002:a17:902:e74f:b0:2e9:6645:e9ab with SMTP id
 d9443c01a7336-2ea439f4abemr8515755ad.16.1792559367058; 
 Tue, 20 Oct 2026 22:09:27 -0700 (PDT)
X-Received: by 2002:a17:902:e74f:b0:2e9:6645:e9ab with SMTP id
 d9443c01a7336-2ea439f4abemr8515555ad.16.1792559366561; 
 Tue, 20 Oct 2026 22:09:26 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b411080sm5815985ad.15.2026.10.20.22.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 22:09:26 -0700 (PDT)
Message-ID: <b24b331b-8735-414c-870d-21ed75863fcd@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:09:25 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add automatic retry
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
 <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad84908 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ry2MZ8c31R7q7bgvnYsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMCBTYWx0ZWRfX+7f/PSgNhFty
 vZpGkcNvK53BZXc9zAE1zDbH1Ut6B7hcHVvmH21McZ4mFiPRjEA4V5XHlDnjOwhLQU+kXyNEys1
 LGbWHgzyCQQ0QBDuACspc0laPMAXAho=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMCBTYWx0ZWRfXxwCjn91N3Z4M
 HRSNr8KUow9og0vNNTdvSHQJCu76QAfveuG0bbjv9n1ebVvQ9v6JLWu+lJd4tgTDzm7zXgASf5p
 nP/KQHyKo1sNLi9nBaJYpfoKAXKNSq4yAIUvnkxmTBy7golGXE8E2SjAymrSCvUnUinzABx2ZaF
 cbWxYiwBSRjh65a8uaqOfOVTsZMQTZNvc6nG5VIqCXjF2e6bAK/vGyw9oHJ5I1iM6KjnFOVbS4F
 9CtFcLCDbXzTpbYvJjBg5HrYxVUTqJDbq2pPyE32NmJJSDcxhH6iP0DwYhrFKiNtSGap4dhKeFD
 02hp+BMlv9MWr4wh8TknKklkim/qKMpTtXSVEU7jJaVilf47YNJkqoQFNqbhNv8CcWsisr24Uxc
 ypfhScQ7o4Yj0IBNf6NQGv9y8MpHSwlcfrPkFGuTx9EF3gW5iNEsp5eIz8Ph7zX5Cw394WqtE0g
 dyuxowHvpzHSTImujVw==
X-Proofpoint-GUID: aXAikGcZKl1ENvAqFcYRKlBl4qNGOGT7
X-Proofpoint-ORIG-GUID: aXAikGcZKl1ENvAqFcYRKlBl4qNGOGT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210020
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 7:41 PM, Brian Cain wrote:
> 
> On 10/20/2026 6:16 PM, Pierrick Bouvier wrote:
>> When merging PR on the project, it's possible to observe failures on CI
>> that can be related to sporadic test failures or infrastructure issues
>> (pod eviction with Kubernetes). As a result, it adds latency on the
>> process and workload for our top maintainers.
>>
>> This patch sets an automatic retry (supported by gitlab out of the box),
>> so failing jobs are automatically retriggered.
>>
>> It's important to note that in case there is a real test or build
>> failure, concerned jobs will run a second time, and fail again. That
>> said, it happens seldomly since sub maintainers are supposed to test for
>> this before sending it. Also, the retry is limited to the job that
>> failed, so it should be cheap in terms of CI minutes.
> 
> Will this effectively mask those flaky failures so that no one hears
> about them?  Is there a way to find out about them with something like a
> weekly/monthly digest of failures?
>

I don't have the exact measure about how many tries on average make sure 
CI is pass, so retry twice is just a first attempt.
Out of occasional flaky tests, there are also sporadic infra issues 
(related to our usage of Kubernetes).

Regards,
Pierrick

