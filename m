Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABB6C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDPA-0004p2-Iu; Mon, 29 Jun 2026 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weDP8-0004oX-Sr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:56:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weDP7-0007hm-ER
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:56:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT7Ol2627945
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 14:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z9/oCyhmjXz+KKfudtfEN2iHH1bOiZ4tAb00LKpqgSQ=; b=px3FS/nF8qqPlncU
 7CxrAdZaAFNYDfbo+6IKj3ECzAbDCK166/07zEqWEW/zrSrfxV2QuqeVxv1Ti9sa
 thkNh9Tld6QUY94Mt2bRXsT7tv/W+yMk70HS0Cm+JGkPaOzXSY7/sF0nWu3oSLTn
 uVKPz351EGqfc+nppevBfsPSpCkTmgRi+GPT3gF1nrSRTuiPopZFbLpa2Ymho5E3
 tXCRNqJV+Rm2NExk9zMrxFBypdMKDKtpuA1/ttAp4ordilJrdgLloNKmP9jG+B4p
 4slPc7qPmP4zQA4d6I7HWV7+YatCxXkMSqCZgYUwhDe6J3YBzSN0AMUYwjoMOlct
 xu7p5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgsfym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 14:56:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f27f49bso169882485a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782744967; x=1783349767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z9/oCyhmjXz+KKfudtfEN2iHH1bOiZ4tAb00LKpqgSQ=;
 b=Qm8ThIoKtfeI58J2yb8HOKcndGX6gI5l9DIclBVSLXESvm3KT1pvYqgtwC1tliIfIK
 R7hUjLsuq0wRfqlMC64w5kfRVGjBZtr8FZYljqI9vgTqhGJSc+fHXnjJj6tmXJ/cH7Jo
 XYuFlp10zEFOp6zKRoqxFKX+KejxJRm9c/zjkH6JFQBb98Cb5FQF71xciK9FcZcUtLfF
 6yMB+1YEU8+byKZsJif7Rad8XbzZRvlmtpAUClWvas/MAtuRhZU6xWFIjRcsF7dKCpd9
 gPp4iPplIHc5R4gQ6np/4ElNpCm4SHZ6EDk5xWyE1lRy2gN7bcrbdaNc1mERhAkWmexJ
 LNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744967; x=1783349767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z9/oCyhmjXz+KKfudtfEN2iHH1bOiZ4tAb00LKpqgSQ=;
 b=BiCjC/HVhe/Cyqo/SbSZqtQQKr4QCP2r9himYYRPTDPbbjhwWVuLk5+LYvzQ8YsKdc
 4f5XYd1bubK61YuAkTUuRfpWyoDa2BZIx4yD6kTK1rH9krgeX2ztQ0/majHXo9RgLuZD
 ix1qgqxj1B8c48Zjar+fyMTvD5w7EX0p/t/RiHknqbH7FuVte3hFg7pbLl3fRPk6vFu1
 dDKPhvVKSJh5kpQwMT+5VgOoPWkr0Ve/OmRJJdq2oymTJffrWjBUvnB1HpuuOX6u3kap
 JoSj7LKXuzALFtoLyEG6FejJDhlFr+JjxvyrPrBEPdT4AvOFcVTpUwhSh7Y6V7Guwjfy
 tmkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H+LMDcGhdlWfNuMfFSRq+tj0+aBaG8uNER1ix8wag3r477wVumegTHdLgMrM+/aJxeh6FGQgIOSVV@nongnu.org
X-Gm-Message-State: AOJu0YxbsPV44cj5eIEf2zQh401hK3rS/PoSJRl6+BLZ/XzX4sBje5At
 RCqlGOjiXWLnfprtimH8kr8FbTahhxPbRTvGUCEFrWQDtqoqHrHJvGuFpwKfbiLPnRMczESedCB
 dT1shghTrz6lGbiD5p8i0azXp4ZcKW4db2po8/hnqvAsnWeZWm+rytK1U0g==
