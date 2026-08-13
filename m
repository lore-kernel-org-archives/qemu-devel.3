Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC7C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXCb-0002S0-F3; Thu, 13 Aug 2026 11:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuXCa-0002Ro-I1
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:18:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuXCY-0002ml-Vh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:18:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DCL8oc1519926
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 15:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qJ/W7s1DPAFOm0Oqzh4dUbDsndEK2fV97t2G5BnY7XM=; b=XPL0y3VNKd20SZmB
 2nfTjGxtcATx4Rg/GvDxPrMVByJaebopvufV7G3nUlXq7RbEaKooAymvUCdOaThg
 uPLYKXg4Wwk9Razv0ITc4mJtegeT66eCoHjcC10EfUGCFZOA7D/F6KYHkbIQGKbv
 4UWHH+r1WcVLRLaJUyvu3/QC77CTxM9JGAmI1iU8ggDcfysF5jD9oDjgWzq+eDXf
 rKbKZayDRTVYEXihQHtBcOYcGx6Y+Ei/tOAG2yGJHXQh9Rhwj67GUo6vUd03K6Oh
 nvLM8ZMmvKUqWPKOG7NYJin2HDkTLbDWvpYgo0z6AUc4BioTJOLVw3ASW3ClJXnu
 d/zGlQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0xsk4ca7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 15:18:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c07f25de2so249071cf.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786634316; x=1787239116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qJ/W7s1DPAFOm0Oqzh4dUbDsndEK2fV97t2G5BnY7XM=;
 b=D1rZc87qFYj0GxpNux4lFEciKM5oMPWhrEh1+bfKt4oNE0Oaj+qlCmghx75QTslFhR
 E5b6E0w0S9rwQIGPhcUQh2PWxRSJe0wnhge3PGCqIw0Z7r2QJZpD+gx1q+FJ53A36TPS
 UfI1+aAyZs6rSFxTfWy5QuYwFm97N5IDvL44OcDOB5GkCbPOHa8SNOWX/h4FAOAaJEA4
 pIwVIPeuKzOtQwmWapb7AqadKZw20asRicQ27PDRPT9ammVJaphZs9L/SDrp3Uef73E7
 c5gLIdtHtfRBOJ+loGk2jrHRhkIlPmVfQv9wqyMduYAre0K9OHLkrZBT4NLMXABIAUvt
 p52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786634316; x=1787239116;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qJ/W7s1DPAFOm0Oqzh4dUbDsndEK2fV97t2G5BnY7XM=;
 b=l0FNHCNaBR1RsqwHfBK6tir8Hcr4FQJKcTGTF4InoVuYS0pgrO0tcg0NR9GyvdmUZz
 M96T49Jkb9HgA1VSLE7azR0GsbKFaIzlD7bNCW0RZTwsjV5a4m7HL6PdShMf9i9y0jvA
 DzNo2ddOahvoUikN1oiNloHOtKLnL5kSzEHwHl0ryoFg5d4ybL48P+nVN/Ar021dixqL
 7pfbFGP2VdgTnB4agMEY/ZXX2lrDaBA8GCkCtKZXMcMnHrLoMzZKyLkWvq6bYL/PRP99
 dsJn1Mp0XAvAcAeIhCcgCHoWP86CeRhPnizw1r61b9ZZ8sxdd/LoZGtvezxmKgN/0Ih0
 7D+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGgPbVmKNuq0KQcfdATtRt6NgOwPvxPt+ahDvxMuke7Fua7aC14vopOLRR3NATt+byliX2kEvLmgJ/@nongnu.org
X-Gm-Message-State: AOJu0Yw6HoVMYqtT4HdHyTDSyAy4Xn6EjKE4zNcsxCu6nlIYkpzaLKkL
 tSFypjbTkM6poWoXv6NPMbAIv3q6to+EUNE40F654giRzBtCORWrqxDSM4cw35b4ipidbNXbdJH
 MFXhhuGr/vKBl2JPQnQmCbW88jgi595f0BIccGLJ2hqdoDmc4t7mWuMV2QA==
X-Gm-Gg: AR+sD11R2NXW0O7TsgW3ixtrzs5bEdQYU2G75fJvi7Sy4HC0qCsaV6uV4KCEz0jp06b
 o+0fG8J7MMxvV6qgmdn1n8fVHQ5faKMtAn9FaMPtfDLo047npZkKGl/ctVMGDe0teSu0jK/aoJK
 kWDMj7GtM1X4JEiO3nkgEG9/Mo3Z7FsE7Une2wtJG0qyPGILfhB9eC00RKfcm4cN6675nA25hCs
 7m8s8S+yYihH1LCZ8KhfgzOrwQ8hswe+vvNy6op+x/ycZjNRFJUj03vl6/QbQWr2ssSx+1OQkCa
 Z+0lRu9Rvkyv1pH4IlwabnhBVSmrBIsvIV+X1ORIwdGGqSdTyKEYIw5Lm1/QDvJIDazv/bIieC8
 /TiRfW950feCj3Knn1jNMf5Gyx+eeJX/BaUs=
X-Received: by 2002:ac8:5711:0:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-52d73e41080mr58650171cf.40.1786634316238; 
 Thu, 13 Aug 2026 08:18:36 -0700 (PDT)
