Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCEBC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AZT-0005xg-8T; Mon, 14 Sep 2026 13:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6AZQ-0005wt-2B
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:34:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6AZN-0005Su-Vc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:34:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0XF7607594
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mAmExiEFYvMr4IIfVNz2Xn7QP/vhDLVmiOYkI8LrhfE=; b=hdZWiqJxlvW2zyJX
 oQU2c3/ijW7q/1jsx+C281ML10HAcG6RWhdf98E8vN/TLnqxlsoqor2Xb2hPdRjn
 zPRHKVz5cgyQQwakJY+wXQpMmgCjK8FHdsjHpKJQ5Kr596f7fkLLEP31U4awFsmJ
 cxUAqw4g7wGmP2EDTYFqPxpaDAZA7nNRLev5bnSkjTx/LhBNmZmYr5BD9aTY0fzF
 YlTIB5wMbW8WwoaJUOzxys8Jq+B2huMMObcIT/2L38VpJLmQVrMkFP/ol7YwQ2X1
 wheHQUtqimAMxFYnt5yCd86tFCY3urfl15ywCoqfd97J+8w0i0xoPgH9Cn+Rcao4
 1ZRjwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2ksk9u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:34:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso3555915a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789407255; x=1790012055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mAmExiEFYvMr4IIfVNz2Xn7QP/vhDLVmiOYkI8LrhfE=;
 b=HEWavDUTcCORgJ3aHCp2yWwNq4ZPk0kwSXr47ORghcaWuw6uILNIbDQX14odIwQTqp
 B7Sqv3lnc3lPuHzSPHIMYuXrX7SFQKhwrpKvkWImMTO1UqcIfE1Evqv4kmiRCKTtn+ng
 6BX65GzTiUTpppuGnb0yOy4qaf1o+qNvUjQPX0bxTjLo5foggHcxVLZiyURiDRYgi94u
 iuBUBtFeXSMEqxGDtLDMbZ8G9Ioh3e2/0uf2Ajx6xMyAOx9XVh1eKE/g7875y40FwJME
 y4BOIFGkVckWeHz3TOt/VzPYcluVzYzU95UjHMAP9w/M8YHxY30uT/2DB7wYvru0fgcU
 +RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407255; x=1790012055;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mAmExiEFYvMr4IIfVNz2Xn7QP/vhDLVmiOYkI8LrhfE=;
 b=JuRWbIhCGBkaI7uwiPHJrEXmnkZVA9Sge8GjY+Z6wQDqYZaKAbGHrKiLMlsYM/skQc
 hXRQGHrlUvZCapzG22zBhykCfg855UAjdeQRRJemV/oabbQrQ2zlvx3gfB0+qTF3xMuG
 w+sI5KQdoTT4nhvYbA1EK7TRvLEC25RzY6EGF8+MwU5JDpWmWjF2y0XTwKT/DzQU57R5
 dbDKWbuV5Vb64ahtfvNRZKc+cT7dHKnAXMkloHnYm4kND/Uav/9oCURo8C56YQtFu0op
 nOBteKKNi7/U97mpVihZ8TwFpW5nfMpSRaVyTdrutCL8wOxxp7LFgaTfXEc27dM9WSme
 TCLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi5xsmqu3wpfcmZ6KgaT967QOxiHCdJ7dPaS9R9zBImgnFKif0hnY/ZKAoBj2Azt9ZKT3/BaH1viPu@nongnu.org
X-Gm-Message-State: AFuF++mIeMwXFfAwV1VI4DXtRpD/rLfrySQQEyKDUSIRb3IK1CXg1plU
 icZxFj+fxBVxIVubsvzOxEQbGTN+xkxlzS0nBSoMf7iwZrSs/6eDXo1dqRviFeC73vmD8w8pMz6
 bg9ExbHH3LNUx32+x1ce8IjLX7VvGTImDVzpVfsmaL1ltvj+pVNY9lTN8YA==
X-Gm-Gg: AYBFou3sNxtDsFD+N+2XUL69BanGs3yyuRuCshD+Hb9bmVEmSut/Uys1jdmOxwlap02
 SmOYLc9n5osQTzAOOvBc9maowoVjCt14/pbx0nF9FAlYreGaKOqwkfxSBc0KsV9fFs8wjirKFRJ
 7DytncZDAUHdNvKai411bYpR9eMmHoLXS0wKG9fnI2J89eUcy1ZBzkUKxGlLOrT3Ioem264rhiT
 iNugMHlxwRmPPWH2rsOQU54OgwDISx7SJJ1J/uORudsvaIUFc+WkzIZbQn0uMadx15wNVXeGrkL
 Pttj8iGuT979/p5sTxgF7zjVdSt1gUysM12QJhRHQfW7GNbZhIX+IdI5Qxd8FHfg4gS7fmJwIQc
 3hI3xCBnVvSGvGyd+WWhm0nQCU1abdn+QEEk0DW8TFUsAcL3ubKsO+Dnd5h8VMwW+5UfX