X-Gm-Gg: AfdE7cnYPvwOU2lLimvPXZjSzlSlFK135FMDa5Hc2dlaLlzXG3/+m1ufEv0KofOZLut
 oxcfrwkI6iuPmyjdUxt3TDQst8JbPcc/bk0iT6g//pTOJHUL1a9qFq8jODHa3wZXyq6jyLRD6XN
 xfxzszUsi65dst5q6AOu+DTTDDtItjhjafSA5FoyLhx62ELOPt9k+v6INjk1ftxK5ADuu5jlQE9
 Cf60AzRwGLbZhA3I4UB46GJYEragKkceYL5UGS2wOz+I1rfjqD4iFBvCbfV8vDLltP9X9DiZ72G
 ScPPbkKRY3w9m5jMxun01rlPfvqmw0E2NpdgNJpFAsOxu9wPzGQ73Ev6RM9q5Do/jQvOHR5leV6
 djZ6V7TmhddBa/IJVi7j6EcZf+tTfIRMYNsMvp6DjXDSi3xhgC3FTDL4EDH83UQ==
X-Received: by 2002:a05:620a:319f:b0:915:e12d:19ed with SMTP id
 af79cd13be357-92b3ea64c44mr1519917085a.52.1782744966822; 
 Mon, 29 Jun 2026 07:56:06 -0700 (PDT)
X-Received: by 2002:a05:620a:319f:b0:915:e12d:19ed with SMTP id
 af79cd13be357-92b3ea64c44mr1519911485a.52.1782744966242; 
 Mon, 29 Jun 2026 07:56:06 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4730937e18dsm15021627f8f.21.2026.06.29.07.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 07:56:04 -0700 (PDT)
Message-ID: <0b79579f-d021-4e7f-9244-125c2bee0d6c@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OzMdojTHTPDTmN_LW2BxU-9yj5PB5yIr
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a428787 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gVTEzMJrF13lI4Zu8YIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyNCBTYWx0ZWRfX/z5iWliLjR4t
 lIbnkLWAHSK7LILMSwM3FMgqWLUqtNIf0yiKQosBuW1ATTil4nTVRJ+53lu+Qom3htUHQ5NbOcS
 LM7Bl3YzyOBSCQUu/gjfGO72MDucnM4=
X-Proofpoint-GUID: OzMdojTHTPDTmN_LW2BxU-9yj5PB5yIr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyNCBTYWx0ZWRfX8BaSbHP/MJnZ
 cjs7XN4OCEZjarRX0OC1qW9ZL4scriEgdDOgJ9gRwmHws5l9kKjRT+6f7vFVKQRu1VpCSgUpiqn
 RlwmZPIcJy9ZJfuCkusJrwx+tDpMOpyqIEe8ERzIeE76yDcE6iKG2TLP/1s9RymOMQMYoPjlISJ
 UW9HtDWFvEj6nfTWxGK+jjuSGWW/rt+6u2LgCz0ryqodEopo8rA9tIONwr+ZCnxsGZ9NjlUeZuh
 vCXBnfp2YnUC5uJjaffZ0pRxj4qjdgWS6pEIK9PaqYE1tpZZjYWvD0bQTu6czNxcGdGScozz/DZ
 omrYEwtQvT+io52x/iUwig1VbZ1tSIFq3pvmVOZ72WapB7UUK6FYaou5x5cRNNwONOwbWtJBssC
 xCWI3PC1QT9FhfgNyxSSab4gnEx4GHexOY+aNhwSlZ83xairvE64SVnOaLEfde62N4+jGaHfxy3
 jhiR4Oy+ShCm++6PFXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290124
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/6/26 15:43, Thomas Huth wrote:

> While it's not urgent, soft-freeze date is in a week, so it would be 
> nice to get this merged before it misses another release ... WDYT?

Queued via hw-misc, thanks!

Phil.

