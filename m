Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64BCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEqWX-0008Uw-18; Thu, 08 Oct 2026 11:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEqWV-0008UR-RR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 11:59:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEqWT-0003CL-KM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 11:59:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVWMZ070500
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 15:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LJKWCwj2Cjhss1wxdbYOVWFcTLGM9gKeaGl9Inqx3GQ=; b=FEw6NgMVUP4QRGN2
 yqNBnGkRFOXV+fJhx6IZtl+Meu6aK+SnHsZoejYrQs27PmJp6sWJ6DAKFMrnD9q2
 hssukO5OEa5wGSlGCQocc7KIX7gH7kMO9R1nJuFxScgO27wB2D2kyETOjIxBlblK
 9e6XbJeDJ6kzE4PbKLCeJ9wEEi4WFrYdCVTJ7WlJpVnJCU+X2Qgv5loQRnt7odeu
 JfFu01wDwJs1LYZvyAxTjXEm80+g60/oUZPJoTNKvGcPNoQ+1lYQFsxCDuyGElXI
 s9rnEzO83QhrQPnhtbZU1QFg7ZhWDE5LklFSqgq2ePy4bIQsUwmNKtwKGvp++AGm
 PFTboA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sgb750-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 15:59:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso10247892eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791475147; x=1792079947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LJKWCwj2Cjhss1wxdbYOVWFcTLGM9gKeaGl9Inqx3GQ=;
 b=UBq5pias9u4FYDohQ4gO/YIFeP160ArOqGmIfxOPJR2X+mUtiX0eOkEw9+L5Bz6Z2j
 fbWgBvWk6tVDbqazB2aNoRsbLoxqrjHsH4V0ZCBUA707q+yT9oUNLZvELzzD6NBPfYOj
 JFv5Kzp58JSU3wL9X2FOu0r7CumVFmwRQ9FufdErMtcSqWVhshKrNQMit1EvS9A6WrFf
 3ZRW6klJ5PbAVyj7FgoNyLMARqPwNyJKapPigkpy+nhGAYDH7DcNGDcaCJFVrPt14tji
 MEqWrg1wo4OhVCry2njd74H7SwhTbO/vPN+AIzEYO7mBKWTKVnLYOQvKeUYeD/FnBaSn
 7I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475147; x=1792079947;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LJKWCwj2Cjhss1wxdbYOVWFcTLGM9gKeaGl9Inqx3GQ=;
 b=wtF1WBkf/dMmGUG9WzhxkloRWUH6FdEAYm0CFgrcpSPIyFl4J8ARpjx98wNmfF0bed
 L1dSQDBsidbtXeM3Zh9jcKlQNHN0NGeddPQK8Vbi5PS3wvxhNnD3yKXOlpxo6clKt2Xr
 XyjzrcHqbxn1TlV8gbX0b+CITlMxyBEyhKscvDekYIJPYk6xPRHpL2rrxEM+FSN9n8Kd
 8e0i1ye6W5hvbUrRL1U1nh4VIs3QYnV0lE2L7tx6Py3tTwWkiv5t03DCRWrliQGLuQIE
 /nkdwBSJAePJfreqv1Zq0u9tHB5d850+3OK9odas5B38ssmO2zkxlFYIM/TTO33ZG09u
 JBRw==
X-Gm-Message-State: AFq9FYJMP5e2uSU3awSWmv2jVYzYq5BQrYv/jzYXFXnrkiCEUjN1kE4r
 oMgNd8z0mimx2RtjuQqwpKMWW6eh0Ow+PdYUK2zzgjSh5u1ZGzCJ99F+iQFpRByZtaQc8pTvvaj
 U6qUFyVB+QfkDyOup51th4/CZ3eCkfXwF4XB2276qpcL9vZmIuFG38Q/xtw==
X-Gm-Gg: AYBFou0yDDVovye+zzGPKivP34pylpE7mFs305J7bEltgLIF/MVKFuS5iJw3OUYGaNL
 n8qmngDR/HEvIq9xl5osgGEps5aCZU5dP9pJOzJeaHHFtc6RHeaL86pRdyn3muPJ4nd2vCFfgpP
 4mhXm2LvZPtKc1G7/cpSE3NZVdWULXz+UVbltjdH2GJl0Q6eVfxMboc9Em95yyX3tWM6GTt+U9i
 vDHcIY0ax93N4P285hVu0Z4U2bWKD/j1q5X/ep+hnGmNzETGu8yoOdPFLhHPLQ8kcxZe7+N3Dp7
 Sib0Cs4IskH7FwP7bewvceGLvUWc0uFim5VP0zIqkZ61b03apFazwL4EWSad9S7Zlckf0A0l5P3
 FBgOCygjSjS1HtW3Bvt09nrJj8R9UBRO8gsUQKMF9FFzPbFRtFDDgx4nfk/kJkVAkxUX4Ag==
