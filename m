Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF5EC282C6
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 01:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toBxG-0001Yx-RN; Fri, 28 Feb 2025 20:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1toBx3-0001Tr-GR; Fri, 28 Feb 2025 20:47:40 -0500
Received: from mail.csclub.uwaterloo.ca ([129.97.134.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1toBx1-00078L-0e; Fri, 28 Feb 2025 20:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=csc; t=1740793651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMQU+hwf/6FXpGH8QjvHBZ5Uf4cfHzZgiKwQI3ENW2A=;
 b=QW3AetzMfn73VdZqe/RrTWxdwuKQtnUEk7iFApG/OqeFDIcen6KnMeWa3HmyKAqUphRpNB
 /aEFQ0Bug1cdKbbE8ePjY/N4jY96Jw5YUEabNEaB4GohBKLBfk6dnT4qWB0EA+CTh3OfDo
 RcPi7imSXNP3pAOq11Xoharra895ZCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=202502e; t=1740793651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMQU+hwf/6FXpGH8QjvHBZ5Uf4cfHzZgiKwQI3ENW2A=;
 b=3pxsCk8SE+Xxk8Yd7lFr4QEcwh8uUZKi1U0uGDPc6GmABSrMIVuOQ/uIwfgvRWc9kBPjfD
 fPUyLtwGBVf1MrDg==
Content-Type: multipart/alternative;
 boundary="------------iOMpxdDDldQXtDQ0AfPpaIqr"
Message-ID: <d714a7c2-2291-4a85-abcc-81648da1ef57@csclub.uwaterloo.ca>
Date: Fri, 28 Feb 2025 20:47:31 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] bcm2838: Add GIC-400 timer interupt connections
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
References: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
 <CAFEAcA9kED+fB1repp2+r-zMfZ_5ZeAkZq2ChyxjSUo1j5gAFQ@mail.gmail.com>
 <aef79501-b99f-4e84-b6fe-14dec1e030e6@csclub.uwaterloo.ca>
 <CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com>
Content-Language: en-US
From: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
In-Reply-To: <CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com>
Received-SPF: pass client-ip=129.97.134.52;
 envelope-from=s23adhik@csclub.uwaterloo.ca; helo=mail.csclub.uwaterloo.ca
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------iOMpxdDDldQXtDQ0AfPpaIqr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-27 10:17, Peter Maydell wrote:

> On Thu, 27 Feb 2025 at 09:15, Sourojeet Adhikari
> <s23adhik@csclub.uwaterloo.ca> wrote:
>>> The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
>>> being wired up in the function bcm_soc_peripherals_common_realize()
>>> in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
>>> interrupt controller), and it isn't valid to wire one input
>>> directly to multiple outputs.
>>>
>>> In fact it looks like we are currently getting this wrong for
>>> all of the interrupts that need to be wired to both the
>>> "legacy interrupt controller" and the GIC. I think at the moment
>>> what happens is that the wiring to the GIC will happen last
>>> and this overrides the earlier wiring to the legacy interrupt
>>> controller, so code using the latter won't work correctly.
>> I'll try reading through the relevant sections and send an
>> updated patch later next week. From what I can tell it falls
>> under the bcm2835_pheripherals.c file, right?
> Yes. To expand a bit, QEMU's qemu_irq abstraction must
> always be wired exactly 1-to-1, from a single output to
> a single input. Wiring either one input to multiple outputs
> or one output to multiple inputs will not behave correctly
> (and unfortunately we don't have an easy way to assert()
> if code in QEMU gets this wrong).
>
> So for cases where you want the one-to-many behaviour you need
> to create an object of TYPE_SPLIT_IRQ. This has one input and
> multiple outputs, so you can connect your wire from device A's
> output to the splitter's input, and then connect outputs
> from the splitter to devices B, C, etc. (In this case A
> would be the timer, and B, C the two interrupt controllers.)
> Searching the source code for TYPE_SPLIT_IRQ will give some
> places where it's used. (Ignore the qdev_new(TYPE_SPLIT_IRQ)
> ones, those are a code pattern we use in board models, not
> in SoC device models.)
>
> In this specific bcm2838 case, it's a little more awkward,
> because one of the two interrupt controllers is created inside
> bcm2835_peripherals.c and one of them is created outside it.
> Since bcm2838 is already reaching inside the bcm2835_peripherals
> object I guess the simplest thing is:
>   * create a splitter object in bcm2835_peripherals.c for
>     every IRQ line that needs to be connected to both
>     interrupt controllers (probably easiest to have an array
>     of splitter objects, irq_splitter[])
>   * in bcm2835_peripherals.c, connect the device's outbound
>     IRQ to the input of the appropriate splitter, and
>     connect output 0 of that splitter to the BCM2835_IC
>     correct interrupt controller input
>   * in bcm2838.c, connect output 0 of ps_base->irq_splitter[n]
>     to the correct GIC input
>
> (This is kind of breaking the abstraction layer that ideally
> exists where the code that creates and uses a device doesn't
> try to look "inside" it at any subparts it might have. We
> could, for instance, instead make the bcm2835_peripherals
> object expose its own qemu_irq outputs which were the second
> outputs of the splitters, so that the bcm2838.c code wasn't
> looking inside and finding the splitters directly. But I
> think that's more awkward than it's worth. It's also possible
> that we have the split between the main SoC and the
> peripheral object wrong and either both interrupt controllers
> or neither should be inside the peripheral object; but
> reshuffling things like that would be a lot of work too.)

This weekend I'll try my best to mess around, and get the solution
you proposed working. From what I can tell, I (personally) think , the not-reshuffling things approach might be a bit better here. Since otherwise it'd turn into a somewhat sizeable patch pretty quick, and is a lot of work, for something that's not *too* big of an issue. I do have access to a raspberry pi if you think I should do any kind of testing before doing the reshuffling.

