Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37EBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEO7J-0008Qh-1g; Mon, 12 May 2025 04:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEO7G-0008QH-Sp
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEO7E-0006W6-Vt
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747036943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P4dStATD9bImCtBYUMP2BjCOEqPoLTTdyFUtkPVvgOQ=;
 b=dxnPqDjpYTrjsJSN/cP1c/J5Axjf3vMZBgzRTwqLt2x8Y40ZswBVOrRLY1dLFKcZNwp6sh
 XmZHyUtLxcEZorIYTrdF3OVcVHZDozn9N1eel1XKeJHc7WontixNibgIsY3VFSryEFEWzL
 c15XqLdymBFdqAIAkUKJAw6865VZEwQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-lsKCSyMXNGe9CG3VdYBvvA-1; Mon, 12 May 2025 04:02:20 -0400
X-MC-Unique: lsKCSyMXNGe9CG3VdYBvvA-1
X-Mimecast-MFC-AGG-ID: lsKCSyMXNGe9CG3VdYBvvA_1747036939
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0b2e56da1so1538064f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747036939; x=1747641739;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P4dStATD9bImCtBYUMP2BjCOEqPoLTTdyFUtkPVvgOQ=;
 b=Bk7G51ftcIzkxqPC8HjG3vfaxQv7crEmMcwxYLmS/dfybl9YahpdO5dy3pQLKy1r70
 0GzifsEDhUyJejDwA8AIjB+XPJVeSts2Fnqa0Vo6dfS6U/9WRuxFVT0wpP438pa74UAx
 4IdhVf+4ouQhtRmHLszJ+xaZHthLeRJCPGD/KRHiAlIDm/m2C1aEK2md4fcF896UVVC4
 YyBBt3hFqMjMH+h2O6qQ5by+Vm985+YU6BMvoBgwbBYZT6yXg35FpJ3q6c1pKTwAz6C3
 pPonNnafihkPY3CK0iWF8Y1q6uz3N5HR2MlnJSTSwY6gM5qmAocnkSidIGPePh+C9nDp
 4WNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1y4Ruyd7xDSU7d/r0Ei+jbJBIhdKrBV+1ySljyIPm19BhveeWSp2IEfS9orDvGRacc6N226uaTHer@nongnu.org
X-Gm-Message-State: AOJu0Yx1BGmf+oDCyDmiF6cKake42mmEFLE0+27IrsYgO2O9lHLVt27w
 9+8aeymJ+Jabpv6ryRUBEKMqFum20DZipQXIJOFxNKQtiL4afr6DrhPQswya8yYNsGlNRUFhOOV
 7jVKgxo+9OHRvQNioy4OipSHAYHU6/gKNCM2poJEYf1SRG7x7prbPumB0IeW7
X-Gm-Gg: ASbGnctgE+W/WxACOv7g2Xo+GsNeihJVvJUiuAAfDk2Ovr7f/itRppVwvGNZQiX6hUP
 yH4mx7GTcEEAntx9FjZfmDILi/j6+FiqmNiSBzgbk7y3WDneB+yGtuPHdR6gLy02oVj8QeDBjXN
 ifINyilMm2uopWZ8ri0w/XJA/9n4Ee17m/tSoUeMeL2OnHf42J+eH9BCaa4osRspWm5MCQxWTtN
 aW1i4Nxqk6NltrUFDGxBrQKUzJoka5hObTFwc8S1Uz299n1UrpZZTaAZb8b7AV16FAWel7mR9nS
 eyt5bsAS39kNVQ7aZJlMVFdoj58oGLgdk7WUWIT4Q2XpjymzLC8Oa5Go88BAgbaUsocLWyAHvFi
 fsXdUs4AG3yygblkyQk+/DCOqYvHbCJk4ZSNY/ZY=
X-Received: by 2002:a05:6000:4383:b0:3a1:fd06:d1c with SMTP id
 ffacd0b85a97d-3a1fd0610aamr5939231f8f.46.1747036938790; 
 Mon, 12 May 2025 01:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcVS1/z3ZJFICQ3nCIlb6ujxUMxgY/FOY1Q81lAH7Oh0gx0cBBifq8cqcrTL3uW5ghNuZp8g==
X-Received: by 2002:a05:6000:4383:b0:3a1:fd06:d1c with SMTP id
 ffacd0b85a97d-3a1fd0610aamr5939207f8f.46.1747036938387; 
 Mon, 12 May 2025 01:02:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0?
 (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de.
 [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f579aa5bsm11518393f8f.0.2025.05.12.01.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 01:02:17 -0700 (PDT)
Message-ID: <9880adf5-b1be-4311-a2b1-9e9a3cade213@redhat.com>
Date: Mon, 12 May 2025 10:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] memory: Adjust event ranges to fit within
 notifier boundaries
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 philmd@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com, sarunkod@amd.com,
 Wei.Huang2@amd.com, clement.mathieu--drif@eviden.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 02.05.25 04:15, Alejandro Jimenez wrote:
> Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
> valid and required operation by vIOMMU implementations. However, such
> invalidations currently trigger an assertion unless they originate from
> device IOTLB invalidations.
> 
> Although in recent Linux guests this case is not exercised by the VTD
> implementation due to various optimizations, the assertion will be hit
> by upcoming AMD vIOMMU changes to support DMA address translation. More
> specifically, when running a Linux guest with VFIO passthrough device,
> and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
> Remove redundant domain flush from attach_device()").
> 
> Remove the assertion altogether and adjust the range to ensure it does
> not cross notifier boundaries.

Looking at the history, we used to have the assert unconditionally, and
made it specific to IOMMU_NOTIFIER_DEVIOTLB_UNMAP in

commit 1804857f19f612f6907832e35599cdb51d4ec764
Author: Eugenio Pérez <eperezma@redhat.com>
Date:   Mon Nov 16 17:55:06 2020 +0100

     memory: Skip bad range assertion if notifier is DEVIOTLB_UNMAP type
     
     Device IOTLB invalidations can unmap arbitrary ranges, eiter outside of
     the memory region or even [0, ~0ULL] for all the space. The assertion
     could be hit by a guest, and rhel7 guest effectively hit it.
     
     Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
     Reviewed-by: Peter Xu <peterx@redhat.com>
     Reviewed-by: Juan Quintela <quintela@redhat.com>
     Acked-by: Jason Wang <jasowang@redhat.com>
     Message-Id: <20201116165506.31315-6-eperezma@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


I think this change here is fine, but it would be good getting Pete Xu's opinion.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


