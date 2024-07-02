Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24958C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYkA-0007Qg-Hc; Tue, 02 Jul 2024 04:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sOYk7-0007PW-4M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sOYk4-0007IF-8q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719908397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=otSo2udX3h7wTjXOpCSchNr1uiFSVNX0FUCelZXem1g=;
 b=JA1hNBMVPi9dzelohQru6FtExpq9u55nKpLH5HeoJN/pYY4jktTcGPs7qSqh0zWkVi9nm9
 71AygKFWQlOnrXLm+R1YhWke0fVmssAOR+Ox32cBljqSD+cTomPJr0arPbZgBJEt1zjk9W
 8R9N0k8T+NSotrtX2TFT9buQGB76IN4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-luxL8STHPkaZx1CrUsdemw-1; Tue, 02 Jul 2024 04:19:55 -0400
X-MC-Unique: luxL8STHPkaZx1CrUsdemw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso26884805e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 01:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719908393; x=1720513193;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otSo2udX3h7wTjXOpCSchNr1uiFSVNX0FUCelZXem1g=;
 b=ODiOAEXUI+ZzSavIcucyTKOmEAi5ifErbnBs+4orlJ1qAero5owKfRkvrz9jdEPFNa
 zHMpZA7EGaODefGjVhLT0V/+8YotVJuHan9HfQWkWC6fVQ2Hze5aNLnGnxcFx6wyzleF
 K1jQKjlK+RrBymeTL7UL/PFLfQfChO49FgOEO9ocMwTGEiGBJymPesdJHeIOHRRqiWCH
 LJzA2LGkGumVNTKdRI6TDm7esZ1cPXUU4O2UwNwDYFKHUAdcQsXZV9Ob6loS5hYJoKRm
 11DlyzdaU3Ya+gE4/CI6Wtuawviicomp1JZD4yjsmItCTX22Z6qooaSL8xk9NFCS4Ybm
 43AQ==
X-Gm-Message-State: AOJu0YwzZBYQTS1EcFy9NKTo0MzoJAwih6y8k0H/gE3gZZ5mpBFSiWCm
 EbfAxBAq37w9VB38WMI/q3pG82iQeVBQedA2ygmjOqz6ywBMDzykOx5IIkzH/W/YlvVOAX2vQA4
 8bp9sACfi9+7jciFtePhNH1PJYlOd4zfFydPDVyh629uTsbOStscDPf0M+BdD
X-Received: by 2002:adf:e708:0:b0:367:8a24:dd2d with SMTP id
 ffacd0b85a97d-3678a24decfmr356443f8f.65.1719908393719; 
 Tue, 02 Jul 2024 01:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBmGCCz9UGRVuNyUIjFk64LNlPHM29aTSZHrScAFFDSz0TxgwfiPx15qA387iWNDQnQtQKcg==
X-Received: by 2002:adf:e708:0:b0:367:8a24:dd2d with SMTP id
 ffacd0b85a97d-3678a24decfmr356433f8f.65.1719908393356; 
 Tue, 02 Jul 2024 01:19:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:8e19:3414:44f0:befd?
 ([2a01:e0a:e10:ef90:8e19:3414:44f0:befd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9148sm12429806f8f.34.2024.07.02.01.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 01:19:53 -0700 (PDT)
Message-ID: <8e453d30-1bdd-4c6e-af00-0b3c115e9daf@redhat.com>
Date: Tue, 2 Jul 2024 10:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: update netdev stream/dgram man page
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20240626155140.74752-1-lvivier@redhat.com>
 <CAJ+F1C+1fmOfE_48iNxCRvxNB+Q_yBrJAUoAi7WyPx-=N756-g@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CAJ+F1C+1fmOfE_48iNxCRvxNB+Q_yBrJAUoAi7WyPx-=N756-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/07/2024 10:08, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jun 26, 2024 at 7:53 PM Laurent Vivier <lvivier@redhat.com 
> <mailto:lvivier@redhat.com>> wrote:
> 
>     Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
>     manpage.
> 
>     Add some examples on how to use them, including a way to use
>     "-netdev stream" and "passt" in place of "-netdev user".
>     ("passt" is a non privileged translation proxy between layer-2,
>     like "-netdev stream", and layer-4 on host, like TCP, UDP,
>     ICMP/ICMPv6 echo)
> 
> 
> Was there any plan to have passt fallback (default / "-net passt") when slirp is disabled 
> ? spawning the process with -F fd etc. That would help migrating away from slirp for some 
> systems.

Yes, I'm planning to add a "-netdev passt" that will start passt and connect it to a 
stream socket to QEMU. Perhaps at some point we can have a "-netdev slirp" and "-netdev 
user" will us by default passt?

I'm also working on a vhost-user interface for passt that will also improve performance of 
user mode networking with QEMU.

Thanks,
Laurent


