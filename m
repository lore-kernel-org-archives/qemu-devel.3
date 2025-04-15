Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BAEC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bJm-0002Z0-Ri; Tue, 15 Apr 2025 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u4bJi-0002YH-Fq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:06:50 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u4bJg-0001CE-9t
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:06:50 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id D742D1508CED8;
 Tue, 15 Apr 2025 10:06:29 +0200 (CEST)
Message-ID: <56d61e87-ed3e-4bcf-8334-e3d3ffb714a7@lauterbach.com>
Date: Tue, 15 Apr 2025 10:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, christian.boenig@lauterbach.com
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org> <87a58qj3ay.fsf@draig.linaro.org>
 <87ldsakgp9.fsf@pond.sub.org> <87y0wahh65.fsf@draig.linaro.org>
 <87mscqiut6.fsf@pond.sub.org>
 <b610c46f-3137-4fc9-a80a-6855e5884c6c@lauterbach.com>
 <875xjdheaj.fsf@draig.linaro.org> <8734ehbm71.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <8734ehbm71.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1744704389887
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 09.04.2025 13:37, Markus Armbruster wrote:

> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>
>>> On 08.04.2025 16:37, Markus Armbruster wrote:
> 
> [...]
> 
>>>> Use of QAPI/QMP does not imply use of the QMP monitor.  We can keep the
>>>> monitor and the debugging interface separate even though both are based
>>>> on QAPI/QMP.
>>>>
>>>> The monitor code is gnarly, I'm afraid.  It supports multiple monitors,
>>>> but they are not fully independent for historical reasons, chiefly
>>>> implied mutual exclusion for commands.  Adding a QAPI/QMP-based
>>>> debugging interface without undue coupling to monitors may pose a few
>>>> technical problems.  One way to find out.
>>>
>>> If I understand you correctly, when QAPI-MCD runs on a separate socket
>>> without using a monitor, it's still coupled to the monitor code
>>> internally? Does this have an influence on the either the usage of a
>>> monitor or the MCD interface or is it rather an implementation detail?
>>
>> An implementation detail - we should try and avoid needless coupling if
>> we can though.
>>
>> AFAIK not all monitor commands map to QMP equivalents but I'm not sure
>> if that's true the other way around - can you do everything you can over
>> QMP under HMP? If you don't have to then that implies we can over a
>> separate schema on a debug socket that doesn't need monitor bits tied
>> in.
> 
> Ideally, HMP commands are human-friendly wrappers around QMP commands.
> Such commands can't do anything that could be done with QMP.
> 
> Not all the functionality of QMP needs to be exposed in HMP.  Some
> functionality might only exist in QMP.  How much to expose is a
> pragmatic "is it worth the bother?" decision.
> 
> Certain HMP commands make no sense in QMP.  Examples:
> 
> * HMP cpu sets the default CPU.  The concept doesn't exist in QMP.
> 
> * Ad hoc debugging commands that are used only by humans, such as
>   sync-profile.
> 
> * The desk calculator[*]
> 
> My abstract mental model of MCD has it completely separate from monitors
> (HMP and QMP).  Just like gdbstub.
> 
> We're considering to use QAPI/QMP as interface definition and transport
> infrastructure.
> 
> Mario's patches do that in a simple way: by "embedding" MCD in the QMP
> monitor.  This creates a coupling that doesn't exist in my abstract
> mental model.
> 
> We could have a separate QAPI schema for interface definition, and a
> separate socket for transport.  This avoids coupling.
> 
> Obviously, we'd still want to reuse existing QMP infrastructure as much
> as practical.  Some of that that code is gnarly.  If we're not careful,
> we get some subtle coupling deep under the hood.
> 
> Here's one possible complication.  While we can have any number of QMP
> monitors, we still funnel most[**] commands to the main loop thread,
> where they run one after the other.  If we reuse all that machinery for
> MCD, we end up forcing MCD commands through the same funnel to the main
> loop thread.  This coupling could be undesirable.

I think now we understand each other. Let me try to rephrase: We're
trying to add a QEMU "debug" monitor which is used to debug the emulated
system. The debug monitor is built on the MCD API as the debug protocol
and QMP as the transport protocol and runs in parallel to the QEMU
monitor which is used to control the emulator. Since the QEMU monitor is
also built on QMP, we can reuse as much as possible from its QMP code
but have to be careful not to add any coupling that goes beyond the
transport layer.

If I understood you correctly, I would feel prepared to go to work and
try it out. If problems come up, I would get back to you.

> Before we contemplate how to press the existing QMP infrastructure into
> service for MCD, we should first figure out how we'd want MCD to operate
> if we started on a green field.  Can we have more than one MCD
> connection?

There are two types of connections in MCD. mcd_open_server_f opens the
connection to the MCD implementation, i.e. mcdserver, and initializes
mcdserver's core database. The actual debugging is performed over core
connections opened by mcd_open_core_f. Each core connection will be
identified by a pointer to a mcd_core_st object in the MCD API and by an
uint32_t holding a unique identifier over the RPC protocol.

In homogeneous multi-core systems, we can get away with one server
connection and multiple core connections. In heterogeneous systems, we
need multiple server connections since most likely multiple debuggers
have to be connected to QEMU simultaneously.

While there are use-cases to opening multiple connections to the same
core at once, I would propose to keep this is as a future option but not
to include this in the initial commits since it considerably complicates
things.

> Which thread should execute MCD commands?

Since both gdbserver and QMP monitor run in the main thread, I don't see
a reason why not to run the mcdserver in there as well.

> Any locking requirements?

As there are no explicit locks in gdbstub.c, I assume they are enforced
by QEMU's infrastructure.

> Any need for asynchronous commands?

No, none that I'm aware of.

> [*] Which arguably makes no sense in HMP either.
> 
> [**] Not out-of-band commands.  You probably don't want to know more.



