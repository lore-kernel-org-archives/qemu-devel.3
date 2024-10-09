Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCA5CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syVx9-000385-SI; Wed, 09 Oct 2024 08:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syVx8-00037x-Fd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syVx6-0004uS-J5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qa7H+1SN9+SmIfSN5871LODTlAtZquZkS0Qc+ee7ync=;
 b=NTNeiXrfWKwADsyIPuHn+hIFEXi2OK4MXSrTchWcevUtHFSR99n+L57uIXEqieU//zy7Xi
 dzkI0CoknFFpL0oLeGXvt0rPejXWKof0x7brCX8BhGi9VV/hFCOToJVz2xic/MgEaMxR6J
 OvxxOQr6Ca7tTt5wjgIbnwGC3bl+chI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-YotczNNfNdiUBI24hPhEsw-1; Wed, 09 Oct 2024 08:38:01 -0400
X-MC-Unique: YotczNNfNdiUBI24hPhEsw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7afc3e607b7so324667585a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477481; x=1729082281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qa7H+1SN9+SmIfSN5871LODTlAtZquZkS0Qc+ee7ync=;
 b=W5h/7Ka05EOkZ4Ei/OxrhakRJPZItobmK89NGonk22rYrzzo3i7hNN6ORrwOLGW9Sv
 RpsAno7JfiXlk2vCLWIQCuni90d4bBH+6Sos2i11QUmSohMs1P3GRv4CSzZMVMfq6TRC
 sDR43Z5m3Sz+vWGHuXdlyC1lh9V2SEJuA5NM1HLIZf/qb4w9onk0LNv72PUqlBCJ458u
 nfWi8tcCliG6MTTB7lcuq6ys/4E6iVgne/CvqPXl+z7reYAtUyGo72swijVmVk1GXIN1
 FoLROfAbaqEurBQrs0rWHDObUG5IkFfBtixNzFo95F/5dyay5ZJhHEECB/++Rnaw9QGV
 mFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbCNxfxOn5K78wDQgVQFE8H4FtrVuUPCFW6nxUZZ95+rd2DrjMNJDfIi9FYhlQlyscnDjXKabeXsvG@nongnu.org
X-Gm-Message-State: AOJu0Yx/h6oYT1ROUcUPDuGJ1zR4onLRya5jPNUVMZP46UxC72Qw6v3q
 uFxvSrtKK1YpPorqme80p9dQVYjfaTTW0LReevDCr7ZhxdhiByn/07Rt6PqBwOrDCLj/C/3fPDP
 F6jAa1NLtluxc5o5kmN1KquFaHnxTGAXuYjriGkhazjunjv1y3ass
X-Received: by 2002:a05:620a:24d:b0:7b1:113f:2e55 with SMTP id
 af79cd13be357-7b1113f2fefmr55418985a.58.1728477481260; 
 Wed, 09 Oct 2024 05:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRY05vq1ytVj1dDLdwDSVfgtreoeXD0JnrxOW4HWuS23+ARx4QgJ70wOp2oOqF/90XFPwYcA==
X-Received: by 2002:a05:620a:24d:b0:7b1:113f:2e55 with SMTP id
 af79cd13be357-7b1113f2fefmr55416485a.58.1728477480871; 
 Wed, 09 Oct 2024 05:38:00 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7afcd6a7d46sm125845385a.127.2024.10.09.05.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:38:00 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:37:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: fix build error when qpl compression
 is enabled
Message-ID: <ZwZ5JXZuD9wLD0-_@x1n>
References: <20241008104527.3516755-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008104527.3516755-1-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 08, 2024 at 06:45:27PM +0800, Yuan Liu wrote:
> The page_size member has been removed from the MultiFDSendParams
> and MultiFDRecvParams. The function multifd_ram_page_size is used to
> provide the page size in the multifd compressor.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>

I'll queue and attach:

Fixes: 90fa121c6c ("migration/multifd: Inline page_size and page_count")

Yuan, is qpl going to be used in production?  When reaching that point, we
may want to add a build test in CI somehow.  Otherwise please help keep an
eye (or whoever can still keep an eye on this..) for at least each release
to make sure it builds and works as expected, because normal developers
(including Fabiano and myself) do no have hardware, and as of now we don't
check builds either (unless the library is packaged in most distros, then
we can try).

PS: it's definitely not 90fa121c6c to be blamed..  But I still added that
tag just to make stable lookup easier.  Looks like this is an unwanted side
effect of how we treat the compressor codes.. but I don't yet have a better
idea.

Thanks,

> ---
>  migration/multifd-qpl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index b0f1e2ba46..bbe466617f 100644
> --- a/migration/multifd-qpl.c
> +++ b/migration/multifd-qpl.c
> @@ -389,7 +389,7 @@ static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
>  {
>      QplData *qpl = p->compress_data;
>      MultiFDPages_t *pages = &p->data->u.ram;
> -    uint32_t size = p->page_size;
> +    uint32_t size = multifd_ram_page_size();
>      qpl_job *job = qpl->sw_job;
>      uint8_t *zbuf = qpl->zbuf;
>      uint8_t *buf;
> @@ -420,7 +420,7 @@ static void multifd_qpl_compress_pages(MultiFDSendParams *p)
>  {
>      QplData *qpl = p->compress_data;
>      MultiFDPages_t *pages = &p->data->u.ram;
> -    uint32_t size = p->page_size;
> +    uint32_t size = multifd_ram_page_size();
>      QplHwJob *hw_job;
>      uint8_t *buf;
>      uint8_t *zbuf;
> @@ -560,7 +560,7 @@ static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
>                                                    Error **errp)
>  {
>      QplData *qpl = p->compress_data;
> -    uint32_t size = p->page_size;
> +    uint32_t size = multifd_ram_page_size();
>      qpl_job *job = qpl->sw_job;
>      uint8_t *zbuf = qpl->zbuf;
>      uint8_t *addr;
> @@ -598,7 +598,7 @@ static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
>  static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
>  {
>      QplData *qpl = p->compress_data;
> -    uint32_t size = p->page_size;
> +    uint32_t size = multifd_ram_page_size();
>      uint8_t *zbuf = qpl->zbuf;
>      uint8_t *addr;
>      uint32_t len;
> @@ -677,7 +677,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
>      }
>      for (int i = 0; i < p->normal_num; i++) {
>          qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
> -        assert(qpl->zlen[i] <= p->page_size);
> +        assert(qpl->zlen[i] <= multifd_ram_page_size());
>          zbuf_len += qpl->zlen[i];
>      }
>  
> -- 
> 2.43.0
> 

-- 
Peter Xu


