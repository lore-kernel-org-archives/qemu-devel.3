Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E644C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TZj-0006Bi-GC; Fri, 04 Sep 2026 09:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2TZb-00066P-Qk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2TZX-0002y5-Gl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AJ3Pl3277324
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cZDwoyISOu5DsleId0iTDNy9xUnMUS+IBUlHEwYSxe8=; b=XfiBjIjvrSSsvMmA
 cOE4qLTVCidbeRvuGFlbdY2uWYrKYDJxtPUprqDFaXbVulutgvNAK1zy7V+Wgcax
 nFIb0u4rym2NeqoWGhtb90/rNzyUKRzubCgQSDpDGzyys1tp8h8v8EY/XaLbmWFN
 34QY6pLe18T0fq1dgjJul+ESasGozotwcJ2SHspDwH+G+JHwfELfx1JMsmhB5Bs4
 Ny24I7O8af5G4WLOIfOIEUDp4f8XZDeB1s1INySBAFFNvS0DRAMCZ/Wf4n5Byoqg
 /leVOR00VBXfLQQgbSGEi/Zvgz7LnJlQkxDN6Ftd5mKVRMGow7pLSZAgegsn3SGE
 2GkYxg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd1gsb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:03:06 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-836cfb589a3so18662887b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788526986; x=1789131786; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cZDwoyISOu5DsleId0iTDNy9xUnMUS+IBUlHEwYSxe8=;
 b=CeKtVfCfMsviTEDd3KxIovPjePdf/2pezdHqxc1/cwNJgng5UcAAnfZM+/a4N7fmvg
 vaOLYbGgLwPzi54hycxSf6DqOey04JLmsvI44e3+TdsCd5vjCynG4fT4Z70X9AnZlI5u
 +74ySG0IbNBHLIMeddfaQtC4Owd+0+IDqrcJoRepErXrlQZABtmHM+wb0OyQITzfR6mA
 u7txDom8iUKMKKZudqKivZ94+A3Sk48r6hDe4L435VEM2DP+uq45BwEG7VWKZNfJJG4N
 +EdbcZ8hdG8MmfxoEJsBn05tUyK/GEbDsf45AISLD5LGpeTOav5uh/TLaAqNxiMQ9qRR
 io4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526986; x=1789131786;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZDwoyISOu5DsleId0iTDNy9xUnMUS+IBUlHEwYSxe8=;
 b=rgkQ9lnc+Ziy608W/TvxQgVsZGxJXiateyroLcs83eLCFcQaLARTjhuyyYnH7jRh6+
 FcyjWBm0QMUiCsVyBjIMXbrZcx5JW6AI09eaTR3ZlzBABtcEEmDf5LOral2VSr5mRCQj
 6J7fe8D8ZT3bFNsbE+GL6ju6ydY+3PIttE/nQ54FULsizXfulcvmZj98k02BYtevh55I
 Zk/64uF+Hs53XoQoh2GXh2tvYYe02JrD+SKVyQF2S/FClg5cBNohBh69+abgzdcD9X8H
 SGNX9Xgq1ei4W1+X+QyfUHvvCvMNUquKwpNtOjsCv5Rppg/iqL8AqZjXtsYf0aewBvUo
 mofA==
X-Forwarded-Encrypted: i=1;
 AKwUvBymbjjswH2s+8521jESWabKthY87tZQJFW6zZ9SJzaQTIfnFkVMYe87L0YPUCPnrudA/u6oYtPEm/SB@nongnu.org
X-Gm-Message-State: AFuF++kOaS7l0Ug1/r54UpjZmGljzcgYiDrZfxAQtXgp+5ZyLmHMRgL4
 4AcbnXYY62CSHF27CLGz0Bbcl6KGnF6WPbMZyWETRqytXVVX2yvhbR0ZSGEeyl6Ms4r1nKk2nNm
 iqDyN44QH8TZQx4gkYwe8ZyaNnxXCS6DT4scXckZKtKzILs+iZLCnYwyXNfrVMhycTg==
X-Gm-Gg: AYBFou0/FNGWbxCR2BRzTZEyXMDoGg3qwk6uxuDW7nkoP2LwfNJBoXNdMxpq4nXVA3J
 0PNUdf0I7+HyMx7fNLUBEaSg+XDZWdPggd2UiiHNT7/j3tPpDJUZHoGeAuxxQtdcYkRo0FWZe13
 6GYfbHQ/TiCX8Nea1YxJ/JJBpRotDVAmA9oo2vvszqlpphUC4BXRmLs9k707piSJbR/GcRI0tna
 ezjugxMmb6brnxH2cxf6/qAx6kDYD2lhtfyQNePmUh5oZAzaxYjiufFyM0dx7qNkPy12vZUAB6I
 OeHWq6Gn/GR1wsFgCiIgoRthjiAspeFed7mwFYRvthdGgna09A/SGYBbuCONy7X6JaOD6qsbWO2
 G8fW0Y12/gqELGy1sjuXaQbvqD8oK1aIPHg==
X-Received: by 2002:a05:690c:c3ef:b0:873:5bd1:98d1 with SMTP id
 00721157ae682-8735bd1a0acmr1453537b3.67.1788526985742; 
 Fri, 04 Sep 2026 06:03:05 -0700 (PDT)
X-Received: by 2002:a05:6123:2e9:b0:5bc:42be:f758 with SMTP id
 71dfb90a1353d-5c7ed3c6dfamr2485452e0c.3.1788526966159; 
 Fri, 04 Sep 2026 06:02:46 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be1c1sm6131741f8f.32.2026.09.04.06.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:02:45 -0700 (PDT)
