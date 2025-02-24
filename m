Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC798C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTbo-0005J4-Og; Mon, 24 Feb 2025 03:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tmTbk-0005If-Ck
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tmTbh-0008TS-FW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740384865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qGnIMJKo43PwUnleOPInupxbYcJ04DsMtEO48K4W+iw=;
 b=EwdzUmhsVqySJoYCpyTIP8FFFSybJJxBpKTXOoKcYmedLbC90EjZbCR7FX+755O7k5zJbv
 aZjscmvffn8Zy6YRVKIgAgN4BxZ5eHtNmA3HKse09c05IzvEVJKoDmdYp0XkkCyjonpNJm
 PCYUDptICnkGnPsJcdiT06tmWL9FKuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532--MVpDpmqMRGXChHpdQKSrg-1; Mon, 24 Feb 2025 03:14:23 -0500
X-MC-Unique: -MVpDpmqMRGXChHpdQKSrg-1
X-Mimecast-MFC-AGG-ID: -MVpDpmqMRGXChHpdQKSrg_1740384862
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e873962so20548785e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740384862; x=1740989662;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGnIMJKo43PwUnleOPInupxbYcJ04DsMtEO48K4W+iw=;
 b=Mke5Lo/eJb+zACNUelvrzTaBAdSYsF7adtck7gxyV4ZD5tdkD9mEeSwbnAfTHff1f+
 a193QiMF/FMcOfQqdmOpxRWFnwwblr7LWrN5Ic0lpmvoQb8t/nXSnJJgn9By7/0bcFu1
 42MFpTI/zQ5x94W+redwavg/pwXgWX7isss44u/ZXtAShQXqtXpnj/sCK9SJ4bv6pvha
 ASHS9Y2/ZU0/SRpVoOQMqp7rrP5Q2Mlar+ewU5dAg4ojvqEM065bClfJMGnpW3QR6pDP
 JEvAaDnAlJXFa1f/5y6g8KyJtAJgm4Dko+J9vJuztxFYlonABx9A+u3k4+vxPPnTAu5g
 m42A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXs8BiBx8+oGSaglpqAyB27qV7YQqoI9R5Erm/9VPMz8/iLeWIC9Nqson1oJmw9qLw1kj25WbtevWk@nongnu.org
X-Gm-Message-State: AOJu0YzAg2D0C9ZpbHzaA5aQrzCoSoXq5ZpGqTmdf4tDTqW3GAeNSy7A
 rfm9uWcg4tzHUrmP+k4BsmIiLq867DMEB/ZmtlHr4gciKhfuPncOHicjp3720YKnesJClXIT69l
 3Sc5n+hu9kGgzj4vFbn3FiUF5BM8yz80vD5SIAXAezs4qhsNx5AYo
X-Gm-Gg: ASbGnctVwn35/QChXC3epb/qFAZecrcmGkdJCTIxQ6thPvc88ndwdoIbffT193ipUvF
 UBbcdeIbjEOh19macz34RngI0NCIrc6k7c0FkNvML3FjtlQRpzZWM0pxDeL34JUK0aPp9dJT8Ty
 wUMK/5frhu9QIJo4V9Meioi0lVSVHSbNAJKR9JiQ/2zZHXhxr8LA7XV4WvLaWlN84L7N6NeHB22
 yeoS+KXVbrS4pPJkXWTEPzgplI9w5faBuyyX044tFPhI2Zn+JVkWJ6nSNmhuB2oZCeVSKL2v1z6
 24qnCI7rnuUPVfatKwT/4zWyLs25gR+kfeFNeW7LpHF0KtcgiO2D0g==
X-Received: by 2002:a05:600c:190c:b0:439:8185:4ad3 with SMTP id
 5b1f17b1804b1-439ae220dfdmr88549275e9.27.1740384862067; 
 Mon, 24 Feb 2025 00:14:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Oulb4sxhCKNRZvgOR2I4s4F0kmk8MtNMOKI1N9eHBVs6Dou1JmJcgO3T1eF5YhOBJIbhww==
X-Received: by 2002:a05:600c:190c:b0:439:8185:4ad3 with SMTP id
 5b1f17b1804b1-439ae220dfdmr88548985e9.27.1740384861670; 
 Mon, 24 Feb 2025 00:14:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0371b7bsm98465205e9.33.2025.02.24.00.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 00:14:21 -0800 (PST)
Message-ID: <905d2fc4-c537-4c05-a759-6434af2b4406@redhat.com>
Date: Mon, 24 Feb 2025 09:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250220224918.2520417-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

> An aspect that needs attention here is whether this change in the
> wmask and PMCSR bits becomes a problem for migration, and how we
> might solve it.  For a guest migrating old->new, the device would
> always be in the D0 power state, but the register becomes writable.
> In the opposite direction, is it possible that a device could
> migrate in a low power state and be stuck there since the bits are
> read-only in old QEMU?  Do we need an option for this behavior and a
> machine state bump, or are there alternatives?

Should we introduce a migration blocker when a PCI device is in low
power state  ?


Thanks,

C.



