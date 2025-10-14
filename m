Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEC9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XuY-0006nJ-SE; Tue, 14 Oct 2025 01:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v8XuQ-0006lc-1z
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v8XuN-0000ck-HX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760420953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlgqWpjRtyfSLMKZsUvtBDHwP8AHMvoaqt2qBdDaXo0=;
 b=A+M+qxKumEpXFz4BDTWZI2072VLagny+3hntylCR3nDvOfMSQPc/cwE2qLVPAiWC1gYHWa
 pxu9XAQH9bhPsjOSeFGNVAnVKIQiNwxwGlcGhPDCMvNctDtDHHMP7D2Kbqe8ISDMVmpLHT
 LidBwuz74bkETLy8ZOrBHw64wCYSgAA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-9Yn8NE-JPCyntHsfHPJpPQ-1; Tue, 14 Oct 2025 01:49:11 -0400
X-MC-Unique: 9Yn8NE-JPCyntHsfHPJpPQ-1
X-Mimecast-MFC-AGG-ID: 9Yn8NE-JPCyntHsfHPJpPQ_1760420950
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3307af9b55eso8321317a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760420950; x=1761025750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlgqWpjRtyfSLMKZsUvtBDHwP8AHMvoaqt2qBdDaXo0=;
 b=FyQXNX8GBJrzGMdDt8oL+vMCIl+BvYw/LbxCPJbmfPVpOl5fJUByIW7Q2oLc4NTtNB
 1CZrl4DDe6TV07pgw6g9CXsuK23uQsWA/o6act1hnrAYfcF37nuLSAsXFxoZ0KA+TNe/
 KlX5XRsmP6of6RkFfAKmJ+dsfCKq77M6zhue1uV9M23uCMxXYoL9DWbj7oqlbdZ3R50b
 dPMilxeYRrlR7ZhqZBzhI9iPy8AXO9Qb3laED3xJ4p97AI80P5Fmi67bhtYxP8HoSxAp
 RUpH765vbim/Q0bp/VdY81EXvXnVoYqyCXPWOu3JB4qUqt4wYs1YVLfijYe7kts8xI8t
 K9mQ==
X-Gm-Message-State: AOJu0YxGyXBgiWMEtFCr3fs6qYAlsCwECIFHxTol+ymRvTLYQyMyJae8
 kEVPjQroE2Sj7nvJXQVXYJ6JWDlNrVt3NlNJqOtgzg0pu2l6KLcO1OKuV3R+9bu0BdxE4RVleLN
 ZpiG5JcjnZWOOFxg96/5hI3xZsE5zHm4Lvw98DPDLiRUq5jrAf8Jx9nEg67QfnZESmJpEXF/nXF
 vOmgDw5kr0Yrs6jPqYj+n3OY0lstVZW3o=
X-Gm-Gg: ASbGncvO/emPLjID3LwHKVEGKIYucuNWN18Iq7XppbWqZab9kbihNWpnETJ0LbGN0ad
 7SYf8o9GRHAvj6RS6ymNkxpjNc2+g38IUKGhqMXH2B3EAow2sj/uPip3hy0sEvlaW/LX9NbLoFl
 eO4woofC9E6PTMpIuAbedkHQ==
X-Received: by 2002:a17:90a:d44d:b0:32e:e186:726d with SMTP id
 98e67ed59e1d1-33b5138e3e0mr31458416a91.31.1760420950146; 
 Mon, 13 Oct 2025 22:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvOmyoP3eHSfje5Z6bnvA4qGAW68mncg71OeK/fYHX2DlSIJnJXMGw+HDYj6oboJWMdEIYV53n6aXeLFf9u7U=
X-Received: by 2002:a17:90a:d44d:b0:32e:e186:726d with SMTP id
 98e67ed59e1d1-33b5138e3e0mr31458398a91.31.1760420949739; Mon, 13 Oct 2025
 22:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250901153943.65235-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250901153943.65235-1-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 13:48:57 +0800
X-Gm-Features: AS18NWB6j_sw9ZspVXfR35Sn9LCb_H8U-RGZ80zbj0rNZwHp2RsECcQZMxlpxwA
Message-ID: <CACGkMEtD3_WP51=XPFM6oTsrSUCHkm9+ukEEWC68iayCKzNU9Q@mail.gmail.com>
Subject: Re: [PATCH v3] qapi: net/tap: deprecate vhostforce option
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 1, 2025 at 11:39=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This option doesn't make sense since long ago (10 years!)
> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").

qemu-options.hx still say:

"""
    "                use vhostforce=3Don to force vhost on for non-MSIX
virtio guests\n"
"""

Should we fix that as well?

>
> Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
> (that don't have MSI-X support), you should have set vhostforce=3Don
> (with vhost=3Don or unset).
>
> Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
> for vhost-enabling options logic.
>
> The current logic is:
>   vhost=3Don / vhost=3Doff : vhostforce ignored, doesn't make sense
>   vhost unset : vhostforce counts, enabling vhost
>
> Currently you may enable vhost several ways:
> - vhost=3Don
> - vhostforce=3Don
> - vhost=3Don + vhostforce=3Don
> - and even vhost=3Don + vhostforce=3Doff
>
> - they are all equal.
>
> Let's finally deprecate the extra option.

Note that vhostforce works for vhost-user as well:

{ 'struct': 'NetdevVhostUserOptions',
  'data': {
    'chardev':        'str',
    '*vhostforce':    'bool',
    '*queues':        'int' } }

Should we change that as well?

>
> Also, fix @vhostforce documentation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>
> v3: - two spaces between sentences for vhostforce description
>     - add r-b by Markus
>
>  docs/about/deprecated.rst |  7 +++++++
>  qapi/net.json             | 11 +++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d50645a071..b17a5a41aa 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>  The ``reconnect`` option only allows specifying second granularity timeo=
uts,
>  which is not enough for all types of use cases, use ``reconnect-ms`` ins=
tead.
>
> +TAP ``vhostforce`` (since 10.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``vhostforce`` option is redundant with the ``vhost`` option.
> +If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
> +
> +
>  VFIO device options
>  '''''''''''''''''''
>
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..bab26e0c5d 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -346,13 +346,20 @@
>  # @vhostfds: file descriptors of multiple already opened vhost net
>  #     devices
>  #
> -# @vhostforce: vhost on for non-MSIX virtio guests
> +# @vhostforce: enable vhost-net network accelerator.  Ignored when
> +#    @vhost is set.
>  #
>  # @queues: number of queues to be created for multiqueue capable tap
>  #
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# Features:
> +#
> +# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
> +#    option is redundant with the @vhost option. If they conflict,
> +#    @vhost takes precedence.  Just use @vhost.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -369,7 +376,7 @@
>      '*vhost':      'bool',
>      '*vhostfd':    'str',
>      '*vhostfds':   'str',
> -    '*vhostforce': 'bool',
> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>      '*queues':     'uint32',
>      '*poll-us':    'uint32'} }
>
> --
> 2.48.1
>

Thanks


