Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5A1D3C53F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 06:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lxb-0002OW-Aw; Mon, 21 Oct 2024 02:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2lxZ-0002ON-FZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2lxX-0000ES-P0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729492324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ISefsF479RvHV+vrC6uixw+VR9UlYq+sxwzmumiQNHc=;
 b=FjnIDzPgPi0ZP7U9/PAozdfjo0MilqM/4Y3ZltfmoFTPuQjMmjl2iDL4btGNk0h/EkdUAG
 E2sywiGlmBEb6TC2BaZ+4Xuws4jGNN52P51pBAzDJMZTpos+ZFzJxwFaS2x29lWfyULwuA
 LqGVezbtNf/ZDMbnog0+tURh7wTh3wU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Fiv7vy9SP8Cu2FZyCmzVMQ-1; Mon, 21 Oct 2024 02:32:03 -0400
X-MC-Unique: Fiv7vy9SP8Cu2FZyCmzVMQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518ae047so24100215e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 23:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729492321; x=1730097121;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISefsF479RvHV+vrC6uixw+VR9UlYq+sxwzmumiQNHc=;
 b=YgOZwmhy4H781DPlWp4lWVTk+YKozPtow3HdKed3ZCgZICv3jcZczIYPfWG0jDRQdm
 kQ3b0EauF9f+kd6JaZvoeeIOVUbUfwvXpcXZkx5TxyCLVKwBmZFXkromZoLc+Dc9bA+o
 oEwFa8hY7jnwH0qBEF0iQtRWMKmaAsE3+Gz/HWRmRAVnO+/iOq0y0eOrc2MXMnwgyBEG
 OkafzRmYfhMXCMZid2wKK4f+eGLy7DIXuPkeK1l551DW6YhYfcuYeu2/j8PenZ1JvyWy
 9vM/mYRRQxxiZ/4siGkZjTjDSkfVESQOUf7m2RbC6m+0rvJy26VvlRY8CVT6y56Dac9P
 8Juw==
X-Gm-Message-State: AOJu0YwYl6Ph1HqHQL+8KD6c5EN4iyM9hXstXIhanPj90o+DECCmre9C
 LHfNDQL5iTnvLgCnmOOxfFFTn9i/TQrbGC6lQSXnQ3AeZHkC4lJ8eFQxmLb6vqPAut9tse5Nj1z
 vj+1+P++kgLRGSQOS1O1YXb9QWjRqFPGzH1RweKyfOBVG0vadPj1qvwMLY7uEXvQ=
X-Received: by 2002:a05:600c:3c9a:b0:431:47e7:9f45 with SMTP id
 5b1f17b1804b1-43158756c5dmr83406005e9.11.1729492321052; 
 Sun, 20 Oct 2024 23:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+d+/1PWy67FUzNjqXoi1LJNViA4IB9YD28stG9NllVAQGFMjv4qfYXGR4N5B5X1KXbwK3dQ==
X-Received: by 2002:a05:600c:3c9a:b0:431:47e7:9f45 with SMTP id
 5b1f17b1804b1-43158756c5dmr83405915e9.11.1729492320690; 
 Sun, 20 Oct 2024 23:32:00 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4316f57124csm45614005e9.8.2024.10.20.23.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 23:32:00 -0700 (PDT)
Message-ID: <5db62c58-b6e3-4f83-9954-ff2bcb1108bc@redhat.com>
Date: Mon, 21 Oct 2024 08:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: introduce alternative implementation of offset_of!
To: Junjie Mao <junjie.mao@hotmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
References: <SY0P300MB10265E25557DB71EE426525795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <SY0P300MB10265E25557DB71EE426525795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/21/24 07:40, Junjie Mao wrote:
> offset_of! was stabilized in Rust 1.77.0. Use an alternative implemenation
> that was found on the Rust forums, and whose author agreed to license as
> MIT for use in QEMU.
> 
> The alternative allows only one level of field access, but apart from this
> can be used just by replacing core::mem::offset_of! with
> qemu_api::offset_of!.
> 
> Using offset_of! prior Rust 1.77.0 requires the structure to have the
> derive(qemu_api_macros::Offsets) attribute.
> 
> Apply as a replacement of 10/16 of Paolo's RFC series [1].
> 
> Also remove subprojects/syn-2.0.66 if there is an existing build. An additional
> feature cfg is added to packagefiles/syn-2-rs/meson.build, which requires meson
> to re-checkout the subproject.
> 
> [1] https://lore.kernel.org/qemu-devel/20241015131735.518771-1-pbonzini@redhat.com
> 
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>

Thanks.  I still prefer to keep the procedural macro code minimal, and 
have the code generation in a separate macro, but this is a nice start!

> +fn is_c_repr(input: &DeriveInput) -> Result<(), proc_macro2::TokenStream> {
> +    let expected = parse_quote! { #[repr(C)] };
> +
> +    for attr in &input.attrs {
> +        if attr == &expected {
> +            return Ok(());
> +        }
> +    }
> +
> +    Err(quote! { "Can only generate offsets for structs with a C representation." })
> +}

Probably can use any() here.

> +/// A derive macro that generate field offsets for using `offset_of!` in
> +/// versions of Rust prior to 1.77
> +#[proc_macro_derive(Offsets)]
> +pub fn derive_offsets(input: TokenStream) -> TokenStream {
> +    let input = parse_macro_input!(input as DeriveInput);
> +
> +    let expanded = match derive_offsets_or_error(input) {
> +        Ok(ts) => ts,
> +        Err(msg) => quote! { compile_error!(#msg); },

It should use quote_spanned! here.

Paolo


