Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33972606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MzYIhifH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVH2rXPe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgum-0000lv-76; Wed, 18 Nov 2026 09:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTguc-0000kr-31
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:45:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTgua-0006d0-Do
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:45:25 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIEIF421431926
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 14:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7ggi6Iegaj4nJtpS69zTYumZlmrus6viZPG2ZBXurRc=; b=MzYIhifHaa4BID62
 mmfNuh2IxltI518BycOmVm8By+4EDP3JTf2SXlJob95bxQhjb0vC8Md1KWncMYbp
 qeyoWxMbKOHS/HlbDxn55XQCIsN4X5MYD68iF16lCYYzhi0nzjeyqn07CUAYMqjb
 4i66GPWdCwcR6Dkzs7+pIKIv0Sw7EvZ6g0ifgXGgA+bclW5dXnGVQPuFp0sdoSpK
 87CeLHjDxMX4N2SVDMBc0eFc+dFoQfkqqYPKUV803eP3RyB8TBAkntaKruYaRswE
 RzUBQ8ppWYAWZxeZoSpq1/Ctsh9+3DzGVyL9rWvPPl+kz1U8sU0VH4uRHtbVkqYU
 2Zwscg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dnrr4yd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 14:45:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94970ad532bso182661985a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795013121; x=1795617921; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7ggi6Iegaj4nJtpS69zTYumZlmrus6viZPG2ZBXurRc=;
 b=EVH2rXPeJWHLu91lrkO7qcmiehlU1v1a0v8UXldDJpVB4ZZtwDunLW/1XsTiGqK6UX
 hVcPoHddaOB77yRuzlBj6W0e+kFVHBa5VWTsgfeZGmJ2Tnvz0l1O7FNxyNdvCBf3vT/7
 dOMkYU3A4thYtbsrOj4xBL1oOGHeUwA2amJSjpCsbL33eOIzWMMxR8lNThCMJM49NB7V
 Y5NC5uPwMdN3kRo5f7hWCiVT4xEgRjPVRoFkizEUbn6OYLRyi+7NrkMAIbhuchOwA9VM
 zags84VfxpgECiYrvkPQuZ78vEFz66hRXAl2zLgJ6PxLUxF+VN5dz2c+QQDEpDfpCx8W
 TMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795013121; x=1795617921;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ggi6Iegaj4nJtpS69zTYumZlmrus6viZPG2ZBXurRc=;
 b=tiYxR04bSvugjGXv+3Y/H8q3EU5aaUAdmnk9zoYYpXw6OojKRlZjLgfd3SdxNdO6dq
 p34h0aYnhPNHL+NzLi6V0g+6/nR/qQQfcN+ex0gMXzKz4Qa76+2Cvp4oR1VtFTGtwUd6
 wIJMtq1D4WJG8ogvH8K/SMG7o41rC67zGqLwU8J22FJ9DboBxWxW+U1s3gWKdhfBozI/
 sS1TP3QUe+pi25oBRH8V9k2u/vywZsXer7QAguPzaB/W+2wdNUOrkp07h8e8G2jvnpj0
 Z9svVMCyzydjWYJmepu60Or6OnKIOQwQAnO/Ep7Cx4xkaVnpduBpLCIrAuS6l6VzkPa3
 RZiA==
X-Forwarded-Encrypted: i=1;
 AL+hErHmMdE3nFFThvsUUqeQmyTav6Ua2rlRAU7lKpB/RPPyydYtwg1XxuFgiQ5KhRsDBuuHM8QnzCB1U0Sw@nongnu.org
X-Gm-Message-State: APuU4Z9VuA8xabl5V9yXArRNv8FZ/1/zK902aXIFB4V85KN3whHwtxt2
 8KfHLuHCmcul1xnYRNfRwrNpXe/+F9XibhZzk8Qu+kFSZpgpfpC/nQZz328D6Pslf3laWyPCR4f
 axiUXsbNAlt/v6t4Yq4HGqM6dn9gK2neGc6SJu43i/ATF300KvJTBeF0u+w==
