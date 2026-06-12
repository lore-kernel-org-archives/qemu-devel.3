Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D1CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4IF-000515-Bv; Fri, 12 Jun 2026 11:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4ID-0004ya-9L
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4IB-000334-Hy
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781279973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZBnaTIqCP0dfLgrceR7aG1MN5jEfzgwfRp9h8dkhK8=;
 b=TCRzFxGI2qkhGxTwrDazBvFauDWeQhIvNiB5m3bHar6BEZaXD+hWKz5SYReH6a200x0/SM
 ntZTuKvrKz5J736dore5prMuP2GX8FfvOSkHI2XvqlWb7vrdiMjWxaFp0DDJIiO+jDXXGM
 7S8aJC7yLFFaMRWtInVKjhGddi74LFw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-TaXkdQg5PRS0l98-w-_Geg-1; Fri, 12 Jun 2026 11:59:31 -0400
X-MC-Unique: TaXkdQg5PRS0l98-w-_Geg-1
X-Mimecast-MFC-AGG-ID: TaXkdQg5PRS0l98-w-_Geg_1781279970
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175b7946d5so9100591cf.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781279970; x=1781884770; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IZBnaTIqCP0dfLgrceR7aG1MN5jEfzgwfRp9h8dkhK8=;
 b=pqrVOpkMD8SFTV4yb7NM16T+1+laUkCiJxLnHWQ/v8sUemPFB2JO/IwRQ5Ikrp3Hpv
 CUFvT6gtQPsdxw6y0HFMgf4vqR6MbpmDNARVdbbX8fuLfO9fKuK984/Y0lpruOvGbA4e
 deD9DRj0CMNWFtMb2qMgTT90HGAJQy+YOpskXw6Z5K4jIDgGHNlnVgBmbO2UkL2rdzZQ
 T4M/YdsuINzLEbJDjZtSZAwOvtyW3XYcm50zkTPMxaQ1FjwimMKbxQdheSH95JGpYj2x
 7SyGUeTIa1XgcRe0kYZFhkDhVPkwU+dIrdzC3WI219wWNkHcBqNdaNtOTmSuiIl+gru3
 Xh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781279970; x=1781884770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZBnaTIqCP0dfLgrceR7aG1MN5jEfzgwfRp9h8dkhK8=;
 b=KI4Lm1JLLk15CDEcy30d8ZEg2GRHp+8Q+xUtI88NATp+sfaHxsHusgwbJuRNA+UaH6
 9G6HZ151Brg+kMeT9dj4fN3VAHGijyvwZWDCQ1Fu9EktR6qwCONWIWMY2QMKIfaxpc1s
 c+mCcBs3VrqjBN/U+UDsYVv9C0HzYevyV9dl5X+gjk7p0Ko4ciVu0hP659jZZfzkC9Oy
 SEFehy18KwZ7GnyfdMl5dAQFK94jXAqO1rscayunKD9zyTuHFT3z/Tlt0LigPuMSlPVm
 nGDUeT33brmh3hcbtQMkIkvJzJkckAadEs7XVDu/DyvB0vGApEWfMEdx6RZiqCAbrZ/H
 3Qkg==
X-Gm-Message-State: AOJu0Ywi31JkXKVuEc6CgKIJmYPFjPsFtGFUVCFTSEd1EbudMpzZRgjB
 yMkVqfOEuzhXr6ORkmUgN+xDTAQIuK97NNoxw84pdBFSOl2jIFwoLDROBiGGTPrYyjcCqbr2FD5
 cqGjovgDMEIzPvsKGBeAUNgrTDTBMRg6LV5nFWU3Z9guojGP8Wvpcol3E
X-Gm-Gg: Acq92OFWgzHAJklzxmkPPf3Pu3eWmWsW0ndYoS3NL33x735MxZyvxyeC03sINBZy4Xo
 K2qm9ZuzIpE+QpISP8SnxxfKiKPTARMqlcGaOYQzSVrbWJAjQVRWl9I3mu2KKxH5b3M4J+mqOlT
 sjq62C2lnUUwrQXI+2aECW4lRs8i7yVwwNnC0IpxT0W0P30TtRHN8LjFVNQbocYWKUWP6tFBStj
 +qs+LJ89rE/z4kdpHdYjUypoVGZBGlTIaedt5Xe/J4wu3CwNDbW9xNtZJDT65MmIGY246l7QL7L
 vWAnsq8yj5kViiEbLdvRb6nBefYWsbon97Yk8f1fFJV3Msc2VYG0NUVd1SDzKRnzVi9l9lxAjDo
 vWqC/TQXyDRXi63M=
X-Received: by 2002:a05:622a:834d:b0:517:82a1:351d with SMTP id
 d75a77b69052e-517fe4ffac9mr38074731cf.20.1781279969614; 
 Fri, 12 Jun 2026 08:59:29 -0700 (PDT)
X-Received: by 2002:a05:622a:834d:b0:517:82a1:351d with SMTP id
 d75a77b69052e-517fe4ffac9mr38074011cf.20.1781279969107; 
 Fri, 12 Jun 2026 08:59:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb642541sm24859251cf.10.2026.06.12.08.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 08:59:28 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:59:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, Gavin Shan <gshan@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3 02/14] migration/ram: Use
 migration_bitmap_sync_precopy() for postcopy discard
Message-ID: <aiws3u2yanOQMVtv@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-3-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609075812.32067-3-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 09, 2026 at 10:58:00AM +0300, Avihai Horon wrote:
> ram_postcopy_send_discard_bitmap() performs the final RAM dirty bitmap
> sync at postcopy switchover, before sending discard bitmap to the
> destination. Unlike the precopy switchover path, it currently calls the
> raw migration_bitmap_sync() helper and passes last_stage=false.
> 
> Postcopy switchover is also a stopped-VM final sync point, so use
> migration_bitmap_sync_precopy(true). This keeps RAM final bitmap sync
> handling consistent across precopy and postcopy switchover, including
> the precopy bitmap-sync notifier wrapper. Current notifier users are
> safe in postcopy: virtio-balloon free-page hinting already opts out when
> postcopy-ram is enabled [1].
> 
> This prepares for moving the final sync out of RAM completion/discard
> paths and into migration_switchover_start(), where the migration core
> can run a final save_query_pending pass for all modules uniformly.
> 
> [1] fd51e54fa102 ("virtio-balloon: don't start free page hinting if postcopy is possible")
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


