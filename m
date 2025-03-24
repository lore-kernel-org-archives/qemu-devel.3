Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39860C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmei-0007fO-Q5; Mon, 24 Mar 2025 14:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1twmee-0007dP-VZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:36:10 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1twmec-0006zN-Br
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:36:08 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso8429634a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742841361; x=1743446161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5/PZ7BT+HhntyRVen9heaZkUf/s+/XZ8b7pFI4Ln3I=;
 b=hza+G0XEDYD7JpF9QDNMx9KFN9XODS4BreyH4Zd6N/0oNdZD4qDZs1/P26KjTFZW9A
 l/lAuj8IVJIoykM47XeVyaGvDrYAH11ngDAzYYmgI6e+SxeR1FRx3Phf2HzS6uFmTYVf
 QIC5sV01z1pgtf0i91HgYDWqIqaf3zudwaEnvQTDOWs4g1qFHCRQMsuqWtuhitll7TT4
 kTwvL8ECqDwDkHEE5QTI6B1Y/hzATVQVl9EbpLTlrW+a96/qHTj5Yg3N2nGlyJYb088L
 JVmmKfg0bTTfH3o09rWirEXAoZMPeiO04pEXPAgxZQyq5eTpSKvGOUIlNYCb+HJR3irC
 2fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841361; x=1743446161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5/PZ7BT+HhntyRVen9heaZkUf/s+/XZ8b7pFI4Ln3I=;
 b=SIiLgPYPkLgTOhXyqh2lUSa1tTrJoK3s0pjU/0HbYqwG9ofiyRAK0gLL51jLbCZe5K
 M6jR11zdZabWM07uTkGO4XS50Kqvv21LB3qTxJwp+yJv71nFaSrupiZ98V18e2D+pGjK
 g9JHW8lK5YtKxnHHYZviyLEuzYe9rp49j9xl5eaCapIWOG2+Iw+QrO7/okavdusGSQvD
 1J9O+m64RnGdhmT5db/FJ8DoktvovvbeQxsJxvo3GGb6S3aRsQ0+v9kCNk456kfl/pFB
 HUVuACXD9UEOYsAeTn73UaWhE37JuCYFldAtytob1sNlcVwEZVV1vSr626OEjijK2VHL
 yxTw==
X-Gm-Message-State: AOJu0Yz8sWrwSME27Wg+tDjz8dlpSyqTuwh5NxU/kTDCyPJnKYIdgBT2
 cC7uefFyGpX1w5wCj89stT2+QB3i3wY+EMnvg/Yk7VZVcgfoDkWjm8N/Qrmx0a5uQJN4QPJjOzh
 2MHYl7Pg8H51hQUWhf2YKGkBTtxA=
X-Gm-Gg: ASbGncvMAs1z62TjkUcuZkGClaGRs+6sjlnAvXQ9faMjMT04b0BpXsNXx4OLGnW9VRB
 Lk88WIgZK0/d3bEtA/3zkp7yKZHqSEmSlAx2h3QRRpPZ06q1Bjee16JYD0TPI5gV2dpa02mBMEq
 Ix1YvQnZPkf5wF4/E286f3Q4gR
X-Google-Smtp-Source: AGHT+IG26lOm1EkcEpZUzH2Cu8Z0EbUSlmEOzNpJZRNwy01djDNjDyF9yP3fuAfDZZD7nEjzd9592WihreYZV41rBus=
X-Received: by 2002:a05:6402:3214:b0:5ec:da2e:6e30 with SMTP id
 4fb4d7f45d1cf-5ecda2e6e54mr2460389a12.4.1742841360469; Mon, 24 Mar 2025
 11:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <9d87fed729b2697605bcf5b6062669b6239e5c0f.camel@linux.ibm.com>
 <CAJSP0QXqseVpaHZEfhJv7nZ8N18PGQqpW-tb9LCkGyvOKvW_zQ@mail.gmail.com>
 <38af196895ab98bafb5423cbc390a1cb79e764df.camel@linux.ibm.com>
In-Reply-To: <38af196895ab98bafb5423cbc390a1cb79e764df.camel@linux.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 24 Mar 2025 14:35:48 -0400
X-Gm-Features: AQ5f1JoOjkR0nRzUFnrRvJkBb4Abkfmm5ccWqLpMXHUO5djQgcACt1oiYVysHy8
Message-ID: <CAJSP0QX-T=8Fw=x_De2HdiNVKNQf2nTbrHp5cnUeJfFzxVONwQ@mail.gmail.com>
Subject: Re: Best practice for issuing blocking calls in response to an event
To: milesg@linux.ibm.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Fri, Mar 21, 2025 at 11:17=E2=80=AFAM Miles Glenn <milesg@linux.ibm.com>=
 wrote:
