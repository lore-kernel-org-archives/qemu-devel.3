Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33552E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 12:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtBw-0001wY-7y; Mon, 02 Feb 2026 07:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vmtBv-0001vy-4a
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 07:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vmtBs-0007pa-LQ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 07:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770035881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPT9paY39GfaTdLiYcFr02HeGBxC/vy280BB8hMwkCM=;
 b=VH03V8vLh1kzGL9DEDlGNQpJNkKaAHO7RRC9mku+vv7B44ytNtcvS70WmkSySHKjufvAVL
 bxkdCiZ1AR6XGJGifaHxx8N3rU5WfZ81GtsTqSukB0rFnYQSkEfTRGdYulvi/mnBDAeycl
 W4ixpkITkmi7jWLBlJ1JhyJFFWlb3LM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-PehBuJ-qNWy_vUWLaKitZA-1; Mon,
 02 Feb 2026 07:37:58 -0500
X-MC-Unique: PehBuJ-qNWy_vUWLaKitZA-1
X-Mimecast-MFC-AGG-ID: PehBuJ-qNWy_vUWLaKitZA_1770035877
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EF9D19560B2; Mon,  2 Feb 2026 12:37:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B282180009E; Mon,  2 Feb 2026 12:37:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A180121E692D; Mon, 02 Feb 2026 13:37:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Roman Kiryanov <rkir@google.com>,
 qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 mjt@tls.msk.ru,  whollins@google.com,  jansene@google.com,
 jpcottin@google.com,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
In-Reply-To: <6f175d60-6544-4dc9-99eb-71f60c305017@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 2 Feb 2026 12:20:30
 +0100")
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
 <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
 <0954062c-c032-42be-ad0d-df2559360963@linaro.org>
 <CAFEAcA-ShmtJ2tOO_bz+d_oKJaDTG15bc9s775mND=FLWQdRpw@mail.gmail.com>
 <aYCD4g7x8DDH4tyW@redhat.com>
 <6f175d60-6544-4dc9-99eb-71f60c305017@linaro.org>
Date: Mon, 02 Feb 2026 13:37:52 +0100
Message-ID: <87wm0v9v8f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 2/2/26 12:00, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Jan 30, 2026 at 09:19:32AM +0000, Peter Maydell wrote:
>>> On Thu, 29 Jan 2026 at 21:44, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> (+Paolo / Eric)
>>>>
>>>> On 29/1/26 21:31, Peter Maydell wrote:
>>>>>
>>>>> What are we trying to achieve here, and why does it benefit
>>>>> us as an upstream project ?
>>>>>
>>>>> cf previous email thread from 2024
>>>>> https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/
>>>>> about "drip-feeding" of this kind of patch with no clear take
>>>>> on what the end state is or how much churn it's going to induce.
>>>>
>>>> I clearly know QEMU is not a C++ project. Now I don't see why we should
>>>> be reluctant to have headers being usable by a C++ compiler, as long as
>>>> it doesn't make our project worst to maintain.
>>>
>>> Every bit of code that is written by some downstream in C++ is
>>> some thing that will essentially then never be upstreamed without
>>> a big rewrite. So making it easier for downstreams to use C++
>>> reduces our chances of seeing them contribute what they do back to us.
>>>
>>> It's also extra work for us (for instance in this thread you
>>> proposed adding a CI job, which is more CI minutes cost to
>>> the project, more work for maintainers when something that
>>> builds fine locally falls over in the CI, and so on).
>>>
>>> Each individual fix might be trivial, but they add up.
>>> So it matters whether this one is "this is the only thing
>>> we tripped over since 2024" or "we just rebased to a new
>>> QEMU version and are going to be submitting dozens of these
>>> over the next few weeks".
>>>
>>>> See for example non-invasive commit 7246c4cc470 ("exec: don't use void*
>>>> in pointer arithmetic in headers"):
>>>
>>>> or commit 17c7df806b3 ("exec: avoid using C++ keywords in function
>>>> parameters"):
>>>
>>> For the record, I wasn't really enthusiastic about those changes
>>> either, for essentially the same reasons.
>>>
>>>> In this particular case, I always have been confused about what would =
be
>>>> the size of forward-declared enums. The C99 standard chapter =C2=A76.7=
.2.2
>>>> point 4 mentions:
>>>>
>>>>     Each enumerated type shall be compatible with char, a signed
>>>>     integer type, or an unsigned integer type. The choice of type
>>>>     is implementation-defined, but shall be capable of representing
>>>>     the values of all the members of the enumeration.
>>>>
>>>> When compiling this file with -Werror=3Dpedantic we get:
>>>>
>>>> In file included from ../../ui/kbd-state.c:10:
>>>> include/ui/kbd-state.h:12:14: error: ISO C forbids forward references =
to
>>>> 'enum' types [-Werror,-Wpedantic]
>>>>      12 | typedef enum QKbdModifier QKbdModifier;
>>>>         |              ^
>>>>
>>>> So arguably this could be fixed for C.
>>>
>>> Yes, I actually like the specific change in the patch
>>> on style grounds.
>>
>> The *current* code style, however, matches the style we use for the
>> struct declaration & typedefs, and it is natural to be consistent
>> in this way.
>
> Per the ISO C standard, maybe we should considerate following the same
> structure style for enum typedefs was a mistake, and update our coding
> style. This is what I suggested here:
>
> https://lore.kernel.org/qemu-devel/20260130211746.46667-3-philmd@linaro.o=
rg/

Is ISO C conformance really a compelling argument?

We are relying on multiple Gcc / Clang C extensions.  Forward-declared
enums is just one of them.

>> Even within this one file we have this example:
>>
>>    typedef enum QKbdModifier QKbdModifier;
>>    typedef struct QKbdState QKbdState;
>>
>> And so personally I think the current code is preferrable to this patch.

I think the current code is just fine.

>> IMHO, if downstream users/developers of a fork really strongly don't want
>> to be writing new devices in C, then the focus should be on Rust as the
>> next generation language, not the C++.

Their funeral.

Can't see why we'd be interested in enabling it, though.


