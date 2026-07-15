Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3533C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2Ed-0000Rt-Ka; Wed, 15 Jul 2026 12:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk2Ec-0000Rc-Iw
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:13:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk2Ea-0008Jl-KR
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:13:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3aAC3904898
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VlYEgaSyilleRAi2X7yYrUoCe2IofjTISNCuQHSUrm4=; b=ebxrWtU6g+Poupky
 zkdAU0vWmQjGYGAZLeA9zxKgQNOfwAkX9ZKvNHS38B6vZDe2d2v8O8AkPKujOxHl
 leHhulDimR1e9kqXdB9XUnhFmwYI5NuTGBF7l0eGMlsIaV79jhNEpy3TVQpPhspD
 YWWg6gC/ZwoPgxQZHMXBEBMItBOAh3UpT/tuqmt5Z8nQlzxVnNdvZcKriLrcT5iN
 ChtRoUp08Xg31e3zXK3F/jT7Uj9RMGY6wo8geGGzFoWFJRAEUkJrUhLQ+nNClxpH
 TIH20vfv5y5NCaef+sZl/RbZvbL5sX0vR/1dq5MFGdEG7ejcrJSf4oUZfgijgiuc
 tzQqjA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdwk33tek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:13:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso8824160a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784131998; x=1784736798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VlYEgaSyilleRAi2X7yYrUoCe2IofjTISNCuQHSUrm4=;
 b=QLr6lMKTf1apODx/wsH3HcTak8OTcJ4PiJespqC63S+ZoQIGVNheuBF5IyLOmI0ZYh
 u0PDPVpWsW+nuy6yzpjMDU6DQDGXRm/ynaWdoY7YS0jloq67xV5KzF1Bd+nN66202Zvs
 QBbO39nFecKWXqharKspMzW8/mqF2eGiRFVG3Ka/z6Equ/O1t0ff788YgOqiTKHmx9H5
 ts08lm96II1Z0I+GF2d84jPwyDJvwE5pUb5mf9uepIYnvudjLnkmOtLM1d7DZ5KC6i/m
 my3++fm6CWhKn1DnxKsImSJ9Yuo+uQsloGb1m/euNN7edTHOwEhZ6z3RnZxWTQK+Jxzw
 8S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131998; x=1784736798;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VlYEgaSyilleRAi2X7yYrUoCe2IofjTISNCuQHSUrm4=;
 b=lNjUgBHOZjw4jdRLgx6PzYAxUO/SzZa4T2+rdy3lY3loRWk09DtnX2LnBxxoMg2M60
 fbjdstxmc8syLBGxa/LPjW+PqOIupVoOAWHYqr9fh5/wgr3y8HTWYP8pxyj2dz/LAMmE
 Diq35Bv37g8oGdXWCSHn1SrusEghnpPD4fZnKlCApPQVVmAtsD9przrPJxTSg9qsMesL
 NwgngDllhNuDf9ugSUHhI4AsHHa9Dkh8odF0MkVxnUM3AZEbpwUyalrRdkXUikXuiZSy
 2JnyZaWvqcqHf9t4AOnFF4rwNrVYSd+pYndHRn6MZfps+flo/sisb9nkV5/jJkBwwsiw
 Y9Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/U3xn4hyD1MVSe1m1gEzZtqjX1568VxdYXU8+D3gi2DfLrJmp2GlXzms2Io7fKdKHq4ho2/8D0RkB@nongnu.org
X-Gm-Message-State: AOJu0YwD4v7bmFd5IsjzTbaypWQu0oSNV3ttgNXCPcB7q7Lj2bX9i7Az
 6hC/wDPtTEC5rwK9Rh0ekD0vWjE5L4EdBIQJ442aQnhtjFkiGunpDurkEfIg+hYWlSZjmCP3MBS
 sdjCxsfQuVZ34w7nm7mZs1f3+D0SG5n3zh7C76LPtQKmv6j1znrSPCN2c+Q==
X-Gm-Gg: AfdE7cmEIQIKyKIyJhg0JWrRlaQaMXj9AUGBGHm4VmGLQb4Cb+HUPC5Kn9aral+njx1
 TKqFrOXfCgjqNCy5SCJRaUYTQxlZDHFDFNQ4PNb6RnbeOBRfBGMVCuALlxU+/ERDnGFVzNumxsU
 6QOUmuUiXvwZUefWGL+LhEr/TTnFe7458V9V6m7X29+yXgv764vLo1hQYrFC3mScCzV/lH+s0sv
 9JyL93iSYKi9PGJPp+FRewygtnWIUTnzOAhaj8xtGpvMHBOB65NxjQ9o30zJv4MZeFf6CBAwBfb
 N56dohUGm93iH3eopoc6Iv54blF1sWya2E7JMsjFx53jjthHIVoTNwhU7Z2WJ7d57GMsjIRnxWz
 A3KkN8pdteOzTj1UaEWR90WWnmgEPQ0SNZk9bn+qT6MFvIsbzIl1a/0RCisA85eUDXrBd0NYBBW
 d4w1I=
X-Received: by 2002:a05:6a21:4ccb:b0:3c0:9c1a:8938 with SMTP id
 adf61e73a8af0-3c34d8b396cmr9412880637.64.1784131997809; 
 Wed, 15 Jul 2026 09:13:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ccb:b0:3c0:9c1a:8938 with SMTP id
 adf61e73a8af0-3c34d8b396cmr9412842637.64.1784131997325; 
 Wed, 15 Jul 2026 09:13:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4365b0dsm4621718c88.15.2026.07.15.09.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 09:13:16 -0700 (PDT)