>
> On Thu, 2025-03-20 at 16:09 -0400, Stefan Hajnoczi wrote:
> > On Thu, Mar 20, 2025 at 12:34=E2=80=AFPM Miles Glenn <milesg@linux.ibm.=
com> wrote:
> > > Hello,
> > >
> > > I am attempting to simulate a system with multiple CPU
> > > architectures.  To do this I am starting a unique QEMU process for ea=
ch
> > > CPU architecture that is needed. I'm also developing some QEMU code
> > > that aids in transporting MMIO transactions across the process
> > > boundaries using sockets.
> >
> > I have CCed Phil. He has been working on heterogenous target emulation
> > and might be interested.
> >
> > > The design takes MMIO request messages off of a socket, services the
> > > request by calling address_space_ldq_be(), then sends a response
> > > message (containing the requested data) over the same
> > > socket.  Currently, this is all done inside the socket IOReadHandler
> > > callback function.
> >
> > At a high level this is similar to the vfio-user feature where a PCI
> > device is emulated in a separate process. This also involves sending
> > messages describing QEMU's MemoryRegion accesses. See the "remote"
> > machine type in QEMU to look at the code.
> >
> > > This works as long as the targeted register exists in the same QEMU
> > > process that received the request.  However, If the register exists i=
n
> > > another QEMU process, then the call to address_space_ldq_be() results
> > > in another socket message being sent to that QEMU process, requesting
> > > the data, and then waiting (blocking) for the response message
> > > containing the data.  In other words, it ends up blocking inside the
> > > event handler and even though the QEMU process containing the target
> > > register was able to receive the request and send the response, the
> > > originator of the request is unable to receive the response until it
> > > eventually times out and stops blocking.  Once it times out and stops
> > > blocking, it does receive the response, but now it is too late.
> > >
> > > Here's a summary of the stack up to where the code blocks:
> > >
> > > IOReadHandler callback
> > >   calls address_space_ldq_be()
> > >     resolves to mmio read op of a remote device
> > >       sends request over socket and waits (blocks) for response
> > >
> > > So, I'm looking for a way to handle the work of calling
> > > address_space_ldq_be(), which might block when attempting to read a
> > > register of a remote device, without blocking inside the IOReadHandle=
r
> > > callback context.
> > >
> > > I've done a lot of searches and reading about how to do this on the w=
eb
> > > and in the QEMU code but it's still not really clear to me how this
> > > should be done in QEMU.  I've seen a lot about using coroutines to
> > > handle cases like this. Is that what I should be using here?
> >
> > The fundamental problem is that address_space_ldq_be() is synchronous,
> > so there is no way to return back to the caller until the response has
> > been received.
> >
> > vfio-user didn't solve this problem. It simply blocks until the
> > response is received, but it does drop the Big QEMU Lock during this
> > time so that other vCPU threads can run. For example, see
> > hw/remote/proxy.c:send_bar_access_msg() and
> > mpqemu_msg_send_and_await_reply().
> >
> > QEMU supports nested event loops, but they come with their own set of
> > gotchas. The way a nested event loop might help here is to send the
> > request and then call aio_poll() to receive the response in another
> > IOReadHandler. This way other event loop processing can take place
> > while waiting in address_space_ldq_be().
> >
> > The second problem is that this approach where QEMU processes send
> > requests to each other needs to be implemented carefully to avoid
> > deadlocks. For example, devices that do DMA could load/store memory
> > belonging to another device handled by another QEMU. Once there is an
> > A -> B -> A situation it could deadlock.
> >
> > Both vfio-user and vhost-user have similar issues with their
> > bi-directional communication where a device emulation process can send
> > a message to QEMU while processing a message from QEMU. Deadlock can
> > be avoided if the code is structured so that QEMU is able to receive
> > new requests during the time when it is waiting for a response.
> >
> > Stefan
>
> Stefan, Thank you for the quick response and great information!
>
> I'm not sure if this is the best way, but I was able to get things
> working today using the coroutine approach.
>
> Now, the aforementioned stack looks like this:
>
> IOReadHandler callback receives request
>   enters coroutine
>     calls address_space_ldq_be()
>       resolves to mmio read op of a remote device
>         sends request
> over socket
>         detects coroutine context and
>         calls qemu_coroutine_yield() instead of blocking
>   returns to callback
>
> <time passes>
>
> IOReadHandler callback receives response
>   re-enters coroutine
>         mmio read op returns data received in response message
>     address_space_ldq_be() returns
>   coroutine completes and returns to callback
>
> While this works, I couldn't help but notice that the coroutine concept
> seems to be like a form of multithreading.  Is there some advantage to
> using coroutines over doing the work in another thread?  Does QEMU
> offer an interface that allows for a callback to queue up work that can
> be handled by another thread or a pool of threads?

Coroutines make it easier to write concurrent code in an event loop.
The alternative is to write asynchronous callback functions, which is
tedious for sequences with multiple steps that need to wait for I/O.

Coroutines do not offer parallelism, so they are not replacement for
multi-threading. QEMU is mostly event-driven rather than
multi-threaded. Usually only computation in QEMU that really needs its
own CPU runs in its own thread (vCPUs, compression, blocking syscalls
when there is no alternative, etc).

There are advantages to using coroutines: less synchronization is
necessary than with threads (you can be sure no other coroutine will
run in the same thread while your code is running) and this eliminates
most thread-safety issues. Also, event loops are seen as more scalable
than threads (lots of historical resources, for example
http://www.kegel.com/c10k.html). One QEMU-specific advantage of
coroutines: coroutine code has access to all of QEMU's APIs that
require the event loop whereas threads need to take extra steps to
interact with the rest of QEMU.

Stefan

