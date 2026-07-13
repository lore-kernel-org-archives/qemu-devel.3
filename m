Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E06C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 01:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj5gA-0005YT-4V; Sun, 12 Jul 2026 21:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wj5g7-0005YE-6u
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 21:41:51 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wj5g5-0002rT-8r
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 21:41:50 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so3236046a12.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 18:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783906907; cv=none;
 d=google.com; s=arc-20260327;
 b=pMtimZYqaofK7kqai5f1W0hXboWK8YAWZo5WpytT/30JpF9k5nHLT1K+2Lobok19ZE
 ZBSh7aFEDBVK2hkJtRvBcMpUiIIVUay2VtZRDnyBnuvZqCu252gSZZjydgZ+SVfvLZjO
 LnN1sF9lKFHVKLQiMKMA6kZp5sDOMnrUTFsieh3oCZ58Nc6eKXg3UpDy3wQtqkO3Sx/0
 2pZaq44FRybydpPXX62DmZPbXaHGa6pWVEFYB1fqqc9pBBfvvU3h4nZOm0BehPVOMxLG
 55L/Rw0Ie8gd2K0nIZ0+Y/U6OCXtNwY2e28Yz56Xd5oT/TQmHLfmd/8dfjOKaI2/MucZ
 rBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AwiOiCRt16pAPXIUqFNZHyYJIYj5AYW+wnMPM6QVZ2g=;
 fh=HMEqSDohimyZm5k0RbcfuA7BILj2eRFccruQ6ZFulDM=;
 b=mhUD6/1+5BBHWvOW+D1CTDCgSZlwdcB7Ya0KZl2DEkpeTUTCj9uSWt3MccmueeV1CR
 AmAy/+ycJccywuHRSW/qWa4Wgsx8jdkdZlT1bg/0HET/nr7NCfz05UVpfLMq33N/fmeB
 aCC29pD20eRb9TwEVM6KyKN91ffZE25I8/x+uZ0CP1OFKGn6bK/4O6bDGeZiORVAceA4
 ukq5X7QCNeHSLYAIhQBiVDcH//0HNUjqHeRli4AeESmyouxJjYqFwY6geBY26K3s4PU4
 qPBJxWtdlw5imij3HZhXH+QzwPSZkIa5eIfWSo2IvSFH1I3V0B4JnkUI8No4FNu0oh7t
 nDZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783906907; x=1784511707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AwiOiCRt16pAPXIUqFNZHyYJIYj5AYW+wnMPM6QVZ2g=;
 b=b4Sdejsyh5CkIaFPhCUA9/BTUsbM9sDVe/75PoARL+RTM5dRzB6lQ1jJo85Nx4QwdZ
 7DuYkEi/uq2iAd28e3SDRdeWRdx6mtTy9qwMkfpiUKAs7LN0K9u66nqRSGNhJVIG/SUP
 AyY+BokCLxNYbnDFG6EwC71eaQoehP9RLe8UrUjQMTLJb3QJ5LJ10GC7+LkEkMN6jNhq
 DlBgp5foHr4Boqc270/hspGt85GluyEdl2mq5YSLoQR64DLupItzRRCqOtVR3cgjKibR
 nfOZxhkb2lvkt8pFszBdZXzvCXXPdXeZUPqiXBRlxsix0I3To/x4WkiJ0EhdAJsDyM3L
 eKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783906907; x=1784511707;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AwiOiCRt16pAPXIUqFNZHyYJIYj5AYW+wnMPM6QVZ2g=;
 b=EBTZ9W8CkwlAhEoeMtOUXyAd5a3sHfS+4SWgSkf/xfi46kPRrE9Up3AQn0C6YGhvMC
 nbWK6O/IC6RDCChp7XSR+9Jj+46Tm0DTM2LEc7NYxmJafyv4Zi02e7IBPKIeMk84MaIG
 0qRMBzDIJngiXc41cgQjgJ9RwDGXFB+NOowi77DDNH/KelCyGk9sOYztWbF1KxBbCzA3
 /yoU66RfJ90V7Ra07QaU32qYmngGBIk+wdTfUwXhbuD0jbO6OynxuGmjRq8+Tmus8ZHt
 sOZghBMt8IA94brFeMOru/OaLyGJHMCy73ndY5qR+Fwrm+VU/McoQNyfGNFkly6BTvB0
 vPew==
X-Gm-Message-State: AOJu0YzWkVJY5ba2Qu1hqkENR37ElRm392JqbI/NlM47xO3iK+v2tijH
 NSKICJ5dRADXUYFOl4WzOh9PZtF/IS9IquBkDcGZAFaOoca8twDporNy85/IwXKvP5GPStO3qbQ
 jOSj9W+LuaQlWW3FomCLTQ0o2CCNO33JYKj533bg=
X-Gm-Gg: AfdE7cl8DMlPpH5DBqlJDx8XLQr4/QGVCDU2oQHIZ1wTvdQTZch7uR9TlBePfnBEOlK
 8KgQn0rHLfkQXYJ74UWltfqC5uqbdKyInGyq0zQ9DJerVGLkxpf51H3bvPiSy/jKSvGKqefQw6K
 9Zc0eeKnL9WPADTQ2jyFWxJm4WDH9Ztnujmf/QVcxF0Kj0DVDn82X6ei+jKu6c+vQygrUbJq623
 moHjiWuKanh9eVw4z2tdbki9cVGx88s1RUE+qo05ocwCd5l9cBwGOKNzfaEUfTTJ1F4zMN3vxM3
 j1FX9x4RBsbcOX74tvY+GoPN9Bn8KoW3XWEN7g==
