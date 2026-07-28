Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED9C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocsb-00050Z-1J; Tue, 28 Jul 2026 04:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wocsW-0004z0-L2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wocsV-0005dL-9J
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785226168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xPtRCODRqx7Jy2WDwMF4tOd7nT32ipyUTsR/r+JMFg=;
 b=PgtoMCGRUhBRCr5BHnQ1DGjImvpkN2RQjpSNIAkvNa3dL/xApv95CPcuTsXknEzwmafZl5
 7YtqRKq/Z2nxcPOFFjWMtEzfMP/H0FSoIrWa09i31OBlo6fYX44uyLSPqP7VyOj5Z1nkco
 mWcxGqVRj1fL81l66o2ry66coIqtoEs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-IyalE8BLOHS5EnA7olyu4A-1; Tue,
 28 Jul 2026 04:09:25 -0400
X-MC-Unique: IyalE8BLOHS5EnA7olyu4A-1
X-Mimecast-MFC-AGG-ID: IyalE8BLOHS5EnA7olyu4A_1785226164
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F95A195604F
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:09:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA39641C; Tue, 28 Jul 2026 08:09:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 859F118000A2; Tue, 28 Jul 2026 10:09:22 +0200 (CEST)
Date: Tue, 28 Jul 2026 10:09:22 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/9] hw/misc/vmlaunchupdate: add api header
Message-ID: <amhYKD2dLMAfevTN@sirius.home.kraxel.org>
References: <20260714024557.204578-1-anisinha@redhat.com>
 <20260714024557.204578-5-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024557.204578-5-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

  Hi,

> +/* disable vmlaunchupdate interface */
> +#define VM_LAUNCHUPDATE_CTL_DISABLE            (1 << 0)
> +/* revert to the original host provided igvm */
> +#define VM_LAUNCHUPDATE_CTL_HOST_IGVM          (1 << 1)

Hmm, I think these bits need a more verbose comment, especially the
combination of the two ...

HOST_IGVM=0 DISABLE=0

Supplied IGVM file replaces the firmware permanently.  Updating the
firmware again is possible.

HOST_IGVM=0 DISABLE=1

Supplied IGVM file replaces the firmware permanently.  Updating the
firmware again is not possible.

HOST_IGVM=1 DISABLE=0

Supplied IGVM file replaces the firmware for one reset.  Resetting
again will switch back to the original firmware.  Updating the
firmware again is possible.

HOST_IGVM=1 DISABLE=1

Supplied IGVM file replaces the firmware for one reset.  Resetting
again will switch back to the original firmware.  Updating the
firmware again is NOT possible.

Question:  How long will the 'disable' flag be active?  Specifically
will switching back to the original firmware also clear the 'disable'
flag?  Which I think makes sense.

Another question: What happens when using HOST_IGVM=0 first and later
on HOST_IGVM=1?

> +typedef struct {
> +    /* api version */
> +    uint16_t version;
> +
> +    /*
> +     * The guest can read this in order to determine if loading new IGVM
> +     * succeeded.
> +     */
> +    uint16_t status;

uint32_t _padding;

> +
> +    /* VMM capabilities, read-only. */
> +    uint64_t capabilities;
> +    /* control bits, see VMFWUPDATE_CTL_* */
> +    uint64_t control;

take care,
  Gerd

PS: you should cc alex for v3


