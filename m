Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FC9C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tie3Z-000116-60; Thu, 13 Feb 2025 13:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tie3X-00010r-Kf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tie3V-0001tV-G0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739471719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OHiFI4SGM+9KLS4EfQRWGW7U6Z+sGKg7ZXQEOUy00CI=;
 b=Na7388FVBWiy8FRSypVfQQESB5vojNlaNHOxDdFpuR19nObGqiRugKtc6X6PJ4UwErXF+y
 AYm0WfapL056pt4GUVa00TA4LxPK/67br4VrxOyB/V9xg7h9FrFSfhOs+rysuPlywTmFET
 LlpjZxMwW/ss53dNxC7dhYmBrNw722c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Qj4Pkw1AOd-pfHQV3wlxdQ-1; Thu, 13 Feb 2025 13:35:18 -0500
X-MC-Unique: Qj4Pkw1AOd-pfHQV3wlxdQ-1
X-Mimecast-MFC-AGG-ID: Qj4Pkw1AOd-pfHQV3wlxdQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dce0d3d34so820323f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 10:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739471717; x=1740076517;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHiFI4SGM+9KLS4EfQRWGW7U6Z+sGKg7ZXQEOUy00CI=;
 b=dARADbkOT/sXthMFYzR3CY+wyluw/vPEWoC+zr8V3rCZht5ey+CrMDa8PLqIvSpRdU
 9/ZTbp/Axk9FVzvYg2vd/DvUeUUJKmq4KtlHMB3FeDchmlh2qNA7GiuOAKPk+uGKKnij
 6cuUj8gEeKOlKFxjTbWfQvHVu0QjDAEv5cH/RFUgua8YKWqd0uC1Rz3GKZQ57pbPD6TO
 bdBeJrOujIMKIaM1BDXwiISmeydEfzjvYv789i0SX4xw11dj+0IxOcyJA4GU9YLs6ru9
 HsI0LvHKgXRxwKbvnxGDNpRcYN5KgLGlc00EDcu32vStX7KsAV51FU6w2anKQsBgOj43
 NjxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV15QzMwTtf7vxH6f9PLVCT8mzwE5D8MvJrqbJU3xhgB2BA/DC9p0B0N7Bz14aM4QWqenCpOFXXFbC7@nongnu.org
X-Gm-Message-State: AOJu0YwRo2Xvgty0bXsVkSP0Hyum7sO9MOixHetEWG7+0OBzzFpuzjVI
 +3E7MgTH/+vUsS7N7+Oc92xv3Cr78Y2GR4fUKt40P2Iutj0NWtRbAQrmivqMVrpbEgxPI40HllA
 uVc78MUIxgEAl+xi5U1hstakAftq1SoTPi/59iOIknaeBJN7UzKVJ
X-Gm-Gg: ASbGnctObz+A0vzntjMYN6SIYgTtxEv7hoA+5GTgnYAGAvDsPLph6xpCgVRH+cS9U57
 5kRK3OU5Dt7nCKcquBKmc+Aik8Wwxor3xvockPlDJZfJvmi2mIvQGRv61FEG+yuGs75idFUVr2V
 pLCZOrKxyE9GC3kiTszC3aWSt1Tge3BOMz7IsqULDfGkpDVX0VPa2sKvFZ2itQHZ+M0rrbYvBIK
 RldPIvoNaTqXHhJRtBx4Rh+n6kHAuBvPnTtAvnv+9X8P0lNMekY37+vfJ0xRMWLHwSQl2MU/hbE
 5RrPJK+rnv4yWQQCDlehNpIG2U+541WgLg==
X-Received: by 2002:a5d:47ab:0:b0:38f:228b:7844 with SMTP id
 ffacd0b85a97d-38f228b78c3mr7031883f8f.30.1739471717500; 
 Thu, 13 Feb 2025 10:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTZhctq/68tBdoo84zl2WnalWzCVmpyQ9oMtYxu68mQQ0N0qrF+gLr8w+k9zbmsWkuJQxRmw==
X-Received: by 2002:a5d:47ab:0:b0:38f:228b:7844 with SMTP id
 ffacd0b85a97d-38f228b78c3mr7031859f8f.30.1739471717192; 
 Thu, 13 Feb 2025 10:35:17 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dd5acsm2590741f8f.35.2025.02.13.10.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 10:35:16 -0800 (PST)
Message-ID: <ec9c9ae7-e14d-41d3-a7be-559dd21f5478@redhat.com>
Date: Thu, 13 Feb 2025 19:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question Regarding the PowerPC arch Support
To: Atharv Dubey <atharvd440@gmail.com>, qemu-devel@nongnu.org
References: <CAKTQj-53s_n=7qdm5eV8vrCLR-AKHBpq1pqCewNKPmyYtHVZJw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAKTQj-53s_n=7qdm5eV8vrCLR-AKHBpq1pqCewNKPmyYtHVZJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/02/2025 19.18, Atharv Dubey wrote:
> Hello,
> 
> I am new user to qemu and wanted to ask if qemu supports AHCI mode in 
> PowerPC emulation.

  Hi,

it seems like the "powernv" machine of qemu-system-ppc64 supports AHCI, but 
I don't have a clue how to use it. So let's put qemu-ppc@nongnu.org in CC:, 
the PPC experts should be there, maybe someone on that list can answer this 
question.

  Thomas




