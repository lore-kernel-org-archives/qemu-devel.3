Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69889D41179
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMI6-0007dk-T4; Thu, 15 Jan 2026 07:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgMHx-0007ZG-4z
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgMHv-0002mc-Ms
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768479438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mEyco97y7xLAKjpCbUq6LZerY9xRgjRXfd1IPc2+DE=;
 b=bwhs43tj+1ok9WnyWFn+RRdXN8UgjlKWZq5JHeuVQ8834R/uIU7MgTbDsDFgibenO5lLZr
 RjK8d3Sh1vXhHjA8Zg/afUNVdZi9efeN9er6ypcl9rVMxfvoGz9NR4JnZuM8V/2bENeI/n
 EVVr/qp2Mi5kLd09WUXhZotbxSxRsXE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-DSMav7AePdiB-ieZHujpxg-1; Thu,
 15 Jan 2026 07:17:15 -0500
X-MC-Unique: DSMav7AePdiB-ieZHujpxg-1
X-Mimecast-MFC-AGG-ID: DSMav7AePdiB-ieZHujpxg_1768479434
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9222619560A3; Thu, 15 Jan 2026 12:17:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 238AB3001DB5; Thu, 15 Jan 2026 12:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9872321E692D; Thu, 15 Jan 2026 13:17:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: dave@treblig.org
Cc: berrange@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hxtool: Error on missing docs
In-Reply-To: <20260115020423.722069-5-dave@treblig.org> (dave@treblig.org's
 message of "Thu, 15 Jan 2026 02:04:23 +0000")
References: <20260115020423.722069-1-dave@treblig.org>
 <20260115020423.722069-5-dave@treblig.org>
Date: Thu, 15 Jan 2026 13:17:11 +0100
Message-ID: <87tswnvznc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> Error if a '.name' is seen after another '.name' without an intervening
> SRST, this normally indicates missing or misplaced docs.
>
> We can't check DEF (as used in command line options) because those
> often have multiple DEF per doc.

Pity.

> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  scripts/hxtool | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/hxtool b/scripts/hxtool
> index ea2accef98..f310071daa 100755
> --- a/scripts/hxtool
> +++ b/scripts/hxtool
> @@ -1,8 +1,14 @@
>  #!/bin/sh
>  
> +printifnotrst()

print_if_not_rst()?  print_h()?

> +{
> +    test $outsiderst -eq 1 && printf "%s\n" "$str"
> +}
>  hxtoh()
>  {
>      outsiderst=1
> +    # .name for HMP
> +    seenname=0

I'd prefer seen_name.

>      while read -r str; do
>          case $str in
>              HXCOMM*)
> @@ -13,6 +19,8 @@ hxtoh()
>                  echo "Error: SRST inside another RST" >&2
>                  exit 1
>                fi
> +              # consume the name
> +              seenname=0
>                outsiderst=0
>              ;;
>              ERST*)
> @@ -23,8 +31,18 @@ hxtoh()
>                fi
>                outsiderst=1
>              ;;
> +            # Note the space at the start - we need to exclude something.name
> +             .name*)

This works?!?  It does in my testing.  I'm amazed.

> +              if [ $seenname -eq 1 ]
> +              then
> +                echo "Error: Seen another .name, maybe missing docs?" >&2
> +                exit 1
> +              fi
> +              seenname=1
> +              printifnotrst
> +            ;;
>              *)
> -            test $outsiderst -eq 1 && printf "%s\n" "$str"
> +            printifnotrst
>              ;;
>          esac
>      done

Could move the printing behind the case, and continue the loop in the
case SRST* and ERST*.  No need for the function then.  Matter of taste,
up to you.


