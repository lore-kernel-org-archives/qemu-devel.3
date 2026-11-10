Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72060A261C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z2mbSIyE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hDfBbOAb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQt1c-0002W1-K7; Tue, 10 Nov 2026 16:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQt1Z-0002Ro-7a
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:05:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQt1X-00015E-K1
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:05:00 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAIonc63893820
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hV8EINPSW8HveOQbUtdtP7Nq0cJYl+m4VP4TviTEeI=; b=Z2mbSIyERnQUUC3V
 evKSgwtDN0xdEZaWxCxYafNKURnGR62yO8XTPtDGVLSNdWelEeRxgWETMHm3xp1M
 lRGz2Qv0nrp81XMS0ffF+E2qO6l09ptq45u482A2CeAxA04rmcP30I+5QYeyVmQF
 GunvUM+vul80KJMIB31MhPSKbvlXO+O/0ue+1ER34HZI943HK2Dk4bhOwky7/zEq
 p57/1fxVEz/tWCsqNTBJnRsF2vrTCZtcKZANQuoBv8q85Nto63jRH/ePKdkVY1/G
 U+XXGmD7O6D5sU+ust1mxIU/R7ZydUJco27KfHTskk9eDeBj9+JGiD9e+UH8w/yI
 z5d5Jw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hux84bbhj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:04:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so496544185a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 13:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794344697; x=1794949497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4hV8EINPSW8HveOQbUtdtP7Nq0cJYl+m4VP4TviTEeI=;
 b=hDfBbOAbPYm4QmkEcDrjQn7QM4lUPfhGBy95mblGevOdnCMTagbgRGibLcu/wh6unw
 /e1iKHdUbnPUtdaZ8MVZXf3VNYd6KqSzG5fYv9MZUza+faqL6nALhbpJ3zYOvq9a/koM
 BirWP2HieFfKD9sVbbLwlsNNshtTIOVnyz+Blp88p9FFjyMzJgLOmPT4vEpDf9Pp7zXX
 m/1vSs4tTsT5pjLwCHCNwCXKnaZHokPijYwl7psPpuu0WZn7kkXWtx1cmoztE9henscM
 /LF0k6XFWArKcEZjm4folwUDX07tYzQbfkRuKV41HrVTX4jZHxT/1hXiN5DTYcHFhbGC
 KLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794344697; x=1794949497;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4hV8EINPSW8HveOQbUtdtP7Nq0cJYl+m4VP4TviTEeI=;
 b=n6KDY6+nNJqcv+qe5mexT3i+WoRHbJ/hQNmIHtqKQTOa2qY4WxswZ3TFweD/8jdZc5
 hOR0HQmiVPBiz62GKnNhk6+m/o/ALdubOjMJeOu+5GDeOf7/Wt1rH0bZfPrAbbf9GCAF
 JFjJskQkh8oI5RU+DZrqU+iEyF1lJ4fyQaZhy3pYnyIr0OQnbpLcsjVKL7zjjxqoMndv
 fNvfacmknNjce+eZg5G2khNI3RFmYttxHxH8tUrbZBtYhJRzC6SKzV596i1f0iaBdxh5
 9aToirWKhT1A93bzSA4XgrT9shNdE4g13MolPb7mFgwrKgP7gkLk1/WD02D81XdsjARa
 Gllw==
X-Forwarded-Encrypted: i=1;
 AL+hErHNb9EIsWSjoBNXugEvZl2m/3xBrmKdenXkubU9OK/ATR5eGQH+CNNGPDYahe/0ZoioX4cRwUwOq8Sp@nongnu.org
X-Gm-Message-State: APuU4Z9AWQPvS+9jBMV6sBuw6QBqNUsa38HHHq+C+1qEtaByiU8QcQVa
 xIF8WTsjkidgXX7zx42/Du30wvHEV4l7d/ga9jUr3huy4qnIOn2haxs3fiT37I8myMYOdc1Rms0
 taQnF1oXNAL1HgK+2AR/XAW7Yh+HCrm2T1UFqSSLs5ztmS0nOlkDM6JMIlg==
X-Gm-Gg: AYBFou1O4px9OOw/ghk1RMNTWRl4Fj9EQQH3QHOCP/BubpBTyZ7QIcjWxvjf7NPgVsZ
 qS2ngQn++meGSin4xhsOjS/fJJIm876YsVpTUArbmr+8oVVpq4SI5DKawyJ9deE9E4UA7E+KkaL
 V3UMSh8DDC90bMp3ocKtAy2uqFiEgm1m4S0gJBsdRR73AhX3Kj+L/C3zBeSYN4CCeDuA3MuNeh6
 izW4MgiMEaoa+TcYjzosLVIzhmCRgT51cICUp7GSd50SeVhnGzz1+57GQ04FyzDeqW57VWcFBAa
 5NKweOFGlEl7M6xnVPZyGSxthx2sh7LqUkk22eeGPRjb92jImvGSl+Quho3G5c5xfkzrWdrYQCy
 x0hVme9nNfMlQEAatwztkezI6lLrfN94XNvzfE7gsk3RzE2n0G7qaaBVG7QZHQHDD9R5spfEWY2
 AKYhKpfZ359Q==
