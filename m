Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A2BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSB4t-0006l5-1M; Wed, 27 May 2026 06:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSB4m-0006kk-QY
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSB4k-0005bk-0s
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779876079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ay2apyt8Zf8k21e9UKkTDBEyVVh69T608NmlPGJLJnY=;
 b=eRQ24tacBEspYmgCG0SdmH5XZcEIBILlP/xjySM4JBYhIamb0BhKIRnrAxtCDI39T+hh6J
 vNu0kcVkEwb0GIgFghqsIjIp/AYcuA1yjl+a1AOlclvdeR5naaBtDoLmRU2MO70JnGIEhs
 44XU2L5e4x5lJQSaYiKcWlL929TR2Pw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-zhPvB4XNP5SIg12YmY5l-Q-1; Wed,
 27 May 2026 06:01:15 -0400
X-MC-Unique: zhPvB4XNP5SIg12YmY5l-Q-1
X-Mimecast-MFC-AGG-ID: zhPvB4XNP5SIg12YmY5l-Q_1779876074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1589519560A7; Wed, 27 May 2026 10:01:14 +0000 (UTC)
Received: from [10.44.32.217] (unknown [10.44.32.217])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D01C01800352; Wed, 27 May 2026 10:01:11 +0000 (UTC)
Message-ID: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
Date: Wed, 27 May 2026 12:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: on ai generated and code provenance
To: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ahauQKLOU1tzDtbb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/27/26 10:41, Kevin Wolf wrote:
> Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
>> The QEMU Project currently may accept limited uses of AI that produce
>> high quality patches that are limited in the creative content added.
>> While maintainers will ultimately decide, changes like the following
>> fall within this policy
>> 1. Fixing obvious warnings in the obvious ways suggested by the tool
>> 2. Tree wide API changes, and other similar mechanical changes done
>>     today with perl/python/sed/coccinelle
> 
> As I said in the paragraph you quoted below, I don't think we should
> encourage using AI for tasks that a deterministic tool could do.

In some cases such a tool does not exist.  Much to my surprise, there is 
no tool to do static type inference on Python code, but AI is very good 
at doing it.

> Letting AI perform the change directly instead may be an acceptable
> shortcut for a one-man hobby project that nobody else will ever look at,
> but in the context of a community project like QEMU in which your
> changes have to be reviewed and understood by others, it matters a lot
> that the output of the tool is reproducible. Otherwise, you're creating
> unnecessary work for others, and that isn't acceptable.

When applicable, going through coccinelle (with the aid of AI if needed! 
is indeed a good middle ground as it helps reviewers for large changes. 
If you have many slightly different but easily separated changes (e.g. 
you can split the patch by struct field), it may make things worse.

Its also worth noting that in other cases even sed or coccinelle, while 
deterministic, cannot produce 100% of the patch.

> So maybe we should even explicitly mention a recommendation like the
> following:
> 
>      If you can use a deterministic tool, don't use AI instead. If you
>      don't know how to use the deterministic tool, use the AI to tell you
>      how to use it instead of trying to replace it.

I like it.

>> 3. Limited, small changes to fix bugs or add a small new feature whose
>>     scope is less than about 100 lines and the originator can explain
>>     them all or the meta issues about the patch.
> 
> Not sure if mentioning a number of lines is wise. 100 lines can be
> mostly boilerplate and simple sequential code or they can be a deeply
> nested complex algorithm.

I'd put the threshold at 20-50 at most.

> I think I would see more use in a tag like (better name welcome):
> 
>     AI-used-for: [code|tests|docs|commit message]...

I like this *a lot*.  No need for free advertisement, but some 
traceability is useful.

For tools such as sed or coccinelle, having the exact script in the 
patch or commit message useful.  Plus, the execution of the script more 
or lesss delimits the commit by itself (or 90%+ of it).  For LLMs it's a 
bit less clear cut because separating docs makes little sense.  And the 
exact model is pointless, it will be obsolete in 6 months and provide no 
useful information.

So, something like:

------------------- 8< -------------------
Use of AI-generated content
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The QEMU project currently allows using AI/LLM tools to produce patches 
in scenarios with limited creative content:

Mechanical changes
   If you can use a deterministic tool or a script, don't use AI instead.
   If you don't know how to do the change deterministically, you may
   ask the AI for help, rather than having it stand in for the tools.

Small bug fixes
   These should be limited to 20 lines of code or less, not including
   tests.  You are still expected to understand and explain your changes
   and the rationale behind them.

These boundaries do not apply to other uses of AI, such as researching
APIs or algorithms, static analysis, or debugging, provided their output
is not included in contributions.  Larger uses of AI are allowed as an 
experiment, but they should be agreed upon with the maintainer prior to 
submission.

Use of AI does not remove the need for authors to comply with all other
requirements for contribution.  In particular, the "Signed-off-by"
label in a patch submission is a statement that the author takes
responsibility for the entire contents of the patch, certifying that
their patch submission is made in accordance with the rules of the
`Developer's Certificate of Origin (DCO) <dco>`.

Commit messages for AI-assisted changes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When AI/LLM tools produce or substantively shape your patch, add an 
``AI-used-for:`` trailer.  The text of the trailer could be one or more 
of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an 
explanation in parentheses::

     AI-used-for: tests, docs
     AI-used-for: code
     AI-used-for: code (refactoring)
     AI-used-for: code (prototype)
     AI-used-for: research

The trailer is intended as a clarification of your DCO obligations as 
well as to guide reviewers.  It is not intended for minimal presence 
such as autocomplete or asking for a pre-review of the patch, and it 
does not remove your responsibility to understand the changes that you 
are submitting.

Include the prompt in the commit message if it helps a reviewer judge 
the result:

* yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a 
function already has a local variable or parameter of type ``struct 
bb``, use it instead of accessing ``aa.bb``."

* yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``, 
forwarding the member functions to ``T`` while taking the lock around 
the calls".

* no: "write user-facing documentation for the new tool"

* no: "write testcases for the new functions"

Deterministic tooling (sed, coccinelle, formatters) is out of scope for 
the trailer, but should be mentioned in the commit message.


