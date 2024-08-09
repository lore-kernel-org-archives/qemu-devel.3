Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B458C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scJGZ-0001D7-2U; Fri, 09 Aug 2024 02:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1scJGU-0001CH-MY
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:38:18 -0400
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1scJGS-000864-SG
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:38:18 -0400
Received: from [192.168.7.205] ([71.202.166.45]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4796cCfI1587367
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Thu, 8 Aug 2024 23:38:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4796cCfI1587367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024071601; t=1723185493;
 bh=gmy6wn7guUM68cWbSyFVbOpJAFyd806LQnbuzj5ZsAw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KnlW1wSlf0QlN/zZMuO0CXnolWdyxtXjVK8468a87tILla/6jI9GdksMLYT/CuDre
 jJNYN+/yDVIMeKFDH/XHbwNSPyFg7STGfpwbZA7equtqP4qo2KE475iUNZ2CpUVPC2
 oZFqWph7uzg6Jfc16+UHxPX3Ft2hvlQODLoqa3F/zlWxLo8ByEos0JNaYrj2wroISP
 /LbTgcaVBjQwKGbalNjXt/6fDl1dHw8SY6ejOQX5x8xW5sMCwNQ7x/cKTQid97Lop8
 0W2NRek/wQWjeyRauD4eFcxgpVec4/OB8wXhQ/pD96jdy910UZwTJoihsQ2tJmFKzV
 0RvWnt7w+IpbA==
Message-ID: <f4ece0e8-b2b3-4178-b281-6ba9cc9cab8a@zytor.com>
Date: Thu, 8 Aug 2024 23:38:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
 support
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-3-xin@zytor.com> <ZrOZkYuSKhYH0ymi@intel.com>
 <f4422fc2-d8fc-4902-80c7-0e2dda5bba59@zytor.com> <ZrSSlri1K5WL7XVj@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <ZrSSlri1K5WL7XVj@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

>>>> @@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>>>                NULL, "vmx-entry-ia32e-mode", NULL, NULL,
>>>>                NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
>>>>                "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
>>>> -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
>>>> +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
>>>
>>> Should we also define VMX_VM_ENTRY_LOAD_FRED? "vmx-entry-load-rtit-ctl"
>>> and "vmx-entry-load-pkrs" have their corresponding bit definitions, even
>>> if they are not used.
>>
>> I'm not sure, but why add something that is not being used (thus not
>> tested)?
> 
> Yes, the use of macros is a factor. My another consideration is the
> integrity of the feature definitions. When the such feature definitions
> were first introduced in commit 704798add83b (”target/i386: add VMX
> definitions”), I understand thay were mainly used to enumerate and
> reflect hardware support and not all defs are used directly.
> 
> The feat word name and the feature definition should essentially be
> bound, and it might be possible to generate the feature definition
> from the feat word via some script without having to add it manually,
> but right now there is no work on this, and no additional constraints,
> so we have to manually add and manually check it to make sure that the
> two correspond to each other. When a feature word is added, it means
> that Host supports the corresponding feature, and from an integrity
> perspective, so it is natural to continue adding definition (just like
> the commit 52a44ad2b92b ("target/i386: Expose VMX entry/exit load pkrs
> control bits")), right?
> 
> Though I found that there are still some mismatches between the feature
> word and the corresponding definition, but ideally they should coexist.
> 
> About the test, if it's just enumerated and not added to a specific CPU
> model or involved by other logic, it's harmless?

Unless tests are ready, such code are literally dead code, and could get
broken w/o being noticed for a long time.

I think we should add it only when tests are also added.  Otherwise we 
added burden to maintainers, hoping test will be added soon, which often
never happen.

> 
> Thanks,
> Zhao
> 
> 


