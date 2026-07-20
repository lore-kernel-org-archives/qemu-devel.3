Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A533FC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlvTm-0002I6-Dk; Mon, 20 Jul 2026 17:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvTe-0002Fh-Rj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:24:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvTc-0003xH-1r
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:24:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTxuQ3368774
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j2+BIPfOpMQnPiqWstnwAPqopwffGmsDh3bGtfv5x4w=; b=FuOYWVov3JBe/c97
 2HOLkwkOoJY6UgGQiVFcwAxnxKYG4GeakE49526pik6QP8Wqm/jzpSbMdnT9rLNw
 gDXp9VMtsFOoJmx+JxfP2tIFcPvNNVIKEa4OpRtCA6E0/xjwcnC0NCrbO9lL0qWu
 zzmVg2PscGGKDfDKTZ7vUT87faAwKxz9OoMDOxuciQhX/cIfiHDsSl6h/oiHm20O
 Wikye7xLn63JSeO+E3oIiqVSl7Ho40K5FB74A2n3LHtdDqZUTvUuj+/BTMsmkcCr
 bvvYiZ4RiCs5BlWXolQSx9i9TGvtJkr9VINYp1FNmXU3Q23Ts0OuQCtRy2jeGeq0
 nNKYRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs033r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:24:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so253132121cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784582677; x=1785187477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2+BIPfOpMQnPiqWstnwAPqopwffGmsDh3bGtfv5x4w=;
 b=d6BLyyThJNRhiEa9nwMPd/FmO4mVfMyvqc9hDb9ImJ2eXd/Mo4shBXz6Dn3hydHDgW
 hufZeQpYbZmZVlPOjs3r54OEC4WVNSTa/ChwIKVssEIxxOrngVL6SviaI/K5qM8kr1fx
 2iwSYoQaX/fdNCtaEX5bDk5QVMRcAQA7K5RvziQJ0o+e++hBDizMh7pEFORVNOIXDiKF
 gEo1pcLYnqMdn3BfgaJGb2zc1tqWQsHORDGauY/GWxkbC6/jOlswajuOfd3kK2sb+NUH
 RfsXEh0hWK/J4Bzc6MxTnq9z/qRehMhKv2An6flSUPlm+bE68RLNFRRkCTD/exEMUVzI
 x7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784582677; x=1785187477;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2+BIPfOpMQnPiqWstnwAPqopwffGmsDh3bGtfv5x4w=;
 b=o5AmuYcLM7LHZg5vqtGfK4TYMBs9WtfACvPfxqfEN5feoAix5U8GzHK3hkb+iRpqDc
 qCu4Oy1XjoV6eCytueG/5Xtwo2J0DhTaSBZ/D8ouVLkBjHw4Ur8eHQyaOsG+ehHpuNQ6
 36XG5NCkzvuo3gnrJFaY1MYfqyeiEKH3EaVCJXyc+k8+lFkQ93NZICSSJA+T6qrqV1Sc
 Z+z/TY+89JUIuP8O/kbWXASjmpwmA1+R4qDmYlU89TMHUGyNGCM3dolbQ4azgdQ28uOE
 ynlZkIVnkRuPzQ4VcaBd5NPYYtHPmOzhGLXi3XedTKTN1js1SKUPX39UzwsNkIidndEk
 uMTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrydzz/G1WuK8YN0grLrMeuh9vJdTm9jvkbAGUED/8uQ6yjTSfaRurLuN+h9d9kwlcNjN13VoQRzNg5@nongnu.org
X-Gm-Message-State: AOJu0YzQgw1d67H8DrJiapm+Uz4xa9pJe487Qg8pN9ng5K9uD+al4F7t
 xtlmgHj1In5aEh+ZDSRsrpqLa+Bp+sPPxI9et7+MaNFejCHrltKMOrccKa4iQLqChIych9X7+Hn
 n2qwZq36sOFcHdOnO5nndYWMgp9fFhGyVAqb6COiUvtCuB6pR0Je/J9JsKQ==
X-Gm-Gg: AfdE7clHA1eEVLQt8GMhT2h0vi6tnUVQkBlueotB2kNxGldsxvv7iWelWecIth23AQG
 Bx1W6YIvtQlX7Q2PX+OdsSObScIxlt9tW7KqzIJK92M0rioEmry5wAKjEW8CafTR8T1Tzs0pt8Q
 PGKhwm7n4hu/FLlVRG78+RJX6RCPp32XjyQEdAaX6dqJOMx2/IXJcO9hAQmSlV0yGCYJ0ddFZjs
 sarBy4nf+9FxSZOoKEMuowZpVUGUphIc8BZlV3RGoU+4NlYr2MiLfU5y2DBYdTNvsdpYWJzLF8T
 QmQGGOPDuPwKELnRS+xxk0Pcay6wrBMdq4cxrAe4e9/92szA2zrN+jxiieKuSmJ4XOYm4gXQTjD
 ZhxPf+m5Dv179tu7TDRmdQzdplusWrKJGAeIyG/xhwS4z02XmI64=
X-Received: by 2002:ac8:7d0e:0:b0:51c:7b11:41a5 with SMTP id
 d75a77b69052e-5213f56e20fmr147679281cf.82.1784582676737; 
 Mon, 20 Jul 2026 14:24:36 -0700 (PDT)
X-Received: by 2002:ac8:7d0e:0:b0:51c:7b11:41a5 with SMTP id
 d75a77b69052e-5213f56e20fmr147678931cf.82.1784582676180; 
 Mon, 20 Jul 2026 14:24:36 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcd13sm32656583f8f.26.2026.07.20.14.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 14:24:35 -0700 (PDT)
