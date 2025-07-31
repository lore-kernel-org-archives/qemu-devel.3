Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A7EC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOSR-0002vj-IH; Thu, 31 Jul 2025 04:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhOSD-0002oK-Tu
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhOSB-0004iU-AC
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753949752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx7B1p3Aou5VOYXUQHBOLvehoQePrRkboYdN16EZLOs=;
 b=giaaL8FRNsZCJ/AYxmL6Mf2ssAaHxthQRl7LnOsPyT28T5OGUTHAB2NudqFSB9DXz+8t0x
 IOuVMZ29vTyhiVggKcUVs1o0nadQ2bdau5Yy6qgQbPC1XadfTe7QVhwH+6HB4+Wv2e5llJ
 Z0o0YDxWygV2wVYMY+SuDjKr2tRi1go=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-MiqGL2P_NISvcVov5GYigA-1; Thu, 31 Jul 2025 04:15:49 -0400
X-MC-Unique: MiqGL2P_NISvcVov5GYigA-1
X-Mimecast-MFC-AGG-ID: MiqGL2P_NISvcVov5GYigA_1753949749
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7931d3d76so478583f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753949748; x=1754554548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx7B1p3Aou5VOYXUQHBOLvehoQePrRkboYdN16EZLOs=;
 b=R9fxStLJBxll/WUMm/Nz32ltra99xbRg55ooAEbUSkBM63fxLeSNOVF15UCtLTRMFJ
 3404TwAv8xhSZyOUY5EaBMBmjsIAvBR4NDNvM6QENWlbK9o3a3yaU5UnxdGbbSEWSVyE
 Znk9v7637NVwj9tIoyOedl2n5XmTGo5NehYAeBEiZw3xcFFP9aENSYA+wJfroJQ6Gyjk
 TrC50umO2ceRqodGaSKYu0dGzBrS58Acdbb7GxkbUzMmMJKtmI6Pd2tAlkTLfU7owtgp
 GGn936OXFTKRJEyQDz6SdxhMhR8bWseEk0m9M4ae2o0533qmJ+gbWFlA5hk2bedzcQrf
 e6dg==
X-Gm-Message-State: AOJu0YxNItVjqLKgeerGSJ8prKEqlkyI2Jogwtx/bLO6d5acX0oef3h3
 L6Ylad4bpSqEKOyeb0v7xUKWECQSwBJcEX7rfwhN9cXNCiGuT0t+t4rEltVIiGU+JAPOB6vST39
 EyuYDNp49cnSSg4+H6R6/fh3np0VYCrusTtsjV4mdRKj0C4X/aFJgqRa8
X-Gm-Gg: ASbGnctoSv/sVp4jQpMs5qKnF56OY+oGq2pFCd5SnpjdDQDeAS6UAbkTjyPhqu9aMC2
 HAP66eADoP6eq4ngKs8Gbt4vqtmIrTVxuIXfZESA/vT5TaW39XwqRxND62yptYz4ip+sYqQddWL
 uK3gAH80j7oc5slsmZKVHyxmso9sfIJdyxYICTLIBIfGpz+MsQJEtmpeQmLIk4SdUL02ZgFC43y
 qL/Lz6gBMSQphmfm9CbqsM/BJhzoNy55VDOWFr0ibBduHusQJzoBxDCHLXA7n8xWJX510rGDGOX
 Jb/zhNCjDPAXKQIDYp6VdUUu/kQdpQ==
X-Received: by 2002:a05:6000:4304:b0:3b7:9d87:97ad with SMTP id
 ffacd0b85a97d-3b79d879f3cmr898119f8f.37.1753949748027; 
 Thu, 31 Jul 2025 01:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkn3J078b4bU0DjYqQv33UUlNv/Q4pL9pg7gPcFgCRvVtwTXq3KCjFCNySIBxD/kit0nJp5A==
X-Received: by 2002:a05:6000:4304:b0:3b7:9d87:97ad with SMTP id
 ffacd0b85a97d-3b79d879f3cmr898071f8f.37.1753949747210; 
 Thu, 31 Jul 2025 01:15:47 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eb7acsm53821015e9.28.2025.07.31.01.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 01:15:46 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:15:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/6] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <20250731101545.5b5ff8c2@fedora>
In-Reply-To: <aIqTCITI84BNtWnp@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-2-imammedo@redhat.com>
 <aIqTCITI84BNtWnp@x1.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Jul 2025 17:47:52 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 30, 2025 at 02:39:29PM +0200, Igor Mammedov wrote:
> > diff --git a/system/memory.c b/system/memory.c
> > index 5646547940..9a5a262112 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -2546,6 +2546,12 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
> >      }
> >  }
> >  
> > +void memory_region_enable_lockless_io(MemoryRegion *mr)
> > +{
> > +    mr->lockless_io = true;
> > +    mr->disable_reentrancy_guard = true;  
> 
> IIUC this is needed only because the re-entrancy guard is not
> per-transaction but per-device, am I right?

As far as I understood, it was per memory region (device in this case).
 
> Maybe some comment would be nice here to explain how mmio concurrency could
> affect this.  If my above comment is correct, it could also be a TODO so we
> could re-enable this when it is per-transaction (even though I don't know
> whether it's easy / useful to do..).

I can add a comment on repin.
> 
> Thanks,
> 


