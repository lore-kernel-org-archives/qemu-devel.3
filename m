Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70256C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8w9-0002rn-K7; Thu, 20 Feb 2025 10:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tl8w7-0002nX-9N
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tl8w5-0005Dd-Is
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740067080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWl9zI0sbg/l3Qyu6PbiDjQxtCyO2/Z028jbv/EMVHo=;
 b=Op1Swx0fvHK1hDCWicdtxlmHp8ID6GJ7gzg1PHVY6gPSqTTdIYoD51mw58LPpVZbFnBpvu
 Us/xyfyKoL2GDbbLygMuteq8vTT2TLM37f5NSR243HH4NZ+zhix0ZJISgqGLwrYnfo/L/F
 CaBmpuCUoxcOGU4FJ9yXFRAREwsOoww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-TJNt14AuNIGmiBTvdW-GpQ-1; Thu, 20 Feb 2025 10:57:56 -0500
X-MC-Unique: TJNt14AuNIGmiBTvdW-GpQ-1
X-Mimecast-MFC-AGG-ID: TJNt14AuNIGmiBTvdW-GpQ_1740067075
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e180821aso5630845e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740067075; x=1740671875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iWl9zI0sbg/l3Qyu6PbiDjQxtCyO2/Z028jbv/EMVHo=;
 b=n74KZYS3uCDa53lN+bFysVt9h+/1M9owcWmDUUCvQFMmOjgA6DTEwsmvy8rdM19Lnn
 t+mwsIOUlsBufX5utzfJgACPIIPZekzPYFWbWfIRCEw/B5AlHgqIxr774zk9BkDRP1w5
 dHTjKzyjstfxaazlYKgPgyY44Ic6oY+CH0CzF0y9LjbTjUnrsmfbt9d6+Ks5YApMJDGq
 WHXJ0y1nwCh0BC9PhevBgA1ubChrIT9ctIxXTbFK+2lUWlGHkmPLc0VhOSYCybu+Qtj3
 NoMo5EQdalUmDT/4+uvSwTmZ24i4yhyhIK+jL8GRBVYnUd4nllDCztNwXbO9oPpxDDmE
 E+Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1v91qcCo8aqQTkV2iLqLoW+/hIKeZPs0NY15EUH+eFfQ9qqiO3dzfo84HUQeGhhhG32IR/GWPG8vI@nongnu.org
X-Gm-Message-State: AOJu0Yyj0D8hLztqFtxEU5aRo/YTNOFkBXMySFtbcRG1cYQ6U5f5dkHP
 kYk/tQAGek/33821jfylCEcyORiJuAMqmBeN6AIn/LChoPnfp6ww26mKyPjeJWmuYeQ6yU86rpb
 NzMSgfmzutQYs1IlqqMZypoQrArDaN4NLKUARW+p9jibsw5+Y++gQ
X-Gm-Gg: ASbGncsTYtwz6lBzK2cs9lagIhpii4OnXwFj7jvfzRgVPW9iMygeym4QTRh4/8yg/bn
 pJnY9O/bzLJ0jvB9Vk9e71J29G2S1MoaUQfwshXIA42H/TowHWNKx8tK4COvzQ8OPbTMTCmalgU
 9K2ciubyAH6z3YO2CGGOZE+OtZq3/dP4HsRjgh93mbM6cKJrdM5FpwvH7ui0eUEPhkZmu+nRsSe
 6tNypWLvFmb0lXcoDPxM0XZrEuS4jRHprCEhAGELAcm2wsZ1hWKvflJtiIvJtVf1JA85LZFrkn3
 cIfBKQVVFKeYViXp68+s0wF2YYiDMzBtr4O4MOsfwMD6o1+RZrtU
X-Received: by 2002:a05:600c:1d27:b0:439:9e8b:228d with SMTP id
 5b1f17b1804b1-4399e8b2474mr51062005e9.19.1740067075343; 
 Thu, 20 Feb 2025 07:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz/+kxx/GkBXkR5Np4V7Uge+qpjysi6qE9cqNziS/byp8jL5J8VCjPMbrYuHh9vYktQwJp6g==
X-Received: by 2002:a05:600c:1d27:b0:439:9e8b:228d with SMTP id
 5b1f17b1804b1-4399e8b2474mr51061755e9.19.1740067074965; 
 Thu, 20 Feb 2025 07:57:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5e92sm21300934f8f.66.2025.02.20.07.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 07:57:54 -0800 (PST)
Message-ID: <fa16f5f1-48a2-4c5d-8b80-4ec012871302@redhat.com>
Date: Thu, 20 Feb 2025 16:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1c073acc-095e-45f0-977c-e22557f180f2@redhat.com>
 <20250220102429-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250220102429-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Michael,


On 2/20/25 4:25 PM, Michael S. Tsirkin wrote:
> On Fri, Jan 31, 2025 at 10:55:26AM +0100, Eric Auger wrote:
>> I tested [PATCH] virtio: Remove virtio devices on device_shutdown()
>> https://lore.kernel.org/all/20240808075141.3433253-1-kirill.shutemov@linux.intel.com/
>>
>> and it fixes my issue
>>
>> Eric
>
> To make sure, we are dropping this in favor of the guest fix (which
> I intent to merge shortly), correct?

Yes this should be dropped in favour of the implementation of the
shutdown callback on guest side. Did you send your patch, I did not see it.

however on qemu side, there is "[PATCH v3 0/5] Fix vIOMMU reset order"
that needs to be merged to fix qmp system_reset.

Thanks

Eric
>


