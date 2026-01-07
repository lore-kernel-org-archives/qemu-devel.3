Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC945CF6C17
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPWZ-0000LN-KK; Wed, 07 Jan 2026 04:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vdPWR-0000Jx-NV
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:08:09 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vdPWP-0005C6-Rt
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:08:07 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so379651466b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767776884; x=1768381684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlPckZkY7dGKX6Oi9Su2GDQPw/qgAi9Qu0+6VKP72xM=;
 b=VwFyHznA7h1AZGdY58OiWZVI86ihxeyXxVB48MtBcyCLC9Ikvzokr+kGpK1SRqsqes
 YreAxV8IpxfV2KXZvEVOjyjdTiaLXJ+/P+czgvNd6u8z+3NBv9Cu7/PsIb/GBKDOGmLT
 XiwUGxtUzWUVJk1o84J6IYi9St16p2HQ96/RetGooS+cuQooLj1+iCPw67/dZY/eIZkA
 98ww3nT7g1OaK8ubVaXwwbK8mtN4HjbjUembyICOrkFVdMrNk20y6M14VISJe9w3IQKb
 bQKECYLGsfVdbs9/tuxr8YzUkPWiyB5672gd0oTfI6kh1s7gAOaLRRoTLGEAyBjCqTPJ
 I18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767776884; x=1768381684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rlPckZkY7dGKX6Oi9Su2GDQPw/qgAi9Qu0+6VKP72xM=;
 b=NPBUJ+dbEJPCipjvkXgLtFjrM9vMgMs80RirX8gMo0pOOQsEbGHnutXPtJvffWp9Ea
 0jOqGH/tOFs4IWFoZbUhVyiUPpyDjM3R6rPEhHx0L43ACyDHePRsdmsw1mN6UR0hRSRV
 sEgcpul/TNDQC/nhtjcLWPAfr5EIzUn3AniGGb0E9KyUEfwFBEFfI/8K6KwDJGYmO3Nr
 8Oc8IxRiUyNDmISp75GeC+hcOsBJn0EbSP+nGGsR9GOazz1oJZ7DffPZbuyc09BkyTnt
 EIUows2sJWiyasGF3vMwHEi3srHsWLpZTsAMQzn/WWFqD37xv2PnK21jIEQ0Dp24AfZO
 UILA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXit31fvYPP4jp8k3hY5yl0BTJxbZMvJXSQ+eJRIcsuDPMYpj7yiW/cGFF2LNVDoJna0vKttCRE7M0M@nongnu.org
X-Gm-Message-State: AOJu0YyFKD/uEADkrtDGJHG5KfPypxYk4wlxnPkH+T8AZo2PCi8lakWX
 idNxOoF8liOS5eL9iS/PhqjKhGQLTp47PdnQxXlf5ZvAzB1kyqAlXLtv9Z8dxmGJn95ftfdA9pe
 0kw6vyalGqdQlpLVIvi/fJsAyi4VbydtoYBmQ
X-Gm-Gg: AY/fxX7Bw4BI07URNhcd12rhEag9KVZKhrFpPsTf/gw/LsI8Ss/lnv/8ivr6lgR432b
 Ps3bVB662p3lsbil74/61SRWv0hOvqXIt3vRAuvBGSrqGps10RyQGCLa6Q20P+aeyLTEiee0yDc
 93srBXgVsbtqOxVvE3jePunv08uclwKKSWKxvqislymM2i9RvgjCq+0p2Y4gwoUYJIv2QfY5IT4
 b86MQSoZDBGtv4B8cjuiIqiaR1l/LHwKJ6AG0UyAOP/gVHzou7TKdRMG6o/gTmE5VADzJcACou6
 tYC+1Q==
