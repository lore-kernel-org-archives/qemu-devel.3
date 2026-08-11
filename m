Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA500C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtkA0-00038U-Tx; Tue, 11 Aug 2026 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk9z-0002z0-Oa
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:56:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk9y-0000UZ-0E
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:56:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BALjkt4177502
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 agkvK8ggp7eihhz2poqHr/XxrshmUOI8lkCPdfeZusM=; b=poGbCtQG32piB/n1
 IAwpOk0pz8+fXXlXMfU6xMp3ofCx4chvr4lwhoxwWSS0N6cy4+Fp6OTJnRFZlJxU
 4xe7RfZgrThKbfZASe9I28flBuvzNntzlyM7NGyt0rFiLcwpjDJlEFiA8FdhhFA3
 LUNS7cFYDZRGqxLIrh5/FLvIjC/Yq9SRDD4HXZ3PD7sXQFvCHNLL/IBGDdXyDm3N
 pSHrY2wdJcWQoycbCGdvYV/fVubuQIcStiS3c0ExG9MuJFXsOGEewqTz1Ka0VEHg
 A72HhlDB3JqNVJuHGClZqUl2INkoVOHTy/Dm88tttqlnlpguri9LWXLkXitBCx+P
 KkWErw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyvcr9f8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:56:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ce64c41efso52592241cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445799; x=1787050599; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=agkvK8ggp7eihhz2poqHr/XxrshmUOI8lkCPdfeZusM=;
 b=T7V6N6v5pbk8XHvkDwYYti/MTkpRPBLyC9pAEKkyh6At0UkSNn5/HAWaD4NxYAswRf
 J0qvHLX8QXq4d+S5/lhF6xqWAx0DiY387bq4gDd1R9ZS5a4J3r+X9Dsxv2OebbYt5r0N
 agXAy8qOqwkXY0kK8vrLTp560A1GvWNiTLzLRMlIjZM6SxqD2BuCOe04gbCgPpWe23Ab
 E5iUgv5qlkOZvgNnYaNgdZWLHjlujdTN7GfzEnWDmMkuysdcNF34lCRyJY+E5FSy5PkM
 AUrcSaH1BVfZXzwyZQyg6CnKOCy1Y3V5qMAxSK22ToFau/iPKIlNaBbqw3HqZB7mKvx1
 U91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445799; x=1787050599;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=agkvK8ggp7eihhz2poqHr/XxrshmUOI8lkCPdfeZusM=;
 b=e7gh1CRTGmLjedYxsfFslj+y6MU/4ff2Y3ZkDCjL4gBZiwjRenvCQ9n6yeqcBTaTAB
 X9wKQFsD34vLK7dn5TdzQD1sG6mmWYDLINzKupK1T7oDJLOeUIjL9rlxISI5bRLGr+ra
 Mxw6n3v/0MSNCsNEUyyadP7gEBsYwBKCelshqWdVubOXRYlCufiC04wMowEIl7rhjU3G
 qgz43SLUhyGmgZAE1nNpWhTOSVbG90yEaVMcxfm+NJg1Xd/KHCv1nooak1UVsXQHeVxS
 z+S+UXptZXFwhnvLgeOWINo79kDNvaP8+5XKEoywxCfjd5Qny0/PKUjzx/IOT82B3qFY
 stPA==
X-Gm-Message-State: AOJu0Yza8l+wFPZ9AYdHZAF64krtme9chWq43iKTuoQf7FD6Xf5XdRqV
 MD54bQYjb9HRlVaNnK5sE50QHoLHjHEuAquvzeHf0L/N7/v02OpqoHZR3j/tuxd7TeVtg1AEj1R
 5PF01nPgmKluFKpIDomQcUNWcFF2GO/rnLGzWRgkc0p8ieWVTz5HTjXzwEw==
X-Gm-Gg: AR+sD12BC8HdOMEmFIGYbblAwYA3MzyRQ8MFgpa6n4HZ1CyAOx3IY/BZI2159sdDQwe
 y5AgQWQYuN4ACVWZRTZRgJkEPuv61e2sxQlXkphgN50fyF+6JQrBN0G9oFDwGbA6B94Wl+uucl4
 5aE+qxUrcciSfvYeQxmX/WleiYXvveY4EjuduGVlN3ofS0Vkx6DVsED5nuZtjTfQLJw4uulBpn3
 F2xRaMfRCOP69Iniyq/zkYz+eOTQLFYPjz5PC2RMsQ4TLz/c+MZ4EjrGiG8ME1RMamLLZASqpSZ
 jMQ7YBI/j5dzX4obrJSzqCZN5KN2kfRRJ7eBZ8ux1PU1e9hAmmmuvQOJdxh8DIR7tWtWnVjQPeH
 YECTsNvdkb7n0nuU6bTwoAsHUgJWY58DTHrS7QMTf
