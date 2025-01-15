Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A364DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4VF-0001dN-Qb; Wed, 15 Jan 2025 09:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tY4VA-0001bU-KI; Wed, 15 Jan 2025 09:36:14 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tY4V8-0006do-O3; Wed, 15 Jan 2025 09:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=BzHVI2QHsblFL3UdSqVJ+hb2V1l2T08WDs3ev7B3rhU=; b=xX5GMUOF7fb6dPESjNoX3BU1Pt
 xYQSp1DvKS8gZEuQnyeqmVK43oN0bHMO89pCSUnersCo3ye9upzNNr0g7dwu0UGn6aXcbOJo54QgE
 DAIyQtU2LBsbuxLKVdygZtPrXLA8xez8lKro5Q/a6/+TMqipsB3nGXAKKT2wZU0mOA4s=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tY4V0-0061ge-2w;
 Wed, 15 Jan 2025 14:36:03 +0000
Received: from [2a01:e0a:1da:8420:b77:bd5:6e45:7633] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tY4V0-006U5Y-2l;
 Wed, 15 Jan 2025 14:36:03 +0000
Date: Wed, 15 Jan 2025 15:36:00 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/2] xen: do not use '%ms' scanf specifier
Message-ID: <Z4fH0NwPEmjryqoG@l14>
References: <20250110093531.23221-1-roger.pau@citrix.com>
 <20250110093531.23221-3-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110093531.23221-3-roger.pau@citrix.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 10:35:31AM +0100, Roger Pau Monne wrote:
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index ef0c2912efa1..989e75fef88f 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -550,7 +550,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
>          goto fail;
>      }
>  
> -    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
> +    type = xs_node_read(xsh, XBT_NULL, NULL, errp, "%s/%s", fe, "type");
> +    if (!type) {
>          error_prepend(errp, "failed to read console device type: ");
>          goto fail;
>      }
> @@ -568,7 +569,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
>  
>      snprintf(label, sizeof(label), "xencons%ld", number);
>  
> -    if (xs_node_scanf(xsh, XBT_NULL, fe, "output", NULL, "%ms", &output) == 1) {
> +    output = xs_node_read(xsh, XBT_NULL, NULL, errp, "%s/%s", fe, "output");

This now set `errp` on error, when `output == NULL`. In case `output` is
NULL, we check for `number` instead and may generate an error message
that probably doesn't really make sense.
    "console: No serial device #2 found: failed to read from /frontend_path/output"
And if number == 0, we tried to create a null device, and if that
failed, the error message will just be about the missing xenstore path
as error_setg() will not set `errp` again.

Could you keep ignoring errors from xs_node_read() like it was done with
xs_node_scanf() (I mean pass `NULL` instead of `errp`)? And we will need
another patch to fix the wrong use of `error_prepend()` and use
`error_setg` instead when `serial_hd()` fails.

> +    if (output) {
>          /*
>           * FIXME: sure we want to support implicit
>           * muxed monitors here?

Thanks,

-- 
Anthony PERARD

