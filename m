Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDCAD1BDC3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80KF-0004si-QO; Mon, 04 Nov 2024 11:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t80KC-0004sN-PE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t80KA-0004bD-Lo
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730739183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipM4JVJ9oifSIpZP3gXnQfEUK0ioCepNz5WE0pEwp8U=;
 b=GWCuc97NVq/IqG4capu0bVkOUc22BS8GZnuLC/9al0CwjBIk28cI3JDy7c1BMLFRN+Pq9y
 +SpIy9RXuDuUM5+3SdnW7Kc12/INm3EQk0rBHrZgahdWQ1G0rkr3egXAF1NHjqhCAKemeK
 EsyHLE0Acv+lqFdecAK0CGC5M4OmDak=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-NLcJ6RxTN5m28gWiwpygTg-1; Mon, 04 Nov 2024 11:53:02 -0500
X-MC-Unique: NLcJ6RxTN5m28gWiwpygTg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-29090a98e97so4504875fac.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739179; x=1731343979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipM4JVJ9oifSIpZP3gXnQfEUK0ioCepNz5WE0pEwp8U=;
 b=OYQN1d+jKi90018zAVnkJCOMDJo6Gin+2KG1gDI6AEaUvtgSsVyU+EFRQRfhBZdOK4
 6zLXbg1s+2cDBASIzuVgR4dowPFEW17bzs/EqE5ClPb5s6VHYABCoS6NoNwnE6JSPbGE
 xQRWrw8NYn7omVNshXKBUlbM+sT9RPbB6dKy/AGYyv67cljPS8R9HWOPApKJRFC2yGmy
 6J299wlKjlZRezO7wwh2EJf7RBNIdVC/D/UjS37y3XnjF/EdxHjMZ5wv4Pwa2F8SYnUy
 AaEa9z96AYPqKlGLLQqKmj3bN6y8aOYXXrdyjXzWgIzqKTvTE9ZHa7vVJ1vmCU7cb6+W
 ejOA==
X-Gm-Message-State: AOJu0YxrOyD6fRJXNFPHKbGBU3/ospsCxUHrBKrQ3ayiQYEBlZFsrLuF
 EL7G5O6qmBAWbaCNEYtXuFvl7809FxDfkQSSIJqtGhLGmqz3EuBJDEegcIl+XQVKz1sRO2wXVVr
 Pdx4p9WmzII8wvs65dWwMt3bfgiXiVK+B5Y1854IzRDOjLgdEWu/Z
X-Received: by 2002:a05:6870:8294:b0:277:e512:f27a with SMTP id
 586e51a60fabf-2946470d6a1mr17760166fac.16.1730739179201; 
 Mon, 04 Nov 2024 08:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhyDXK1O1o5rNA8T8+JleeHaDnSpxg5MR4LqXWfpuTxJr+KY/fYlwqQ48DeuuWmuigKcIuSg==
X-Received: by 2002:a05:6870:8294:b0:277:e512:f27a with SMTP id
 586e51a60fabf-2946470d6a1mr17760087fac.16.1730739177897; 
 Mon, 04 Nov 2024 08:52:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7189cc7f754sm2078148a34.42.2024.11.04.08.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:52:57 -0800 (PST)
Date: Mon, 4 Nov 2024 11:52:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 3/5] migration: remove multifd check with postcopy
Message-ID: <Zyj76Olcwtfs4ndt@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-4-ppandit@redhat.com>
 <ZyTnWYyHlrJUYQRB@x1n>
 <CAE8KmOzD3L2kO7AucYcyVEbjh-qc5H_1Xc9A2VPxT9mX_8nMGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzD3L2kO7AucYcyVEbjh-qc5H_1Xc9A2VPxT9mX_8nMGg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 05:53:22PM +0530, Prasad Pandit wrote:
> On Fri, 1 Nov 2024 at 20:06, Peter Xu <peterx@redhat.com> wrote:
> > > -    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> > > +    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD]
> > > +            && !migration_in_postcopy();
> > >  }
> >
> > We need to keep this as-is.. I'm afraid.
> > You can always do proper check with multifd & !postcopy in your use cases.
> 
> * Above change simplifies it a lot. Separate checks as
> migrate_multifd() && !migration_in_postcopy() make it more complicated
> to follow, because migrate_multifd() is often combined with other
> checks like migrate_multifd_flush, or migrate_mapped_ram etc. I was
> hoping to avoid adding one more check to those conditionals. Also,
> with the above change we don't have to explicitly check where to add
> !migration_in_postcopy() check.

We definitely need a helper like this to simply detect what the user chose
on the feature.

You can still introduce a new helper, e.g. migrate_multifd_precopy(), if
that simplifies the code.

Thanks,

> 
> * Will try to separate them.
> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


