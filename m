Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FB5D15DB2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vf2-0005J0-IW; Mon, 21 Oct 2024 12:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2vf1-0005IG-0D
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:53:39 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2vez-0007p5-8f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:53:38 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb49510250so44201171fa.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729529615; x=1730134415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31j4a4Ov8mIjYCZ+STXjsFrRvIyGd1+WR6sp2ABRv2A=;
 b=wackGIwPz2W+FN9fd3CNBfVh2xwASdBXPavFfgeNmBZZMq7Ao021bQ4aPZ2pX44yTo
 ghuUg4BHQuJzzrKhHyiwWxHKMwkEQKIHktQJ2bfcNoNNPwrgRigBLVwquc9mKcpHWNis
 xqyPOUO/3Q5Rol0U71TK0UBAjU4SETEBNYHf53T/D6d2s6JD3V0FkRHETLFUlk0vUVtR
 gNDUp/jatxdrrT3/S+zrNf/DVX/9WnpABIWsvsoOsX10JHOMPNeUKrj0QAzOK6K6JSJG
 UxCe52ae1Y9PORp8GQlSn/7n/SRI9pXkz5C0eOFsyfYKz/zxSpXwczl3EaWBaJW6kI8Y
 2r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729529615; x=1730134415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31j4a4Ov8mIjYCZ+STXjsFrRvIyGd1+WR6sp2ABRv2A=;
 b=EAHuJbI5pFCnaTs9mvwWh7G89sQsE7nTHh4lVoQieb+1+9Yl/LhzCHRWVn61yUurdp
 SKoM2Cgx8vrf3MtgJ4n8POhQpnJ49I8UVM6vrbUvx4ZY6CEYyL7UK6Rayk5AnlL0WS2m
 g+TlBdaT3aI0XJBTPmr3ND7eII8ak+iZl2AnF6ZKfI6p18mXhdbsRW4i9rZeRd6Qjg58
 ButdGmS2kW5hBdFQS/4N1lFLJv8GNFdAdhbyg2ORzGTmm7NLFMHAZmMTdPnaal+A++oB
 i4rA8EBAOqnv6ashD3PUR7varEOieDxMaZY/OxayiWmS2BvMbgXOL0ERPfr8bfC/p4b0
 Sjbw==
X-Gm-Message-State: AOJu0YzsMi8DTL+64cSJ0z/7m2KNRXzBCCvhUs3ExBhAw9N2j8grm3s2
 EUurh6+5biqm9bc9ICX5DkVXtPAmrOffv7yEEHpu6jzMq5rwfgsPaKG37HoROaQVAAbR037cnBN
 cpOxuv2FKe+oy8oIWhaqsDdv/eNUmzKoclYUxBw==
X-Google-Smtp-Source: AGHT+IG4EjxgPJBC4ZaydX/jlVUAM5lD3lmVq8umWoSVwm1Wt0KNSM+bOVo6rjYe41vOph43rrrdgeMDJISYyuovtkc=
X-Received: by 2002:a05:651c:1508:b0:2fb:6465:3198 with SMTP id
 38308e7fff4ca-2fb82e90cf6mr52932891fa.5.1729529615271; Mon, 21 Oct 2024
 09:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241021145410.1420261-1-berrange@redhat.com>
In-Reply-To: <20241021145410.1420261-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 17:53:17 +0100
Message-ID: <CAFEAcA9_9jYHHspAbR=3uXLHD=7AcMN3dQubYxsAQgyCyMOFUw@mail.gmail.com>
Subject: Re: [PATCH] util: don't set SO_REUSEADDR on client sockets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Mon, 21 Oct 2024 at 15:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Setting the SO_REUSEADDR property on a socket allows binding to a port
> number that is in the TIMED_WAIT state. This is usually done on listener
> sockets, to enable a server to restart itself without having to wait for
> the completion of TIMED_WAIT on the port.

[...]

> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 60c44b2b56..80594ecad5 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -367,7 +367,6 @@ static int inet_connect_addr(const InetSocketAddress =
*saddr,
>                           addr->ai_family);
>          return -1;
>      }
> -    socket_set_fast_reuse(sock);
>
>      /* connect to peer */
>      do {

We definitely want to keep the socket_set_fast_reuse()
call in create_fast_reuse_socket() as that function is
used (only) in the "create socket, listen, bind" server
socket code path. (Arguably create_fast_reuse_socket()
is a bit unnecessary as it has only one callsite.)

The one in inet_connect_addr() is clearly wrong as that's
the client end (fixed in this patch).

How about the call in inet_dgram_saddr() ? I'm not sure how
SO_REUSEADDR interacts with UDP sockets... (I'm assuming
the answer is "we need it there" so I'm kind of asking for
the code-review record really.)

In net/socket.c we already set SO_REUSEADDR for dgram
and for listening sockets but not for client ones, so
we're now consistent there.

thanks
-- PMM

