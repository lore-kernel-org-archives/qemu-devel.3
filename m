Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58872C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxsh-00015y-Rz; Sun, 02 Jun 2024 22:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxsc-0000uk-RX
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDtJ3-0003El-Dc
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 18:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717365840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rg/U5bQVZCvitAfOXOtID9rN/KNAL8UobrEOBWlnOIc=;
 b=gsiDP6MmpjwOSqM2tXMIczi1ASsnsMHXMgnkjEKKQ+bDSAyg9Uouertir0au72MZaSuETW
 DeF7fqP4tVJ3orW08Qlr2cL7gsGCwPfDN5HJu6UcJEmCrfvp016PoktOcgOcfXfiV/VElb
 PqZW9JADLwa/Bipd/gdWXkI3Q3ZOdM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6cL8X-7UMVSn-JEBoLnWvQ-1; Sun, 02 Jun 2024 18:03:59 -0400
X-MC-Unique: 6cL8X-7UMVSn-JEBoLnWvQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42135f6012fso8047635e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 15:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717365838; x=1717970638;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rg/U5bQVZCvitAfOXOtID9rN/KNAL8UobrEOBWlnOIc=;
 b=a67UXk19NlnKzrwehLbjwk0QynWoqtrh/JXBpVIaPgPsUz4nWYgr1grS9x7PumGKzY
 +tseDYU2Hsyedqq8lfqYNdOYCrMWkZavW/r677H+iTciC4X5zeBNOiz0vgya3w/pyjja
 1DQRNFwNSddYXNp7MgbG5Nd8STQzN1YB4u68z7zULZRGgV23cGj6GGY//nE5dWWY0pSY
 DIj/QYZl/rUalYLu5c2Y/SZ5xGRIj40qvjMzzpFOcFlFqkpd9zKiyHaAD+41ADg+HGSW
 Px8UumZUYzfDVuadLJU33p4GtXXjKAD0iWsmHt5zqofry+GY0722H8qUCGIhXfPhqafj
 nhYw==
X-Gm-Message-State: AOJu0Yx/gSB4wcdmLXxEStgBBEQxmejjfiZ74mkAjkCo2maRbTIQ1mzs
 qHD3pUrN4KGLVlhj7CNXi5/ESDBYlwjf902QOprSa2TFTIkKcQeRBsM+xdndeFjE5p/xM6qTFNb
 xLbUqv1Dmrh68xTEJSBIJ0JLyUWtOpf4D1s0/3Teeftd9aXMmDydNB0VU3F2Y
X-Received: by 2002:a05:600c:46d4:b0:41f:e56c:ef81 with SMTP id
 5b1f17b1804b1-4212e0448admr58237495e9.1.1717365837725; 
 Sun, 02 Jun 2024 15:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCVatZdqgJCSjoDjAECdvqnYzLD+JpNZ8eE+w4CM4r46MgCuz7VB6WyC6opgFoBhz0TcYhEA==
X-Received: by 2002:a05:600c:46d4:b0:41f:e56c:ef81 with SMTP id
 5b1f17b1804b1-4212e0448admr58237255e9.1.1717365837182; 
 Sun, 02 Jun 2024 15:03:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cad2csm7066202f8f.36.2024.06.02.15.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 15:03:56 -0700 (PDT)
Date: Sun, 2 Jun 2024 18:03:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 0/2] qapi: Remove deprecated events
Message-ID: <20240602180336-mutt-send-email-mst@kernel.org>
References: <20240530071548.20074-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530071548.20074-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 09:15:46AM +0200, Philippe Mathieu-Daudé wrote:
> Remove MEM_UNPLUG_ERROR and 'vcpu' field in TRACE events,
> all deprecated since long enough.
> 
> Philippe Mathieu-Daudé (2):
>   hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR event
>   trace: Remove deprecated 'vcpu' field from QMP trace events

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



>  docs/about/deprecated.rst       | 16 ----------------
>  docs/about/removed-features.rst | 15 +++++++++++++++
>  qapi/machine.json               | 28 ----------------------------
>  qapi/trace.json                 | 27 +++------------------------
>  hw/acpi/memory_hotplug.c        |  8 --------
>  hw/ppc/spapr.c                  | 11 +----------
>  trace/qmp.c                     |  2 --
>  trace/trace-hmp-cmds.c          |  4 ++--
>  8 files changed, 21 insertions(+), 90 deletions(-)
> 
> -- 
> 2.41.0


