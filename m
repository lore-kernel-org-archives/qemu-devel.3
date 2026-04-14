Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB0DF9D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmKz-00025G-Rd; Tue, 14 Apr 2026 18:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCmKy-00024e-TC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCmKv-0007S8-1D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776206063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NjEL5s6syEAzbqovTTDxGPrHujVvSu2wfeNkkEez/c=;
 b=B1yFxKr6TKzm/ImNSa0H65cGyoSvyxfrZwL8WsKoRnBf8q73fa3gK7hYcHN545NEFoNMr5
 DLhc+cWyrrNnvJQf1Ix0Pw8fk9mQ+pYS8Nd36UDf/c2WyXmEYYfC2OaUUkg4U/wcKJdydy
 VbRQN+dc4VWiOG0pnan1MK8vpYSTPSk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-26lG5qE7PzmZBzDCuBwM4w-1; Tue, 14 Apr 2026 18:34:21 -0400
X-MC-Unique: 26lG5qE7PzmZBzDCuBwM4w-1
X-Mimecast-MFC-AGG-ID: 26lG5qE7PzmZBzDCuBwM4w_1776206061
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ae6aa148a7so2068306d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776206061; x=1776810861; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0NjEL5s6syEAzbqovTTDxGPrHujVvSu2wfeNkkEez/c=;
 b=S5CCXkeqiqcSHJAXzBiQxu69Qc5D+Jqu3fZTrx6NL5XEuv220jlnJ3Qw+AMeMoNLUx
 RuUbfkqdoxgNNQi8xdnlj9hVz3w4bnKLVjvsPyDlKUoGnLhYpLk2nSAYo8e1IwWB+zQJ
 fQaCDU1uOPhtyfP5vDoFHcvDWPzLl4bBlSjC3LVNBsGlzHT5ftDaJuUOMN9R9LIeIhFo
 A8WtYCgD04ZjfP6tC04+Q22r3cxy7ljuSt6RLlVS7wUL83oeNTlbsOx8nGVfdhBouJH6
 tPz/2vsUG7DhkdjGMvx9NB4rvRJev9WqhIyUn6THIQNs6vnwESt+KOevqtjs3ia8hE+h
 UnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776206061; x=1776810861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NjEL5s6syEAzbqovTTDxGPrHujVvSu2wfeNkkEez/c=;
 b=Bz94ak2yyk1FHr9TkE+DG4hxl8pXRVkID6ea1K3TCK6eVl6Jc0q7D1ViDhYqBXoNN9
 Re+QoWLVF0SbHqewLcGuWm1CWpHCG2HQs/xv9kEcBF7i29Jum3/TSNs5tNP2f0QkB0T9
 wwksQpsGulg/n8twlC/6zwfumezrEWi/JDy/Bx1rVQuT9d2Sh2jtD3/8IXV2thz0HB3D
 BowXbZGV9G427D9NALYQPWO+9s3YByRMSzt0ch39Sk5tppCZCEJzKC7L9wBzJsKtkX0N
 T78OKA9UDhm7kWTjpXMkrHN0TNOa363vjWsWYuQgco6RKfWkB1MAd0nrxrmiPTynAU/6
 Idlg==
X-Gm-Message-State: AOJu0Yw/YxAGUMv4v9Z9CRgTDQ28n+bf7XtF86GO11QxKfIfzmjE2dkH
 eZj4D665Cn4TuNYa5KT7riFy1EXzWdJszFJvgX1J8S8AFz+CxhBQmQtyDsloY0P6u0sDmYwelPF
 00tFBmeLtpnXDvsZ/uNTRyEkMXhRMJesEE14df66muyUzq6VatV//0d7i
X-Gm-Gg: AeBDievvB6ZWqlyDf5VXMUCKmIKTKkTG9sNoWw56PJU/fWGAoO1/n5ERVfG//XbQplx
 Ivk03QeHBZa7V9A0wInt/ERgCsim56nqwZVw17cDl7ly6ZzrvyLNb6yrotjU1e6ortnaU4VTP8z
 Lat7LgRrHrRXpmiwAdCpEr+aRW0REMFTHg5zev/DHMWumj9ajY5draWRMGTh9+MHF1WRW0r97fR
 l/jfCedQlR0pj57TrUBs3TI6hqP//UOAuoh8hfUkB5f+3ofMDUr7j/VZFZjP44t3AZRd3pmPSTi
 SaOm5TzxttxstC5Xt7kNCIRyBkMX3Ag4k0dmUw/pXX9fFBsjoYvGseCuG5K1UU3RlgalBXwKVSk
 qj3lIoZCOSqL3pyKXtEPIFggverLp6Ex5e3+ypItzFHPDA5f9OT/22a+CTA==
X-Received: by 2002:a0c:e014:0:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8ac860e5ed8mr258224826d6.3.1776206061067; 
 Tue, 14 Apr 2026 15:34:21 -0700 (PDT)
X-Received: by 2002:a0c:e014:0:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8ac860e5ed8mr258224416d6.3.1776206060515; 
 Tue, 14 Apr 2026 15:34:20 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8acb508807fsm58307466d6.48.2026.04.14.15.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 15:34:19 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:34:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 eblake@redhat.com, armbru@redhat.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, PengJu.Zhou@amd.com, Qing.Ma@amd.com
Subject: Re: [PATCH v5] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <ad7A6dUi88Lfohqm@x1.local>
References: <20260413035703.2602065-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413035703.2602065-1-guoqing.zhang@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 13, 2026 at 11:57:03AM +0800, Samuel Zhang wrote:
> The default 1MB RDMA chunk size causes slow live migration because
> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
> 
> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> faster migration.
> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
> 
> Performance with RDMA live migration of 8GB RAM VM:
> 
> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> |-----------------------|----------|-------------------|
> | 1M (default)          | 37.915   |  1,007            |
> | 32M                   | 17.880   |  2,260            |
> | 1024M                 |  4.368   | 17,529            |
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Li Zhijian <lizhijian@fujitsu.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


