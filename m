Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E84DC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmST-0005uu-O0; Mon, 20 Jul 2026 07:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmSR-0005tS-IF
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:46:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmSP-0002VF-SJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:46:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvTkv2430393
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tn4YwetOSaiGCl3PF7wvEM7vPuEgx8RadQWaKDT6hSM=; b=nBb+oegvVAnfXemZ
 TRlEQKCL/YXaSxhmPBbt+qSuvIqHxIvNJWznGStveaHMxnZhZY8s+dbzWW3yMsrg
 oAbIIZBzgAhY7mcobqK4TBRDvBCrHW8izOR9GMUlBd/R+Suj15q6CwydsMkYz1bI
 PfBKrUxqY0JyzsbFU6QqKpWSU4f3WfJw/TpJtaAmUd0mhRFyRwM4nzuV1dMhPPqA
 4fwlmkDueaEsT2iI+HU8Uz++hc3BXNMRzQKka9FRps35J9EkvG1RmrHOt9+YpFxo
 JdaxZrLbw6/EUiNsLJP55ZVneJHzCRf8A7bwZ1qNMGoYLSk0e94oTR1Y3XMNeNAW
 sFafng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhhgyrekr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:46:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-522de3c645dso52854591cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784548007; x=1785152807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tn4YwetOSaiGCl3PF7wvEM7vPuEgx8RadQWaKDT6hSM=;
 b=IO38PEDTKlxtg2XXTpEUWK3xYz4RGOSmzU3hnKpXaStmKziysVROzAxqK+FSMBHgrX
 +Pc/eTb94BeRFePWDV0ooOVRLdVuiloivmoEKOkxAygZIY0osVa0GS8KLFOZhTIXM39v
 1dm4LQyxVduGRzBbymEzMiSxLWXz4kag/ecCz3ZkyYz9gWtanBe7vu7xFcwsUBqyPpZq
 nwqGERR593Ih+ILcddDpkqKEx6hk3k67Ch68WXOm2AiWORP+HtKT36CPect6By0gJ5rX
 YJe7GAa9HtmLFWMNoOqtgpURmBBYxqKc6wecjKNp+fwJk8fPYWxs6fdcQYarzKkrz61y
 6Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548007; x=1785152807;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tn4YwetOSaiGCl3PF7wvEM7vPuEgx8RadQWaKDT6hSM=;
 b=shnx2bW1A/T7rjq2sUrr/M7dsyBlWKz8dE+wzV74MRfQDmLcgNzppsubzSRoya460c
 Iz74ZuMkhff/X8Dj2fh+h6+22C6GUwM5TtKc83XpNOmuS2ZwkFfG7/WyBQZzA5nO9Vwc
 2qis7y7b3Iv9v7mIuv5m72T93n3lM/ltMmcdbTMVL9oSGn273nJTQarEF0qKwHxh5lq9
 B4h6LqXxGBlzT6InlQnaUfGxCbke9YjeU5utasloPYQuTmk6zEpwMsYRofaGmUb/OrQJ
 A4CplJ8BVSWPLSUDLgbZ2ayUEfxAVtcv3Xr9o5QisqxKemUn1b8txLNwmR7TbM/UhK+5
 bzMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9In+DtSO47b9Cjv7ozLXJkRALtl3c86SI+I7D45SlGx5eX5uvcbA/p4Y22f1X8GaZpmhv+aNPTMZd@nongnu.org
X-Gm-Message-State: AOJu0Yz5ltI0Ye4Q3ON7HRYKy6PX/5icFm/NPYNqs1DkfBinjQKl3+YU
 uQBft5ujdYzSpOKK6sHoCGT36cc+RHM5o9VwABTA9OEf1pyTaN5lCv2fw+5W8+WokhDA5Sp+Bsj
 PACyDHCVbjfsGBrLgIEUKPe7KuXgIA8dFQGScTePVDGYIUEo4WS+Ykt24Jbbsk38qpg==
X-Gm-Gg: AfdE7cnugAwxWWxx4Gar1682jWH8VRRcSdkLN7t5NJH/TbvCnaE0lwKtDgFkB5TeV07
 tkJiWS9Vg/PTTDJxN7iYeHppKEeDgNQM9CCDvjZXWed4e68tKhV8vOpR0q4hBqDAIbHki1sZNef
 U3lxPs05YN+RDvzi2dbfO48LdT7N+0wBgRAcXMAAtENx3SgvTin2JD3dRRwI/ZeP37Zp2KoqpHj
 V7MoHFmC+kQUsuQaKeqXIu8dz+8F0uhQ9FkxJ7aTT4/gNivsY+x32RRfHtAui49+20J4Vn7WFVB
 zkXC8oAUrYb4XwrFPV1FuD8S49t/JjY7djBescVdbs20VKTOlqA1hUWAvSHHeGRNRNmDil/k84w
 P43NQRepPc90lkPTjVmIo6RTr+mEnv1x/QGKgoJWxSvfpiI6g7yQ=
