Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EEFC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocvM-0006Bn-7K; Tue, 28 Jul 2026 04:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocvK-0006BL-Rw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:12:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocvJ-00060V-ED
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:12:26 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82LDT2359345
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KaecBDseZq1cRu/+2Sh7uHCAbf4AGD+/OXb012XCaeQ=; b=o4BEFlW3uNB32QgR
 ulQs5FhLLQHEM3iBXrhdgmGxITD38L23Clv7MkQKzDHOaXED1Am46vS0sPugEOj7
 JaRxMJsWn0MHRyMzpw3JjWvbXxMoEM0Chsu7Je7pHUQJjOqwOQiN9j/7NBSj18IC
 wOCcY95SA+UfWztpfzjfNy146tniyBMsZ+0Gs0VqggjVgSMDYFbl8pVuvJetQpml
 U7lVrBWm/ujaCnTidJM1mdgNNRmfj781JBhUeXlS/qjvPFosVpeCq6vyAdA1pW9l
 7I+qmt8UDlenki1rLh2WwkQclqTcprt9UBKMYhsV+a5V9CB688S9XGZRrJuiqP/s
 Z5qTWA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y0vxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:12:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283df62d68so39405291cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226344; x=1785831144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KaecBDseZq1cRu/+2Sh7uHCAbf4AGD+/OXb012XCaeQ=;
 b=afsT7j1xY3i6rYSaHDLLHhLUSKgI3pMccJ7NkSRnZ3h0p/IR3a4eRLjt9bn8ZAcJNK
 vi3fPjUVlcBkcFybzj+/snTUgZH5+3d7IhZJdmEcG554xLi1HBnV3ECemeteguJSJi+h
 h22toK1B5uov86d0C25YtzgcP8UkHOURApRodRaySKkq+JYtdgR8buGLoLvxJl9dtSEI
 0JPwZbr76ryjdDApfXOI+j4XD25ibCPEEt6/9sF0RZSuf3XV00bHO7b9+34hGv+zOLYV
 2987WGVvHEiKN3kfsdmkn3UN62MovugbtjOODwaZ4VKf2Ta7SnwLkbKqOPBlharFF1qB
 5HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226344; x=1785831144;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KaecBDseZq1cRu/+2Sh7uHCAbf4AGD+/OXb012XCaeQ=;
 b=EGO5O7/WUZ/PnwC2O3BD+K9hiUAMDaAZziUBBiDMrv5gwtuT1+gUkblS96rGgiJSYP
 mTduXb2f72OZhY7g6GOlKHuhxPPax1lyKd7IM5l2I7Rxf9Tqe7oKqj2Hw0k4ST9iHu0V
 tZyH47qg0psgqrbunoL+ZCIm1uXMvQteSHAKC9F0wxADDIqJBa66R6Bm7AH/U6wAMXPs
 EnxeITLUoR/6fnafCWczNHYGgJuV1CAtLW6VTW9J1nkjtbREaCsbsI3SLD5h4KVX90o6
 2KDUjMndvC3M3NKfasoc8fQGhH9O/aV6Xz/LnbKsTchdHVneWbUu/0UH4IxXoAH8DTdM
 vvoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5/HQBWc/oHs2f0qUMGtp0Nzq3g9GAfA3XLSkw2OyyDlnprif59tYg6M2Tiqg6UforKyPRouPpsdlm@nongnu.org
X-Gm-Message-State: AOJu0YylrDQ2Kbjph4uO+6jjAO2p5MVwcWZq+yvj6z1XLosMcfCDAx6w
 0690VgzpRqfD6KLMhDP4IccyreLMuLjLyY5FYv0CVhYz6O7bHoM/yg57mdonY7PSBbw3Qh699Jl
 7d9f4Sct2jBFqch35IzL8tuOvlVStwNBCV22glUCCLP2vYw0WGusO1cnBSw==
X-Gm-Gg: AR+sD12kcdWLv+0gFEHrkgUkCmkhZ816lPB9K5cJdq/JGtsEq1jl5teTxVBTzPwFBzD
 aSKLm0Euyd7ur/I2kMqgX7oYIjiCZe9SH3o+HTOXQFtrrPcyEG9ltXif9bfqRdmEe+oyQ4dpE5s
 61yFkPvJflpePhMpjEvPvxD2SYqVJzyxFv56WNOB5YIk5FFKju6hNGRUffaqPu8aG6xQeBnRhOJ
 vZctImyzNP6qRbqlMxGbJILeOaxuCTCCiNgxEJ9JQs0RS3WpcmZNpwK++vZnGc+wxBRM5RjDpLU
 QOcW1755z8Q5efRHdTgX4ufxFf2Hj9gKArdp8aJhBmy3G4Jurh/NHwIYgka8CuLfTjOpDVw3USh
 XOZQ+csnTFCT6vPdHemgvT8Of16+0AmxG0fP/q1849JFVd7vMdM8=
