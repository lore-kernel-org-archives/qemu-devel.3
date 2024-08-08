Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDB4C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2WI-0000Kb-FR; Thu, 08 Aug 2024 08:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sc2WC-0000Gy-Ny
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sc2WA-00088s-Li
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723121121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptKDxgrGdse9UED2SWQeru7lsVTSreNqiYvZX807YgA=;
 b=WymqIFU5QWjk+D4I69EQmNOs4puqK6jlOFEMNilFsXXBffGC0aTTA6k7VefqxHHnKvLKmL
 MJm86oy5t+eqyrJbdI7IFoTCUFbZfcv8JpWYs2mEam9s725pOz7gu6YM3Sa+MTRHgf3SKa
 U8G2Hljn4wJbUdqSm/uupThX2sQl0Ag=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-ywGc0MKNNteD5lzTC9gEQw-1; Thu, 08 Aug 2024 08:45:20 -0400
X-MC-Unique: ywGc0MKNNteD5lzTC9gEQw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f01b9ae749so9064171fa.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723121119; x=1723725919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptKDxgrGdse9UED2SWQeru7lsVTSreNqiYvZX807YgA=;
 b=EXJXnepYt9N7y36rFGi2mmjeSDXXiYICNldH7KWxtmKU/AFTv6hzkLCQw6QKTVSjfu
 mtvQr2qCEgaPxLJUtWA33yMkfzf48kLB7/TcLGDtriXAHEe93IlfYhTJEsNChS1xi2DP
 +Ockns0JFIKH5RT6Aez08Ze5NWKOSqvGM1B22E5nH2ccyjlBymDzH9PHTlZ1c+CX1MVa
 wOxccqBvF/jaS4lj3wFNVNDEtU8sUVORpdhxSFXtf94i9Ms5EChySDvnEYhssftK2FXj
 5BOFBotY2MG57t0CjSo4Z100UO/dui2tbSWf647DnMrhuD442ZEBrb4IyA9b6U2lrAFB
 IzQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVWbz20j21Mn6xgG12PXxJbL4+b+ReWABscgWR0qpXYqcrGxgbkEZb/GU9JN7GY4wE5WQdAnwN9AimeSmZ6eEbg6GXM78=
X-Gm-Message-State: AOJu0YzYAuacrlYFIebd2F6f5fCrPlusMcC1gvdag60DjCtMKHY8LkSy
 I6kvSXf1SbSrvVGQHqRLAf3fPqcj1z6AF7tUI6ZYODXGo3uZvaL3OFbZq2xN4vzaY53G6IgQsXA
 U+xSLOoFSEHme1UwBIsquFjZemwaz5+Sn8BQZFha7sBZKc4X/i4ei
X-Received: by 2002:a05:651c:204:b0:2ef:22ed:3818 with SMTP id
 38308e7fff4ca-2f19de759f9mr11082451fa.32.1723121118797; 
 Thu, 08 Aug 2024 05:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvp8ayaTFQjj9t66k/5w3gC1rs6hkHc9HoxalxOhOyJ/hFVqfNEib82fRz9Ou0AziP0J7oNQ==
X-Received: by 2002:a05:651c:204:b0:2ef:22ed:3818 with SMTP id
 38308e7fff4ca-2f19de759f9mr11082211fa.32.1723121118172; 
 Thu, 08 Aug 2024 05:45:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059cf83dsm71238425e9.47.2024.08.08.05.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 05:45:17 -0700 (PDT)
Date: Thu, 8 Aug 2024 14:45:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808144514.399e9e4b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240808141114.3b021f80@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
 <20240808141114.3b021f80@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, 8 Aug 2024 14:11:14 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 6 Aug 2024 16:31:13 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > +    /* Could also be read back from the error_block_address register */
