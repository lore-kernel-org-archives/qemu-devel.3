Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E7CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sOT-0001Hc-HQ; Thu, 09 Oct 2025 11:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6sOP-0001Gm-4d
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6sOJ-00018E-4n
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760023026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L6O38mSJwfwPtPOEqnYAiZ23CzRACuayKbh38tEyw0U=;
 b=d1HTuzAHALNv9ByvvrEDvzg8n471ljpytSFD3WPJlnBAv621D8bWFvXkkiNFoyFwU6P6sW
 25Ry+bmD/33Du2Hum31XA3PToj3jkiTC+cKjHobl/70wdR2xsw/ZWiUZenHxwThu2dZnnN
 8h0sbrejc2RoIdYq+RM9YRD1DoXnZEE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-oHOWQvbuN3CVGfl0OHJS4g-1; Thu, 09 Oct 2025 11:17:04 -0400
X-MC-Unique: oHOWQvbuN3CVGfl0OHJS4g-1
X-Mimecast-MFC-AGG-ID: oHOWQvbuN3CVGfl0OHJS4g_1760023023
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so1058517f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023023; x=1760627823;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6O38mSJwfwPtPOEqnYAiZ23CzRACuayKbh38tEyw0U=;
 b=OFnpvs+Jht2bOHkx32x165LOXQ/CaliMfCDqYkVreuNO9NBFDhVeRdS6Dysybc1tjV
 hkuPShi4MnCWODS6azzIVOzK1ogwO0nEOiSCBpm8uO/EqqF5hpv7VeGar1AbtqhkMnO8
 b0ojGtPjnbTkKj51L3X1K5gNgiXG+sep1m5IdwdO67TokjNHhadGGx+0v5WPpSEEQde3
 IjQB1wbURUcwlLSK8DctvumGHgQfhogmsNXN2OFu15cYINJ98xlFq4KFZfbLgBhXKsB+
 VqZP2dHcp80DIv3Eo0TKgelMS8ZEs/qHIhP5YkHCxGg7p4i6cBmFGYWTkp2kE/ed2hRY
 Iggw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqx6hFQ79VBRV0EyVvFvHGG2M4jAkSMojuPBz+0VwOrZ9m5An5JtjASwEuRf+d9bV21Iw9n/eX1qd/@nongnu.org
X-Gm-Message-State: AOJu0Ywk6A4EefQp+L8umKGOcgz2E4LsFvwtKybpKstYWF/RB1pqxeBI
 L3xqQppMsUwy/s+my8CCxfvM7q2H11adFFloH4w0+fS1aCJS/rCnNUJKpBrCuf9VUryB0WgUEsV
 giKRDHWmw2jjmJNqpnRxn0J+KD3py84qkhZdx/KvRchQOEWMT+rOQugGnKPUbh4aQ
X-Gm-Gg: ASbGncuXV0Uw+9Yd7puqZtoKUNIhAXMs+vuXnfMleAvfRmgAMzPe2IIUxkghE6MIQjN
 UvRG9vWHFzdgk/fpXu5HupunAUwyYNux7IkasV2UJPusE6gZ5coLOt1HqPhnvPSexxhmogFVBBm
 ed+9YeCXxdqeYJ5PUvERr8G8DFhuurSoUxNGktGkEsQlMsFx+d/y2Yerkg7NvjHZCV0jfrhYLMT
 9vUHmWyH2zh+NRA4da8GfI572ZP9noPn9Y+FCHQE7rDJosXeANyt2DscjQZdmk3tpAyYZxWYODv
 dEQdc62ZUHsbgVflfGKdeGQ2k3sdEM/pXp0Ho6rk/7gZAG4vxAglRJ2tW6jGAwSjJ6cW7KOM7hn
 TDw5ry4Xt
X-Received: by 2002:a05:6000:2681:b0:3ec:d9a8:3700 with SMTP id
 ffacd0b85a97d-4266e7c84cemr5140848f8f.23.1760023023048; 
 Thu, 09 Oct 2025 08:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfFjfi5JE67NchaM+b4D7XErKEBGS7vaTLdr9bCyQKxgaGGMYp6CD8uD6kmfw0K3yCOKv6vA==
X-Received: by 2002:a05:6000:2681:b0:3ec:d9a8:3700 with SMTP id
 ffacd0b85a97d-4266e7c84cemr5140826f8f.23.1760023022643; 
 Thu, 09 Oct 2025 08:17:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm36022661f8f.31.2025.10.09.08.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 08:17:02 -0700 (PDT)
Message-ID: <7b282913-8caf-4616-ae38-df5ea30b3e3d@redhat.com>
Date: Thu, 9 Oct 2025 17:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/devices/vfio-user: fix formatting
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20251009140206.386249-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251009140206.386249-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/9/25 16:02, John Levon wrote:
> The example QEMU argument was not rendering properly, as it was not
> indented.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   docs/system/devices/vfio-user.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
> index b6dcaa5615..7c110b1644 100644
> --- a/docs/system/devices/vfio-user.rst
> +++ b/docs/system/devices/vfio-user.rst
> @@ -20,7 +20,7 @@ Presuming a suitable ``vfio-user`` server has opened a socket at
>   
>   .. code-block:: console
>   
> --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
> +  --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
>   
>   See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
>   information.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



