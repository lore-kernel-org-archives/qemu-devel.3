Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CB606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U9JIIkqF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOMRg-0006ov-2y; Tue, 03 Nov 2026 16:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOMRd-0006oc-V9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 16:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOMRc-0006tV-AQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 16:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793742806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gejCDLbcFZm4xmjs7E1RYJi6d3GBAqc3eG17R7vZeP0=;
 b=U9JIIkqFna68dS1s1+kRkpvLrZf2L3AW4fi4RybhSwcOZi2YtXB9jUwqEmXBjPe2jgwUpL
 2D/8Q6wO1N9BnZEdgmhYYBeNB79v1pKloPEOPQYMjFWRCkYMkwphB6v4O0rWmho2AYFAHN
 y3cG1hDeHxHRijJ2v4Nkv/MwimIMAYU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-dsK0SVwrNaqqd4N-nCbEow-1; Tue,
 03 Nov 2026 16:53:22 -0500
X-MC-Unique: dsK0SVwrNaqqd4N-nCbEow-1
X-Mimecast-MFC-AGG-ID: dsK0SVwrNaqqd4N-nCbEow_1793742801
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809881956063; Tue,  3 Nov 2026 21:53:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEEB4195608D; Tue,  3 Nov 2026 21:53:18 +0000 (UTC)
Date: Tue, 3 Nov 2026 16:53:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: qemu-devel@nongnu.org, Sam Li <faithilikerun@gmail.com>,
 dlemoal@kernel.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Subject: Re: [PATCH v16 2/9] qcow2: add configurations for zoned format
 extension
Message-ID: <20261103215317.GE1738758@shajnocz.csb>
References: <20261030171038.702962-1-cassel@kernel.org>
 <20261030171038.702962-3-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030171038.702962-3-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 06:10:29PM +0100, Niklas Cassel wrote:
> @@ -432,6 +518,96 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>              break;
>          }
>  
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len != sizeof(zoned_ext)) {
> +                error_setg(errp, "zoned_ext: unexpected len=%" PRIu32 " "
> +                           "(expected %zu)", ext.len, sizeof(zoned_ext));
> +                return -EINVAL;
> +            }
> +            ret = bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "
> +                                 "Could not read ext header");
> +                return ret;
> +            }
> +
> +            zoned_ext.zone_size = be64_to_cpu(zoned_ext.zone_size);
> +            zoned_ext.zone_capacity = be64_to_cpu(zoned_ext.zone_capacity);
> +            zoned_ext.conventional_zones =
> +                be32_to_cpu(zoned_ext.conventional_zones);
> +            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
> +            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
> +            zoned_ext.max_active_zones =
> +                be32_to_cpu(zoned_ext.max_active_zones);
> +            /*
> +             * A zoned image has the zoned incompatible feature bit set,
> +             * which a version 2 image cannot have.
> +             */
> +            if (zoned_ext.zoned == QCOW2_Z_HM &&
> +                !(s->incompatible_features & QCOW2_INCOMPAT_ZONED_FORMAT)) {
> +                error_setg(errp, "Zoned extension header without the zoned "
> +                           "incompatible feature bit");
> +                return -EINVAL;
> +            }
> +
> +            /*
> +             * Validate the header before it becomes the driver state.
> +             * qcow2_check_zone_options() also clamps the zone resource
> +             * limits, so the driver has to pick up the checked copy.
> +             */
> +            if (!qcow2_check_zone_options(&zoned_ext, s->cluster_size)) {
> +                error_setg(errp, "Invalid zoned extension header");

Please pass errp into qcow2_check_zone_options() and use error_setg()
inside the function instead of warn_report() for consistent error
reporting.

> @@ -237,6 +242,62 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
>  
> +/* Maximum number of zones a zoned image can have. */
> +#define QCOW2_MAX_NR_ZONES (1U << 20)
> +
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned;
> +    uint8_t reserved[3];
> +    uint32_t nr_zones;
> +    uint64_t zone_size;
> +    uint64_t zone_capacity;
> +    uint64_t zonedmeta_offset;
> +    uint32_t conventional_zones;
> +    uint32_t max_active_zones;
> +    uint32_t max_open_zones;
> +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> +
> +typedef struct Qcow2ZoneListEntry {
> +    QTAILQ_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> +    QTAILQ_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> +    QTAILQ_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
> +} Qcow2ZoneListEntry;

This and the other struct definitions and fields that are not yet used
should be moved to the patches that introduce code that needs them. It
is not possible to meaningfully review them here before they are used.

> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 0054c2ed97..02a68b34f7 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -117,7 +117,7 @@ header_length             112
>  
>  Header extension:
>  magic                     0x6803f857 (Feature table)
> -length                    384
> +length                    432
>  data                      <binary>

This looks suspicious but it's because qcow2_update_header() eagerly
advertises all features it knows about, even if the image file does not
use them. This means newly created non-zoned files will now have the
name for QCOW2_INCOMPAT_ZONED_FORMAT_BITNR even though they will never
use it.

There is no harm in this change. In the future maybe
qcow2_update_header() should only include feature bits that are actually
used, but you don't need to implement this.

Feel free to add by R-b to the next revision:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