X-Received: by 2002:ac8:5711:0:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-52d73e41080mr58649521cf.40.1786634315739; 
 Thu, 13 Aug 2026 08:18:35 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21238443e1sm1411866b.58.2026.08.13.08.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 08:18:34 -0700 (PDT)
Message-ID: <d7b2fbf6-f9fa-4b39-8f40-95b7d5d0d8fb@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 17:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Next patches
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260812151444.2611689-1-peterx@redhat.com>
 <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org> <an26zg9zVW-JrV9f@x1.local>
 <an3JcZvNNS8o_UFg@x1.local> <f6f159d5-4740-49b6-949c-cdcb1ec3c71f@linaro.org>
 <e02f8fb8-3ee3-4471-9748-8a26b95134a7@oss.qualcomm.com>
 <an3dSch6yhK52d2X@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <an3dSch6yhK52d2X@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nKFmQt1VuQ7xmKulvFGQGy1Jx8iER5TQ
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a7de04c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=V1GM0Q2YnqM44Xxf4_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwOSBTYWx0ZWRfX+1T1fmQL4WDo
 e7u6Qg57f1ylomViCqvbrlcXZEYjD2erN/sx4+NEYpTHVYy8gIfGGtQPPHG068LhpLlAQAsRZLY
 ohzeeVT1aSwKpw8HMF+b5oxrFwcdIsM=
X-Proofpoint-ORIG-GUID: nKFmQt1VuQ7xmKulvFGQGy1Jx8iER5TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwOSBTYWx0ZWRfX1XUAaiGjOzXx
 PZ3lIJY2aVdRXgLHg39J1nyZUbA0D9OMjYxiQBMkp9Gp8Ll1EzBj9IS3qlxC6fA8wYZ4zEhRjeR
 uARIsboAiZAmRYf01w+90D0g6hFSRx2MTkVr6qIhJOygl5FXEgHTPZY/aUjpq25FxN//eJiYIx2
 QeyXZj4m+TVMDnquHnx4eiXGPQqGOgibQOLhGab18wwzVNlpEaau6/Kp7bjBaaLmGbyIP4E84F7
 KHLxKcEy75FkyELxPnQfZvQfUjp5Fr7enyHLoG90XIN84jmHys5Ap9nGMnqstCT2YSVtUlWTwbk
 Kre7H8ykD9bLr8VctoosX0YzSxtAJYB2p6lvREUE48Skpv+C9C0RxzM6lt3jxnFPHi9cyQq4g6K
 JP5TdZ1gdBqKTq67RHkyquY5SZhUI93/RQQCJRnGVa+gWLAp1cxoz5honA++XOVshF/i/5xGIpO
 Pi/FioLr/O5ArXA1s/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130109
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

On 13/8/26 17:05, Peter Xu wrote:
> On Thu, Aug 13, 2026 at 04:51:39PM +0200, Philippe Mathieu-Daudé wrote:
>> On 13/8/26 16:14, Richard Henderson wrote:
>>> On 8/13/26 06:41, Peter Xu wrote:
>>>> Now when I think about it from the root, I tend to like what Xen defines
>>>> with ram_addr_t:
>>>>
>>>> /* address in the RAM (different from a physical address) */
>>>> #if defined(CONFIG_XEN_BACKEND)
>>>> typedef uint64_t ram_addr_t;
>>>> #  define RAM_ADDR_MAX UINT64_MAX
>>>> #  define RAM_ADDR_FMT "%" PRIx64
>>>> #else
>>>> typedef uintptr_t ram_addr_t;
>>>> #  define RAM_ADDR_MAX UINTPTR_MAX
>>>> #  define RAM_ADDR_FMT "%" PRIxPTR
>>>> #endif
>>>>
>>>> I don't know how we supported 32bit host emulating anything larger, but
>>>> logically it's doable, then IIUC uintptr_t won't be enough allocating
>>>> anything >4G?
>>>
>>> ram_addr_t != hwaddr or vaddr -- it's just an internal token.
>>>
>>> So a 32-bit machine could put 1G of ram (identified by ram_addr_t) at 8G
>>> (hwaddr) just fine.  But obviously it couldn't put 8G of ram anywhere.
>>> :-)
> 
> Yep, I should have described it as allocating >4G in total, rather in one
> shot.  So it's about the address space we can allocate that is limited..
> 
>>>
>>> That said, Xen was weird in that it used to be possible to have an i386
>>> qemu command-line talking to a x86_64 dom0 kernel controlling x86_64
>>> guests.
>>>
>>> So, yeah, now we should drop this ram_addr_t distinction and always use
>>> uint64_t.
>>
>> 🩷🩷🩷 lovely 🩷🩷🩷
> 
> I can throw a patch, just to double check one last thing: we don't support
> any form of 32bit hosts anymore, am I right?

commit 372ec46b9f1215f48a4717f2b7ed969f65bfadc6
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Dec 18 09:56:27 2025 +1100

     meson: Reject 32-bit hosts

     32-bit hosts have been deprecated since 10.0.

diff --git a/docs/about/removed-features.rst 
b/docs/about/removed-features.rst

+32-bit host operating systems (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''


