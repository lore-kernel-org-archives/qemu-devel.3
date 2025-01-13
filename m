Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B03C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 23:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXU11-00089t-Tb; Mon, 13 Jan 2025 18:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXU10-00089Z-1M
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 18:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXU0y-00020j-Ao
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 18:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736811513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VBoxovjgKBlmm1lYjtwR/LOFCCVdgh62J6XNbW8iEr0=;
 b=IyQLMdIRrU1sFFwtp/mXlznB6hQFVSkzfUMV4q7YhK/bqPQ65P7+EYYf17AMiW9/e7ALuo
 sbK+dTWrcYU3o/DoZ4yizIb//DIX5HUH8db5l+imZbK8ZOe0msKEXDNhp3M9PJU1rdn/QV
 yXzV7WDyFe1/RVfOKFMsi6CdAsdTBlg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-swAVwkRUMq2n2Lssu1TKhw-1; Mon, 13 Jan 2025 18:38:32 -0500
X-MC-Unique: swAVwkRUMq2n2Lssu1TKhw-1
X-Mimecast-MFC-AGG-ID: swAVwkRUMq2n2Lssu1TKhw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e27c5949so2842380f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 15:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736811511; x=1737416311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBoxovjgKBlmm1lYjtwR/LOFCCVdgh62J6XNbW8iEr0=;
 b=ocYAewh6Jracph+qUbWS1P+/JX8RALWziktSUUaF5xEa6QVp3lRzR02h/ClFwPQPIm
 4SQlfB9OjP/kDACfmHC/j4KmklJnXZUaQHLhZYlXzFoVOSIFFvybMKIoDtOMFbd0gYl2
 zK1gASIaWVhZbi3NGaCmvO50wfXkOE8qfJhz0A7SB0R3U/0H9Fds2dllhC0nWqWlwspO
 SkbVF46NOEuFfVPXSQk7s0anXiEcEpByxQhvoq0V4csa3A750zmy4g9fwj5Yz0wKQSji
 oR1I6015MOgAVBUqcn6Vfp38E5gqIzdUFzyMR/rgasGXAZwL5oWRxDZHxVV0CLHFSjEL
 nNxw==
X-Gm-Message-State: AOJu0YyA6GCZWKJPcQ2y5mtFJy0Bc9Z5NQ/w1t8dDDsY6rdTZ4hLNzSY
 66QBgfdlTStmKtC/lFOmtioy6BNS/gt8+7ZNPwrnNPvCR8qbKdU933ZssZOmsBXGJJYPc51+vaz
 8b9g49yyO8/gQJvjR7nAuiKkFHOrE6eC4IhxU9fYEfQ3D1S8L6A5Z
X-Gm-Gg: ASbGncug0jAp//ygMPtAzqc64MXLVor6jvCxQboWweVDJW/ZwlR+FQjGteIWqWnU1o2
 rB+oFdLpiEMhZRhrRZXCEPXKcjqH4JjHP9wsXj4eT0aY5rHtldnjdFrpQj1sO8Iwe7XGzl++82a
 xf5wOZQzFgGE4jzorF/YJox9FHVHLaUPP4VIg2S2Hbg07VeLwKIW474rB7o9GAUX26EswXamOYZ
 uMDLbJNDVk9DJb3knyRVPRw4GIqQ0sEuThzoMJf0YuaR7dASA==
X-Received: by 2002:a05:6000:1864:b0:386:42a6:21f2 with SMTP id
 ffacd0b85a97d-38a872cfeafmr20383974f8f.10.1736811511344; 
 Mon, 13 Jan 2025 15:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8xdyCB1D3ojakL6RyIaOTwcXmS+iqQTUBITc/HnGa7JBGWgDjrDGU6m/5OvjzhdPeCGv4xA==
X-Received: by 2002:a05:6000:1864:b0:386:42a6:21f2 with SMTP id
 ffacd0b85a97d-38a872cfeafmr20383964f8f.10.1736811510959; 
 Mon, 13 Jan 2025 15:38:30 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:f243:3731:6014:d7c:f11f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm13561825f8f.39.2025.01.13.15.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 15:38:28 -0800 (PST)
Date: Mon, 13 Jan 2025 18:38:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 1/3] win32: remove usage of attribute gcc_struct
Message-ID: <20250113183102-mutt-send-email-mst@kernel.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <20250110203401.178532-2-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110203401.178532-2-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jan 10, 2025 at 12:33:59PM -0800, Pierrick Bouvier wrote:
> This attribute is not recognized by clang.
> 
> An investigation has been performed to ensure this attribute has no
> effect on layout of structures we use in QEMU [1], so it's safe to
> remove now.
> 
> In the future, we'll forbid introducing new bitfields in packed struct,
> as they are the one potentially impacted by this change.
> 
> [1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build                               | 5 -----
>  include/qemu/compiler.h                   | 7 +------
>  scripts/cocci-macro-file.h                | 6 +-----
>  subprojects/libvhost-user/libvhost-user.h | 6 +-----
>  4 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index d06f59095c6..da279cc1124 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -377,11 +377,6 @@ elif host_os == 'sunos'
>    qemu_common_flags += '-D__EXTENSIONS__'
>  elif host_os == 'haiku'
>    qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
> -elif host_os == 'windows'
> -  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
> -                           args: '-Werror')
> -    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
> -  endif
>  endif
>  
>  # Choose instruction set (currently x86-only)
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index c06954ccb41..d904408e5ed 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -22,12 +22,7 @@
>  #define QEMU_EXTERN_C extern
>  #endif
>  
> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> -# define QEMU_PACKED __attribute__((gcc_struct, packed))
> -#else
> -# define QEMU_PACKED __attribute__((packed))
> -#endif
> -
> +#define QEMU_PACKED __attribute__((packed))
>  #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
>  
>  #ifndef glue
> diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
> index d247a5086e9..c64831d5408 100644
> --- a/scripts/cocci-macro-file.h
> +++ b/scripts/cocci-macro-file.h
> @@ -23,11 +23,7 @@
>  #define G_GNUC_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>  #define G_GNUC_NULL_TERMINATED __attribute__((sentinel))
>  
> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> -# define QEMU_PACKED __attribute__((gcc_struct, packed))
> -#else
> -# define QEMU_PACKED __attribute__((packed))
> -#endif
> +#define QEMU_PACKED __attribute__((packed))
>  
>  #define cat(x,y) x ## y
>  #define cat2(x,y) cat(x,y)
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
> index deb40e77b3f..2ffc58c11b1 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -186,11 +186,7 @@ typedef struct VhostUserShared {
>      unsigned char uuid[UUID_LEN];
>  } VhostUserShared;
>  
> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> -# define VU_PACKED __attribute__((gcc_struct, packed))
> -#else
> -# define VU_PACKED __attribute__((packed))
> -#endif
> +#define VU_PACKED __attribute__((packed))
>  
>  typedef struct VhostUserMsg {
>      int request;



Acked-by: Michael S. Tsirkin <mst@redhat.com>

> -- 
> 2.39.5


