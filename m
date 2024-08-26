Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAA9C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 18:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sierc-00084l-M3; Mon, 26 Aug 2024 14:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1siera-00084C-BK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 14:54:50 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sierY-00038i-Py
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 14:54:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7143185edf2so3908562b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724698487; x=1725303287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cpcTE5ovd0HkdL31NSs6RKLfKYFHxH6WNpnODa/kpy8=;
 b=PICiWbsyxOhKQfUypoofkIqo7QNX2HNC6CiLqHmq6NojEcwEInh4ko4dWcq0DLA4mV
 7K/zdSUnFVbywDjvThMErbdlBDDP50vlC/q0IjveNllSj75K+FUptM1Y1q0ZjVyKBCg8
 u3nTakxdAZ1Z0Xgc2gZRgMFzDtfVo636UNJcvoHbfCT5/uEzI2bdNSVxdzetwwpJOJ0W
 /xOKDi27xsTm8/MsLl9EvoJetf6+6IhyIW/8ImSA2zhmNS90QU5yLXbzeuocA1Sf05zM
 TQLAwtpQue5oQl5ZRQWLi37PqhMGvE+LrxSQkfhHzyiA93eg6CZkpC8qu8wgblDiHn8N
 7UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724698487; x=1725303287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpcTE5ovd0HkdL31NSs6RKLfKYFHxH6WNpnODa/kpy8=;
 b=Ysrthgzyek9rqHHKySrZrahZA4kcWUNFPDlV7Sp3VocFfdqilO1I/6+eu+nBk7taph
 0ABTJ7suugr1pKy9UXYtonR3RRFWMt3bn1nCjQHUAuTRalbocgxL3WD4BwiOl5DpkN5t
 d4tfxw746RpDKFUhMMgtifaqdddUGl48zMDH1DO+r5hZqpl8q3fR9mvKGzt8gM4ADXjQ
 oiAVxWvlQrJhKqs1EGjet1ltGdq1BtEFVVpayvjBcq0tvirju3BLkIUTM1p+Bf5CbVVJ
 4vdL8Ukdp4alkWNo11HT3rT38ZkX03l8zPN0/jjvO7i2NwL52hx51WCI9g0qj9TDlItX
 rcHg==
X-Gm-Message-State: AOJu0Yw5e90+5nsJnwf/KR4oEy5QVcpFHlaYY2LbR0B4ETcrbuEb2d3G
 eQTbKeaU/vhWA/RDMmyIvzPzBqnTRSsvoQ1K4vt5jbnpvV4EwLd2arwaOHp0tOA=
X-Google-Smtp-Source: AGHT+IEycWaGZKXtZdlNG44YVcz8+Yn3Jzaf9CE98F1S4WlE2TNdXGwpRM9BhQIaNUFW7ygV1dJsZQ==
X-Received: by 2002:a05:6a21:6481:b0:1c4:bde5:174b with SMTP id
 adf61e73a8af0-1cc8b5d8978mr13311530637.41.1724698487269; 
 Mon, 26 Aug 2024 11:54:47 -0700 (PDT)
Received: from [192.168.1.211] ([50.46.173.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434340419sm7302459b3a.205.2024.08.26.11.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 11:54:46 -0700 (PDT)
Message-ID: <94f0ad4a-753a-43c7-b4c0-9e1fa3c4d00d@gmail.com>
Date: Mon, 26 Aug 2024 11:54:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to read guest memory
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240821235607.208622-1-rowanbhart@gmail.com>
 <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
 <87a5h3legw.fsf@draig.linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <87a5h3legw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alex,

Thanks for the additional information.

>>
>> A key aspect of what you propose here, is that the memory may have
>> changed during the write time, and when you read it, while what we
>> propose guarantees to track every change correctly.
>>
>> It's not a bad thing, and both API are definitely complementary. When
>> talking to Alex, he was keen to add a global read_memory API (like you
>> propose), after we merge the first one.
>>
>> @Alex: any thought on this?
> 
> I'd like to get the memory callback API merged first - mostly because
> that is the API that will absolutely reflect what was loaded or stored
> to a given memory location. For precise instrumentation that is the one
> to use.
> 
> However I agree the ability to read the state of memory outside of loads
> and stores is useful especially for something like this. It's not
> unreasonable to assume the memory state of arguments going into a
> syscall isn't being messed with and it is easier to track pointers and
> strings with a more general purpose API.
> 

I agree, I considered the absolute load/store question and poked around the
code a bit, but I didn't find what looked like a solid way to either:

A) Ensure that all writes are flushed before the read happens (which sounds
like a hefty performance penalty anyway) or
B) Check whether there are outstanding writes and return an error

It sounds like essentially use cases where that level of per-insn write
granularity matters should utilize your upcoming API instead of this one, and I
will add a call-out to the doc of this one to alert users of the potential pitfall.

>>>       qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>>>       qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> 
> There was someone on IRC looking to trace system calls in system mode
> (by tracking the syscall instruction and reading the registers at the
> time). I wonder if we could make this plugin do the right thing in both
> modes?
> 

Cool! I think this should be doable.

-Rowan

