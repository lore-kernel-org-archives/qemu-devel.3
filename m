Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PJ8CVVyZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tJsdVzfZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWvOT-000514-4l; Fri, 27 Nov 2026 07:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWvON-00050R-5w
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWvOL-0008Ae-Cd
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 07:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795783767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gT2XmcoLOOYkkOMR6gisPN9f+DznBHP7TG6MECkF67k=;
 b=PJ8CVVyZBxtAehygSCXjMnwSs/68N6QeqHNTyN7hWA3Y6zaBmZp6ERBo7J14zJcfguvJ4v
 ob65tkntDKHtxHrW8qILVFnTJMzKamIZZacDesJUMMnv1cK0BYt+aXOI46KbJ06NDbfwNd
 PGTxEWxGJaKknlTPOdeMhpLZ/G7oFdM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-q0LTlATWOQWqsiLY65Ibiw-1; Fri, 27 Nov 2026 12:49:25 +0000
X-MC-Unique: q0LTlATWOQWqsiLY65Ibiw-1
X-Mimecast-MFC-AGG-ID: q0LTlATWOQWqsiLY65Ibiw_1795783765
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9211f05706bso85726346d6.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795783765; x=1796388565; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gT2XmcoLOOYkkOMR6gisPN9f+DznBHP7TG6MECkF67k=;
 b=tJsdVzfZG5JEC+IeVI9Sp9IkS/N2lGR8sdD1U19JGZszgvdSJFVf0Xd9WGCGHcW8oU
 hO5mWomjb9quihapqQ5J8rI4OQ6YLo6WBxo1veeby2MzRdJrOsZLDDH5R5xTJPO3C76n
 XkEKwD2c1FigutmSNYImZjjDivwhQeAl204d/u2snBX0nzQQldh3Ru9xxMO5dXf0OHfg
 gMuBtEJPqbfH76SfMBEt4NLMdTmx7ODEw/3T/85Q5fzGNS3HCubPLc1CUtFcxmXdChJs
 S4SXsA1zr5miwlpidnrr71qnCqQO013st5stBqI2w3iHAy35p7SV0kGQYrDFqZ50Ii19
 8JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795783765; x=1796388565;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gT2XmcoLOOYkkOMR6gisPN9f+DznBHP7TG6MECkF67k=;
 b=lZsju9BbNmTI37X0hEqqrZMWJ50QerbALWxj/O3QYVwWLysXbY8eNMzkOwtJmScses
 Cdng3E9ZhMtqftZoFwuSjvhz3gw59jHZkAt7oeGcrFjYGThriEF1U41C6T98erO0a16q
 jcls1kXwMEcrYDVWedHwkY14sd8kU7S+wsifKJ4SUuC7AODgjnpfyKYM3NVOWguFwyBm
 KnWhVeNwrtHGw/zINnpUxBB8xyA21Jz5GkZ22df43V17AY+1FrLMXaRp6GChuEWH+LVd
 WoHN5odayqHQU5qC+K9w0JLEZyti7b6Xjfwt5gvFJ0Tc78YBfyENE3tbANQnxhpCxfBo
 w6TQ==
X-Gm-Message-State: APuU4Z8xACXVw3bXmIrK09EZrfp6EoLbrf4wGAm7jC0drxHggwU3cDo7
 Lj1N+UHXDQOQItI9JhRTKKPZaDwIBwgbFWmu0x0aaR2Y8OOgowVfZq535CkZNTIQnnToclwSZbK
 +xpwC2+oY9kbNASpqhUF/KAEyvySeHawfJBPP83g8as8cm/LwxmRjuwRr
X-Gm-Gg: AZFdTZdhlZ7z9eCfigr61SItJd35XV2NYIV12+tAPPGx74XxYjJpsQBu8Jdsy1rZ/yC
 YBM5jp8fTqO24bcFJIWzoq4WkSU3oJozIcry90FsCF+H93T2eAAvQKh03pCIR9xq3mqitIogimQ
 B9mp7HElAHinSlKQxVf/yc1Vgub/PJL3oJQUdG6GPmkZxKt0ubkcw/ICS2keaR4IuSVA18ikBqP
 39oVkpJPtspkO5ac1bOITu9i4QCtTEq3RY/T/39LSFDs1zzIri0M6MAnIzanLvGCm8Et+D2APTA
 jKGZppnz0yHlLa2HPuEvHdNEjul4HTFKnhQV8WvG555/QtOKHvgUUyxw4gg/n/JHvCG3hq1ksxF
 hZaYJaaF+2yxFfnR1Dl+4UMCRYRx4enhkj51MSjvlS66p
X-Received: by 2002:a05:6214:ca7:b0:921:53fe:b7e2 with SMTP id
 6a1803df08f44-92153febe12mr305058376d6.38.1795783764796; 
 Fri, 27 Nov 2026 04:49:24 -0800 (PST)
X-Received: by 2002:a05:6214:ca7:b0:921:53fe:b7e2 with SMTP id
 6a1803df08f44-92153febe12mr305057726d6.38.1795783764214; 
 Fri, 27 Nov 2026 04:49:24 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9217fd18b2asm59827646d6.21.2026.11.27.04.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:49:23 -0800 (PST)
Date: Fri, 27 Nov 2026 07:49:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Jie Song <mail@jiesong.me>
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 farosas@suse.de, avihaih@nvidia.com,
 Jie Song <songjie_yewu@cmss.chinamobile.com>
Subject: Re: [PATCH] vfio/migration: Use qemu_put_buffer_async to avoid an
 extra copy
Message-ID: <awl8Uksgkf_z821z@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120162026.31245-1-mail@jiesong.me>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120162026.31245-1-mail@jiesong.me>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 12:20:26AM +0800, Jie Song wrote:
> From: Jie Song <songjie_yewu@cmss.chinamobile.com>
> 
> Replace qemu_put_buffer with qemu_put_buffer_async + qemu_fflush in
> vfio_save_block to avoid an unnecessary memcpy of device state data
> through QEMUFile's 32 KiB internal buffer.
> 
> With qemu_put_buffer_async, the data_buffer pointer is added directly
> to the iov array. Since the next read overwrites the same buffer,
> flush immediately so that the channel has consumed the data before
> the buffer is reused.
> 
> Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>

Showing some number would always be nicer, but in this case it seems we
have two buffer sizes almost constant (32K for qemufile, 1MB for vfio), so
it seems always a win,

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


