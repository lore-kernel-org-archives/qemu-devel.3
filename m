Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB77F364A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAt0j-0006EX-CU; Thu, 09 Apr 2026 13:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAt0h-0006Ct-1x
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAt0f-0001WH-Lh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775755061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=247jl1JVuyPjui+k+uF4E77GLIH5nMqjIn39eEpQu7I=;
 b=IQ/VIsUZCDrL7OYKhOVb65Zx1YN6Z1e+oeTpmuOK4xLI0+I2rDM6cIRCRNqnm/YMggYD9A
 nqFxAquBZFUxeUzYi5gqKmgjaiq1BvJ+T8XU/ofi8By8L52UZIZG747W/0UtzANJRJ5zGP
 SsEfXDcD23YnN49PZVKIFONtSs2AmEo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-4rNMfa0xNFO5RdF9fdNyrw-1; Thu, 09 Apr 2026 13:17:39 -0400
X-MC-Unique: 4rNMfa0xNFO5RdF9fdNyrw-1
X-Mimecast-MFC-AGG-ID: 4rNMfa0xNFO5RdF9fdNyrw_1775755058
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-486fa07f2bbso6212065e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775755058; x=1776359858; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=247jl1JVuyPjui+k+uF4E77GLIH5nMqjIn39eEpQu7I=;
 b=ZpZGMaX86wijTxZPLZ9FIVUclrQ1pOlrN5znFxPP7rgqU/1RvFj5FHw9zFx/O/0fwD
 8+hEQoU9HdidiOxue4cLCOFOxF40EpAMPyKOqBlpyEpJVTrOIvqUM/WRRTBXwq8ZccCr
 IChN9Fce986y4uH74WzKlO6nXtuZENveeeiMckzfHmgT4yZQV/P2P/xuNDzH7gHD0JTa
 G8UJFR6RrSIrExN5ycmZzqpNoxLIO9ONgWBsGRoFZDxmQtuiKhpvAsXd22CToLr7aB4Z
 a3cigKkF21DtJ9o5MgaM0Vfsk+bntwq3Tnv0R3/FSfIir1WJTbo2zLHstyy06fDtoYA0
 Ml4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755058; x=1776359858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=247jl1JVuyPjui+k+uF4E77GLIH5nMqjIn39eEpQu7I=;
 b=cJGgxFumMz8ySB3Vg7slXtrVgdJ3zXlSjGe10MiY5QxkB8hhOpF8TLIKC1Co05xDJH
 y6mTWunt/nHGk9XL5hYnU2JiHyloCCH72vQR9LuAhCFS+W5PqgoInvES8tzf18KGLmZ1
 Pby2uoXjUgvT6b34nIcfXFV3NSiJ2n2vG1Uc678HV10FrhmnTOD3t4Ntx/9m1hbDnP8d
 IwIQIzyV5HZhQFeAPSOqLS26YpJs3MUNbwJRLdrjIgpIffBdWqDqvT2Es2S6cN45VOhG
 G9trEExzoLZVmTB7m+p+22q+dj5E8ezW2yYAuBtCVDxKTtXtWbEpXuTcg1F9v2F8fxPD
 95OA==
X-Gm-Message-State: AOJu0Yx80cMnTmQGJZWTNzAq7OA6vurs6IuI6hoBqI4uOkgbWUcwPDjr
 O5dQUYCAlnlRzvjA8V4BKQbxEYyhBY4hx5GoKxA5iF5fa+jeU+xRpXLiabNj3+6O6JAAATT/xwZ
 nSXMLYEt+5iXjFnfTOJqSpzift85jEdWorlxpcJCc8k44Yt0emw+7kgnR
X-Gm-Gg: AeBDiev1d69HaysXbwEPqvLz5Cg2SyVyO8uokDZn4RxwzCCMMwn7dIfSdpliAz2l3VY
 fEN2+CRKGn5jOKasl7Eh6X2IDmA5gPzx/201wCUaW5I3daB5cPmVHKihr/QNrgGmYRlu8Ntnyxi
 KpRuujB0IMZP99ZYOdIkDJGzQbOESfd33leq1NC8OXEZg1HN0uha6nIihlmf1ChBWS0y+zO9Z/V
 rFVTn0gMyg07SDF/6GRX1rQmPaSPnVHVlHX72o7iN1EFXWb4tW8glSsuAsE1cDSwnB+a/WzHXqS
 4SOLnyf28YCP08vbwczhfJyYulwbcBl5/cUOC3IRLzOUF1E+gWLfoVcAfOiJYU8g+nvGkaxMiss
 TfxFVQKQpSKkyCvkvyxWZkGBGfuv8/EIm/aKhhXg=
X-Received: by 2002:a05:600c:4ed4:b0:488:8b52:f7de with SMTP id
 5b1f17b1804b1-488ccf7f7bemr62443875e9.12.1775755058226; 
 Thu, 09 Apr 2026 10:17:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed4:b0:488:8b52:f7de with SMTP id
 5b1f17b1804b1-488ccf7f7bemr62443365e9.12.1775755057681; 
 Thu, 09 Apr 2026 10:17:37 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d532ef00sm11337405e9.5.2026.04.09.10.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:17:37 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:17:34 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 12/14] migration: Fix calculation of expected_downtime to
 take VFIO info
Message-ID: <adffHdctAKEsb3IG@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-13-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
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

On 2026-04-08 12:55, Peter Xu wrote:
> QEMU will provide an expected downtime for the whole system during
> migration, by remembering the total dirty RAM that we synced the last time,
> divides the estimated switchover bandwidth.
> 
> That was flawed when VFIO is taking into account: consider there is a VFIO
> GPU device that contains GBs of data to migrate during stop phase.  Those
> will not be accounted in this math.
> 
> Fix it by updating dirty_bytes_last_sync properly only when we go to the
> next iteration, rather than hide this update in the RAM code.  Meanwhile,
> fetch the total (rather than RAM-only) portion of dirty bytes, so as to
> include GPU device states too.
> 
> Update the comment of the field to reflect its new meaning.
> 
> Now after this change, the expected-downtime to be read from query-migrate
> should be very accurate even with VFIO devices involved.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h |  8 +++-----
>  migration/migration.c       | 11 ++++++++---
>  migration/ram.c             |  1 -
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


