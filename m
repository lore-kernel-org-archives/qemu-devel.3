Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B69AC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5J0-0006y1-R9; Tue, 07 Jul 2026 08:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5Iq-0006kd-RB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:53:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5Io-0003T5-CP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:53:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8mrF3606303
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 12:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 npke8tdiTuia2QzKeBYhYA328xiDhs0qeyYMNBCfOf4=; b=Gqj6SNZ+dMKXi8Y0
 Zp0J4MUMGwVsnco6/GLs4f9bmLrHPDez+sip9ptq8uvGLpou2xmxz9d+WqRD4egb
 Rp7+Mf9CTCdiNA/ItVmVgJ3UcEu+74PoZQfWdC1jAWPE28j4AjtgPAclBdgX1YgS
 qTxeo4eD3R+1RSBtPurQ2XbQrSJswbShJx5HeIMCt/cy4QkfF5fJR4Qinq5nVCpx
 ZwgzjVFJrNEGxGliEcAl+xYQO4Bch20nqcBM+o2NgrgjrycPEkq5rrJ7BIs0LWwr
 upiiJcFjYb7w//m/1G9wlMSzmaU91N0ol7Y5WcuEjko/fYU5UVyFVVMOrHnwKPfJ
 pXeMrA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8j21m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 12:53:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so54642211cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783428807; x=1784033607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=npke8tdiTuia2QzKeBYhYA328xiDhs0qeyYMNBCfOf4=;
 b=jVIMKJ18+8A8IHsZObDLWBQq9Om1SNPwUDDDwDliqEgcKOLFo0+DtVG2HAfjGCKd32
 82egSN5UTiJNoi6h92YHCyu3ol1cO2f2UuFi+CrqBWNPALgA6mIWbf+TRYswvVlXZP+E
 yRwC3rLVs3/IEuKzPbWQyEhuEBdx7jbxQSwssBaQlPuM+IYDvosGITox8doE6TVKzyc+
 phmJwgNGlgTwjNZXL06jyEejFAtgOBdDYRBcwy+iWFnOrISaUNyxwK65eDtkVHefcyAc
 h8RjcR/c27NfHALlhbFhWhYPDv/3cyd1R2wJdgEaeugJqOSo2bF5XmROB9GvU6FUSr9b
 yQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428807; x=1784033607;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=npke8tdiTuia2QzKeBYhYA328xiDhs0qeyYMNBCfOf4=;
 b=Z04xjNODS+ZkHtxqBdGtRccH+SBbjDGEYWNQffOxIlUWmkXlJ2Apl9L74tpPMzvPT/
 xBlYWHSGJPbtMhI1DLtopZ2/g8OuArGSHDpcc2s1RqLwEqOIJ22KJ4cC1FGHsySyYhU4
 906IbVdQrgkQBtga5aX5Z96rRgSaJkoJ+AXNrXxT9xRUqTVxA7gGam8oTckeHM8jd+Q5
 tusSytDpOUezS1Jp4e9mTtQvDiXzW+M+Jl5u2JU7vwABS8RBrsmruSTuCMgVwfcVsA+l
 x35zM31w+Y6m5TKWl8e71qXC3zkMlf2foj1Kt0UfHOfeqmJm+Ru9I5YD0TZ0ij6ZEPkP
 XnpQ==
X-Gm-Message-State: AOJu0YwMlhZvVB0wDiorliOnHgFz6kUjqn1/AcEckANe8r+oc0YtzhQa
 3hald56zcwvnkfxptOYLKYjRoOwC5AlV6C7casyCITW1q3xjBiLO6/B/ubfOujhNQKVisTkjp/M
 dslMkH/Kv4MA3vxnMm/H5TLd+oadkDi300RGjVSdAoFXo13vGMsponQMojQ==
