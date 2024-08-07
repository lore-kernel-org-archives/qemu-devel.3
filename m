Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E27C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgiR-0005Zr-LY; Wed, 07 Aug 2024 09:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbgiP-0005Pb-0E
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 09:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbgiN-00038F-8l
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 09:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723037309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuOMS6Luo6DRqz2cR8tGU25H7DLY1HtTPW8DCbYrHtY=;
 b=dyUomfSAuwLZs+LYiWryfy4sWaqEqJpcOZxOH4+qCemt1JfEtrpC8R4qas2rp6xLVHYzql
 eOu6OfNYMtwkJdSFSB2we9gqQDD++e7nUP4LM469uaXbrZUvVGS9X3yyg62qlAmL4J1Y6X
 xip1GIyXpvHW0hmSpwEmaTKxTDl+v+8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PcWeJnS_PxKBNnlyGIp37w-1; Wed, 07 Aug 2024 09:28:26 -0400
X-MC-Unique: PcWeJnS_PxKBNnlyGIp37w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42817980766so12548545e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 06:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723037305; x=1723642105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuOMS6Luo6DRqz2cR8tGU25H7DLY1HtTPW8DCbYrHtY=;
 b=VccNvP6cSRu3cZv8KEjBfP0L1kQazTEltQX2fxvBDdK1XiXSXnopSleG6l84R7F5or
 7fkCue6hmaLjW/a0yPR8U3F9cRxN+lUOSdW150iiO0cfIfS6vRTbN0oyvNrbDRocWL2G
 XTz4gUVm4V5d5cA6IBfxOb5Hw8JADqB+jGpNhipip/YorpzMSVNRMyiiiigsicRRNBUx
 t++47OnnNlh/d4McbIu3EdyJ1K/Nb/JhAjW22lzjcFhdiwmBGtQ2xW3fJAOKwVugWmAA
 qbEPE9aiIgFlUDEy2jBoa93e6ceSluUNZDMU03C13F2jKJc2gQYoeM7HzvfJBGhtoJQv
 aszQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSW2q5eXHNYdZ/0Jmmo3kwZ8INkgAO5rg/EEE0ivoGv4EBxqOhNOPMd5HzjzJvu9i1LlEN0n3+CGfjDAb1zcXlMcb8/wg=
X-Gm-Message-State: AOJu0YwDx10gE6++B/l2pX5JgZkF9sZlVwEAm87bIR3IoLvu+8bDa1aY
 ET5Fla4Bv/QwMAg5kGqj/Lhy5YehVIIlOWRMQc4SCDDBTOt3NTbDF+U9kyqNqxXaT+4aHgVI+rl
 8v17f8351Tnonf2LIrv3jeXGceJds9cqHOs0zlS01MCy74NJ5NX4m
X-Received: by 2002:a05:600c:458c:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-428e6b30e41mr133299785e9.20.1723037305387; 
 Wed, 07 Aug 2024 06:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLj+isQ7nmBF9hW30nn+vT8bfESNT5x6lh77Gwp7uo/AL4KwM+k2TyKmw7SZMV+5PNlKfGIg==
X-Received: by 2002:a05:600c:458c:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-428e6b30e41mr133299525e9.20.1723037304859; 
 Wed, 07 Aug 2024 06:28:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42905801c42sm30509085e9.34.2024.08.07.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 06:28:24 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:28:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807152823.0d9117bc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240807103436.000013fc@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
 <20240807094750.6414fb2f@foz.lan>
 <20240807103436.000013fc@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 7 Aug 2024 10:34:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 7 Aug 2024 09:47:50 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 6 Aug 2024 16:31:13 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > PS:
> > > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > > and it is the total size of a error block for a error source.
> > > 
> > > However acpi_hest_ghes.rst (3) says it should be 4K,
> > > am I mistaken?    
> > 
> > Maybe Jonathan knows better, but I guess the 1K was just some
> > arbitrary limit to prevent a too big CPER. The 4K limit described
> > at acpi_hest_ghes.rst could be just some limit to cope with
> > the current bios implementation, but I didn't check myself how
> > this is implemented there. 
> > 
> > I was unable to find any limit at the specs. Yet, if you look at:
> > 
> > https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section  
> 
> I think both limits are just made up.  You can in theory log huge
> error records.  Just not one does.

What I care about is what we actually allocate vs what we promised
in docs. Given that it's harder to change actual size (we would need
a compat handling here not to break old machine types), I  would vote
for syncing docs to match code.

A separate stand-alone patch for fixing it would do,
or it could be a part of series.

Also I'd like another pair of eyes to look at it to confirm actual
size we allocate, in case I'm not seeing it right.

> > The processor Error Information Structure, starting at offset
> > 40, can go up to 255*32, meaning an offset of 8200, which is
> > bigger than 4K.
> > 
> > Going further, processor context can have up to 65535 (spec
> > actually says 65536, but that sounds a typo, as the size is
> > stored on an uint16_t), containing multiple register values
> > there (the spec calls its length as "P").
> > 
> > So, the CPER record could, in theory, have:
> > 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> > 
> > The CPER length is stored in Section Length record, which is
> > uint32_t.
> > 
> > So, I'd say that the GHES record can theoretically be a lot
> > bigger than 4K.	  
> Agreed - but I don't think we care for testing as long as it's
> big enough for plausible records.   Unless you really want
> to fuzz the limits?
> 
> Jonathan
> 
> > 
> > Thanks,
> > Mauro  
> 


