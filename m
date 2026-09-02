Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C5C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nHh-0007LP-W0; Wed, 02 Sep 2026 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nHg-0007LH-CL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:53:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nHe-0006z7-U2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:53:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FcjIO1806775
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sW7JbNTJX7fhwhkgo8oPeRzohvsBawGYdqv0Oe91N2Y=; b=D1ke55eS6TBCXoJu
 ajNHAgDTI2FTnQwLOCeLsyD9cZg8VYUaiwKNng1xA6FJ9fOUda5caVbqeu8aoRUl
 m6itDKHpc54aIXGOe9i1xWA4n+JKh4b/bmqdhxUEV+ckzwIOtnNnkFa0c6Koas7j
 kURnmvstL7HixFesPW2IuN7N5cWJFRsnsRM83o8C62TfBaQiVAeXGcbftwT0fQfa
 frTnECzmoZ3komON7A9skjaEidkCXk1cIfy1MO/BJSukz9jOXfODceEvyUjTBjd0
 0PEO+VXGYkuSk5Px1A8CR4KGgcfeFL8qaDw2JvdzidBnV37BUWALV0t7loJOeTXc
 nLB6MA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdr912-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:53:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939665a1ae6so168587685a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788364433; x=1788969233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sW7JbNTJX7fhwhkgo8oPeRzohvsBawGYdqv0Oe91N2Y=;
 b=RCfq8HOKgq1GszqCg7DxRF5b2U+gJUx7E/y7mV/IJvQ4BpfrUM5u3B1kBRnSu8NGcD
 3YFoywOdvpnjgUY4pBwrYiA9giJ74f6/XLfFyXTiOCmLLYHE/50gLnSh6UDaAn0kt0e9
 6fCDUaDokJEgg/gENFZqsVABJHbb1rcvctjicetQEXc1+zVAgu0PHqXi1lB5YpBrUpN6
 CPEgcFPwS+JXjI+imQyJS8mPBs9emWZU9mwzhob5cpbBNqaxnLkneCZ1Q++99UavaFL4
 l1hPiOjyS0XYeBZSi6Ul0lkUW2yoHifEB73a6ZK+sNDWysVNwaHmzHrbSfiqOn9CJr/F
 nsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364433; x=1788969233;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sW7JbNTJX7fhwhkgo8oPeRzohvsBawGYdqv0Oe91N2Y=;
 b=p/1HD9anQj8vmxGAKnnhr8TtmrlyZg61BPVbEk4JaTeOJ6MNGPHOhv2yB7R+tcasoS
 ndI/xJyGiMczoOF/WFtrMawGaJ748gj5NQDZjUh3aFBy+fY/GnBuT6Uqg4dwfb9v7mhV
 jcFfMhtwMH7DOzXxPbCQeRXMT/utqn5DluwUQVErjw4NeLLB33R9Uk2tZfwoLdfRxxyE
 eTXez5UDizWigFjexm4gUgnXOTIrqWJo6aEokR8eYLkfq1545OvBEil+Bl/zhfr58wYa
 M3eJP7MQzq0hJ8UjMnt+2Yje0StwD7+D28xnCRwRTPj2+/UhEI0GkX61kxs+LqhkSrez
 hm4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqgx0KPwAGoOdqs5Jc/g/EyC5P3yN1g5buxYoIwyPDfKQyu4mQTztFzE29AmKqH3CKREnccuhFGyN4Z@nongnu.org
X-Gm-Message-State: AFuF++lka4WLtysK1+lB2F1qYN6A8xq/3wsjclvg8NjWQ0CdsiXrpwxa
 45gJI00yMS+wpS04z/eafVnzs9/HeCslPK5qvzXGoeoPxiLthV0qAfWhe01S3HT/ci+sKobMD9d
 x1WXtrxPgcZp5ozYmyxmlrDzqFJrx0ymsz6/KmVX8m4DKYvHizIAq6vSGeheMToRCaA==
