Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31723C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTktU-0003GM-BR; Tue, 16 Jul 2024 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTktQ-0003BY-VI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTktN-0004ih-9J
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721146744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OsY+tcqQ7bq9JNt5VwP+2RyUWBPNbVX3S6HNKWfnuBg=;
 b=F/IfCWCBz/Q0QKZGnhYTp0sv2YbIjH8o1gK7pYwhan6JIjqqhMs/bIhcGZ8mAalRm0Avvi
 agdfin05zWfq0PbgJNrtgX9+Du64B4iEyk+MHIkGq5zRJXJfYH8qpkDlpIKpGt3exT1jDk
 wjSKRu4463brcCG0S4ADkG/xT8Lsuz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Zxwk-Fo8OXCKxF4ZuuAjuw-1; Tue, 16 Jul 2024 12:19:02 -0400
X-MC-Unique: Zxwk-Fo8OXCKxF4ZuuAjuw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3679ab94cdbso3590948f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146741; x=1721751541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsY+tcqQ7bq9JNt5VwP+2RyUWBPNbVX3S6HNKWfnuBg=;
 b=eRWDHHsoHrJPd3FtBkYhy6OUaIZCi3wTKMlrinhhX5l38gH7w0sp7mlF7RJ71oiiJE
 7Jx6t4YLTdbr5ZL1ajBrDWEnG4m1fVpI+0j07lfE8HCPvaQ44vLfaPcNDryyBWCfSFMR
 vHA/I6KvMhR6UuDFFPDpGaSV5wpKmc50PW3LP80yu9ivI68W6DaJDGOMMjQFjbcYqsBA
 cgxhfLclivD6IJLr6/JgP04+7R0150tUTa5YpFmtorglzIRYR7ktz2gOQmmOm/PDvtOU
 xJHDv4N4j/la0hFx1iKCYbLlD51HQdxLqehUHzA0KAf4AFjzvUqAtIfpbtWK2EIKZ2W6
 6bYQ==
X-Gm-Message-State: AOJu0Yz2a3zchsfJMoEx84HnEM7cNNwOPYUsdoZdCLCUWLj7P64GLkKl
 Jj2TN21jcgdmfiClPdxXt29kJXQyOm+8AYcKkKrM8g/EjZrU3kYBCu5r6zi/96+pR4KS0QG7J9C
 POtpOWi89bQacn1brzH76YPFjFO08923vnO1OS7u6Isqv4IoAOtzh
X-Received: by 2002:adf:ed0e:0:b0:368:5e8:2c8e with SMTP id
 ffacd0b85a97d-3682635cbecmr1901570f8f.58.1721146741237; 
 Tue, 16 Jul 2024 09:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM5F93G7hQ/7AA4dAGx5Zn8uIQUFIej5SKfCKuLVStjB87XT71l5hN/Ds7FGU4tQ7Iccifkw==
X-Received: by 2002:adf:ed0e:0:b0:368:5e8:2c8e with SMTP id
 ffacd0b85a97d-3682635cbecmr1901543f8f.58.1721146740610; 
 Tue, 16 Jul 2024 09:19:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:360d:da73:bbf7:ba86:37fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0ee46sm9423397f8f.114.2024.07.16.09.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:19:00 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:18:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, eblake@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com, jsnow@redhat.com,
 imammedo@redhat.com
Subject: Re: [PATCH 0/5] qapi: Doc comment cleanups
Message-ID: <20240716121845-mutt-send-email-mst@kernel.org>
References: <20240711112228.2140606-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711112228.2140606-1-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 11, 2024 at 01:22:23PM +0200, Markus Armbruster wrote:
> Markus Armbruster (5):
>   qapi/pci: Clean up documentation around PciDeviceClass
>   qapi/machine: Clean up documentation around CpuInstanceProperties
>   qapi/machine: Clarify query-uuid value when none has been specified
>   qapi/sockets: Move deprecation note out of SocketAddress doc comment
>   qapi/ui: Drop note on naming of SpiceQueryMouseMode

pci/machine bits:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

>  qapi/machine.json | 18 ++++++++----------
>  qapi/pci.json     |  6 ++----
>  qapi/sockets.json |  7 +++----
>  qapi/ui.json      |  2 --
>  4 files changed, 13 insertions(+), 20 deletions(-)
> 
> -- 
> 2.45.0


