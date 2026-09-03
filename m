Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62638C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24Sg-0004Vr-Eb; Thu, 03 Sep 2026 06:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24Se-0004Vj-K9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24Sc-0000ok-KV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788430461;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7rhymgnk9AbRjTSee4UU+/OgRhOtkXkex/Gls60TTI=;
 b=U/pc4GJX4LFbcqNjBZrc2JbSJhWOQNOjgMjaTpUPbwVb0x51iOAExw0XLxF1dVXUSKH/CP
 baOlzgT+EBCZxHODb86I4rNrA5db2SOXoeYGxTTenwOym/UhlaYkAPc2/jXlS3xIA0hPrh
 wJyGu6wVelY/RkrUINNKZ/4MM4u9VUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-As3RXAC1NYaZnDwfvyoRdw-1; Thu,
 03 Sep 2026 06:14:19 -0400
X-MC-Unique: As3RXAC1NYaZnDwfvyoRdw-1
X-Mimecast-MFC-AGG-ID: As3RXAC1NYaZnDwfvyoRdw_1788430458
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72CFC185CE9F
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2026 10:14:18 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988A1434; Thu,  3 Sep 2026 10:14:17 +0000 (UTC)
Date: Thu, 3 Sep 2026 11:14:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] checkpatch: reject trailers that credit an AI agent
Message-ID: <aplIdioRiKdK5gqg@redhat.com>
References: <20260903100441.781277-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903100441.781277-1-pbonzini@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 03, 2026 at 12:04:40PM +0200, Paolo Bonzini wrote:
> The QEMU community has broad consent to not accept assisted-by and similar
> trailers, and much less fake co-authored-bys, independent of any AI policy.
> Implement this in checkpatch.pl already, so that there is another way for
> contributors to discover the AI policy.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012..90cb40dfe1f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1811,6 +1811,18 @@ sub process {
>  			}
>  		}
>  
> +# Reject trailers that credit an AI agent.
> +		if ($realfile =~ /^$/ &&
> +		    ($line =~ /🤖/ ||

Oh wow, is that something people actually do :-)

> +		     $line =~ /^\s*(?:Assisted|Generated)-by:/i ||
> +		     ($line =~ /^\s*Co-authored-by:\s*(.*?)\s*$/i &&
> +		      $1 =~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \bcursor\b | \[bot\] |
> +			     \bllama\b | \bgemini\b.*(?:pro|flash|ultra|google\.com) |
> +			     \bclaude\b.*(?:opus|sonnet|fable|haiku|anthropic\.com)/xi))) {

I presume the qualifiers after gemini/claude are a mitigation against
accidentally matching a real person's name ?

> +			ERROR("QEMU does not allow using AI for contributions, " .
> +				"see docs/devel/code-provenance.rst\n" . $herecurr);
> +		}

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


