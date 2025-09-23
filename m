Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07704CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12Vp-0000Z3-LP; Tue, 23 Sep 2025 08:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1v12Vc-0000Xc-Gh
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1v12VV-00031g-H3
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758631947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KI4j1ztN2iBmMQ6QxYrRzu/PKlF81s/uI/+JC+vAJC8=;
 b=SEtzj69bKSNxiYKeknCsYQZxzzEoj0KQMAmYAo/e3f2/TXQxBWnoperm0A6vOSNcUiRJcP
 Chlk3O346XY2BT/5MhkqcO/FT6u0BxE9RGPZQqExV3GEwCuXWqEKKXCVEujWEjH6CiF+N1
 Vn1q6AjOlyGM3A6w+D0sbqO0Wq3bSdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458--ezrUkXfNeWXwmbynwQekA-1; Tue, 23 Sep 2025 08:52:19 -0400
X-MC-Unique: -ezrUkXfNeWXwmbynwQekA-1
X-Mimecast-MFC-AGG-ID: -ezrUkXfNeWXwmbynwQekA_1758631938
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46da436df64so13921305e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758631938; x=1759236738;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KI4j1ztN2iBmMQ6QxYrRzu/PKlF81s/uI/+JC+vAJC8=;
 b=rK2/bMWxb+haBW3B1pJm66Q9AKQL2Vgno5pI40KhsN0NrL+/51tcL/nQ4JAh3nPNte
 6C+GDFWA4Bh2fOm11evwzJQvRG3qxRKgwV1FN8o2Ysd1kdX3UxPH/77A3LNGmYbSuqPS
 wtsF/4yuy1cZr+BO1JV3fFEjnjlv4UyDGfgGkTnvTLmpJ0Zd7iU7qJfkZbSXJmQxaze5
 EwNuML4tUmHdvO76ayU7mFtVayUIS/H0UskkBBePyrC8JQaiyDsGZR7vtQBvUNunzdP+
 nRlz+T215sHP1F0PkSbGDIJa7XqbIVIFshdGznsSCmdt04galLWbX5F68DtjNufzyJPB
 LwkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvHELvsHN2l/ZpkCMU5AZDa9wm1U4MC57Rj2fvWdFExtF5frlto517mOv+dqNsdaapQdE4yI7gLlP@nongnu.org
X-Gm-Message-State: AOJu0Yx34pht56Tvf4WzCeMYKndgUgjDNwWKlcw8G5oCgD/wv2Nqhil3
 RmY0OmGkSZj4DCSeisXtfZ+yd4uBcDu9aEBeeRtQpsydkHpR42hiOcKJenO+t42hGyxsXtUA4iD
 OQIVIYNaSN130TABsyhEuHsJmf1ULTvowLAU2Gs3iERsdbhSnKUu+qRwJ5sAdRLRc
X-Gm-Gg: ASbGncvB2Ywr7miE1zqOO4cCXPSelfFbNq4Gnz+TMSGetdPq2dK4DCuQ30d+jxxhjkg
 uFK0E+UGbcqD8fH2mJQH0TbCx4KPTjfV7oti7S98DlVdpJDM17vQHa20jn14uGH4LS/u+AgfHSk
 UBOmzJh47lxwEYxb2BdmO+Vg+JusHyf9GOmorUyYw2Bw1OvHMNBdNn6qJO22YOY5oCFpF9o1eFj
 ujIPrPJKYooPl9sGPAAPhd5EJIE/RKburJ+ppu5NMJc2ceMy8vCYsB/OGfSEggTaopNp/CCx35n
 BZcPwjIfUOxZGx7cRlIQmsomoZRHB6e6xxlmDzZtGhLwcrFEQtYmzk3GCKfcojIlVz11JNgPjkm
 rgLQ=
X-Received: by 2002:a05:600c:1ca5:b0:468:9798:2043 with SMTP id
 5b1f17b1804b1-46e1dabf75bmr30262955e9.26.1758631937906; 
 Tue, 23 Sep 2025 05:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnD2NMX+bf29QjAG22vBLi7OvC7Bh7NRyKDgTnkMs/Hvi63nB+zYmGaxjOaYzx6X4AyyWI8g==
X-Received: by 2002:a05:600c:1ca5:b0:468:9798:2043 with SMTP id
 5b1f17b1804b1-46e1dabf75bmr30262605e9.26.1758631937471; 
 Tue, 23 Sep 2025 05:52:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fcb01a9049sm9137057f8f.61.2025.09.23.05.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:52:17 -0700 (PDT)
Message-ID: <5c952898-c129-426f-a68f-42b369ca7aa7@redhat.com>
Date: Tue, 23 Sep 2025 14:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] passt: Declare dependency on gio
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250922132217.680404-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20250922132217.680404-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/09/2025 15:22, Peter Maydell wrote:
> The passt network backend uses gio; declare this dependency in
> meson.build, so we don't try to build it if configured with
> --disable-gio or if gio is not present.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 854ee02b222 ("net: Add passt network backend")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3121
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index 6ade30f36ad..c5a56ba5deb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1279,6 +1279,7 @@ if not get_option('slirp').auto() or have_system
>   endif
>   
>   enable_passt = get_option('passt') \
> +  .require(gio.found(), error_message: 'passt requires gio') \
>     .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
>     .allowed()
>   

I sent the same patch two months ago:
https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04907.html

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Laurent


