Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB77E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM1v9-0007Pi-K6; Fri, 13 Dec 2024 04:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM1v7-0007PM-JJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM1v0-0002q8-Kz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734081903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G30+jVq7BVqeTyK0CkqzxN0y4eTRKLqiG5jzrqUMBz0=;
 b=iNaJvsEJHs1+KolDjfF8DZEZp1eCaywGtbh8On+XUBSefC29WkL3OqpMUOXxmLYc/JejLj
 PfLdAkl++2pBw6DU7LB+sELTPwupWBPq+m7rbULdAVfjM0yKpgBQ711lf/ifx0vOt4mplW
 iCfbfKJULPJhQoy+yDlVtjIJA3av/ro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-MzMWbfqEMmCrYsDUEWq4pw-1; Fri, 13 Dec 2024 04:24:59 -0500
X-MC-Unique: MzMWbfqEMmCrYsDUEWq4pw-1
X-Mimecast-MFC-AGG-ID: MzMWbfqEMmCrYsDUEWq4pw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so14302485e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 01:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734081898; x=1734686698;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G30+jVq7BVqeTyK0CkqzxN0y4eTRKLqiG5jzrqUMBz0=;
 b=JDwT1PXRpX1eenOqZ/UQCXVFrg6E1ZzpCzs8G7N0KeZEPmhqJfVO9cLiN3w1ehoHYd
 ylPIaWQpFpulwBYTUs+UL6DvkT3wR/SL51b7FjdoIM3VXZSjc5z3BvORoKHIJyIIM7Ae
 vVYs3SjIAx7Z6fzLojv4U2NeqvqGs4GrRqlHR2iF7aIrcQTKmb5E25HuxxBaY0mCQ9b/
 gdCOmOmx1xCyg0uguWROXTb+rnLV43FbV0oO25/cBIp/1nCm3iNHolJiNTvw/r3gPtDy
 wWE/ZjBi7K28qU8fNvQJvRQHMGIEemJAeylQ1jVSHJtQ/ClJU1LAboiu1gMuVGLm2yAf
 GCXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2h1Y6buDwAQXQpneF5lQZ2PTe1866OWNOWfSz14QuU+2/cH9Vfdft5eqwp2Rqse2M2Lt/O5Hy/ww4@nongnu.org
X-Gm-Message-State: AOJu0YzDm8rMOr4l4smT7qyUf1h0EXi/qwqG74CnZTNEM3k/DPtWl9q+
 vdASiybZhz9DPdiXGrwpV5Py3Xn91RMc7ras21F27RiXUICOB02P3NYCz4Jcq3Sr1CIUfwg6eH6
 GAHYTIyNI4i7sPU94EivQcHYdtCOAEopnKN+6d5dPeUJKoq4gMERI
X-Gm-Gg: ASbGncttbIf7WHbykibLmx2K5saLlnhUWhmF+9AdyNluj31OHZnlVFWSuq26iDHj/Zn
 UhFM1j+Zb7gfOKKdOKkVLkWHP2nk62v7DLduhbDMy3KNH56CNsSDzJ2GBzoHWYvE1xPIhHUWN8Y
 fEb7yahphHb+bdJkk/DrSmdEBrLcGC3lZL9mSRbpmvySw2GTEqQx+lfnoFVJuvUpnKHBDYWPB+Y
 K+2BSA9fX70+4C13sr2Brgntbqf3DxLQHM2MEhULljnEomrq0cBlG4tLK4rnrtSeZgGw1xSbhEz
 Ag+HFQ==
X-Received: by 2002:a5d:64e9:0:b0:385:df43:2179 with SMTP id
 ffacd0b85a97d-38880acd813mr1012014f8f.17.1734081898323; 
 Fri, 13 Dec 2024 01:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6i0TSa047SafdVR9y+nFWWb8HsuwbcPIOgNFzRQa+JU0d31kj4ZGw4g2cjkK+pZo8HJTBEg==
X-Received: by 2002:a5d:64e9:0:b0:385:df43:2179 with SMTP id
 ffacd0b85a97d-38880acd813mr1011996f8f.17.1734081897976; 
 Fri, 13 Dec 2024 01:24:57 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c1ccsm6639219f8f.88.2024.12.13.01.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 01:24:57 -0800 (PST)
Message-ID: <f1aff4c3-6395-46da-a19e-f5e7e46f1a2a@redhat.com>
Date: Fri, 13 Dec 2024 10:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390x/pci: relax I/O address translation requirement
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clegoate@redhat.com, qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <990f5ccd-b05f-4e25-bc68-60793d4d21ad@redhat.com>
 <9b143fc7-9ac7-4b87-8089-5209aab186ec@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9b143fc7-9ac7-4b87-8089-5209aab186ec@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 12/12/2024 15.42, Matthew Rosato wrote:
> On 12/12/24 4:10 AM, Thomas Huth wrote:
>> On 09/12/2024 20.29, Matthew Rosato wrote:
>>> This series introduces the concept of the relaxed translation requirement
>>> for s390x guests in order to allow bypass of the guest IOMMU for more
>>> efficient PCI passthrough.
>>>
>>> With this series, QEMU can indicate to the guest that an IOMMU is not
>>> strictly required for a zPCI device.  This would subsequently allow a
>>> guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
>>> PCI devices.
>>>
>>> When this occurs, QEMU will note the behavior via an intercepted MPCIFC
>>> instruction and will fill the host iommu with mappings of the entire
>>> guest address space in response.
>>>
>>> There is a kernel series [1] that adds the relevant behavior needed to
>>> exploit this new feature from within a s390x linux guest.
>>>
>>> [1]: https://lore.kernel.org/linux-s390/20241209192403.107090-1-mjrosato@linux.ibm.com/
>>>
>>> Matthew Rosato (2):
>>>     s390x/pci: add support for guests that request direct mapping
>>>     s390x/pci: indicate QEMU supports relaxed translation for passthrough
>>
>>   Hi again!
>>
>> One more thought: This is a guest-visible feature, isn't it? So do we also need some migration handling for this? For example, what happens if you start a guest that is aware of this feature on a host that has a QEMU with this feature, and then try to live-migrate the guest to a QEMU that does not have this feature? I guess the guest will crash? It would be better to fail the migration instead. At least we should disable the feature in older machine types and only allow it for the latest one.
> 
> zPCI devices are currently marked as unmigratable in s390_pci_device_vmstate so it's not a reproducible issue yet.

Ah, right, I forgot about that migration blocker, so we should be fine, indeed!

> Re: disabling the feature for older machines, OK -- Shall I fence similar to what we did for interpret/forwarding-assist with a new device property that is default to off on older machines ("relax-translation"? alternative suggestions welcome)

Sounds reasonable!

  Thomas


