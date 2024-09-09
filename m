Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C63ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngWI-0004OT-Vh; Mon, 09 Sep 2024 11:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sngWH-0004Nu-7b
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sngWF-0003y2-0D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725896493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INjtO/NFBs49SCboRR+JNXBjH1xGtekL1LMYUJhHFss=;
 b=K735MJk+IHFCM4ZTmTipM4xRjSmBOh5KxZ6T460eFornu54y4dgPbjGpGB6SI02dPrTeDa
 x5gXS1G7qkh4UfkSyjJVW9OivMv8wfPALF2ftR1mjknxswWkBnlbXswACyZsJX7tvC3C7J
 ibRKuiZLbJgYtEWJwyaP+stfRo1FsrI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-zgi4f5XKNVGI-TgxkDWMbA-1; Mon, 09 Sep 2024 11:41:30 -0400
X-MC-Unique: zgi4f5XKNVGI-TgxkDWMbA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45832b277d9so13042581cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725896490; x=1726501290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INjtO/NFBs49SCboRR+JNXBjH1xGtekL1LMYUJhHFss=;
 b=xBbM2lR5pVU4Fi55OzTODAoCtr4vOrowYal7nA9MoTBgToCWuUfMFll27tAwth87vI
 NPTaPuI9kCKyIy3mcM3Gku6u+OjEUKBx509frpr0ZfLqswRGtX+CAXjgym9vE0sCoFRb
 ki3BEHIIrdalGQIVfoZl3c5Arsc+Due1DyWbyv8jiKlDBPZVqBS2CufPGvNjYO68Iq3f
 JZ3eKXAZdJmcpck61cX90ZqChSlRqD2i6Jl5iar7fPdksEN/QhuZp3IxIKfV0CAuzdxc
 E7eiTQLcbk7kWm0avlxA2lkaY842IURMF4RGVp1qy7RhcWYjT++m7fVH/prEtK0kN4jm
 NJLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMaPd6TvPEcaFrxD0FIYkpAiiJKy4pQrl5gPdDOFRNFv0ux/hLDWxf6pMeb4oEl4fFykoLyvQnq2VM@nongnu.org
X-Gm-Message-State: AOJu0Yxi34Rb4qh6X1qPmMPAYLrl6idIFJ3+NoJge3l2xGufhm661HLO
 XAYzmFGrSnmSV+w0+/4LTO5kQfD70UBb1DqV9YHxUZEXOccdudbE9+hjV/Mphdb+YYnjwRU6r6g
 1AaxwAIeEGZBj0rn8zo862VhLLsGkX4Ljf32r0Rz47A2QldbsLF/K
X-Received: by 2002:a05:6214:8d2:b0:6c5:5080:bbb1 with SMTP id
 6a1803df08f44-6c55080bbeemr16816806d6.13.1725896490222; 
 Mon, 09 Sep 2024 08:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcy3+pE9t9QuI21OL4Kyce7rUA/OIobfBm5gnBIZgRY0iGw5BTnl6lnkJimJpRYfmD8TkaQA==
X-Received: by 2002:a05:6214:8d2:b0:6c5:5080:bbb1 with SMTP id
 6a1803df08f44-6c55080bbeemr16816466d6.13.1725896489772; 
 Mon, 09 Sep 2024 08:41:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53474d793sm21416116d6.101.2024.09.09.08.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 08:41:29 -0700 (PDT)
Date: Mon, 9 Sep 2024 11:41:26 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/17] migration/multifd: Zero p->flags before
 starting filling a packet
Message-ID: <Zt8XJmPT3gHzTcAM@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <6230f70a9d11f5b5efd2811ebdebc722318c6b15.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6230f70a9d11f5b5efd2811ebdebc722318c6b15.1724701542.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 27, 2024 at 07:54:22PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This way there aren't stale flags there.
> 
> p->flags can't contain SYNC to be sent at the next RAM packet since syncs
> are now handled separately in multifd_send_thread.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


