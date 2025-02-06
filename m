Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD56C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3hZ-0008Mt-Fq; Thu, 06 Feb 2025 10:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tg3hX-0008MD-Fb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tg3hV-000599-O7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738855316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpV63lmlHFTW8rPxsUNo3ZqcDK3KgCRBJFh9ATs0+OM=;
 b=Dz0LVlz4oE1I72HoXWKvbh10z60vNWEv3VTLICSNscBevwaEIlR4IxSVMYSHGzTuUGccr+
 HKR+vAW2KY0PwNhjmWH12bbBJtiDQzRWmhgvXxRo2LHLM1ciEzLnYrt//YkjVfAAnZTGmm
 ckmqMhnNx4SZhLsfNii2XBSDoO9jOKE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-LkKsof9NPEy64FIWWHC5ew-1; Thu,
 06 Feb 2025 10:21:51 -0500
X-MC-Unique: LkKsof9NPEy64FIWWHC5ew-1
X-Mimecast-MFC-AGG-ID: LkKsof9NPEy64FIWWHC5ew
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B30BC19560AA; Thu,  6 Feb 2025 15:21:50 +0000 (UTC)
Received: from localhost (unknown [10.44.33.231])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22B7C1800872; Thu,  6 Feb 2025 15:21:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Corvin =?utf-8?Q?K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Corvin =?utf-8?Q?K=C3=B6hne?=
 <c.koehne@beckhoff.com>
Subject: Re: [PATCH 2/4] scripts/update-linux-headers: include PCI ID header
 for Intel GPUs
In-Reply-To: <20250206121341.118337-3-corvin.koehne@gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
 <20250206121341.118337-3-corvin.koehne@gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 06 Feb 2025 16:21:46 +0100
Message-ID: <87ikpn6qut.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06 2025, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wrote:

> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> We've recently imported the PCI ID header for Intel GPUs into our tree.
> Add it to our helper script to make it easier for us to sync this file
> in the future.
>
> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> ---
>  scripts/update-linux-headers.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
> index 8913e4fb99..a4ff5a8fe9 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -269,6 +269,12 @@ mkdir -p "$output/include/standard-headers/drm"
>  cp_portable "$hdrdir/include/drm/drm_fourcc.h" \
>              "$output/include/standard-headers/drm"
>=20=20
> +# Linux does not install the PCI IDs header for i915 devices, so we have=
 to
> +# pick it up from the source tree itself.
> +mkdir -p "$output/include/standard-headers/drm/intel"
> +cp_portable "$linux/include/drm/intel/pciids.h" \
> +            "$output/include/standard-headers/drm/intel"
> +
>  cat <<EOF >$output/include/standard-headers/linux/types.h
>  /* For QEMU all types are already defined via osdep.h, so this
>   * header does not need to do anything.

The correct process here would be:
1. update the script (this patch)
2. run a full headers update against Linux v.13 (replaces patch 1)

I'll leave discussion of the whole series to the others :)

Thanks,
Cornelia


