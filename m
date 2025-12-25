Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69B9E7AD42
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 10:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYiYy-0004iz-D3; Thu, 25 Dec 2025 05:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vYiYw-0004i6-GW
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 05:27:18 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vYiYu-00051O-4X
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 05:27:18 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso975619566b.1
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 02:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766658433; x=1767263233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDe9eMVN1fKi7Q/iyHYrVj8/ySf3l14AB41Q+XQkkuw=;
 b=fz95V40jfsouEAw8U185PvSCIZ7+225XTHEYuK6W5W5qa6t8j9aZQhNG0NReCcWbz3
 514r9eDUYpdx2Ghr3ezcrJNEvkgyJd2w0Fv9ecnt8TcX1HoTKgIK7b9ToKohvrcWrW3j
 XqaYKq1zQJwqjrJSquyGlEBHL6P6oDdOP7S3eLdnB8nxZTt+bXyuX4XXxPx2kJ/shuYc
 ZqagUDGpoYYVHjP53b26jo9gKKfqyviPKmFhpq5BBFNEDNWR/7JL8Vto45HYVaCAfalU
 odn8ESc7SFlBlPIc7ac0Ee7NkAUe/GiBW8XJWv6oVYXHu0mM4LmGbR8FkdtnTQY47d0h
 AJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766658433; x=1767263233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yDe9eMVN1fKi7Q/iyHYrVj8/ySf3l14AB41Q+XQkkuw=;
 b=Br786az/wz40hiOYzDsvbgw6aHwPgT7CJafOgJ37SXG+WUj3iiYt1go9W0LKESXGrQ
 JCz3cCJvSX72FeoZbO2VHZp8Y/l6hNUD/gwE3Of8YNml6XTY/QLrEuhu4lPmgT5dHnQh
 5Z00DTvmeK1HX5VxzpzouUFTw3+v/UJHmlbroOB/QkkyYW5cOTejuEjZIJyqmJ+7JJkR
 9zAQdLsP27pZVYYowRazJYsRSnEoAS1U5VGle8E/+Jdz/UhPmdQLNsOLeQnanhebg8LK
 RFpugBpNVQ+0BJSVhcJrNr2iM/7q3N7biKlZu8GnlV7zz3Jt23nmWqDdrfLCNQGtEXul
 rcOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtlKgs27OXKUxBNm1+NlcmHbykwq+aDN48/hGj+xtHASw6jP25M2jQ2c8frmOD3nK0kKhCsOjp32Z7@nongnu.org
X-Gm-Message-State: AOJu0YwwxmRz/1Y0+AlIE7JoOlz7Un6TsN+PYZMQyQig0oqtX/3HOx6n
 IUwvjY8DVxkb2RYx3jipz/JnDMkhQduLltLcjNYctz0beVZ4wqPULODfDzZFzOY+vN717AhBV51
 knKq9m9Sd5Mw3MRyEeNZui8c3W/hh/4Y=
X-Gm-Gg: AY/fxX7PNTGUgl58NdVAuzrqWoKrfx1SNVIk8uaysQeQiEx843ngDu/9XzVVgkCycnx
 wXIS7kQFsn+hcq1OX+FG2LT7oPQ/R8AZ1Ssk7Q/ChRk9iMy2mtIbqNz4zbcde/p42iGZtBuIvkX
 zotOTVuCmbcna/CfGVBFagPnPz1koG0PYz6LMxZbuCAFpUedGqXKZVDgNJST59CqaQ07pQCbWOZ
 Fwl/wkAKg8s2ncmkZhJZZyTIH9teMKZgNUsBpfjR3ch4AJ010/Q4vATKN6YjjLlQwrH3HHR
X-Google-Smtp-Source: AGHT+IE6MIt9Crf4uFb9SsL0mplFpaLIV/KfK+m84t5SIp5eiaNifC4TGk5tsi/6DLhp3erQaDECSZ1wEA/Ly3WUdQQ=
X-Received: by 2002:a17:907:6e8e:b0:b73:b0eb:16f5 with SMTP id
 a640c23a62f3a-b8037152abcmr1803096266b.31.1766658433025; Thu, 25 Dec 2025
 02:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
