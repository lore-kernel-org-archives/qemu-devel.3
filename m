Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51989C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 05:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Lce-00034y-QQ; Tue, 15 Sep 2026 01:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6LcQ-0002za-Pf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 01:22:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6LcP-0008MH-79
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 01:22:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F4uAww2032181
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 05:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QsHbF0iZ/RiGnU/d6vMRjUdhWqk3Yc4GsBkY6SrGARg=; b=TZOPcAa3qd83q1+O
 JB3sHXrjrg75UO3g7GDEScOqikjUvzgpfKzONgX67M0RVo1hRqF7wtBCULvXpQgN
 olDNq43x97SJo/u8lbDRL6nHofyzbUVtCuhz3eBppdE3uY59xyBzA99G6PnQEYi4
 Raj9piYjTOFbKm2b54Fn55RFL+aVbEqj7h9vnaNNkDO5tjfBd3jvjJiU62rduVQe
 5hqkNbnh87nVxXk4lHTZx0rEoAHWwdTz9Jd+kMuT1+d6+Y9bOcmMehzAZd7epKIk
 uYLhTJA89PZCpBEXOl3DO9bWd1UCBcJb6ZXVMND8DXgSBMsKrJMFcXNY+THwezI8
 LBKsug==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpye702tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 05:22:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso623939a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789449723; x=1790054523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QsHbF0iZ/RiGnU/d6vMRjUdhWqk3Yc4GsBkY6SrGARg=;
 b=XXDtO8HgiBnRIIIf74VQRrvuUAk7DnitnKJCEKg27OzRB11mb9CXYwn17Y501pPGZV
 SxBqtBEQNZaqlWEQ6WcHiuoQrcrEmRnxULxkxX2d0cwpjnfv8Wv0v/Oza3fywfCoFyFA
 MdO3WxYqqGpMAPjWJtrjcdK6Lnt6LcFAYlZlJf+w2N+PkxopV9jYyqAxAfnizF+dJ6NA
 R0nG11ZmgbCL3PBZukvHKEIgIjku73U549pXxY28PZdpO7c45gfr1Zq70uS/A3gBygVL
 gnMBdO8QnGFH80CTioWA0MvrPvQfr/UBwdQ34uv3AzdPAieGMmtbCV7ZkGRIKor7Lj/d
 PDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789449723; x=1790054523;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QsHbF0iZ/RiGnU/d6vMRjUdhWqk3Yc4GsBkY6SrGARg=;
 b=heHNs22qn3p/8aqPqHbgouHWU9x7lCAjNxCB1jkTA+Uen/uM//WOMm3g0xvZ+6zuSU
 cpZh26jxlVW710941UtGa+loDdsGZjwQtH28kD88O6MNK+YbacTr5dLahcEpoqaA1Qtq
 HHqPhbypxfz6KFpwgAzVYp0uljlgApRqSm/IGSV/Le4aNshqyOf6zV0NsWq05eqhNVZR
 a+0Fs/RpmGlngpoW1wD+oLagrntbsPpDaVYWD+JI7RUuU3OspWNwzU7X3pwIf1rEAEFi
 VB0OL7hNSkRy50dki+fyNJHCP3//gGWvBRLLx1O53s3o4hxEPkyb/8cVJDQUeNI4XAGa
 4Usg==
X-Forwarded-Encrypted: i=1;
 AKwUvByMvRpjZMd1BPB1nzrXuAKHL6g6bcCvb0IyHnCPMUM01UgQwgcD3rZw8RI7xHCwxy8cS8dA43GiNM4Z@nongnu.org
X-Gm-Message-State: AFuF++n7qnOZt2wFIvzYRxC8m0mQGr1oLIsWoM48ip/SBH82gqZ3pJtO
 fJSDiQRj0BPy+3gjP2gOYDvcT8DbhP0M/XEAlFdAyVwgg4cAMNiG1Wen9oeDzWPKa/dToY72tsi
 4eGOwqHk90Iuhy3P8QIaAyDGJ9Sc1pO4vwFFQ8bSjFH8qlS8fkv0II8K77A==