X-Gm-Gg: AR+sD10v9gpG0X1Y7/2EJiT83k/7b5G+4zbdgIvr0Vcmt+g8ZjXYyvJec6PpPvzwpNO
 1PvwKsL3vFgNsCVtoatzEINdiCXIx6xFSNJm5aH/EFq7iG8F59kbTHR1ggkRWZAbXhaTlKIiaDT
 NUfyzFr5auGGot/qV603tkGS/gzxxk6nIcYmm90F15EFtna17z+JJEI71FDoX84tgGKMqS0ho1G
 RJCTFIjRfxvj7eXjlegP02gINzI041BgHTRHztX9khORpfe1ritBdUqVFMfnevmOEJwCyqm/5+2
 zKOsAi8BQ8Rw4R1YSkzZI6HHF629piPYqBOcrR1Tsm0sqVmsoCxIG9mE+cROXunpcrKsWGlwclg
 dLToSqJQKZZ7uaph+AdHgohqNuKpKdzRqkw==
X-Received: by 2002:a05:620a:1724:b0:92e:45e4:c6e with SMTP id
 af79cd13be357-93960efc4afmr705975185a.22.1788364427956; 
 Wed, 02 Sep 2026 08:53:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1724:b0:92e:45e4:c6e with SMTP id
 af79cd13be357-93960efc4afmr705970385a.22.1788364427302; 
 Wed, 02 Sep 2026 08:53:47 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d9e7dsm1366485e9.7.2026.09.02.08.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 08:53:46 -0700 (PDT)
Message-ID: <537f54ad-a5b7-4f61-b1a8-0167e0fe1e92@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 17:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] qom/object: add is_available callback to TypeInfo
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a984691 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=r6GMaPgdXFw_UnAZDlMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 8u2cogx3VQDobg9Bod5ezni2duePzOAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MCBTYWx0ZWRfXydnnBGhI/VzN
 JW0Dy6nDM44Rrcr6PNiYrlAwGJoFSXr4EpGN6P6chPe3a84cFQd/2xZ7IfDB0ysx5L/85/HQ8OD
 ZvX2amWrb/FUjX6JZdtae0c6b+trpF/Aq8U4DQ2FK6B5mKfLXwhWjHycx4fGf2iLQGeybvSne1Z
 MFRwtE1Yz1f2dNXj6DTJpfoq6cazAhbxeRDsKpZbzq7niWx5bGOvSlepOCon5p0ZciPcYa4bCZ7
 d5UYShWOSWVQQTxxcyHVGjkBN7WqyeDnwtBesNMa3lMng3DX6tZDmMSVE6DIH3XgYvz4pirS8N9
 OAG8KQw811AbBJ7ckDVhce1MEiJZZhPpJl1UO4mx+J+FZAmMTvwgVMLRTishn498L4qyIlUmCy0
 OvuPjy0pN0xWRsPHP0J8YcDjqXrreSKNSxKWsLjcPFQYJjvIWQz/28ejlKj578msQLBZi3+RoDK
 ugcUIDQTtYPOOw+T8gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MCBTYWx0ZWRfX70WibxKxR/GI
 9kp7YkrtGyIbwDu197DobxmVvDW8w5xfy/em/Df73HjLMW4nPL+GmHdw0xAbX4r6zWFawI/NfXP
 iedsqYoGE0T+1+ilHyECxRGE847BQRc=
X-Proofpoint-ORIG-GUID: 8u2cogx3VQDobg9Bod5ezni2duePzOAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020140
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> When removing target specific sections (#ifdef TARGET_X), we started
> exposing types for different targets in the same file.
> 
> Previously, we implemented a filter based on interfaces, but it
> proved to be too cumbersome, requiring duplication across architectures.
> To simplify it, we add a new callback, is_available, to TypeInfo, that
> will replace the existing filtering mechanism.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qom/object.h | 3 +++
>   qom/object.c         | 4 ++++
>   rust/qom/src/qom.rs  | 1 +
>   3 files changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

