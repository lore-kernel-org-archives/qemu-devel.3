Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F195C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 19:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpYCu-0006r8-4i; Tue, 04 Mar 2025 14:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tpYCY-0006oc-Tr
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 14:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tpYCV-0003s5-3p
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 14:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741117507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tmIv44zPtxIDvzjpq4iHerVOxcgBtfTsXACjwPGsLuI=;
 b=GOztyWHfhSAkHfeZilulY2VyiPYrdsGAch1WZ0mhUrw03O/1ANWHy0WWObCxj0q66MUY3G
 FFJmX8eagyzavoMD2W47JvesdDPN0qqPGlX/10RnnclXeNHNkuANjZOIKbHlXCfcJxsP7J
 ycuyTk1Sq3Vbi4keebSORSKymHi4B4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-dTJHF8cbPAaBFK5vgdLEgA-1; Tue, 04 Mar 2025 14:44:56 -0500
X-MC-Unique: dTJHF8cbPAaBFK5vgdLEgA-1
X-Mimecast-MFC-AGG-ID: dTJHF8cbPAaBFK5vgdLEgA_1741117495
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390e003c1easo47128f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 11:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741117495; x=1741722295;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmIv44zPtxIDvzjpq4iHerVOxcgBtfTsXACjwPGsLuI=;
 b=fUl79hhS3gbGhbfDrg5EhKWxxnQcpIoFc652IuM8UqV1vWOC1r3e3buyqy3MN5S6hE
 /YK0TQ69uiEd+7uXOG1dR4gf6HL0JDA1Fqxyf/eG/yTOaxpt5L2UQVfj9bacCFKeq5Ed
 qCKByqmvI5acUrbXZom5mzDeok7i9jgRvK8FdfG11uVG5VY9ow6nUm+P9WSzZwy9SDfO
 myvfCBiB4uonA8NV/KCpNc+CKzd++nlHKr09EhM6/1hByaYbphPhv1wnvIYwid14BtgI
 835hBPw2knI8yd/izR/OuOqPc6z0npncJBcU/+LQIUcLBjESAshVuOIPbsNxKBQWze2m
 1htQ==
X-Gm-Message-State: AOJu0Yyu+dYzpbQRIPmWGVER1vpxDDkss6AqhLsav6OBXa4bLXhMn2JG
 Gj9UGlBfe1DsHrCZh3LxGbIlFY1F8Qa7rfEQ+idXDGLvIhH1NbIkA/zWnjdi6qI0A807VxJMFgm
 2KGoS8z/VFLGYLdDzX5BCFThSnbcMPThkQH/IuS9EULXuemtwtXyI
X-Gm-Gg: ASbGncsKSaXADUfBNVCEPIcMd1fAEs8l+Uz8SFjlWiNeaB/ahQ8JO8+mujeP4oUShRT
 3DfZEcK+Z7PekxHjT5TLqr54K45WRpFrwMsFlImd4536w+8hR8BJ9MwGvP8PNA0qHWGaeRfkONE
 RTi8AmazrNXepidFDdNajm+0O8O7QCQ5W/7lxc9sqbMLMUB95MbqpP9n8wIFbC6kfYoPuoWoB6b
 Pv2JoBW2lLSuhzThY6hbgmSqVyjcdqkTzu7KV4MV9O+uM+KbUh+iAEakEKe3Gl1fLxZmhUAgGvw
 h8h/kQNxwZl60deDDn4=
X-Received: by 2002:a05:6000:154e:b0:390:fe2d:3172 with SMTP id
 ffacd0b85a97d-391155fa457mr3482371f8f.3.1741117495346; 
 Tue, 04 Mar 2025 11:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsBhwPJdfZObhvsd8Hhufx6ErDTMJRDFhCDgfxLLjoSulUTK7jZ/QnOeidw+RjwlaZVHxAaQ==
X-Received: by 2002:a05:6000:154e:b0:390:fe2d:3172 with SMTP id
 ffacd0b85a97d-391155fa457mr3482354f8f.3.1741117494931; 
 Tue, 04 Mar 2025 11:44:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-390e47a66bcsm18408519f8f.21.2025.03.04.11.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 11:44:54 -0800 (PST)
Message-ID: <79ca1c7b-6196-41f8-a25e-154b13fc70cb@redhat.com>
Date: Tue, 4 Mar 2025 20:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: cell: add full example of declaring a SysBusDevice
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250228085506.846381-1-pbonzini@redhat.com>
 <Z8cyhSfdeTufVzaj@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8cyhSfdeTufVzaj@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 3/4/25 18:04, Zhao Liu wrote:
>> +//! struct PL061Device {
> 
> Maybe PL061State?
> 
>> +//!     parent_obj: ParentField<SysBusDevice>,
>> +//!
>> +//!     // Configuration is read-only after initialization
>> +//!     pullups: u32,
>> +//!     pulldowns: u32,
>> +//!
>> +//!     // Same for sub-objects of the device
>> +//!     out: [Owned<IRQState>; N_GPIOS],
> 
> Should this be InterruptSource type?
> 
> Just have a quick look at pl061.c:
> 
> qdev_init_gpio_out(dev, s->out, N_GPIOS);
> 
> So in Rust side, `out` would be initialized by
> DeviceMethods::init_gpio_out().
> 
> 
> Others are fine for me ~ with above nits fixed,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Yes, all good points.  Looks like we're set for 10.0 soft freeze. :)

Paolo


