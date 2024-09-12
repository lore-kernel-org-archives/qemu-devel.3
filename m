Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D8EE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojQS-0000sv-3y; Thu, 12 Sep 2024 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sojQP-0000sE-NL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sojQO-0003Ie-9Q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726145991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LlmaeAHNGjpt2/u+c/R2kLSba/scu1B9WIXZM6TBuVU=;
 b=bUbJrZUzYnqXAN5ZoqvjeUnEdlkEKiZyHeU6Qcam79PEF/P9vbA48ugw+0Pbolr53lLKKw
 HyflI06Ou9Lcu3v2ZBISlGuPLJDAG2wUGtCr9BgMREMZpj5E4630/oEj7fWQlDLWPMCVw8
 Q5Iet9e+oTlUXCDYSYNIZjkW2j1/Pss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-OcD5GgONMM6Kfy-LAPss5w-1; Thu,
 12 Sep 2024 08:59:50 -0400
X-MC-Unique: OcD5GgONMM6Kfy-LAPss5w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87135193EF41; Thu, 12 Sep 2024 12:59:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E5F11956053; Thu, 12 Sep 2024 12:59:47 +0000 (UTC)
Date: Thu, 12 Sep 2024 07:59:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH 2/2] qapi/block-core: Drop drive-backup's "Any other
 error" documentation
Message-ID: <tprkbhy63k2vbzrw34qewvanfnfd6lbusubaozror5ty3ghlpx@rqrg7rrjgugg>
References: <20240911132459.2548063-1-armbru@redhat.com>
 <20240911132459.2548063-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911132459.2548063-3-armbru@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 03:24:59PM GMT, Markus Armbruster wrote:
> We've always been rather lax about documenting errors.  Many "Errors"
> sections are obviously not exhaustive.  Only drive-backup is explicit
> about this: "Any other error returns a GenericError".
> 
> Not useful.  Drop.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 82f59a7758..485388be32 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1853,7 +1853,6 @@
>  #
>  # Errors:
>  #     - If @device does not exist, DeviceNotFound
> -#     - Any other error returns a GenericError.
>  #
>  # Since: 1.3
>  #
> -- 
> 2.46.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


