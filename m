Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D244E7AD77
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 03:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYyIe-00076S-Ma; Thu, 25 Dec 2025 22:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vYyId-00076G-7f
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 22:15:31 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vYyIb-0000ch-4Z
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 22:15:30 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so1270932066b.3
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 19:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766718927; x=1767323727; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmGwsZlUmGKGwr+/F+mvvbtK62FHC4lhHRR+r5d0cBk=;
 b=LbIzjzZ8kALhsrPRHj6N9etg6GTwpU9m8iphQ/Cx6gy1HjbOKsfiZ+UZ91CB6SLv4N
 CXs1+wsXTzrqu/GpdzU6vSXeNuErBbw95Bk/OZW/sLmReoQGRxqnKa+peZuezpAsC4uV
 9xTulIGVZPx2/W6JSKorD5gMPA1wbcN0iUGr9uNMmk1g+ZDIwHLG7DHR53Gr28h0YZes
 8qilQn363LpCpKYowY8OUhZcVCWdasdLWtU8tPweC9CPsCc4bqX+b2Hx1Pr+JxiIIBFY
 xjqQCgpzcX26Zo8vwdD15E3cOY67rMxvCHvLACvPaHPW/tRkZ8u8ZQdJCP07XLo/VRLt
 97Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766718927; x=1767323727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmGwsZlUmGKGwr+/F+mvvbtK62FHC4lhHRR+r5d0cBk=;
 b=iEt5J+N0qR3zsoW0CRCHC9KU/QFanjdnyo5Wnrp2dEuyoVkFqEp7TDJrZ4DK8C9gai
 ZtNpeLSg/aziE/mfxpFPVQws7a/04lo3HIzBY8emfanalDTVfMXMUuqSlMEb8W1yg3Lh
 R/t9hnbtaxxG6z/Ht72GaDhdIwJwcgY7xVAvbIlmKYbXDp2gRrOB4l83msCt/JI+0kop
 RtuL39//xY5eG7Z32tg5vfMInlSAw+kHZek2Kq9+FTO0G9/5qTAdDBbBhg5t8i1mFmFC
 qZWJjWQWpAF98vx82BjolOM05cs6EILwqy4/aTr1tVK2RiIm/h4fGsBCn/1HFTypSx36
 /fXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6j4Vk9oQO4xEMSzpQo1UWp9SWbY7XGBTB9ScKCQegra9lJD7TVyb3D5BjkY6Kbh6S2S6ICEQQ6SoA@nongnu.org
X-Gm-Message-State: AOJu0YzaUuEzq2flU43z/Yr7aiysEZGbVeeHuprvL+DZyvXZyquYkXeJ
 Zq0uJLrK0y15x70EC+QX4GuWQ1jOStS+UgxaXOQnOdXqym1VKplOajuh9G+l/pzPa3Rj4HblpLi
 Cjg6KLw3Py3Q2X4u0FeFWxtsrJdT3yQQ=
X-Gm-Gg: AY/fxX5bIgnsjB/NQN4sjnlYsa6GKuRM1nd611BN0f4ONx+xehNHm6MJo0LnjOo6gdg
 YE8evjnLUNjKAwPN5QR8T8SSRY7Wv9Q5waKf9PVYgyxv7VNn210N4TLwTkMQSUwv8zJcQ5xHYQb
 y4BPolWvcPWszoHBk3x88d51zB1WjRaEpeS9hP2rIKF14MuKwyyGBobW16JRiTtO7pJPKBviL4N
 IU0nWgX8Ys/4qVodT6Ij0AJUYvYU29Dt9VnlDH4zJm8yf40AtHNWeMQiXg8nxpk55tgyAHEI85X
 InXVMQ==
