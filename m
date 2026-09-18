Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B7C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7c7E-0002Oz-HY; Fri, 18 Sep 2026 13:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7c7B-0002Oi-3u
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 13:11:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7c79-0006kJ-6H
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 13:11:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoM4U676970
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 17:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZF3i+uduXuUozbtD+gC3wHSEg53dF1oNZ8ARpzyVt6I=; b=lLMQEP/6LbTEUuQK
 ttRlh6R1qD4eNiKL9V3BJv2aw1/iz4oL67jOvyb+wJj2QXPH2sYQeJm0KMX5nPHf
 rcAb50qK1OhpCy65BHWssTgDYCNS8s+zgFc9k0SiuRDYNHJh+jHtYTTO3Qz342ug
 snzJ193nkn2WHpxXM2pg7p6GtWAMbzf1zWi82UwD6wRLOT5eA0X9/Vkt+52si7XQ
 ot+S4cRoZ/t+TTJ66DZ4fBW4WJ9AMpyU0z/wgdXS0k8vHk7PGaKd31ta95Ypxj8W
 oeLq4yLq2MTxq85qiVSiVA51vgf0ou3DaAun7L6kA+l3U8W4jJIf1WybFUbpNsZr
 KtFOww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrjdvan2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 17:11:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so17331935ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789751464; x=1790356264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZF3i+uduXuUozbtD+gC3wHSEg53dF1oNZ8ARpzyVt6I=;
 b=jFVO3yzh8vnvF5LR740f4cCdRUjw54/u+t00nmzHmXTLncBI334jlmPwD0kCpZv4jv
 d2RuDcQMBbwREvMUSikKVxwRknQcPhAUX1CJMj+2qWuqJ3gog1sxVmd7EtAaibMbImFK
 gHkp7vnaRNbaPVMJj68w/9CzNfiLZD8BPdJmxUDAMJvI7Cey9NrpJj0H80utEpM9NZhP
 zw1e2dKvT06RFxKR8caW1Ao+bS/eFG8/V3uS9vfJcSB65qfzc4iTLV6eKvbngq1dcbqK
 Qe/w7GoAnmOVe4GDMx4IZlPwATepAjZqW+qiaUr6DWG7ecH9uJjDGWZt58d6KFzl6/qe
 k+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789751464; x=1790356264;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZF3i+uduXuUozbtD+gC3wHSEg53dF1oNZ8ARpzyVt6I=;
 b=fRfhisFYeOakhlqYz+3g5P2f3eBUHmIBbArdXhiUs882v5Ip7Gt8RclJBPM7jTPDlN
 1I7EfKPKng4EmJIoVJRHOdPGSLUjYq2AMqpgsuAUAocg2r7ZJpX+uOBnOuPQ64Evthzx
 u3oy0kMTm77jW6oju7p2kUcEyjD2FchV8mOVMGc9oXOddkx+zkAWBvMRVBD+ISJwMPon
 5/pQ4I35e3CTj3j471kzjc6TypLOnhTB327wVj0jfm59BO7Oy2Tssi3fpIsNJgOm8+ij
 DdcuQA8uy+tmEtalDA8XQ+c9WHNt4DBAq4dlLMOOkEcxzYQK9JkvaOnI394th1sOVUbY
 5wJw==
X-Gm-Message-State: AFuF++nBwsM148sEFhwAQVwAx6AqJZEsYVwhviyyMCRgxXibV2b5MDWd
 NdDMgE7sXglesGKsJAYb45HkgnUt7bKOVMqFJnNYd9Op+SGh0ujGgPwuO1FnMrvqKnbH5kzYT2Y
 FrmVP7+hRLTcTST4b0Wayo/NBXqjsbaspxppwdbp4bWFe78gkSgeVCBiN2A==
X-Gm-Gg: AYBFou3QQXpzvzwUBe1uPagebttqV9r90EmqsNfrc+wBnEBcwTAT4KD10LuQEvaG5xQ
 qMaa1fitNJfjiX6wRWFIxLS0F8rmB+hxx0xoPwY63iZsNdGCjPs2mpEWQ7PmsbAc9Bm0kGVld1Z
 BHM4xJAqJksUMu5eElz3GjbhnzlLpzpik3hT7E/EWjtKm7L9luVIH6zIw5V1zbjpkL04vnmaXlF
 LZQBc3rPyIBRtDnUHg8waO95AbYtqp9uRQwWXaY4J+TEVg5XxSpyCw997/eBbycUMEH4Y1/Kuge
 ygOGmKTnrYoOwbRLXaxJKRUl/pLeLoqUQe8q/qUgEAUZ9DaSEpI/9XgWsdh7/cFwR0bxI6+Usk9
 VjtBfRmSLUdJjnuZ4B5VUoreNwSxb+Dc2fPYv0I6ZkKkiCNv0Eitm6FHKSb1qIGCexf1q
