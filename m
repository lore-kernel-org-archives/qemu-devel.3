Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451460A261D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBgmPyEW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqvE-0003re-UM; Mon, 02 Nov 2026 07:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xNqvD-0003rN-Jg
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:13:55 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xNqvB-000082-UR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:13:55 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c4550d8ab15so340263266b.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 04:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793621632; x=1794226432; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=te4k0OiRLza6Lo4n+zDXw1Zis7YXCaGEKmKMBfphC5k=;
 b=uBgmPyEWdo+mY0hxR+Zpj7T8v33hXa2JYeK/hQnVYNBcIQtUW6pPFdLrfZYmWi+1ow
 u6NvnWIF57Ti7cdMC98yzb5bQfUZGQZhDo1WmnIFVU59r1G2pS00AqojEMcZg+BHIuIy
 4yh0UmNsfMmZHtBMGp2oKZ6/SrRV8uZM8WOoRP5xB0olRBzuosKZ2mPsLv5zU0WhZcPO
 GSFp/6jaI2ukgB6NGcxoR25ZAPVlEHC7C9l6wsq8gjQfuNr2XjOZcZlotovbrOMeD1Fx
 J7p2D/A5xz06mUtLPDJ4P8DK3HbKZf4kz+J62tg+fDk/aBF88Q+VhZ2pHFuOBAoWBP8X
 Auuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793621632; x=1794226432;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=te4k0OiRLza6Lo4n+zDXw1Zis7YXCaGEKmKMBfphC5k=;
 b=Ttw+mm9QXaYOsuLOWYw2I7N30VazjIbR3qv7/l6r53hAem4mVH/JDBg8QofU6gQZd5
 7aLjmNx7v7NWBpwMINyR5FmJneKXC0lXcb5unxUUFJHZYj6g35ErkjYeKShVR4NJdFkw
 DbiI2hRS3NMzNXmx0eJWkQJm5I0ZRPgOAIjS/SvFIOjzxUThPrZnGJiSJXQpzQ/BTKV8
 7+hYT4SKyLq25B9KJGg7Rzlk6VmY9MCwTi2PJ7D83/9T6CxinNDomWsVL4F6uwfNl8R/
 m6gyPPD8rJivR9YcozLEbzvwC4M7WhlauWYix12rxwyBVN++ojAzIEU6cuajvBa0hhEZ
 7jDA==
X-Gm-Message-State: AFq9FYKclHdolGBkXFMxzMWPUgJrLB8BYcOzOd4cAOikn/bh0lLACCD/
 B/Hq+pyLkMmBI5SKR1l0Yzei3DLRBDA79rWCOf3+Ags2+l+i2tpokDQErgVRlofNMuk=
X-Gm-Gg: AYBFou1T3UGbQvG4pVnsewF1RJ6QFwnXAkl47g07Pbeqdzvie7I+TXk+B385mBh/DkB
 VFJpbqjuvhazvk4c3M3579mQTooK0nFXhAMYVs3CuG87knBYLOpTT6n8ZPsh7t15rZ236MXVRJB
 JFqQSp/ls9nR2BVZRD0Y0TEmiZN/H7uY4HD63+jNf/kCLBrdtICeQTPqcH0JfLF3/x6l/DUPdba
 3X3wTqO0HhvqmSkL62whNav8L89hOQzjDhMPJ/TVoVp6qll9mducFb3sYJTgFUOhy93yu9Of5So
 azpDyUtial5Hj0jnJgZ1qxqRUhDp4yWBx7onj7mGWlzpBTDXqMnmqTdp/OVaVrItkTKRsiZ568T
 tffO9rGT3fxOK0O5jrhy9cuq6ZaPjPJ0/WLt9cOFz9q2+F/YGj/iqZ+fdd7ZDlTW/bz7nj32KRW
 SwYg9ICUfuiJcMyrxmgy5KKT++Ngl0yfxNJb/HZ843wMWRnaUhjqzeOu6410gqG6pds5Hm28UIu
 Md5TJqHHsL4b2+3KWS+DxRPHKfhkbwFiFw681Yp1CN7f9ZzFdfqkvJiFAFbtITc+BmvGdz4AamW
 Oaadojfv6l1dp4yJsfS6Ha0jU7lGKcokYGiflOSrR7s6YAE7UaV4Ft1ICTmrTq3yAMvvjBBweVj
 4pacen5+E0MuOEbtq3nNniWBRBWEEOlRKmBwb6FtbcRsGuQ==
X-Received: by 2002:a17:907:e849:b0:c35:d50a:1352 with SMTP id
 a640c23a62f3a-c4ca7a55635mr759332766b.11.1793621631734; 
 Mon, 02 Nov 2026 04:13:51 -0800 (PST)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4aa07sm389918566b.63.2026.11.02.04.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:13:51 -0800 (PST)
Date: Mon, 2 Nov 2026 13:12:46 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, michael.roth@amd.com,
 kkostiuk@redhat.com
Subject: Re: [PATCH 2/2] meson.build: fix getifaddrs() detection on illumos
Message-ID: <auh-OAbaZfTvMKHU@tulp>
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
 <20261015173250.65942-3-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261015173250.65942-3-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Roman Bogorodskiy wrote:

> Currently, getifaddrs() fails to get detected on illumos
> because it requires linking with libsocket which meson
> is not doing.
>=20
> Fix by adding socket to getifaddrs dependencies. This
> unlocks 'guest-network-get-interfaces' implementation
> for illumos.
>=20
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/meson.build b/meson.build
> index 432a333f56..20407024fa 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2644,7 +2644,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_funct=
ion('timerfd_create'))
>  config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
>  config_host_data.set('CONFIG_ARPA_INET_64', cc.has_function('htonll'))
>  config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_=
range'))
> -config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
> +config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs', de=
pendencies: socket))
>  config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
>  config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependen=
cies: util))
>  config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', pref=
ix: osdep_prefix))
> --=20
> 2.55.0
>=20

ping? (for meson.build changes)

