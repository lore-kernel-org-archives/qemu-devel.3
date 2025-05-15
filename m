Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81606C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 11:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFWUR-00052F-AT; Thu, 15 May 2025 07:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFWUO-00050C-CI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFWUM-0005RF-4J
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747307454;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqpqjSH0LjXlJc0cxJbaoqO9mmRsjJbyvub59brdBSU=;
 b=UMDHV2qMh8szvIy0P5dzTEbEuo6SKrMUQKrTAPUMh//YyV4HgVVSSEi5keqX+EXjc1FgqW
 RzP79OJI29pIyW0V0voXWpgywmHrMILiVz7Tqd0BLnkQe6YJhxZfIcwxGK7sq85hwaRkRz
 +N0AtTBwV2tIE9SrxMkE9hyrmN4hLj8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-0eQwV75APga9dkwD-8NcmQ-1; Thu,
 15 May 2025 07:10:51 -0400
X-MC-Unique: 0eQwV75APga9dkwD-8NcmQ-1
X-Mimecast-MFC-AGG-ID: 0eQwV75APga9dkwD-8NcmQ_1747307450
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C726F1800871; Thu, 15 May 2025 11:10:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 732F41956094; Thu, 15 May 2025 11:10:48 +0000 (UTC)
Date: Thu, 15 May 2025 12:10:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 7/7] scripts/checkpatch: reimplement mandate for
 SPDX-License-Identifier
Message-ID: <aCXLtD3QiioqKFyE@redhat.com>
References: <20250512182447.1139105-1-berrange@redhat.com>
 <20250512182447.1139105-8-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512182447.1139105-8-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 12, 2025 at 07:24:47PM +0100, Daniel P. Berrangé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Going forward we want all newly created source files to have an
> SPDX-License-Identifier tag present.
> 
> Initially mandate this for C, Python, Perl, Shell source files,
> as well as JSON (QAPI) and Makefiles, while encouraging users
> to consider it for other file types.
> 
> The new attempt at detecting missing SPDX-License-Identifier relies
> on the hooks for relying triggering logic at the end of scanning a
> new file in the diff.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d416a6dcf9..95609ca010 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1482,6 +1482,20 @@ sub process_start_of_file {
>  # Called at the end of processing a diff hunk for a file
>  sub process_end_of_file {
>  	my $fileinfo = shift;
> +
> +	if ($fileinfo->{action} eq "new" &&
> +	    !exists $fileinfo->{facts}->{sawspdx}) {
> +		if ($fileinfo->{filenew} =~
> +		    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {

Slight tweak needed here as 'Makefile' is a filename base
not an extension:

                /(\.(c|h|py|pl|sh|json|inc)|Makefile.*)$/) {


> +			# source code files MUST have SPDX license declared
> +			ERROR("New file '" . $fileinfo->{filenew} .
> +			      "' requires 'SPDX-License-Identifier'");
> +		} else {
> +			# Other files MAY have SPDX license if appropriate
> +			WARN("Does new file '" . $fileinfo->{filenew} .
> +			     "' need 'SPDX-License-Identifier'?");
> +		}
> +	}
>  }
>  
>  sub process {
> @@ -1780,6 +1794,7 @@ sub process {
>  
>  # Check SPDX-License-Identifier references a permitted license
>  		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
> +			$fileinfo->{facts}->{sawspdx} = 1;
>  			&checkspdx($realfile, $1);
>  		}
>  
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