X-Received: by 2002:a17:903:110f:b0:2dd:c053:e666 with SMTP id
 d9443c01a7336-2ddc053e6c4mr7408645ad.44.1789751464402; 
 Fri, 18 Sep 2026 10:11:04 -0700 (PDT)
X-Received: by 2002:a17:903:110f:b0:2dd:c053:e666 with SMTP id
 d9443c01a7336-2ddc053e6c4mr7408275ad.44.1789751463819; 
 Fri, 18 Sep 2026 10:11:03 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a0e5sm141944eec.10.2026.09.18.10.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 10:11:02 -0700 (PDT)
Message-ID: <e45f6d5b-010f-4ac0-94fb-3860d0229d23@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:11:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg: fix more container issues
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
 <CAFn=p-ZHdCGWdxN7viafrTybhBzm+avpPc5tDfg=cd9ThmXYDQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFn=p-ZHdCGWdxN7viafrTybhBzm+avpPc5tDfg=cd9ThmXYDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0NiBTYWx0ZWRfX+fdIrUgb/D+C
 ttsfVVJbvIMzQwDHmdTs8SwumAMu1ZOGXRh6kqNfdhgq2EaLYRg1ymkt3nf5WFn8JnJrYy9GIAI
 vwxDDN0rvfnRpT9XJ/fcX9yH5nMtCbVQgRDdwJmAJ60i9J3QNsp3vnD1k0k1AcfR8grsbn5RKIk
 6zi7/IFmJUOEq04KtkDrnCjBXgzGI4vPaPWN+BzRAVrkJD4KJvsTiG2o+KB4xfFXu+BRS/XX/ao
 OynHHadw/47jVMc4ZLPGOvXJKzTTRQ0EkAkoOrcnVR9EJprafb7MQF0xU8A4HKd3/Qs6isIYU16
 IiyPlSnxs79G2W5vFcK4nEO/vVGl21Srl5UKp9nDB9VpDmZLVuFg4DhKjogSihEeTq31vOhJmn3
 plPtx1y0zvwsPAc6W8RLPpjRb9YJw7MBQoAuIan4VVYZj0p98Pg4ebGYa7kgRavH3W6872ncsST
 YKlEtkhmgqhJqW2ioLQ==
X-Proofpoint-ORIG-GUID: LiaJDkctvb3ML3uHJqyjMgn2SK6MdOZf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0NiBTYWx0ZWRfXybea/onT9qE7
 WxZdNSr89renIOHN+KI4zuH/1QBR/tm29mM2oBI8XFixv3sGPvIMW4h9NWwXEU0RwOoRQUAZMTI
 G4AOuajOr77mxCz/DTn6nazzfwWcrbE=
X-Authority-Analysis: v=2.4 cv=J9Q/fwnS c=1 sm=1 tr=0 ts=6aad70a9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=_XVCL9AYNST2H5sEPZgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LiaJDkctvb3ML3uHJqyjMgn2SK6MdOZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180246
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/18/2026 9:38 AM, John Snow wrote:
> On Thu, Sep 17, 2026 at 6:11 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> This series fix tcg tests compilation with containers.
>> It fixes SELinux hosts and dev container with rootless podman.
>>
>> @Alex: it's based on the v5 series and can be applied on top of it.
>> It can be added for the PR coming tomorrow.
>>
>> Based-on: 20260917165602.3405537-1-alex.bennee@linaro.org
>> [PATCH v5 00/17] testing: various docker clean-ups post meson tcg conversion (pre-PR)
>>
>> Pierrick Bouvier (3):
>>   tests/tcg/meson.build: fix host fs mount on SELinux enabled systems
>>   tests/docker/docker.py: fix run command with $UID == 0
>>   tests/docker/docker.py: do not add-current-user if $UID == 0
>>
>>  tests/docker/docker.py | 16 +++++++++-------
>>  tests/tcg/meson.build  |  2 ++
>>  2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> --
>> 2.47.3
>>
> 
> Series:
> 
> Tested-by: John Snow <jsnow@redhat.com>
> 
> Thank you!
> 
> --js
> 

Thanks for testing John.
I'll send a PR for this as soon as Alex's PR is merged upstream.

Regards,
Pierrick

