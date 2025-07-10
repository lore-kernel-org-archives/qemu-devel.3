Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D541C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZp03-0001kw-3S; Thu, 10 Jul 2025 06:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZp01-0001jC-F9
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:59:33 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZozz-0001eI-9J
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:59:33 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae35f36da9dso157065466b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752145169; x=1752749969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qRIH7hDx9QeiMNstYmr1eVSJvrCPinsAcsApTD21uU=;
 b=q7qZdLM28iLbRpNJWi7t6CNzZVrKnyOhcklACz6ZvlQRfjdePckJv+s8xoA4Me2rOt
 r2pvC9dqZx8RTGGYNYampkhjasgVz1IfD/G+x9swggM99AFP2ukWbEigd6VSj2ZVd79q
 qv1ZZDYNFOM74n/gscF97k0uOB/bWRsWSHRgjz7ogwarP3LjImEZhy0v0aNjRFC+5qZV
 uYelHVfYPPzBTpzX0PCmUyuqTSNbW1wtslE3RG5ocRapKtG0Zj1lhvyBn7SLAyIP2KJt
 8cdnvka9yq90/j3Nof77puS/CjPQcobWLZIgy2u+0pG5OitPnwblbCIHzNLN1gswQKax
 ff3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752145169; x=1752749969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qRIH7hDx9QeiMNstYmr1eVSJvrCPinsAcsApTD21uU=;
 b=WpugHHzu2mWh0/T/mTFOiIBgWhLNjRTtajcLjkiEuL0CaT4ZyrG2QlQET8fLVmS4o2
 n3PJ3Ys3eEEOBfLUI/feAtzjNZ4Gw7N7vHPm9xmQdKz/8qKNS20NnTkgIhA5L/+aKPOJ
 7F5STYHT2S6iI855I2jUrQVnkA1lDCtWXuByM+czFyD8bw2+9oN53EBYGxDqjPfyh5HJ
 XaJ+KczmZzuIj2lnlvm3JRj/VDVWERD97rCAFINjWK1Oh31fYb35crVjBBL1SNofgtyC
 TavJqb6obeYCvFo95eQX91Jb7A5LEWizQXW3zfac4hgKxF6js+4KdV6hEESzYQUT0Nkk
 9swA==
X-Gm-Message-State: AOJu0Yw/lBKlCyZFbI4XHn6J4Rz6L9EuesKYYfL32S8Wx6Hwq0/KOcoE
 VZJJwEhPxb9LdQZC4iTJ7+/PIHMSYqhzoD3ZE5P6x56KCjQcniS/v2C+3XWAXiBRUKij3bPWW6e
 mpZRMvS2WG848lzVz0foLe8ruZ7tEdRrwOris3WXp2w==
X-Gm-Gg: ASbGnctVftZuUz2JEtjWMU4l4L078Jk8khF6wH7UIGgufw86BLy/FaDWr7g9wMpdLZ5
 2qQBC0hzLtb3M54fMsUtMhpjKKqnnWqXQ/1LwwaytcjOE7QyYL2n2rP3cIDLDRal1XGe4W6YLY/
 DWWVWbC3gn+KpFfXow9U41vXjPjmBFWwp6N2Ej9KZhkYU=
X-Google-Smtp-Source: AGHT+IHgpVDZBd4s2xW07tV5/tScEQ6G48svxEsjqpFgBC+wy09dAc/wcmNj1KzifTgMm3M6eO18qD3ZImzvL95uc+4=
X-Received: by 2002:a17:906:f5aa:b0:ae6:d421:a745 with SMTP id
 a640c23a62f3a-ae6e70fe856mr249811266b.57.1752145169024; Thu, 10 Jul 2025
 03:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
 <20250710104531.3099313-8-alex.bennee@linaro.org>
