Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63DFC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 18:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCk7w-0002Jg-R0; Thu, 30 May 2024 14:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCk7v-0002JV-1i
 for qemu-devel@nongnu.org; Thu, 30 May 2024 14:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCk7t-0004hw-5d
 for qemu-devel@nongnu.org; Thu, 30 May 2024 14:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717092224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOB6G8jzViWGQJnznrZEWl0KVoqzNMeuwRHbzOyXwW8=;
 b=PyVJ9AMWr5P8Tc3marPs1YXPgEp6xC3TTwZvNosshkyZV/qGgOz4swHCvTRrtMkKRaM+Rj
 4KfYyyoB3vsnutt1kATlp3+sQ55pPnW3aLsKnxAGCPmEGlmK41nAAaN/Xefiev9cWivtsu
 axPi26sL8m6/mSy4xy8SWKNF+YdfDVE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-1vQYO7MLPTGHowRDkvG83Q-1; Thu, 30 May 2024 14:03:42 -0400
X-MC-Unique: 1vQYO7MLPTGHowRDkvG83Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ad803bc570so3495436d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 11:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717092222; x=1717697022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOB6G8jzViWGQJnznrZEWl0KVoqzNMeuwRHbzOyXwW8=;
 b=TXk6p8NbtnHqlKLWduloyPkjkevzudvjndSksZYhC/HASnQXiSllMqmkIaqP2UUFT4
 HCRK/r3L9AljZoify5XN8BUof0xULS/Cx6pWxxAObj96OBRI5HfL/VbbHqUGTXwJLbWN
 nZ1PwTGAvcIYHFw7zy/vX2YYn6fNIJ+SxB9hii7eNsFmOUbs5Pziq++4z5DqJlK+XRDS
 7G8l4QXvktE3zZsCndVCg2enQKISqyvU//Q4to5Kpci5JryYtOExqee8P28EUkGwXxXP
 fhX/Bv1dDCRaBGw3Tbu6E8Ozf/zNm/bExavg3qVropVghjAvVaM7xW/A8BHbGJGWHhD6
 1wtQ==
X-Gm-Message-State: AOJu0Yw6eIcqKUv+6vlL+6UAs0duqrKQjL6deAOl7C3itUhx+RN+9+eG
 8ZcRcHWCpgE8QmVjcHivhoyCnNzTF5eGQU+2D1C/fvKBPMxCBqjxHFB0tf7Om393EGYxR4BA4IW
 FxggzLtP+6CorFv7jVal2tmkK4rI5H0BMeziXniMV0cQxg8HtniM8
X-Received: by 2002:a05:620a:2681:b0:790:a8bf:e816 with SMTP id
 af79cd13be357-794e9e3a3ccmr309439185a.5.1717092221399; 
 Thu, 30 May 2024 11:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5BR4MBa/yHz8sqt/CG3A5nuPMyXITJi8M/Zh4HxVQ5jmVz6p4Gd2Cf2a136Fui8GXSb9lCA==
X-Received: by 2002:a05:620a:2681:b0:790:a8bf:e816 with SMTP id
 af79cd13be357-794e9e3a3ccmr309432785a.5.1717092220498; 
 Thu, 30 May 2024 11:03:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a7482b3sm573666d6.52.2024.05.30.11.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 11:03:39 -0700 (PDT)
Date: Thu, 30 May 2024 14:03:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 07/26] migration: VMStateId
Message-ID: <Zli_eYlZ_nhhzrmF@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
 <ZlTO9fVYG50r3XL9@x1n>
 <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
 <ZlYX4BWLU19f1vaI@x1n>
 <18f8bba1-b687-43ba-9f2c-4cfafe005ac1@oracle.com>
 <Zld5kdnOB9CqyRYq@x1n>
 <01170fdb-5c1a-4058-8d4b-dae07dbb52b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01170fdb-5c1a-4058-8d4b-dae07dbb52b5@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 30, 2024 at 01:11:26PM -0400, Steven Sistare wrote:
> On 5/29/2024 2:53 PM, Peter Xu wrote:
> > On Wed, May 29, 2024 at 01:30:18PM -0400, Steven Sistare wrote:
> > > How about a more general name for the type:
> > > 
> > > migration/misc.h
> > >      typedef char (MigrationId)[256];
> > 
> > How about qemu/typedefs.h?  Not sure whether it's applicable. Markus (in
> > the loop) may have a better idea.
> > 
> > Meanwhile, s/MigrationID/IDString/?
> 
> typedefs.h has a different purpose; giving short names to types
> defined in internal include files.
> 
> This id is specific to migration, so I still think its name should reflect
> migration and it belongs in some include/migration/*.h file.
> 
> ramblocks and migration are already closely related.  There is nothing wrong
> with including a migration header in ramblock.h so it can use a migration type.
> We already have:
>   include/hw/acpi/ich9_tco.h:#include "migration/vmstate.h"
>   include/hw/display/ramfb.h:#include "migration/vmstate.h"
>   include/hw/input/pl050.h:#include "migration/vmstate.h"
>   include/hw/pci/shpc.h:#include "migration/vmstate.h"
>   include/hw/virtio/virtio.h:#include "migration/vmstate.h"
>   include/hw/hyperv/vmbus.h:#include "migration/vmstate.h"
> 
> The 256 byte magic length already appears in too many places, and my code
> would add more occurrences, so I really think that abstracting this type
> would be cleaner.

I agree having a typedef is nicer, but I don't understand why it must be
migration related.  It can be the type QEMU uses to represent any string
based ID, and that's a generic concept to me.

Migration can have a wrapper to process that type, but then migration will
include the generic header in that case, it feels more natural that way?

-- 
Peter Xu