X-Received: by 2002:a05:622a:15d5:b0:528:3471:937f with SMTP id
 d75a77b69052e-529d6febce3mr9166261cf.29.1785226343976; 
 Tue, 28 Jul 2026 01:12:23 -0700 (PDT)
X-Received: by 2002:a05:622a:15d5:b0:528:3471:937f with SMTP id
 d75a77b69052e-529d6febce3mr9165901cf.29.1785226343356; 
 Tue, 28 Jul 2026 01:12:23 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm56168763f8f.8.2026.07.28.01.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:12:22 -0700 (PDT)
Message-ID: <bde04bf1-fab2-48d6-9e07-0e47b363060e@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 050/103] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-51-pierrick.bouvier@oss.qualcomm.com>
 <1c5b223c-301b-419a-a686-0170ce3fddd0@oss.qualcomm.com>
 <cda94007-9cff-49d8-a36b-15beca93790d@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <cda94007-9cff-49d8-a36b-15beca93790d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a686468 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ym9qpeRovnsZcfP_UNIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX87o3VDBOQoka
 ao4MJwcmQS92HIZAWWQXor3VNvd0KenGGV/VHHlFopq7QiX5cVSKP72xmkyMI2VomJsfd9zphCS
 q4KHM/m5OLT+gaRljzy5NUVJBXnVSVQ=
X-Proofpoint-ORIG-GUID: bJWEa73nejiiRJgEbvU6hkayBPIlgUyn
X-Proofpoint-GUID: bJWEa73nejiiRJgEbvU6hkayBPIlgUyn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX3jIpEEp9hMpp
 mHNUlWYofAO8lOTyyBUlWPOktg3UciAX+0hK7MvfLFvMDO84bmOr3FNzS7YROpSvJV6aKXOZDre
 NJ4r76lXIourkevKAwf58dFN8KmsUaCl0Yd84Tj0PnoQLpjnbv/JEqBcq6itN7h+YnLNU9dQJxs
 YXMx4j8PGeWxvIFMmcItKfBytkKJstFeFun/u+WVbdE5kSrUZOZ/iWF/tc+XzJSmd5MXNpNC+rS
 Q7aq8OQ8dk+rI4qWwKqAR7KbOILmURTxrJWeWOdY21cu14KewhB+g8sgiwThK+i1UFk0yayg7Lw
 Ftu/PVeAikp/qls3oY68UaVQHbClN8h12DmikaFxd5WusgL0FjZFMzExB5OPvVdngR9mrf/ZCg2
 +GY9RvAmVLn2TXoWVATXf88wGVxKDFh5SavZx+0tdy/m+LvX4nRvd18ImicuMzSvq7Q/xZes3zF
 Ns3XuXAjwY603HZSXAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
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

On 28/7/26 09:56, Pierrick Bouvier wrote:
> On 7/28/26 12:36 AM, Philippe Mathieu-Daudé wrote:
>> On 28/7/26 06:41, Pierrick Bouvier wrote:
>>> All big endian targets were returning a wrong value due to this.
>>>
>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/multiarch/sha1.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
>>> index 0081bd76577..6cebad2951d 100644
>>> --- a/tests/tcg/multiarch/sha1.c
>>> +++ b/tests/tcg/multiarch/sha1.c
>>> @@ -48,10 +48,10 @@ void SHA1Final(unsigned char digest[20], 
>>> SHA1_CTX* context);
>>>    /* blk0() and blk() perform the initial expand. */
>>>    /* I got the idea of expanding during the round function from 
>>> SSLeay */
>>> -#if BYTE_ORDER == LITTLE_ENDIAN
>>> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>>    #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
>>>        |(rol(block->l[i],8)&0x00FF00FF))
>>> -#elif BYTE_ORDER == BIG_ENDIAN
>>> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>>>    #define blk0(i) block->l[i]
>>>    #else
>>>    #error "Endianness not defined!"
>>
>> Orthogonal but what about tests/tcg/multiarch/sigbus.c?
> 
> That's a good point.
> Taking a look, the original issue with the current test is that #include 
> <endian.h> was missing (for some wrong reason, I thought it was defined 
> by qemu in compiler.h), letting the defines undefined.
> sigbus is correct since it has the right include.
> I'll change the current fix to just add the right header.

Then simply including <endian.h> in sha1.c:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

