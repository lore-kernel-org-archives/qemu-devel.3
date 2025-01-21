Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CBDC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDxD-0004Lg-90; Tue, 21 Jan 2025 08:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taDxA-0004Ku-Ur
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:06:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taDx9-0007tm-Af
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737464756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XiUbAhTQX1NUjhqK074VBwe1uYkz0jqo4aSLP15LyiI=;
 b=SznHShYbrLj+wS+NRVt85nsun02MhxYkCjIHwcsZe+2DUBWmLNZzLhkPPLWqvu85XtZ2A4
 mlWEO/Z1TVyc4Ba/htZYNSq0pK/gc4n9rWBDA0t63YR4CBOtZ4YEO1yE7WOgO+cphm9WZ/
 bOeuTsMtC3JoDcZMwj6gwEoPjAZZ+jk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-odqd8sxzPVeNRrD--vOGBg-1; Tue, 21 Jan 2025 08:05:54 -0500
X-MC-Unique: odqd8sxzPVeNRrD--vOGBg-1
X-Mimecast-MFC-AGG-ID: odqd8sxzPVeNRrD--vOGBg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so42700845e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 05:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737464753; x=1738069553;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XiUbAhTQX1NUjhqK074VBwe1uYkz0jqo4aSLP15LyiI=;
 b=dwAGb2N5s1Z5r49okqASjdc9TeIHiWdZYDMA/gazFjfojxsnU0wSadovYuZStSd9bC
 cKQgz/yP1O1mnZD/dHFybcpui3rvPaWMNhj0dknBoBepKa9HbPoGPTuxfATgM5hCEBGu
 eNIXa2xDk4/7JRt3r3uzqMgS49yfQVHNYA/rB2H7Eg1M2ZDYayRx0Sbi/PZBX7LdOHd1
 d9pNGo/7NP/w+NsuXjq8jJnxZ53TglmwWVE+m70lGnHQJdNIzJI7ML/FliQJN3p5WY87
 7iwAN5OnNl99mY44RIKydf7vWhA/EUKNVQ+d+VWcYLDTmDJ6NlrYc3Ct+Zm9rsbDwiAo
 c6/g==
X-Gm-Message-State: AOJu0YwT9u7rCyMMDRfNpU8A8VgkhzDkQF/f4SFcrI9/NHIrM3K60D4M
 sehcOmv+bzePhS0LhRi6v/reZKxZo6N8k/v51SN9TzGf2ekre3WxsyAS2NBMjQ+nkQU+UCgcMB/
 ND62zwKl7TTorkJIzv3cwUpRXe543egGJLFLr4YnZ9m0V9OXab3wL
X-Gm-Gg: ASbGncsr7qjXZBdUJSr0IeVYqn0yexWZQfG/ZXf8LBDXceqJWscTS8a7IEmJsEdlZGE
 Ts29DDyJSX0jkjN9adOSSAM2ap99mwXvGj5XeDIkXyxd8QoLUSlG+uwlYvif6Glqr52EQ5mwIlt
 bEqN39TOt8WHerwVJOfs25f47zcwc7TEwi8ocVOZ929W3BP3Q2Uk9ZBu2du1Q1qv/eBekvojjla
 iOx4jM6paT8Tn/c8J/y6vMnpGHQRK2sEjxsHjNgSkNMlCeny4cxZZFIqUiVR9C0saOgFkgEg+t+
 7XId4iQueBg2IsRck6vri1I=
X-Received: by 2002:a05:600c:4e93:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-438913df89fmr161954605e9.15.1737464752957; 
 Tue, 21 Jan 2025 05:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF85pno/BMiUwrZvb+HEjLQiH0OMIR04SjuhOmOI5jm8XJHVK1+Z19E4XGsaA1VEuIKF1B7uQ==
X-Received: by 2002:a05:600c:4e93:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-438913df89fmr161954215e9.15.1737464752558; 
 Tue, 21 Jan 2025 05:05:52 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6f60.dip0.t-ipconnect.de. [91.12.111.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ace8sm13411475f8f.53.2025.01.21.05.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 05:05:51 -0800 (PST)
Message-ID: <967bd8b2-3a97-4cd8-9f5a-3de3d25fd2d6@redhat.com>
Date: Tue, 21 Jan 2025 14:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Support P2P access in confidential VM
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org, mst@redhat.com,
 sgarzare@redhat.com
References: <20250116095355.41909-1-east.moutain.yang@gmail.com>
 <479d79c7-2cb8-4f32-9bf0-fe1a50931925@redhat.com>
 <CALrP2iXft+p2FiSDUpMn+PnvhUVxw57uRQdwAPGiiR8wjpo5TA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALrP2iXft+p2FiSDUpMn+PnvhUVxw57uRQdwAPGiiR8wjpo5TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21.01.25 09:50, Wencheng Yang wrote:
> hi, David,
> 

Hi,

>  > I'm wondering: isn't this something the kernel should be able to figure
>  > out? Is this encrypted RAM (SMA) or not, and set the flag accordingly?
>  > What are the challenges?
> 
> VFIO driver and IOMMU driver don't know the device(memory or device 
> mmio) behind vaddr,
> only device driver knows that, now that the device is managed by user 
> space VFIO,
> user should tell the info to VFIO driver.

what I am wondering was is: does it ever make sense to set the SME PTE 
flag on anything that is not ordinary system RAM?

IOW: in which scenarios would we set it on a PTE that targets device 
memory or device MMIO?

-- 
Cheers,

David / dhildenb


