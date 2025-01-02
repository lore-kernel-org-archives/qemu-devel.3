Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B427E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 17:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTOcV-0006Sb-Ut; Thu, 02 Jan 2025 12:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTOcS-0006QT-As
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:04:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTOcQ-0002Oy-Kj
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:04:24 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso122022945e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735837460; x=1736442260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OmAlhZpQsAKEBA0E73VS/v2bvw8ZDZwE8WrobfO2y1M=;
 b=iL68JxEzO0i2PfNJsUH5tqb1dCispuecFfK57U4Yzakuch3KwQdsTSomVA6a/NrTON
 Dne0Rq4pzWuREA+o0XuUMDRXyzEFXRP3XdIZ4NfOVpqd5PdsvRFVcoIMf7rlCZIjR42W
 nvnYMRiwBl+Jep5gjEByGQw7pRtkaUv1Ud+pNVXUes7P1dAwhVQbrFPxme3Qt7/xTHyC
 6Pccup37e7S0P2gWs28YKaQFK/noalK7jbN13kQnZq1g6ElEXLNpoJnvaLfuP6TO/uRV
 2Kt51wz7R5OFE35R0BNB64V7v+YB50E0J91Ud4zTHI/NbVrOI7NgHMHEXjY/c0L61Qe9
 yHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735837460; x=1736442260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmAlhZpQsAKEBA0E73VS/v2bvw8ZDZwE8WrobfO2y1M=;
 b=I5ZhH4186XGY9ydOqcF8unodBWUcq33eiGKQSzfsWtjWG6+zsZ3SX5I4dA8EsB521j
 X3tqCTAOfd3hj9EjrCVQp+OJTMRuEtMZbR/zUDL60dcyo1VOLS/GqbSXHG4SJAZQenqo
 A9we8ycqDXzOC8VpUY0vAgdzqhJZtpuYRubKSpsRBR21yNKx/kvw2UumEbkJEHc7gTrj
 H64R8JVcL1GHFNXBQbUjsZukVWJ68iDmq+oH2QhJvWtwNLbmBvKJkDgRKNtCudgcsJI0
 4p0ZVuMwigwHnpbRcwdZ/2DFuSIahMyH3jxDkDuHnrjB7152JNeNN1T0+0/YB77Rdb/7
 NGOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfbz4oN4DCR4cSfJtiLq4w5OK04G3YpFpfKn7LQkWZOhECIKaeb/Sg/L+HlXkJrsXglZM8YNUhqUl@nongnu.org
X-Gm-Message-State: AOJu0YzNVJ8OPaVNP21UHLgq4oozY/eKRRMlKgwD0IYoGSnIUeCsEtmd
 wXH/36eIhfCR91VYFiKnVdlgZBN0dYTnKjP7rhu0C1Js9x6prYRa+gFuoA7s6S4=
X-Gm-Gg: ASbGncsjVVGzlspvg4zlEinioM/8iCeNaZuV0I6eqZl438pvPWlhR6CAMV3Q2T4FY0R
 7QyOvn92A6NhMnBiV6D8Uy4JCnSiEMUaT+LYaXR4iTxynMy0sBX2Suc4+TfYPwzHJPfv9Bdp4l5
 UaRzS0f1RpfoJcdZqYVDD+krscGZx8mI7IkDxJ/71YP3Q/+Dp/5O5cYdBleArFD9nn2AesPe6vO
 37NrzJrd7nh1UDh/pGbrs8gxItCMdwBmXwS8cGRQRti2cgmg+UEloOLheEuo7EC3C9CmW1vM1KK
 +o5QhNCe3bxR5GvgCO7I5GGP
X-Google-Smtp-Source: AGHT+IF+EM49eWNItqBaBhDanafMOSMhfoK9CwGM8lczfOAwiSygHwDFefERZu426Cf/nctqPBicCQ==
X-Received: by 2002:a5d:5f54:0:b0:385:fb53:c67 with SMTP id
 ffacd0b85a97d-38a221e2743mr44571123f8f.3.1735837460081; 
 Thu, 02 Jan 2025 09:04:20 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4bbsm455232135e9.32.2025.01.02.09.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 09:04:19 -0800 (PST)
Message-ID: <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
Date: Thu, 2 Jan 2025 18:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241219083228.363430-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

On 19/12/24 09:32, Paolo Bonzini wrote:
> Parameterize the implementation of ClassInitImpl so that it is
> possible to call up the chain of implementations, one superclass at
> a time starting at ClassInitImpl<Self::Class>.
> 
> In order to avoid having to implement (for example)
> ClassInitImpl<PL011Class>, also remove the dummy PL011Class and
> PL011LuminaryClass structs and specify the same ObjectType::Class as
> the superclass.  In the future this default behavior can be handled by
> a procedural macro, by looking at the first field in the struct.
> 
> Note that the new trait is safe: the calls are started by
> rust_class_init<>(), which is not public and can convert the class
> pointer to a Rust reference.
> 
> Since CLASS_BASE_INIT applies to the type that is being defined,
> and only to it, move it to ObjectImpl.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs  |  19 +----
>   rust/qemu-api/src/definitions.rs  | 111 ++++++++++++++++++++++++------
>   rust/qemu-api/src/device_class.rs |  50 +++++---------
>   rust/qemu-api/src/sysbus.rs       |  18 ++++-
>   rust/qemu-api/tests/tests.rs      |   9 +--
>   5 files changed, 127 insertions(+), 80 deletions(-)


> diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
> index c98f0b2c7da..dcec5488291 100644
> --- a/rust/qemu-api/src/device_class.rs
> +++ b/rust/qemu-api/src/device_class.rs


> -/// # Safety
> -///
> -/// We expect the FFI user of this function to pass a valid pointer that
> -/// can be downcasted to type `DeviceClass`, because `T` implements
> -/// `DeviceImpl`.
> -pub unsafe extern "C" fn rust_device_class_init<T: DeviceImpl>(
> -    klass: *mut ObjectClass,
> -    _: *mut c_void,
> -) {
> -    let mut dc = ::core::ptr::NonNull::new(klass.cast::<DeviceClass>()).unwrap();
> -    unsafe {
> -        let dc = dc.as_mut();
> +impl<T> ClassInitImpl<DeviceClass> for T
> +where
> +    T: DeviceImpl,
> +{
> +    fn class_init(dc: &mut DeviceClass) {
>           if <T as DeviceImpl>::REALIZE.is_some() {
>               dc.realize = Some(rust_realize_fn::<T>);
>           }
>           if <T as DeviceImpl>::RESET.is_some() {
> -            bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
> +            unsafe {
> +                bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));

Pre-existing, but since it appears on this patch, Rust device models
should not implement this legacy interface. If a non-Rust parent
implements it, I think we should convert the non-Rust parent before
adding a Rust child. No clue how to check a parent don't implement
this interface in Rust.

Generally, we shouldn't access legacy API from Rust IMHO.

> +            }
>           }
>           if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
>               dc.vmsd = vmsd;
>           }
>           let prop = <T as DeviceImpl>::properties();
>           if !prop.is_empty() {
> -            bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
> +            unsafe {
> +                bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
> +            }
>           }
>       }
>   }


