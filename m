Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A798C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMDU-00051E-Su; Thu, 02 Jul 2026 14:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfMDT-00050s-DN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:32:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfMDR-0002xS-Hl
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:32:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662E3K25514999
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 18:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IiU/adXUZ5A9dw/LaxYOxZ1OdnodgJu/dYuVzZI+PB8=; b=IkVj4Hmi89sYgkQ+
 rI4d4CMTQcP8GI9TUukz7cQ1b85BjG9Y1rjTsWvU3umF/U2sEdCKqP4GPY5e8kvD
 rxQ4wNFo/3A048yH7G48leKwp+6PG4KRO4IoC29UZKl+u+9vAwR+pBcxYXjewiDo
 lgwLXkgus9vQV13fHVXGHVMmnK7s39XzqVbP7gO/Tbj/BNDw2P2dGmcIcv6F71UP
 WoKJmCiMPAS14MA6W7BXcLtQ88lSPg1rsPs4Ix9oxLdRjkdC1/i89r3bvPTD3y8a
 2PIEdvSnrPJMfTAHNZilH9z0CFOCAb1v7bnd1eV/f8I//9amg3q9F4u8s+qG8YOE
 Kjw8TA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npra8bv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 18:32:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8895156101so2585967a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783017166; x=1783621966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IiU/adXUZ5A9dw/LaxYOxZ1OdnodgJu/dYuVzZI+PB8=;
 b=d1QFAKkTFeM9h+kw/DBiTOVI0Cjmk1c66H3gVYa2CzWo0PiCioMC5xrMlXmLq0uW2l
 z5NPxM2V9aX91Skb5HO5V3xdxlGkoJmq/n2smTCs/x1gVMJnDBcRmSnaLabtQtVZd/5+
 ImMtygrlQqKZY1AtK6CW8qmaRJTOfkC84kZKri/QgwL93TZzZYCTp97EYbZOh0j8cGj4
 o49Ld74WCGsF1CwB6FuWbb/KQWtP+0yEuVPJX3ZDo58Y8lA/ScKh9FYha4YLqE9vXC6w
 BUe6zs9fvE/ihfhDYPRcMjKa20smQIfrA+fcchLGjwwd08X8/WgpWFi/6o2cfo2b1zL2
 ncaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017166; x=1783621966;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IiU/adXUZ5A9dw/LaxYOxZ1OdnodgJu/dYuVzZI+PB8=;
 b=Sw2rEZXLPGoXknVia2uK1HqYPZir4VVYxK3UEWILEbt3VkROPUDWz+Dl4J3OSqc6aR
 9sQnzTnB9NBQSv9OfgZsHlcacW1qNjNf0a6dqAoWaMCIGOIrR8u12pyYHsKjCunCSbrD
 107T/73s6py2HEaKHBR+oaY2dCsEyoahb3c1WH1IOKTSNYzBoKxFTuJAuY4tegsDtWMb
 NwX12d5ZyHymTgLcpYuD6lwCd1JLETsKaj+8AboHqx1ytcONBVAmRoBXxcRkQ877iP1v
 xfGhBrzZkeHSiwl/Fs4YFnvjse9ElSS4e50Ge6T2mRM4bZdq0XPOPtzaISG4Hmg9INLN
 mBRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9T5iBC/xonBjm1XebFWCBZk5hEDaeX2vk0ECjZPh4vaIvztsFM+kQrA8Ab4X6cPIcoyGwSPq1LN0nv@nongnu.org
X-Gm-Message-State: AOJu0YxIAK12bk2BYb33gHy64p9RXAcIvV2RJAjnXdypUr1EDOZEFYKg
 Mi6JvpYDuuuHeh32Ry2mf3FhgN7dkee9Iq/BFIjhOGx+15uZ87hppvEMeYlaNEpbyQjgAm7esvU
 Is2AQCZbXjo/PRB6KyOLse5aEt2E41x1kNfJXhs3wtdnuvuuaRzhpmR362Q==
