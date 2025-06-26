Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1ABC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 06:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUgKD-0006Fj-Az; Thu, 26 Jun 2025 02:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUgJU-0005f7-72
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUgJR-0003ec-QE
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750920140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KAZXdk40FLAd1559S0hIVauuh/w7lHZ2Iw4QxfarxE0=;
 b=MVmE0igqSx3Q5ixpxInmotuSJdcIg2nQK6muXomtrEGSDVf6/32ghb4ScQM7JtoN7XbBE3
 LA5snkYDzQi4v/slUfkbVJjxvVFN02LEnoTZmo6YnrTDWWaco7oir3wif+tvdAOPuNjjip
 l2Me7zkbSJ8ifwc6NI7ZeZS9U4HnUpw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-8JDHBAzrOpuhMsM_soUl7g-1; Thu, 26 Jun 2025 02:42:18 -0400
X-MC-Unique: 8JDHBAzrOpuhMsM_soUl7g-1
X-Mimecast-MFC-AGG-ID: 8JDHBAzrOpuhMsM_soUl7g_1750920137
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso3253745e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750920137; x=1751524937;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAZXdk40FLAd1559S0hIVauuh/w7lHZ2Iw4QxfarxE0=;
 b=WTGVIT8y4IytMj6K6JXK/ZxgVa8+jKUdYfHqVrrORDthDy8BXHyjXjxbfg8VtcxsW+
 Gcu8YejNRR5yx73LiMVMTJDzfDVhWorV0TgmaaXcx+SXXftPJxc2NhJ4S6Cct7Zyt6i8
 4tZeo/RO/XlpHwZdI90V3VVKk85Gx/pQddCiOW4hgGAnjexrIPpyStsozyg3acfCf31v
 KEONUf37dmki1l0KeNWAhRxrfOPPGZQzukYF/WmOJkyusHBGqISVjbOXcxHxSNZxp/Co
 BQFC0MNs4jpytRPAEpVWq9yw1OZ+TwtXblmdd8hiER343SbclAKcKeX3iAiCgO/4Vlzf
 Y5QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSY2/MLh7UueCc4tiRJhK9T6OLffteU7bwT/N1UdDasSVw3Ygnu0dtNxk0jbjBD8gxfFsFG/7sAp0y@nongnu.org
X-Gm-Message-State: AOJu0Yy/eSQ8jm3ojbyhSGnCq6C54Tqpf/NPRI6Ma3MFi4/jO2/v5rIy
 pm6nwhDnR+X6kVa9P/pFBf/st61aXcvSTNL7xMZXyLEbOlsLHjNVkdO7LD+k4YnMj8irhnocFhs
 IartL/bTNCVCz1w4VpwkzoySNo+4GHuA2/HsInoqCnOOEXHKbK/VrzLOL
X-Gm-Gg: ASbGncsD6tIhwl2kAvDmiMCRWhjD+bGxXpZFSHEhYV4NdgwWp7k5YoB0VkA2AY4JoS1
 cuIRrsq1CY82LvQR0J4/KnwXyzG2dSVdVC8rdJk4VmE6W16LYm7oQTclsXPr29i77YgJhgQWdVU
 epBhMGjej6IGO4HFpbDbI3fFr3wCHewq6sLomXnvq0Q/06G6rUYk0OGVczaxAs3dZFJ8hetvTNM
 YauYBNs+ni0swaaGR6VRmJ5P9J8eWa+rUN1v/xfkfYBrznhC3+dq5ZplZ/5k7f5gK6DkS+velrG
 WZfpNiptWH7P8xk1lSowUNyi1N3jNziy1Xvz8vtn3LFHJDZkUPyMzHTOmLHE
X-Received: by 2002:a05:600c:a01:b0:451:df07:d8e0 with SMTP id
 5b1f17b1804b1-453889d0d93mr21357425e9.11.1750920137243; 
 Wed, 25 Jun 2025 23:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY0J6HsHX2S8AHS8618fx9buu3OgtoFLUeV+lzPYSAJrReDKVC54clGOpi5gpKFtlpzKlYxQ==
X-Received: by 2002:a05:600c:a01:b0:451:df07:d8e0 with SMTP id
 5b1f17b1804b1-453889d0d93mr21357115e9.11.1750920136754; 
 Wed, 25 Jun 2025 23:42:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a5b7fsm9716235e9.10.2025.06.25.23.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 23:42:16 -0700 (PDT)
Message-ID: <215a0489-79b3-4e69-9235-4ad8853471ea@redhat.com>
Date: Thu, 26 Jun 2025 08:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/19] vfio-user: introduce vfio-user protocol
 specification
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
 <20250625193012.2316242-20-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250625193012.2316242-20-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/25/25 21:30, John Levon wrote:
> From: Thanos Makatos <thanos.makatos@nutanix.com>
> 
> This patch introduces the vfio-user protocol specification (formerly
> known as VFIO-over-socket), which is designed to allow devices to be
> emulated outside QEMU, in a separate process. vfio-user reuses the
> existing VFIO defines, structs and concepts.
> 
> It has been earlier discussed as an RFC in:
> "RFC: use VFIO over a UNIX domain socket to implement device offloading"
> 
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   MAINTAINERS                |    3 +-
>   docs/interop/index.rst     |    1 +
>   docs/interop/vfio-user.rst | 1520 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 1523 insertions(+), 1 deletion(-)
>   create mode 100644 docs/interop/vfio-user.rst

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



