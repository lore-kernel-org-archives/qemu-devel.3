Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296ABFEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 15:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwM3P-00073f-Go; Sat, 28 Feb 2026 10:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwM3O-00073T-GH
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:16:26 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwM3M-0006cy-Tb
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:16:26 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64aedd812baso2623532d50.3
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 07:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772291783; cv=none;
 d=google.com; s=arc-20240605;
 b=P3aFvkm4nsxNhPYvIIO1CqoHWX0FIluqmGdUHchDjV4/YkjDfXp71pu6tPwsOUIAiS
 nmTor/rJNLgfNZ7DGW9ypJxrHRcKuQ8z9pzDpYBAuZQcYOBClXafp2IshsGequk5wTEY
 /oZnjKYEecnDX5q1TzWlWL/UctgwrXWBkk7pHXFJGXqn6y/fE+lYaWsONzm4QDYAvhmq
 xk1C2WEWfJPV2s/n/7X5+Ebws2kWIxdFO+9HeT882psujez5RRfnYesKcKZ4kT+SsxXg
 LfvqGrj+m7odPWOz9aGgdZdN/E49GQ9XtS+sRk6+63XKd2LVvmrcforDsuIn7gtR+Qph
 RApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nJoX/C2VlbZDTZg9Z07rPFxfsw/5ECYGVXNc9n6ByLE=;
 fh=78TpgcLamJyHQJ2WTYqug+6NJBxneU/+gyGTo4UwNEk=;
 b=eU2WVyPvqGNKkS03jUAK4KfbbAqZu+8cVNTeEcIqnwZttNqYNLs5dN8r9aV62oE8Ph
 LwPfV7bpk2+mTcdXqHwqS7oZhjdh40VwhsVOdpBy1/92D8eXr91eTtw4CBRpah4/YXRq
 nwTo/3oIJYFN3q2Vm6c4uyQcwCCEqXmlgoJ/KKk64erWmcqxaPo67n+8zdwr/aTaL1y9
 WbItiaxa3mUWJr0IW6v5d/2tVtpjnjv0fvc+FvLExIIAQPbMGuiKU3dMMd+wwB+c6cZR
 Aka5fXGZ3tZeVQ0MC8d+E4dToLtJE6VjtwKiNqRlnvP4linF/IsBuypoJQ5bRLvHpmjI
 ZNhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772291783; x=1772896583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJoX/C2VlbZDTZg9Z07rPFxfsw/5ECYGVXNc9n6ByLE=;
 b=bqySeqpod1nj+NVqEZ/kQMEM4HxwECpqFJV/QlTcFA2NJMVV3XLahneI8pF5t2cjvp
 8/L4BSSI+bXL7w5rioiXUWtiGPMOJYkHYXBouKN6daRVCW32mBFjT5EJwWEUMIhgIEjJ
 TdKh/M8pHO748LuAinXVSs55smnZfQHYPyERvzVxzNglsTz9fbXrGXqpSNF2uVlS8BXg
 0ldJpo9+8HfpnPEHgKoIyBRcj5qjmqt6XAwBidl/hpTBA39zPE03xiEYdFhScTMWPH3r
 qrO7lzxPyjNWbosTZACVe1xP/d6POQIkU23Dbfoq/VOeAkE1fITHDVxoopid9u7ERCeE
 xidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772291783; x=1772896583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nJoX/C2VlbZDTZg9Z07rPFxfsw/5ECYGVXNc9n6ByLE=;
 b=QP2VOhAAdp0EQkNHrD9Ffely6P5XJPG3Lyr/Jwj9IJW8cB11w0bQl528fQx9k1p285
 OW+xtC4U051FcG2k3SKitbWQ54UsJS5NmQh8th1kt/yIi51mc7NupwVo6dJxDoeZUsox
 35FtjTLhw257u1mYzws32t6gvuZ6v08n9ZNhCoDtvEWJEyS99PR5EQRuRbzjxaRaop7S
 hZsf4l17yJ183LjcblLPE5tcuzeD77vJZ+6sV2cZaRI/qC8yK2j0O2BZFpwvY39b0QhN
 1Y5uIAplvMVMwGXxyXK9gYIUvs2eE4891f6/xwTJu8hhE0d0zQxrpcVUlr+92/1VSNV2
 eF6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAqS57bAhitWSNpmBN9kv6C/IBTt3XmJ+mgP7tJzy0T/+yI4c2Gy/VyfKJ1eRuOOF83JO6E2996Wp7@nongnu.org
