Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE29EC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2es-0001H2-Jx; Mon, 16 Jun 2025 01:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR2ei-0001Ca-Sp
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR2eg-0007qU-9q
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750052712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qwff3nWQXvSMruSgJmawrDVwQHKyN42/EoGomjHhuyc=;
 b=SGKifuXSN+rtStpKrbIIZa+TmBoaIWgf42mLYM2RXiba4+6bsf6alm54Vnmj+rx8czYql8
 SPCDsazR84Mp816qv1g+gXTYlFMgnZeiU3y0osaVwAg4wd3zyQ2Cn68dYCipknvJRCoWXu
 kbagJvras8+2DsPIuos3F15pU0BJ+ds=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-Ehg6MLWBPem2DlQ5H3Ov2g-1; Mon,
 16 Jun 2025 01:45:10 -0400
X-MC-Unique: Ehg6MLWBPem2DlQ5H3Ov2g-1
X-Mimecast-MFC-AGG-ID: Ehg6MLWBPem2DlQ5H3Ov2g_1750052709
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBBB719560A7; Mon, 16 Jun 2025 05:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402381956094; Mon, 16 Jun 2025 05:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AED6F21E6A27; Mon, 16 Jun 2025 07:45:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs: remove repeated word
In-Reply-To: <20250615143353.5542-1-algonell@gmail.com> (Andrew Kreimer's
 message of "Sun, 15 Jun 2025 17:33:03 +0300")
References: <20250615143353.5542-1-algonell@gmail.com>
Date: Mon, 16 Jun 2025 07:45:05 +0200
Message-ID: <87jz5cw87y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Cc: qemu-trivial

Andrew Kreimer <algonell@gmail.com> writes:

> The word 'find' appears twice, remove the extra one.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  docs/system/introduction.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
> index 338d3745c3..4cd46b5b8f 100644
> --- a/docs/system/introduction.rst
> +++ b/docs/system/introduction.rst
> @@ -81,7 +81,7 @@ may not be optimal for modern systems.
>  
>  For a non-x86 system where we emulate a broad range of machine types,
>  the command lines are generally more explicit in defining the machine
> -and boot behaviour. You will find often find example command lines in
> +and boot behaviour. You will often find example command lines in
>  the :ref:`system-targets-ref` section of the manual.
>  
>  While the project doesn't want to discourage users from using the

Reviewed-by: Markus Armbruster <armbru@redhat.com>


