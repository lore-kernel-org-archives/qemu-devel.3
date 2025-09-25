Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D01CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 21:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1tMS-00048n-Ce; Thu, 25 Sep 2025 17:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1tMP-00047Q-B0
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1tMH-0005uo-8e
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758835105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrngkqSuncyw/thZjGcMSR8E6qg1tXb8OHSx0UP1C3U=;
 b=Tmvhz4bGrGGy3DCRz6nZTAFOg1z+AQqYITSqVa7F/EcHfYUigVm0T/eQe2CjkwOfn/waqb
 4yW7HNTMlYtWC8EeBWd1D6sWqFxndas9qVD6h4Gs4H27NG9iAhd/ALo4KB7EW+3x/zYb73
 wHIOo5LyBJo04wx7wsPz1mYyks78ZuE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-s_THKFkHO8aieyo4VOG1Vw-1; Thu,
 25 Sep 2025 17:18:21 -0400
X-MC-Unique: s_THKFkHO8aieyo4VOG1Vw-1
X-Mimecast-MFC-AGG-ID: s_THKFkHO8aieyo4VOG1Vw_1758835099
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35ED519560B2; Thu, 25 Sep 2025 21:18:19 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D8141956095; Thu, 25 Sep 2025 21:18:14 +0000 (UTC)
Date: Thu, 25 Sep 2025 16:18:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 09/23] util: introduce some API docs for logging APIs
Message-ID: <jy2fj4hg7v7dy7eonzp2ur5fbwpsnurxol7iaf3ny2bb5n7ksk@7sblz7mhyx7j>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925094441.1651372-10-berrange@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 25, 2025 at 10:44:27AM +0100, Daniel P. Berrangé wrote:
> This addresses two key gotchas with the logging APIs:
> 
>  * Safely outputting a single line of text using
>    multiple qemu_log() calls requires use of the
>    qemu_log_trylock/unlock functions to avoid
>    interleaving between threads
> 
>  * Directly outputting to the FILE object returned
>    by qemu_log_trylock() must be discouraged because
>    it prevents the inclusion of configured log message
>    prefixes.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> +++ b/include/qemu/log-for-trace.h
> @@ -29,7 +29,40 @@ static inline bool qemu_loglevel_mask(int mask)
>      return (qemu_loglevel & mask) != 0;
>  }
>  
> -/* main logging function */
> +/**
> + * qemu_log: report a log message

> + *
> + * The FILE object returned by qemu_log_trylock() does
> + * not need to be used for outputting text directly,
> + * it is merely used to associate the lock.
> + *
> + *    FILE *f = qemu_log_trylock()
> + *
> + *    qemu_log("Something");
> + *    qemu_log("Something");
> + *    qemu_log("Something");
> + *    qemu_log("The end\n");
> + *
> + *    qemu_log_unlock(f);

Should this example include spaces, as in qemu_log("Something ");, so
that copy-and-paste coding is less likely to
ResultInCompressedSentences across the log calls?

Adjusting a comment is trivial, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


