Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47143FCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXkD-00027N-VQ; Fri, 06 Mar 2026 11:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyXkB-000274-SW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:09:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyXkA-0005WM-6h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772813375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3kL9Yv7G/zAj/TCnqBHpCNBCM8qGHl7OWM7Zg7ESHrs=;
 b=XS37OadKUmCcPs5BIwlrbOhVICLwXUZ7KPwyHyqLrltlBzPNeYTSekPRKApt2v/doPyIL5
 KrInxNlD4rH2oxiOL17o7WXlYd0IUJq5uDX3WOW589JOP7Z/HNkU6Udjcg1cZQxFOhvQsA
 7NKrYDMAepaxtPqq6Cuori/Lw1eJKSo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-Axpn23kyM_OkY7KNJhOsxw-1; Fri,
 06 Mar 2026 11:09:34 -0500
X-MC-Unique: Axpn23kyM_OkY7KNJhOsxw-1
X-Mimecast-MFC-AGG-ID: Axpn23kyM_OkY7KNJhOsxw_1772813373
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F89C19540F2; Fri,  6 Mar 2026 16:09:31 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E90B81800764; Fri,  6 Mar 2026 16:09:29 +0000 (UTC)
Date: Fri, 6 Mar 2026 17:09:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] iotests/244: Add test cases for keep_data_file
Message-ID: <aar8NxJVHFDC9HpL@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
 <20250530084448.192369-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530084448.192369-5-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 30.05.2025 um 10:44 hat Hanna Czenczek geschrieben:
> Add various test cases around keep_data_file to the existing data_file
> test suite 244.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/244     | 71 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/244.out | 53 ++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)

> +# No preallocation is OK when also specifying data_file_raw; otherwise, none of
> +# the data file will be mapped, i.e. its contents will stay hidden, so
> +# requesting its contents to be kept (but hidden) doesn't make much sense.
> +#
> +# Metadata preallocation is OK: It will not overwrite the data file's contents,
> +# but ensure the contents are mapped and visible.
> +#
> +# Any data preallocation (like falloc) is not OK, as this would overwrite the
> +# data file's contents despite keep_data_file requesting they should not be
> +# overwritten.
> +#
> +# Note that all of these cases use the data file created above: This verifies
> +# that when passing keep_data_file=on, the data file is always kept as-is (and
> +# e.g. not deleted on error).
> +for prealloc in off metadata falloc; do

Why not add full just for the sake of completeness?

Kevin


