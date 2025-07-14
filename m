Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA00C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNJ9-0002ZP-OL; Mon, 14 Jul 2025 13:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1ubMHM-00052G-Ja
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:43:48 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1ubMHE-0007GJ-PT
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:43:48 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 5d56e144;
 Mon, 14 Jul 2025 19:43:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; s=dkimselector; bh=MdF3
 wVOdcBXE3vSbImY9UKHk2Ko=; b=qDjs9HEHxNnuT86z7yIvgQ2Vjxd4NrPx/3LI
 sR9PYPYN677Q54MU3S6F6m+QH9wFsBB9L9aL7mOJZOBHXBDxYiks7J9q+Fkklca8
 tF8mVPEnqss3gIJD5vCYU1fSukFp2S7d7P4RsbWzu7cQV1zALREWxbST07uCoQKk
 IlFul1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=dkimselector; b=
 uCd8G+4X7GVs3GMNkbT4MzBQ5cWIUW0dKPjzJCNl1x2UE5Jt4cqVlDUj8RnBBhb3
 r5jEu6C+fiAI+zKQfqehV0DxZ72nPaWRD3XOl0vQ9IRBLCrKBiRBeuFhCIuIYmvd
 JlCqoj7NLPlORNTuElyrHoafk3/OReUVzLV0eoi9xkI=
Received: from [10.137.0.79] (<unknown> [194.127.199.89])
 by quyllur.org (OpenSMTPD) with ESMTPSA id fa988e73
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Mon, 14 Jul 2025 19:43:00 +0300 (EEST)
Message-ID: <4a0810b7-9fa1-48f9-9cae-fc72376e2fe6@quyllur.org>
Date: Mon, 14 Jul 2025 11:42:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Reformatted Sparc GDB XML patches.
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com, laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk, philmd@linaro.org
References: <20250711155141.62916-1-unisono@quyllur.org>
 <87h5zf11jf.fsf@draig.linaro.org>
Content-Language: en-US
From: Rot127 <unisono@quyllur.org>
Autocrypt: addr=unisono@quyllur.org; keydata=
 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
In-Reply-To: <87h5zf11jf.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 > What testing have you done with these two?

None with Sparc32 and Sparc32plus. Also because I don't have immediate 
access to a toolchain. But I have to do Sparc32 eventually as well and 
can report back then.

For Sparc64 I use it in a the TCG plugin as described.
And it works as expected.

But haven't tested more unfortunately.
I wanted to get the patches out early, so you can consider adding it 
into v10.1.

On 7/14/25 05:59, Alex Bennée wrote:
> unisono@quyllur.org writes:
> 
>> From: Rot127 <unisono@quyllur.org>
>>
>> Adds Sparc XML register files from GDB.
> <snip>
>>    Adds the GDB register XML files for Sparc32.
>>    Assign the GDB register XML files of Sparc64 to Sparc32plus.
> 
> I'm holding of these two until I can get sparc32-linux-user tested. Our
> coverage isn't currently great due to not having cross compilers. For
> sparc32plus specifically is the sparc64 xml going to work given it is
> using a 32 bit ABI.
> 
> What testing have you done with these two?
> 
>>
>>   configs/targets/sparc-linux-user.mak       |  1 +
>>   configs/targets/sparc-softmmu.mak          |  1 +
>>   configs/targets/sparc32plus-linux-user.mak |  1 +
>>   configs/targets/sparc64-linux-user.mak     |  1 +
>>   configs/targets/sparc64-softmmu.mak        |  1 +
>>   gdb-xml/sparc32-core.xml                   | 84 ++++++++++++++++++
>>   gdb-xml/sparc64-core.xml                   | 99 ++++++++++++++++++++++
>>   target/sparc/cpu.c                         |  2 +
>>   8 files changed, 190 insertions(+)
>>   create mode 100644 gdb-xml/sparc32-core.xml
>>   create mode 100644 gdb-xml/sparc64-core.xml
> 


