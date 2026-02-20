Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A93C5CFE6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 22:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtYaz-0002Xo-5d; Fri, 20 Feb 2026 17:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vtYax-0002Xf-Ko
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 17:03:31 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vtYav-0001sb-OK
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 17:03:31 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 33a7a2fd7c2028b854d60a31ace0b06d6ff6280ad57941bbd0d4bf2a74bcc483 with SMTP id
 6998da27afc0c105805ecdaf; Fri, 20 Feb 2026 22:03:19 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1771624999;
 bh=3eqlh91QcE7Cfu6/M8CpQgvcFBXLI81+blWz11VyZJo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=TM9QcYAo3GWaYCD3aubKGV7JJxafN+LzqeoDMJXv1ViScJZzwxiBv0oVYUep7VyOE
 uGoR22/3RR6qnU99K57sU1xZJWavzGonRvMv3cYcuDvfYxV/MOXe0V9Gwy/o0zHHMx
 QNbKcQh48hGCrVPRlhULRqLJjntWGq0gMU2rkiTwqTmCiNSi8MWlgezpqEpDLunqMt
 elafGc/ZcM5YkmzdVgGxY2bjgtwZE8Uah8xyt1NDzpEUiaFGJOGewZV6h8wa6U9Xui
 hgcp9wse6LBGETVymZvc6SQjYrhVV0VDscP/tO48uYgWwNx1LV1GBGkGsHY/2JUFTi
 n7fFU1nf5hCzQ==
Message-ID: <01dde2d8-b080-413e-a0d6-2f76805cc8ab@yodel.dev>
Date: Fri, 20 Feb 2026 16:03:17 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] vhost-user-bridge housekeeping and test
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260129133049.119829-1-yodel.eldar@yodel.dev>
 <cba38de0-38c0-4d99-9d50-a028fa6510e0@yodel.dev>
 <749d684e-d4a4-43ea-af55-bd901ac7b97f@yodel.dev>
 <20260217100300-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260217100300-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Michael

On 17/02/2026 09:03, Michael S. Tsirkin wrote:
> On Tue, Feb 17, 2026 at 08:56:12AM -0600, Yodel Eldar wrote:

...skipping...

> 
> i will queue this shortly.
> 
> 

Thanks for picking up my series and for agreeing to shelter the
functional test under your umbrella.

Regards,
Yodel