X-Gm-Message-State: AOJu0YzlYam93147LNQYerZTwUF3/5rbmFCqIO8PkgRprA1Dw4TaG2GB
 oNOdfaJ5/fWrlBbemzLj6Hl2VXPLgogu+iQ/r2rTK+y0FJAlbfFn2fj9jmHdaKzDGXjxaI+I3Ek
 CZRkCcQDChbfkzHI76LT0N2e0Cv2NEbINh7IZ5Oe6Og==
X-Gm-Gg: ATEYQzzQZHFiybCwnRCoeBCaQDvrXG8QRi1RVLACjzCT5X2tBARnNtLU6e7GupH7bh7
 B0yG9Z1cPjdcMQ33hkXCxEKRzZhQmULjQfBideAXyBseMt1M3xH2N5zMFYeTrl0K9D86KWbK3Rt
 2fH2L8ojnIqvA++qB9wTsqLcWMaD4AO1RnD2n0uN4ULUL9WFRElF8uLdIUxnQxTR2cy+HIDxoI0
 r4A90I47hi5GZNNWE60K6Sas3JvWlB2SglwH9CGtKif4fmtjbD0jP745/QyOMSHGg9K41KcIiWY
 e9/eKzwhpovlV56Qke7+Zp3yOEQ8CleLADAQcW/EjXRUH6h4C+6Kp364Xrev8G3MZnk=
X-Received: by 2002:a53:d68e:0:b0:64c:b6d9:a847 with SMTP id
 956f58d0204a3-64cc208339dmr4213596d50.5.1772291783008; Sat, 28 Feb 2026
 07:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-5-farosas@suse.de>
 <aCsPOyZCu-AcZOI3@redhat.com>
In-Reply-To: <aCsPOyZCu-AcZOI3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Feb 2026 15:16:11 +0000
X-Gm-Features: AaiRm52Px9oVuOFchWzEATcAUX1RDgwJkK2R67sRQ40eCPW9K_at7n6ARPGF1Io
Message-ID: <CAFEAcA_BvkKaF-qgJm25wSwuLEBedxL_pRVedQadCh1fVQBr8w@mail.gmail.com>
Subject: Re: [PATCH 4/4] chardev: Introduce a lock for hup_source
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 19 May 2025 at 12:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, May 15, 2025 at 07:20:14PM -0300, Fabiano Rosas wrote:
> > It's possible for the hup_source to have its reference decremented by
> > remove_hup_source() while it's still being added to the context,
> > leading to asserts in glib:
>
> IIUC this must mean that
>
>   tcp_chr_free_connection
>
> is being called concurrently with
>
>   update_ioc_handlers
>
> I'm wondering if that is really intended, or a sign of a deeper
> bug that we'll just paper over if we add the mutex proposed here.
>
> Are you able to provide stack traces showing the 2 concurrent
> operations that are triggering this problem ?

(Pulling up this thread from last year since I ran into something
similar running the sanitizers, and Fabiano pointed me at this series
he'd sent that fixes most/all of the problems.)

I had a look at this, and although I couldn't get a specific
backtrace, I got enough information from asan leak backtraces
and looking at the code that I think I understand where the race
is here:

vhost-user-test.c:test_server_create_chr() sets up a chardev with:
 qemu_chr_new()
 qemu_chr_fe_init()
 qemu_chr_fe_set_handlers()

For the "connect-fail" and "flags-mismatch" tests, it includes in
the options to the chardev "reconnect-ms=3D1000".

qemu_chr_new() ends up in tcp_chr_open(), which calls
qmp_chardev_open_socket_client().

If reconnect_ms is not 0, qmp_chardev_open_socket_client() calls
tcp_chr_connect_client_async() instead of doing the connect synchronously.
That kicks off a qio_task_new() to do the connecting, and immediately
returns, so we return successfully from qemu_chr_new(). So
test_server_create_chr() will continue execution into qemu_chr_fe_init()
and qemu_chr_fe_set_handlers().

qemu_chr_fe_set_handlers() calls qemu_chr_be_update_read_handlers(), which
calls the chr_update_read_handler method for the ChardevClass, which here
is tcp_chr_update_read_handler(). That function calls update_ioc_handlers()=
.

Meanwhile, the thread that got kicked off to do the connect is
running in parallel. If the connect succeeds then qemu_chr_socket_conneted(=
)
will call tcp_chr_connect(), which will also call
update_ioc_handlers(). (If the connect fails then presumably we end
up in the tcp_char_disconnect or otherwise destroying the chardev,
though I haven't figured out exactly what happens in this case.)

None of this appears to be taking any kind of lock while it modifies
the SocketChardev fields, so we could have two threads in
update_ioc_handlers() simultaneously.

 How is this intended to work ? Is the test case code incorrect to assume
it can work with the chardev it got back from qemu_chr_new(), or should
the chardev be handling this case?

thanks
-- PMM