In-Reply-To: <20251225072442.36012-2-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 25 Dec 2025 18:26:32 +0800
X-Gm-Features: AQt7F2oMwZMhp2uvMvsdRXXO0dnU3nVve5Zu9uXROr1DJlwJAadKW71tshE_EsE
Message-ID: <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x635.google.com
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

On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Add test_change_interval_timer to verify that modifying the 'interval'
> property of filter-buffer at runtime takes effect immediately.
>
> The test uses socket backend and filter-redirector to verify timer behavi=
or:
> - Creates filter-buffer with a very long interval (1000 seconds)
> - Sends a packet which gets buffered
> - Advances virtual clock by 1 second, verifies packet is still buffered
> - Changes interval to 1ms via qom-set (timer should be rescheduled)
> - Advances virtual clock by 2ms, verifies packet is now released
> - This proves the timer was rescheduled immediately when interval changed
>
> The test uses filter-redirector to observe when packets are released
> by filter-buffer, providing end-to-end verification of the timer
> rescheduling behavior.

If user try to simulate network latency by filter-buffer, the accuracy
of time is important.
Do we need add some note about the first buffered packet time not
equel to dynamic
changed time (default interval time - new qmp cmd effected time +
changed time ?).

Another issue is what level of stable accuracy the QEMU filter-buffer
can be achieved in actual testing?
Maybe need to tell user recommended test range?

Thanks
Chen

