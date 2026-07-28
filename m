Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA73CC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocyW-0007dA-Ep; Tue, 28 Jul 2026 04:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocyV-0007cr-04
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:15:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocyT-0006m0-7a
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:15:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82DEv2480142
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XQqiFG2aoLUrZJ36D/JnFNoNB9Yuz7WprZPbxXTXBZo=; b=ZpUV9bdRoPM0Drm3
 ZG48QF3AR1WEbUjdmTxKAQmumQImMlkTf+Vjto+SBAf2XcTCbuzM7yfWFdqB2as4
 cbLGUDb11yaqzeQKL9s6v4ZiRXJYGQJJ6WLJXk7ugy9CSZ/dCCJlTUDshBgEN/o6
 p432s9JN4TXKf7xkVx2h0KDaElW2PLfaJF/qbhBagdK0l0Eg+cC6XKnqqTFSO32/
 kmaw1DJnBLzu78u6bS/gI73MHSvo5nx+lD2fFph/lHPlyxGO/VpWFlPJWH6PfayK
 fqbeYJqpRW8RT8AHNidCNR/3La33HZlAz0fE2TikX+e7rguWZQoESwQNRN7y6Pi1
 1btoig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy10x98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:15:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930a098ea19so395469185a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226538; x=1785831338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XQqiFG2aoLUrZJ36D/JnFNoNB9Yuz7WprZPbxXTXBZo=;
 b=Hv6KmcR6QpN4UqfoIEYUbNa0S1Tu0fmXn5qKYCsO4TVIaXzjnBPPPyHbu24ituUyUO
 O3Dct8KvKChHcijrscXTXdUgsB/X0EJWZOBV74w1AAoo/392ZVq5flsYuiKaY7KTYxWW
 j8ZboMTybjlKkqLIZQFmQW/v7qC39fp5pWvjdAX1qdZkSxHwtV8DrcSV3Dgre0SUStGx
 Qm4o7E7lZFYHQlOqCjML45KCcN1XoRGLOXBZlsLRDUWKWHNCadq2YY21jbM/lN2HJuET
 /QrUbB5n5yUayCTRGn45GRWbpi0dYdcjNA6sQ3qog52CI4zkGX15VBFcO5KXHYDJ2lcq
 VIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226538; x=1785831338;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XQqiFG2aoLUrZJ36D/JnFNoNB9Yuz7WprZPbxXTXBZo=;
 b=UyjBzTKGLBHU4aq+WDB/HrlCMNKTrUhfU2WcturwYCj+Yf3cvDG1ZbUpaQpfFtC9cu
 2Cuc9DxzxgxHCh34AcFgKeFX58D4r1H/rlJDV1TGEWHQ0HT8Xgsf8E0I23kUL+RknnvU
 jE0UHPqVevwQ7NJ9bSKfsdQPk3+ruhkafNmvm3kfH7yZVZ4B5JZQddSo1HpIzD74evF8
 N7wV9XNNtyUgs7lI/dA8E8HmFas8Rfht8hMva6Wt0r2UyzswxrqtlLglWA0IswjXgtRm
 5fDOBQRTQJ6Jtu1/C5MyjEK4qz9OMf1vu8CdZ2tuP5/F8ZUmJIQ1sz6lCE+v37VRI1CW
 BHig==
X-Gm-Message-State: AOJu0Yz9QeyZfJD2YynankUfUf7sBrqtqsI3DMfvnQUObLMhutmnpayf
 Ar3cAp572+bZNQt7fR+eI4uTfSF9Jtg/MejINRZeIy3gW+rOHHV6jMR5znU6N0nJSLmOuVk+cAb
 BEOuCcD0M5ONqLt/coyGULPMgfYsgorlK59zDD5ap94llEFmEC94ctfQ/qw==
X-Gm-Gg: AR+sD13wg/C2QWeo07eHPWwmQUq29pLiMvkgMMC+r4QYyR8bFgZ4ea1d3U3UqLVByzv
 KKT11aUKaZmRSkifzAuxeMTn3OCB0BUREVxMxRulp7qYLWuP6zWHjHLqDechA8+Yd/L6zP9QSuR
 Acl1uuzGe7HARPbzSvJ317D9MimiEKti+tDZ8GXk+fHa0d0HWjylA5xa5JuHl3tBHlRzDbUSdO9
 mpReQntoU8yW/Qv1KUwXUKl1XBeie27Gk4+VDtmG86SlglfMXUXObmK1hUTxREMTFant00JDxT/
 cBx8Kxlf+gziXdFNUGlujpxWx8QUa7emfcKI3WB7occEL75wFHIM/YXE4V8gLzRqmeibDa4Nje+
 spnAtP9q+vaGOC4bdxz/FPUEYlIHrd7tBcD7D2XNR9tYBLUAnVmU=
X-Received: by 2002:ac8:7fc2:0:b0:51b:fe7a:4eb8 with SMTP id
 d75a77b69052e-529d71524ecmr10713011cf.35.1785226538082; 
 Tue, 28 Jul 2026 01:15:38 -0700 (PDT)
X-Received: by 2002:ac8:7fc2:0:b0:51b:fe7a:4eb8 with SMTP id
 d75a77b69052e-529d71524ecmr10712821cf.35.1785226537629; 
 Tue, 28 Jul 2026 01:15:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c462512dsm52770435e9.13.2026.07.28.01.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:15:36 -0700 (PDT)
Message-ID: <d4ed43db-6c6b-4269-b6da-38320d340cc6@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
 <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
 <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
 <CAEUhbmXT9ajeFMz8_1GsCWZJU-FmkYXTPZd-pfYQ2A45Qm7hFQ@mail.gmail.com>
 <D1B4AD96-B24C-4448-9B83-8D319997E768@gmail.com>
 <26ad904f-7f15-4ccb-a9c0-3c3bc279a283@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <26ad904f-7f15-4ccb-a9c0-3c3bc279a283@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bBgDIBBprOGGy4TcKQCxpiKuaK2KukQe