X-Gm-Gg: AYBFou3zaojGmn5/nlJIXdOthIi2huxgX9TnhePjGMYAYPSpJrsnNkOo0UrIeVr+O6T
 uH43cI3IhfEJ6oRfJEyfEeRFK0XP18x7Jk/y2bEPumrfKJ4KAHC/0433O2WVClOpH/tGeDIykhg
 sapevBwGOutPizVhe3aHVwTWNopQge/lbKvybCaSKPDpEB2uWSqNfjAzRnySFCAiJDioUJEVb0o
 LRq0S4Ah662rX//1mAZsQo1HSIVeutGbvpjgZy/kebCyV5l2ZobMZMBmJ5h3wi/L+YrylzkCHUz
 UlOPLkQ1dkpcMO8hT8sTrC3teOzBhHpeeJcd8DdCCXZN4g48DcVV/f4PRXkECvWc6eSC5XTdE+f
 labJhhln0mIx4XxHUV5kQwRIdNSUXo6r1aVpSsCQDfw1hodH0eyztivc=
X-Received: by 2002:a17:90b:5348:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39dfe0471d3mr2783794a91.5.1789449723517; 
 Mon, 14 Sep 2026 22:22:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5348:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39dfe0471d3mr2783763a91.5.1789449723058; 
 Mon, 14 Sep 2026 22:22:03 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdaccc0fsm2839570a91.15.2026.09.14.22.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 22:22:02 -0700 (PDT)
Message-ID: <0c59f6ac-1840-4479-8831-838ca9af3f6b@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 22:22:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] roms: fix compilation for {vof,optionrom,s390-ccw}
 blobs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
 <9d06a145-297b-46b7-8df1-c00dd51484a7@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9d06a145-297b-46b7-8df1-c00dd51484a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3NCBTYWx0ZWRfXzsiepIZ2Nx72
 QajMr7syoyg3LyVKDNkMXh8HOyZ1anMUfXYypraIszAwIrcZImtr/m/MP8SKvyEQqhpL4jtEW+F
 DSzJGjBbnItVzU4sjDR9pClco+QRN28LKVvq/YEDIoFh+IDM9EN+EQVrKigzj70ZalyL1CTaJHd
 qo0DQdXi9Y0lZXRX12WSSV7ASuI3f4UbzTu/VIuE0V2lHqrazgH0TLFwUtQtmMnPEaVkQAXc81T
 Euv/7kREQVYQ8sGyTVtCJWj8mRpZrGCJtYJfD347xHrtiaa6Eh3zgzmjyUPEAUxepuFb7gGWcqn
 krdEBAdCzsm034z7nydzymde4Yx2I00VNyRc8uVcV0NM92FuqRNFC+ij3TBMbnULV1X0QAvMtqH
 95xANGEYD5oI3lOMzhfquf+Fdo2fV0QQ2CCzuT72+U4hL5irweFasSliJa7cdFXVm4nyyPTWL61
 L0txn4oGecStvtWj9Cw==
X-Proofpoint-GUID: KrnUCPhxzKPKMxq72eHfVm17ajt8o0uM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3NCBTYWx0ZWRfX3cAx9XfWSD1j
 XCnGXMoT5KE41J/aXBzjHxIB0s612tcFvf5jLE/RQ76x0Q3rO0F40BN0liYF0N5szVtnWOlG82n
 M+3PIy70M6hG5G7oPyTaj+kX9Q8bUt0=
X-Authority-Analysis: v=2.4 cv=fck4WEQF c=1 sm=1 tr=0 ts=6aa8d5fc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7j54PoZPxgzlAQWijgwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: KrnUCPhxzKPKMxq72eHfVm17ajt8o0uM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150074
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

On 9/14/26 10:04 PM, Paolo Bonzini wrote:
> On 9/15/26 02:27, Pierrick Bouvier wrote:
>> Recent switch to tcg-tests removed a part of configure that was generating
>> config .mak files, that were reused in other places of the tree:
>> - linux-user vdso
>> - pc-bios
>>
>> Taking a look closer, our roms sources are supposed to be in roms folder
> 
> Says who?
>

It was not said on an authoritative tone.

I can reformulate to be understood better:
Taking a look closer, it seems to me that our roms sources are mostly 
located in roms folder, to the exception of the one in this series, 
which are in pc-bios.

> You haven't even *tried* to look at the difference between pc-bios/ and
> roms/, i.e. that pc-bios/ tries to use the container-based cross
> compilers.  Because if you had, you would have mentioned it in the
> commit message.
>

I noticed this difference, and mentioned on original thread that I would 
not port the cross container part to avoid duplication. Those files are 
not built in CI, nor by default, so it was not obvious for me they have 
a special status vs the rest of roms/.

> NACK.
>

Without the move to roms/, does the change to Makefiles seem interesting 
to you, or do you prefer to keep configure as it was with no change?

> Paolo
> 

Regards,
Pierrick

