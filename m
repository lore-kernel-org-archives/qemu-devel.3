Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFCECA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLBV-0002ca-6I; Tue, 19 Aug 2025 08:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoLBP-0002b3-2i
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoLBM-0004ju-ME
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755605475;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BIqwWA2YEFREd1cyxL8cQwTV6HTOXZUWeCqGsi+OwXc=;
 b=Wwu05/LEwWctlGfPcju8If8N8fqfpJhlqw+m1pqpo4w8UpGfqp80ojrodn3ga3NeILuWZZ
 SuXdH4JEAqDDe5hWilsJxet/k0NkDoq70LXSkh6EFJl1HeGwDECp6Qb/qgLU1PhDnpZSzz
 Tu1+SsofbROELlq1STSbch9GMniOV+M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-0BgR1L4NOLidEFofzxCunw-1; Tue,
 19 Aug 2025 08:11:13 -0400
X-MC-Unique: 0BgR1L4NOLidEFofzxCunw-1
X-Mimecast-MFC-AGG-ID: 0BgR1L4NOLidEFofzxCunw_1755605472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96A90180034F; Tue, 19 Aug 2025 12:11:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57BC630001A8; Tue, 19 Aug 2025 12:11:11 +0000 (UTC)
Date: Tue, 19 Aug 2025 13:11:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] scripts/kernel-doc: Avoid new Perl precedence warning
Message-ID: <aKRp22i5RhqZKGkt@redhat.com>
References: <20250819115648.2125709-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819115648.2125709-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 12:56:48PM +0100, Peter Maydell wrote:
> Newer versions of Perl (5.41.x and up) emit a warning for code in
> kernel-doc:
>  Possible precedence problem between ! and pattern match (m//) at /scripts/kernel-doc line 1597.
> 
> This is because the code does:
>             if (!$param =~ /\w\.\.\.$/) {
> 
> In Perl, the !  operator has higher precedence than the =~
> pattern-match binding, so the effect of this condition is to first
> logically-negate the string $param into a true-or-false value and
> then try to pattern match it against the regex, which in this case
> will always fail.  This is almost certainly not what the author
> intended.
> 
> In the new Python version of kernel-doc in the Linux kernel,
> the equivalent code is written:
> 
>             if KernRe(r'\w\.\.\.$').search(param):
>                 # For named variable parameters of the form `x...`,
>                 # remove the dots
>                 param = param[:-3]
>             else:
>                 # Handles unnamed variable parameters
>                 param = "..."
> 
> which is a more sensible way of writing the behaviour you would
> get if you put in brackets to make the regex match first and
> then negate the result.
> 
> Take this as the intended behaviour, and update the Perl to match.
> 
> For QEMU, this produces no change in output, presumably because we
> never used the "unnamed variable parameters" syntax.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This obviously will clash with the "import the python script"
> patchseries, but I figured it was worth providing the minimal
> fix for the benefit of stable backports.
> 
> The kernel's copy of kernel-doc.pl still has this bug.
> ---
>  scripts/kernel-doc | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index fec83f53eda..117ec8fcd1f 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1594,13 +1594,12 @@ sub push_parameter($$$$$) {
>  
>  	if ($type eq "" && $param =~ /\.\.\.$/)
>  	{
> -	    if (!$param =~ /\w\.\.\.$/) {

I think it would be possible to change this only line to
collapse the ! and =~ into the !~ operator:

    if ($param !~ /\w\.\.\.$/) {


> -	      # handles unnamed variable parameters
> -	      $param = "...";
> -	    }
> -	    elsif ($param =~ /\w\.\.\.$/) {
> +	    if ($param =~ /\w\.\.\.$/) {
>  	      # for named variable parameters of the form `x...`, remove the dots
>  	      $param =~ s/\.\.\.$//;
> +	    } else {
> +	      # handles unnamed variable parameters
> +	      $param = "...";
>  	    }
>  	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq "") {
>  		$parameterdescs{$param} = "variable arguments";
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


