Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25C2E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPxE-0002Yf-E2; Wed, 08 Jan 2025 01:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1tVPxC-0002YM-Pp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:54:10 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1tVPxB-0001kk-9b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:54:10 -0500
Received: from blackfin.pond.sub.org (p50902029.dip0.t-ipconnect.de
 [80.144.32.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 43BEF20DCF
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:09:16 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3EA9121E6924; Wed, 08 Jan 2025 07:54:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi: fix colon in Since tag section
In-Reply-To: <20241217091504.16416-1-victortoso@redhat.com> (Victor Toso's
 message of "Tue, 17 Dec 2024 10:15:04 +0100")
References: <20241217091504.16416-1-victortoso@redhat.com>
Date: Wed, 08 Jan 2025 07:54:03 +0100
Message-ID: <87jzb523uc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.24, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Victor Toso <victortoso@redhat.com> writes:

> As described in docs/devel/qapi-code-gen.rst line 998,
> there should be no space between "Since" and ":".
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  qapi/cxl.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 9f65589bce..dd947d3bbc 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -460,7 +460,7 @@
>  #
>  # @unstable: For now this command is subject to change.
>  #
> -# Since : 9.1
> +# Since: 9.1
>  ##
>  { 'command': 'cxl-add-dynamic-capacity',
>    'data': { 'path': 'str',
> @@ -539,7 +539,7 @@
>  #
>  # @unstable: For now this command is subject to change.
>  #
> -# Since : 9.1
> +# Since: 9.1
>  ##
>  { 'command': 'cxl-release-dynamic-capacity',
>    'data': { 'path': 'str',

Reviewed-by: Markus Armbruster <armbru@redhat.com>

and queued, thanks!

