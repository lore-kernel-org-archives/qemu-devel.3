Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36212C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 05:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u60UM-0001iS-HQ; Sat, 19 Apr 2025 01:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u60UJ-0001i9-Kw
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 01:11:35 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u60UD-0006Sk-Cy
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 01:11:34 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4766631a6a4so25928221cf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 22:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745039485; x=1745644285; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teBy3OEPFdM4Vxh47FcYUjz5MyJuzLv+23/zL6OE3MM=;
 b=LqDA2vhCrEkKgAzuEtSXCoZazRpZTQPd1qjofpK1tDz1zTcdlzacNx+LuA9Hz0lLb0
 /XiaI+lmNuBFPiM79RNb4Wx0NtxugaTiRIRPWaMF41RbBixqfNm+soKgGrMu2c0ZeO69
 5fQ4gIvsazOEod3q37/zQLk3NdZMTd2fPN5lVnfqSUNNfRlsIeenC7RtmMfAj+RRXBtG
 xo7oG2aAzY+76eMFKQqJfT9ioG0+baA1XWp+7fndlgAMJxeWY3gRqvEZzzGm0QX7pvW+
 LIu60oxX0SG1JF87oCoVNlc5ScbalWnBo2PZq01878oPOSTvEu5UCQ28el6XtsC0WCfn
 3e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745039486; x=1745644286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teBy3OEPFdM4Vxh47FcYUjz5MyJuzLv+23/zL6OE3MM=;
 b=ezxhW7coh5KbFQs5x/3iOjJkRIjVPUNT4Fn7xuyTzSUCzm+s4l1hqM43A3UJWrcoAn
 OY+sxuV3GxFE82+XhDG5gJ27/Ud93Ea8diOFxnOTL5Q4xvy7HyMIJhC+OMdqVsm6UJav
 suFnPLAZQqC+sY2d5csSdOW4TObDTO3oKQYljLX8fnPt82noiRZHOkOlxW9dUhZErUJS
 GCVUFAHhbi7OlWEYisJ3gkFgI9vZzj9AqHrPMTPBUKF6h3VWjEX6Tcl3A5tizzckXCMT
 KSTbpaBxDoMvMOiggow5JUL+TCI+c4UK8C7cy+onkPSYz9/oG4+hXsHCBaz24RWU+Q7w
 Ty5Q==
X-Gm-Message-State: AOJu0YzWaec/C4pwJZx7pywUAxvijeeWlwcjIHzwCV8mNg7fSjQn2IFt
 Y8Si7gyO+P71xpSp7f13/yBl/K15qogvMMd+CDzy4bw3eijkuTEcbV5vd2eX7yflCfq0PYjsTsr
 ypddB+0tuqIxgozGzpGupLIomFDRaACtSLsQDNQ==
X-Gm-Gg: ASbGncuj5kITSzt/oa+Z4z4XsOCOVYf2EH+vaoW1VEngAr+L7LzG+v0SGMqwmNcX4iB
 G08AISx1ePQYlnM4p6A351++WpBFbCrTC2DziWCTeCmwemESOI0+Pvn7BXGo4NHwR+7Y/5t/yQk
 Mfe476T+sWLNxU2BKlddOZaWaziWqhrCZo6w==
X-Google-Smtp-Source: AGHT+IGHLTEjdr6AMuDCr+hfU5hkNEqjE75Z/fUio6tqLRr/s1QW1xjCOV2Ww4GghkGavqaHV0xvqsqHUXQ40GaaOew=
X-Received: by 2002:a05:622a:1a97:b0:476:5fd5:4de7 with SMTP id
 d75a77b69052e-47aec4b7606mr96602701cf.41.1745039485429; Fri, 18 Apr 2025
 22:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-2-dietmar@proxmox.com>
In-Reply-To: <20250418112953.1744442-2-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 19 Apr 2025 09:11:13 +0400
X-Gm-Features: ATxdqUEpwDLA9lxDddjRyvgPT54KEL3TA0tnL-kfR98_hyt9XCUdbBRtKcHAFTQ
Message-ID: <CAJ+F1CKpR-Z2+bs3T8Dzco3j7-cMcEDO2qKXCO8PNcc5nXk_bg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] new configure option to enable gstreamer
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

On Fri, Apr 18, 2025 at 3:51=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
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

(from v2 review)

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
>


--=20
Marc-Andr=C3=A9 Lureau

