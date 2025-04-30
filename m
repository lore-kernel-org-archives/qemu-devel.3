Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71269C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA21t-0004Yb-8u; Wed, 30 Apr 2025 03:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA21r-0004YJ-9I
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA21p-0005yD-9L
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745998726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Ng7O6TUPIZXkCsW/9yzV1cXjwD4T5lUtAWSo859F58=;
 b=goclI9jxzbZpDRobQJkfcP0ieHl5I2ws6hVIPE5DgKePpjnxkGaS3YuFwPsvDvbwkFtEkR
 5tLJxDyItqjtfE+qPftRpmbzNUkH0fyGq1nJ963cc3CGyDWtlNv680x5toNWELsIWLtxx9
 2GbJPlkNOshv8tdWs4yx4VZ2gsu3FNI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-FgNCPvgXPI2jAh-VZtSH2A-1; Wed, 30 Apr 2025 03:38:43 -0400
X-MC-Unique: FgNCPvgXPI2jAh-VZtSH2A-1
X-Mimecast-MFC-AGG-ID: FgNCPvgXPI2jAh-VZtSH2A_1745998723
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391315098b2so2031385f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 00:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745998723; x=1746603523;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Ng7O6TUPIZXkCsW/9yzV1cXjwD4T5lUtAWSo859F58=;
 b=K4GxaaOX72aX8gaArj8J2sulUCicOY/f9AtRZ1hG2lQZfh7ETYFukx0m3jhNlXNEnN
 BgakUB5Gq4gTuWn+svz7CfzMPEU/w4t3HkhEUQrzg4XwPS4jM/8Am+io08s3DGqt4sv5
 qL6SpxMPaTlX1+DvlLr081XERr/RoKZaf6J+nZO6HawEIzWZDfXnF7/bvjLooATFvjZt
 LpjsNg3jiL10YicegwdCOEOTGQjS/HEhHTCZxSWr3PjbPytI0/uVCI7XIiNyZUWH/RrX
 jmHoGkxT36XLLP1p/y/FtqSfrqEBjXpIsZoXKTdIBDyC7p3/P2tTNiVwdewetV0Pu+KV
 MoeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdfTsepqkkNplfnwTFOiQ813KJ4tICrm98xKHl4mBq4wHkFOlJciV5bMp3Ug+oFZg6o2Cm2kOrgiOp@nongnu.org
X-Gm-Message-State: AOJu0YzlBt8hPkGfQUy2zuADtX9kdSDkh8NqOaYkcxA1sY9f76sLka5U
 CdoY9CMi4iNVtQu/fhn7lBtBaeH4mDVcQivfgxAkb6uhrzekCLjCOWftTbT9xDoV2wm763T32Ob
 Bsnm4YBE7fyyitvsP91f80P1WWRW4exzP7fGv6qSc1egq4nFAFjGv
X-Gm-Gg: ASbGnctdaUNX8Ul9GI1sHMKRwc6v085AGW2jx2K9UqBaaOotDXdEN/4gb2MKOdFeiiI
 ztXgaldst+GFH+ytz5SxCRCTYolqlPzr7r2kqvQzVAW+ci8e5ul78xQYj4nEWHkt0LBfa+KGuEN
 sAXz0rcPwGqSAAbNL/WotgV2fvcUhuucZHKoizbu8wWtCm3J+kwbHGEUU9mQCwkOVk947v2389k
 bDVt/tqZJYoWCNrX6VSPdWfb9mH46g/AyMg9e8jdBxvqy7R8+UvgumVKswoWxaBRhsVHgn5syzA
 oTWrNLq3BE+LQJqtshpuRqKQ/0Mc0elUVTpyE6d8
X-Received: by 2002:a5d:5c84:0:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3a08ff50b1fmr1230102f8f.39.1745998722702; 
 Wed, 30 Apr 2025 00:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIqumlKJbXjvLeZikQmdsKHCKb0UvhI+LKhKin3HVFacrh7P/eyfiRNiUcJ/5MVm1qj/pmhQ==