X-Received: by 2002:a05:620a:470b:b0:939:3a81:326 with SMTP id
 af79cd13be357-947affd3920mr35802985a.37.1794344697148; 
 Tue, 10 Nov 2026 13:04:57 -0800 (PST)
X-Received: by 2002:a05:620a:470b:b0:939:3a81:326 with SMTP id
 af79cd13be357-947affd3920mr35796985a.37.1794344696617; 
 Tue, 10 Nov 2026 13:04:56 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7d6964sm317315285a.34.2026.11.10.13.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 13:04:56 -0800 (PST)
Message-ID: <62ad93c0-8674-48fe-af61-6c3d4c7047c4@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 18:04:53 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
To: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: ZhengXiang Qin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
 <CAKmqyKN09Ut3BAnUpF4Fen=DzMcT=sNpGjTHa8yPeu58H5EpDg@mail.gmail.com>
 <03156de5-9081-4b32-93ea-eaf363acf8ab@oss.qualcomm.com>
 <CAKmqyKOtPw1ca_QsaxYMiWGETTT0mVyA-ENb12b7aKO7F=uACQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKOtPw1ca_QsaxYMiWGETTT0mVyA-ENb12b7aKO7F=uACQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4NCBTYWx0ZWRfXxdzEkk7vKVcw
 ur8sUkoX90CsYbeSX041yeAqWsRR14jR013gq2a0OxY9W4jCn/p42t7yxigFaGi6A/6o1dWY+TH
 lkReo7gV/FxGUJaVkVBVKBGRT+Sx9KNyI8eN5klHUKepNF3OyouxpLWzJ5qH+7ltt4GTlXWse+6
 Uosjt9P6Lc/KNS8Vg3bxqYqOpMuLP5lASQM/5VoyWLSKkFd3VrKenv99d/IxygTUJrixaRsvF0m
 H4nXaC7UWb7ZTi54ypNLTVoRvh/Zuf0t9+OYvg+lpX9pQPA1E3//Uc7MxSrxuRg9IsBbUbZyZBK
 KBA2O92tgEV3hslECWVcpEPZNL5YByN9nSZK10ZS0iNXrULoKDKar7xi1+s277pzL/UOZd4IfbM
 mzSB1uK09qgAhTMjxWZi3zQJHTKJ7sTzlMdhwyX9vOpR91g8UokE6qkWoEnjl5VvyEB2IVnuC3+
 lE+G0P2Zhk4yqnXiqjQ==
X-Proofpoint-GUID: jWVBrc-QCHzljfkouKBOAdKtj4kQmfze
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4NCBTYWx0ZWRfX32/6K9NvGPIj
 0xnCUWtBnNFulndviYxQwQGLnLYtO2DVo04EMgoZqMg/h8R7X8WWAboHsoG+LGX7UvIKtZM01Xb
 yaOQX3zs2o5Ota1vDqp7xXp7UUmQ6kk=
X-Proofpoint-ORIG-GUID: jWVBrc-QCHzljfkouKBOAdKtj4kQmfze
X-Authority-Analysis: v=2.4 cv=JNSuIMKb c=1 sm=1 tr=0 ts=6af386f9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=bDN84i_9AAAA:8 a=pGLkceISAAAA:8
 a=kOPhJXXjI6kSadoPpLQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100084
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,


I'll send a v4.  We have people asking for this fix in Gitlab.


Thanks,
Daniel

On 6/28/2026 10:55 PM, Alistair Francis wrote:
> On Mon, Jun 22, 2026 at 11:39 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi Alistair,
>>
>> On 22/6/26 05:03, Alistair Francis wrote:
>>> On Sun, Jun 21, 2026 at 10:48 PM ZhengXiang Qin
>>> <qinzhengxiang@foxmail.com> wrote:
>>>>
>>>> check_zicbom_access() currently treats any probe_access_flags() result
>>>> other than TLB_INVALID_MASK as a successful access. However, a result
>>>> with TLB_MMIO means that the target is MMIO-like and should not be
>>>> treated as a normal cache block management target.
>>>>
>>>> Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
>>>> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
>>>> non-cacheable/MMIO-like memory.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
>>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
>>>
>>> Thanks!
>>>
>>> Applied to riscv-to-apply.next
>>>
>>> Alistair
>>>
>>>> ---
>>>> Changes since v2:
>>>> - Add else before the success path for readability.
>>>> - Keep fault_addr as target_ulong since CPURISCVState::badaddr is target_ulong.
>>
>> This is not true, the fields is uint64_t since this commit:
>>
>>    commit f2287c7020f36e2f13622d9635a968d6f6fb507d
>>    Author: Anton Johansson <anjo@rev.ng>
>>    Date:   Wed May 20 14:53:43 2026 +0200
>>
>>        target/riscv: Fix size of badaddr and bins
>>
>> Could you update the commit, or ask the contributor to repost,
>> or clean on top, please?
> 
> Thanks for catching this. I have dropped the patch, please rebase on
> master and send a new version
> 
> Alistair


