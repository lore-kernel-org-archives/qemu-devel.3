Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF5DC021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti936-0001pQ-Jk; Wed, 12 Feb 2025 04:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ti932-0001oh-Ti
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ti930-0001PB-7a
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739352524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n6cDg26mFjpBICZXHQaKgZDwfO0PxFjt59qifV/rayQ=;
 b=U7d5Ugo6PARddBmqWmvEiMzIiFwA6uE1bx3BY4cnCKTBTP4Y4PGzrWD3Mew5CmELlQbYEY
 082ToOSpIplWIEQIkTuMz0am0uUPd480WTmCCSnBhA6eR/fo5zTR4lc7ZXL0zxDCXxGDgS
 Pd2aEiIZIb3x6x6M7jc5GgaX40csMJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-b5FcwS6NOYm548tkIFb5GA-1; Wed, 12 Feb 2025 04:28:43 -0500
X-MC-Unique: b5FcwS6NOYm548tkIFb5GA-1
X-Mimecast-MFC-AGG-ID: b5FcwS6NOYm548tkIFb5GA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso19586435e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 01:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739352522; x=1739957322;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6cDg26mFjpBICZXHQaKgZDwfO0PxFjt59qifV/rayQ=;
 b=wKMENldmfa60B+k6eHyiFRHhzpJqyzzI54U2Kta1Zesw14YhLyrX1mEA2ZidK6+MnY
 WOzcEMWyK3Jy5ypizfbW0A7YxJ4hj4753nMxaeWoajdAMAL0PdCebpuzA0e/4S6hFN/8
 8ax9IC2xn7LmokdZVgIqvrpxQRcTO1oeu9qkTCAOW/KX8LRaHv1UfSkw+9k12GpSfInd
 XCBq4E6rxiJqXfZCZbXGxqR82cftjGhjDADmLt2cjaMvXQpW2F/O90vRjw03a4rxFCiG
 kItPzxlpa9jFHEroTRh7hPWKXRmfgNcbZh7NhQXpuXPfXpfY86qm+cJRilq+hlTDljyP
 dLVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuTpmemN4X1EOILtR6VzYBaHL+jZdJvUoOFhyjGLgaY8wTCspfpo1JSWKAHs0G747hvShzEWUyMS+g@nongnu.org
X-Gm-Message-State: AOJu0Yx+KpnW0AeRPLQQgT3R2/qW0JaBJpawXjG3eSYcWCig6mLaDZhF
 ZR0U64+e0HWGVCuUTTDkfN3sMU4IjZOpxrgxCzrt2Sx8gu7u5rJF4opXC8tPNEJpso5fif3lN7v
 lJQOUY7qeX9vlMDiqiN9ErO4V4JTknd24luT9F+PoEdizbZ6DwpDi
X-Gm-Gg: ASbGnctReF+E2elCyXIQ8ffOsM9KYTLvIFOzVvfYshAzrqO4oBOk68gePFeHxi9rPbm
 3DbTwFTJ+wfsbRN5WT6zUrnBmTjEV3OtpqhoDj0W5qndZZElpVGqzQ5XYl0rS+LpNBZ6MsZ+YCa
 Vt6TBu8imsi3HiG1YUaKzmk0dCe/E0MGL44g1eRpL1h/JwClpnFCuMhc9MGU5gBDYQ56/myRJPo
 wgRpgLwQi8W5BT78/R7acAUVQbbMlTzKxOhXvBYtMhhG5PZB8zPdqHEvlfVci5C3cEzovNlt+w8
 6P2e0Dg=
X-Received: by 2002:a05:600c:4e8d:b0:439:554f:f64f with SMTP id
 5b1f17b1804b1-439580e7b8bmr23927275e9.0.1739352521708; 
 Wed, 12 Feb 2025 01:28:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTkzorP4BAe0HGS1kf4MbmBwnv1+OK3RKrArrwWo0Q0z6JpMmyP2/t0Z24AsbZpLdgSOg4Lg==
X-Received: by 2002:a05:600c:4e8d:b0:439:554f:f64f with SMTP id
 5b1f17b1804b1-439580e7b8bmr23926905e9.0.1739352521255; 
 Wed, 12 Feb 2025 01:28:41 -0800 (PST)
Received: from [192.168.10.81] ([151.95.148.6])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38dcd0fac67sm13905279f8f.54.2025.02.12.01.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 01:28:40 -0800 (PST)
Message-ID: <533ac9c1-7486-4b1b-af9a-ed4a864727de@redhat.com>
Date: Wed, 12 Feb 2025 10:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rust/qemu-api: Add wrappers to run futures in QEMU
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, 
 qemu-rust@nongnu.org
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-5-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250211214328.640374-5-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/11/25 22:43, Kevin Wolf wrote:
> +/// Use QEMU's event loops to run a Rust [`Future`] to completion and return its result.
> +///
> +/// This function must be called in coroutine context. If the future isn't ready yet, it yields.
> +pub fn qemu_co_run_future<F: Future>(future: F) -> F::Output {
> +    let waker = Arc::new(RunFutureWaker {
> +        co: unsafe { bindings::qemu_coroutine_self() },
> +    })
> +    .into();

into what? :)  Maybe you can add the type to the "let" for clarity.

> +    let mut cx = Context::from_waker(&waker);
> +
> +    let mut pinned_future = std::pin::pin!(future);
> +    loop {
> +        match pinned_future.as_mut().poll(&mut cx) {
> +            Poll::Ready(res) => return res,

Alternatively, "break res" (matter of taste).

> +            Poll::Pending => unsafe {
> +                bindings::qemu_coroutine_yield();
> +            },
> +        }
> +    }
> +}
> +/// Wrapper around [`qemu_co_run_future`] that can be called from C.
> +///
> +/// # Safety
> +///
> +/// `future` must be a valid pointer to an owned `F` (it will be freed in this function).  `output`
> +/// must be a valid pointer representing a mutable reference to an `F::Output` where the result can
> +/// be stored.
> +unsafe extern "C" fn rust_co_run_future<F: Future>(
> +    future: *mut bindings::RustBoxedFuture,
> +    output: *mut c_void,
> +) {
> +    let future = unsafe { Box::from_raw(future.cast::<F>()) };
> +    let output = output.cast::<F::Output>();
> +    let ret = qemu_co_run_future(*future);
> +    unsafe {
> +        *output = ret;

This should use output.write(ret), to ensure that the output is written 
without dropping the previous value.

Also, would qemu_co_run_future() and qemu_run_future() become methods on 
an Executor later?  Maybe it make sense to have already something like

pub trait QemuExecutor {
     fn run_until<F: Future>(future: F) -> F::Output;
}

pub struct Executor;
pub struct CoExecutor;

and pass an executor to Rust functions (&Executor for no_coroutine_fn, 
&CoExecutor for coroutine_fn, &dyn QemuExecutor for mixed).  Or would 
that be premature in your opinion?

Paolo