On another note, do you think it's reasonable to add what you said here into the development documentation (paraphrased, and if not already documented). If I do write a patch to the documentation, can/should I cc you on it?

> (PS: for the other "not 1:1" case, where you want to connect
> many qemu_irqs outputs together into one input, the usual semantics
> you want is to logically-OR the interrupt lines together, and
> so you use TYPE_OR_IRQ for that.)

(oh oki, I'll make sure to do that on the upcoming patch then,
thank you!)

(P.S the patch probably won't be coming till next week since I have quite a bit of work outside of my programming stuff to do. Should hopfully be done by Wednesday next week though?)

--------------iOMpxdDDldQXtDQ0AfPpaIqr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="monospace">On 2025-02-27 10:17, Peter Maydell wrote:</font></p>
    <blockquote type="cite"
cite="mid:CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, 27 Feb 2025 at 09:15, Sourojeet Adhikari
<a class="moz-txt-link-rfc2396E" href="mailto:s23adhik@csclub.uwaterloo.ca">&lt;s23adhik@csclub.uwaterloo.ca&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The systmr INTERRUPT_TIMER0..3 sysbus IRQ outputs are already
being wired up in the function bcm_soc_peripherals_common_realize()
in hw/arm/bcm2835_peripherals.c (to the TYPE_BCM2835_IC
interrupt controller), and it isn't valid to wire one input
directly to multiple outputs.

In fact it looks like we are currently getting this wrong for
all of the interrupts that need to be wired to both the
"legacy interrupt controller" and the GIC. I think at the moment
what happens is that the wiring to the GIC will happen last
and this overrides the earlier wiring to the legacy interrupt
controller, so code using the latter won't work correctly.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">I'll try reading through the relevant sections and send an
updated patch later next week. From what I can tell it falls
under the bcm2835_pheripherals.c file, right?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yes. To expand a bit, QEMU's qemu_irq abstraction must
always be wired exactly 1-to-1, from a single output to
a single input. Wiring either one input to multiple outputs
or one output to multiple inputs will not behave correctly
(and unfortunately we don't have an easy way to assert()
if code in QEMU gets this wrong).

So for cases where you want the one-to-many behaviour you need
to create an object of TYPE_SPLIT_IRQ. This has one input and
multiple outputs, so you can connect your wire from device A's
output to the splitter's input, and then connect outputs
from the splitter to devices B, C, etc. (In this case A
would be the timer, and B, C the two interrupt controllers.)
Searching the source code for TYPE_SPLIT_IRQ will give some
places where it's used. (Ignore the qdev_new(TYPE_SPLIT_IRQ)
ones, those are a code pattern we use in board models, not
in SoC device models.)

In this specific bcm2838 case, it's a little more awkward,
because one of the two interrupt controllers is created inside
bcm2835_peripherals.c and one of them is created outside it.
Since bcm2838 is already reaching inside the bcm2835_peripherals
object I guess the simplest thing is:
 * create a splitter object in bcm2835_peripherals.c for
   every IRQ line that needs to be connected to both
   interrupt controllers (probably easiest to have an array
   of splitter objects, irq_splitter[])
 * in bcm2835_peripherals.c, connect the device's outbound
   IRQ to the input of the appropriate splitter, and
   connect output 0 of that splitter to the BCM2835_IC
   correct interrupt controller input
 * in bcm2838.c, connect output 0 of ps_base-&gt;irq_splitter[n]
   to the correct GIC input

(This is kind of breaking the abstraction layer that ideally
exists where the code that creates and uses a device doesn't
try to look "inside" it at any subparts it might have. We
could, for instance, instead make the bcm2835_peripherals
object expose its own qemu_irq outputs which were the second
outputs of the splitters, so that the bcm2838.c code wasn't
looking inside and finding the splitters directly. But I
think that's more awkward than it's worth. It's also possible
that we have the split between the main SoC and the
peripheral object wrong and either both interrupt controllers
or neither should be inside the peripheral object; but
reshuffling things like that would be a lot of work too.)
</pre>
    </blockquote>
    <p><font face="monospace">This weekend I'll try my best to mess
        around, and get the solution<br>
        you proposed working<span style="white-space: pre-wrap">. From what I can tell, I (personally) think
, the not-reshuffling things approach might be a bit better here.
Since otherwise it'd turn into a somewhat sizeable patch pretty
quick, and is a lot of work, for something that's not *too* big
of an issue.
I do have access to a raspberry pi if you think I should do any
kind of testing before doing the reshuffling. </span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">On another note, do you think it's reasonable to add what you said
here into the development documentation (paraphrased, and if not 
already documented). If I do write a patch to the documentation,
can/should I cc you on it?
</span></font></p>
    <blockquote type="cite"
cite="mid:CAFEAcA9ht=T_XqKaKB-PaNK9joQFYgks37JHjqUO-qkaNe7YUQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">(PS: for the other "not 1:1" case, where you want to connect
many qemu_irqs outputs together into one input, the usual semantics
you want is to logically-OR the interrupt lines together, and
so you use TYPE_OR_IRQ for that.)</pre>
    </blockquote>
    <p><font face="monospace">(oh oki, I'll make sure to do that on the
        upcoming patch then, <br>
        thank you!)</font></p>
    <p><span style="white-space: pre-wrap"><font face="monospace">(P.S the patch probably won't be coming till next week since I have 
quite a bit of work outside of my programming stuff to do.
Should hopfully be done by Wednesday next week though?)
</font></span></p>
  </body>
</html>

--------------iOMpxdDDldQXtDQ0AfPpaIqr--