X-Received: by 2002:a17:90b:1642:b0:398:dc16:3c29 with SMTP id
 98e67ed59e1d1-39debf7a8e2mr7294244a91.7.1789407254867; 
 Mon, 14 Sep 2026 10:34:14 -0700 (PDT)
X-Received: by 2002:a17:90b:1642:b0:398:dc16:3c29 with SMTP id
 98e67ed59e1d1-39debf7a8e2mr7294182a91.7.1789407254347; 
 Mon, 14 Sep 2026 10:34:14 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bc03ac1ecsm14426078eec.10.2026.09.14.10.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 10:34:13 -0700 (PDT)
Message-ID: <a6315b60-7487-4a41-b01c-6640ff87ea9e@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:34:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <ccd9e4ad-2469-46f7-b60e-01c21fa99953@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ccd9e4ad-2469-46f7-b60e-01c21fa99953@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gYJaZzmwNBbd4YJvai4faTOVNmYsyRuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0OSBTYWx0ZWRfX3gZvM5cu9eqe
 fzeB4x2/i5U4gBk85ShyknfWOJp9E5bgO1WIRAykXm6RiTM5MCQVMEU8LhQF6CVuFSYMshBJ6vI
 GdfF5ZpP9hgiGxSq89JqGzYzzafR8E4+zC9QNbkaNz8m6hZxIaMFMDZtNxcQMQF+x6RwvyQU/PJ
 oTPk+nGEvlNqoqLwloBwyr3Mlx3fAR4tNYCSgPbvg2iYrCZ1j7GoUP5f/qoMIaExB1WJKQGGNKm
 EoPeNV9LBiOcpUYv5gLr/Kiyu7OkUYCuYVnwLw43Yv5bGTw+cy3yw6UX5oI2hNgvXUFhUKg0adQ
 MrNjEQro1viMYxdrYstqxvwfWWEVZPG6PVTwvLEbiMptZ8TnsocaNqYXnrVG5En54xKt2XPEhMQ
 YQoE89FJO0kGFKqYfVciOe/qKOM/CsVlx9bYSVkXGNGMu7m2IgnhR21Fe5A2AffbdbHuTsPDpWb
 uFpSrreiaMF4cRbWdvQ==
X-Proofpoint-GUID: gYJaZzmwNBbd4YJvai4faTOVNmYsyRuo
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa83017 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Z0KqDakv1EUQvxTMeEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0OSBTYWx0ZWRfX/DPfVz4v2H+R
 wslJ6B5uvcNiQVkyBLmjsSrqNM2E/zcfLTqIboAEu4XgWgATv11irAwl5ML7e0Wd9e8hHJEigHu
 eoNB5kngC4JQRZkL5jh91HhU3cHtsN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140249
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

On 9/14/2026 10:16 AM, Pierrick Bouvier wrote:
> On 9/14/2026 9:57 AM, Paolo Bonzini wrote:
>> On Mon, Sep 14, 2026 at 6:13 PM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> There might be some confusion with what the series introduced. To make
>>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>>
>>> Each tests/tcg/arch declares which container it depends on, and we have
>>> tests/tcg/meson.build that automatically builds it if needed for tests.
>>> Reverting that will not be very easy to be honest, as it's a core part
>>> of the new logic.
>>
>> If it is core, why is it patches 102...105?
>>
> 
> The container build logic is introduced in patch 28.
> Then, in review, it was asked to honor existing configure options, thus
> they were added on top. Same for cross cflags. (patches 100-101).
> 
>>>  > IMHO it would be nice to replace tests/docker/Makefile.include with
>>>> a meson.build too. Yes, that would make it rely on a configured
>>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>>> stuff into meson natively.
>>>
>>> That's easy, and would allow us to get rid of
>>> tests/docker/Makefile.include completely, by adding matching targets
>>> make container-image-debian-*. Also, we can have a top target
>>> 'container-images'. With this, people can build them with ninja or make.
>>>
>>> As Daniel mentioned, the trade off is to run configure first, and I feel
>>> it's quite acceptable. What do you think Paolo?
>>
>> The problem is that right now firmware builds are broken, because all
>> the supporting code in configure was removed. I'll review anything
>> that fixes it, even moving firmware builds to meson custom_targets
>> even though it seems quite intrusive.
>>
> 
> roms/Makefile find cross compilers by itself without relying on
> config-host.mak.
> If my analysis is correct, the only components that need to be fixed
> are: pc-bios/vof, pc-bios/s390x, and pc-bios/optionrom.
> 
> If it works for you, I can replicate roms/Makefile logic for cross
> compilers directly for those components, which would remove the need to
> reintroduce anything on configure side.
> 
> By the way, why do those pc-bios components have not been added to roms
> like the rest?
>

If we go this way, I won't replicate all the cross containers logic for
those pc-bios. We don't need this for roms/* and it does not seem to be
a problem.

I can also just revert the patch as you asked first to quickly unlock
things, and discuss further if we should move those firmwares to roms/.
 >> Paolo
>>
> 
> Regards,
> Pierrick