X-Google-Smtp-Source: AGHT+IHMn6kYlhP+HGuvYChVaHkmZTHiP+bKbajoT2U+gEgIBteyWmWJtHqd3er1YZDXT/W+W/qC8HDpglQEzwDHA8Y=
X-Received: by 2002:a17:907:a0e:b0:b84:2fe8:b5d6 with SMTP id
 a640c23a62f3a-b8444f2a1bcmr165260766b.23.1767776883750; Wed, 07 Jan 2026
 01:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-3-jasowang@redhat.com>
In-Reply-To: <20260104075412.1262-3-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 7 Jan 2026 17:07:27 +0800
X-Gm-Features: AQt7F2oRARLMOtMlFm4diwMVBGMR0i12WOpBMt57GHe9CPIIv0VUZsXM2VlUNn8
Message-ID: <CAK3tnvK_NL4QyRUKqinUbAwiYuPKxr7dbai7bn5dkENFvC-2UA@mail.gmail.com>
Subject: Re: [PATCH 2/3] qtest: add a test to test redirector status change
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x631.google.com
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

On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> This patch adds a qtest to test the status change of
> filter-redirector. Two subtests were added:
>
> - test_redirector_status: tests dynamic on/off switching at runtime
>   using qom-set QMP command
>
> - test_redirector_init_status_off: tests creating filter-redirector
>   with status=3Doff from the start via command line
>
> Both tests verify that:
>
> 1. When status is off, data from indev chardev is not received
> 2. When status is switched to on, data is received correctly
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

LGTM.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

Thanks
Chen

