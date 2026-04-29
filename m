Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8328FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIBTe-0006G3-Sr; Wed, 29 Apr 2026 16:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIBTZ-0006Ek-4l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 16:25:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIBTX-0000S7-A3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 16:25:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TFZHO71641533
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1UvIbzR33RJcZEPni0payeAt7cn1ut02z8gxeRCXwv8=; b=RajRJdN87Ae4Vtis
 b8VUDXn9G2FDcfVtIyrPNEKr49O5bkIHQLnDtmYWlcapmzFhDm/Wxslhncfn2ncM
 W5Al0Dy54mDJaNi+70DEonCCMNmkDD79EJLg8giAv8hYfzbUGsRcB7KqGsf3kGnY
 YUkBXG9/Oi5Lb4NK7wDhVmN+vFYlFsobpVBx3vAuy2VsidhBMJqYXyat8hzJGymO
 ix/cnekMB2PAXhBd9jONo9eTL4NekSw3c6ZlR4Kb+pczVth6GAVhlgxjfM/k1YoJ
 jRyveLe0F0tDCMQezu+IRvYl0RfyH6I9hg4QGbs9Gbet1u7OLUJ3jb2b/9JRnYYI
 4oM8lQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj83cgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:25:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2e60238adb1so876045eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777494336; x=1778099136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UvIbzR33RJcZEPni0payeAt7cn1ut02z8gxeRCXwv8=;
 b=CYZJyHUY8w7s83rIkxsjzFnqebSUjb+avHG2ASLWimKbGTCIYCcS2zMs6DbMbLyNpB
 +Ve92IIlB9Nc+H2EpOPRLDkS8HJmfr0+r+MZkw3J97WIA/IJMassFE6afRRuaEDGK9N1
 RvIX+275fPUp+xUk7lzkwdAl/65wNBa6OfmNI9oiGN19FtiVyFmhH2jgQWUmC4CJ8me8
 Jnx3Rz72gunif5IfxDu2l1BaGb+g6W05L8GF4TMfFDhOyw2rppcxS5vgleeJKLw30PHU
 LJUUvgKTNe3B2tm58h9HFPd/kExrCBZUuiGkSDHGMF8JbjJWCtOTl0yLyZPtT62I4cuL
 f+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777494336; x=1778099136;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1UvIbzR33RJcZEPni0payeAt7cn1ut02z8gxeRCXwv8=;
 b=gH+FTdi/C5fjpoFfEvrUSiuDBo/8ww8awL8ZQVC+iFZ6Ut9M7XnaFV1HSVXhFSS+WE
 WNNRGw3pKc9BBH68ZelRLQfUX9Q8xmpXHTLwBhPexhl88OyTvdXR3wkagWxe0azlBzZU
 vL9SFV/8PQm7cAY1kPXOCcMvlGAHPvsprEoIK9I09HNZ0HfSO5JpgJC1b2EYgChTVXx+
 MYBlKZLRWYeNtRsXMpoFKZF1vz5UCsynpWosdhPxiSEfjJ/KgQ3D+oQ+6cTd6Yr2gYQk
 rV1RoeTS/BWP9MkykvqVgnJlgCOORJiVW9bbHv9KKhw+iqF0Ki95w2bj2yqaMFj7waf4
 U/eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VXnA7gNu4YE4ANYKiP/qcDOdCifF+BRdA0LQ2q27Xd8Ardd2KNt1386Kg/HoTPvXKpdJcxpIFCFQN@nongnu.org
X-Gm-Message-State: AOJu0Yyau7LbYxUBuL+jrmqu7L3P9ljzsO9GAFqU/jgUCEVXd0N30qnc
 94c2JI3LJ4LBSVqS+0fU+ntzifWRpmkYcEgXUHL4/zwVrzuYlXYLOpUqDwUn9qLbd33xyK2D6K6
 WASCv2Aq2/watlIiKU5NBTDjczIXSTy63lT7hygTIJOiH5aZY/iheuotjcQ==
X-Gm-Gg: AeBDiesYysF2Ea52hNE69HR2jaFQGdsELL6s+ySizd/famMmE0bZrAcaCnr+Vp6mLtv
 lr8uDPli907dxIbdbPwGBjEVCCujQm4G26RpSXCqpSCHAXMmfxfB6s6WCi5zSnetvi90584JMOZ
 1Z/OC1sRA941BH/MtJB+UO2FaSb/UUB19QovYnLI/+omuOY4wfebdkjw2/ddLkutXOuMw/GD5Ty
 uyrY3TVR/ksskxo/aL6GwhdEV+aiI+e1/eHThBQMdYZOBm5AxXGfWTexqkh+X+N6cL+IPGwrdvK
 O4L3X7SQfNdGLgRnXCTzC51VTCjHPhXKQiiIhNL3dxR+KdBIsqjhQQf4eK5IeLxk+6qeZUtOULN
 wAgp6ONSEUVNzmNQt9GAAn90hGTFlILpkwHYQZBRfcvr/DTSBXMK+2YwOYZ6s0SvSUAdwirsrAU
 l+uoYtX7WiG2iIX2fKjMVT0FWx