In-Reply-To: <20250710104531.3099313-8-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 13:59:02 +0300
X-Gm-Features: Ac12FXyIGSU0W67VAPE74wdoxmr8J79tHZ8eJr3JCG0M1GXG_3ceO0LrhIynUuM
Message-ID: <CAAjaMXY-RNiwcWB9Sz-JvCHR3MN+EWb86X+to59HiqoT=WPPgQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] docs/system: clean-up formatting of
 virtio-net-failover
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Thu, Jul 10, 2025 at 1:46=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> We didn't clean-up the rst formatting when we moved this into the
> docs so lets do that now:
>
>  - un-indent the usage/hotplug/migration paragraphs
>  - properly wrap the command line fragments in code-block
>  - highlight parameters in text with ``double quotes``
>
> No changes to the actual text.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/virtio-net-failover.rst | 51 ++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/docs/system/virtio-net-failover.rst b/docs/system/virtio-net=
-failover.rst
> index 6002dc5d96..0cc465454c 100644
> --- a/docs/system/virtio-net-failover.rst
> +++ b/docs/system/virtio-net-failover.rst
> @@ -26,43 +26,48 @@ and standby devices are not plugged into the same PCI=
e slot.
>  Usecase
>  -------
>
> -  Virtio-net standby allows easy migration while using a passed-through =
fast
> -  networking device by falling back to a virtio-net device for the durat=
ion of
> -  the migration. It is like a simple version of a bond, the difference i=
s that it
> -  requires no configuration in the guest. When a guest is live-migrated =
to
> -  another host QEMU will unplug the primary device via the PCIe based ho=
tplug
> -  handler and traffic will go through the virtio-net device.  On the tar=
get
> -  system the primary device will be automatically plugged back and the
> -  net_failover module registers it again as the primary device.
> +Virtio-net standby allows easy migration while using a passed-through
> +fast networking device by falling back to a virtio-net device for the
> +duration of the migration. It is like a simple version of a bond, the
> +difference is that it requires no configuration in the guest. When a
> +guest is live-migrated to another host QEMU will unplug the primary
> +device via the PCIe based hotplug handler and traffic will go through
> +the virtio-net device. On the target system the primary device will be
> +automatically plugged back and the net_failover module registers it
> +again as the primary device.
>
>  Usage
>  -----
>
> -  The primary device can be hotplugged or be part of the startup configu=
ration
> +The primary device can be hotplugged or be part of the startup configura=
tion
>
> -  -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:6f:5=
5:cc, \
> -    bus=3Droot2,failover=3Don
> +.. code-block:: shell
>
> -  With the parameter failover=3Don the VIRTIO_NET_F_STANDBY feature will=
 be enabled.
> +  -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:6f:5=
5:cc,bus=3Droot2,failover=3Don
> +
> +With the parameter ``failover=3Don`` the VIRTIO_NET_F_STANDBY feature wi=
ll be enabled.
> +
> +.. code-block:: shell
>
>    -device vfio-pci,host=3D5e:00.2,id=3Dhostdev0,bus=3Droot1,failover_pai=
r_id=3Dnet1
>
> -  failover_pair_id references the id of the virtio-net standby device. T=
his
> -  is only for pairing the devices within QEMU. The guest kernel module
> -  net_failover will match devices with identical MAC addresses.
> +``failover_pair_id`` references the id of the virtio-net standby device.
> +This is only for pairing the devices within QEMU. The guest kernel
> +module net_failover will match devices with identical MAC addresses.
>
>  Hotplug
>  -------
>
> -  Both primary and standby device can be hotplugged via the QEMU monitor=
.  Note
> -  that if the virtio-net device is plugged first a warning will be issue=
d that it
> -  couldn't find the primary device.
> +Both primary and standby device can be hotplugged via the QEMU
> +monitor. Note that if the virtio-net device is plugged first a warning
> +will be issued that it couldn't find the primary device.
>
>  Migration
>  ---------
>
> -  A new migration state wait-unplug was added for this feature. If failo=
ver primary
> -  devices are present in the configuration, migration will go into this =
state.
> -  It will wait until the device unplug is completed in the guest and the=
n move into
> -  active state. On the target system the primary devices will be automat=
ically hotplugged
> -  when the feature bit was negotiated for the virtio-net standby device.
> +A new migration state wait-unplug was added for this feature. If
> +failover primary devices are present in the configuration, migration
> +will go into this state. It will wait until the device unplug is
> +completed in the guest and then move into active state. On the target
> +system the primary devices will be automatically hotplugged when the
> +feature bit was negotiated for the virtio-net standby device.
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

