Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70DBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sgP-0007cG-JW; Fri, 03 May 2024 09:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2sgO-0007c2-4i
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:10:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2sgM-0001PA-Jm
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:10:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f44ed6e82fso311037b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714741833; x=1715346633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/qd8oZ2HnJZTizzNiciGt3jRN4Q26fbAbnpLDb7B0M=;
 b=xwYPtMUIStPFIJESDdpdkUi+SXp2O7wVWQyMLW0dnZt5Rjiehdkt/noNLdOFp2WkYi
 2DCeXsm4LLjwlEYGw1CG3mTRu7RaTMUDvi1wJkl3AwLaPms1R9e00UpDYZ/Ls+eed1eA
 JTYjs5SAZWbcc/MzCncQLFD3LuzBa8c4OarqNlZfZTM9ma8Xcf5WtD2UkH092zQ94CPZ
 5zYFIQVgOcQfNjrX7DIy5sWWnSBdUVfg0jbKLcwdo00qr+pRXjK6AbQInueRJClGFaCe
 +QPcuPocVjJAKbvei5tnTTmtHJgvQBQ1L0f3z3hlOc40HYg4qchCuqsTN/d3Q1v2IOFI
 CPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714741833; x=1715346633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/qd8oZ2HnJZTizzNiciGt3jRN4Q26fbAbnpLDb7B0M=;
 b=FEcSYgXDykNOQY7zEBBJDLX4//IaMIO37igW4m+DO4aehaBobUmvw7D4TT7fIbmNWn
 78R99ZYo5IB9S5eqe4HMA+EtIA71buU7jSz5gC9PkbLOHnLpUPI9XxK94jAH+aIuKaQs
 4iwYMBSuP5ohtxQV2CYeDXTQXFFgIxNSfusF5JfR3nSPEq0NRixc/sPCTviokUhUJjqV
 k2mG3CAF555O+zMz8nEMwUFhIs7InXbQFygvxyuBmLJXmLPzOct/74rQj/b9P12UdSUh
 FmiQMaTGpAAzQ7BIhnOkzGbRehuB2+6S09tihS2+qCO9INPAatkoZzj/25x1KiY5Ae1M
 5HCQ==
X-Gm-Message-State: AOJu0YwuF6dvmGiwTMjkipzr5c0ev9am7tTBr8GU4aLNiW8A8L56xAF5
 7aJVSDuVJZyfYtLjWbrRzVsNfSMKp43lg1cQB1cZyfUchH6Ghsy4ZVYHebyj+nY=
X-Google-Smtp-Source: AGHT+IF0/hUfzjonRG2t6X+ybcznJAPkDk/TYS2tpKkdXh5NSRNSl7hcVmpy3EjaagoH9pCJQ9bYDg==
X-Received: by 2002:a05:6a00:2411:b0:6f4:41f2:b869 with SMTP id
 z17-20020a056a00241100b006f441f2b869mr2491381pfh.21.1714741832966; 
 Fri, 03 May 2024 06:10:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e9-20020aa78249000000b006f43480dac7sm3003731pfn.59.2024.05.03.06.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 06:10:32 -0700 (PDT)
Message-ID: <4c683c02-64fa-47b8-882c-bd19c90897de@linaro.org>
Date: Fri, 3 May 2024 06:10:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/13] hmp/migration: Fix documents for "migrate" command
To: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20240502202316.29924-1-farosas@suse.de>
 <20240502202316.29924-14-farosas@suse.de> <87bk5n1ius.fsf@pond.sub.org>
 <87cyq3njnr.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87cyq3njnr.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/3/24 05:51, Fabiano Rosas wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> From: Peter Xu <peterx@redhat.com>
>>>
>>> Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
>>> 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
>>> adding a Fixes to make life easier for the stable maintainer.
>>>
>>> When at it, slightly cleanup the lines, move "detach/-d" to a separate
>>> section rather than appending it at the end of the command description.
>>>
>>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>>> Cc: Fabiano Rosas <farosas@suse.de>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>   hmp-commands.hx | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>> index ebca2cdced..484a8a1c3a 100644
>>> --- a/hmp-commands.hx
>>> +++ b/hmp-commands.hx
>>> @@ -918,8 +918,13 @@ ERST
>>>   
>>>   
>>>   SRST
>>> -``migrate [-d]`` *uri*
>>> -  Migrate to *uri* (using -d to not wait for completion).
>>> +``migrate [-d] [-r]`` *uri*
>>> +  Migrate the current VM to *uri*.
>>> +
>>> +  ``-d``
>>> +    Run this command asynchronously, so that the command doesn't wait for completion.
>>> +  ``-r``
>>> +    Resume a paused postcopy migration.
>>>   ERST
>>>   
>>>       {
>>
>> I have questions on this one.
> 
> Yep, I should have waited longer before queuing this one, my bad.

Ok, I will not process this pull request.


r~

