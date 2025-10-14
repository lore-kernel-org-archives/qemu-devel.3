Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F2CCD194
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ges-0006Np-0Z; Tue, 14 Oct 2025 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8gep-0006NN-BZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8gem-0005Gg-T4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760454582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B/zZoSle//6Sw/N0PFc50XkWyU5qfZTc9Kl0ctw4IXw=;
 b=hV0N3qAqf/LQYjhdT7cL71zgHs5Svi9QljfpRvuezXN9R7HtW1BCrJR2R+vwFJVLfXgx0x
 xKPawsoUGkxVknrxTcxZkfgkOncQWykts9bXUIky31sTM+Hn85Us7g+6E8xAgPTmlk641v
 0HUQgciP4KvHCW5FfDQcfFvBx89abJs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-1vYenv2UM-WilMmmCab-CQ-1; Tue, 14 Oct 2025 11:09:38 -0400
X-MC-Unique: 1vYenv2UM-WilMmmCab-CQ-1
X-Mimecast-MFC-AGG-ID: 1vYenv2UM-WilMmmCab-CQ_1760454577
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdf7b5c46so2865067f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760454577; x=1761059377;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/zZoSle//6Sw/N0PFc50XkWyU5qfZTc9Kl0ctw4IXw=;
 b=pn+pgOZI7xpRDryNu3cJx/npTVCQ4DjL4NDm3bNORkYubkKn771Ea0O72v2A94vLv4
 tUzijerRFFqQxRGomrclC7TDSA4r5Ja2M17M3bZmDxNg4yWN9JPWXXZ60ee+znqd7d7R
 +aD7ho0BB9anPDyrBdwQ2O+G6wErZB9s+1N9PB8SBl4b1sBOtE4Q1DTW+77PN//zkK70
 NiG35Vwzny8BIVrbEi4igFhzA8mZGhagYp+iukUnMyEONW+XJ3uOFIrON7t6oOs07RVs
 taYZLNpbkXEML3rJELeZh71S5vZTO1I+y+mmdMVeNnPnGqHGv0Eb/a9fZpaU6+4IXRoP
 LhqQ==
X-Gm-Message-State: AOJu0Ywdrl2GakJNwkiB50pHq1vzRpzaQXdCl3bvLNnO7GdGahxGGAAs
 DUNG819uGxVknH+S6e/NskkyqWVq66cm0HtjMygFjp6owONIDN0KguFgzxQZ6l4Vmhy5TnML534
 AS7F1U4CAw2M2YyFUvrWemhWOEm1DjZsVO/PV0IG50uyPGQv672o6dj60
X-Gm-Gg: ASbGncu1EqmIPdwp4k7AvVpvtKubjn+X4rOFQy5Ds9yE/N0EpawbDunvEnQ279pKTOW
 mVM95wK4SX5xYBeLcLRPcZ4BpuC+EU202t8bmIHQ6rbEz4ck/9GmmqLtnaV/f81VIPzYnXiMzF0
 KD92RRM5hOdY9vSB2vuZ1a+n9JHO+6Ro4cyb4vFpodcS436IHRJPHCRhxSfBffDsZq2w5DtiApM
 jzs76M6xDfpTwYZFqzf5MSW1LKlYiJn5B3ri6BsuMKZZzW3dRVJaxtCAI76RUv7YeR2IovdlAS/
 EH6IF6JHEdpVFRe5qNA/33psqDrfuBnUe4KPboVhE6umeY6eUytH9wVJi5cIEP7KHGaGKoOyUAD
 8fVnXWb9S7UXVJ3GlaLiAVr3yVgGEcF2vgDPWqdz89A8=
X-Received: by 2002:a05:6000:420a:b0:400:ac58:b35f with SMTP id
 ffacd0b85a97d-4266708361bmr12750456f8f.21.1760454576937; 
 Tue, 14 Oct 2025 08:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhTDkL9zZB8pIrdbMaSQSstkAqa2QSFtzE+AQ9NA0WD5xrmJb5VG1wPUq3CkRSeagWrWVK1Q==
X-Received: by 2002:a05:6000:420a:b0:400:ac58:b35f with SMTP id
 ffacd0b85a97d-4266708361bmr12750430f8f.21.1760454576497; 
 Tue, 14 Oct 2025 08:09:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46fb32a84edsm131835335e9.4.2025.10.14.08.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 08:09:35 -0700 (PDT)
Message-ID: <0d7741c3-2ffb-4076-8baa-864a83197805@redhat.com>
Date: Tue, 14 Oct 2025 17:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust/qemu-macros: Convert bit value to u8 within
 #[property]
To: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20251014150251.2473680-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251014150251.2473680-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/14/25 17:02, Zhao Liu wrote:
> diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> index 3e21b67b4719..2a7454da2416 100644
> --- a/rust/qemu-macros/src/lib.rs
> +++ b/rust/qemu-macros/src/lib.rs
> @@ -271,7 +271,10 @@ macro_rules! str_to_c_str {
>                   name: ::std::ffi::CStr::as_ptr(#prop_name),
>                   info: #qdev_prop,
>                   offset: ::core::mem::offset_of!(#name, #field_name) as isize,
> -                bitnr: #bitnr,
> +                bitnr: {
> +                    const { assert!(#bitnr >= 0 && #bitnr <= u8::MAX as _, "bit exceeds u8 range"); }

The check for the upper limit must be "#bitnr < $field_ty::BITS as _", 
for example rejecting 32 for an u32 field.

Also, the tests need to be updated.

Thanks for remembering about this change!

Paolo

> +                    #bitnr as u8
> +                },
>                   set_default: #set_default,
>                   defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
>                   ..::common::Zeroable::ZERO


