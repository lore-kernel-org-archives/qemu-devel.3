Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5B5CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcm5-00065A-Pz; Fri, 19 Sep 2025 11:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzcm0-00064L-B3
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzclx-00053C-2H
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758294697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YkUeOoW8wr6bV2oPTwH5EdSmjx9cFHZd9cyhJI9u+xg=;
 b=J6gt+Vywl4XNKo0owmGPHuV0ZlvJutrWoeA7gX+TkOw6YNVYTgtu7+g6uW6h3tT51ZgjPt
 aBCBANGSGa1syFzGREA33T7NB9Rn9iA6Xx5ZDnlEPiH+GgvDLc4SVSSc1KSJy+MkMPcwp9
 kDpvf0zexIgtkii+UZ1lm9+7EFi8tUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-tDHr75DZNmG7Y4TikqLQBw-1; Fri, 19 Sep 2025 11:11:33 -0400
X-MC-Unique: tDHr75DZNmG7Y4TikqLQBw-1
X-Mimecast-MFC-AGG-ID: tDHr75DZNmG7Y4TikqLQBw_1758294692
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45dd56f0000so26266105e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 08:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758294692; x=1758899492;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkUeOoW8wr6bV2oPTwH5EdSmjx9cFHZd9cyhJI9u+xg=;
 b=l8esKgAgfB7ODt6vIvojsV92T2MyixEOcfDPAadmjqn1PIOEeFnRi7/RTIVqR1p+9O
 xAfw789Rcnr3EelbgpguQRV0Zou7UhK7ezLcxsVtDaFDYiPh3S4Mfwnh1yKLPQxHqxmI
 Pfn0u7GkbKtHXhfvffG0CJQj0UTGzy5HLYWU/HHqIFHPEl9OEenq+PgF7yNQLyG4DyRF
 gVK4bHr//5AHm7c7aXo+oRQJgO1TE4/fZiDXXbcmANmnuLlNGlqAyLlCFM5t4sj/22Od
 0up4f4ZMEGHjpjwaBFjHENbwxANrXi0k81wImnQNEST06KjIOIbmLEh3zFFfx2NEuEc7
 Ovtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOlabHFiGpmQW4V9A2lCoA8XQqGLYwTWplu/Wf66eMyxVwl45U2BUBc1Bg812BC0mcIcOm267MpA6Z@nongnu.org
X-Gm-Message-State: AOJu0YyRwFoWAoDqAVBQviaWY9vRW7dsGbZpRVpIw4seAXgC2V9Ax5zc
 sDk6OVGI4OJ7lAQox+rDjTgXS4GxHZsjJldDCOBTgrnAE2RQGr+HW7wIJJCOCXKJIAxSKRxd9QL
 z+p0CmTU6J4GUx968NCACNlYM1HeYS0O5YgPwUKZyFN86l8X6uXs0XhBG
X-Gm-Gg: ASbGncvcSbJaHBN27JHe15ty5ymFM4H+hAuWFhzq+pyeRwkE+B4+Ty3V9SfRR+s3NeZ
 8MzBXsyf2SMdp2UXzPLw655Wt3K2SIBfzIPU0wIhrwi9NjNSy5Srltlqjx+Vr4cgTAd82PS2wXi
 iegRleyTU0iXIPDRapVKpXeOONpDWfBjWUedKngZbCEqLxJDP8MLLKdHyhKJG9+47a+Bj1IUChk
 Uvn9WndYjiRK6wmrkMeveDY88PRxl1I1fZ1VmpSnTpP9ghfpwqG7PWyRwh6gFwzinmZ7YNDHz3K
 SnqCW07s2df/xEQkGK61NjA53qGjlBfgAV0lqfPwV9q56Q8hezWrczFcaVhsxc0y6nwcVXRPYC8
 RsQaG61reF+joAm8Snp4Yery61kP81gdvBdd78ZZF2lQ=
X-Received: by 2002:a05:600c:468a:b0:45d:cfee:7058 with SMTP id
 5b1f17b1804b1-467ea89da77mr37161255e9.22.1758294691994; 
 Fri, 19 Sep 2025 08:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGPLiOKWQGVe306KSAh2zoHIrQ8ZFHaXQ9Abp0h8UQluY71Y9Je/GRC7LN3H2dhHFbfKevzQ==
X-Received: by 2002:a05:600c:468a:b0:45d:cfee:7058 with SMTP id
 5b1f17b1804b1-467ea89da77mr37160815e9.22.1758294691545; 
 Fri, 19 Sep 2025 08:11:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee074106f4sm8172058f8f.25.2025.09.19.08.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 08:11:30 -0700 (PDT)
Message-ID: <4b093127-5a2f-45f8-ba5c-674522b6d7d4@redhat.com>
Date: Fri, 19 Sep 2025 17:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] RFC: configure: use the same machine as the host
 triple by default
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-7-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250919133320.240145-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/19/25 15:33, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> IIRC, this fixes build on msys2 - although I can't reproduce. Maybe with
> some other host, on *bsd?
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 32eb313941..c2f4534964 100755
> --- a/configure
> +++ b/configure
> @@ -1205,7 +1205,7 @@ if test "$rust" != disabled && test -z "$rust_target_triple"; then
>     # arch and os generally matches between meson and rust
>     rust_arch=$host_arch
>     rust_os=$host_os
> -  rust_machine=unknown
> +  rust_machine=$(echo $rust_host_triple | cut -d- -f2)
In theory the machine, when not unknown, should be computed in the case 
statement(s) below.  I remember I checked against "rustc --print 
target-list" but I could have missed some.

Paolo


