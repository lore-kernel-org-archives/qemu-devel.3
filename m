Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AD9C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5Lc-0003Ug-78; Thu, 06 Mar 2025 02:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5LY-0003R0-A8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq5LW-0000tg-El
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741244920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aq7el6MmM+lyQkTtJn25+TSSbUsMvqeVY+xw1CoOML0=;
 b=K5XhkMid1U5FU15DMimp9Ynr/IGX5A0J7nA1Yg374d703ZNbL4T3UCiObwDif6lZGYrQDV
 +7nIMslLPrWTu8T7VJ7lCfyXCzUc9OnZkX1P6ZhXycVX5SA7lbGby9QVnpdRvkiSqMH0ZH
 g1RcK0tsw/zfXdivSjV85tbGh4RvVzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-AWJp-e0hOo6KRhLIwEfRTQ-1; Thu, 06 Mar 2025 02:08:29 -0500
X-MC-Unique: AWJp-e0hOo6KRhLIwEfRTQ-1
X-Mimecast-MFC-AGG-ID: AWJp-e0hOo6KRhLIwEfRTQ_1741244908
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bbbb00891so980775e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741244908; x=1741849708;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aq7el6MmM+lyQkTtJn25+TSSbUsMvqeVY+xw1CoOML0=;
 b=PdYlJBkLr7MXfYqGR4x3k5Jh+2VBM2o0yCgbH453kwkE+IEv4er7JmIRODkhwL3TF9
 19z4pQCNdBVDC9rMH16mSwLCWW/iIuQ5YNrpzvJnOOYjXGOduLq+5fpV8FskeXaluVpr
 denDL9vckK/RkwhfFvB9WdTBr80bE60N6LyPhPeojTRpU/UhFLhE9kwS+lQGauumE442
 OvjfYHtv4gqJfN9nckOUEINcaWlR5EtM+q+NppEwx7SnVCTT9gNjr2PkrxalqBWeiMEW
 45IfmoCS8lcy/h/folIyPe1kYjbdZGSLYV1zeZG+0soc425bdvKd8yIq36wcApWlyZOx
 1biQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3oa+Y0wskXRFXlvT38mLv6heRcuF7+T1UugXBNSZipiJJV912JDlpvD1gcuvCZdLvWZ78hDXxTjO8@nongnu.org
X-Gm-Message-State: AOJu0YyurQtccPrSah076mhgpNuxYFt4a2U1Pt//tLXzoOK2hR27EscI
 VBtHzmxofkBD1yhH5riLIUlTHzTvPDumZkgaGfTx5euvOsZeMWusUVbzfKa+j0Qf3nSX9Fgww79
 +6lOmjsRxdRKU8e/3OL3WLFN6tYbXWvvvhwGsqJizq5wHRcLU79u5
X-Gm-Gg: ASbGncsmI4EtqHvPBkz57FwZlzwd7NIePRSNXABip/AoKlhLDRKW5DYLuBfg1Q10x+L
 kmpeJ6RvGHkeGKWMkpvSfFt0GRoDOzJYsICs4meQNfBepmmXo7/hM/vqo1lafqObQRUQHBnRr/T
 OCtaPgZbs6a7q3DD+1GLC+jsPJOKWkZO9i0wEaAJhhaHYMJ5GiGIkKdHmTAAOB4aXICZSp3wma8
 IZ+8IdBf8u2BR4OQbm9Eq94clvYqQ/HrJMaQYPHfXekc26SjjMQjbTRgV62c8ZHyjX4MIlWM4Hp
 8yyF43m7UKmRqb9FylbUBdjBuvI9qJ7RAcxK1ehhGFtc/D4=
X-Received: by 2002:a05:6000:1542:b0:391:2391:2f79 with SMTP id
 ffacd0b85a97d-39123913196mr5596379f8f.43.1741244907895; 
 Wed, 05 Mar 2025 23:08:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBNJcc5ikHkpNhh9AXpXifgRrFp6Ucj/Xyj7REs/wXS5KrjlzVuILOaoFmD9FiKKAyojlZiA==
X-Received: by 2002:a05:6000:1542:b0:391:2391:2f79 with SMTP id
 ffacd0b85a97d-39123913196mr5596345f8f.43.1741244907492; 
 Wed, 05 Mar 2025 23:08:27 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0194f2sm1044419f8f.54.2025.03.05.23.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 23:08:26 -0800 (PST)
Message-ID: <ad51f681-98d1-4347-bbfe-5ffb8366af8d@redhat.com>
Date: Thu, 6 Mar 2025 08:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] s390x/pci: relax I/O address translation
 requirement
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clg@redhat.com, qemu-devel@nongnu.org
References: <20250226210013.238349-1-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226210013.238349-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 26/02/2025 22.00, Matthew Rosato wrote:
> This series introduces the concept of the relaxed translation requirement
> for s390x guests in order to allow bypass of the guest IOMMU for more
> efficient PCI passthrough.
> 
> With this series, QEMU can indicate to the guest that an IOMMU is not
> strictly required for a zPCI device.  This would subsequently allow a
> guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
> PCI devices.
> 
> When this occurs, QEMU will note the behavior via an intercepted MPCIFC
> instruction and will fill the host iommu with mappings of the entire
> guest address space in response.
> 
> The kernel series [1] that adds the relevant behavior needed to
> exploit this new feature from within a s390x linux guest is available
> in linux-next via iommu-next.
> 
> [1]: https://lore.kernel.org/linux-s390/20250212213418.182902-1-mjrosato@linux.ibm.com/
> 
> Changes for v5:
> - Add some review/test tags (had to drop some due to code changes)
> - Dynamically allocate iommu->dm_mr, remove direct_map bool
> 
> Changes for v4:
> - use get_system_memory() instead of ms->ram
> - rename rtr_allowed to rtr_avail
> - turn off rtr_avail for emulated devices so MPCFIC fence properly
>    rejects an attempt at direct mapping (we only advertise via CLP
>    for passthrough devices)
> - turn off rtr_avail for passthrough ISM devices
> - various minor changes
> 
> Changes for v3:
> - use s390_get_memory_limit
> - advertise full aperture for relaxed-translation-capable devices
> 
> Changes for v2:
> - Add relax-translation property, fence for older machines
> - Add a new MPCIFC failure case when direct-mapping requested but
>    the relax-translation property is set to off.
> - For direct mapping, use a memory alias to handle the SMDA offset and
>    then just let vfio handle the pinning of memory.
> 
> Matthew Rosato (2):
>    s390x/pci: add support for guests that request direct mapping
>    s390x/pci: indicate QEMU supports relaxed translation for passthrough
> 
>   hw/s390x/s390-pci-bus.c         | 39 +++++++++++++++++++++++++++++++--
>   hw/s390x/s390-pci-inst.c        | 13 +++++++++--
>   hw/s390x/s390-pci-vfio.c        | 28 ++++++++++++++++++-----
>   hw/s390x/s390-virtio-ccw.c      |  5 +++++
>   include/hw/s390x/s390-pci-bus.h |  3 +++
>   include/hw/s390x/s390-pci-clp.h |  1 +
>   6 files changed, 80 insertions(+), 9 deletions(-)
> 

Series
Acked-by: Thomas Huth <thuth@redhat.com>

I'll queue it for my next pull request.

  Thomas


