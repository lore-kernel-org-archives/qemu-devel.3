Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16039D59F53
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 23:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUCe4-0003ne-8q; Fri, 12 Dec 2025 18:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vUCe2-0003nK-RB
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 18:33:54 -0500
Received: from m228-31.mailgun.net ([159.135.228.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vUCe1-00089M-51
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 18:33:54 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 27c2015fbf8d1903b07aee4363a9131f916608f32f4d32e868b3f954c8c702db with SMTP id
 693ca6577fb35aba9573efde; Fri, 12 Dec 2025 23:33:43 GMT
X-Mailgun-Sending-Ip: 159.135.228.31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1765582422;
 bh=cMQPg7v3DwE4MXXLruYCnKON1p6jkTly0q8R9f4/keI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=mBoopMD0xr3RN5nlXNr2BZXcgv+9uRU+yy7sn+xWkSenU8db6YTqB5xen1+vPEUuj
 tKv70DgU9N0xsJeUjT6NyNMnJJGc5c+nocTAUEAywCKXJGReRjq6Z9X4LE14gAztEG
 ggyCqSmW/G36XzD2Wg7qZ0dMzHxgTTbf8v5hNNgXSGfY48d/7TJy8yGEyKvjQiU2uu
 56oyOZ03YP/ct0WY3BSOjG+a1JCiv0z1JF2a/R63RRVJ5KAhWUJMYprBZanhwXfOPN
 rALWQl0AsBEeX0tx5twnGadMhTCcBqrdY2WEV7Hw0CnUWoathg1eff0Yt7vRAj9h1e
 ytPz1eEqixsig==
Message-ID: <bc52f621-493d-4df6-8403-1e4c7e2be424@yodel.dev>
Date: Fri, 12 Dec 2025 17:33:40 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] tests/vhost-user-bridge.c: Fix const qualifier build
 errors with recent glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-3-clg@redhat.com>
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
In-Reply-To: <20251210181306.926334-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=159.135.228.31;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=m228-31.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi, Cédric!

On 10/12/2025 12:13, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
> ../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    749 |     char *p = strchr(buf, ':');
>        |               ^~~~~~
> 
> Fix this by using the glib g_strsplit() routine instead of strdup().
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/vhost-user-bridge.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index a5c711b1de8e9c164dd1614f4329b8e3c05d0402..ce4c3426d3938a0b54195f3e95bb1f1c3c4ae823 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -746,14 +746,12 @@ vubr_run(VubrDev *dev)
>   static int
>   vubr_parse_host_port(const char **host, const char **port, const char *buf)
>   {
> -    char *p = strchr(buf, ':');
> -
> -    if (!p) {
> +    g_auto(GStrv) tokens = g_strsplit(buf, ":", 2);
> +    if (!tokens[0] || !tokens[1]) {
>           return -1;
>       }
> -    *p = '\0';
> -    *host = strdup(buf);
> -    *port = strdup(p + 1);
> +    *host = g_steal_pointer(&tokens[0]);
> +    *port = g_steal_pointer(&tokens[1]);
>       return 0;
>   }
>   

Thanks for addressing this before the glibc change is widely propagated
among distros.

Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>

For testing, I built and installed glibc (76 commits ahead of cd748a63a)
in an x86_64 Linux container and built vhost-user-bridge on top of that.
Ran it with:

./build/tests/vhost-user-bridge -H

qemu-system-x86_64 \
     -enable-kvm -m 4G \
     -object memory-backend-ram,id=mem0,size=4G,share=on \
     -numa node,memdev=mem0 -mem-prealloc \
     -chardev socket,id=char0,path=/tmp/vubr.sock \
     -netdev type=vhost-user,id=net0,chardev=char0,vhostforce=on \
     -device virtio-net-pci,netdev=net0 \
     -drive file=linux.qcow2

and visually inspected the logged traffic.

Thanks,
Yodel

