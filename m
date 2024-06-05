Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0234EC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEs6f-0002Gn-CG; Wed, 05 Jun 2024 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEs6d-0002Fa-UP
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEs6a-0008Gk-Hl
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717599551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gn/eBWWIm6t54GG4oYvydhrpfvE4s2/NRLKk6xhbirg=;
 b=MabGFvXYTpfBTQjRu58X4M6sdRibOu52OYcYxCw2vaX4T770zeL9SFbAsI83aQ0ZDpQfcv
 fYbMD7hyVPb9h2+LDIvMosqJZ85imu6J5yYcgeJ6NJwP6Gf2U4YDeIapHtELkza9WFnmYv
 g0KIqSAc4zkis1ou9vvRyGYXfTOrh88=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-KcGjQDJ3P7qrYWEgIb62HQ-1; Wed, 05 Jun 2024 10:59:07 -0400
X-MC-Unique: KcGjQDJ3P7qrYWEgIb62HQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44033f06299so326191cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717599547; x=1718204347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn/eBWWIm6t54GG4oYvydhrpfvE4s2/NRLKk6xhbirg=;
 b=tOczw3jVg4sYtrZri3FdszWX2Sq68+Z1zGJkMjUe09+lk3ofk1u5sJ92aVdZY9hrsU
 bGQQ/drGdNkk0ziQ7jgMFNp6ygxcIH53rS7BJon5Cpk6aw6Y1gRpo5AnEQECHroft6PC
 /qXMtSZaih9p/Rphl9fz8PbFTiSy9yWqXUxCy94/pNBH2eyb9FgQci8CASNa7NpnW60k
 JFZUqWERKHHinY/vnw2k1YRj0FPROg+kBBC+C6L7pYalbMGFC+fUPj9cjuCB2MSQWnzn
 7O19S4XGILLbdNNhqk8bKaAW8a1eK4C3hdgmyKWorHOxWi+HTlmitX+yl+xe4QpkCHLH
 SDIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3jZbrK3EsKAEicw+RunJ3rYJ8e6KmEtvxmZQa496Y7R40vN/Ww0NidbqJV1sIIUt2nhGrurzC3TNbh0VU5fkO29WGzDU=
X-Gm-Message-State: AOJu0Yx4oYpB/BxhfH3rdOGOdlT/lxKDZLOi7XR7L+agZTYLT/Agu0QJ
 KGYkZaUCcyPrHth88PQkFPNP83rLZUHFRfBKtR5QNCZ7++R+StLw4hTCrlT/MRdnF11tdXRQiDF
 0uPd9b36aXf3UuvPBIqbtUtSN3Z25ayDENfiQoIGKWOPnPNWaeIEG
X-Received: by 2002:a05:622a:1391:b0:43a:46e3:f610 with SMTP id
 d75a77b69052e-4402b6a6d58mr28864701cf.3.1717599546720; 
 Wed, 05 Jun 2024 07:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ceVYT+BF9h/DqRhgidTNpPCOvh7M9MpWlND4TdghdEOH1vh3jsqnRTU53oEDZ5bKJKcaJw==
X-Received: by 2002:a05:622a:1391:b0:43a:46e3:f610 with SMTP id
 d75a77b69052e-4402b6a6d58mr28864231cf.3.1717599545899; 
 Wed, 05 Jun 2024 07:59:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23a419asm59711721cf.15.2024.06.05.07.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:59:05 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:59:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Michael Galaxy <mgalaxy@akamai.com>, Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZmB9N4Vr2csBBEnY@x1n>
References: <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
 <Zl-x_Az8i4jOwitt@gallifrey> <ZmBx8UDDmO-C1Oqu@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmBx8UDDmO-C1Oqu@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 05, 2024 at 10:10:57AM -0400, Peter Xu wrote:
> >   e) Someone made a good suggestion (sorry can't remember who) - that the
> >      RDMA migration structure was the wrong way around - it should be the
> >      destination which initiates an RDMA read, rather than the source
> >      doing a write; then things might become a LOT simpler; you just need
> >      to send page ranges to the destination and it can pull it.
> >      That might work nicely for postcopy.
> 
> I'm not sure whether it'll still be a problem if rdma recv side is based on
> zero-copy.  It would be a matter of whether atomicity can be guaranteed so
> that we don't want the guest vcpus to see a partially copied page during
> on-flight DMAs.  UFFDIO_COPY (or friend) is currently the only solution for
> that.

And when thinking about this (of UFFDIO_COPY's nature on not being able to
do zero-copy...), the only way this will be able to do zerocopy is to use
file memories (shmem/hugetlbfs), as page cache can be prepopulated. So that
when we do DMA we pass over the page cache, which can be mapped in another
virtual address besides what the vcpus are using.

Then we can use UFFDIO_CONTINUE (rather than UFFDIO_COPY) to do atomic
updates on the vcpu pgtables, avoiding the copy.  QEMU doesn't have it, but
it looks like there's one more reason we may want to have better use of
shmem.. than anonymous.  And actually when working on 4k faults on 1G
hugetlb I added CONTINUE support.

https://github.com/xzpeter/qemu/tree/doublemap
https://github.com/xzpeter/qemu/commit/b8aff3a9d7654b1cf2c089a06894ff4899740dc5

Maybe it's worthwhile on its own now, because it also means we can use that
in multifd to avoid one extra layer of buffering when supporting
multifd+postcopy (which has the same issue here on directly copying data
into guest pages).  It'll also work with things like rmda I think in
similar ways.  It's just that it'll not work on anonymous.

I definitely hijacked the thread to somewhere too far away.  I'll stop
here..

Thanks,

-- 
Peter Xu


