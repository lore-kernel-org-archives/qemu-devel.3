Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0BDC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWSP-00088Y-U4; Mon, 26 Feb 2024 03:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1reWSE-0007Yf-FC; Mon, 26 Feb 2024 03:35:20 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1reWSB-0006TI-Jt; Mon, 26 Feb 2024 03:35:18 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42db60ebcd7so13240841cf.0; 
 Mon, 26 Feb 2024 00:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936511; x=1709541311; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=556s9HbIF6gW0h9p5/wllHpndfq5pf/1zDUonsuknRk=;
 b=Y+VuLbr2yrcaiBX/GhyTQHIYwkHaQhN3d4orSR+JbnPNvNCs0oGQq6/uNldvI9y0uH
 e3VlnigvzERdEcE2T9Mjt4PFQNLy5qxj7cUo6x6jIO/UaWKfP4qN+CLQj3Y4vC8FDXkp
 irFcEYSzpAX4Es4vOnCZOR/Xx4/AolAxi4w/PXoO633DyXwjnsUgMB124CUUxAMKZl7K
 MZxnb2na3KFEcBzaMeSCuXoUQgW3hhR3FRE1Jdu47D2AgzzwQoxuodUNTWLPkbef16Ni
 ZQkNg83Tr8o5QyuKLfhmyAmmbWBa7m2aBmjz3D6ORv2kzcpWAIAfq/k+L2bUA+3nrcfS
 zDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936511; x=1709541311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=556s9HbIF6gW0h9p5/wllHpndfq5pf/1zDUonsuknRk=;
 b=e0eazE68SIjfPTfYhXaennW+8SqobxnvQ+2tbwQw6/YwhWIH/MF9J3xGrRFWEtXK/X
 RWZ9oHOkBLH5XVCsV0xMI7nGuhUEQapA9bMWU5xjJCiSUSUVbvpWez9044OgOmDGriC4
 IDkpbGVe8nFKYTKTidahKBRWOgeYwH7wqVmW5GAV7xWwUBdd2wJs6cVuk7tzIzC4g/Sc
 BZwGLp1Vu7emKbnePgiABrZXOSPc1IQSxS6UyuCEvVwJoYv65+vT18K8XFcKNHfxvvu1
 39gbU1QZKsvmmpHtmyJ9qT727oZZVx7F6v9u7dA6i+vYOnVw3nclxZj9pfjfvne72UlA
 9KEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Yqf/kU9h/mvKJ+MEocJkPhhcVNJAfpeYy5a1eFEM+zXieYuWItbkrLyYqnzJC7ZHCInsUe0REx02ozN8PUg7ldUgfsfZBA==
X-Gm-Message-State: AOJu0YyrsgnIQ7vnbdgh1ffmAbWGcpruD5ICy5YLKYwEjCA5ot6AAU8T
 UbPTPI+O11htcf2AID1OFfW/DI6O8FkYnLI8/k1DVqeQefDByyFdUlXvlDCC3tZfJv3uQ7CQg+3
 Dyyxre+CIQRIgU4Vm+aJ65inxO3c=
X-Google-Smtp-Source: AGHT+IHYu8njjunVoxOLXoIE7QG6xGF+C/zZ/n3EmW7tRXCdDLtso3dpCXYNZqmvYE4Ub2KDeHrTlgKR0WuYWTN0xvQ=
X-Received: by 2002:ac8:5952:0:b0:42e:5c3a:8b2d with SMTP id
 18-20020ac85952000000b0042e5c3a8b2dmr8862362qtz.1.1708936511638; Mon, 26 Feb
 2024 00:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20240226082728.249753-1-thuth@redhat.com>
In-Reply-To: <20240226082728.249753-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Feb 2024 12:35:00 +0400
Message-ID: <CAJ+F1CKnRSW8=LzDzL6ed05hF8Snw_PFH2j58QFU_VjiH68N+A@mail.gmail.com>
Subject: Re: [PATCH] tests/unit/test-util-sockets: Remove temporary file after
 test
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Feb 26, 2024 at 12:28=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> test-util-sockets leaves the temporary socket files around in the
> temporary files folder. Let's better remove them at the end of the
> testing.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/unit/test-util-sockets.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-socket=
s.c
> index 63909ccb2b..4c9dd0b271 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -326,6 +326,7 @@ static void test_socket_unix_abstract(void)
>          test_socket_unix_abstract_row(&matrix[i]);
>      }
>
> +    unlink(addr.u.q_unix.path);
>      g_free(addr.u.q_unix.path);
>  }
>
> --
> 2.43.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