X-Received: by 2002:a05:6402:50cf:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-69c5f102c59mr2950055a12.19.1783906906758; Sun, 12 Jul 2026
 18:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
 <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2026 11:41:19 +1000
X-Gm-Features: AUfX_mwdNliS1jq6559CIVZKK_7V2Vmm4eGtJiu0dVX8FuL7alxmj_nRYDNgeD0
Message-ID: <CAKmqyKPQj8wWC_f4xL9sJVg-CKb3FPG-or=34B2tF4i-pRjnZA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] build: add optional librpmi dependency
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 10, 2026 at 10:23=E2=80=AFPM Subrahmanya Lingappa
<subrahmanya.lingappa@oss.qualcomm.com> wrote:
>
> From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
>
> Add a meson option and config probe for librpmi so RISC-V machines can
> opt into RPMI support when the library is available. Keep the dependency
> optional so default builds without librpmi continue to work.
>
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.co=
m>

Can we add some documentation of how get librpmi support to work? Do I
just apt/dnf/pacman/apk install it? Do I need a certain version?

Alistair

> ---
>  Kconfig.host                  |  3 +++
>  meson.build                   | 14 ++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  4 files changed, 22 insertions(+)
>
> diff --git a/Kconfig.host b/Kconfig.host
> index 933425c74b..6f98dadb2e 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -8,6 +8,9 @@ config LINUX
>  config LIBCBOR
>      bool
>
> +config LIBRPMI
> +    bool
> +
>  config GNUTLS
>      bool
>
> diff --git a/meson.build b/meson.build
> index 19e123423b..103b4649b8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2005,6 +2005,17 @@ if lzo.found() and not cc.links('''
>    endif
>  endif
>
> +librpmi =3D not_found
> +if not get_option('librpmi').auto() or have_system
> +  librpmi =3D dependency('librpmi', required: get_option('librpmi'),
> +                       method: 'pkg-config')
> +  if librpmi.found() and not cc.has_header_symbol('librpmi.h',
> +                                                  'rpmi_service_group_lo=
gging_create',
> +                                                  dependencies: librpmi)
> +    error('librpmi support requires the RPMI logging service group API')
> +  endif
> +endif
> +
>  numa =3D not_found
>  if not get_option('numa').auto() or have_system or have_tools
>    numa =3D cc.find_library('numa', has_headers: ['numa.h'],
> @@ -2427,6 +2438,7 @@ config_host_data.set('CONFIG_LINUX', host_os =3D=3D=
 'linux')
>  config_host_data.set('CONFIG_POSIX', host_os !=3D 'windows')
>  config_host_data.set('CONFIG_WIN32', host_os =3D=3D 'windows')
>  config_host_data.set('CONFIG_LZO', lzo.found())
> +config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
>  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>  config_host_data.set('CONFIG_BLKIO', blkio.found())
>  if blkio.found()
> @@ -3258,6 +3270,7 @@ host_kconfig =3D \
>    (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=3Dy'] : []) + \
>    (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=3Dy'] : =
[]) + \
>    (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=3Dy'] : []) + \
> +  (librpmi.found() ? ['CONFIG_LIBRPMI=3Dy'] : []) + \
>    (have_rust ? ['CONFIG_HAVE_RUST=3Dy'] : [])
>
>  ignored =3D [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
> @@ -4971,6 +4984,7 @@ summary_info +=3D {'TPM support':       have_tpm}
>  summary_info +=3D {'IGVM support':      igvm}
>  summary_info +=3D {'libssh support':    libssh}
>  summary_info +=3D {'lzo support':       lzo}
> +summary_info +=3D {'librpmi support':   librpmi}
>  summary_info +=3D {'snappy support':    snappy}
>  summary_info +=3D {'bzip2 support':     libbzip2}
>  summary_info +=3D {'lzfse support':     liblzfse}
> diff --git a/meson_options.txt b/meson_options.txt
> index a07cb47d35..9f773a7886 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
>         description: 'lzfse support for DMG images')
>  option('lzo', type : 'feature', value : 'auto',
>         description: 'lzo compression support')
> +option('librpmi', type : 'feature', value : 'auto',
> +       description: 'RISC-V RPMI support')
>  option('pvg', type: 'feature', value: 'auto',
>         description: 'macOS paravirtualized graphics support')
>  option('rbd', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index c003985047..e8a20068e7 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -140,6 +140,7 @@ meson_options_help() {
>    printf "%s\n" '  libkeyutils     Linux keyutils support'
>    printf "%s\n" '  libnfs          libnfs block device driver'
>    printf "%s\n" '  libpmem         libpmem support'
> +  printf "%s\n" '  librpmi         RISC-V RPMI support'
>    printf "%s\n" '  libssh          ssh block device support'
>    printf "%s\n" '  libudev         Use libudev to enumerate host devices=
'
>    printf "%s\n" '  libusb          libusb support for USB passthrough'
> @@ -376,6 +377,8 @@ _meson_option_parse() {
>      --disable-libnfs) printf "%s" -Dlibnfs=3Ddisabled ;;
>      --enable-libpmem) printf "%s" -Dlibpmem=3Denabled ;;
>      --disable-libpmem) printf "%s" -Dlibpmem=3Ddisabled ;;
> +    --enable-librpmi) printf "%s" -Dlibrpmi=3Denabled ;;
> +    --disable-librpmi) printf "%s" -Dlibrpmi=3Ddisabled ;;
>      --enable-libssh) printf "%s" -Dlibssh=3Denabled ;;
>      --disable-libssh) printf "%s" -Dlibssh=3Ddisabled ;;
>      --enable-libudev) printf "%s" -Dlibudev=3Denabled ;;
> --
> 2.43.0
>
>

