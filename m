Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3E9EFCE53
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 23:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxvWu-00070B-TM; Wed, 04 Mar 2026 18:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxvWr-0006zw-Ha
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 18:21:21 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxvWj-0008Vl-FJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 18:21:18 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 0d9e54eb1665d69a8921462db17eac5952dfe00a32f05afdde6487722d8f0d5f with SMTP id
 69a8bceadbe5d4f814ede7e9; Wed, 04 Mar 2026 23:14:50 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772666088;
 bh=GUt0YC0VDSX4wZOusrz3Bc8/+zlZVoBecxoHBf8Ga+o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=Zc5E/xpY8GKcqGfqrknPH3YTFH7bvccC/o8tZcrlNKQKXG4gpPavlAR4TSrahwMQp
 gtyfm9sq6cvjL3un6T4mHNZAcDwkODZWGt1r2DfKvvk68GJbgLRISgc9/fVgGv5ojH
 XaaGKZJKObc3SiMwS8zjPet/eV1ezlCaK9gVcmO0+AOhubcdf9lh50w71smPownTEm
 khndKcJv6XeBqRUldQt8wXFCaj2fhr541TUXzPJ7pegofukqtRpQL75INz89O44cGl
 Nzq/bStJrygz1SY9DLO5SXX0X+kXCw9FplXsLd/ECPhaM2MWpHRR7bzVza4L2OCCtA
 D0iPGUZUZNYAw==
Message-ID: <3a7617d2-ff9d-403c-9733-14f7c1b5ac3d@yodel.dev>
Date: Wed, 4 Mar 2026 17:14:47 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
 <8b2855dc-44eb-417f-8a18-f40b1036637a@redhat.com>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <8b2855dc-44eb-417f-8a18-f40b1036637a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 04/03/2026 01:38, Thomas Huth wrote:
> On 04/03/2026 02.08, Yodel Eldar wrote:
>> +Daniel (thanks for your comments)
>>
>> On 02/03/2026 19:20, Yodel Eldar wrote:
>>> From: Yodel Eldar <yodel.eldar@yodel.dev>
>>>
>>> Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
>>> clang if available, otherwise disable the treatment of warnings as
>>> errors.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>>> ---
>>> Hi,
>>>
>>> The previous version only disabled Werror whenever `--skip-meson` wasn't
>>> used and the build occurred in a git repo, but this change should
>>> probably apply to all types of builds. So, let's use meson_option_add
>>> to globally disable Werror instead; IIUC (and according to my testing),
>>> this will override the value in config-meson.cross.new.
>>>
>>> I'm still not sure if we should be disabling Werror for ubsan, even
>>> though it's not currently breaking builds with GCC; please let me know
>>> what you think.
>>>
>>> Special thanks to Peter for looking into the cause of the reports around
>>> this, for sharing the findings, and suggesting approaches to resolve it.
>>> I couldn't pick one over the other, so I went with using clang when
>>> available with Werror disable as a fallback; please let me know if you
>>> think this is an XOR kind of policy decision.
>>>
>>> Link to RFCv1:
>>> https://lore.kernel.org/qemu-devel/20260302210039.261325-1- 
>>> yodel.eldar@yodel.dev/
>>>
>>> Link to mentioned discussion:
>>> https://lore.kernel.org/qemu-devel/ 
>>> CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/
>>>
>>> v2:
>>> - Fix misnomer in commit message
>>> - Simplify condition by using the same variable for all sanitizers
>>> - Use meson_option_add to disable Werror
>>>
>>> Thanks,
>>> Yodel
>>> ---
>>>   configure | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index 5e114acea2..e457e8a17d 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -762,6 +762,12 @@ for opt do
>>>     ;;
>>>     --wasm64-32bit-address-limit)
>>>     ;;
>>> +  --enable-asan) use_sanitizer="yes"
>>> +  ;;
>>> +  --enable-tsan) use_sanitizer="yes"
>>> +  ;;
>>> +  --enable-safe-stack) use_sanitizer="yes"
>>> +  ;;
>>>     # everything else has the same name in configure and meson
>>>     --*) meson_option_parse "$opt" "$optarg"
>>>     ;;
>>> @@ -771,6 +777,18 @@ for opt do
>>>     esac
>>>   done
>>> +if test "$use_sanitizer" = "yes"; then
>>> +    if has clang; then
>>> +        echo "Sanitizer requested: setting compiler suite to clang"
>>> +        cc=clang
>>> +        cxx=clang++
>>> +        host_cc=clang
>>> +    else
>>> +        echo "Sanitizer requested: disabling Werror for non-clang 
>>> compilers"
>>> +        meson_option_add -Dwerror=false
>>> +    fi
>>> +fi
>>> +
>>>   if ! test -e "$source_path/.git"
>>>   then
>>>       git_submodules_action="validate"
>>
>> We could treat the rtl8139 as a one-off by carving out the
>> offending code with a GCC pragma or finagling GCC into cooperation
>> by substituting eth_payload_data with the expression assigned to it
>> (thank you, Thomas and Daniel, respectively); indeed, AFAICT the
>> rtl8139 is currently the only code that triggers the GCC bug
>> (and is overdue for a refactor/cleanup), so it's tempting to go with
>> either of these helpful suggestions; *however*, until the GCC team
>> fixes their buggy pairing between sanitizer and -Werror
>> (a pairing that they themselves disavow [1]), IMHO there's a
>> significant risk of recurrence if we went with either option, and
>> it's not clear to me whether reviewers will be able easily spot the
>> next one before it's too late (post-acceptance).
>>
>> That said, I fully share Daniel's concerns about "overriding the
>> user's choice of compiler"; so, what if we instead moved the
>> sanitizer check into the existing "Preferred compiler" section
>> in configure, such that we only set cc=clang when the user hasn't
>> explicitly specified CC/CXX (diff below)? Note: there's already
>> precedent for this with the Obj-C compiler [2].
>>
>> I'm definitely onboard with Daniel's warning message in meson whenever
>> the user: 1) explicitly opts for gcc/g++, 2) enables sanitizers, and 3)
>> -Werror is enabled. At the risk of overengineering, though, what if we
>> made it an error message instead, and gave users an escape hatch like
>> `--force-werror-sanitizers` (name TBD)? I can see that being too much,
>> but it may prevent some grief if they missed the warning, and the build
>> breaks several minutes later. WDYT? It's not included in the diff below,
>> but I'll gladly add it to v3 if there's interest; if not, I'll go with
>> the warning message as suggested.
> 
> I think I would rather avoid another switch like --force-werror- 
> sanitizers and making it a hard error instead of a warning. Think of the 
> point in time when GCC fixed their bug - if someone then wants to 
> compile QEMU with that new GCC, this becomes rather obstructive.
> 