Message-ID: <058aa196-1641-4860-b817-8ad207e5dbec@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:13:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] bitops.h: Add find_first_bit32()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
 <32acc813-37ae-4708-a842-7d7958b7d388@oss.qualcomm.com>
 <CAFEAcA9Smft=r25PJEDiSg6sF-006xLvq56iFWKW+WHWwATUSg@mail.gmail.com>
 <100b70e6-9b5a-4dc7-967c-924a80c09cef@oss.qualcomm.com>
 <CAFEAcA_zBP+Y-ocE39NYYtKBVTsRB_CL7OGC1OELQhcp1FRzwg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_zBP+Y-ocE39NYYtKBVTsRB_CL7OGC1OELQhcp1FRzwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yc6NIQRf c=1 sm=1 tr=0 ts=6a57b19e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Qc2Z5RpNmu6Bdqn3OkQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ry8aPcPzWzML8iV_xgrsqyy2Xepg4r3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE2MSBTYWx0ZWRfXxu5cPAIaHCPV
 Vx+fp+hwU8nuxcZ1sJRcnulJuPLdZXBG03+4Fo8SZ5IFYoi2ZPa5qlMlMGpl7MuVOyPHiHj4l09
 9GvXo3WNlgbn/SinGieJK2IIWY9og39On+B7nsHCGXojHRryS0YvIQ0ZdYHnK4hodLpFy36T1JZ
 sDLFx0UhHMLjpHmmeyvoM/JtATBjhTCqLE4ZvkfMJoRo61pNWbrSHwdytCbelgIpHW8Bdz58IrY
 CbT43qYBxLOQOe55N+RSnzkMD5DjEaGid8iwTP4kGaIrZNAuGsIF5dOAEG4fFaQA2Aa0+ziV2PP
 FKMdnvQhoCi9i1v7NAqbRAFW2BZjb/Z+dSBhSsbK+rd80Dqvb7Le8JXxBtzYdUiWBWsIHat752J
 JqotZBawmL/HNrC1KmD50uLhN5nDg6n82aYtIcpa40cKhwWdZ7IDWWr0I/4CG2RRulwlUejwubd
 hSbB11raB/tQ7qOBkPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE2MSBTYWx0ZWRfX+bXy/DuMIazC
 Ubg51F3bw9JpBdGahjkB/59emBRGarlk7kjnf3KM079jRdk27UPD0gA9jrp/SdQFCwODB2//1o+
 iK1Rjas80FOKFnCuJe26haLeTI/Smsw=
X-Proofpoint-GUID: ry8aPcPzWzML8iV_xgrsqyy2Xepg4r3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150161
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/15/2026 9:05 AM, Peter Maydell wrote:
> On Wed, 15 Jul 2026 at 16:30, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 7/15/26 3:01 AM, Peter Maydell wrote:
>>> On Wed, 15 Jul 2026 at 02:18, Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 7/14/2026 8:51 AM, Brian Cain wrote:
>>>>> set_bit32()/test_bit32()/etc already let devices operate on
>>>>> guest-visible uint32_t register arrays without depending on the
>>>>> host's 'unsigned long' size. find_first_bit() has no such
>>>>> equivalent, which pushes callers towards casting a uint32_t array
>>>>> to 'unsigned long *'.
>>>>>
>>>>> Add find_first_bit32(), implemented the same way as find_first_bit().
>>>>>
>>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>
>>>>> +/**
>>>>> + * find_first_bit32 - find the first set bit in a memory region
>>>>> + * @addr: The address to start the search at
>>>>> + * @size: The maximum size to search
>>>>> + *
>>>>> + * Returns the bit number of the first set bit,
>>>>> + * or @size if there is no set bit in the bitmap.
>>>>> + */
>>>>> +static inline uint32_t find_first_bit32(const uint32_t *addr, uint32_t size)
>>>>> +{
>>>>> +    uint32_t result;
>>>>> +
>>>>> +    for (result = 0; result < size; result += 32) {
>>>>> +        uint32_t tmp = *addr++;
>>>>> +        if (tmp) {
>>>>> +            result += ctz32(tmp);
>>>>> +            return result < size ? result : size;
>>>>> +        }
>>>>> +    }
>>>>> +    /* Not found */
>>>>> +    return size;
>>>>> +}
>>>>
>>>> Either we should express size in terms of number of elements, or add an
>>>> explicit check if size is not a multiple of 32.
>>>
>>> I think we should follow the API of the existing find_first_bit()
>>> function here, which defines the size in terms of number of bits.
>>>
>>> Sizes not a multiple of 32 should work fine -- the representation
>>> is "bit 0 in LSB of first 32 bit word, working upwards". So e.g.
>>> an bitmap of 16 bits has the representation "a single 32 bit word,
>>> and the bits are in bits 0..15". The code correctly handles this
>>> with the "return result < size ? result : size" logic: even if
>>> bit 17 is set, we will return 16 to indicate "no set bit in bitmap".
>>> (This also follows the existing find_first_bit() handling.)
>>>
>>
>> What I had in mind with 'add an explicit check', was to make sure we
>> don't read the last entry if size is not a multiple of 32.
>> In case addr is a buffer, we might read past its last entry.
>> But maybe it's not a concern.
> 
> I think if we didn't need to check it for the existing find_first_bit()
> we aren't likely to need to check it here. If the caller has taken
> something that's not actually an array of uint32_t and passed it
> to this function then the code at the callsite probably looks suspicious
> enough to be caught in code review.
>

Works for me as long as you're happy with it also.
@Brian: you can ignore my original comment.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

> -- PMM

Regards,
Pierrick

