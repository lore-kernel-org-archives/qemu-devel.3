Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD217E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqGb-0002fz-Lc; Thu, 09 Jan 2025 05:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tVqGa-0002fg-8X
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:59:56 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tVqGY-0000VJ-36
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=Xb8WmGVRb/vr/z5nwf4UmXY3kfsCsZcEmJes/p0baWo=; b=ghRRgBC3k/9uFoYqGU8pKpLzEL
 LnxzcjNJZxalmdPHZz3imf+etNf2Lu0rvndDrdIVCEIFVFV4iXiJdkhqW3/InpA8M9r2M8Y8bHHdK
 wm+dk2HNMDKVolfJP+CBYaMILNQ2dQe7dobqc3tcRBSGSrochTA2alblX0PkQITE8oSA=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tVqGU-00Ckur-38;
 Thu, 09 Jan 2025 10:59:51 +0000
Received: from lfbn-gre-1-248-145.w90-112.abo.wanadoo.fr ([90.112.205.145]
 helo=l14) by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tVqGU-009H4r-2j;
 Thu, 09 Jan 2025 10:59:51 +0000
Date: Thu, 9 Jan 2025 11:59:48 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: do not use '%ms' scanf specifier
Message-ID: <Z3-sJMXpiFUoATHz@l14>
References: <20250107093140.86180-1-roger.pau@citrix.com>
 <20250107093140.86180-3-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107093140.86180-3-roger.pau@citrix.com>
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

On Tue, Jan 07, 2025 at 10:31:40AM +0100, Roger Pau Monne wrote:
> The 'm' parameter used to request auto-allocation of the destination variable
> is not supported on FreeBSD, and as such leads to failures to parse.
> 
> What's more, the current usage of '%ms' with xs_node_scanf() is pointless, as
> it just leads to a double allocation of the same string.  Instead use
> qemu_xen_xs_read() to read the whole xenstore node.
> 
> Fixes: a783f8ad4ec9 ('xen: add a mechanism to automatically create XenDevice-s...')
> Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
>  hw/char/xen_console.c | 11 +++++++++--
>  hw/xen/xen-bus.c      |  7 +++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index af706c7ef440..18afd214c2f6 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -531,6 +531,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
>      const char *name = xen_backend_get_name(backend);
>      unsigned long number;
>      char *fe = NULL, *type = NULL, *output = NULL;
> +    const char *node_path;

Is "const" correct when we are changing to which string `node_path` is
pointing at? Also, why "const"? Also, compiler complains that we can't
free a "const something*".

>      char label[32];
>      XenDevice *xendev = NULL;
>      XenConsole *con;
> @@ -550,7 +551,10 @@ static void xen_console_device_create(XenBackendInstance *backend,
>          goto fail;
>      }
>  
> -    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
> +    node_path = g_strdup_printf("%s/type", fe);
> +    type = qemu_xen_xs_read(xsh, XBT_NULL, node_path, NULL);
> +    g_free(node_path);

I feel like we want "xs_node_read()" which would be similair to
xs_node_vscanf() but would simply return the result of
qemu_xen_xs_read(). This would avoid the need format of the node path in
several place in the code. But it's OK like that as well.

Cheers,

-- 
Anthony PERARD

