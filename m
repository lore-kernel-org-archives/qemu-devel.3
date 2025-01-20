Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6447C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyF9-0001Sz-9J; Mon, 20 Jan 2025 15:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZyF7-0001Si-9a
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZyF4-0006TA-FV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737404363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUWDGIwO1FbEQxMvPfuVA74bL427fymFcpQS1Zu4RrY=;
 b=cCjUP9PfdCV6ueD8367+EfTfqntzGCaziBh7Tj9CQlpp5GpM+orqAowgyNTTvkTD+thDVC
 MJeIy1gts1PF9NIXk4iaQ/8FNuoTjS88tVMf+8x0i1FMHEaw4eG8O+MOJf7n9OVMYw5aP8
 m9Uhr23k7qHoYav3bkiwoomnV6C+8qE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-bJKXt8mrOwa1rvHqrVzlDw-1; Mon, 20 Jan 2025 15:19:22 -0500
X-MC-Unique: bJKXt8mrOwa1rvHqrVzlDw-1
X-Mimecast-MFC-AGG-ID: bJKXt8mrOwa1rvHqrVzlDw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6dcd1e4a051so91503716d6.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737404362; x=1738009162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUWDGIwO1FbEQxMvPfuVA74bL427fymFcpQS1Zu4RrY=;
 b=dUhwZFfL8E0FULaOyenGmiWPVBGkup5EZ8eB7zswCtivpxHI1zhr5UXqppgTVVag9o
 ebWsFyK0xJiaQo3ZNsX8gQmq1pFXOH2md1JoCMc83/dgNWaL0tPr9UwgdbQCMY0yfQgD
 Bp7Z5uGVX1Tsb9cFpA9+NadlxQUxlohesQHGs8yKBYGMFHmF7GbqIPRRkFvQBLqfhWp4
 91R25VUZlUcKoQrHPTS35aT36KV06s8cpnci7PDvPq540sC2ft4qL7hPrYwapBxUp+in
 eJX+SWdB6HTAshshbpk7mDjX2RIyIiHwAKwGIBIebaG8yfohRi5flJNCsKvZPpUzA0oa
 IcVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW85M1mFScCoNsL5NvBxuTFywj5MaDmLCmsQEA5gu/BnS7IvmCNJZApb5XNJhdl6kw5oYPJjejdKiYP@nongnu.org
X-Gm-Message-State: AOJu0YxG+ioRvgbLoG0PRfQYVAUAH+SleCY7kj9RJuXP3Y7aMKnyUm1l
 g9vHyB5OqtJOUQIE2I8ZXZ++BNqDmPXVH8GwtGtlm8xtUL0/+zWKtp+Mh1HKlXNhLJSykyl+Q7Y
 DvEGLUyPKam5dEnMaa59mo595zhxnoKtEN8n2yrJxEdlkFdCkyc8k
X-Gm-Gg: ASbGncuM2sfac27yQQRLxl3ofbLYgRIm4Yg9khSFKtCrEkOW3HEpPEI5LV5xBSCiU7t
 rIWidsmoWSZ5wd5Ab780pmBIs/QrYnBCltU8xcfZwL4/+2agKmr537AbRnSgJk/ZT0DZqNf94UN
 Lv//WssqGReNkcFoA8x04Kqf2eVrQAYQgXvGfOtarhoqiwVQ0tNW2hhIPQPxIPAtZY1sjnwotQa
 WMrz96FWnO0wh9pkZHp2dhbK7UGL7iO5p0mX1jhgqrSFrJXtcD0xREMH41wHRiHgwB3O2njl2Er
 65qAY9c+y1ixAwAL5VpleruUhoHBFQk=
X-Received: by 2002:a05:6214:570b:b0:6d4:25c4:e772 with SMTP id
 6a1803df08f44-6e1b2251083mr288914456d6.36.1737404361973; 
 Mon, 20 Jan 2025 12:19:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdseRQA0lTqL+ahCpBlb/Tkp1YOBsMwNUZ0Zhdb+QMVK55z+vsjtUKotEmMM7kRLN7wC+2zA==
X-Received: by 2002:a05:6214:570b:b0:6d4:25c4:e772 with SMTP id
 6a1803df08f44-6e1b2251083mr288914096d6.36.1737404361716; 
 Mon, 20 Jan 2025 12:19:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd5a2dsm44510926d6.72.2025.01.20.12.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:19:21 -0800 (PST)
Date: Mon, 20 Jan 2025 15:19:18 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z46vxmZF_aGyjkgp@x1n>
References: <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com>
 <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com>
 <Z46W7Ltk-CWjmCEj@x1n>
 <ba6ea305-fd04-4e88-8bdc-1d6c5dee95f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba6ea305-fd04-4e88-8bdc-1d6c5dee95f8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On Mon, Jan 20, 2025 at 07:47:18PM +0100, David Hildenbrand wrote:
> "memory_attribute_manager" is weird if it is not memory, but memory-mapped
> I/O ... :)

What you said sounds like a better name already than GuestMemfdManager in
this patch.. :) To me it's ok to call MMIO as part of "memory" too, and
"attribute" can describe the shareable / private (as an attribute).  I'm
guessing Yilun and Chenyi will figure that out..

-- 
Peter Xu