X-Proofpoint-ORIG-GUID: bBgDIBBprOGGy4TcKQCxpiKuaK2KukQe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX+2mPtE5isK3c
 JBbYGO03kDJHyauxIEoxijYPRSCBdpsFBo5LUBvJ4I8U/tDHCiKuEn60KdSEv+2u44yaekh4WXN
 wBB6YttoL/lMX2rwqmVpi542OZdapD2RqRMF4MdZIwMLSf/b9GLw6eKRW0a4YA3StbiWtC5h7ZC
 DhdrUQ+N+tFuEylcA7sEE7WpNCoHqX9Eb7zrhbxXRrvtjlqtuRd1nXMgvvvUEIN01HzlHquD79r
 w62J2DgfN0BHU5NLShkRJmcwFT+2kFJ5FoyoOy+vZsCtCdTvmI3j25mCfokHQvJKiMi3WY5J63w
 tuODVGfyfVLJjdnoDEopmA2/1TQeCVeIZ4Sk/Es3cXQ9GMxMt+oBtjht4tGCx9Mv8kqFtx+LoKw
 G965bSZvKjCmm5z4ppLm2TfOIEY25v4vl+D0kvJfuR8xef5cHOgWVv5IUMLiRhKtL6sWf1nH4A5
 sCap/LVf3ViehhHDibQ==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a68652b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=NUih9VNtcY7qAV_uwyIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX6lhx3IpvmRPT
 FlhIedb1KWvCXA0Ebp7Ix5eKnzJENoqszMNm5Sm/u9tJ/im7UeNY8YH3QF9j2FmXUWuzLdTxlGa
 CujZJEs+a4KeYwjAJ+QlRe6Htg5Zjoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
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

Hi Bin,

On 21/7/26 12:42, Philippe Mathieu-DaudÃ© wrote:
> On 21/7/26 12:29, Bernhard Beschow wrote:
>>
>>
>> Am 21. Juli 2026 08:38:19 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
>>> Hi Bernhard,
>>>
>>> On Tue, Jul 21, 2026 at 5:11 AM Bernhard Beschow <shentey@gmail.com> 
>>> wrote:
>>>>
>>>>
>>>>
>>>> Am 20. Juli 2026 14:50:24 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
>>>>
>>>> Hi Bin,
>>>>
>>>> Thanks for yor reviews and R-b tags!
>>>>
>>>>> On Mon, Jul 20, 2026 at 5:19 AM Bernhard Beschow 
>>>>> <shentey@gmail.com> wrote:
>>>>>>
>>>>>> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() 
>>>>>> while
>>>>>> the eSDHC code path uses the standard SDHC interface. Extract the 
>>>>>> quirk
>>>>>> into a new `usdhc_write()` function.
>>>>>>
>>>>>> Fixes file system corruption on emulated i.MX53 where Linux'
>>>>>> esdhc_is_usdhc() returns false. The same likely happens on e500 and
>>>>>> imx25-pdk machines.
>>>>>>
>>>>>> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
>>>>>> cc: qemu-stable
>>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>>> ---
>>>>>>   hw/sd/sdhci.c | 73 ++++++++++++++++++++++++++++++ 
>>>>>> +--------------------
>>>>>>   1 file changed, 44 insertions(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>>>> index c86dfa281f..e58a610397 100644
>>>>>> --- a/hw/sd/sdhci.c
>>>>>> +++ b/hw/sd/sdhci.c
>>>>>> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, 
>>>>>> uint64_t val, unsigned size)
>>>>>>           sdhci_write(opaque, offset, value, size);
>>>>>>           break;
>>>>>>
>>>>>> -    case ESDHC_MIX_CTRL:
>>>>>> -        /*
>>>>>> -         * So, when SD/MMC stack in Linux tries to write to 
>>>>>> "Transfer
>>>>>> -         * Mode Register", ESDHC i.MX quirk code will translate it
>>>>>> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>>>>>> -         * order to get where we started
>>>>>> -         *
>>>>>> -         * Note that Auto CMD23 Enable bit is located in a wrong 
>>>>>> place
>>>>>> -         * on i.MX, but since it is not used by QEMU we do not care.
>>>>>> -         *
>>>>>> -         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
>>>>>> -         * here because it will result in a call to
>>>>>> -         * sdhci_send_command(s) which we don't want.
>>>>>> -         *
>>>>>> -         */
>>>>>> -        s->trnmod = value & UINT16_MAX;
>>>>>> -        break;
>>>>>> -    case SDHC_TRNMOD:
>>>>>
>>>>> Looks like this register is not eSDHC specific?
>>>>
>>>> Not quite sure what you mean exactly. The SDHC_TRNMOD isn't eSDHC 
>>>> specific but as per the comment above trnmod partial handling is 
>>>> deferred here, i.e. needs to be intercepted.
>>>
>>> If I read the Linux driver correctly, I think we should do something
>>> like below when writing to SDHC_TRNMOD:
>>>
>>>   case SDHC_TRNMOD:
>>>       if (is_usdhc) {
>>>           val |= s->trnmod;
>>>       }
>>>       sdhci_write(opaque, offset, val, size);
>>>       break;
>>>
>>> Because for eSDHC, the transfer mode is already passed in the value,
>>> and oring previous s->trnmod may cause some bits being set to old
>>> previous value unexpectedly. Please double check.
>>
>> By moving out of esdhc_write() into a dedicated usdhc_write() method 
>> we achieve exactly that, no?

What is your final tought, should we proceed with v2?


