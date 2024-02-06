Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7244C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXN7C-00045H-Rf; Tue, 06 Feb 2024 10:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN7B-00044x-T7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN7A-0004Jk-Gg
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36sAmlBQzYPKLJUGwkwfVkai6wFC6wetPzyYQCmi64A=;
 b=ZgTMZxXWSkPAC5tSy8FXAAl9t3NURGj1FRtbt4q8q8hEp0H0XsSws9khDh5y/GR4Z1dlu0
 Idy+5iWywp27e/eMMJ2twoXTPxg1FtgOcO9Ez/67ZUDI9gc2sN90XPevb59DUZfdQmP3OF
 3YX7HxTNO/+XMIWZSINfALsz30Atm/Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_QCv3RfNOMGx2CgGm8bPZg-1; Tue, 06 Feb 2024 10:11:58 -0500
X-MC-Unique: _QCv3RfNOMGx2CgGm8bPZg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b316fcaecso1468319f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232317; x=1707837117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36sAmlBQzYPKLJUGwkwfVkai6wFC6wetPzyYQCmi64A=;
 b=f+OyBTn7n+RB8rJtPOq8CUtoxhBPEWvqIq1jOxPp23yoY1G9PuS6LFypFj2UYhIIXn
 S+mASDmds9Gq/6zqOfB0vVXPrtxRjINKnTTP+EzuFjRp9guIBiIwb+0FrlM7h+b9B9Z+
 5plTDingAgpmduYH7iRrM3kwhbRlO2vB+1tApZbevDeZRVPIthfrGXHmFWUD45wNZmvF
 46cKTbv+4beOXLYfx3BkxBY3EgWscbolnBIyXuNFQEhzheqETFOO1QjGYUfgQIvY3hVp
 WRQnc6NEGJQ3w7w55Ryhw4Y6qhfmTR4V8bL34+mvEyp2PnLAK2qIGSMzoZdMjOBntRa6
 RclA==
X-Gm-Message-State: AOJu0Yw6IHdtkr5nSBAy8az9ypRHHPxGkEFNTouXT2uxIPGfNYg5M84t
 fnT/FoSetaJ81XKQDqiB0qdiE72rrgkP3f0CrAUF8nC90Jd/8CZjlthybu4aEDEVvsP0LIGt9fW
 e4yE2wf9/t6R7yGP5Viiv5Q7kZkXz+JKRjPsa7QHYE3FV8LWSPq1O
X-Received: by 2002:a5d:5650:0:b0:33b:1b2a:b6cc with SMTP id
 j16-20020a5d5650000000b0033b1b2ab6ccmr1379267wrw.10.1707232317117; 
 Tue, 06 Feb 2024 07:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFckJhN3ttnKUAEiGJSW3bMpIhdGSt0ikgrksCzRlxdsFKq/UtQXPT4AoUUV3kecfEMPX/yYg==
X-Received: by 2002:a5d:5650:0:b0:33b:1b2a:b6cc with SMTP id
 j16-20020a5d5650000000b0033b1b2ab6ccmr1379249wrw.10.1707232316788; 
 Tue, 06 Feb 2024 07:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUP+vTeKIsgXLjrD9Z5gifJMrbdgRKIYqcEjkIYoVJE0raxHPhkuPDKXsSHL0ay4Xn7j3nBN9z9IIVVNNr/qlt+YIrG1R+6KVf6vUGOTelet8emM2PsFNIr43THA2T3xcHaszlHG7L3miqXwrbbE4tCH2ywda0b6cwCWWqPWvA2Ay2A4eq+pa+WeOS9WgkAYwe43Aqxtg==
Received: from ?IPV6:2003:cf:d740:65ef:7c9f:a118:b826:ff5f?
 (p200300cfd74065ef7c9fa118b826ff5f.dip0.t-ipconnect.de.
 [2003:cf:d740:65ef:7c9f:a118:b826:ff5f])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a05600c4f0e00b0040fc56712e8sm2293529wmq.17.2024.02.06.07.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:11:56 -0800 (PST)
Message-ID: <9071df4c-d08a-4298-b6fb-a562745773a8@redhat.com>
Date: Tue, 6 Feb 2024 16:11:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] monitor: use aio_co_reschedule_self()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-6-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240205172659.476970-6-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05.02.24 18:26, Stefan Hajnoczi wrote:
> The aio_co_reschedule_self() API is designed to avoid the race
> condition between scheduling the coroutine in another AioContext and
> yielding.
>
> The QMP dispatch code uses the open-coded version that appears
> susceptible to the race condition at first glance:
>
>    aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
>    qemu_coroutine_yield();
>
> The code is actually safe because the iohandler and qemu_aio_context
> AioContext run under the Big QEMU Lock. Nevertheless, set a good example
> and use aio_co_reschedule_self() so it's obvious that there is no race.
>
> Suggested-by: Hanna Reitz <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   qapi/qmp-dispatch.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