> ---
>  tests/qtest/test-filter-redirector.c | 192 +++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
>
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filt=
er-redirector.c
> index a996a80c1c..da0c126314 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -196,10 +196,202 @@ static void test_redirector_rx(void)
>      qtest_quit(qts);
>  }
>
> +/*
> + * Test filter-redirector status on/off switching.
> + *
> + * This test verifies that:
> + * 1. When status is set to "off", the filter stops receiving data from =
indev
> + * 2. When status is set back to "on", the filter resumes receiving data
> + */
> +static void test_redirector_status(void)
> +{
> +    int backend_sock[2], send_sock;
> +    uint32_t ret =3D 0, len =3D 0;
> +    char send_buf[] =3D "Hello!!";
> +    char sock_path0[] =3D "filter-redirector0.XXXXXX";
> +    char *recv_buf;
> +    uint32_t size =3D sizeof(send_buf);
> +    size =3D htonl(size);
> +    QTestState *qts;
> +    struct timeval tv;
> +    fd_set rfds;
> +
> +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    ret =3D mkstemp(sock_path0);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    /*
> +     * Setup a simple rx path:
> +     * chardev (sock_path0) -> filter-redirector -> socket backend
> +     */
> +    qts =3D qtest_initf(
> +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> +        "-chardev socket,id=3Dredirector0,path=3D%s,server=3Don,wait=3Do=
ff "
> +        "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
> +        "queue=3Drx,indev=3Dredirector0 ",
> +        backend_sock[1], sock_path0);
> +
> +    send_sock =3D unix_connect(sock_path0, NULL);
> +    g_assert_cmpint(send_sock, !=3D, -1);
> +
> +    /* send a qmp command to guarantee that 'connected' is setting to tr=
ue. */
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
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
> +    /*
> +     * Test 1: Set status to "off" and verify data is not received
> +     */
> +    qtest_qmp_assert_success(qts,
> +        "{ 'execute': 'qom-set', 'arguments': "
> +        "{ 'path': '/objects/qtest-f0', 'property': 'status', 'value': '=
off' }}");
> +
> +    ret =3D iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_bu=
f));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    /*
> +     * Use select with timeout to check if data arrives.
> +     * When status is off, no data should arrive.
> +     */
> +    FD_ZERO(&rfds);
> +    FD_SET(backend_sock[0], &rfds);
> +    tv.tv_sec =3D 0;
> +    tv.tv_usec =3D 500000;  /* 500ms timeout */
> +    ret =3D select(backend_sock[0] + 1, &rfds, NULL, NULL, &tv);
> +    g_assert_cmpint(ret, =3D=3D, 0);  /* Should timeout, no data */
> +
> +    /*
> +     * Test 2: Set status back to "on" and verify data is received
> +     */
> +    qtest_qmp_assert_success(qts,
> +        "{ 'execute': 'qom-set', 'arguments': "
> +        "{ 'path': '/objects/qtest-f0', 'property': 'status', 'value': '=
on' }}");
> +
> +    ret =3D iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_bu=
f));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    ret =3D recv(backend_sock[0], &len, sizeof(len), 0);
> +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> +    len =3D ntohl(len);
> +
> +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> +    recv_buf =3D g_malloc(len);
> +    ret =3D recv(backend_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
> +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> +
> +    g_free(recv_buf);
> +    close(send_sock);
> +    unlink(sock_path0);
> +    qtest_quit(qts);
> +}
> +
> +/*
> + * Test filter-redirector created with status=3Doff.
> + *
> + * This test verifies that when a filter-redirector is created with
> + * status=3Doff, it does not receive data until status is set to on.
> + */
> +static void test_redirector_init_status_off(void)
> +{
> +    int backend_sock[2], send_sock;
> +    uint32_t ret =3D 0, len =3D 0;
> +    char send_buf[] =3D "Hello!!";
> +    char sock_path0[] =3D "filter-redirector0.XXXXXX";
> +    char *recv_buf;
> +    uint32_t size =3D sizeof(send_buf);
> +    size =3D htonl(size);
> +    QTestState *qts;
> +    struct timeval tv;
> +    fd_set rfds;
> +
> +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    ret =3D mkstemp(sock_path0);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    /*
> +     * Create filter-redirector with status=3Doff from the start
> +     */
> +    qts =3D qtest_initf(
> +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> +        "-chardev socket,id=3Dredirector0,path=3D%s,server=3Don,wait=3Do=
ff "
> +        "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
> +        "queue=3Drx,indev=3Dredirector0,status=3Doff ",
> +        backend_sock[1], sock_path0);
> +
> +    send_sock =3D unix_connect(sock_path0, NULL);
> +    g_assert_cmpint(send_sock, !=3D, -1);
> +
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
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
> +    /*
> +     * Test 1: Filter was created with status=3Doff, data should not be =
received
> +     */
> +    ret =3D iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_bu=
f));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    FD_ZERO(&rfds);
> +    FD_SET(backend_sock[0], &rfds);
> +    tv.tv_sec =3D 0;
> +    tv.tv_usec =3D 500000;
> +    ret =3D select(backend_sock[0] + 1, &rfds, NULL, NULL, &tv);
> +    g_assert_cmpint(ret, =3D=3D, 0);  /* Should timeout, no data */
> +
> +    /*
> +     * Test 2: Set status to "on" and verify data is received
> +     */
> +    qtest_qmp_assert_success(qts,
> +        "{ 'execute': 'qom-set', 'arguments': "
> +        "{ 'path': '/objects/qtest-f0', 'property': 'status', 'value': '=
on' }}");
> +
> +    ret =3D iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_bu=
f));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    ret =3D recv(backend_sock[0], &len, sizeof(len), 0);
> +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> +    len =3D ntohl(len);
> +
> +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> +    recv_buf =3D g_malloc(len);
> +    ret =3D recv(backend_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
> +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> +
> +    g_free(recv_buf);
> +    close(send_sock);
> +    unlink(sock_path0);
> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/netfilter/redirector_tx", test_redirector_tx);
>      qtest_add_func("/netfilter/redirector_rx", test_redirector_rx);
> +    qtest_add_func("/netfilter/redirector_status", test_redirector_statu=
s);
> +    qtest_add_func("/netfilter/redirector_init_status_off",
> +                   test_redirector_init_status_off);
>      return g_test_run();
>  }
> --
> 2.34.1
>

