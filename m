Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEADAC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1Ja-0002J9-Gl; Wed, 17 Jul 2024 05:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sU1JX-0002Cu-TF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sU1JR-0001hd-Ub
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721209864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uAg5TjLXaiLFarObFOsQF0xtXQb0N9FabnJOYTdItzg=;
 b=hsnNpd1nA0eqbxLr2GIZ2ntgili+k1C+eTZ7cOXs4laEmbFrsAVN5SBebFr5IxO0L5onL/
 zYvWy3Hc4DdaUVD3rpIEK0BEO9dywKhsAuNdQXddcfPRDUNSkZ4EFwNV+/ABw0JJbjZU7Z
 wYIWjpHvWJPWNA0vHUWN29QXmfN4WO4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Q4a0tpwHPdO9u_cyQ_Zi7A-1; Wed,
 17 Jul 2024 05:50:59 -0400
X-MC-Unique: Q4a0tpwHPdO9u_cyQ_Zi7A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49E5919560B4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 09:50:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 879E91955D42; Wed, 17 Jul 2024 09:50:55 +0000 (UTC)
Date: Wed, 17 Jul 2024 10:50:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com
Subject: Re: [PATCH] scripts/checkpatch: emit a warning if an imported file
 is touched
Message-ID: <ZpeT-85-AnNidaNC@redhat.com>
References: <20240717093752.50595-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717093752.50595-1-sgarzare@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 17, 2024 at 11:37:52AM +0200, Stefano Garzarella wrote:
> If a file imported from Linux is touched, emit a warning and suggest
> using scripts/update-linux-headers.sh
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  scripts/checkpatch.pl | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ff373a7083..b0e8266fa2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1374,6 +1374,7 @@ sub process {
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $reported_maintainer_file = 0;
> +	my $reported_imported_file = 0;
>  	my $non_utf8_charset = 0;
>  
>  	our @report = ();
> @@ -1673,8 +1674,17 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =~ /^-/);
>  
> -# ignore files that are being periodically imported from Linux
> -		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
> +# ignore files that are being periodically imported from Linux and emit a warning
> +		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
> +			if (!$reported_imported_file) {
> +				$reported_imported_file = 1;
> +				WARN("added, moved or deleted file(s) " .
> +				     "imported from Linux, are you using " .
> +				     "scripts/update-linux-headers.sh?\n" .
> +				     $herecurr);

This is a good hint, but can we add a further check that is a fatal error,
if the headers are changed in the same commit as non-header changes. When
importing headers, they should only ever be in a self-contained patch
with nothing else touched.

> +			}
> +			next;
> +		}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


