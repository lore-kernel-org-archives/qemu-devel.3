Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5532D0C5EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GMw-0001Hl-Av; Fri, 25 Oct 2024 05:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4GMu-0001HY-Lh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4GMs-0007vI-RJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729847543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QmxSrcyUFqYxzFcxS1EfVezWS25fp337WV2KUu4otWI=;
 b=I+VeO4d4FiqerlzkK61yqQqUjzne9DeOTu4BfF2m8X09AckpeOMwr5xOefSCdRkg+/CrqL
 P+CLHLQjaAmYXIfxoZzvrSC9iL6d3yFlKulQ95Nd296uocSp9DEmH+jK0UCl6PoqYtm9/4
 F1wYKLzvY1lXwHTw5Gq1il+5PycgiHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-y0qWSpJzNLObY5s4QrqdFQ-1; Fri, 25 Oct 2024 05:12:21 -0400
X-MC-Unique: y0qWSpJzNLObY5s4QrqdFQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso960646f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 02:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729847540; x=1730452340;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmxSrcyUFqYxzFcxS1EfVezWS25fp337WV2KUu4otWI=;
 b=SpkXrR8gcXvo/5p3vKosS8HXTBftU3+B7LNy7zLyuP/NDgMYNYhHDIsYnIVe2oA1op
 pYYDC9w8cQxkFnuc6Vkvc+TfDSMoFDDibp394/EmGbTFRF/BIlOrJqknbVapD46RQzzh
 LkAELuUZnfTaVU1XM+eAwSEcwRijE1HnFozX+qvPAwOhiGD7IfuIDBLysk5z8D1WfqE9
 0brQP4Gm8vZmtlKg/Pc4WTTtQY+eS/ReLLsOnfcwmtxNTjZiS7e7cLosA9ATW8xc8TmL
 0F/21qewZqNeAmqyJGCjgKt0mueCEn+IlMK4yt8q9A/JLNhp7YCHredy25FY82Yqdf5m
 Qs8Q==
X-Gm-Message-State: AOJu0YyYnNQlZ3KBgf+0hVubx1sTu9Lz/jbj/QOGrLMtcGTjCvrxyXtx
 jtGyFOgyp6x45DmF1SKLh69bAVJlhVRRvGn0Hj0dc3+6pVVtZUuitv/a0i4Gwu8+7NZS3DxLQWU
 wEKVPOu675XbjP9vteGNjG0fRWYvk70kNQKqLQbAn7MYTDCgj69+t
X-Received: by 2002:a5d:588a:0:b0:37c:bafd:5624 with SMTP id
 ffacd0b85a97d-38045883830mr4267043f8f.25.1729847540185; 
 Fri, 25 Oct 2024 02:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAmovYuGicR0f7YZHfVYIizQgM4vlX4ob+V2HUd9wdJWpDlI945cWl9mX20F/G2LvTHnpSJg==
X-Received: by 2002:a5d:588a:0:b0:37c:bafd:5624 with SMTP id
 ffacd0b85a97d-38045883830mr4267016f8f.25.1729847539757; 
 Fri, 25 Oct 2024 02:12:19 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43193573e47sm12110875e9.8.2024.10.25.02.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 02:12:19 -0700 (PDT)
Message-ID: <abd849c3-5824-4654-a6e3-90aa4aed4a6d@redhat.com>
Date: Fri, 25 Oct 2024 11:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!, use it from
 #[derive(Object)]
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com> <ZxteAWr98He5Zedc@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZxteAWr98He5Zedc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On 10/25/24 10:59, Zhao Liu wrote:
> I want to see how general this macro could be, so I checked current
> type_init() cases for TypeInfo. In most cases, only type_register_static()
> is called directly in the init_fn() callback.

First of all, it's okay if the Rust code does not cover everything.  But 
looking at your cases:

> There are only two exceptions:
> 
> 1. Some init_fn callbacks contain more complex validation or register
> logic.
> 
>    For example, in backends/hostmem-epc.c, sgx_epc_backed_info involves
>    extra check before type_register_static().
> 
>    static void register_types(void)
>    {
>        int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
>        if (fd >= 0) {
>            close(fd);
> 
>            type_register_static(&sgx_epc_backed_info);
>        }
>    }

This one is okay to just change to type_register_static(), moving the 
/dev/sgx_vepc code to the "complete" callback.

> 
>    And in hw/audio/intel-hda.c, there's extra pci_register_soundhw afer
>    type_register_static():
> 
>    static void intel_hda_register_types(void)
>    {
>        type_register_static(&hda_codec_bus_info);
>        type_register_static(&intel_hda_info);
>        type_register_static(&intel_hda_info_ich6);
>        type_register_static(&intel_hda_info_ich9);
>        type_register_static(&hda_codec_device_type_info);
>        pci_register_soundhw("hda", "Intel HD Audio", intel_hda_and_codec_init);
>    }
> 
>    The device can define a custom init_fn() for TypeInfo based on
>    module_init!, but I wonder if the examples above are valid. Is it
>    allowed to include other logic in init_fn()?

Yes, it is but it is also possible to use your own module_init! 
invocation outside #[derive(Object)].
> 2. Some init_fn callbacks use type_register() instead of
> type_register_static().
> 
>    TypeImpl *type_register_static(const TypeInfo *info)
>    {
>        return type_register(info);
>    }
> 
>    It seems that type_register() and type_register_static() are the same.
>    I guess I could clean up one of them, right? (type_register() was added
>    by your earlie commit 049cb3cfdac1 :-) ).

Yeah, you can!

Paolo