X-Received: by 2002:a05:7300:a498:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-2ed0a0994fbmr4510983eec.17.1777494336465; 
 Wed, 29 Apr 2026 13:25:36 -0700 (PDT)
X-Received: by 2002:a05:7300:a498:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-2ed0a0994fbmr4510966eec.17.1777494335867; 
 Wed, 29 Apr 2026 13:25:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d52fsm3772476eec.4.2026.04.29.13.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 13:25:35 -0700 (PDT)
Message-ID: <8209d049-83ee-4900-a3dd-0797eb99ecf9@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 13:25:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust builds don't use link_args
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <24ba9372-a691-4a63-a6da-e8340343faaf@oss.qualcomm.com>
 <389edd46-c25d-473c-8603-1a5d411d0d63@redhat.com>
 <5aed20fb-9df4-4f87-83f2-2309a8d6ad8f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5aed20fb-9df4-4f87-83f2-2309a8d6ad8f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Pm4Dd7yL1sE0e687isY66_uEue7ZmAOt
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f26941 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ukH1R-b_AAAA:8 a=EUspDBNiAAAA:8 a=dXCJVgDiEbLzNdVaxgMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=zUGFzhdS3I8ccRoxxLmr:22
X-Proofpoint-GUID: Pm4Dd7yL1sE0e687isY66_uEue7ZmAOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIwNSBTYWx0ZWRfX6wXQ17fBBvNX
 TfO5Gvl8yeHFr9AlYsl0Kg4WIuV534awhOnS+kjObYsJx9K0P6m6QxWDbchMOPZXOpuvV8yS7ZV
 vArallAGWw1DYLkOtuj4Gw56sBSl+xqehlb3lzWvpgEM2b8n6ONUn+L9kJCd0uTELtZ9s//0lKA
 585d+aAql3NhtK2UNdpt/kkmmPNLK/bzUNsD7rRv1D8tsCppekLyaU3LElsz1dqjQdpsCHVd0IP
 hurvQ8mDRgBySTzQf/Mt2CSfAK8wyjZJ0rHa/89WDLKvK4YfMwJkSVg7SWvAI0mBpAFQ2oStR3c
 PmIIWCDddqdXPRdDGxeKvUEhpAtRS8h9pI3tLQ/WUOKxx5AT2dtkcjBP3ayt/iFvuKgMyVhHiUD
 GFj4VD0FULx+kmxqLMhuCRo6Kti4ieLW/RaF5ig6VUTfiYeeP9uF5Laqd8aya+ALW+hFac80PTe
 Wdgjn6GlpI5g6KS4r9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290205
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 4/29/2026 11:03 AM, Pierrick Bouvier wrote:
> On 4/29/2026 1:32 AM, Paolo Bonzini wrote:
>> On 4/29/26 01:16, Pierrick Bouvier wrote:
>>> I noticed that plugins are not working when building with with
>>> --enable-rust.
>>>
>>> We explicitly export qemu_plugin_* symbols from QEMU binary using:
>>> plugins/meson.build:24 [1]
>>> ```
>>> emulator_link_args += '-Xlinker', '--dynamic-list=' +
>>> qemu_plugin_symbols.full_path()
>>> ```
>>>
>>> Tracing a rust enabled build, it seems that rustc is responsible for
>>> doing the final link, by calling the compiler (cc here).
>>> However, I didn't see those flags being passed.
>>>
>>> Any idea how to make rustc apply these flags correctly?
>>
>> I would start by testing Meson 1.11. From https://mesonbuild.com/
>> Release-notes-for-1-11-0.html:
>>
>> ---
>> ## Change to handling of linker arguments for Rust
>>
>> Since the Rust compiler integrates the compiler and linker phase,
>> previous Meson versions did not obey link_args,
>> add_project_link_arguments or add_global_link_arguments.
>>
>> Starting in this version, add_project_link_arguments(),
>> add_global_link_arguments(), and the link_args keyword argument are
>> supported for Rust. They wrap the arguments with -Clink-arg= when
>> invoking rustc, and are only included when creating binary or shared
>> library crates.
>>
>> Likewise, methods such as has_link_argument() now wrap the arguments
>> being tested with -Clink-arg=.
>> ----
>>
>> Paolo
>>
> 
> This works with meson 1.11.0, I'll send a patch to update version after
> running a full CI.
> 
> Regards,
> Pierrick
> 

Sent patch (not yet available on lore, hope the updated wheel didn't
break it):
20260429202051.2998084-1-pierrick.bouvier@oss.qualcomm.com

Regards,
Pierrick

