Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFA6C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfUO-0002YL-MP; Tue, 15 Jul 2025 09:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhroncok@redhat.com>)
 id 1ubdKS-00057P-Qd
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhroncok@redhat.com>)
 id 1ubdKQ-0001gu-FC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752576964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnABPLj5RV7Y6VPy/RvmkzIfps4Z68NP1PpHIrCWwZA=;
 b=Pbs38Xb3R8JLKndgCRm8VJF4v9ZBDbu9GqU/8ymTw9a/EgEAyhi4+B0IleadMspr3JU4av
 lJr4Yv4Iu2IMikJkHEiC93+hbmqRHqqgI8TEWEnw8AIrtfGrmShHd8VQRqztFXRTCSXp6T
 ZGo/jQCTDUSE19Qg62yg1kiMMQnPI/o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-JcL-JByTN1KeK9yDE2YJZQ-1; Tue, 15 Jul 2025 06:54:30 -0400
X-MC-Unique: JcL-JByTN1KeK9yDE2YJZQ-1
X-Mimecast-MFC-AGG-ID: JcL-JByTN1KeK9yDE2YJZQ_1752576869
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561611dc2aso18406695e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576869; x=1753181669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnABPLj5RV7Y6VPy/RvmkzIfps4Z68NP1PpHIrCWwZA=;
 b=EhYNioiIw9BJj9HqItT7L9wNqTK2mo5u+WWjkMtEjr/tQr13EwXAJBSMEJNL/wqeJ8
 nqWttcYvAt9dhfPM4WihliNkOEe8JrDpAYjJGqxf6Ajapzro7RwGL/zYdnLPxAv66AWw
 7wwSorbb7Cmi65Bz5mmgN8Uvp1DeSHZE/eh1qByia7gZqpELQoOFs3hKYVTxxY6x9ikL
 mvhiNmK7u25ysPUmezX4MiE4sOc6YmUXE50e8EtTQGlmWn2ZbmPKs4alw7wJvCUCXwDi
 4pY3gNh9NQ9Emy7+K+mS34clgN6tZMGG446YIfyh1eLQiyF3YH7jlIKIDQ78OEpbjAZU
 tHFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYEBcxcYb9HlOoKZUK6rT0uK+UB4NOBuCSLzYngHjNp3UK44oAKCS3TJNFmcLwRt13VtsZNPv+hhr5@nongnu.org
X-Gm-Message-State: AOJu0Yy1TFuCrmDM1uSq5sgX7suhXcGXBxFPkaQ7FifiTDqnL/iZ12eK
 L8PSSsMpJzGHrxVJg/Vvm15BcCmoNBuIno9jIHIsX4cmy+jJXhilJ9gtvAy28EmnlLlsO/Agx23
 qLlzwFggr1DX/KumAnpdDE6mbSwBVD8Ct2nYEfInNUmtxVPFqWOa3meKa
X-Gm-Gg: ASbGncsXd3BjBlxn3kXXhFf6ktcLLba8C8bWkypwJ8xW0W90IZgxxFsW/yqB1yUHi9M
 /7Z3ZcZPIFT0ZN2vzfsFHcqKLYUYjsj+GhzkM3L1wdmSzhlGkJhTe8sgC3M1OH8BjTOU5Qrdbmc
 pQ4y5Pk3EENQlVQDBdOIKYKZcanKcW9reBqas9rWLTVYDKlEzx7x+wb34aLcb9JgyLwls1AIymt
 XOWzFOPnvefq3OOHr0o1PtmR9Co3o+oHznCHcufk+O7pAmdqG9wiKQ5qqkLbGteRRM1hHEMsxkg
 XsOSVuCqCEDQAz4Q9zkOkUZLyIEg1W62kWr3WkV+vi4csz8RuRweZzueTvkf7XwZWB2UUz6J8WR
 h7wJg0YNy2suY3RtOcDqp6MSMhNFqSdVMMKliJlsJ70cHI8O6FQDa1p5JQ1vsCVNDznZWumsRa6
 0czJ8KdTc=
X-Received: by 2002:adf:a351:0:b0:3a5:52d4:5b39 with SMTP id
 ffacd0b85a97d-3b60a1456fdmr1177368f8f.8.1752576869013; 
 Tue, 15 Jul 2025 03:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy1BloFFwuh/jgZ9zXy/pLkZySAtCQLNZFt3NCA8sb1oQLaDOMurPE6W+oIIazcDIH1OY9Ng==