X-Received: by 2002:a05:622a:1cc4:b0:51c:9c2:99f4 with SMTP id
 d75a77b69052e-5213cdcc8dbmr130616971cf.64.1784548007311; 
 Mon, 20 Jul 2026 04:46:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1cc4:b0:51c:9c2:99f4 with SMTP id
 d75a77b69052e-5213cdcc8dbmr130616671cf.64.1784548006766; 
 Mon, 20 Jul 2026 04:46:46 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3f07esm266378025e9.6.2026.07.20.04.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:46:45 -0700 (PDT)
Message-ID: <6e4220ed-1e4f-4174-88cd-151c03b8048d@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 13:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] bitops.h: Add find_first_bit32()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
 <cc3b6f33-6cc7-484c-901c-ffa4003c2865@oss.qualcomm.com>
 <CAFEAcA9iSgrua_ekOQ=EaXp=Mcxwk52qK6AkRXCrH1KcRm_vTA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9iSgrua_ekOQ=EaXp=Mcxwk52qK6AkRXCrH1KcRm_vTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzMSBTYWx0ZWRfXxEBNl4Zdywwc
 Qp2BQGmatskLKV7FFDgNcSmWJH2MPUNmAHcx3qHDQ3uHB3NHwcbzztkDU43CfjfDrWVgafW540+
 xC1Qvei0BVW6gVM3G0U1MJS+szdoU8k=
X-Authority-Analysis: v=2.4 cv=LK9WhpW9 c=1 sm=1 tr=0 ts=6a5e0aa7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vyxOcZ8Lr-XSI_iZ1cgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 3VAB0ZMxeBLzrAKDdFHEHreVZe1rKEg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzMSBTYWx0ZWRfX+Du64amrcnsh
 xa5qBHQM07hSOPgsDSb970xFyultnuvCVw5rGbzgK4warKKrFfWVXpRo5AtCiuInLLoBaDo24r/
 gUDnk6MVB4tRT3O9+axhRqry09Mbj2kGgM4M2L0TBeJi3Tig3Xq0Rb14vcjClOropwey/ue+rLJ
 ffbnsx32u7h/1PvCsuSRGTXZYLUaCvov/c7Qr+/DdB2PK3JESdSm7L/I608GZDVq1wOFNrfcHCz
 U7upxfWiHOmcQXkt++EpwOw+KIm7mg6rxxY0KzTxGj0SgW9iLHkC0G8bX2UIuu/bnECdVD24fRa
 I1WZJ1arYcPWdZmc6JtSZiOr7XnNZ62W2yx+ldfXapZuosPJg8i/Sxr1xeb/mDGN4xSpXML19Ie
 Zaw+NcFwXbkoTIOrCo99Ooun3T9rAz7kIX/zYOEbqXrp1+0CBBU5eUAIPACfeQpBsKmb9vbLaQR
 iqYdPgeQM39tidOmUJg==
X-Proofpoint-GUID: 3VAB0ZMxeBLzrAKDdFHEHreVZe1rKEg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200131
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

On 20/7/26 10:31, Peter Maydell wrote:
> On Mon, 20 Jul 2026 at 08:49, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi Brian,
>>
>> some random thoughts...
>>
>> On 15/7/26 20:56, Brian Cain wrote:
>>> set_bit32()/test_bit32()/etc already let devices operate on
>>> guest-visible uint32_t register arrays without depending on the
>>> host's 'unsigned long' size. find_first_bit() has no such
>>> equivalent, which pushes callers towards casting a uint32_t array
>>> to 'unsigned long *'.
>>>
>>> Add find_first_bit32(), implemented the same way as find_first_bit().
>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    include/qemu/bitops.h | 30 ++++++++++++++++++++++++++----
>>>    1 file changed, 26 insertions(+), 4 deletions(-)
>>
>>
>>> +/**
>>> + * find_first_bit32 - find the first set bit in a memory region
>>> + * @addr: The address to start the search at
>>
>> s/addr/ptr/?
>>
>>> + * @size: The maximum size to search
>>
>> Pre-existing, it is not clear this is expressed in bits. Neither if
>> we expect it to be a multiple of 32, or @addr to be 32-bit aligbed.
>>
>> Maybe rename as @last_searched_bit?
> 
> Could we please stop bikeshedding this function? It's
> a simple copy of the existing find_first_bit() but
> with the type changed from 'unsigned long' to 'uint32_t'.
> The comments and parameter names on that existing function
> have been fine for years, and having the new function
> pick different names and comment phrasing seems unnecessary
> and obscures the parallels between the two functions.

Argument renaming of course implies renaming the other companion
methods. You taught me to add public APIs with good descriptions
when possible, I thought your advice was worth to other contributors.
I'm not considering this review comment as bikeshedding. Anyway,
thanks for your review and advice. I don't object if Brian keeps
the current names or rename as @a, @b, @foo, @bar.

Thanks.

