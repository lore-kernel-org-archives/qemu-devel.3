Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4ED107BCC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w14yc-0004LI-0j; Fri, 13 Mar 2026 12:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w14yD-00047R-15
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:02:42 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w14y7-0002C8-RL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:02:34 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 09050db704188346b7c9b66743b658b511bd8e56111b7a289c12a94f60194008 with SMTP id
 69b43508f08442bfef00132a; Fri, 13 Mar 2026 16:02:16 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773417735;
 bh=lzKAixuZCayhFTV7+Vh4mud5fQweakyuorFaQ9FQW8I=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=MBmJDkVFrYvrEue4qkqAlDt3eFW6X66pNcMtYAeu+MkSHnPFQEh+hU1G1GBFZJ/Xl
 AsYgbbtEJ7hcp6Iyv64JdjG7rY1ZGkvJbkf3CMAxzB391+l6ZjxmBW6ozaE1sJWrw2
 GtBPOfTj4D3prZbZzxyxLqygrQ+kae8F4UYBMk1IdosLPolR4M3l+cPakWgcCG/u2W
 emWte8QocXvV8EroFIUh/T8i9C0xl5P1OUc4YPH7T1qljrDUXIyuARuNx59nuqhCCa
 2Kzq7Gso6KpHx9ucLQyAqVK2Tqf9+hMqMHqLT5ntZlohQHrptEC3L+fi50byVkYIwe
 qXjFgbdHT7mFg==
Message-ID: <19204615-dc07-4bc7-b662-f44ac3f23f97@yodel.dev>
Date: Fri, 13 Mar 2026 11:02:13 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] MAINTAINERS: Update the s390x maintainers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-3-thuth@redhat.com>
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
In-Reply-To: <20260313113424.15583-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dear Thomas,

On 13/03/2026 06:34, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> I'm going to move to another project next month, so I will not have
> enough time to take care of s390x patches anymore. Fortunately,
> Cornelia volunteered to take over the job of collecting s390x patches,
> and Eric and Matthew offered help to back her up, so we can keep
> the "S390 general architecture support" section in the "supported"
> state. Thanks for your help, Cornelia, Eric and Matthew!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Our correspondence had only begun recently, but as a QEMU user I
had been enjoying the fruits of your labor for much longer (though
I did not know it at the time). I'm so grateful for all of your
contributions and the help you so kindly gave during patch review.
I won't ask about this other project in case you have reasons not
to share it at this time, but I'll say this: in about a month, that
project is going to get a major upgrade in quality, and everyone
here will know exactly why.
Thank you for the time, energy, and care you put into QEMU!

Sincerely,
Yodel

>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49e9b7dccbb..9a859e4133a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -102,7 +102,9 @@ T: git https://github.com/vivier/qemu.git trivial-patches
>   Architecture support
>   --------------------
>   S390 general architecture support
> -M: Thomas Huth <thuth@redhat.com>
> +M: Cornelia Huck <cohuck@redhat.com>
> +M: Eric Farman <farman@linux.ibm.com>
> +M: Matthew Rosato <mjrosato@linux.ibm.com>
>   S: Supported
>   F: configs/devices/s390x-softmmu/default.mak
>   F: configs/targets/s390x-softmmu.mak
> @@ -1862,7 +1864,6 @@ T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   S390-ccw boot
> -M: Thomas Huth <thuth@redhat.com>
>   M: Jared Rossi <jrossi@linux.ibm.com>
>   R: Zhuoying Cai <zycai@linux.ibm.com>
>   R: Christian Borntraeger <borntraeger@linux.ibm.com>


