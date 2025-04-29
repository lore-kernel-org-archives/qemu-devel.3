Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51877C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jhv-0005VM-Gy; Tue, 29 Apr 2025 08:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9jhs-0005UT-UG
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:05:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9jhp-0006Fr-TW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:05:00 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7A2D455D23B;
 Tue, 29 Apr 2025 14:04:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id p3F8Upxsfi85; Tue, 29 Apr 2025 14:04:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 72C5E55C592; Tue, 29 Apr 2025 14:04:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70F53745682;
 Tue, 29 Apr 2025 14:04:52 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:04:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, 
 richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, 
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com, 
 philmd@linaro.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files
 common
In-Reply-To: <875xinnzok.fsf@pond.sub.org>
Message-ID: <c1a03806-b9f5-6301-4cc0-fcb571ed2b37@eik.bme.hu>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 29 Apr 2025, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>> On 4/28/25 4:07 AM, Markus Armbruster wrote:
>>> Peter Krempa <pkrempa@redhat.com> writes:
>>>
>>>> So what should libvirt do once multiple targets are supported?
>>>>
>>>> How do we query CPUs for each of the supported targets?
>>>>
>>
>> It's kind of a similar question we have to solve now with QEMU code.
>> What happens when a symbol is duplicated, and available only for several
>> targets?
>>
>> In this case, we found various approaches to solve this:
>> - unify this symbol for all targets (single implementation)
>> - unify all targets to provide this symbol (multiple impl, all targets)
>> - rename symbols adding {arch} suffix, so it's disambiguated by name
>> - create a proper interface which an available function (multiple impl,
>> selective targets)
>>
>> In the case of query-cpu-definitions, my intuition is that we want to
>> have a single implementation, and that we return *all* the cpus, merging
>> all architectures. In the end, we (and libvirt also) should think out of
>> the "target" box. It's an implementation detail, based on the fact QEMU
>> had 'targets' associated to various binaries for a long time and not a
>> concept that should leak into all consumers.
>>
>>>> Will the result be the same if we query them one at a time or all at
>>>> once?
>>>
>>> Pierrick's stated goal is to have no noticable differences between the
>>> single binary and the qemu-system-<target> it covers.  This is obviously
>>> impossible if we can interact with the single binary before the target
>>> is fixed.
>>>
>>
>> Right.
>> At this point, we can guarantee the target will be fixed before anything
>> else, at the start of main(). It's obviously an implementation choice,
>> but to be honest, I don't see what we would gain from having a "null"
>> default QEMU target, unable to emulate anything.
>>
>>>>> This requires fixing the target before introspection.  Unless this is
>>>>> somehow completely transparent (wrapper scripts, or awful hacks based on
>>>>> the binary's filename, perhaps), management applications may have to be
>>>>> adjusted to actually do that.
>>>>
>>>> As noted filename will not work. Users can specify any filename and
>>>> create override scripts or rename the binary.
>>>
>>> True.
>>>
>>
>> I would prefer to not open this pandora box on this thread, but don't
>> worry, the best will be done to support all those cases, including
>> renaming the binary, allowing any prefix, suffix, as long as name stays
>> unambiguous. If you rename it to qemu-ok, how can you expect anything?
>>
>> We can provide the possibility to have a "default" target set at compile
>> time, for distributors creating their own specific QEMU binaries. But in
>> the context of classical software distribution, it doesn't make any sense.
>
> I don't wish to derail this thread, but we've been dancing around the
> question of how to best fix the target for some time.  I think we should
> talk about it for real.
>
> Mind, this is not an objection to your larger "single binary" idea.  It
> could be only if it was an intractable problem, but I don't think it is.
>
> You want the single binary you're trying to create to be a drop-in
> replacement for per-target binaries.
>
> "Drop-in replacement" means existing usage continues to work.
> Additional interfaces are not a problem.
>
> To achieve "drop-in replacement", the target needs to be fixed
> automatically, and before the management application can further
> interact with it.
>
> If I understand you correctly, you're proposing to use argv[0] for that,
> roughly like this: assume it's qemu-system-<target>, extract <target>
> first thing in main(), done.
>
> What if it's not named that way?  If I understand you correctly, you're
> proposing to fall back to a compiled-in default target.
>
> I don't think this is going to fly.
>
> Developers rename the binary all the time, and expect this not to change
> behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
> qemu-FOO.COMMIT-HASH to let me compare behavior easily.

These would be handled by doing only a prefix match with strncmp instead 
of strcmp on argv[0].

> We could relax the assumption to support such renames.  Developers then
> need to be aware of what renames are supported.  Meh.
>
> The more we relax the pattern, the likelier surprising behavior becomes.
>
> We could mitigate surprises by eliminating the built-in default target.
>
> Users invoke their binaries with their own names, too.  If Joe R. User
> finds qemu-system-<joe's-fav-target> too much to type, and creates a
> symlink named q to it, more power to him!
>
> Distributions have packaged renamed binaries.  qemu-kvm has been used
> quite widely.
>
> In neither of these cases, relaxing the pattern helps.

But completely renaming is not solved even by prefix match.

> The least bad solution I can see so far is a new option -target.
>
> Instead of turning the target-specific binaries into links to / copies
> of the single binary, they become wrappers that pass -target as the
> first option.  We need to make sure this option is honored in time then,
> which should be easy enough.

I proposed before that since target (or arch because target is used in 
different senses so may be confusing) is usually tied to the board it 
could be made part of the board name. Such as ppc:g3beige or x86:pc. Then 
you can search the board list and find a match for the -machine option and 
find the arch from that. There are only a few machines that are 
problematic that behave differently based on which binary they are in and 
use different default -cpu type based on that, such as mac99 and maybe pc 
and q35 (I don't know if these x86 machines use same default cpu in 
qemu-system-i386 and qemu-system-x86_64) but those could be solved by 
deprecating this behaviour and adding different machines for each variant 
then by the time we have a single binary they would fit in this scheme.

One question is what arch to use for heterogeneous machines using multiple 
archs. Those still may have one that's considered a main arch so could be 
grouped there or we may use multi:name format for those that cannot have a 
main architecture. Or we can list them with multiple names, one for each 
arch so any of them could be used and on start to select the machine and 
the binary can check that all of the listed archs are compiled in. 
Specifying the arch for -machine would also be optional anyway unless we 
have two machines with same name but different arch which is rare.

Regards,
BALATON Zoltan

> If you invoke the single binary directly, you need to pass -target
> yourself.  If you don't to pass it, or pass it late in the command line,
> you open up a window for interaction with indeterminate target.
> Target-specific interfaces could exhibit different behavior then, even
> fail.  That's fine under "additional interfaces are not a problem".
>
> Thoughts?
>
>
>