X-Gm-Gg: AfdE7cmTKwBdvaBldN+p59ycXsW6yMrjqKqVNIGHKZBr7TnJj1rHV912PvDpeAjvLkJ
 o6APY3BD02KZEuAjWjeCYpBT05kMCSPqRymLogvEpDBsgSJLN8MJWQ1hXjPufy0SpJfoCSb0Krr
 XhaZqmJt8EEabhFkxoQSGn0MC2YeeWRj7rNvH7Yxs7JBXN7RiT/A6j8BIeyG8ZsiOxGwhp1Veys
 J9gItzPDQDUirH+ur3LV01fikeuXrhwKUkwOU3m5Tq3XqQjsYiq22fbihxFZfnaAfZiE5upSQ/p
 TGY000rni/1OV6+voVFV9rCrGs1dqZ9mxgnGkcZKgYKdb1bvKsWsTyUvlhwucFhRABlyV7pXFTG
 g5fOQBYJq2QWUO53e9M/R04CXBxch/ohjJBtWTu9ESHsiLF2X1qVc/tO2CHL2Xw==
X-Received: by 2002:a05:622a:4d09:b0:51c:a7b:f730 with SMTP id
 d75a77b69052e-51c74821a95mr52209861cf.33.1783428807107; 
 Tue, 07 Jul 2026 05:53:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4d09:b0:51c:a7b:f730 with SMTP id
 d75a77b69052e-51c74821a95mr52209651cf.33.1783428806715; 
 Tue, 07 Jul 2026 05:53:26 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada057dasm132539366b.50.2026.07.07.05.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:53:25 -0700 (PDT)
Message-ID: <4e9aa2f8-71aa-40ce-b9a3-9521c9240b46@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/pci: Consider reserved slots mask when checking
 PCI bus is full
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
 <20260707084050.32137-4-philmd@oss.qualcomm.com>
 <20260707061902-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707061902-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyNSBTYWx0ZWRfX45HL2kko5kRd
 EXWFE6u6P7oRMBJ2kME9G8/BgUuuVgo+UUvt19E74oNYtI0Eb6SL0FcSefig1TcyzBJIGuCqWHN
 8yZXgxwNO3DKVhj5KSsGY57FhsrgiaxNqDpH4YMgJHNSWXiAdhGneqSPqOvx6M045y6SuHb/YH7
 4LOmU/OkjXfYwrSP3HMdR1CmnjOB1jUkt52UP+ruqI45kjeAvtlGGFUWCs396B/B+c1kZ5SdUwi
 0A5RgW5KXjjv2KAxOHAyLNWqQuMHAlldFIVjLmRHUZLgefWz/fxZDtrQ9sWN9PecDTlDA6Uv5JA
 ySDQ1m7JC9urFGQAPGefUxtS2mjt2JMdhvRAhOHLbqtVFIPw6OFrsq/AbkBzV7fIBPA6azBrr4g
 NL6sK7FV8l36tqcsF8O+oLcMQGcbBAi9NwGnnJ4bSd6LsA2p8AW6jnf4Nkcx74d+IJGxQ+u5kYh
 SAwsmS/tbJNsWOw5FnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyNSBTYWx0ZWRfX5U7pQZ2Tr4bR
 yAIpP5HcZNwx3jLstb9vBtapPR46TBLWAvoCQzBtD1znOLRl2qViUPSVAi9OkDssZaXULDrFMP1
 SObkQcD9uP9M2jlmjiSBYVYPnC9XKiY=
X-Proofpoint-GUID: t42VP18h0UCkHScHVtfsYrAJN4W_GC3O
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cf6c8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=89a2Fk8zC9IZJLcj1DkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: t42VP18h0UCkHScHVtfsYrAJN4W_GC3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070125
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

On 7/7/26 12:20, Michael S. Tsirkin wrote:
> On Tue, Jul 07, 2026 at 10:40:50AM +0200, Philippe Mathieu-Daudé wrote:
>> Do not consider reserved slots as available.
>>
> 
> Philippe this is not how commit logs are supposed to look,
> just repeating what the patch does with no explanation.
> You know that.

Yes, indeed, you are right :( I'll blame the heat for sending this
botched description. And I'll ignore Thomas issue for the freeze,
we didn't care for 4 months, so I should not feel any rush.

>   
>> Fixes: 8b8849844fd ("pci: add reserved slot check to do_pci_register_device")
> 
> especially if it's supposedly a regression?
> 
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/pci/pci.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)