> > > +    *error_block_addr = base +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > > +
> > > +    return true;
> > > +}    
> > 
> > I don't like all this pointer math, which is basically a reverse engineered
> > QEMU actions on startup + guest provided etc/hardware_errors address.
> > 
> > For once, it assumes error_source_to_index[] matches order in which HEST
> > error sources were described, which is fragile.
> > 
> > 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> > in RAM migrated from older version might not match above assumptions
> > of target QEMU. 
> > 
> > I see 2 ways to rectify it:
> >   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
> >        in guest RAM, like we do with etc/hardware_errors, see
> >             build_ghes_error_table()
> >                ...
> >                tell firmware to write hardware_errors GPA into
> >        and then fetch from HEST table in RAM, the guest patched error/ack addresses
> >        for given source_id
> > 
> >        code-wise: relatively simple once one wraps their own head over
> >                  how this whole APEI thing works in QEMU
> >                  workflow  is described in docs/specs/acpi_hest_ghes.rst
> >                  look to me as sufficient to grasp it.
> >                  (but my view is very biased given my prior knowledge,
> >                   aka: docs/comments/examples wrt acpi patching are good enough)
> >                  (if it's not clear how to do it, ask me for pointers)  
> 
> That sounds a better approach, however...
> 
> >   2nd:  sort of hack based on build_ghes_v2() Error Status Address/Read Ack Register
> >         patching instructions
> >                bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,                
> >                    address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),                      
> >                    ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
> >                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
> >         during build_ghes_v2() also store on a side mapping
> >              source_id -> error address offset : read ack address
> > 
> >         so when you are injecting error, you'd at least use offsets
> >         used at start time, to get rid of risk where injection code
> >         diverge from HEST:etc/hardware_errors layout at start time.
> > 
> >         However to make migration safe, one would need to add a fat
> >         comment not to change order ghest error sources in HEST _and_
> >         a dedicated unit test to make sure we catch it when that happens.
> >         bios_tables_test should be able to catch the change, but it won't
> >         say what's wrong, hence a test case that explicitly checks order
> >         and loudly & clear complains when we will break order assumptions.
> > 
> >         downside:
> >            * we are are limiting ways HEST could be composed/reshuffled in future
> >            * consumption of extra CI resources
> >            * and well, it relies on above duct tape holding all pieces together  
> 
> I ended opting to do approach (2) on this changeset, as the current code
> is already using bios_linker_loader_add_pointer() for ghes, being deeply 
> relying on the block address/ack and cper calculus.

I consider (2) as a fallback in case (1) can't be done with reasonable effort.
At this point, (1) looks doable and I'm not convinced that duct tape
is necessary and that we badly need to rush in this series.
Hence I'd strongly prefer (1).

See my other reply to Jonathan, setting write pointer is not hard.
Parsing HEST doesn't have to be a full tables parser as long as
it respects table types/length/revision then we can cheat by using 
documented offsets from ACPI spec as is, for fields we
need to access.


> To avoid troubles on this duct tape, I opted to move all offset math
> to a single function at ghes.c:
> 
> 	/*
> 	 * ID numbers used to fill HEST source ID field
> 	 */
> 	enum AcpiHestSourceId {
> 	    ACPI_HEST_SRC_ID_SEA,
> 	    ACPI_HEST_SRC_ID_GED,
> 	
> 	    /* Shall be the last one */
> 	    ACPI_HEST_SRC_ID_COUNT
> 	} AcpiHestSourceId;
> 
> 	...
> 
> 	static bool acpi_hest_address_offset(enum AcpiGhesNotifyType notify,
>         	                             uint64_t *error_block_offset,
>                 	                     uint64_t *ack_offset,
>                         	             uint64_t *cper_offset,
>                                 	     enum AcpiHestSourceId *source_id)
> 	{
> 	    enum AcpiHestSourceId source;
> 	    uint64_t offset;
> 
> 	    switch (notify) {
> 	    case ACPI_GHES_NOTIFY_SEA:      /* Only on ARMv8 */
> 	        source = ACPI_HEST_SRC_ID_SEA;
> 	        break;
> 	    case ACPI_GHES_NOTIFY_GPIO:
> 	        source = ACPI_HEST_SRC_ID_GED;
> 	        break;
> 	    default:
> 	        return true;
> 	    }
> 
> 	    if (source_id) {
> 	        *source_id = source;
> 	    }
> 
> 	    /*
> 	     * Please see docs/specs/acpi_hest_ghes.rst for the memory layout.
> 	     * In summary, memory starts with error addresses, then acks and
> 	     * finally CPER blocks.
> 	     */
> 
> 	    offset = source * sizeof(uint64_t);
> 
> 	    if (error_block_offset) {
> 	        *error_block_offset = offset;
> 	    }
> 	    if (ack_offset) {
> 	        *ack_offset = offset + ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
> 	    }
> 	    if (cper_offset) {
> 	        *cper_offset = 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t) +
> 	                       source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> 	    }
> 
> 	    return false;
> 	}
> 
> I also removed the anonymous enum with SEA/GPIO source IDs, using
> only the ACPI notify type as arguments at the function calls.
> 
> As there's now a single point where the offsets from
> docs/specs/acpi_hest_ghes.rst are enforced, this should be error
> prone.
> 
> The code could later be changed to use approach (2), on a separate
> cleanup.
> 
> Thanks,
> Mauro
> 


