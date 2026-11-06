Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5740606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ecmEaEql
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLH3-0002TV-4z; Fri, 06 Nov 2026 09:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xPLGv-0002St-8e
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:50:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xPLGt-000285-H4
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793976626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JErcGewUXqvF9zgQ7V0Xh+c4el+tz4M+IrTJ1kceNUY=;
 b=ecmEaEql0A93WWEdihLBC3Yzw+MvWLI8oD62vFjzHwsa9ZMV7eLd+cc/nuVGjmqIvjSKH8
 CwuPOBx5+QhChDTcHyvkPVlqadeTzgXEy7iCzlIypsiaZPxeYg2Mpe0+tYt6+eME/GVGVF
 tGlfFgVqD1HckKbpTknolV7uiYtvJYg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-i0B48GWxPKiPlvy2rrLNjw-1; Fri,
 06 Nov 2026 09:50:23 -0500
X-MC-Unique: i0B48GWxPKiPlvy2rrLNjw-1
X-Mimecast-MFC-AGG-ID: i0B48GWxPKiPlvy2rrLNjw_1793976622
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA4201955E80; Fri,  6 Nov 2026 14:50:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.86])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F35DE39202; Fri,  6 Nov 2026 14:50:18 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:50:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, berrange@redhat.com
Subject: Acknowledgements for AI-assisted trivial bug reports (was: [PATCH]
 block/vhdx: Prevent out-of-bounds BAT accesses with) malicious vhdx files
Message-ID: <au3pKF4zORf4_98U@redhat.com>
References: <20261023130023.539252-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023130023.539252-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 23.10.2026 um 15:00 hat Thomas Huth geschrieben:
> virtual_disk_size is read directly from a VHDX image's metadata region
> and never checked for sane sizes.  The 64 TiB limit (VHDX_MAX_IMAGE_SIZE)
> is only enforced in vhdx_co_create(), so it limits images QEMU creates
> but never images QEMU opens.
> 
> Without the bound, vhdx_calc_bat_entries() computes the block count
> into a uint32_t, so a huge image size gets truncated and the BAT is
> undersized relative to total_sectors.
> vhdx_block_translate() then converts sector numbers into BAT indices
> with no bounds check, allowing out-of-bounds access on the BAT array
> from both the read and write paths.
> 
> To fix the problem, add a VHDX_MAX_IMAGE_SIZE check to vhdx_parse_metadata()
> so images opened for reading are subject to the same limit as images
> created by QEMU.
> With this limit, the calculation in vhdx_calc_bat_entries() cannot get
> truncated anymore (block_size is at least 1 MiB):
> 
>  VHDX_MAX_IMAGE_SIZE / block_size = 64 TiB / 1 MiB = 64 MiB
> 
> ... and 64 MiB fit nicely into 32 bits.
> 
> To be really on the safe side, let's also add an assertion in
> vhdx_block_translate() to catch accesses that exceeds the allocated
> entry count.
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
> Reported-by: Daniel Wade <danjwade95@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4470
> Reported-by: Mayank Jangid (OpenSec)
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4487
> Reported-by: Ken Hsu, Royce Lu, and Bo Qu of Palo Alto Networks
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4638
> Reported-by: Thai Duong (Calif.io)
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4733
> Reported-by: Xiang Chen

So if I understand correctly, this issue is trivial enough that it was
found by five people('s AI agents) independently, can be fixed in five
lines of code, and not a single one of the reporters could be bothered
to send an actual patch or at least attach one to their report?

All these reports seems to include two kilometers of AI output and
somewhere in it they typically hide a section on suggested fixes, but
always either in English or as a code snippet that you have to manually
insert in the right place instead of a patch that can actually be
applied.

I wonder if we're setting the wrong incentives if we reward such
laziness with Reported-by lines for each reporter. I'm inclined to drop
all of them and only leave the Resolves lines in place.

Maybe how to deal with such cases could actually be a topic for QEMU
Summit.

Kevin

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/vhdx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index c16e4a00c8d..8013a90a1a4 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -815,6 +815,11 @@ vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
>      }
>  
>      s->virtual_disk_size = le64_to_cpu(s->virtual_disk_size);
> +    if (s->virtual_disk_size > VHDX_MAX_IMAGE_SIZE) {
> +        ret = -EFBIG;
> +        goto exit;
> +    }
> +
>      s->logical_sector_size = le32_to_cpu(s->logical_sector_size);
>      s->physical_sector_size = le32_to_cpu(s->physical_sector_size);
>  
> @@ -1149,6 +1154,7 @@ static void vhdx_block_translate(BDRVVHDXState *s, int64_t sector_num,
>  
>      sinfo->bytes_avail = sinfo->sectors_avail << s->logical_sector_size_bits;
>  
> +    assert(sinfo->bat_idx < s->bat_entries);
>      sinfo->file_offset = s->bat[sinfo->bat_idx] & VHDX_BAT_FILE_OFF_MASK;
>  
>      sinfo->block_offset = block_offset << s->logical_sector_size_bits;
> -- 
> 2.56.0
> 
> 


