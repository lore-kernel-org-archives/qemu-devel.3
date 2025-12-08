Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC833D3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXgT-0000Fe-Hm; Mon, 08 Dec 2025 04:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuramitsu@ksl.ci.kyutech.ac.jp>)
 id 1vSXgR-0000Ew-K0
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:37:31 -0500
Received: from ns.ksl.ci.kyutech.ac.jp ([131.206.203.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuramitsu@ksl.ci.kyutech.ac.jp>)
 id 1vSXgP-0005QL-7I
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ksl.ci.kyutech.ac.jp;
 s=default; t=1765186640;
 bh=bjj62e8e/spufriawCR1s/qMAGjv/cDJZCugCAozaJ8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OkaUy9S3xoJcANaz89QhiQU5Djg5XbjkWkZSGM2FfeUMHog+xK43LzdkS7tEV9LKd
 82d0u4Mh3h8pNPf43tN/88CvnQIuI0XG6VbYym6uiYVib2pf7jNvjQ4VMhzs3ssnGD
 Fa4l0u/A/erR0LdW0mHjV4hOP/lMP2bFP6rubrCWu1yH0jHrLXnejSRLyVvUsb9a7x
 5fhCPBwwYw3HwbAPtbaUrcliYxXbRn94gJ1kq3RoBqZxzT31j2Cg8X8BgNMfcMQsGd
 aN6EEiGaXJd97b3Rqlg/9m/Z4HX4sFQXIEiJhBwj/epZs+NCZBg43r+kIWmARSWQU4
 OARfWDq8RIMFw==
Received: from [192.168.0.85] (unknown [192.168.0.85])
 by ns.ksl.ci.kyutech.ac.jp (Postfix) with ESMTPSA id DEEC23C0442;
 Mon,  8 Dec 2025 18:37:20 +0900 (JST)
Message-ID: <ca445bdd-297e-4e8d-9b44-06c1b44378e4@ksl.ci.kyutech.ac.jp>
Date: Mon, 8 Dec 2025 18:37:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tcg: Requesting clarification on return value of prepare_host_addr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <3d73bcbc-d3f0-4271-9f99-d53fb5a85db6@ksl.ci.kyutech.ac.jp>
 <CAFEAcA_XNdUDFLojnqYdsBqh2jZyg45ds9wJjiS9ujhPnX2z9Q@mail.gmail.com>
Content-Language: en-US
From: Shusaku KURAMITSU <kuramitsu@ksl.ci.kyutech.ac.jp>
In-Reply-To: <CAFEAcA_XNdUDFLojnqYdsBqh2jZyg45ds9wJjiS9ujhPnX2z9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=131.206.203.254;
 envelope-from=kuramitsu@ksl.ci.kyutech.ac.jp; helo=ns.ksl.ci.kyutech.ac.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 2025/12/05 23:44, Peter Maydell wrote:
> On Fri, 5 Dec 2025 at 14:27, Shusaku KURAMITSU
> <kuramitsu@ksl.ci.kyutech.ac.jp> wrote:
>> I've noticed a possible discrepancy between the comment and the behavior
>>
>> of i386's prepare_host_addr (located at tcg/i386/tcg-target.c.inc, line
>> 2157-2260):
>>
>>
>> ```
>>
>> /*
>>    * For softmmu, perform the TLB load and compare.
>>    * For useronly, perform any required alignment tests.
>>    * In both cases, return a TCGLabelQemuLdst structure if the slow path
>>    * is required and fill in @h with the host address for the fast path.
>>    */
>> static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>>                                              TCGReg addr, MemOpIdx oi,
>> bool is_ld)
>> {
>>       TCGLabelQemuLdst *ldst = NULL;
>>
>> ...
>>       if (tcg_use_softmmu) {
>>
>> ...
>>
>>           ldst = new_ldst_label(s);
>>           ldst->is_ld = is_ld;
>>           ldst->oi = oi;
>>           ldst->addr_reg = addr;
>>
>> ...
>>
>>       } else if (a_mask) {
>> ...
>>       }
>>
>>       return ldst;
>> }
>>
>> ```
>>
>>
>> The code appears to always assign (in case of softmmu) a label to `ldst`
>> and return it,
> No; if tcg_use_softmmu is false and a_mask is zero then
> we will not take either the if() or the else if() block,
> and ldst will still be NULL when we return it.
>
> This is because:
>   * softmmu always requires a slowpath (because we might
>     look the guest address up in the TLB but not find it)
>   * linux-user mode needs a slowpath only if we need to
>     enforce alignment and atomicity checks for this
>     memory access (because linux-user always has "guest
>     address == host address + some constant", so most
>     simple loads and stores cannot fail or be complicated)
>
> If we don't have to do either, then we don't need the slowpath.
>
>> As I understand it, there is no way to determine, at this point, which
>> of the two paths to use;
>>
>> the generated machine code (see L2233-2237), not the C code here,
>> performs the TLB comparison.
> That's right. We are generating the code in this function
> to do everything except the final "load/store from the host
> address" part. If we're using softmmu that includes all the
> code to look the guest address up in the TLB.
>
> I think the way to understand this function is to look at
> the functions that call it, like tgen_qemu_ld(). They do:
>
>   * call prepare_host_addr()
>   * call a function to generate a plain host load or store
>
> If the prepare_host_addr() code wants to do an out of
> line slow-path, then the code we emit looks like:
>    - do stuff to figure out if we can fast path this
>    - conditional jump to out-of-line label for slow path
>    - fast path handling; at the end of this we have the
>      host address for the memory access
>    - host load or store generated by tgen_qemu_ld etc
>    - and then fall through into code for the next guest insn
>
> At the end of the TB we will arrange to emit the
> out-of-line label and the slow path code.
>
> thanks
> -- PMM

Thanks for the reply! Perhaps the confusion is from what "requiring 
slowpath"

means. Does that mean requiring emitting slowpath (which I suspect is 
what's happening

here), or requiring jumping to slowpath (i.e. never using fastpath), on 
softmmu?


Shusaku KURAMITSU

Kyushu Institute of Technology, Japan