X-Received: by 2002:a5d:5c84:0:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3a08ff50b1fmr1230078f8f.39.1745998722349; 
 Wed, 30 Apr 2025 00:38:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8ca99sm15997248f8f.20.2025.04.30.00.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 00:38:41 -0700 (PDT)
Message-ID: <462058f0-ce94-467a-8865-cef1ec3cb646@redhat.com>
Date: Wed, 30 Apr 2025 09:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] new configure option to enable gstreamer
To: Dietmar Maurer <dietmar@proxmox.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
References: <20250430072524.3650582-1-dietmar@proxmox.com>
 <20250430072524.3650582-2-dietmar@proxmox.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250430072524.3650582-2-dietmar@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 30/04/2025 09.25, Dietmar Maurer wrote:
> GStreamer is required to implement H264 encoding for VNC. Please note
> that QEMU already depends on this library when you enable Spice.
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>   meson.build                   | 10 ++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index bcb9d39a38..50a9a2b036 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1348,6 +1348,14 @@ if not get_option('zstd').auto() or have_block
>                       required: get_option('zstd'),
>                       method: 'pkg-config')
>   endif
> +
> +gstreamer = not_found
> +if not get_option('gstreamer').auto() or have_system
> +  gstreamer = dependency('gstreamer-1.0 gstreamer-base-1.0', version: '>=1.22.0',
> +                          required: get_option('gstreamer'),
> +                          method: 'pkg-config')
> +endif
> +
>   qpl = not_found
>   if not get_option('qpl').auto() or have_system
>     qpl = dependency('qpl', version: '>=1.5.0',
> @@ -2563,6 +2571,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
>   config_host_data.set('CONFIG_STATX', has_statx)
>   config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
>   config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_GSTREAMER', gstreamer.found())
>   config_host_data.set('CONFIG_QPL', qpl.found())
>   config_host_data.set('CONFIG_UADK', uadk.found())
>   config_host_data.set('CONFIG_QATZIP', qatzip.found())
> @@ -4895,6 +4904,7 @@ summary_info += {'snappy support':    snappy}
>   summary_info += {'bzip2 support':     libbzip2}
>   summary_info += {'lzfse support':     liblzfse}
>   summary_info += {'zstd support':      zstd}
> +summary_info += {'gstreamer support': gstreamer}

Should this maybe rather go into the "user interface" section, next to the 
VNC options?

>   summary_info += {'Query Processing Library support': qpl}
>   summary_info += {'UADK Library support': uadk}
>   summary_info += {'qatzip support':    qatzip}
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..11cd132be5 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -254,6 +254,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
>          description: 'SASL authentication for VNC server')
>   option('vte', type : 'feature', value : 'auto',
>          description: 'vte support for the gtk UI')
> +option('gstreamer', type : 'feature', value : 'auto',
> +       description: 'for VNC H.264 encoding with gstreamer')
>   
>   # GTK Clipboard implementation is disabled by default, since it may cause hangs
>   # of the guest VCPUs. See gitlab issue 1150:
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 3e8e00852b..f88475f707 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -229,6 +229,7 @@ meson_options_help() {
>     printf "%s\n" '                  Xen PCI passthrough support'
>     printf "%s\n" '  xkbcommon       xkbcommon support'
>     printf "%s\n" '  zstd            zstd compression support'
> +  printf "%s\n" '  gstreamer       gstreamer support (H264 for VNC)'
>   }
>   _meson_option_parse() {
>     case $1 in
> @@ -581,6 +582,8 @@ _meson_option_parse() {
>       --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
>       --enable-zstd) printf "%s" -Dzstd=enabled ;;
>       --disable-zstd) printf "%s" -Dzstd=disabled ;;
> +    --enable-gstreamer) printf "%s" -Dgstreamer=enabled ;;
> +    --disable-gstreamer) printf "%s" -Dgstreamer=disabled ;;
>       *) return 1 ;;
>     esac
>   }

Please keep the scripts/meson-buildoptions.sh file sorted alphabetically. 
It's an auto-generated file, so if you edit it this way manually, it will be 
changed by the build system the next time someone touches meson_options.txt.

  Thanks,
   Thomas