X-Received: by 2002:a05:622a:4a8e:b0:527:6d0b:b399 with SMTP id
 d75a77b69052e-52d586946bfmr18758871cf.39.1786445799573; 
 Tue, 11 Aug 2026 03:56:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8e:b0:527:6d0b:b399 with SMTP id
 d75a77b69052e-52d586946bfmr18758561cf.39.1786445799149; 
 Tue, 11 Aug 2026 03:56:39 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977bab479sm28759265e9.0.2026.08.11.03.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 03:56:37 -0700 (PDT)
Message-ID: <8b29d341-9807-4001-b8be-106d315a4e29@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 12:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/nmi: Safer vCPU delivery
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
 <ac8e5e46-eb2f-4e7d-aad8-390a940829e9@oss.qualcomm.com>
 <81799d60-4409-4286-8795-192e1b8ea4fa@oss.qualcomm.com>
 <eff6e1f7-e477-42ea-a80a-14349bacb97b@oss.qualcomm.com>
 <anrwDkuc9LoY3uhg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <anrwDkuc9LoY3uhg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MSBTYWx0ZWRfXxi8sdZ/T2bNZ
 nmD+k8SjSdjzt5+i22tSMQSmpC/0c6JFKrp4/UFGsKtcn2z0hXTs2pVyBmjxLSOfJWZ5qtJXJKG
 D4dBfq3rdd+Ft/gyTkeauBihO3vvYhP/RxF9okp8FLoZ+8yjehdmBfPEDmx6q9q6IKX4g8IctPB
 jDrO30g9aTRLmJhORz+bODCidhN1lo00dKg9soqd5YZQ6A7S6lO/So9bvdj2qrmIvASSP7bPag/
 UrqazuSUaa4tdWyS6eaxpbBkJbT6DKeJpLtRAdnyQ/KPlZyaZwj/vyLwhjQ7DMD0UigHLt3qSpt
 b4L3ZisUR4gEccYTmolk3d7nQ18PHXj6NBIzPlh3NkLBXSJhao0r4ixSbHZ34mjEIUVbAsXjiGU
 roXqxOExWwuv+uUerDKXcUuVS83z9m3R6Lti2JV670/qd7bv268vNUVHnS+21PFXDZc4cpJ5TbJ
 VocWgLM/AVcM+/9Ebig==
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a7affe8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=gG9_uzZLLawnOPDZY4IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: --T3D10zBpotKDiE0-Z58hM6ioT3lh-o
X-Proofpoint-ORIG-GUID: --T3D10zBpotKDiE0-Z58hM6ioT3lh-o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MSBTYWx0ZWRfXxgGjQt+Yomnw
 +s0mKiWHY9t7gwfJDYl8KCqYzeFPp/jyPRoG0O42Uu+kELyaK1ICQAEozbLn1OmZyA8YMKALkbw
 1BTOZzk9N0CFcSqAm7c5aSVMdRm7fl0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/8/26 11:49, Daniel P. BerrangÃ© wrote:
> On Tue, Aug 11, 2026 at 11:36:59AM +0200, Philippe Mathieu-Daudé wrote:
>> On 11/8/26 10:50, Philippe Mathieu-DaudÃ© wrote:
>>> On 11/8/26 10:44, Philippe Mathieu-DaudÃ© wrote:
>>>> On 10/8/26 23:37, Philippe Mathieu-DaudÃ© wrote:
>>>>> Hi Marc-André,
>>>>>
>>>>> I don't remember what I suggested particularly for
>>>>> 20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com,
>>>>> but this series is what I had in mind back then.
>>>>>
>>>>> If you find it worthy, please consider including it
>>>>> in your "Make HMP optional" work.
>>>>
>>>> Not well explained, this series disentangle HMP from
>>>> the generic NMI class.
>>
>> Actually previous version is better:
>> https://lore.kernel.org/qemu-devel/20240220150833.13674-1-philmd@linaro.org/
> 
> Are you going to rebase & resend that ?   The old thread has a lot
> of commentary that I don't think it is worth reviewing the old code
> again until updated.

Please discard this series.

Old series rebased and reposted (addressing comments) as v3 here:
https://lore.kernel.org/qemu-devel/20260811105425.7429-1-philmd@oss.qualcomm.com/


