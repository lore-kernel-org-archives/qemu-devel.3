Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7301C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQjJ-0001DA-4J; Tue, 04 Jun 2024 05:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQjH-0001CJ-8J
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:45:19 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQjE-0005rk-AI
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:45:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso78997766b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494314; x=1718099114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDiA1iH3Is/8QelR5Op25gwEeDLmgqCOg99x/mjG4fk=;
 b=OeJ5+I0IwW5MwLkn6c3vaornQIeb0apV4RvxY1Z2m8657Oe7T5frBPiSS6KbtGPCxh
 7U2w69A9MxdHHDv6LiKhxLNMr61bJW2JAWS44STbP/vr7Vi8dsMj3yZyES6ZpX8/bSYF
 bi5UeHtwlG5ZX4hdXloBcemuGesx2ekR3zAEGIn1pnonLpduwlWc545e1iiVk9RUtjx3
 cCGJ+zUh7EkKmjapROAw2lbYldKRuKNcGKLu1HEgbyY3OlUP+ImnqB96ym9mOBdfTF5S
 hNldG2uHPlXxKmF2sawFmUpRHc+QSYFqNjZraiqIY5bFMiPLZ3UonlWfRF7ZCEtMtm2N
 Qf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494314; x=1718099114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDiA1iH3Is/8QelR5Op25gwEeDLmgqCOg99x/mjG4fk=;
 b=bMdjEaUwRLwfEoFgov9XMAVYjOcOKzKKTYsQjWE5KzoMnH+QGp5t0JeMqQC2l6Qwwj
 H39t07H49blvxuzr20F/4XVN+vYf7GCtgPrlKIF7W1SBG1VYXSmgZwBFqjuTyc2XTWHz
 NKD62YBOnSbnYVIQgG0ImWOKKAmFnJazu7M6UZU7f7D928F8YOV3bF0R1WVZRsdSaLp2
 K7BsUkMUeeRfwV5iwXABFbFThQq2r5B3eobPCC9U2dPS/o8F/+Tmv5UdiWO0A7T1NQUg
 C22/AtluPLdph2S/DF2n9gusNHclUE6qydSVIm64pzfHSkOkiKtYQGYMVqI6jnBDiaan
 8mzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkJxWz6v8NI/SJC++X4Hx6c2xq41AVOngQME8Wk9aiswHZ/lEKZGSKwiHtjaprIqM1niaw1YgPQH33m/mdSNKSRl/fB30=
X-Gm-Message-State: AOJu0YzjIe7AQRE1MEPfkhLVG1N5Y+yC39jZa8VnlLT2ysmA2bMNaTWV
 l1HB2b1WT6bwFYTMnCwYPmBeyIXebXa+TWZPJ2wlpp+MBEQxCO5LBPxlXjHT900=
X-Google-Smtp-Source: AGHT+IEHvEa9j4cG92UAr03wb2sMZwBzO7HNUulkcYcP5PACQ1RaK6qzU9j30BsYxhLKhDDaltZA1Q==
X-Received: by 2002:a17:906:2845:b0:a68:b5f0:3b31 with SMTP id
 a640c23a62f3a-a68b5f04030mr519947966b.72.1717494314352; 
 Tue, 04 Jun 2024 02:45:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691122859esm252602366b.224.2024.06.04.02.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 02:45:13 -0700 (PDT)
Message-ID: <fcb6ff5d-fcad-4eb1-9b64-0a8477954a0d@linaro.org>
Date: Tue, 4 Jun 2024 11:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 devel@lists.libvirt.org, Eric Farman <farman@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com> <Zl4tgFuAdjU2bst6@gallifrey>
 <87y17lcni7.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y17lcni7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Daniel, Dave, Markus & Thomas.

On 4/6/24 06:58, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
>> * Daniel P. Berrangé (berrange@redhat.com) wrote:
>>> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
>>>> On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
>>>>> We are trying to unify all qemu-system-FOO to a single binary.
>>>>> In order to do that we need to remove QAPI target specific code.
>>>>>
>>>>> @dump-skeys is only available on qemu-system-s390x. This series
>>>>> rename it as @dump-s390-skey, making it available on other
>>>>> binaries. We take care of backward compatibility via deprecation.
>>>>>
>>>>> Philippe Mathieu-Daudé (4):
>>>>>     hw/s390x: Introduce the @dump-s390-skeys QMP command
>>>>>     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>>>>>     hw/s390x: Deprecate the HMP 'dump_skeys' command
>>>>>     hw/s390x: Deprecate the QMP @dump-skeys command
>>>>
>>>> Why do we have to rename the command? Just for the sake of it? I think
>>>> renaming HMP commands is maybe ok, but breaking the API in QMP is something
>>>> you should consider twice.

I'm looking at how to include this command in the new "single binary".

Markus explained in an earlier series, just expanding this command as
stub to targets that don't implement it is not backward compatible and
breaks QMP introspection. Currently on s390x we get a result, on other
targets the command doesn't exist. If we add a stubs, then other targets
return something (even if it is an empty list), confusing management
interface.

So this approach use to deprecate process to include a new command
which behaves differently on non-s390x targets.

If we don't care for this particular case, better. However I'd still
like to discuss this approach for other target-specific commands.

> PRO rename: the command's tie to S390 is them immediately obvious, which
> may be useful when the command becomes available in qemu-systems capable
> of running other targets.
> 
> CON rename: users need to adapt.
> 
> What are the users?  Not libvirt, as far as I can tell.

Years ago we said, "all HMP must be based on QMP". Now we realize HMP
became stable because QMP-exposed, although not consumed externally...

Does the concept of "internal QMP commands" makes sense for HMP debug
ones? (Looking at a way to not expose them). We could use the "x-"
prefix to not care about stable / backward compat, but what is the point
of exposing to QMP commands that will never be accessed there?

>>> That was going to be my question too. Seems like its possible to simply
>>> stub out the existing command for other targets.
> 
> That's going to happen whether we rename the commands or not.
> 
>> Are these commands really supposed to be stable, or are they just debug
>> commands?  If they are debug, then add the x- and don't worry too much.

OK.

> docs/devel/qapi-code-gen.rst:
> 
>      Names beginning with ``x-`` used to signify "experimental".  This
>      convention has been replaced by special feature "unstable".
> 
> Feature "unstable" is what makes something unstable, and is what
> machines should check.

What I mentioned earlier could be 'Feature "internal" or "debug"'.

> An "x-" prefix may still be useful for humans.  Machines should *not*
> key on the prefix.  It's unreliable anyway: InputBarrierProperties
> member @x-origin is stable despite it's name.  Renames to gain or lose
> the prefix may or may not be worth the bother.

Could follow the rules and be renamed as "origin-coordinate-x".

> Making an existing part of the interface unstable should be treated
> similar to deprecating it: we keep it stable for at least the
> deprecation period.  Not written policy, because we didn't consider such
> changes when we documented our deprecation policy in
> docs/about/deprecated.rst.
> 
> Alternative path to a renamed command (*if* we want that):
> 
> 1. Make it unstable.
> 
> 2. But keep it stable for two releases.
> 
> 3. Rename.
> 
> [...]
> 