X-Received: by 2002:a05:7301:3d0e:b0:351:5112:ec4b with SMTP id
 5a478bee46e88-3515da5dc10mr6655964eec.2.1791475141974; 
 Thu, 08 Oct 2026 08:59:01 -0700 (PDT)
X-Received: by 2002:a05:7301:3d0e:b0:351:5112:ec4b with SMTP id
 5a478bee46e88-3515da5dc10mr6655905eec.2.1791475141191; 
 Thu, 08 Oct 2026 08:59:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af90521sm29050543eec.19.2026.10.08.08.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 08:59:00 -0700 (PDT)
Message-ID: <34ad2c3e-fa4b-47dc-a81e-38c7f561d2e9@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 08:58:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
 <CAE2XoE-qDvOUG2+1yTTvBUyBLxoxCPPy464KQVLgSFx+tuQ2XQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-qDvOUG2+1yTTvBUyBLxoxCPPy464KQVLgSFx+tuQ2XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pxP4-c4KhmITIFGnLdSPr9hDyl72Lk_4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MyBTYWx0ZWRfX1yBGLClTsyZ2
 13NGZ5LY+SoPZrpe5TXXAspNKwes9Dn2zFIuKcjUe8k4gptFiVlao4xJja7XjeoLE8aW1lyxgix
 hkEVQb0RFvdHDGkKAUzCKKeaRyY5+6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MyBTYWx0ZWRfX5D9l6Yq/XfpH
 ESLO/0oaojTYv7ZFPjFwDK6s6ooZsRPvXvVBVB5J/7e4QeMonfH/Q+waqtFJIcNIDSwanQ7cPOx
 jhp4cCbbheHP+zbig9K1YN6KBU7gkBvEvGxsHQQlkUDbPsDhsdUoTk6QBrhyBHZjciTdxmBwJR5
 4Z6toYK2sW+p8HIBUyYa/SVrhun0l9vs1Esas9ZDW0TBo+g2LCtBEtYxZlh5Ekzrxo08gjM2Rj2
 a8lq3lIJ+QHDn87Ct3SMv1oFU5cOWSYqPIh37tIJbnKZ5MzxJ6ZYHlvJqhYXb72/MuMtGE+tyv5
 KVlONe/o33vp8iOoazHgLWVIKfzYFwS+TyF8g6YmuJU6JkWSzx+7ejbF37uYellle4dmSLCJy2h
 1Z9eb3yjFNSx23II6tNseNKFxdIEZvzWJykGKXjlFNYve/QC7JfoC7tJFFAbtkNgFyTRJQnK2ql
 fRMkU68lp+/MxWEk5fQ==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac7bdcb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=xOZJixWyuWTxZ7Atf4oA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: pxP4-c4KhmITIFGnLdSPr9hDyl72Lk_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/7/2026 7:08 PM, Yonggang Luo wrote:
>> So, based on all the previous conversations, we agreed to have a
>> qemu-system binary with all the QOM types available (for all targets).
>>
>> I personally think that if we go this way, we should not have any
>> -target option, and even less a -target none option.
>>
>> The current is_available() approach was made with filtering per target
>> in mind, which predates where things are now. So, it's a good time to
>> reevaluate how to do it.
>>
>> This leaves us with (at least) two options:
>> - keep the callback and add TargetInfo parameter (what is done here)
>> - remove is_available, and adopt a more declarative approach
>>
>> How about we (re)-explore the second one?
> 
> Indeed, I am doing
> 
> - preserve is_available(TargetInfo*), and adopt a more declarative approach
> 
> /* Generated by scripts/gen-target-info.py. Do not edit. */
> 

...

>     {
>         .name = TYPE_TARGET_BASE_ARM_MACHINE,
>         .parent = TYPE_MACHINE,
>         .abstract = true,
>         .is_available = target_is_base_arm,
>     },

