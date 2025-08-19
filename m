Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49631CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSRs-0000bG-Pw; Tue, 19 Aug 2025 15:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSRp-0000aT-9s
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSRl-0002hh-VD
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/khvpbR7kYmNIAaBiW0dqJZTcljVEEG0pES9seVMIGY=;
 b=HO+5RJwoI2H0Dtpq97jEjKabpbauggQq7rlkY9qTKbl9reX9QbXuJjOqkzn9LmnaaqUZPp
 kSpuJCN0FskaNGrj9iAmYj0WcZMpE3bXLTdukBhzT/+oPaS8S9/xoCmA6JYdJBC9LtvBn1
 jvyVsdLJdB0spD0R8CcCHLjwzpB81jw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-UN_ALLdINmu0wOpGongbhw-1; Tue, 19 Aug 2025 15:56:39 -0400
X-MC-Unique: UN_ALLdINmu0wOpGongbhw-1
X-Mimecast-MFC-AGG-ID: UN_ALLdINmu0wOpGongbhw_1755633398
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458297be0so130540155ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633396; x=1756238196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/khvpbR7kYmNIAaBiW0dqJZTcljVEEG0pES9seVMIGY=;
 b=ojpnvT8xEHY+f/mxaipBJJTBDI50u7aIpAGE1Hw+O3+/u2mPUBt+zjr4XlnFyXpfEd
 x9v3j7URhNaJVZ/vahTwDvrhlstvug+vSEpeK4mkQO5NTwwvurAh3IzdeHicfUuHqFHP
 Nd415HdLKl7ntBUU048Ft9CClpaNvq3mVackQpDygaSUrRqn/XMZ4BnPp1OBtCYaGurN
 J7aGQXnV9dtZtnYUnv7cHbJQJgP1OuITjAA7oyA7563jwSWxpGZ5kDk9TQX2Z45HKGBv
 ab9on9g+ekepXkd8hEwkb+d6Se2whY25L+/L5yZWK4ptBTM2wovhaoJJzdykiA6TphDz
 cLqA==
X-Gm-Message-State: AOJu0YzDmieA4BoJhHyMKJR1/YkvxU2wEymZXAF5xGdbz5HFB7Ug0skJ
 9JT5S4U57Zigxe/ecCMIgnM0SI7IP2sNcULoT2SeeaJjQibLmw3O/4YW4Ktkd1kQdxrRm+YQne9
 00H5jiXMqIwjjxP4U/mlfJqF8IxueI/2KtWayGEaTaj1MI/DVl97W7MQnw2Y3o0I4cXkzYOZVxK
 yy+9jHCK+6LAtwJ89aL0+nhgaEcJkhb9lIlbdDGoc=
X-Gm-Gg: ASbGncthXCA2pLHNtisIWjJmJUmFwMoXar72JvZmuowXVfoprzQi5wDhxnxnc+sM10f
 SdSqQkxbyq1g3CSMshIHhYQ95rXSp/FG4t5J5H4BjhnXELQU4mJUikRPVD/7EZAQgq7suvalqxp
 WHGGaNXdGseK/DJJvROdjq9uOfQA2Izah/Djok/9GHbhohPSQAGusR
X-Received: by 2002:a17:903:1b48:b0:243:926:b1f3 with SMTP id
 d9443c01a7336-245ef1728b2mr2841035ad.24.1755633396304; 
 Tue, 19 Aug 2025 12:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt8vgs24I0tD+15AE/ZD0Z0GenQB1zR5t4yFrhHIIvABJuGuEvH5LorH0g4WuW9b62MDHyHfHzo2Pvcp63asw=
X-Received: by 2002:a17:903:1b48:b0:243:926:b1f3 with SMTP id
 d9443c01a7336-245ef1728b2mr2840725ad.24.1755633395947; Tue, 19 Aug 2025
 12:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-4-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-4-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 15:56:23 -0400
X-Gm-Features: Ac12FXyCXhiQcZdxYEu5OE_sbkZj1-mlrTtKwTr8T_d_3rPyQoyQpaBWRqVhxzU
Message-ID: <CAFn=p-ZChaXSJsuq3_RxmRMddvoTCZ0cOnBCkznVXGuvYOxqxg@mail.gmail.com>
Subject: Re: [PATCH 03/14] python: drop 'is_closing' back compat helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:31=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> Our minimum python is now 3.9, so back compat with python
> 3.6 is no longer required.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

Another thing that happened in the standalone tree, but not in
qemu.git. Ditto patches 4, 5, 6.

> ---
>  python/qemu/qmp/protocol.py |  3 +--
>  python/qemu/qmp/util.py     | 16 ----------------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
> index a4ffdfad51..9a7ada4a1e 100644
> --- a/python/qemu/qmp/protocol.py
> +++ b/python/qemu/qmp/protocol.py
> @@ -39,7 +39,6 @@
>      create_task,
>      exception_summary,
>      flush,
> -    is_closing,
>      pretty_traceback,
>      upper_half,
>      wait_closed,
> @@ -825,7 +824,7 @@ async def _bh_close_stream(self, error_pathway: bool =
=3D False) -> None:
>          if not self._writer:
>              return
>
> -        if not is_closing(self._writer):
> +        if not self._writer.is_closing():
>              self.logger.debug("Closing StreamWriter.")
>              self._writer.close()
>
> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index ca6225e9cd..39fc341f2f 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -104,22 +104,6 @@ def create_task(coro: Coroutine[Any, Any, T],
>      return asyncio.ensure_future(coro, loop=3Dloop)
>
>
> -def is_closing(writer: asyncio.StreamWriter) -> bool:
> -    """
> -    Python 3.6-compatible `asyncio.StreamWriter.is_closing` wrapper.
> -
> -    :param writer: The `asyncio.StreamWriter` object.
> -    :return: `True` if the writer is closing, or closed.
> -    """
> -    if sys.version_info >=3D (3, 7):
> -        return writer.is_closing()
> -
> -    # Python 3.6:
> -    transport =3D writer.transport
> -    assert isinstance(transport, asyncio.WriteTransport)
> -    return transport.is_closing()
> -
> -
>  async def wait_closed(writer: asyncio.StreamWriter) -> None:
>      """
>      Python 3.6-compatible `asyncio.StreamWriter.wait_closed` wrapper.
> --
> 2.49.0
>


