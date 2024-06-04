Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A76C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEWYZ-0005hf-61; Tue, 04 Jun 2024 11:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEWYX-0005h6-GR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEWYV-0001ns-2d
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717516713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTCKnPUKCGBaSO1uqzIfox+QHaAFTvacrq22+e3G+8Q=;
 b=MP1qmUI+vZXhZva8MqOfOoNunHdTk16GPTeht4W06Sr11k6YIbwueazGdu03fZx3uZqEnm
 yg66bmLPzINafUNuHrdNYWZi7xg6RDpTIxTO17TzUWdfMYDxlK3T6KYqALxBnzD2Mcx4sK
 2JqhEHAg495pDbHdtB8wisyBeb6ez0g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-h6Ee-EzJNYO49fCc0Rk_Vg-1; Tue, 04 Jun 2024 11:58:32 -0400
X-MC-Unique: h6Ee-EzJNYO49fCc0Rk_Vg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6afff9d990dso1807526d6.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717516711; x=1718121511;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTCKnPUKCGBaSO1uqzIfox+QHaAFTvacrq22+e3G+8Q=;
 b=E+ILz1rOHdzJ2Tzl0jnDLjfKHPup/gWZsaKl51VuxglPg5kS7dXKz6ks1GCBvia/4q
 NRK0XemZfNKDMcHqPFaP5BrvOBtprN8SCpnmaLoMHsvwCSrYgmursqRJyZOc+wYPYXsX
 AoEVy+ZuRBLeslwvxgbD1t44SLhBuA6PcFOkAm6/n/Ki6pRfRwcHMw7voD83pUznwWcx
 1/ZgP7BSBXndolCKp40ucljMqvcdtVK01lBqiUzBAnE7nAPAPyuME+Br7q4UP4iHnV69
 SoJS+usNVNJtDDn5HiieYJwJSWj9XpNdbDF3ii8DiuZYVZUvOYGy7RG9g0duYz2tvu2o
 UrBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCJ5lteT3nWiqbs+bIwO9WpQIhABXD0nWGPMmFXTibZlFXlGQb1YiKQx1HeUpjOb70lD/pCPpK5Gx0PZkC77XvlVnvWXA=
X-Gm-Message-State: AOJu0YwFUrLLBZt6DbAP7i3/jU8F9GmqfiTjsZl6bgoXkGyoWGmBeVZd
 6SJX4rJzfU6CMzATWSJfD/hZX4Sx5E+WE6CR5LiN9Wt501zRSgAd7H6rPyjJJBbZHIDXKu1Pi0P
 99epcjusyQ20HH2/ekh+RgiK8XkzXm1+F3XJXoSayFwSEL38setvw
X-Received: by 2002:a05:6214:f6e:b0:6ad:8c3b:6aed with SMTP id
 6a1803df08f44-6aecd599f82mr136237386d6.2.1717516711191; 
 Tue, 04 Jun 2024 08:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRe3qe9Z87nVk9dL9TGxZ2285lE+XtCU8eXgAgUMq3Y1GvLwcdoonOsP6ESMN5FuSJaAofQA==
X-Received: by 2002:a05:6214:f6e:b0:6ad:8c3b:6aed with SMTP id
 6a1803df08f44-6aecd599f82mr136237026d6.2.1717516710401; 
 Tue, 04 Jun 2024 08:58:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4402177fd6asm6457641cf.66.2024.06.04.08.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 08:58:29 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:58:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
Message-ID: <Zl85o3w6ncv63zG5@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n>
 <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n>
 <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
 <ZljCHgwJhGcFiP1J@x1n>
 <e6d5f123-37ad-4d77-8536-f7f85213073d@oracle.com>
 <Zl46MIO30mGrtsQk@x1n> <Zl6-f245q-M7A62J@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl6-f245q-M7A62J@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 04, 2024 at 08:13:26AM +0100, Daniel P. Berrangé wrote:
> On Mon, Jun 03, 2024 at 05:48:32PM -0400, Peter Xu wrote:
> > That property, irrelevant of what it is called (and I doubt whether Dan's
> > suggestion on "shared-ram" is good, e.g. mmap(MAP_SHARED) doesn't have user
> > visible fd but it's shared-ram for sure..), is yet another way to specify
> > guest mem types.
> > 
> > What if the user specified this property but specified something else in
> > the -object parameters?  E.g. -machine share-ram=on -object
> > memory-backend-ram,share=off.  What should we do?
> 
> The machine property would only apply to memory regions that are
> *NOT* being created via -object. The memory-backend objects would
> always honour their own share settnig.

In that case we may want to rename that to share-ram-by-default=on.
Otherwise it's not clear which one would take effect from an user POV, even
if we can define it like that in the code.

Even with share-ram-by-default=on, it can be still confusing in some form
or another. Consider this cmdline:

  -machine q35,share-ram-by-default=on -object memory-backend-ram,id=mem1

Then is mem1 shared or not?  From reading the cmdline, if share ram by
default it should be ON if we don't specify it, but it's actually off?
It's because -object has its own default values.

IMHO fundamentally it's just controversial to have two ways to configure
guest memory.  If '-object' is the preferred and complete way to configure
it, I prefer sticking with it if possible and see what is missing.

I think I raised that as the other major reason too, that I think it's so
far only about the vram that is out of the picture here.  We don't and
shouldn't have complicated RW RAMs floating around that we want this
property to cover.  We should make sure we introduce this property with
some good reason, rather than "ok we don't know what happened, we don't
know what will leverage this, but maybe there is some floating RAMs..".
Right after we introduce this property we need to carry it forever, and
prepared people start to use it with/without cpr, and that's some
maintenance cost that I want to see whether we can avoid.

Thanks,

-- 
Peter Xu


