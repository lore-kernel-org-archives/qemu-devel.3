Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0988BD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSsKW-0007nc-DK; Tue, 09 Dec 2025 02:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuramitsu@ksl.ci.kyutech.ac.jp>)
 id 1vSsKQ-0007lJ-AL
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:40:12 -0500
Received: from ns.ksl.ci.kyutech.ac.jp ([131.206.203.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuramitsu@ksl.ci.kyutech.ac.jp>)
 id 1vSsKK-0000ZV-UT
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ksl.ci.kyutech.ac.jp;
 s=default; t=1765265999;
 bh=Btn/LhflQC39+1Ar7CUzAkKUucxFeCXsIQ/HNdHLQdw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=heyp1G96Mz9uqloS0or+xkag09p1KDzxzeBzMoH0lL3WiZDs79hn9WBJtNabEHUQi
 ibwBYW0bPhcsM9AF4/Qd8qJ1rM7+9Jh9y51Aj1wTk7Dc7jKZ1dtqzpChElVIksziu8
 S46pogY4EXB1eczRaod3s6ULeAdSEoiXlwatAQGyF2uwblvC+P7Fck4G6A0HeSDOoU
 a8l+Q76DUjjDD3rmqsB8SCNCuvY/bjdLRtMRIC4dMoz17yTb32O3EqF8a3m3hXhUin
 ivvXohdW+jCkl59PFhoNYCsJv6KQLVI1e9RYo1YNQe5lDZ4GTmtoTKJhLqNnDlm+Us
 g+40VpAldSEsQ==
Received: from [192.168.0.85] (unknown [192.168.0.85])
 by ns.ksl.ci.kyutech.ac.jp (Postfix) with ESMTPSA id 352783C012C;
 Tue,  9 Dec 2025 16:39:59 +0900 (JST)
Message-ID: <875336d6-9393-4e61-ac86-10285f4aae3d@ksl.ci.kyutech.ac.jp>
Date: Tue, 9 Dec 2025 16:39:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tcg: Requesting clarification on return value of prepare_host_addr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <3d73bcbc-d3f0-4271-9f99-d53fb5a85db6@ksl.ci.kyutech.ac.jp>
 <CAFEAcA_XNdUDFLojnqYdsBqh2jZyg45ds9wJjiS9ujhPnX2z9Q@mail.gmail.com>
 <ca445bdd-297e-4e8d-9b44-06c1b44378e4@ksl.ci.kyutech.ac.jp>
 <CAFEAcA8EE_HrLKCvwTYGxVUtNqiF9nRycPPihMoRyMSPzyZt4Q@mail.gmail.com>
Content-Language: en-US
From: Shusaku KURAMITSU <kuramitsu@ksl.ci.kyutech.ac.jp>
In-Reply-To: <CAFEAcA8EE_HrLKCvwTYGxVUtNqiF9nRycPPihMoRyMSPzyZt4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=131.206.203.254;
 envelope-from=kuramitsu@ksl.ci.kyutech.ac.jp; helo=ns.ksl.ci.kyutech.ac.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/12/08 19:11, Peter Maydell wrote:
> On Mon, 8 Dec 2025 at 09:37, Shusaku KURAMITSU
> <kuramitsu@ksl.ci.kyutech.ac.jp> wrote:
>>
>> On 2025/12/05 23:44, Peter Maydell wrote:
>>> No; if tcg_use_softmmu is false and a_mask is zero then
>>> we will not take either the if() or the else if() block,
>>> and ldst will still be NULL when we return it.
>>>
>>> This is because:
>>>    * softmmu always requires a slowpath (because we might
>>>      look the guest address up in the TLB but not find it)
>>>    * linux-user mode needs a slowpath only if we need to
>>>      enforce alignment and atomicity checks for this
>>>      memory access (because linux-user always has "guest
>>>      address == host address + some constant", so most
>>>      simple loads and stores cannot fail or be complicated)
>>>
>>> If we don't have to do either, then we don't need the slowpath.
>> Thanks for the reply! Perhaps the confusion is from what "requiring
>> slowpath" means. Does that mean requiring emitting slowpath (which
>> I suspect is what's happening here), or requiring jumping to
>> slowpath (i.e. never using fastpath), on softmmu?
> Here I meant that we must emit code for the slow path,
> because we cannot guarantee that we do not need it at
> runtime. (If we are in this function at all then we
> know it's at least possible that we might be able to
> take the fast path and handle the load/store entirely
> with the inline generated code.)
>
> The only case where we can guarantee that we do not
> need a slow path and can always complete the load/store
> inline is for linux-user mode when there are no alignment
> or atomicity constraints.
>
> thanks
> -- PMM


Thanks! That answers my question.


Shusaku KURAMITSU

Kyushu Institute of Technology, Japan


