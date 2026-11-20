Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF160A260E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ulc05Gsp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gZsVJhA/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSGP-0000PN-BZ; Fri, 20 Nov 2026 12:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSGN-0000Ou-LK
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:19:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSGL-0002eH-Gf
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:19:03 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfDPq1066182
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j2K1HDiZnOFmW1E8xXEt9Gf5cK+wmNfiWpMSXUvkPN0=; b=Ulc05GspxVY1CCi0
 booUnbH1/bTcbRRxjlRzgG3Xqsn3XP402iyAn71k3KyD58Kj7vLGzJ4MvaViO+4M
 XcUnJbelK1ihi08s4P9ExYVAfAWN3UYIwOOvgmnekWA+4cKZ3g5DYtM2ZNqugzKs
 CFaxDe81s+SIFmN2DLwsXtinxeI4wtfhxZFDDaTpk1tMOH6omIx0OcPUTC3Gls1n
 dSFKTSqWRaSRzbPLRzW19t1KUlyq/8/pXXPdAFnX8vdJKaSLQ7Ybx8FdYaWjmOtZ
 2HqLUImIhY1fk+7/Zo1AtOSEVHMmZBa5mjAnO0WL+uTly/JUGVWpYY0cDXvaqF0E
 Djyr+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fsbjwdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:18:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-949b0d322fbso172567285a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795195138; x=1795799938; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2K1HDiZnOFmW1E8xXEt9Gf5cK+wmNfiWpMSXUvkPN0=;
 b=gZsVJhA/hLGf2y0sJTe8hjrI/phRwmL1JZEgElOBm5QkrIROhOAHVL8+LFtZTu95bq
 o0QRMHGqlUGgiGBBuJkidVlbEWG//ZO4hAybJQKji6slpnu4n7zYyFb2N3GeMrfrAu+0
 JFy8LRI03jwxgeVAwIGlLfPmURQ4FWtb/KgiISJGVxCnCr6v7Qn3v0MKSdkHOmOIs+Gs
 gBG4vQp3ClsYWWOIXDJhrygy7JCxoHfmn8Y7WkxbIs+M36rWkbhA8f86qcH417908HSB
 cSrBmakm2yOW2WiJz2IbW8SUEKEd5JQj0c2WLpL8dEsHH70o1NBTSnide6imR8FkgdVw
 vBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195138; x=1795799938;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2K1HDiZnOFmW1E8xXEt9Gf5cK+wmNfiWpMSXUvkPN0=;
 b=FIG/yCuRITAGfsRZuSw3o317yhYQxFr3Rqlt5zPBDWR2DXeZtPXVsYmgjut04LBI53
 mmscB22aK9GzZosNN+6IbZV7ip7LByM3ccjeQzvQjpk6Z6LMBx3BVnWc6hWU4JbjMrqH
 MFy1JkYRd/z4m40ytskYZtAiqK/jYiTcKlJLHcjedd0bwRP2eaEVRYgZP2J1LIMZg06X
 Muhetu026kepz/to1xSigBkRQr+Ig9KcfCmmU6qujnpls0ScDGE8bjSi71kAz3tCzwV8
 FpKDsvo1wL8I1fszCeFHUIiqXvD3vr8YB8Mk87/+AmpuQFA0b6Iut9MP+PfSUa7zgbmE
 00XQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHy1YU9A8bs0vIozeX888ZLb7606EHdl7CDx8am+F5VnfPbQyxsbk8/Cms9VGW902VYdqL7hjBa9jl8@nongnu.org
X-Gm-Message-State: APuU4Z9DH1YfOGD+7JFknliCZrSYEmDqZVGA5HPNqwbn/w7eifUFwSAw
 gKsgx0Iytak5O0ulnt5DpUV3qWtzNUbMLFargl/Mu8Bji5LtHySTCemLG/OVhrMYpec4YeAANv7
 ghlodn7cK+ZaHKsbO3kjrXeXVG9oDuZS37vBtt8dKGwiMJ6TFrXog+QNzbA==
