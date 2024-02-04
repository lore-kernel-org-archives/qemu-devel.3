Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8279C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 14:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWdbs-0004oW-GI; Sun, 04 Feb 2024 09:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWdbo-0004nm-H5
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:36:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rWdbm-0003sz-1Q
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 09:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707057390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SDkM9qdjqdwgAJRX7NDpwd6+Mkk5ECioN5WdvzaIcQ8=;
 b=EOJZQsPuKIn71EegvQoZiQEPrPfmIOFuAkvF74RvTMMjekNz9/k1AeWtmKfDoZiT11gvtX
 8B4Ts9JscgzbG94EJoPI9dhAZ8nJQ+h5QDmdIb2zjkYiTHCGGm00Pv5P1ItCXEmwhF1c+/
 UtqmVOn4MTeSfaG3hm1Th4PZm5bDxGg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Svk-bFfSN2Wiqx8593LDLw-1; Sun, 04 Feb 2024 09:36:28 -0500
X-MC-Unique: Svk-bFfSN2Wiqx8593LDLw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33b2badbb4eso562784f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 06:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707057387; x=1707662187;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDkM9qdjqdwgAJRX7NDpwd6+Mkk5ECioN5WdvzaIcQ8=;
 b=LTKO10mfBAbMae85UjGcQLSzn1Rxa61Df1WTVnvCrftEL+t3QZUFkAtdrwCYQRRHG2
 fgwVIROq/eLIbVjvbKc59hGMDpc73QDRtK44wTKNxlTknhrADL2auDPcD6xX3F8GY/Uj
 /ztkNuzJ+1/eCokxLG3WzBEiqIANYNWftwogh/0Szcj4LItVmlQivKJe0Vip+SZOrKd5
 fAPjw9qRRVyh+4+60LCO6lh4zrhhv1ZmvoV4ldM77jMk0IPgVMs5d/Pdl/nXAzMl7rqw
 KGwTeeH7OuBgXb7J95imDdQxyLQ6jHq9dXsfVeWCWBF1/SAEAzxvPNB3XLVXEmOog2jz
 dzFg==
X-Gm-Message-State: AOJu0YwrDsD/u00J6hXhRGG3etxO0DNX/gYRC103SbOcRlpmNO+o3VNp
 uWMQ+Y4xPoxn65jUJCWkFLsKKMM9dCUt66jwUCIqdp1Y0KAgoHhgFcZ07Lk8jiNvwS1690k7Yzu
 nPlfsS+i/sBWBHTtOHxLhl5bc+8XYATG8ms8U0sSNN4Q2BnRblmLv
X-Received: by 2002:a05:6000:104f:b0:33b:1293:55c0 with SMTP id
 c15-20020a056000104f00b0033b129355c0mr7433190wrx.49.1707057387347; 
 Sun, 04 Feb 2024 06:36:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxVJYiT2s0dR6bz50PcDmpAo4//7Zf4sIPjTkZMNwRLFWGbE4cIgJWtHWmNgJQMXPqfeZ6bQ==
X-Received: by 2002:a05:6000:104f:b0:33b:1293:55c0 with SMTP id
 c15-20020a056000104f00b0033b129355c0mr7433178wrx.49.1707057386975; 
 Sun, 04 Feb 2024 06:36:26 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW8g6QsZ1bkZa4IR/REwbIzYOdgPy/zrtA4jQ/Pe/Uc1c5dzzW/tQl1YIoTze2c10CpD4gzTtmXjk19uc2uW67cFdF1ugjJZo2ytsv0PQvxcyRVvcJLLOxfHpAHA8wT/bVG04YLcZQ7BobNucTw+HekLKdxm4pD1AvkAr32DGe+yC2ZVr1pmXCeSeZLwcgZ4eXzQvdPECnQ1i31/2BouF4a4HCdoHU/lqq9AeQtJOI=
Received: from ?IPV6:2003:cb:c725:700:519c:c741:25de:232f?
 (p200300cbc7250700519cc74125de232f.dip0.t-ipconnect.de.
 [2003:cb:c725:700:519c:c741:25de:232f])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a5d608e000000b0033b3cd4ad89sm344391wrt.59.2024.02.04.06.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Feb 2024 06:36:26 -0800 (PST)
Message-ID: <8c3ffb6e-0b77-41ef-8f8a-ea67b62ff410@redhat.com>
Date: Sun, 4 Feb 2024 15:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] libvhost-user: Fix msg_region->userspace_addr
 computation
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-2-david@redhat.com>
 <CAFubqFuiQ5vEzELv0_y2+9KwhLDs3mNJQXMfeR4_YFMumo-x_g@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFubqFuiQ5vEzELv0_y2+9KwhLDs3mNJQXMfeR4_YFMumo-x_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04.02.24 02:35, Raphael Norwitz wrote:
> As a heads up, I've left Nutanix and updated it in MAINTAINERS. Will
> be updating it again shortly so tagging these with my new work email.
> 

Thanks for the fast review! The mail server already complained to me :)

Maybe consider adding yourself as reviewer for vhost as well? (which 
covers libvhost-user), I took your mail address from git history, not 
get_maintainers.pl.

> On Fri, Feb 2, 2024 at 4:54 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> We barely had mmap_offset set in the past. With virtio-mem and
>> dynamic-memslots that will change.
>>
>> In vu_add_mem_reg() and vu_set_mem_table_exec_postcopy(), we are
>> performing pointer arithmetics, which is wrong. Let's simply
>> use dev_region->mmap_addr instead of "void *mmap_addr".
>>
>> Fixes: ec94c8e621de ("Support adding individual regions in libvhost-user")
>> Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
>> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>


-- 
Cheers,

David / dhildenb