X-Google-Smtp-Source: AGHT+IEzCQgjLYaDyF0qOUHn22xrcoQuJPSXvMeQdZrZrsb74ICkQNye9RYySsuKkIA5d8POGxTmtjxOF8buTVOVpp8=
X-Received: by 2002:a17:907:9303:b0:b83:1340:1a2c with SMTP id
 a640c23a62f3a-b8313401b75mr546096766b.64.1766718926953; Thu, 25 Dec 2025
 19:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
 <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
In-Reply-To: <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 26 Dec 2025 11:14:49 +0800
X-Gm-Features: AQt7F2o4K5OFBs3t2W8XzYMDfUy6HUdA5_v8ewK9GBBS6tV6i1-DpfyoNgsKFjw
Message-ID: <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62b.google.com
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

On Fri, Dec 26, 2025 at 9:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > Add test_change_interval_timer to verify that modifying the 'interval=
'
> > > property of filter-buffer at runtime takes effect immediately.
> > >
> > > The test uses socket backend and filter-redirector to verify timer be=
havior:
> > > - Creates filter-buffer with a very long interval (1000 seconds)
> > > - Sends a packet which gets buffered
> > > - Advances virtual clock by 1 second, verifies packet is still buffer=
ed
> > > - Changes interval to 1ms via qom-set (timer should be rescheduled)
> > > - Advances virtual clock by 2ms, verifies packet is now released
> > > - This proves the timer was rescheduled immediately when interval cha=
nged
> > >
> > > The test uses filter-redirector to observe when packets are released
> > > by filter-buffer, providing end-to-end verification of the timer
> > > rescheduling behavior.
> >
> > If user try to simulate network latency by filter-buffer, the accuracy
> > of time is important.
> > Do we need add some note about the first buffered packet time not
> > equel to dynamic
> > changed time (default interval time - new qmp cmd effected time +
> > changed time ?).
>
> I'm not sure I will get here, we can't forcast when the first packet
> will come. So the behaviour is always that the filter-buffer will
> flush at a fixed interval. Or I may miss something here.

This case same like this test, before change the user target interval time,
filter-buffer maybe already buffered lots of packets, for this parts, the u=
ser
external measured time did not meet the expected settings.

>
> >
> > Another issue is what level of stable accuracy the QEMU filter-buffer
> > can be achieved in actual testing?
>
> We use qemu_clock_get_us() so it's the us actually?

Yes, this is our expectation, but in actual operation, there may be
many interferences.
For example user setup filter-buffer interval to 100us, even on the
same physical machine
host to guest, external client may get test result as 110us(like ping).


>
> > Maybe need to tell user recommended test range?
>
> Could you elaborate more on this?

Based on the above statement, is it necessary to provide an empirical value
for the time range, such as 10us(like 100us --> 110us)?

Thanks
Chen