X-Gm-Gg: AfdE7cnTDx5IIVzeh57BtVpFiTiSrENsCz3bdiO7PnckPrF/9VkFiNf1lzNwoyaRx0U
 51LxPgD3HHT8/Il5RQJkEVWE9jPdXQM8d/fVuaZEbEJJk8rvrwZwhAG7+oMeNXMc5k8qh9jx0KZ
 +sMZSaxYVH2Rz18gRhtceKa5qt4XeSf6W0EMWZ1R/yDQEjnRS7c39PHvr/1rAzG1aAkeaeV51Lf
 pG75xw9hucKTTMCkizzsfLWjl+59r6sUz/Ub7T+Umae5JvjxbE0bcmExuypEPB0LwvVSN2Ods9g
 Y6iLaQyuTg2q2DE5lFDS9qcnXnfYs3Y3fUD14WPZQO9mDavWnMDEsjI0hHEwZZDC0oHLidF3hHp
 Dezy9MgjyLMjH9v6McXQZJYCRsSrBUMD1KwRZ8Fyqp0Aq/M2qp6qHag3beIIbuFLovwKLf+98dV
 aBOuE=
X-Received: by 2002:a05:6a21:4ccb:b0:3bf:6c08:fb87 with SMTP id
 adf61e73a8af0-3bfed4b6f8fmr8687520637.55.1783017165941; 
 Thu, 02 Jul 2026 11:32:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ccb:b0:3bf:6c08:fb87 with SMTP id
 adf61e73a8af0-3bfed4b6f8fmr8687470637.55.1783017165424; 
 Thu, 02 Jul 2026 11:32:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm10597096c88.4.2026.07.02.11.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:32:44 -0700 (PDT)
Message-ID: <db0e39ba-ccc1-4e17-8456-c21d3843788c@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 11:32:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <20260629160217.1637276-1-functioner@sjtu.edu.cn>
 <42297965-3d92-4d9d-ad6f-4861841d4806@oss.qualcomm.com>
 <faad8fd9-5fa8-4ae8-8437-28864543e34e@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <faad8fd9-5fa8-4ae8-8437-28864543e34e@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DZlYDhydT_W55C--ark09Vnw7plVSL8C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5NCBTYWx0ZWRfX07WTJqhEVWP7
 Zoer/DaiCqDVavfE/vdHY4hjIAZXT6UM+Z4ERVb6HQr9Wyl/OcVYd6w9t+3im6SWIDhO3jMKPmK
 6uQi43Xe7RAXgJkxfNAw9t8B9mshzJs=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a46aece cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=9rKaqBXaalEQfT-SZYsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: DZlYDhydT_W55C--ark09Vnw7plVSL8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5NCBTYWx0ZWRfX9NYe5gsqW+ZU
 qLH4qoCIjjxboDJv1tNu7HyAxmIrGDfPaOq18X82Oix28DJyr7Zy7cmes6uwPnXRcJkifU5jfHa
 B8y8IzTvalN1Zcyiv8d57iMaxalY2xCf1tRrK5WudZs/euv6G9a9HOwGl5D9QJu0Hl4DTle+O06
 LAs077Rl9u1e/AS9KXfNu9yC+11QqVip7O6wjYLMyTCNOS49mGRLwDLmOi1RAOZm/N4z+CUGnFj
 h6xdG0NI3Ou+7QqGmA8sTkdXoU0nlibl54tQuwswclvW6erhYVp05mzyMeAOH/xYqb19/6rCbXC
 7b2mEZfvtwQ4GZWdn/9LCLyS5PtfB0tFrlGFY2oBr+NjruXUMWO19fxaCtTe+nE5qCatn0swIOi
 FVi5BsVGA6mcw4qCl1DjJYodv2V5t++V7NouXpEjOefKo9Lonzk7Bdw2MuQE41+IJKORqtoWDSw
 l8qFkE1dOje6oFD7y3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020194
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

