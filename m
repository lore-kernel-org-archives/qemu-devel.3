Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5149C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmK6l-0001Rt-8Z; Mon, 18 Mar 2024 17:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmK6i-0001RB-Bu
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:01:20 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmK6f-0007cg-62
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:01:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:dad:0:640:1761:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C2B96608FE;
 Tue, 19 Mar 2024 00:01:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b660::1:2d] (unknown
 [2a02:6b8:b081:b660::1:2d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id t0LCk63Ru0U0-TvBjDTvz; Tue, 19 Mar 2024 00:01:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710795666;
 bh=Un+ZBOEXfXJf2RriBtZ1el3F/h3IKWgyQ0ZVSDgNmGo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rIq6cKvmgUa3bCQczO0fVfKIveGMotn22o+Xm8vYOkdThOqykWNujUSGgW9fHyy9U
 dzck31LvCPu8uSoi1yFvEk/CY69jCTS2qaq3Y2PB4DzwULPi8Td3qtg4lH0jIRUcOU
 nO3P5aQ8OIkITCV6oD35lgv4yybn8dUcHt1fxVXk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <28e9e719-0f31-4e85-8834-9d95bd2ff0e1@yandex-team.ru>
Date: Tue, 19 Mar 2024 00:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] machine development tool
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, jsnow@redhat.com, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
 <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
 <874jdkn3he.fsf@pond.sub.org> <ZefNfJ3BwudA-M7t@x1n>
 <117b4556-aadd-4287-909c-e5cf988214b5@yandex-team.ru> <ZeqKZOxF1MlgeRE3@x1n>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <ZeqKZOxF1MlgeRE3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 3/8/24 06:47, Peter Xu wrote:
> On Thu, Mar 07, 2024 at 12:06:59PM +0300, Maksim Davydov wrote:
>> On 3/6/24 04:57, Peter Xu wrote:
>>> On Tue, Mar 05, 2024 at 03:43:41PM +0100, Markus Armbruster wrote:
>>>> Peter Maydell<peter.maydell@linaro.org>  writes:
>>>>
>>>>> On Mon, 4 Mar 2024 at 13:52, Maksim Davydov<davydov-max@yandex-team.ru>  wrote:
>>>>>> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
>>>>>>
>>>>>>     Merge tag 'pull-request-2024-03-01' ofhttps://gitlab.com/thuth/qemu  into staging (2024-03-01 10:14:32 +0000)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>     https://gitlab.com/davydov-max/qemu.git  tags/pull-compare-mt-2024-03-04
>>>>>>
>>>>>> for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
>>>>>>
>>>>>>     scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Please note. This is the first pull request from me.
>>>>>> My public GPG key is available here
>>>>>> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> scripts: add a new script for machine development
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>> Hi; I would prefer this to go through some existing submaintainer
>>>>> tree if possible, please.
>>>> Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.
>>> Yeah this seems like migration relevant.. however now I'm slightly confused
>>> on when this script should be useful.
>>>
>>> According to:
>>>
>>> https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/
>>>
>>>           This script runs QEMU to obtain compat_props of machines and
>>>           default values of different types of drivers to produce comparison
>>>           table. This table can be used to compare machine types to choose
>>>           the most suitable machine or compare binaries to be sure that
>>>           migration to the newer version will save all device
>>>           properties. Also the json or csv format of this table can be used
>>>           to check does a new machine affect the previous ones by comparing
>>>           tables with and without the new machine.
>>>
>>> In regards to "choose the most suitable machine": why do you need to choose
>>> a machine?
>>>
>>> If it's pretty standalone setup, shouldn't we always try to use the latest
>>> machine type if possible (as normally compat props are only used to keep
>>> compatible with old machine types, and the default should always be
>>> preferred). If it's a cluster setup, IMHO it should depend on the oldest
>>> QEMU version that plans to be supported.  I don't see how such comparison
>>> helps yet in either of the cases..
>>>
>>> In regards to "compare binaries to be sure that migration to the newer
>>> version will save all device properties": do we even support migrating
>>> _between_ machine types??
>>>
>>> Sololy relying on compat properties to detect device compatibility is also
>>> not reliable.  For example, see VMStateField.field_exists() or similarly,
>>> VMStateDescription.needed(), which are hooks that device can provide to
>>> dynamically decide what device state to be saved/loaded.  Such things are
>>> not reflected in compat properties, so even if compat properties of all
>>> devices are the same between two machine types, it may not mean that the
>>> migration stream will always be compatible.
>>>
>>> Thanks,
>> In fact, the last commit describes the meaning of this series best. Perhaps
>> it should have been moved to the cover letter:
>> Often, many teams have their own "machines" inherited from "upstream" to
>> manage default values of devices. This is done because of the limitations
>> imposed by the compatibility requirements or the desire to help their
>> customers better configure their devices. And since machine type has
>> a hard-to-read structure, it is very easy to make a mistake when
>> transferring
>> default values from one machine to another. For example, when some property
>> is set for the entire abstract class x86_64-cpu (which will be applied to
>> all
>> models), and then rolled back for a specific model. The situation is about
>> the same with changing the default values of devices: if the value changes
>> in the description of the device itself, then you need to make sure that
>> nothing changes when using the current machine.
>> Therefore, there was a desire to make a dev tool that will help quickly
>> expand
>> the definition of a machine or compare several machines from different
>> binary
>> files. It can be used when rebasing to a new version of qemu and/or for
>> automatic tests.
> OK, thanks.
>
> So is it a migration compatibility issue that you care (migrating VMs from
> your old downstream binary to new downstream binary should always succeed),
> or perhaps you care more on making sure the features you wanted, i.e., you
> want to make sure some specific devices that you care will have the
> properties that you expect?
>
> I think compat properties are mostly used for migration purposes, but
> indeed it can also be used to keep old behaviors of devices, even if the
> migration could succed with/without such a compat property entry.
>
> If it's about migration, I'd like to know whether vmstate-static-checker.py
> could also help your case (under scripts/), perhaps in a better way,
> because it directly observes the VMSD structures (which is the ultimate
> form on wire, after all these compat properties applied to the devices).
>
> If it's not about migration, then maybe it's more QOM-relevant, and if so I
> don't have a strong opinion. It seems still make some sense to have a tool
> simply dump the QOM tree for a machine type with all properties and compare
> them between machines with some binaries.  For that I'll leave that to
> Markus to decide.
>
> Btw, I tried to apply the patches and build, but failed:
>
> In file included from ../qapi/qapi-schema.json:70:
> ../qapi/machine.json:224: text required after 'Example:'
> [40/2810] Generating trace/trace-hw_ide.h with a custom command
> [41/2810] Generating trace/trace-hw_isa.h with a custom command
> [42/2810] Generating trace/trace-hw_intc.c with a custom command
> [43/2810] Generating trace/trace-hw_mem.h with a custom command
> [44/2810] Generating trace/trace-hw_isa.c with a custom command
> [45/2810] Generating trace/trace-hw_intc.h with a custom command
> [46/2810] Generating trace/trace-hw_mem.c with a custom command
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:162: run-ninja] Error 1
>
> There also seems to have an assumption that QEMU is built under "build/" in
> the script.
>
> +default_qemu_binary = 'build/qemu-system-x86_64'
>
Sorry for late response
This is the default value, the script has the option to redefine the path to
the binary `--qemu-binary`

-- 
Best regards,
Maksim Davydov