X-Received: by 2002:adf:a351:0:b0:3a5:52d4:5b39 with SMTP id
 ffacd0b85a97d-3b60a1456fdmr1177353f8f.8.1752576868574; 
 Tue, 15 Jul 2025 03:54:28 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838c:6c1a:5a85:279d:fb90:4bfa?
 (dynamic-2a00-1028-838c-6c1a-5a85-279d-fb90-4bfa.ipv6.o2.cz.
 [2a00:1028:838c:6c1a:5a85:279d:fb90:4bfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e285e0sm14485904f8f.101.2025.07.15.03.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 03:54:28 -0700 (PDT)
Message-ID: <81d639a0-aea2-495a-91d4-6dcc397ef7db@redhat.com>
Date: Tue, 15 Jul 2025 12:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] python: Replace asyncio.get_event_loop for Python 3.14
To: "Richard W.M. Jones" <rjones@redhat.com>, jsnow@redhat.com
Cc: crosa@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
References: <20250715105113.623604-1-rjones@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Miro_Hron=C4=8Dok?= <mhroncok@redhat.com>
In-Reply-To: <20250715105113.623604-1-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mhroncok@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Jul 2025 09:08:57 -0400
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

On 15. 07. 25 12:51, Richard W.M. Jones wrote:
> In Python 3.14, no asyncio event loop gets generated automatically.
> Instead create one when we need it.  This should work with Python 3.13
> as well.  This is a mechanical change as suggested here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2375004#c4
> 
> See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
> Thanks: Miro Hrončok
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>   python/qemu/qmp/legacy.py  | 5 ++++-
>   python/qemu/qmp/qmp_tui.py | 5 ++++-
>   python/qemu/qmp/util.py    | 5 ++++-
>   python/tests/protocol.py   | 5 ++++-
>   4 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
> index 22a2b5616e..e11d05afbd 100644
> --- a/python/qemu/qmp/legacy.py
> +++ b/python/qemu/qmp/legacy.py
> @@ -86,7 +86,10 @@ def __init__(self,
>                   "server argument should be False when passing a socket")
>   
>           self._qmp = QMPClient(nickname)
> -        self._aloop = asyncio.get_event_loop()
> +        try:
> +            self._aloop = asyncio.get_event_loop()
> +        except RuntimeError:
> +            self._aloop = asyncio.new_event_loop()
>           self._address = address
>           self._timeout: Optional[float] = None
>   
> diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
> index 2d9ebbd20b..84c5da4e66 100644
> --- a/python/qemu/qmp/qmp_tui.py
> +++ b/python/qemu/qmp/qmp_tui.py
> @@ -377,7 +377,10 @@ def run(self, debug: bool = False) -> None:
>           screen = urwid.raw_display.Screen()
>           screen.set_terminal_properties(256)
>   
> -        self.aloop = asyncio.get_event_loop()
> +        try:
> +            self.aloop = asyncio.get_event_loop()
> +        except RuntimeError:
> +            self.aloop = asyncio.new_event_loop()
>           self.aloop.set_debug(debug)
>   
>           # Gracefully handle SIGTERM and SIGINT signals
> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index ca6225e9cd..8f9f849a5f 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -160,7 +160,10 @@ def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool = False) -> T:
>           return asyncio.run(coro, debug=debug)
>   
>       # Python 3.6
> -    loop = asyncio.get_event_loop()
> +    try:
> +        loop = asyncio.get_event_loop()
> +    except RuntimeError:
> +        loop = asyncio.new_event_loop()
>       loop.set_debug(debug)
>       ret = loop.run_until_complete(coro)
>       loop.close()

This one particular addition should not be necessary as it only runs on Python 
3.6. This code is not reached on Python 3.7+ and hence it is not reached on 
Python 3.14.

> diff --git a/python/tests/protocol.py b/python/tests/protocol.py
> index 56c4d441f9..aa7c0e4397 100644
> --- a/python/tests/protocol.py
> +++ b/python/tests/protocol.py
> @@ -228,7 +228,10 @@ def async_test(async_test_method):
>           Decorator; adds SetUp and TearDown to async tests.
>           """
>           async def _wrapper(self, *args, **kwargs):
> -            loop = asyncio.get_event_loop()
> +            try:
> +                loop = asyncio.get_event_loop()
> +            except RuntimeError:
> +                loop = asyncio.new_event_loop()
>               loop.set_debug(True)
>   
>               await self._asyncSetUp()

-- 
Miro Hrončok
-- 
Phone: +420777974800
Fedora Matrix: mhroncok


