Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B17D3A66D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oU6-0006UP-3x; Tue, 29 Oct 2024 11:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5oTy-0006TC-LP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:50:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5oTv-0004Fx-IC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:50:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so32729415ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730217006; x=1730821806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IIyfpaAlcP/8/dG+hj3vP/WkWeV+zJOT0Dr2xeLMIdY=;
 b=bEkahMEXP4aE4/2heU1Wg5GAKMDSCJnbN0tBBoLfTFmJ8oam3IBVKE7s8ZJ4aWr6l9
 bJWz5KnoAu9ps3ri+vyfYXvgnPwG3lfhLwvgx7nEfscUSfMmZclwKL1gFG3JViNzjxHJ
 bsRq8igIH22AjO5mPNzrkLV4uiFAmgoyDo6OqIdK/sAQCmcoqrRmRq49902pgBWZ9KGJ
 BZJOVTYB8DPURuoz3lsLpIb7CaMC7LvYXVskiB6KxDFXT5CBggTn3GC36AZIdhL8eT2h
 pDZsSWN7H0o2edYe4QskEIivED9o4A8KV/WpcJg1lEM8ZF6se/1giuV0zUQgI+daOrHk
 N3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730217006; x=1730821806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IIyfpaAlcP/8/dG+hj3vP/WkWeV+zJOT0Dr2xeLMIdY=;
 b=v7+MY89v23CPeUcxa2Bvlwt1KO2zOj4CFLGGkOWyk0GyyIg97nlytFevVDjqjT7+Vk
 MwlYYymCjQ2qqPBrf/Fs69IUO1INg/kWUM9NpFDHVX8WwkmSukYrP8BpE8Rp/ElJiiHQ
 RGrAZhsiYxNs8zvLGAlwU3Q/SX3xmtRRZVj1w7sOES+Y0wfpwiYekdBx1vc8Q0CQcp3h
 rXxgOt6imW3RZQ36Ix24mPe8pCHVwOJyXPchvX8KYqIaLz20HydLVMYwNn0PCRjVf2Zt
 3Z7EmyzVNo2whagJarGhlRxum9o5X5mb7BbXNjM2jr+d6ouPoYBcOIfOMFmskhM29ziq
 Fpmw==
X-Gm-Message-State: AOJu0YyyBRlLH4qCFzMtS6N0ud9jigPIGvlioWL0/E9W7ymO2NxYEHta
 1eWiVZvONRiDpDsbe7Imk9qZrus7mWJBU3CBEMCWsALFmQn0/WuwVXQFXUXj3s4=
X-Google-Smtp-Source: AGHT+IEq1uyvd2bOd8ey2JGSiEBSRzmrkU5tISuYdlbgvQ8V/Z0neE9vEM17G+dYHxyQQ9guVzfQMg==
X-Received: by 2002:a17:902:dac6:b0:20c:6bff:fcb1 with SMTP id
 d9443c01a7336-210ed3b249fmr39179185ad.1.1730217005920; 
 Tue, 29 Oct 2024 08:50:05 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf441b1sm67422455ad.50.2024.10.29.08.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:50:05 -0700 (PDT)
Message-ID: <8f249581-59dd-4d2e-9b4b-fb4af082d2ad@linaro.org>
Date: Tue, 29 Oct 2024 08:50:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Christophe Lyon <christophe.lyon@linaro.org>
References: <20241018130852.931509-1-peter.maydell@linaro.org>
 <153648b2-1978-45ca-9731-b922da98d81d@linaro.org>
 <CAFEAcA-s4uji7rufaE394=kWMxEtWA3+XQMozfjx0uHscpnO5Q@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-s4uji7rufaE394=kWMxEtWA3+XQMozfjx0uHscpnO5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/29/24 03:04, Peter Maydell wrote:
> On Mon, 28 Oct 2024 at 19:43, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 10/18/24 06:08, Peter Maydell wrote:
>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
>>> must be parsed with shlex.split().  Otherwise the script will fail if
>>> the build directory has a character like "~" in it.
>>>
>>> Note: this fix cannot be backported directly to any stable branch
>>> that doesn't require Meson version 1.4.0 or better; otherwise it will
>>> work OK on Linux but will break on Windows hosts.
>>>
>>> (Unfortunately, Meson prior to version 1.4.0 was inconsistent between
>>> host OSes about how it quoted arguments, and used a different quoting
>>> process on Windows hosts.  Our current git trunk already requires
>>> 1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
>>> the stable branches are still on older Meson.)
>>>
>>> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
>>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> [PMM: Updated commit message to give all the detail about the
>>> Meson version compability requirements.]
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> This is essentially back to version 1 of Akihiko's patch, now we
>>> have a new enough Meson; I just updated the commit message.
>>>    https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/
>>> (I have dropped the various reviewed-by and tested-by headers because
>>> I figured the passage of time was enough to make them moot.)
>>>
>>>    scripts/symlink-install-tree.py | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
>>> index 8ed97e3c943..b72563895c5 100644
>>> --- a/scripts/symlink-install-tree.py
>>> +++ b/scripts/symlink-install-tree.py
>>> @@ -4,6 +4,7 @@
>>>    import errno
>>>    import json
>>>    import os
>>> +import shlex
>>>    import subprocess
>>>    import sys
>>>
>>> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>>>        return str(PurePath(d1, *PurePath(d2).parts[1:]))
>>>
>>>    introspect = os.environ.get('MESONINTROSPECT')
>>> -out = subprocess.run([*introspect.split(' '), '--installed'],
>>> +out = subprocess.run([*shlex.split(introspect), '--installed'],
>>>                         stdout=subprocess.PIPE, check=True).stdout
>>>    for source, dest in json.loads(out).items():
>>>        bundle_dest = destdir_join('qemu-bundle', dest)
>>
>> Hi,
>>
>> would that be possible to pull this patch please?
>> It's currently blocking the devs who reported it initially.
> 
> Yes, I'll put it in my upcoming pullreq.
> 
> thanks
> -- PMM

Thanks a lot Peter :).