X-Gm-Gg: AYBFou3CBuch6tkIEBC9Mq01AT7X0iV6njo3WPDN2+pHbNLv7rmHU6UD9oZK1dHcC3C
 G37cqG5AIuwf6iwdXVlG34nVP5Vp/gdNJzNJeRTSxRmnBfG+6E426vHBxwMGvPTXv3N/+y24gbJ
 HMtITVOPZ+36VmpUjldpSXAA2gcNFszp9IhlRdKX1tDdbR8pugofX/65wPY6Q2YLKSb7Ws84G/s
 jmyeADMgeOyUkVK4GnfOEBS9wa3R8Q+op1/BxdM5DRu4C8xTR7Rv4GTm4bx5RTvT+WtE0ICz0dS
 zstHOe8Sm472bQU7FGSfZguJ56vpU2Va9PvJ7FnNQqlWUoOwEsIN396az/4almevEANg0kHLehG
 Fz1lUPphXSKrPv7kArWoO9jHp+B9jaPT/wc7fODy1sQHbueuoNaNq5p4aXuuKzfaczYWx+rilGT
 VQZU+cyVQ=
X-Received: by 2002:a05:620a:2795:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-949996d0f59mr457771985a.53.1795013121126; 
 Wed, 18 Nov 2026 06:45:21 -0800 (PST)
X-Received: by 2002:a05:620a:2795:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-949996d0f59mr457766085a.53.1795013120387; 
 Wed, 18 Nov 2026 06:45:20 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm160914875e9.4.2026.11.18.06.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 06:45:19 -0800 (PST)
Message-ID: <a8399514-7046-4bf5-a26c-1076d83c5b77@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 15:45:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Misc TCG & HW patches for 2026-11-17
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Tommaso Califano <tcalifano@redhat.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
 <66172cab-a9a3-4be6-a4e7-edc77ba9da44@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <66172cab-a9a3-4be6-a4e7-edc77ba9da44@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NiBTYWx0ZWRfX+nZ7/PuN35Xb
 pDxCcM/8ytC8CQj1oFqT7if159cmssQerPdEmDmyXkmZ0shUskiA7r/ARd/V+VjA61EBXfctJqy
 pNpdkTWXcyTXwE8sqJ9AtWTAp4Yyn59U1o3+OdrTOA9sKo9o8CnDQrn0eWDE2Xltl+MdCCIDP4/
 oMq+D4XRt8YbB82TLa2ty53qfTpg/t0VSvMutoljxxZbSzTCwEKor7S5tdfOSW5ftYwOgEmkCx7
 WvIi5aSfhnPCnyDsw7Id8JqDwD1AUNO6c5bY+qzoeglO3WP1fAhCYAYJxeyRpW8kKPZbTkznhcT
 wqsZJT5H/J3Tq77nJsoGOKYOhDRDfO4b5YT5qOiqK/MdTx0qgd8qmfNeDMCOXtd6BlFKGSjPmyW
 2/8XarON/Ne3VhsGD/Uyo1zK4+Nf58CHcPpHFVWQBpatPsk/2PC/P1hViy/KHPhLVPCUgq3wWce
 sB8IAc8Uby3Nvk3Yuvg==
X-Proofpoint-GUID: kcl8hkGZyvbdI9t2-CGai8e3z6a6Lkaf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NiBTYWx0ZWRfX7uboA3wHtxAx
 1W9qNineLNTDrY5qg4ZhMe1LxJpjz2VeyHCwp74eL77S9Ww1DyMSpAXs8JKC7/Vfj88k42BGjVM
 vnOIBbse4aTfkLoUf0CZi4YmUinUiww=
X-Proofpoint-ORIG-GUID: kcl8hkGZyvbdI9t2-CGai8e3z6a6Lkaf
X-Authority-Analysis: v=2.4 cv=bfH+w+PB c=1 sm=1 tr=0 ts=6afdba02 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=LTSSmNQUf9SDuo4E-48A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180056
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18/11/26 14:43, Michael Tokarev wrote:
> On 11/17/26 02:23, Philippe Mathieu-Daudé wrote:
> 
>> Tommaso Califano (3):
>>    hw/usb/dev-mtp: Fix recursive delete of directories
>>    hw/usb/dev-mtp: Check length of class control request
>>    hw/usb/dev-mtp: Stop processing SendObjectInfo after an error
> 
> Hi!
> 
> Philippe, there were a 7-patch series by Tommaso, grouped into a
> single patch set because they touch the same file and all together
> fix a single issue --
>    https://gitlab.com/qemu-project/qemu/-/work_items/4529

I missed all are needed for the issue to be fixed :/

> Did you omit the other 4 changes because of the review comments?

Yeah, as individual fixes they seems worthwhile in the release,
unfortunately I couldn't merge all of them because the comments
were not addressed by the time we had to tag the RC.

> 
> The original patchset cover letter is
>    https://lore.kernel.org/qemu-devel/20261112174907.158825-1- 
> tcalifano@redhat.com/
> 
> Thanks,
> 
> /mjt
> 