>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/qtest/meson.build          |   1 +
>  tests/qtest/test-filter-buffer.c | 169 +++++++++++++++++++++++++++++++
>  tests/qtest/test-netfilter.c     |   3 +
>  3 files changed, 173 insertions(+)
>  create mode 100644 tests/qtest/test-filter-buffer.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..ffa85ba984 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -46,6 +46,7 @@ qtests_cxl =3D \
>  #        for the availability of the default NICs in the tests
>  qtests_filter =3D \
>    (get_option('default_devices') and slirp.found() ? ['test-netfilter'] =
: []) + \
> +  (get_option('default_devices') and host_os !=3D 'windows' ? ['test-fil=
ter-buffer'] : []) + \
>    (get_option('default_devices') and host_os !=3D 'windows' ? ['test-fil=
ter-mirror'] : []) + \
>    (get_option('default_devices') and host_os !=3D 'windows' ? ['test-fil=
ter-redirector'] : [])
>
> diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filter-b=
uffer.c
> new file mode 100644
> index 0000000000..441cbb975c
> --- /dev/null
> +++ b/tests/qtest/test-filter-buffer.c
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QTest testcase for filter-buffer
> + *
> + * Copyright (c) 2025 Red Hat, Inc.
> + * Author: Jason Wang <jasowang@redhat.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qobject/qdict.h"
> +#include "qemu/iov.h"
> +#include "qemu/sockets.h"
> +
> +/*
> + * Test that changing interval at runtime affects packet release timing.
> + *
> + * Traffic flow with filter-buffer and filter-redirector:
> + *
> + * test side                        | qemu side
> + *                                  |
> + * +--------+                       | +---------+
> + * |  send  +------------------------>| backend |
> + * | sock[0]|                       | +----+----+
> + * +--------+                       |      |
> + *                                  | +----v----+
> + *                                  | |  fbuf0  | filter-buffer (queue=
=3Dtx)
> + *                                  | +----+----+
> + *                                  |      |
> + *                                  | +----v----+  +----------+
> + *                                  | |   rd0   +->| chardev0 |
> + *                                  | +---------+  +----+-----+
> + *                                  |                   |
> + * +--------+                       |                   |
> + * |  recv  |<--------------------------------------+
> + * |  sock  |                       |
> + * +--------+                       |
> + *
> + * The test verifies that when interval is changed via qom-set, the time=
r
> + * is rescheduled immediately, causing buffered packets to be released
> + * at the new interval rather than waiting for the old interval to elaps=
e.
> + */
> +static void test_change_interval_timer(void)
> +{
> +    QTestState *qts;
> +    QDict *response;
> +    int backend_sock[2], recv_sock;
> +    int ret;
> +    char send_buf[] =3D "Hello filter-buffer!";
> +    char recv_buf[128];
> +    char sock_path[] =3D "filter-buffer-test.XXXXXX";
> +    uint32_t size =3D sizeof(send_buf);
> +    uint32_t len;
> +
> +    size =3D htonl(size);
> +
> +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    ret =3D mkstemp(sock_path);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    /*
> +     * Start QEMU with:
> +     * - socket backend connected to our socketpair
> +     * - filter-buffer with a very long interval (1000 seconds)
> +     * - filter-redirector to send released packets to a chardev socket
> +     *
> +     * queue=3Dtx intercepts packets going from backend to the guest,
> +     * i.e., data we send from the test side.
> +     */
> +    qts =3D qtest_initf(
> +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> +        "-chardev socket,id=3Dchardev0,path=3D%s,server=3Don,wait=3Doff =
"
> +        "-object filter-buffer,id=3Dfbuf0,netdev=3Dqtest-bn0,"
> +        "queue=3Dtx,interval=3D1000000000 "
> +        "-object filter-redirector,id=3Drd0,netdev=3Dqtest-bn0,"
> +        "queue=3Dtx,outdev=3Dchardev0",
> +        backend_sock[1], sock_path);
> +
> +    /* Connect to the chardev socket to receive redirected packets */
> +    recv_sock =3D unix_connect(sock_path, NULL);
> +    g_assert_cmpint(recv_sock, !=3D, -1);
> +
> +    /* Send a QMP command to ensure chardev connection is established */
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
> +    /*
> +     * Send a packet from the test side.
> +     * It should be buffered by filter-buffer.
> +     */
> +    struct iovec iov[] =3D {
> +        {
> +            .iov_base =3D &size,
> +            .iov_len =3D sizeof(size),
> +        }, {
> +            .iov_base =3D send_buf,
> +            .iov_len =3D sizeof(send_buf),
> +        },
> +    };
> +
> +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + sizeof(s=
end_buf));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    /*
> +     * Advance virtual clock by 1 second (1,000,000,000 ns).
> +     * This is much less than the 1000 second interval, so the packet
> +     * should still be buffered.
> +     */
> +    qtest_clock_step(qts, 1000000000LL);
> +
> +    /* Try to receive with non-blocking - should fail (packet still buff=
ered) */
> +    ret =3D recv(recv_sock, recv_buf, sizeof(recv_buf), MSG_DONTWAIT);
> +    g_assert_cmpint(ret, =3D=3D, -1);
> +    g_assert(errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK);
> +
> +    /*
> +     * Now change the interval to 1000 us (1ms) via qom-set.
> +     * This should reschedule the timer to fire in 1ms from now.
> +     */
> +    response =3D qtest_qmp(qts,
> +                         "{'execute': 'qom-set',"
> +                         " 'arguments': {"
> +                         "   'path': 'fbuf0',"
> +                         "   'property': 'interval',"
> +                         "   'value': 1000"
> +                         "}}");
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    qobject_unref(response);
> +
> +    /*
> +     * Advance virtual clock by 2ms (2,000,000 ns).
> +     * This exceeds the new 1ms interval, so the timer should fire
> +     * and release the buffered packet.
> +     *
> +     * If the interval change didn't take effect immediately, we would
> +     * still be waiting for the original 1000 second interval to elapse,
> +     * and the packet would not be released.
> +     */
> +    qtest_clock_step(qts, 2000000LL);
> +
> +    /*
> +     * Now we should be able to receive the packet through the redirecto=
r.
> +     * The packet was released by filter-buffer and sent to filter-redir=
ector,
> +     * which forwarded it to the chardev socket.
> +     */
> +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> +    len =3D ntohl(len);
> +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> +
> +    ret =3D recv(recv_sock, recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
> +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> +
> +    close(recv_sock);
> +    close(backend_sock[0]);
> +    unlink(sock_path);
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/netfilter/change_interval_timer",
> +                   test_change_interval_timer);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilter.c
> index 326d4bd85f..b7271055d6 100644
> --- a/tests/qtest/test-netfilter.c
> +++ b/tests/qtest/test-netfilter.c
> @@ -10,7 +10,10 @@
>
>  #include "qemu/osdep.h"
>  #include "libqtest-single.h"
> +#include "libqtest.h"
>  #include "qobject/qdict.h"
> +#include "qemu/iov.h"
> +#include "qemu/sockets.h"
>
>  /* add a netfilter to a netdev and then remove it */
>  static void add_one_netfilter(void)
> --
> 2.34.1
>