Message-ID: <8a282fc2-c583-49ea-a183-5934d0b3c3cc@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: Peter Maydell <peter.maydell@linaro.org>, luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <CAE2XoE8FTYQMDZFdjf=gayR7H0MJrO=thUcFXddRWBd3_2KQZA@mail.gmail.com>
 <CAFEAcA9eLNLs7ZRaH=PS7tAK49WeJzc0PKfWVG3xKRdc-joU3w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9eLNLs7ZRaH=PS7tAK49WeJzc0PKfWVG3xKRdc-joU3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tPRPc2UtujcIK1xBsax3lg6vaMhHUCaP
X-Proofpoint-ORIG-GUID: tPRPc2UtujcIK1xBsax3lg6vaMhHUCaP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOCBTYWx0ZWRfX1oxfNgdKWETa
 P60i9aeE/iVql2z2nraXoeBsWuWK8eQOcLPXLuX5cm01R52kRyIKJzX1d/zwdG3NaKaKFViO6AM
 s2zRE/TjQk5pCQpoYWYroaO2b1V/ioU=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9ac18a cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=lUiSEC1R9o1OYI5mJ9IA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOCBTYWx0ZWRfX0UFlONCs5GHS
 A4SfnlTG0/cHw+728PtSdozyea48+yMOtXI3A/ZYcGIXeJzlYtYoFj0aNYL80c3Ch4452UL+Qb5
 CElq0xNLG5yu2uZiMy6u3bKFhOvxwJ1AS0GmYAj/0z4jQHrkgoDKioTOYN6UJTcAh+6JfpAWoic
 3ONkBRWJzh/SxofMEbENhRBZUIqxhu79fqQmB8HYKofTNnk8U7v6HbvXzPDVU8ibGuc5v/F+84Y
 L/570UugCz+VqoEZv2ufRNH3lOeze20Ds9S6gNLyeEecJa4C0OJ0Ap8NGC8Uxi/dXI0DQ+Af3GZ
 AkqEe8gaOEdssnhrda/Nne9LkfxiC8ItE03O+07zFtp9JXEKyUK9DJeSOpoPJUD+cwaugDt2WnT
 GTnt+wd5xT8IBphX1O5kp/ns9wf2051nvpckDwVkQqpXU/j/jVXcO/shoQLXYeiIQ+5Ds+ZKpGl
 h/twy8NOn5uicsztDXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040118
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

On 4/9/26 11:41, Peter Maydell wrote:
> On Fri, 4 Sept 2026 at 10:34, Yonggang Luo <luoyonggang@gmail.com> wrote:
>>
>>
>>> I was wondering if maybe one way to approach that is some
>>> "disambiguation" syntax on the machine name; so one could write
>>> "-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to
>>
>> That's the Proposal B: target only in -M or argv[0] (alternative)
>> Do not add -target. The target is always embedded in the machine
>> argument, or inferred from argv[0].
>>
>> - qemu-system-aarch64 -M virt: single-target from argv[0].
>> - qemu-system -M arm:virt: single-target from -M.
>> - qemu-system -M virt: error (heterogeneous not supported yet).
>>
>> There is no global option that selects TargetInfo before -M.
>> Early option parsing still has to read -M (and argv[0]) before
>> machines initialize, the same as proposal A reads -target.
>>
>>    qemu-system -M help
>>    qemu-system -M virt              # error: heterogeneous not supported
> 
> This should be an error because it's ambiguous (and ideally
> the error could include listing the possible candidates, like
> "Did you mean 'riscv64:virt' or 'aarch64:virt' or 'arm:virt' ?"),
> not because of anything to do with heterogenous machines. For
> instance there's no reason
>      qemu-system -M vexpress-a9
> couldn't work without a "arm:" disambiguator, as there's only one
> "vexpress-a9" machine across all our target archs.
> 
>>    qemu-system -M arm:virt ...
>>    qemu-system -M aarch64:virt,gic-version=3 ...

I don't understand why we are discussing the CLI options and machine
names in qemu-system when nobody has a clue what qemu-system is for.

The overall discussion gives the impression qemu-system will be
helpful toward heterogenous emulation, but this is the opposite,
it hinder our work. We have identified many core problems in
QEMU APIs and planned to fixed them when needed (because too many
issues) and only expose heterogeneous-able working machines.
The current approach try to expose everything with core APIs
totally broken. If we go this way -- which I don't object at
all -- I don't plan to look at the issues reported, for my own
mental health.

>>    qemu-system-riscv64 -M virt ...
>>
>> at:
>> https://lore.kernel.org/qemu-devel/CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com/
>>
>>
>>> disambiguate when just "-machine virt" would be ambiguous; but if
>>> there's only one machine of that name then just "-machine foo" would
>>> work. That extends nicely to truly heterogeneous machine names:
>>> "-machine my-mixed-machine" wouldn't need the user to explicitly
>>> give it a -target option or otherwise say that it includes aarch64
>>
>>
>> Seems this direction is fine, May I post experiment patches with this direction?
>> The machine-filtering is still needed. and when the target is not specified by machine parameter. The default TargetInfo will be target
>> SYS_EMU_TARGET_NONE. And it means emulating heterogeneous machines.
> 
> I think we could also let the default (no target specified) work
> for non-heterogenous machines, as noted above.
> 
> -- PMM
> 