>     {
>         .name = TYPE_TARGET_AARCH64_MACHINE,
>         .parent = TYPE_TARGET_BASE_ARM_MACHINE,
>         .abstract = true,
>         .is_available = target_is_aarch64,
>     },
>     {
>         .name = TYPE_TARGET_ARM_MACHINE,
>         .parent = TYPE_TARGET_BASE_ARM_MACHINE,
>         .abstract = true,
>         .is_available = target_is_arm,
>     },

...

> Other than these base machines, other machines are children of these
> base machines.
> 
> See these changes
> https://gitlab.com/lygstate-qemu/qemu/-/commit/c71da20c2483cdf577fd2a5548a80ca1e5099676
> https://gitlab.com/lygstate-qemu/qemu/-/commit/252b8763fd74ec57f5762bf9c57e19d8d9e5a146
> https://gitlab.com/lygstate-qemu/qemu/-/commit/252b8763fd74ec57f5762bf9c57e19d8d9e5a146
> https://gitlab.com/lygstate-qemu/qemu/-/commit/252b8763fd74ec57f5762bf9c57e19d8d9e5a146
> For ARM:
> https://gitlab.com/lygstate-qemu/qemu/-/commit/c42d5eb333fd3a7cab899c8df95375dfc79aba40
> 
> These base machine type is auto-generated in this MR.
> You can see at the branch
> https://gitlab.com/lygstate-qemu/qemu/-/commits/single-binary-arm-riscv?ref_type=heads
> 
> And the inherit is done by commits
> qom: inherit is_available and filter after MODULE_INIT_QOM:
> https://gitlab.com/lygstate-qemu/qemu/-/commit/cb66474a36e03b4353c2f525ce7821f2af779ea1
> qom: register late types through module_call_init_fn:
> https://gitlab.com/lygstate-qemu/qemu/-/commit/ba6a3d3fb6e4bfe35d88d3845abf7b0ec8fbc337
> module: add before/after hooks and module_call_init_fn:
> https://gitlab.com/lygstate-qemu/qemu/-/commit/86c635f45e283b6d0f714a1a3a9d9521b17d5152
> 
> And the gitlab-ci is already passed
> 
>

The hierarchy based approach (we considered that also at the time) has a
big caveat: a QOM type can only have one parent. There is no multi
inheritance in our model.

You can easily merge arm and aarch64 under a base_arm parent. However,
you can't express:
- this machine is available for target X and Y (x-remote, nitro, null)

That's why we chose interfaces based tagging 1.5 years ago, because they
allow multi inheritance in some ways.

>>
>> It's what we did in the past
>> (https://gitlab.com/qemu-project/qemu/-/commit/5de9216064d32eaac125dac4de1878486c16d73e),
> 
> Somewhat alike except I do not introduce many interface types. Just
> base machine types.
> 
>> and that I removed recently, in favor of is_available.
>> My rationale was that it was incomplete, since we needed to filter types
>> per config also, and not only target.
>> Now that direction is to not filter anything, filter per config is
>> unneeded, and switching back to declarative instead of callback makes
>> total sense. Using interfaces like we did has its own issues, and I
>> would not like to see this coming back.
>>
>> I'll do one very concrete proposal:
>>
>> ```
>> How about letting machines (and machines only first), have a new field
>> 'targets', being a uint32_t mask with an array of EMU_TARGET?
>> machine->targets = EMU_TARGET_X | EMU_TARGET_Y;
>>

For now, it's the best I can think of. I tried having an array of
EMU_TARGET but declaring it was a verbose mess.
The arch mask, that you or Daniel sugggested at some point IIRC, is the
best compromise here: it's compact and readable.

> 
> From my experience at
> https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads
> this is not enough, we still needs is_avaible, because for those
> machines that binding to
> KVM/WHPX and other accels, we need to use target_kconfig to handle
> them. That's why I choose to use a unified
> is_avaible(TargetInfo*).
>

Given our base assumption to expose all types, why should we care about
kvm/whpx? If we don't have a proper message when user select a wrong
machine/cpu type, we can simply add one.

> This new field only works if is_availbe still be a member of TypeInfo.
> machine->targets are not generic. Indeed CPU and ACCEL(kvm/whpx/hyp)
> types also need filtering.
>

Yes, so CPU can have the same target field. Since we won't filter
devices, I don't see a need to have this in object.c. Also, it can
completely replace the existing is_available mechanic.

Also, in multi-target.c test, we can add a new test to ensure all
machines and all cpus that belongs to this binary have targets set.
This allows to leave the rest of architectures as they are for now, and
force to add this when we'll integrate them.

Regards,
Pierrick

