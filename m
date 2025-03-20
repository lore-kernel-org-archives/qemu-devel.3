Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F08C36002
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvMD9-0004lp-VL; Thu, 20 Mar 2025 16:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tvMD7-0004lU-VD
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:09:49 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tvMD2-0001BA-0Y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:09:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so1924362a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742501382; x=1743106182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Td7EFuTJ2om+RFEY5HkKdjzsPHCJqWxm4Stka7owgiY=;
 b=AEiar6ZvzPkMBx7Np2p6qNf4lHBNkDaFY8SXkRimYvBm6qQPj5sW0NWEj2WtmFxFmu
 384Xg7kD3GQhIG5ISSCvhyGtLMNw8YDQ5fyNk4L7DV/yJ4tXmJrC99bHXXIrTHklCE74
 gT1XDTgoGXhStfXpoFBZ/JTa4lca/eVwHUiM4M+Svq2GHTC6qLpL+5LnAfWIYvEjO8pc
 VtwA1X1Sd4V9j5Rcus727W2uOy6MxanBpe4xbhC2/9OXlgFd06ePCRi9ofZEsf1teNgv
 U38bm6nPFnPe4yr9SfPE4dVfQoWcKzKgsw3zcjHf9DKhvuChoM3e4Q5EdjMdrpJiYCxa
 VjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742501382; x=1743106182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Td7EFuTJ2om+RFEY5HkKdjzsPHCJqWxm4Stka7owgiY=;
 b=RysD23JPNoRTCDrjFEUfE05iN1h6TV1pIhQxEaE+sYumwuNysk/oOwpGkXFbrqhYOZ
 ws74gsLvUU+PaVYBj2xm1pFRELL1ie7PSQpQp9oyaBdOz2+FgDHp6XrJgsqCbZ/9RfnS
 EStOSoaUYrq/gQk+SbVvFvB0X4R0oxdTP1m22JGijULFiFFGz1fYG/fD9DG6C412u9X7
 tbJJ/H6kRoeNooAdu9Ov0vHPDjhl7nHdi52zbfrUfx62WwTRVXafM0MJm4+8c9Ef7G/I
 r5u9kiz3rJVndBA+O6XDljPsEvj5hGCeGGVI1yPtEWDVxjxNeQByt/zIOdteqo4PJoaz
 DpDQ==
X-Gm-Message-State: AOJu0YwibkJMJey22KQSfpMpoiSlGWBQhiO5VEmdGAuaI0e5jwiHONn5
 LPtcsuUckCwQagJjKVNjfuMoi1SpUxoQZ8hKaXlQSwp2cJgccAtqI4771/W54khwd38s46fUqsi
 NGL7WOM2EalVvftZFRpGxmGsT5JA=
X-Gm-Gg: ASbGncuusm5KSQPu18UGRlR0sjiXcIZ8B0Fl4JGe+jmTCpZ2bs1m5X8bK5ip1u5z2NR
 jmzFUl0Nyn+/NCe5p12lsysz1GQNHSxS+sSuHxsA9zB21u+y9TeWG/+XfZhff8JRtHhiW+8TuGU
 6rfReColCn4Tg47X/ORTY43sg5
X-Google-Smtp-Source: AGHT+IF3vYsrOEO4xxglMQZCM+rd/gbuWcJR87v8vHeaz+XlGE0OYvTvTLyq52krwHnOtNP8nV7/xWEuRTD3P6ug/oc=
X-Received: by 2002:a05:6402:27c6:b0:5e6:1842:1346 with SMTP id
 4fb4d7f45d1cf-5ebcd520333mr603134a12.30.1742501381372; Thu, 20 Mar 2025
 13:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <9d87fed729b2697605bcf5b6062669b6239e5c0f.camel@linux.ibm.com>
In-Reply-To: <9d87fed729b2697605bcf5b6062669b6239e5c0f.camel@linux.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 20 Mar 2025 16:09:28 -0400
X-Gm-Features: AQ5f1Jq1TfDJtoR5_ea50TTMZ9ttzb5_AKh-2U1M5686vcG6zPSMMO6P94-jTFI
Message-ID: <CAJSP0QXqseVpaHZEfhJv7nZ8N18PGQqpW-tb9LCkGyvOKvW_zQ@mail.gmail.com>
Subject: Re: Best practice for issuing blocking calls in response to an event
To: milesg@linux.ibm.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Mar 20, 2025 at 12:34=E2=80=AFPM Miles Glenn <milesg@linux.ibm.com>=
 wrote:
>
> Hello,
>
> I am attempting to simulate a system with multiple CPU
> architectures.  To do this I am starting a unique QEMU process for each
> CPU architecture that is needed. I'm also developing some QEMU code
> that aids in transporting MMIO transactions across the process
> boundaries using sockets.

I have CCed Phil. He has been working on heterogenous target emulation
and might be interested.

>
> The design takes MMIO request messages off of a socket, services the
> request by calling address_space_ldq_be(), then sends a response
> message (containing the requested data) over the same
> socket.  Currently, this is all done inside the socket IOReadHandler
> callback function.

At a high level this is similar to the vfio-user feature where a PCI
device is emulated in a separate process. This also involves sending
messages describing QEMU's MemoryRegion accesses. See the "remote"
machine type in QEMU to look at the code.

>
> This works as long as the targeted register exists in the same QEMU
> process that received the request.  However, If the register exists in
> another QEMU process, then the call to address_space_ldq_be() results
> in another socket message being sent to that QEMU process, requesting
> the data, and then waiting (blocking) for the response message
> containing the data.  In other words, it ends up blocking inside the
> event handler and even though the QEMU process containing the target
> register was able to receive the request and send the response, the
> originator of the request is unable to receive the response until it
> eventually times out and stops blocking.  Once it times out and stops
> blocking, it does receive the response, but now it is too late.
>
> Here's a summary of the stack up to where the code blocks:
>
> IOReadHandler callback
>   calls address_space_ldq_be()
>     resolves to mmio read op of a remote device
>       sends request over socket and waits (blocks) for response
>
> So, I'm looking for a way to handle the work of calling
> address_space_ldq_be(), which might block when attempting to read a
> register of a remote device, without blocking inside the IOReadHandler
> callback context.
>
> I've done a lot of searches and reading about how to do this on the web
> and in the QEMU code but it's still not really clear to me how this
> should be done in QEMU.  I've seen a lot about using coroutines to
> handle cases like this. Is that what I should be using here?

The fundamental problem is that address_space_ldq_be() is synchronous,
so there is no way to return back to the caller until the response has
been received.

vfio-user didn't solve this problem. It simply blocks until the
response is received, but it does drop the Big QEMU Lock during this
time so that other vCPU threads can run. For example, see
hw/remote/proxy.c:send_bar_access_msg() and
mpqemu_msg_send_and_await_reply().

QEMU supports nested event loops, but they come with their own set of
gotchas. The way a nested event loop might help here is to send the
request and then call aio_poll() to receive the response in another
IOReadHandler. This way other event loop processing can take place
while waiting in address_space_ldq_be().

The second problem is that this approach where QEMU processes send
requests to each other needs to be implemented carefully to avoid
deadlocks. For example, devices that do DMA could load/store memory
belonging to another device handled by another QEMU. Once there is an
A -> B -> A situation it could deadlock.

Both vfio-user and vhost-user have similar issues with their
bi-directional communication where a device emulation process can send
a message to QEMU while processing a message from QEMU. Deadlock can
be avoided if the code is structured so that QEMU is able to receive
new requests during the time when it is waiting for a response.

Stefan

