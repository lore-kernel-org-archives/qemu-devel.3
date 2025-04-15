Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6185C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4agM-0002uW-Sr; Tue, 15 Apr 2025 03:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u4agJ-0002pN-5h
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u4agH-0004FS-1S
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744701964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrySK1Xh6/PlCY9M5ixkBnYoIcMxsBwFfuAco65LJwA=;
 b=b/1DN/KYwuLqGAA0m+Tvyg7O9ngGdsCKCAUIiEXWD6iu6Ugo95sJXHboa85n1IFOK8dx6t
 QBRk2kdXRF284lpy97isAmmauHOyh6FQwRVwAN8tkwCwXX239zD9rtysxrgCo/zHlA8/9+
 oUqpZNZzkjBvt+Z3TMmA2+LYtWfeo8U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-S53gAirSP32Kob-TCTqoQw-1; Tue, 15 Apr 2025 03:26:02 -0400
X-MC-Unique: S53gAirSP32Kob-TCTqoQw-1
X-Mimecast-MFC-AGG-ID: S53gAirSP32Kob-TCTqoQw_1744701961
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c54e7922a1so1068930785a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701961; x=1745306761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrySK1Xh6/PlCY9M5ixkBnYoIcMxsBwFfuAco65LJwA=;
 b=JHq9vZ0PA0UJ72xHch4jHwuI9X71btEz7V0oqP1H4z5CWfUS23dIwadl53YiByzJNM
 Uaonag+vgty5k4lAdUcL2eZcAXEjQM3ivU+GBgh/hcM69hodv/7mIZGkVhWLRc+uoiiz
 h5o8PvPK+gMzXaQy7/PI1WFEZxsgcvg2zqCvjV6jJJLeS+kfaAPpY99A0aeJeFF8ZcNx
 jOIlzRbHB3j9HfR9Pf3VUDO1kZufYxsICarzfMI8HqUM44BamOZOCjyQ8NPAJnuYvOkg
 Kqfgec8LyUUInyk6xjte26toqIKZdPnIr706voIvYxXU+ix8wjwh4RI1SofBSrUUZTe8
 1ljg==
X-Gm-Message-State: AOJu0Ywg/g/1+2fiLx/UK9P6akhTjN47iPJz5G5QL4/xxUDVxuKkBvd5
 ebbkd+tXUbRX1KGDaXpOD3cg7QUPkdlIpioqZz3FnBSGxoTbmwBGXZvIVsyEaLX+/HfYvCiuctW
 cOyb0L9LI0czzjc5y6ap2pqjrFV0BDGuNpSK/s/YIh1yfbMwDVWJeV2pmMwEiVF2yF7guXW4ble
 cF02DrF0R1xlml4leg1xwDp+Lk4Y2GoaUC2+Q=
X-Gm-Gg: ASbGncuu8TCvC8SKpRkvua6zZPwAqCRgzKNV+/998GtolIPjDaA8LPDOlK13foA7hyY
 m+2ZHxpMvENuEkP+n5AG93DZPJRfIhy+55TbVwMEGjGUB4CnmG88C0hjmguLZiSGHDbXiow==
X-Received: by 2002:a05:620a:370b:b0:7c5:9a09:cb73 with SMTP id
 af79cd13be357-7c7af116621mr2004283785a.23.1744701961425; 
 Tue, 15 Apr 2025 00:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnemshrUz7zVgXv7lhraiNcenHaotWHxOGT5IxtpU+mlYFlPfuAVOoTXfsxUkn8lwvyksUjSI7yziLHucZJVs=
X-Received: by 2002:a05:620a:370b:b0:7c5:9a09:cb73 with SMTP id
 af79cd13be357-7c7af116621mr2004280485a.23.1744701961046; Tue, 15 Apr 2025
 00:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250410112238.3550155-1-dietmar@proxmox.com>
 <20250410112238.3550155-2-dietmar@proxmox.com>
