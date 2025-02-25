Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD77C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsAw-0008Uh-2u; Tue, 25 Feb 2025 05:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmsAt-0008RI-7h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmsAr-0002QU-CG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740479303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdxe8QVzbSwWLUsTWuIexDFH7Q9sLzTEKsTQQFHaB4Y=;
 b=G/WeFSUVtgwNd7lYoczFS/Xizkcc1lA4AAkpNczDXS7kJRzlLIkMkHhSG68O2xV+jM4Xo4
 rZrnnAdIfhUlaiO3U0ZXJJu72Z5an+TBPQZgPivVf1CXAI2P0Ks5iLG3yKfkMqRbCnlZna
 /djwtO9SgZyzpjUXMEmw0l0pXCHh0fI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-txW7_rjDOe6ZXQdJe8kuzw-1; Tue, 25 Feb 2025 05:28:22 -0500
X-MC-Unique: txW7_rjDOe6ZXQdJe8kuzw-1
X-Mimecast-MFC-AGG-ID: txW7_rjDOe6ZXQdJe8kuzw_1740479301
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f32ac838cso4229710f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 02:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740479301; x=1741084101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdxe8QVzbSwWLUsTWuIexDFH7Q9sLzTEKsTQQFHaB4Y=;
 b=H4ZP/45cSY1Pn1lBS8ilIRxkS5vRstzhERA5mdT18mZ+TbnQ2UO7a7rRHkAofrAhD6
 8UsdlHz8HVaTjP2zdhfDjbKugii5AakdQNjodBV7uriUmV1wZ+qAg9LPer3x3pAdfPjX
 +xMkllAAhtole8ovPeEi45n9X1Dgd4nrz1kcT1FXRzhiL9AeQJDCeQ6Z7b1BprBgl67K
 rgz7LJ6WMgPncejn37VaLCurMBhLB70ih0/rAMk/QWVex0jJQhBvt6w3eIiZIZ7pUt1o
 nVHO+eVIAs38eqmcqq0iHyCzze2n7WkSTPySNJdIcM6p80akllAzyLb+bUSNc4jql+4U
 69Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzX4NBFwasp5+381rAup7iqnP9lRkgZhU6Ve+ND3wewZVsTHMibW41ABweo9GxQTkul4HrreG1VJBQ@nongnu.org
X-Gm-Message-State: AOJu0YzB6vL0gmYEiQYp6bhq7ah29wWPPNZJuD4eIb46OjtShaTXu5sj
 wECGZ/y2lGxtOnqZ+hMsvGUc/IMYYkC5gfm+m7zcWNMd4qKnMsvQ8jwj3Vqhchw/V8Oe0Zw9o43
 sxHSefqNtUHOr57NVIa8JDmEicbPgU393t47bMQo+jocGwE4o06JZ
X-Gm-Gg: ASbGncteZ1QGeN0LzDZBVqpuFMLEPohwfigP86M0wcb9iV7SxjqMeJkQFwVNUZqswHk
 TqJDU2A6KKNE7f/ZUAsnR9BoDLovT+/VOoV3wdzs6gWkuJT7TtlqXDZl2mBNPhSgHO7mDzR0T4C
 eXM4E3BLotPuIbAdWBNJovC3ucQH9fZU8ZMvjF+g2arvzjnIHqXaJ+wfA3StXGtHYN4YyPJLuA8
 xxkA5jLHeCGlzRhYp/JZ7Xv+z/Uqhwj2t6ATPkSOE0nY7w6NDWoVQ1T+8MRjfvwG5aCBMoxw93F
 QT1GDiJmQzCGga6GtZIy2WxYQCSYzbTxP6I0SsGQ/DuXbsH7SBdX1Oaw9rfV7fg=
X-Received: by 2002:a05:6000:1ac7:b0:38d:d299:709f with SMTP id
 ffacd0b85a97d-38f6f0d1d13mr13898202f8f.48.1740479300872; 
 Tue, 25 Feb 2025 02:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvzlh6+2aHay0mh5dt9X9XrQ2uL0w750Zyxjk8feVrR3T9rW5BOvqSic/4J5BfWyRNKck8Kg==
X-Received: by 2002:a05:6000:1ac7:b0:38d:d299:709f with SMTP id
 ffacd0b85a97d-38f6f0d1d13mr13898182f8f.48.1740479300505; 
 Tue, 25 Feb 2025 02:28:20 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc864sm1799744f8f.91.2025.02.25.02.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 02:28:20 -0800 (PST)
Date: Tue, 25 Feb 2025 11:28:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <20250225112819.7cb8b32d@imammedo.users.ipa.redhat.com>
In-Reply-To: <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Mon, 24 Feb 2025 16:47:31 +0100
Gerd Hoffman <kraxel@redhat.com> wrote:

> On Fri, Feb 14, 2025 at 09:04:07PM +0530, Ani Sinha wrote:
> > VM firmware update is a mechanism where the virtual machines can use their
> > preferred and trusted firmware image in their execution environment without
> > having to depend on a untrusted party to provide the firmware bundle. This is
> > particularly useful for confidential virtual machines that are deployed in the
> > cloud where the tenant and the cloud provider are two different entities. In
> > this scenario, virtual machines can bring their own trusted firmware image
> > bundled as a part of their filesystem (using UKIs for example[1]) and then use
> > this hypervisor interface to update to their trusted firmware image. This also
> > allows the guests to have a consistent measurements on the firmware image.  
> 
> Works nicely for me.  Test case:
>   https://kraxel.gitlab.io/uefi-tools-rs/seabios.efi
> 
> > +Fw-cfg Files
> > +************
> > +
> > +Guests drive vmfwupdate through special ``fw-cfg`` files that control its flow
> > +followed by a standard system reset operation. When vmfwupdate is available,
> > +it provides the following ``fw-cfg`` files:
> > +
> > +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitmap of additional
> > +* ``vmfwupdate/bios-size`` (``u64``) - Little Endian encoded size of the BIOS region.
> > +* ``vmfwupdate/opaque`` (``4096 bytes``) - A 4 KiB buffer that survives the BIOS replacement
> > +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is disabled.
> > +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded guest physical address  
> 
> This is out of sync with the actual code (vmfwupdate/bios-addr does not
> exist there).
> 
> Also this adds five fw_cfg files.  Given that the number of fw_cfg files
> we can have is limited I'm not convinced this is the best idea to move
> forward.
> 
> Alternatives I see:
> 
>  (1) Place everything in a single fw_cfg file.  ramfb does this for
>      example, the guest writes a struct with a bunch of values.
> 
>  (2) Go for a mmio register interface.  The EFI variable store I'm
>      working on does this.  fw_cfg is used for hardware discovery,
>      via etc/hardware-info file (which can carry entries for multiple
>      devices).
> 
> See https://lore.kernel.org/qemu-devel/20250219071431.50626-2-kraxel@redhat.com/

After looking at it, it seems to me that data will be in host byte order
and guest has no idea what that is.
Probably it should advertise byteorder as part of the structure,
and guest side should then do conversion if necessary.  

> and https://lore.kernel.org/qemu-devel/20250219071431.50626-21-kraxel@redhat.com/
> (v4 has a double-free bug in patch #1 which will be fixed in v5 of the
> series).
> 
> take care,
>   Gerd
> 