>
> Thanks
>
> >
> > Thanks
> > Chen
> >
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  tests/qtest/meson.build          |   1 +
> > >  tests/qtest/test-filter-buffer.c | 169 +++++++++++++++++++++++++++++=
++
> > >  tests/qtest/test-netfilter.c     |   3 +
> > >  3 files changed, 173 insertions(+)
> > >  create mode 100644 tests/qtest/test-filter-buffer.c
> > >
> > > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > > index 669d07c06b..ffa85ba984 100644
> > > --- a/tests/qtest/meson.build
> > > +++ b/tests/qtest/meson.build
> > > @@ -46,6 +46,7 @@ qtests_cxl =3D \
> > >  #        for the availability of the default NICs in the tests
> > >  qtests_filter =3D \
> > >    (get_option('default_devices') and slirp.found() ? ['test-netfilte=
r'] : []) + \
> > > +  (get_option('default_devices') and host_os !=3D 'windows' ? ['test=
-filter-buffer'] : []) + \
> > >    (get_option('default_devices') and host_os !=3D 'windows' ? ['test=
-filter-mirror'] : []) + \
> > >    (get_option('default_devices') and host_os !=3D 'windows' ? ['test=
-filter-redirector'] : [])
> > >
> > > diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filt=
er-buffer.c
> > > new file mode 100644
> > > index 0000000000..441cbb975c
> > > --- /dev/null
> > > +++ b/tests/qtest/test-filter-buffer.c
> > > @@ -0,0 +1,169 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * QTest testcase for filter-buffer
> > > + *
> > > + * Copyright (c) 2025 Red Hat, Inc.
> > > + * Author: Jason Wang <jasowang@redhat.com>
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "libqtest.h"
> > > +#include "qobject/qdict.h"
> > > +#include "qemu/iov.h"
> > > +#include "qemu/sockets.h"
> > > +
> > > +/*
> > > + * Test that changing interval at runtime affects packet release tim=
ing.
> > > + *
> > > + * Traffic flow with filter-buffer and filter-redirector:
> > > + *
> > > + * test side                        | qemu side
> > > + *                                  |
> > > + * +--------+                       | +---------+
> > > + * |  send  +------------------------>| backend |
> > > + * | sock[0]|                       | +----+----+
> > > + * +--------+                       |      |
> > > + *                                  | +----v----+
> > > + *                                  | |  fbuf0  | filter-buffer (que=
ue=3Dtx)
> > > + *                                  | +----+----+
> > > + *                                  |      |
> > > + *                                  | +----v----+  +----------+
> > > + *                                  | |   rd0   +->| chardev0 |
> > > + *                                  | +---------+  +----+-----+
> > > + *                                  |                   |
> > > + * +--------+                       |                   |
> > > + * |  recv  |<--------------------------------------+
> > > + * |  sock  |                       |
> > > + * +--------+                       |
> > > + *
> > > + * The test verifies that when interval is changed via qom-set, the =
timer
> > > + * is rescheduled immediately, causing buffered packets to be releas=
ed
> > > + * at the new interval rather than waiting for the old interval to e=
lapse.
> > > + */
> > > +static void test_change_interval_timer(void)
> > > +{
> > > +    QTestState *qts;
> > > +    QDict *response;
> > > +    int backend_sock[2], recv_sock;
> > > +    int ret;
> > > +    char send_buf[] =3D "Hello filter-buffer!";
> > > +    char recv_buf[128];
> > > +    char sock_path[] =3D "filter-buffer-test.XXXXXX";
> > > +    uint32_t size =3D sizeof(send_buf);
> > > +    uint32_t len;
> > > +
> > > +    size =3D htonl(size);
> > > +
> > > +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> > > +    g_assert_cmpint(ret, !=3D, -1);
> > > +
> > > +    ret =3D mkstemp(sock_path);
> > > +    g_assert_cmpint(ret, !=3D, -1);
> > > +
> > > +    /*
> > > +     * Start QEMU with:
> > > +     * - socket backend connected to our socketpair
> > > +     * - filter-buffer with a very long interval (1000 seconds)
> > > +     * - filter-redirector to send released packets to a chardev soc=
ket
> > > +     *
> > > +     * queue=3Dtx intercepts packets going from backend to the guest=
,
> > > +     * i.e., data we send from the test side.
> > > +     */
> > > +    qts =3D qtest_initf(
> > > +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> > > +        "-chardev socket,id=3Dchardev0,path=3D%s,server=3Don,wait=3D=
off "
> > > +        "-object filter-buffer,id=3Dfbuf0,netdev=3Dqtest-bn0,"
> > > +        "queue=3Dtx,interval=3D1000000000 "
> > > +        "-object filter-redirector,id=3Drd0,netdev=3Dqtest-bn0,"
> > > +        "queue=3Dtx,outdev=3Dchardev0",
> > > +        backend_sock[1], sock_path);
> > > +
> > > +    /* Connect to the chardev socket to receive redirected packets *=
/
> > > +    recv_sock =3D unix_connect(sock_path, NULL);
> > > +    g_assert_cmpint(recv_sock, !=3D, -1);
> > > +
> > > +    /* Send a QMP command to ensure chardev connection is establishe=
d */
> > > +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> > > +
> > > +    /*
> > > +     * Send a packet from the test side.
> > > +     * It should be buffered by filter-buffer.
> > > +     */
> > > +    struct iovec iov[] =3D {
> > > +        {
> > > +            .iov_base =3D &size,
> > > +            .iov_len =3D sizeof(size),
> > > +        }, {
> > > +            .iov_base =3D send_buf,
> > > +            .iov_len =3D sizeof(send_buf),
> > > +        },
> > > +    };
> > > +
> > > +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + size=
of(send_buf));
> > > +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> > > +
> > > +    /*
> > > +     * Advance virtual clock by 1 second (1,000,000,000 ns).
> > > +     * This is much less than the 1000 second interval, so the packe=
t
> > > +     * should still be buffered.
> > > +     */
> > > +    qtest_clock_step(qts, 1000000000LL);
> > > +
> > > +    /* Try to receive with non-blocking - should fail (packet still =
buffered) */
> > > +    ret =3D recv(recv_sock, recv_buf, sizeof(recv_buf), MSG_DONTWAIT=
);
> > > +    g_assert_cmpint(ret, =3D=3D, -1);
> > > +    g_assert(errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK);
> > > +
> > > +    /*
> > > +     * Now change the interval to 1000 us (1ms) via qom-set.
> > > +     * This should reschedule the timer to fire in 1ms from now.
> > > +     */
> > > +    response =3D qtest_qmp(qts,
> > > +                         "{'execute': 'qom-set',"
> > > +                         " 'arguments': {"
> > > +                         "   'path': 'fbuf0',"
> > > +                         "   'property': 'interval',"
> > > +                         "   'value': 1000"
> > > +                         "}}");
> > > +    g_assert(response);
> > > +    g_assert(!qdict_haskey(response, "error"));
> > > +    qobject_unref(response);
> > > +
> > > +    /*
> > > +     * Advance virtual clock by 2ms (2,000,000 ns).
> > > +     * This exceeds the new 1ms interval, so the timer should fire
> > > +     * and release the buffered packet.
> > > +     *
> > > +     * If the interval change didn't take effect immediately, we wou=
ld
> > > +     * still be waiting for the original 1000 second interval to ela=
pse,
> > > +     * and the packet would not be released.
> > > +     */
> > > +    qtest_clock_step(qts, 2000000LL);
> > > +
> > > +    /*
> > > +     * Now we should be able to receive the packet through the redir=
ector.
> > > +     * The packet was released by filter-buffer and sent to filter-r=
edirector,
> > > +     * which forwarded it to the chardev socket.
> > > +     */
> > > +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> > > +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> > > +    len =3D ntohl(len);
> > > +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> > > +
> > > +    ret =3D recv(recv_sock, recv_buf, len, 0);
> > > +    g_assert_cmpint(ret, =3D=3D, len);
> > > +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> > > +
> > > +    close(recv_sock);
> > > +    close(backend_sock[0]);
> > > +    unlink(sock_path);
> > > +    qtest_quit(qts);
> > > +}
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +    g_test_init(&argc, &argv, NULL);
> > > +    qtest_add_func("/netfilter/change_interval_timer",
> > > +                   test_change_interval_timer);
> > > +    return g_test_run();
> > > +}
> > > diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilte=
r.c
> > > index 326d4bd85f..b7271055d6 100644
> > > --- a/tests/qtest/test-netfilter.c
> > > +++ b/tests/qtest/test-netfilter.c
> > > @@ -10,7 +10,10 @@
> > >
> > >  #include "qemu/osdep.h"
> > >  #include "libqtest-single.h"
> > > +#include "libqtest.h"
> > >  #include "qobject/qdict.h"
> > > +#include "qemu/iov.h"
> > > +#include "qemu/sockets.h"
> > >
> > >  /* add a netfilter to a netdev and then remove it */
> > >  static void add_one_netfilter(void)
> > > --
> > > 2.34.1
> > >
> >
>