In-Reply-To: <20250410112238.3550155-2-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Apr 2025 11:25:49 +0400
X-Gm-Features: ATxdqUFUMZ-jYiztDSi0wGqUDe1D1h3NhsBFkfqzM54x2YFrQ2gsymCPFkHDOSA
Message-ID: <CAMxuvawL-GGX0muqDWs3+vYt4pvRALycd_1oh_AxwxzdRyJNrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] new configure option to enable gstreamer
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Thu, Apr 10, 2025 at 3:22=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
> wrote:
>
> GStreamer is required to implement H264 encoding for VNC. Please note
> that QEMU already depends on this library when you enable Spice.
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  meson.build                   | 10 ++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  5 ++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 41f68d3806..28ca37855a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1348,6 +1348,14 @@ if not get_option('zstd').auto() or have_block
>                      required: get_option('zstd'),
>                      method: 'pkg-config')
>  endif
> +
> +gstreamer =3D not_found
> +if not get_option('gstreamer').auto() or have_block

rather "or have_system"

otherwise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +  gstreamer =3D dependency('gstreamer-1.0 gstreamer-base-1.0', version: =
'>=3D1.22.0',
> +                          required: get_option('gstreamer'),
> +                          method: 'pkg-config')
> +endif
> +
>  qpl =3D not_found
>  if not get_option('qpl').auto() or have_system
>    qpl =3D dependency('qpl', version: '>=3D1.5.0',
> @@ -2563,6 +2571,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_mall=
oc_trim)
>  config_host_data.set('CONFIG_STATX', has_statx)
>  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_GSTREAMER', gstreamer.found())
>  config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_UADK', uadk.found())
>  config_host_data.set('CONFIG_QATZIP', qatzip.found())
> @@ -4836,6 +4845,7 @@ summary_info +=3D {'snappy support':    snappy}
>  summary_info +=3D {'bzip2 support':     libbzip2}
>  summary_info +=3D {'lzfse support':     liblzfse}
>  summary_info +=3D {'zstd support':      zstd}
> +summary_info +=3D {'gstreamer support': gstreamer}
>  summary_info +=3D {'Query Processing Library support': qpl}
>  summary_info +=3D {'UADK Library support': uadk}
>  summary_info +=3D {'qatzip support':    qatzip}
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..11cd132be5 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -254,6 +254,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
>         description: 'SASL authentication for VNC server')
>  option('vte', type : 'feature', value : 'auto',
>         description: 'vte support for the gtk UI')
> +option('gstreamer', type : 'feature', value : 'auto',
> +       description: 'for VNC H.264 encoding with gstreamer')
>
>  # GTK Clipboard implementation is disabled by default, since it may caus=
e hangs
>  # of the guest VCPUs. See gitlab issue 1150:
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 3e8e00852b..b0c273d61e 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -229,6 +229,7 @@ meson_options_help() {
>    printf "%s\n" '                  Xen PCI passthrough support'
>    printf "%s\n" '  xkbcommon       xkbcommon support'
>    printf "%s\n" '  zstd            zstd compression support'
> +  printf "%s\n" '  gstreamer       gstreamer support (H264 for VNC)'
>  }
>  _meson_option_parse() {
>    case $1 in
> @@ -581,6 +582,8 @@ _meson_option_parse() {
>      --disable-xkbcommon) printf "%s" -Dxkbcommon=3Ddisabled ;;
>      --enable-zstd) printf "%s" -Dzstd=3Denabled ;;
>      --disable-zstd) printf "%s" -Dzstd=3Ddisabled ;;
> -    *) return 1 ;;
> +    --enable-gstreamer) printf "%s" -Dgstreamer=3Denabled ;;
> +    --disable-gstreamer) printf "%s" -Dgstreamer=3Ddisabled ;;
> +   *) return 1 ;;
>    esac
>  }
> --
> 2.39.5
>