X-Gm-Gg: AYBFou0+1YkQ3oZBqaeuCYNq9snAsVsCbpya0+MXy9ac4EBZkdq2kA6WhZxX9ANu3hq
 RJyFQOOnRUY3v6TfFtzDqk6WQhVSbOFQ2JOKouaYP/3gyzqJdsuzHgsGNzxJYCGxR9jAmSgg+w9
 HDVMHHny7+Q9jEiyHNeTHlmnTmHhqpTxXi5qEZoTVjvyvU0ASaZAupBdHELziUjPegS0hRNrEpG
 nSe8ERDfqdUb23qJPCSPfjGEKyp/q6HKGN6qEA0+aLrP5u2CBAoYbgT1XYflsQYxNcehp0By28q
 uFBz+E59QAdF4Hq8NfO0cQkr4YxlRGY4jf3u7fSo+PCPI9EWzqoVKWQdSsX6bzOKVpgFVFptdCz
 lZEZlE7QZuso5hDBVxE1Im2qYwr9nT4a9uV04AnboXclzpBzrzkGoBmORhtM19m5TH8goxT1/1G
 mm3YpBXZ4=
X-Received: by 2002:a05:620a:4727:b0:949:326f:bd2b with SMTP id
 af79cd13be357-949ba9aa37amr620004485a.43.1795195137990; 
 Fri, 20 Nov 2026 09:18:57 -0800 (PST)
X-Received: by 2002:a05:620a:4727:b0:949:326f:bd2b with SMTP id
 af79cd13be357-949ba9aa37amr619996585a.43.1795195137338; 
 Fri, 20 Nov 2026 09:18:57 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm107817855e9.2.2026.11.20.09.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 09:18:56 -0800 (PST)
Message-ID: <28be7b0d-da2d-48d1-80b6-86492abf7550@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 18:18:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
 <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
 <062a8d3b-44a0-4938-8fcb-9f755d92c21a@gmx.de>
 <b9ee3eb0-9a65-42c1-bf6f-078b0f34a5d1@nutanix.com>
 <71fa0d0f-6b0e-49eb-8044-9c4eb30b9f38@oss.qualcomm.com>
 <8b0e292b-c27a-46c8-907d-3316ce16a667@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8b0e292b-c27a-46c8-907d-3316ce16a667@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXxKeyyrdXefNk
 DwLlVYyJXZfumTjdHBXRO/zKfNLodqcZdS9JO18DDc2WtPJt6Bghc7I42o4Q7xEfVlqKkKAFT2l
 e6FNYNs2f4+qbOg7o7v94C+BAdns8X8YXnX7QQJFN74gLriW9wlUv9ZXcOXb6kr9Qs/VZPkFzM6
 P/7WNAKMHh2eD6bH3HcG5Ih/abgDCRWGvjZj429amDzUwGYdmaCwpqDb/VOs8o70SY0FD0HxRPr
 RiLlL/p4zsLAnL5XJ9U75GdnEQHcokW00VhbjP7p2+Q+3wGiMC9LLDS2kkG4ErVHEEDBR++li8r
 lJhb/FVSTdZQDiBLhksINadEs8iNwKwPgjJYTAXs/60+pQMzrTZC5xEreA5zXG7EHe7eOrMNFiE
 OCeQdY3VXgTf5Klbpdmo1EKzt3HBdPDyLj2eI45mJlhddh24XQUFaHV8rWPIW7QHyDCouVNfR7O
 GxP0g6kBEvbEN3MDa3Q==
X-Proofpoint-GUID: c5GqszYptIOqIKVqtPc3udZ4bQM5NoV_
X-Authority-Analysis: v=2.4 cv=DeiCOftW c=1 sm=1 tr=0 ts=6b008103 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VEjALGItrutBmTdmSwIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: c5GqszYptIOqIKVqtPc3udZ4bQM5NoV_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX1Emx7p7eZt/9
 MA7YI8oD0EXxyHTITf1dAuIga9PmEzD/RxF/RBbgVsMv0k24B7fXrbZgQk+Jx5LenemwK/NaR1y
 aIY5P8yYHrllKdaOMuwkEXA1ahf9ybA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/26 17:43, Mark Cave-Ayland wrote:
