Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1154ED68BC9
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCITZ-0008W1-B1; Sat, 16 Nov 2024 08:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tCITY-0008VW-5J
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 08:04:32 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tCITW-0007fD-8S
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 08:04:31 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso2758545b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 05:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731762268; x=1732367068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JrB4xR7NrOxza1Ts14L8SnYo82Kbim+uMMw6HugfaQY=;
 b=WNkE24d8qp5T7YRImN2NLGG+RhKsLJXG13Hd8mSBSu2BavJTjrYI2BKX4HrsWo+/cd
 Yaw9ZNdNWcCp8gFhVXByXB5ahofZIycK/0itTV/hQqqGL3S8i6zKro2qK7xNuTdjZWP0
 vLiXqN7YDHtPubMEa+sYQr8+4u1b6quW4ClKOCEFnyKBHZMgyct2Wokl/01OGQQCwJnV
 bTFVC8hREVf8Zfzq+ZKQhQ63CdXe+wN20cWzihOSO/Mp7BOxkDchVv5HfdQfUIdohiri
 V6lHw/D3n93L9vUR+j3YcwRAL5GDwghCZHklOkwBqb9L9i4jnL6cITl4QebvCzXcCKoP
 xQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731762268; x=1732367068;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrB4xR7NrOxza1Ts14L8SnYo82Kbim+uMMw6HugfaQY=;
 b=iaGvs8mPfzV6w0dyoDsGmp2bkaah2bUCuwq8jff0sFoIZeVFf0KeIo49w5IJcjR/Sk
 CDb7c9YZ8yvA/eM+bzQY0oLIWM2KUXe/P4jPwn16U3WemwfExmBj5zAJPK+/HwqJ4pR9
 4c2DWxRSCDmY7jyIn2vSoYw/PFBD2wTCG/oCW0ftBdZtv6pn5mqiniCMF0mDYknIeIjz
 lkuXl4pMWSx8NueCpZoK5uR3SJ6GhCadsLUqYw+NcHyNsvwPYfLnwakT1rFmkAeL9ge1
 ILZQHARRm8DecuKaYKckAmVCOWIOO6rch9+QHNE+nOKRwLA/OzKT5Gij2IYg6ylisv97
 NsKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6seBOF5vZLAcS7oZV4F1xhZSbZ+OtUWkFgapA6HmYXVASn9eOtGu9psmXNFrlasMOdyXY5iQrB3VM@nongnu.org
X-Gm-Message-State: AOJu0Yyyl3FYslKx1aXuUvsVwoYF6x6MGKnc274zDB/APEbPCaiJSNZn
 Hc82eMwXeZZv2gjDeQseYeBcrVL4PbsnNo+XqZD1ci3wGjEQBXei
X-Google-Smtp-Source: AGHT+IHdav85v1ZSu+7ERedV6cEizJiQnsNpTFPkTT3wIgXnrqlwD4KF9VmCUeL5mS9JPTFTMo3yyg==
X-Received: by 2002:a05:6a00:4b4f:b0:71e:79a9:ec47 with SMTP id
 d2e1a72fcca58-72476b96825mr8657519b3a.6.1731762268069; 
 Sat, 16 Nov 2024 05:04:28 -0800 (PST)
Received: from [192.168.1.8] ([223.233.87.157])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7248305a356sm1804799b3a.34.2024.11.16.05.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Nov 2024 05:04:27 -0800 (PST)
Message-ID: <dae3a8a4-b60e-44db-9224-af3258c1e339@gmail.com>
Date: Sat, 16 Nov 2024 18:34:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Support setting vring_base for packed svq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, sgarzare@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241104162124.49867-1-sahilcdq@proton.me>
 <20241114015754-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <20241114015754-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 11/14/24 12:28 PM, Michael S. Tsirkin wrote:
> On Mon, Nov 04, 2024 at 09:51:24PM +0530, Sahil Siddiq wrote:
>> Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the
>> vq state to the device's initial state. This works differently for
>> split and packed vqs.
>>
>> With shadow virtqueues enabled, vhost-vdpa sets the vring base using
>> the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
>> differs for split and packed vqs. The implementation in QEMU currently
>> uses the payload required for split vqs (i.e., the num field of
>> vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
>> payload is used with packed vqs.
>>
>> This patch sets the num field in the payload appropriately so vhost-vdpa
>> (with the vp_vdpa driver) can use packed svqs.
>>
>> Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
>> Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> 
> Looks like a feature, not a bugfix to me, so I guess - next release?
> 

Right. Also, based on the discussion in the reviews [1], it's been decided
to consider this patch for release when the patches to add support for
packed svqs [2] are also ready.

I'll resend this patch with the other patches.

Thanks,
Sahil

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-11/msg01432.html
[2] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue


