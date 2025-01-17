Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0292EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYib3-0001bY-19; Fri, 17 Jan 2025 04:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYib1-0001b8-FE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiaz-00035H-VJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737105893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tDNK3Itl48mC30+V7JH6eei5KqzPVYO9+iYMGDD9ePw=;
 b=ZIk3IgtvaHY5xQarOey7QC9b4Bcs4QmqN4KHZ5Zgivs421xIWYWzlavB59YlumVjnrNoMZ
 FwumUR0laCathWXWcYXyIqaRUQ6FJF+bMPxWnkknH4kkNOgtLtuUmRMhYsm+2GsVyieDXZ
 DAswv4cuzBmODiN8X8yhp38ESfQrRfQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-hDtWXWhuMOGEYLHpyZulrw-1; Fri, 17 Jan 2025 04:24:51 -0500
X-MC-Unique: hDtWXWhuMOGEYLHpyZulrw-1
X-Mimecast-MFC-AGG-ID: hDtWXWhuMOGEYLHpyZulrw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so1171628f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105890; x=1737710690;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tDNK3Itl48mC30+V7JH6eei5KqzPVYO9+iYMGDD9ePw=;
 b=qHiEO4I0loUYvhZ+lAU841qb06Pbc8ZsgTQNKORIMFCrspIeOYPwZfqIVMBGNobynr
 U1vSs/j/YcGL6VYvq3BrPkd/eZo2ArxRJfue1LiE2u+ZoJmaWbaKkm3y20XY+bBjzgAF
 B8ihfmK0GmwtGeNMTqhQg69WZ5cXS8o1yaZ+DGz37/q7U9oeGfFBs7LVnkGMk55wd4mF
 LMpErJs5e38yALFOr+Yc0fmXlApSU4rxMJVdwZ/Pmsd0KbUREZMKcdhJMkCeB5DmH4Pv
 5HYAY9zWZ5ebWn6F0hJ2ozp6GGcLJTMSu1lxcpP5EfaW4hfhVAoaFKx5ayEAlPpgiyKy
 /Qrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGuXXCh5d2z/5JUzhW/f7Xc5iggeyZT9RzVKLTWFSb21tc3C5wx0uCAtFaE8CZhR4aBI07iDI58Mx@nongnu.org
X-Gm-Message-State: AOJu0Yxlxnrke3z1s2jQdtBfOtOd5Jupo2L/E4muT5ijoWl5T40ChALT
 52njPTJAh9z+T8kyOE55HiBpniWU7/ReDAqTp6vTA+bDVjDbn6f2n0LHM/7+wwdp9e3XRcYy8wd
 f+VUH0TUpIPBRCzNtldjudSf23/v5V2h5fmIIbUEHgVkajsaDkqT5
X-Gm-Gg: ASbGncuZbtr7eJOxoKMRsZ1sjzTQglTbYNmUpe8uO+ur6GzU/XRS111pvPQHsHdU95Q
 mNFg1QVJblhwfLV4+6l8dnmEU8kNNEv5GYcTyqSxEejuAkk1KdEqhVc3Wisbcyix3m3hr4/qtQ9
 ZBsJ9t/hy6cvuHct9qlgqScRI4oAJdVycf9iOTeceyz3qsxREOd2J3N6TxIX+4bqW4zKkibrb+0
 /74+mkjJDxBx0wtiK0LGWPgeLAsqFrcm3tgTrg9Ohg3XkOdbvraF9ncTlafhWRtx0G5QbeAs3zm
 H64G3QHDKjWt
X-Received: by 2002:a5d:64a1:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38bf57d3813mr1825456f8f.51.1737105890135; 
 Fri, 17 Jan 2025 01:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLsCxvOi6Lzb1sAJij8xn7SFeR1d9gqvsohS9ftO/55RH3uxIS6sgY2xHvTR8RBvkpXERZ1Q==
X-Received: by 2002:a5d:64a1:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38bf57d3813mr1825380f8f.51.1737105889019; 
 Fri, 17 Jan 2025 01:24:49 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327e327sm1949094f8f.87.2025.01.17.01.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:24:48 -0800 (PST)
Message-ID: <c6f75836-b52a-4ee0-9599-3aa5dbea84b7@redhat.com>
Date: Fri, 17 Jan 2025 10:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-18-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
> hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
> We removed all machines using that array, lets remove all the
> code around PVSCSI_COMPAT_DISABLE_PCIE_BIT.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
...
> @@ -1292,19 +1269,14 @@ static const VMStateDescription vmstate_pvscsi = {
>   
>   static const Property pvscsi_properties[] = {
>       DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> -    DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
> -                    PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
>   };

While you're at it, I think this was the last user of compat_flags, so you 
could remove that compat_flags field from the struct, too, now?

  Thomas


