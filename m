Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DE8C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 06:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiSll-0005fX-Kf; Thu, 13 Feb 2025 01:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiSlk-0005fD-2H
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 01:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiSli-0000JM-IP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 01:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739428334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UalnhXlX4fOsQ+2Vrz3Nc96asacR+U/dILbXMz9ZvNc=;
 b=T5ufE4Ok32MbPv84dDvU2k5Mu28lKbT+O33bvGEHqtp+NcUahC8+4FYeaI5PCTOZ+1rQI8
 m2ttALzRMSKQF9UihcaBf8Dn5P7PoDHyCNdKqjYf6r8t5xfDv0D+UO0n0G34nl9b7Lh2e5
 DFcwv3J3NP/JiEql0gnB3iuifxydz1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-uJWcmLkrMOuwo9vtDxVVVw-1; Thu, 13 Feb 2025 01:32:09 -0500
X-MC-Unique: uJWcmLkrMOuwo9vtDxVVVw-1
X-Mimecast-MFC-AGG-ID: uJWcmLkrMOuwo9vtDxVVVw_1739428328
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38ddcb63ed1so296508f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 22:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739428328; x=1740033128;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UalnhXlX4fOsQ+2Vrz3Nc96asacR+U/dILbXMz9ZvNc=;
 b=B2qOoJK1NfgvcmoOi7wxZ1TevcMICYxBVZOhw+JkPy3RZ6Yg+MGplG1PVYphkwbQVO
 T1qaiG4OkkjoIFqKxlnAbVn5o/T5n7dNLtQqL0ciQBSReizni0txoeg/KSzhSruAk1R5
 rgC5X4nGmI5ErIoqXfrPsnmp76Ex+Rri2xuoay/ZPyXN1lMugC8D1hbRQgex5m6BDBc8
 j2G9EK5aePfCn3mUkEsijIM+t3oYTLdMIOvqffmCEtFErrF3t0BCHZyLcaUU26bbGDKU
 MBKeDE7NP3BXD59gDZQip96cd/WbAD8gxBXpQJS0K26je4Z9h1Tb27YM4Y7KuFGVSSmk
 kIbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5A8jrQGeW7ntOQjtZB+Sz2WZD4xqA7OzAHju7v4Uc/+ap0iBciLFImXHXO1T3tLf2E1QFkFCK6Kyw@nongnu.org
X-Gm-Message-State: AOJu0YxfviHS0ac31v+Ofv/KkvMySchy9eiym7Ct5xFlPvx5e+imNH3r
 ppeWXfx4u9w5v8TLRUN1NDM1RNsgvCVmjqXpVfnIkPnG4hHz8bAnUa/u+MCuHGR9m1EZGfuuYFe
 h02oGw1irdXTu0eQRG2NXVrxRSAJUoEco+MtnVlAuB0dGnfxjkqIo
X-Gm-Gg: ASbGncsbxOGif8ryxo+o6CcQUFDKGqZsrEpSFvX0NLCj/oGHb6S5lOSsAxnWJ9aptIn
 Ds8MKAHnBj5Zte4UhK9sIwBk8edH9VHnmrnXMx3ZWb4xm64F9yvmrCXdjK/k4jgndBtfWdrTZmg
 6rxmYBE9vIHoyyMQVRcDQgkK3nJGM5FUUCwWQkC/K72P8UVLsG1iVtbfSP5mxPrkZas4RPvosp7
 CfvpPIlCRGuGKgA9F9UuKZkU66IfSVjBRDW8IrgC9wTdLnuTzAr+uYF6GDHDfuXhey88x4PaG34
 Vi5LqJEdS00jhqK/qnc3bYFC4osX38CZRPAqpwW42cE=
X-Received: by 2002:a5d:5849:0:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38dea2e9632mr6159576f8f.38.1739428328008; 
 Wed, 12 Feb 2025 22:32:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2poyGOHC7GkhrDZ2zzar09LyZd7YXZo3EQKz5IMWS0g0ZiAhBQAi/eyYRQVNsJaDRuOluzA==
X-Received: by 2002:a5d:5849:0:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38dea2e9632mr6159556f8f.38.1739428327700; 
 Wed, 12 Feb 2025 22:32:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa6f7sm38569745e9.32.2025.02.12.22.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 22:32:06 -0800 (PST)
Message-ID: <7d076159-d3c9-4b38-bb8c-40645098e28a@redhat.com>
Date: Thu, 13 Feb 2025 07:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/12] vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Eric Auger
 <eric.auger@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250211143340.787996-1-clg@redhat.com>
 <20250211143340.787996-6-clg@redhat.com>
 <9c31241e-96d0-4014-b9ce-42362ea10eaf@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9c31241e-96d0-4014-b9ce-42362ea10eaf@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 2/12/25 20:12, Michael Tokarev wrote:
> 11.02.2025 17:33, Cédric Le Goater wrote:
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> When iommufd_cdev_ram_block_discard_disable() fails for whatever reason,
>> errp should be set or else SIGSEV is triggered in vfio_realize() when
>> error_prepend() is called.
>>
>> By this chance, use the same error message for both legacy and iommufd
>> backend.
>>
>> Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Link: https://lore.kernel.org/r/20250116102307.260849-1-zhenzhong.duan@intel.com
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/iommufd.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> This seems to be a qemu-stable material (for 9.2).
> Please let me know if it is not.

For 9.0 and above. It applies cleanly.

Thanks,

C.