A good point I had not considered, though it may favor the hard error:
if GCC resolves the bug on their end while we've got a gate (with a
switch) around it, we may hear the good news sooner, because of the
increased visibility (or obstructiveness); thus, we may be better
situated to promptly tear the gate down if/when that time comes as
compared to a missable warning that may get ignored well after GCC
releases an immune version.

Furthermore, I think the timeliness concern will apply to most
solutions, because the issue stems from an external dependency, and
any workaround will become redundant upon upstream resolution.

> Alternative idea: What about adding -Wno-stringop-overflow to the CFLAGS 
> when we detect the problematic situation (GCC + sanitizers + -Werror)? 
> Then the build could also continue with GCC without running into the 
> problem.
> 

This seems like a major improvement over local pragmas insofar as it
will prevent future occurrences of -Wstringop-overflow false positives,
but over time this may end up growing into a denylist of all of the
warning flags that confuse GCC + sanitizers, and it could be painful
iteratively expanding that list, because we might catch the triggers
ex post facto.

Moreover, if my reading of Peter's description of the GCC bug is
correct [1], then my guess is that a fix may require a nontrivial
redesign that won't be easily backportable for them, so we may end up
in a situation where we also have to account for the user's GCC version
to judiciously apply the piecemeal exclusion of warning flags to only
the versions that are unable to handle them correctly, and that has the
potential of getting messy pretty quickly (unless we decide to treat
all versions the same, or have a cutoff for supported versions).

In that regard, Daniel's substitution method would fare better, but it
doesn't prevent build breakage before they occur, it may only apply to
stringop-overflow false positives (TBD), and it may come at the cost
of code clarity or expressiveness.

That said, selecting a compiler on behalf of users, as I've proposed,
might subvert environmental expectations and cause problems for them.
Furthermore, my concerns remain largely speculative; so, I'd like to
further monitor the bug to see how it develops upstream GCC.
Thus, I'm formally withdrawing the patch for now.

Thank you to Peter, Thomas, and Daniel for the lively discussion!

Regards,
Yodel

[1] 
https://lore.kernel.org/qemu-devel/CAFEAcA_nCSah+orZrMvsit=iWWp8o9J_Y8Fg7sMJP7XeV0_GBg@mail.gmail.com/

>   Thomas
> 
> 