On 6/30/2026 6:48 PM, Ziyang Zhang wrote:
> Hi Pierrick,
> 
> Thanks for the review, and for thinking about the end-user experience.
> 
> On Tue, 30 Jun 2026 12:34:59 -0700, Pierrick Bouvier wrote:
>> Thanks for publishing it.
>>
>> A few ideas to make Lorelei even more easy to use:
>>
>> Would that be possible to add binary artifacts to the existing 1.0.0
>> Lorelei release?
>> Ideally, it should provide a toolchain (for x64 hosts) with support for
>> x64, arm64 and riscv64 guest thunks.
>>
>> Also, would that possible to provide a script to generate boilerplate
>> for thunks, and extract list of symbols from a given library?
>>
>> My ultimate goal would be to have something as simple as:
>> $ wget toolchain.hostx64.tar.gz
>>
>> # automatically generate boilerplate + compile guest/host thunks
>> $ toolchain.hostx64/bin/generate-thunks \
>>    --arch arm64 --library /usr/lib/libfoo.so \
>>    --header /usr/include/foo.h --out thunks_arm64
>>
>> $ aarch64-linux-gnu-gcc main.c -lfoo
>> $ env LD_LIBRARY_PATH=./thunks_arm64 \
>>    qemu-arm64 ./a.out -plugin contrib/plugins/liblorelei.so
>>
>> I understand it asks for more, but we really need to make lorelei as
>> simple to use as possible, without pushing the internal details to users.
>>
>> What do you think about this?
> 
> 
> Prebuilt toolchain / instant acceleration
> 
> Agreed: the goal is to install it and feel the speedup right away,
> with no build step. I'll do this, but as a point release on top of
> 1.0.0.0 rather than in the initial tag, so it lands as its own
> increment. The model is FEX's FEXFetchRootFS: a prebuilt host
> toolchain plus ready-made thunks, so a user goes from download
> straight to an accelerated guest. Like FEXFetchRootFS, the tool will
> likely have the user pick their distribution and version, because a
> thunk is bound to a specific library build: the exported symbols, and
> sometimes the ABI, differ across distros and releases, so the prebuilt
> thunks must match the host's real libraries.
> 
> Generating thunks for a new library
> 
> One caveat on the generate-thunks sketch. Lorelei guarantees that
> thunk *generation* is automatic and reproducible: once a library is
> described, TLC deterministically emits both sides, including the
> callback and variadic cases. What it cannot do on its own is
> *describe* the library, that is, pick the symbols you need and write
> descriptors for the ones that do not marshal trivially (callbacks by
> pointer, ownership crossing the boundary). Those stay judgment calls
> that need a human, or an AI, in the loop.
> 
> So adding a new library is not one fully automatic command. What
> Lorelei does is drastically cut the effort versus hand-writing every
> thunk the way Box64 does: the generate-thunks helper automates what
> is automatable (symbol extraction, boilerplate, building both sides),
> so simple libraries are close to one-shot and harder ones start from
> a skeleton rather than a blank file.
> 
> Plugin name
> 
> I would rather keep "dlcall" than rename it to "lorelei". The plugin
> defines a general interface (the magic-syscall dlopen/dlsym/invoke
> ABI), and Lorelei is only one userspace implementation of it now:
> 
>   - "dlcall" says what the plugin does and is understood without
>     leaving the tree. "lorelei" names an external project and says
>     nothing about the mechanism.
>   - An in-tree interface should not be tied to the branding or
>     lifetime of an out-of-tree project. If Lorelei is renamed,
>     forked, or joined by other toolchains, the name becomes
>     misleading.
>   - Naming it after one implementation implies it is the blessed one
>     and discourages alternatives. A generic name keeps QEMU neutral.
>   - It also matches how the other contrib plugins are named, by
>     functionality (lockstep, cache, ...).
>

I agree with your arguments, let's keep this name then.

> I do agree Lorelei should be discoverable from the tree, so I'll add
> docs to docs/about/emulation.rst that introduce the dlcall interface
> and point at Lorelei as a ready-to-use implementation, with a minimal
> example and without the internal details.
> 
> Does that sound reasonable?
>

Yes sounds good to me!

> Thanks,
> Ziyang Zhang
> 
> 

Thanks,
Pierrick

