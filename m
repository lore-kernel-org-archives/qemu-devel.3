Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1429BFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABR8-0002io-Ge; Tue, 07 Apr 2026 14:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wABQt-0002am-Io
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAAIj-00024z-HW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775583199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZaUMrvK3Z09e4E2lwWLZMeDvEvk+3MRODn5jjQV5TM=;
 b=WSNCiBESsQJ7AozVmBjRFSbk0uYmoVKd1q4UjHT5T1IUq5Unjgjv9YvLJhsBJ0eI5E7mtK
 4Nnt+jT1dollqYwUiaaFbAz7jXBz1IevBSOlRHkaWz8iC6jijf/cox1wEcMB27Rw0oqVdV
 gX9uEKSZ+T56cs7aWjZs2WE7npQaGaE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Mzn_Vu9YPvGjLNHmSiLaxQ-1; Tue, 07 Apr 2026 13:33:18 -0400
X-MC-Unique: Mzn_Vu9YPvGjLNHmSiLaxQ-1
X-Mimecast-MFC-AGG-ID: Mzn_Vu9YPvGjLNHmSiLaxQ_1775583197
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89463017976so141676716d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775583197; x=1776187997; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MZaUMrvK3Z09e4E2lwWLZMeDvEvk+3MRODn5jjQV5TM=;
 b=niBV5fPdnXxbCPLauzOxI5btTzP11bkmrKAVJN/aXiDr7LZHhtzHYsYJn3QHKTor22
 NpDemWUSHPtcX6JI4cHcHYBnp6Mi0Z2pqeqUOMb+2izX6SY3USLjwbYYA1TpaOpn5H7B
 +3/Y0PAIEC0X8Nf4vH9A8mHaa9kK6pmCYFaqcAEpO0OtsLmNr51huHV1nrDMSl6vPY5F
 80mSvGe8ZBTNt18WZRi68CZhYbQwarbAlOO0SjxEt8HWANLv0yydnqhbidHw9uGuf0/d
 ndM6hLevOo+DdmVAphnwr22Iy25QEil+9oMJjkF4juwiwmK9Sq/E2iXW9Jj7Kyp7kBLP
 irQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775583197; x=1776187997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZaUMrvK3Z09e4E2lwWLZMeDvEvk+3MRODn5jjQV5TM=;
 b=NKrucstOU/guDeV1cKZJCQ43OI0uapgWF31yGt0xvXV1Tt46feYXC7d3hb5RCJLQz0
 6dw2fEYtnMs0KgdJWMSWxgS+c3MZzwqlhQc6Uy3GmYzH88FoMD4KPC67qRCL0gOhmb/Q
 6Mqih8iTxiFUasNSDoE0CwdW/bZeuGRyIfl6SQcjMAJSztz0OaoseDbEIxQS2hOAfpVY
 s/66+kM2LVMXIW+hRIW3AxFGjPlIFC4UGtPaLlcZOV/CiuRJDjJgpQgEokBNCeRctwHz
 QCKr4BnUjrmaX36nCR8mwyZsQv1evnyvbeOpqnmdhA7TP3y3aq2Jf59352ew8rWT6xOU
 M06w==
X-Gm-Message-State: AOJu0Yzarc9e0tiDbtRA1K/OPFJpT84bpLBWYyIQuNPk2NY8E9KOInMN
 sh06NO3gFqSJ0SDLy6zedRdBDhQ6vSY3gg9hizYR203G8FNFXUmxYjp2aF/7XUWccxXPgccsqr7
 ADGoA6Gpq+xU/s0LaI8n/JxdYLRLhvlLbbjAT9axlPrP9AQRPEMMy4b/d
X-Gm-Gg: AeBDies/H5ALrnXMyGWiAWHYT4l8LyaGrbA6dxIkL45aDuhx51ZJotlRNKSCim0YF/m
 fHRZvCa5SCsvNGQleUWQSf0HSOmhvMr/FY4eV7kq43kRGVUHQQ4jHbyiGk5pTXdAFHiau74NsJC
 ZZWtnRx5lw7pxsCoTIRH6O8EkmZ8oCIzHPMBFJh6aw016Ag1LI6tLI9g1f5gohdelC6nPQaEWE0
 4hyXdutD4/3VszL0S1/sqUSxj4YEHhLScQn81qPsIOHWA1QX7l8oL4Uog3u1Ss4p9t9+YTtcwn5
 GVudRAgp6mFRvxy/LxHL1O+SM70Lu/asJUwgkqoV1aHECJn/ujCPj8k4BHLEWG+j4UkNqsNFZhS
 mTPDxN5VXzfPEDo3gUyJkSB5S1TcVNXXPQJLWRbRI5BrMKIg=
X-Received: by 2002:a05:620a:408e:b0:8cd:87aa:e3e1 with SMTP id
 af79cd13be357-8d419c57767mr2348867185a.29.1775583197234; 
 Tue, 07 Apr 2026 10:33:17 -0700 (PDT)
X-Received: by 2002:a05:620a:408e:b0:8cd:87aa:e3e1 with SMTP id
 af79cd13be357-8d419c57767mr2348860885a.29.1775583196650; 
 Tue, 07 Apr 2026 10:33:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596a0a3cbsm162913976d6.25.2026.04.07.10.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:33:15 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:33:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 11/12] migration: Calculate expected downtime on demand
Message-ID: <adU_2gIaPe_zil45@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-12-peterx@redhat.com>
 <aca6I81dKUdk2bI2@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aca6I81dKUdk2bI2@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Mar 27, 2026 at 06:17:03PM +0100, Juraj Marcin wrote:
> > +/* Return expected downtime (unit: milliseconds) */
> > +int64_t migration_downtime_calc_expected(MigrationState *s)
> > +{
> > +    if (mig_stats.dirty_sync_count <= 1) {
> > +        return migrate_downtime_limit();
> > +    }
> > +
> > +    return 1.0 * mig_stats.dirty_bytes_last_sync /
> 
> If the intention of '1.0 *' was to get double out of dirty_bytes_last_sync, I think
> an explicit cast would be better.

Let me drop the "1.0 *"; it's not needed when the divisor is double.

Thanks,

> 
> > +        migration_get_switchover_bw(s) * 1000;
> > +}

-- 
Peter Xu


