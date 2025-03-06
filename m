Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB4C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqD9Z-0006pv-FZ; Thu, 06 Mar 2025 10:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tqD9V-0006oj-C9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:28:49 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tqD9S-0003hU-Sq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:28:48 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5940C4E6013;
 Thu, 06 Mar 2025 16:28:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rIuRJW1JyRqo; Thu,  6 Mar 2025 16:28:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5DF6E4E6001; Thu, 06 Mar 2025 16:28:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B43074577D;
 Thu, 06 Mar 2025 16:28:41 +0100 (CET)
Date: Thu, 6 Mar 2025 16:28:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
In-Reply-To: <Z8m8GmPzTum7qEcS@redhat.com>
Message-ID: <15694c26-5a08-d786-e1bf-212365b1f957@eik.bme.hu>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
 <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
 <21a34cac-855b-4628-a154-e708ea85df59@linaro.org>
 <CABgObfaKQLizim36Lzqzn+brc5d7m10eKbZV59ZK9+03Kt7eTg@mail.gmail.com>
 <Z8mMhjwiYCY7Pq4H@redhat.com>
 <c6953b69-a54d-6d42-343e-dae07266306f@eik.bme.hu>
 <Z8m8GmPzTum7qEcS@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1209260455-1741274921=:53921"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1209260455-1741274921=:53921
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Mar 2025, Daniel P. Berrangé wrote:
> On Thu, Mar 06, 2025 at 02:45:52PM +0100, BALATON Zoltan wrote:
>> On Thu, 6 Mar 2025, Daniel P. Berrangé wrote:
>>> On Thu, Mar 06, 2025 at 12:34:13PM +0100, Paolo Bonzini wrote:
>>>> Il gio 6 mar 2025, 10:27 Philippe Mathieu-Daudé <philmd@linaro.org> ha
>>>> scritto:
>>>>
>>>>> This API is to allow refactoring code for heterogeneous emulation,
>>>>> without changing user-facing behavior of current qemu-system binaries,
>>>>> which I now consider as 'legacy'.
>>>>>
>>>>> Once all current restrictions removed, the new qemu-system-heterogeneous
>>>>> binary is expected to run any combination of targets.
>>>>>
>>>>> qemu-system-$target will be a call to qemu-system-heterogeneous with
>>>>> a restricted subset, possibly in the form of:
>>>>>
>>>>>   $ qemu-system-heterogeneous --target aarch64-softmmu
>>>>>
>>>>
>>>> Or just qemu-system I guess.
>>>>
>>>>     ^ equivalent of today's qemu-system-aarch64
>>>>>
>>>>> If you don't like 'qemu_legacy_binary_' prefix, I can use
>>>>> 'qemu_single_binary_' instead.
>>>>>
>>>>
>>>> Still there is a problem with renaming binaries (both the "qemu-kvm" case
>>>> and the good/bad case that Richard pointed out).
>>>
>>> We could special case the '-kvm' suffix, because by its nature it
>>> implies the current binary build target.
>>>
>>>>
>>>> I think you should try creating two versions of system/arch_init.c, so that
>>>> it has a separate implementation for heterogeneous vs. single-target
>>>> binaries. Then you can keep separate linking steps for single-target
>>>> binaries and you naturally get the right target info from either the
>>>> target-specific arch_init-single.c, or the --target option for
>>>> arch_init-multi.c.
>>>>
>>>> (Is --target even necessary? As long as you have a way disambiguate
>>>> same-named machines like -M virt, and have no default machine in the
>>>> multi-target binary, you shouldn't need it).
>>>
>>> If we did 'query-machines' on qemu-system-heterogeneous, it would
>>> return all machines from all targets. To disambiguate naming there
>>> are various options
>>>
>>>  * The query-machines command would have to gain a new 'target'
>>>    field and we would have to document that uniqness is across
>>>    the tuple (name, target), not merely name. That's a semantic
>>>    change.
>>>
>>>    We would still need a way to express the 'target' when asking
>>>    to instantiate a machine
>>>
>>>  * The query-machines command would have to gain a new 'target'
>>>    paramter so callers can restrict the data they receive back
>>>
>>>    We would still need a way to express the 'target' when asking
>>>    to instantiate a machine
>>>
>>>  * Rename all machine types so they are '<target>-<machine>'
>>>    The query-machines command doesn't change. Apps would have
>>>    to "parse" the machine name to see what 'target' each is
>>>    associated with, or we include an explicit 'target' field
>>>    in the returned data. Instianting a machine would not need
>>>    changing
>>
>> I think -machine m68k:virt could work, -M help would list machines like:
>>
>> arm:raspi
>> i386:pc
>> etc.
>>
>> Management apps could easily find : to separate arch but those that don't
>> care about arch would just work and list more possible machines. Some
>> machines like pc or mac99 that may appear differently in different single
>> arch binary might need to get resolved first. Maybe need a way to search
>> machine list by pattern e.g. as -machine x86_64:help.
>
> ...except that custom structures/formats in command line args is
> something we've tried very hard to eliminate in Qemu, and instead
> model everything as a distinct fields, using QAPI, so...
>
> .. if you're meaning "arm:raspi" as a short hand for "target:machine"
>   that would be a design anti-pattern, b
>
> ...if you're meaning that "arm:raspi" is the full machine name, to be
>   strictly treated as an opaque string that would be acceptable.
>
> I rather think the latter would not end up being treated as an opaque
> string though - the tempetation to parse it & assign semantics to the
> pieces is just too great. So I'm not a fan of that approach.
>
> From a QAPI design best pratice POV, the requirement would be for
>
> -machine target=arm,name=raspi

As long as I don't have to type that and can use -M arm:raspi as a 
shorthand that's OK but then we could just make an exception for this and 
combine target and machine name here for simplicity. Unless it's simpler 
to internally use separate name and target attributes and implement a 
command line shorthand. You'll also need a way to display machine list 
with target and name in a way that's easy to parse for tools for which the 
target:name format seems like a trivial way. So I don't mind how you 
rationalise it and call all of it the machine name or if it's implemented 
as separate name and target attributes but please try to keep the command 
line something a human can use too.

Regards,
BALATON Zoltan
--3866299591-1209260455-1741274921=:53921--

