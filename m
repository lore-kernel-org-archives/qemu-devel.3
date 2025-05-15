Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C14C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFefn-0008JF-Io; Thu, 15 May 2025 15:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFefU-0008FB-AL
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFefP-0001jD-1s
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747338886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGrskkDvhYODZOL28O7wsFt2juOgjoFN+W5SicLLyMI=;
 b=FlGIJLw6/hWJ6tWnNbRM5KHYQW4EjPJ3fXbWbgYmE1DxR2timLxmmcHu8LBKh86aQrPTn4
 ovkw9QPz89tEMb3xxEPpftG0Qup/fJuEQXAIM5oKrA3yzSoRvW9sCp3cYxQnbBPeHCtBbB
 DdL5XMcBzO711EXkJT9IBzVuREmU//0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-U7e3vCpdNeiF_sj8AUL2JA-1; Thu,
 15 May 2025 15:54:43 -0400
X-MC-Unique: U7e3vCpdNeiF_sj8AUL2JA-1
X-Mimecast-MFC-AGG-ID: U7e3vCpdNeiF_sj8AUL2JA_1747338882
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24E17195609F; Thu, 15 May 2025 19:54:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BF22195608D; Thu, 15 May 2025 19:54:39 +0000 (UTC)
Date: Thu, 15 May 2025 14:54:37 -0500
From: Eric Blake <eblake@redhat.com>
To: conte.souleymane@gmail.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH] docs/interop: convert text files to restructuredText
Message-ID: <zox7vj235b67jxv6fklzre6ebeqbft3sujqjuh5it2cng2culj@a63jddoleon5>
References: <20250515102400.36151-1-conte.souleymane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515102400.36151-1-conte.souleymane@gmail.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 15, 2025 at 10:24:00AM +0000, conte.souleymane@gmail.com wrote:
> From: Souleymane Conte <conte.souleymane@gmail.com>
> 
> buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
> 
> Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
> ---
>  docs/interop/index.rst                |   1 +
>  docs/interop/{qcow2.txt => qcow2.rst} | 210 +++++++++++++++-----------
>  2 files changed, 123 insertions(+), 88 deletions(-)
>  rename docs/interop/{qcow2.txt => qcow2.rst} (89%)
>

As long as we're touching this file,...

> +Feature name table
> +------------------
>  
>  The feature name table is an optional header extension that contains the name
>  for features used by the image. It can be used by applications that don't know
> @@ -288,7 +300,7 @@ the respective feature (e.g. because the feature was introduced only later) to
>  display a useful error message.
>  
>  The number of entries in the feature name table is determined by the length of
> -the header extension data. Each entry look like this:
> +the header extension data. Each entry look like this::

s/look/looks/

> @@ -377,35 +392,40 @@ Logically the layout looks like
>  
>    +-----------------------------+
>    | QCow2 header                |
> +  +-----------------------------+
>    | QCow2 header extension X    |
> +  +-----------------------------+
>    | QCow2 header extension FDE  |
> +  +-----------------------------+
>    | QCow2 header extension ...  |
> +  +-----------------------------+
>    | QCow2 header extension Z    |
>    +-----------------------------+
> +  | ...                         |
> +  +-----------------------------+
> +  | ...                         |
> +  +-----------------------------+
>    | ....other QCow2 tables....  |
> -  .                             .
> -  .                             .
>    +-----------------------------+
> -  | +-------------------------+ |
> -  | | LUKS partition header   | |
> -  | +-------------------------+ |
> -  | | LUKS key material 1     | |
> -  | +-------------------------+ |
> -  | | LUKS key material 2     | |
> -  | +-------------------------+ |
> -  | | LUKS key material ...   | |
> -  | +-------------------------+ |
> -  | | LUKS key material 8     | |
> -  | +-------------------------+ |
> +  | LUKS partition header       |
> +  +-----------------------------+
> +  | LUKS key material 1         |
> +  +-----------------------------+

Is there no way to nest a table in .rst?

> +Host cluster management
> +-----------------------
>  
>  qcow2 manages the allocation of host clusters by maintaining a reference count
>  for each host cluster. A refcount of 0 means that the cluster is free, 1 means
> @@ -453,14 +474,15 @@ Although a large enough refcount table can reserve clusters past 64 PB
>  large), note that some qcow2 metadata such as L1/L2 tables must point
>  to clusters prior to that point.
>  
> -Note: qemu has an implementation limit of 8 MB as the maximum refcount
> -table size.  With a 2 MB cluster size and a default refcount_order of
> -4, it is unable to reference host resources beyond 2 EB (61 bits); in
> -the worst case, with a 512 cluster size and refcount_order of 6, it is
> -unable to access beyond 32 GB (35 bits).
> +.. note::
> +    qemu has an implementation limit of 8 MB as the maximum refcount

Should we be changing s/qemu/QEMU/ while editing this file?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


