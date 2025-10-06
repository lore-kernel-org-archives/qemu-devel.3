Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9078ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 12:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5kHZ-0005KT-Ag; Mon, 06 Oct 2025 08:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v5kHY-0005K6-2h
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 08:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v5kHQ-0006St-16
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 08:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759753518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtIOB2ORHnv00wGpv1SPGdg2Vc7LBEp/d+Bu9thVGc0=;
 b=HIxYEY2gi6n8yCDJWQBicDYCvT2s16xA7SZViOCAOutSlH6thSJe01GIiIJLYhQITjPHGk
 TJfQ9Zwcxq+4535Dmru+mmgBZwkLHYdjRW1WRrNv6p325c2Pq9i+ohKiTtjIIlk0oa+8XG
 DH20TV0GJBnxFvEA2lIsCNgY7FWieGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-VNluvHvGPdqrBnjmyqUqHQ-1; Mon, 06 Oct 2025 08:25:17 -0400
X-MC-Unique: VNluvHvGPdqrBnjmyqUqHQ-1
X-Mimecast-MFC-AGG-ID: VNluvHvGPdqrBnjmyqUqHQ_1759753516
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso25850325e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 05:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759753516; x=1760358316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtIOB2ORHnv00wGpv1SPGdg2Vc7LBEp/d+Bu9thVGc0=;
 b=HdI9lC1meJLIDGzEQ1iv2cdaa0NAg7ejFOkkKsNWYWIRLp3w2xpTNt55PiPUDNwYS0
 C8g/RV/+MrYNNgFaMVYW+GJr+aPu+usjpkVyrcbQ+wgTXDqyYFFLvp14Z1T42zrKW4Gq
 VpUIq146m3zSFqZvUhPOesT/k07LKBzNiiGnMFSPO781qfdOWZbit9QjcQ5LSaT+LiCw
 plkETJBXTEZdhHHsqQe1SKU5groX+7UFlsHfBebI6IvQq6xTrhLmOieseZ+oaa5W8Zs9
 QM9aR9fV34QyGaLMkkJKXZivP5B2AYXl3bypuHcSqhyTpd8J4io0bhbe7YKJCvWvnvTs
 bRbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQrR6EvaMS2FiE/QN9AlZoozoPSgLhh2Cb5pc2e4B8VLct64tQ79cbwcOB+gz7rK3PEREsNNNfjzIV@nongnu.org
X-Gm-Message-State: AOJu0Yz3ypRpRc6YRMmkYelFhHEj7ZWulV0BKNO3k5sP0VZ1D1Mgri3W
 MQh5RdLw/2QZsDx3Puk32Q8kRGQj7AAvFb3pwYPdfzBuLHwnhg9bc9E6U+E26P8KoWcoHhl+mgD
 XnCBlFmP9bqaQdsgWnaLzNB/E/4ij+2yBh5YbaH2JPA8Ia8+NND9PWfJN
X-Gm-Gg: ASbGncuvLcrY/W3f1/A0srEqgsYgG03dH2DA2lwdjeOf8OrwEY9vgCpHv5Fqo7e26SL
 HYe3Hx2x8AdJGNV5X0IWsawC02hrZso1IOcfwgoMZqK/BsmxnIYwR9Se5UP8+HuLvDvVsQJ9AXJ
 Sdwp2/05BMubfCKRpCsO89z0R8oEP+j7RdEHEDwW9VvWrZEpsv5/VU9rwTVnMcCErHtV1d8KeXS
 zdhkFOCKjxXEHQx3VJSzr0rKn49YTneN50m+oI1IYojKe1+QWLba6wEPilYgz70jxi56H+7qBFO
 rgCnliqWw9r4HG3qW8f5ELjWMyq+BaXh6g1o
X-Received: by 2002:a05:600c:354a:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46e7114e5aamr78375905e9.29.1759753516275; 
 Mon, 06 Oct 2025 05:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu94jRm70DWB9vR4OvGkToEpJq2UIYkmERrt5E2M+jW6j6Oz9rwsdNaQAzo04SYziwYEP3gg==
X-Received: by 2002:a05:600c:354a:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46e7114e5aamr78375725e9.29.1759753515822; 
 Mon, 06 Oct 2025 05:25:15 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8343sm257336975e9.2.2025.10.06.05.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 05:25:15 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:25:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: philmd@linaro.org, berrange@redhat.com, jdenemar@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] isapc: remove support for -cpu host and -cpu max
Message-ID: <20251006142512.2698fc71@fedora>
In-Reply-To: <8f358e5b-2a31-4ad8-8861-3f762d2b42e5@nutanix.com>
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20251002151316.0a546cd2@fedora>
 <8f358e5b-2a31-4ad8-8861-3f762d2b42e5@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 3 Oct 2025 12:46:12 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> On 02/10/2025 14:13, Igor Mammedov wrote:
> 
> > On Thu, 25 Sep 2025 17:03:18 +0100
> > Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> >   
> >> This series removes support for -cpu host and -cpu max from the isapc
> >> machine as suggested by Igor, and then updates the "Backwards compatibility"
> >> section of the documentation to reflect both this and the recently
> >> introduced 32-bit x86 CPU restriction.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>  
> > 
> > so, taking in account discussion in this thread.
> > 
> > I'd 1st post only deprecation, and once it is run out
> > this patch.  
> 
> Regarding deprecation, do I understand correctly that you are happy with 
> the current restriction to 32-bit x86 CPUs added for 10.2, and it's just 
> the -cpu host/-cpu max you want to go through the deprecation process?

given we haven't released any restrictions yet and it was possible to start
VM with any of cpu model. We should just revert 
   e1e2909f8e74 hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
for now and add deprecation message for 10.2

and then apply reduced (on max/host) variant in 2 releases.


> > With that:
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Thanks!
> 
> 
> ATB,
> 
> Mark.
> 


