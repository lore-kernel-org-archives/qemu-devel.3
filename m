Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB81C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ckt-0006MS-64; Tue, 22 Apr 2025 08:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7Cke-0006Gf-Aj
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:29:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7Ckb-0004vb-7w
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:29:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E911855D230;
 Tue, 22 Apr 2025 14:29:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 5S1LtgnTZeZW; Tue, 22 Apr 2025 14:29:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BFC8C55C592; Tue, 22 Apr 2025 14:29:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BDAF2745682;
 Tue, 22 Apr 2025 14:29:14 +0200 (CEST)
Date: Tue, 22 Apr 2025 14:29:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
In-Reply-To: <877c3c7ead.fsf@pond.sub.org>
Message-ID: <a2181385-7909-d5e6-a794-ae34600a7c6f@eik.bme.hu>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org> <878qnsagfo.fsf@pond.sub.org>
 <b846a12d-bbe3-4a88-aecd-b62cd57d297d@linaro.org>
 <877c3c7ead.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1188720983-1745324954=:48919"
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

--3866299591-1188720983-1745324954=:48919
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 22 Apr 2025, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>> On 22/4/25 07:55, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> The QAPI-generated 'TargetInfo' structure name is only used
>>>> in a single file. We want to heavily use another structure
>>>> similarly named. Rename the QAPI one, since structure names
>>>> are not part of the public API.
>>>>
>>>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>   qapi/machine.json          | 12 ++++++------
>>>>   hw/core/machine-qmp-cmds.c |  4 ++--
>>>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>> index a6b8795b09e..3246212f048 100644
>>>> --- a/qapi/machine.json
>>>> +++ b/qapi/machine.json
>>>> @@ -275,15 +275,15 @@
>>>>  { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>>>>
>>>>  ##
>>>> -# @TargetInfo:
>>>> +# @BinaryTargetInfo:
>>>>  #
>>>> -# Information describing the QEMU target.
>>>> +# Information describing the QEMU binary target.
>>>
>>> What's "the QEMU binary target"?  The QEMU binary's target?
>>
>> For me 'qemu-system-aarch64' is a QEMU binary,
>
> Makes sense to me.
>
>>                                                but for Pierrick and
>> Richard it is the QEMU target,
>
> Make about as much sense to me as calling my /usr/bin/gcc "the GNU C
> compiler target", i.e. none.  It's the GNU C compiler targeting x86_64.

There's some explanation on different usages of target in
https://www.qemu.org/docs/master/devel/tcg-ops.html
maybe that explains different views.

Regards,
BALATON Zoltan

>>                                so I merged both names ¯\_(ツ)_/¯
>
> If it gets your patch merged...
>
>> This structure describes the static target configuration built into
>> a binary, i.e. TARGET_NAME=aarch64, TARGET_BIG_ENDIAN=false.
>>
>> For the forthcoming single/heterogeneous binary, we don't have a
>> particular restricted configuration in the binary.
>>
>> What about "Information describing the QEMU target configuration
>> built in a binary."?
>
> That's better.  Here's my try: "Information on the target configuration
> built into the QEMU binary."
>
>>>  From the QMP user's point of view, perhaps "the QEMU process's target"
>>> would make more sense.
>>
>> So maybe ProcessTargetInfo is a better structure name.
>
> QemuTargetInfo would sidestep binary vs. process.
>
>> For heterogeneous target I suppose we'll return SYS_EMU_TARGET_HETERO
>> and we'll provide new QMP commands, possibly returning array of
>> ProcessTargetInfo.
>
> [...]
>
>
>
--3866299591-1188720983-1745324954=:48919--

