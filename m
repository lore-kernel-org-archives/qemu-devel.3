Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2A8C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjEW-0006L8-EV; Tue, 30 Jan 2024 03:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUjEU-0006Ky-Pm
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUjEO-00018G-47
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706602351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUP2JljS6FOQZiqW1SxyIHFKp8/4cL1yUaoKE1AMXyw=;
 b=H1UdedOywD6vdElq5xaBUrZXmqXiDiWj8kjaWXhW2M7DqfxzH8p8BTXamy5kREMyVP0UoK
 f/gAwXZasTQUuSa5JmlPVA140m33Z+uGhM3k3csfnz5NOvExUXPbdxb9jqLA1C1TlOMhyb
 tHnGgtTq6P6QreKUAe0DNXBm2SOGmg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-dNuU_G7sOB-uZNd9mqZJqA-1; Tue, 30 Jan 2024 03:12:29 -0500
X-MC-Unique: dNuU_G7sOB-uZNd9mqZJqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07701185A782;
 Tue, 30 Jan 2024 08:12:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA07340C122E;
 Tue, 30 Jan 2024 08:12:27 +0000 (UTC)
Date: Tue, 30 Jan 2024 08:12:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1] scripts/checkpatch.pl: check for placeholders in
 cover letter patches
Message-ID: <ZbivaYQ1rC6AgHbU@redhat.com>
References: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 09:56:15AM +0200, Manos Pitsidianakis wrote:
> Check if a file argument is a cover letter patch produced by
> git-format-patch --cover-letter; It is initialized with subject suffix "
> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> exist, warn the user.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  scripts/checkpatch.pl | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7026895074..34f12c9848 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1650,6 +1650,20 @@ sub process {
>  			$non_utf8_charset = 1;
>  		}
>  
> +# Check if this is a cover letter patch produced by git-format-patch
> +# --cover-letter; It is initialized with subject suffix
> +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
> +		if ($in_header_lines &&
> +		    $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
> +        WARN("Patch appears to be a cover letter with uninitialized subject" .
> +             " '*** SUBJECT HERE ***'\n$hereline\n");
> +		}
> +
> +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
> +        WARN("Patch appears to be a cover letter with leftover placeholder " .
> +             "text '*** BLURB HERE ***'\n$hereline\n");
> +		}

Indentation here is totally off

> +
>  		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
>  		    $rawline =~ /$NON_ASCII_UTF8/) {
>  			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
> 
> base-commit: 11be70677c70fdccd452a3233653949b79e97908
> -- 
> γαῖα πυρί μιχθήτω
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