Message-ID: <1d7b9883-5f12-4cc6-b379-ce13a1f1afcc@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 23:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
 <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
 <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
 <cfa19c77-6783-0870-a509-691f0539ff2a@eik.bme.hu>
 <e43b316e-e8ac-42ea-afec-c56d2f030819@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <e43b316e-e8ac-42ea-afec-c56d2f030819@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIzMiBTYWx0ZWRfX9oo9EPVXZbGs
 kuLYl8lmUd7pdpGq4C3cDQwa+bQF4V66YMKkjrxHjcr7HyK9dEenBsdkzNATGH0+uBotRfFGnG4
 q/YWhLXf851CjN/iet4rb9z1iXpgGaw=
X-Proofpoint-ORIG-GUID: E4SrrwsitfLBPpFCFdQGlZttn1B5FeL3
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e9215 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=g26msxm2AAAA:8 a=QxbLE5Ik5vzX3J06DfwA:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22
 a=kacYvNCVWA4VmyqE58fU:22 a=GGU-N_oZwHsPb1Xv_0el:22
X-Proofpoint-GUID: E4SrrwsitfLBPpFCFdQGlZttn1B5FeL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIzMiBTYWx0ZWRfX6rZKU3mNNHPj
 NxLAUiC/3J0y6+jTgimL995FjBKwyspdCcX4JIsMwumbVeb5kfY5fY8z8iU4SdWzyZWeV7sLwim
 s43mfYyhovFNbCbtmzy7QIEyiGL5G2knsBGXxXpRYqQ34vdoyI+KJp3WHR8S8wRdbMRK6eZ+fmq
 rQf1bShWzCVwuHOqPhzwPudB0L7nKImuYExmWSB3i0q7/t+MS+MikMBw+cIMFRsXCI+/n44fWdr
 SbbWC0A1B4ByAjpFYppt3rURhG36fAsZ7cbmbuhMt9BUjmInyQgP4TgT6eLF61wDAGrTMCcLwK/
 eDkkUJC4z4y5CMDglU8h9wmvKmUrD2G5rVa44erjZRIc+lBsjCY/0FHdI02jDDRZky7kJg98fcd
 FACi8D2s6Aa91sd2hGL8+tmNDJ5g1KwSQKsSeFSN+y96bm/06ekBa2gNEEhNU561zbiP/vR2ql7
 8uRTlE+3e0rMkbtdN3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200232
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/7/26 20:44, Pierrick Bouvier wrote:
> On 7/18/2026 4:51 AM, BALATON Zoltan wrote:
>> On Sat, 18 Jul 2026, Cédric Le Goater wrote:
>>> On 7/18/26 06:52, Pierrick Bouvier wrote:
>>>> On 7/17/2026 9:14 PM, Michael Tokarev wrote:
>>>>> On 7/17/26 22:40, Pierrick Bouvier wrote:
>>>>>
>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>>>>>> ref_type=heads#L5
>>>>>>
>>>>>> ```
>>>>>> config VFIO
>>>>>>        bool
>>>>>>        depends on LINUX
>>>>>> ```
>>>>>>
>>>>>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>>>>>> At least sparc64 to fix the current issue.
>>>>>
>>>>> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
>>>>> way we can do --disable-kvm and it will work.
>>>>>
>>>>
>>>> I think it's a safe choice, but not sure if we are supposed to be able
>>>> to use the exotic combination of vfio with tcg also. Maybe it doesn't
>>>> make any sense technically though, I don't know the arcane of vfio.
>>>
>>> VFIO works in some heterogeneous configurations, aarch64 TCG running
>>> on an x86 host for instance. The opposite doesn't. ppc64 TCG on an x86
>>> used to work. The limitations primarily stem from architectural
>>> differences in the host/guest memory mode, CPU/IOMMU address spaces,
>>> assumptions, etc.
>>>
>>>> @Cédric, Any idea of which matrix of host/target is supposed to be
>>>> supported?

 >>> With KVM, the supported architectures are x86, aarch64, s390x, ppc64.

>>>
>>> Overall, heterogeneous TCG configurations happen to work by accident.
>>> I would not consider them supported.
>>
>> VFIO (vfio-pci) works with PPC TCG and is used for passing through cards
>> including GPU to emulated AmigaNG machines (maybe also mac99).

So also Kconfig PPC (32-bit).

Can we assume the following is safe on 'LINUX && !KVM'?

   #include <linux/kvm.h>

> Please do
>> not break that. There are some quirks mostly with GPUs, see https://
>> qmiga.codeberg.page/qemu_vfio.html but it works and used by some people.
>>
> 
> 👍
> 
> In this case, and we want to ensure we don't break any existing workflow
> we might now be aware of, a safe choice could be to restrict VFIO to all
> hosts that supports KVM. This is different from CONFIG_KVM, which is
> only enabled for new hosts.
> 
> @Michael: You'll need to detect kvm hosts (see meson.build for
> kvm_targets), add a host config CONFIG_KVM_HOST, and use that for
> CONFIG_VFIO definition. This should restrict VFIO to host providing KVM,
> without limiting which target is ran.

For the 11.1 release I'd go with this 1-line fix:

  -         depends on LINUX
  +         depends on LINUX && (AARCH64 || I386 || PPC || S390X)

> 
>> Regards,
>> BALATON Zoltan
> 
> Regards,
> Pierrick
> 


