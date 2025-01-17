Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDB3C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYm9Z-0001gb-PH; Fri, 17 Jan 2025 08:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYm9X-0001gS-My
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYm9V-0005Lk-QN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737119564;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bfh3oF4HpqMbRqjdaYVzLaEbmo9Z04aJmAVx0NJ+/WU=;
 b=Mt3Zx5xGdzJIIc/iQEy+Au3W6CBDwBVuowjkVB0iLpazR6lIs0CCKlHchAuuZpP+Fc+3mR
 yrpGUGcdWySb3jMop+un/rslTrSgisZO68COZG0ff5ht6V78tOASYoySmrHmv9U7/3Ztuf
 0ZzBaRojViUqryP74TbOVvpPYK/zTzw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-BNI3640kMJqmGOEdiPaKRQ-1; Fri,
 17 Jan 2025 08:12:41 -0500
X-MC-Unique: BNI3640kMJqmGOEdiPaKRQ-1
X-Mimecast-MFC-AGG-ID: BNI3640kMJqmGOEdiPaKRQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6314C1955BD9; Fri, 17 Jan 2025 13:12:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5298F1955F1B; Fri, 17 Jan 2025 13:12:37 +0000 (UTC)
Date: Fri, 17 Jan 2025 13:12:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v2] checkpatch: Check .m, .build, .hx, .json and .plist
Message-ID: <Z4pXQYHNOMJ_JPjq@redhat.com>
References: <20250111-checkpatch-v2-1-db77a522ab6a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250111-checkpatch-v2-1-db77a522ab6a@daynix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Sat, Jan 11, 2025 at 05:07:48PM +0900, Akihiko Odaki wrote:
> Check more text files: Objective-C, Meson, "hx", JSON, and property
> list.

Objective-C looks sensible at least.

For the others though, I'm wondering if any of the current checks
performed are liable to cause false positives for these files ?


> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 06d07e6c225c..94ac5230b48f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -12,7 +12,7 @@ use Term::ANSIColor qw(:constants);
>  my $P = $0;
>  $P =~ s@.*/@@g;
>  
> -our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
> +our $SrcFile = qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|hx|json|plist)$};
>  
>  my $V = '0.31';
>  
> 
> ---
> base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
> change-id: 20250111-checkpatch-26ea9d86c76a
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