> On 20/11/2026 16:34, Philippe Mathieu-Daudé wrote:
> 
>> On 2026-11-20 10:59, Mark Cave-Ayland wrote:
>>> On 20/11/2026 08:25, Helge Deller wrote:
>>>
>>>> On 11/20/26 00:39, Philippe Mathieu-Daudé wrote:
>>>>> On 20/11/26 00:32, Helge Deller wrote:
>>>>>> From: Helge Deller <deller@gmx.de>
>>>>>>
>>>>>> This is the third attempt to replace the existing 53c710 driver by
>>>>>> a new driver based on the code of the lsi53c895a.c.
>>>>>> Patch #1 is not meant to be reviewed, as it basically just replaces
>>>>>> the existing driver by a new one.
>>>>>
>>>>> "Please do not review, simply accept".
>>>>
>>>> Well, I agree, it sounds quite rude, which was not my intention.
>>>> I basically wanted to say that it's a hard lift-and-shift patch which
>>>> makes no real sense to try to review, as it is huge and replaces
>>>> most of the code.
>>>>>   hw/scsi/ncr53c710.c   | 3042 ++++++++++++++++ 
>>>>> +------------------------
>>>>>
>>>>>> Please review.
>>>>>
>>>>> .
>>>>>
>>>>>> It would be great if this series can be included for qemu v11.2, 
>>>>>> as the current
>>>>>> driver does not work stable for any guest OS.
>>>>>
>>>>>   11 files changed, 1426 insertions(+), 2215 deletions(-)
>>>>>
>>>>> IIUC even v11.1 driver "does not work stable for any guest OS", right?
>>>>
>>>> Yes.
>>>>
>>>> Helge
>>>
>>> As I mentioned in some of the earlier reviews, I have a lot of 
>>> sympathy for the submitter here based upon my experience of doing the 
>>> large rework of the ESP SCSI driver a while back. In particular when 
>>> working on QEMU as a hobby, it can take much longer to find the time 
>>> to complete any changes requested during upstream review.
>>>
>>> My take on this is that we want to encourage more people to 
>>> contribute to QEMU and unless you happen to be an LSI SCSI expert 
>>> it's almost impossible to review a large rework like this - and this 
>>> shouldn't be a barrier for contribution. It's clear from Keith and 
>>> Helge's comments that this series solves real problems that users are 
>>> currently experiencing with QEMU's HPPA emulation so I think we 
>>> should aim for a more pragmatic approach:
>>>
>>> - Aim for a basic code review based upon our existing coding 
>>> standards to check that the device implements a reasonable object model
>>>
>>> - Ask for proof that testing the supported guest OSs (Linux, HP-UX 
>>> and NetBSD) doesn't trigger a sanitizer abort when built using '-- 
>>> cc=clang' '--cxx=clang++' '--enable-ubsan' '--enable-asan'
>>>
>>> - Mark the device as not being included in the QEMU security boundary
>>>
>>> - Update Kconfig so that the NCR710 device is only built when the 
>>> HPPA target is selected
>>>
>>> If these criteria are met, and given it only affects the HPPA target, 
>>> then is there any reason why this series shouldn't be merged?
>> Sorry if I missed your comment on an earlier series, I was not Cc'ed and
>> try to not read all qemu-devel@ :)
>>
>> I understand the hobbyist PoV and respect it, but that would settle a
>> precedent which I'd rather discuss with other maintainers or during
>> a community call.
>>
>> I'll try to split this series using a LLM, since this appears to be
>> an acceptable use.
> 
> Hi Phil,
> 
> I think this work is different from the ESP device in that when I did 
> that rework (about 88 patches from memory) there were several guest OSs 
> that I had to test on each commit to ensure the series was bisectible, 
> and even then it wasn't possible to keep all guests OSs working for 
> every commit.
> 
> The NCR53C710 is different here in that it only has one user which is 
> the HPPA machine, and the submitter has clearly tested the set of guests 
> they wish to support and has considerably improved on what is already 
> there.
> 
> Based upon my previous experience above, no matter how you split the 
> series there will always be at least one guest OS that won't work: by 
> splitting the series it feels like the end result won't necessarily be 
> any better for developer maintainability, and will delay the merge of 
> some much-needed improvements.

It was quick enough, already posted, no clue what it is worth:
https://lore.kernel.org/qemu-devel/20261120171235.61325-1-philmd@oss.qualcomm.com/

