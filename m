Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F0C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTui-0001xI-O4; Wed, 26 Mar 2025 12:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txTue-0001wu-2v
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txTuc-0006v9-Aw
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743007648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1KUk7x98FtWWrAmK8I0Soo44pS23TmyqbhFHljuhj+4=;
 b=Swpwzx9/N3pnpbg6/X1UmCduumS8xQFYlH4+EdpxiNB6PcUGzB+Dl6wvguLG4Y3tSrBu5c
 PAS0/S2HsYXnUxiOybjYyzbZw9K2H24Ri7vEUBbYx0BkCIGErrlF9g+/n1RC1x5Ns4KU7u
 0dnyxq6QupICIv6PcK2D9GO7DkZll9U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-SSdqDKYuPVmH9_TTs_fDew-1; Wed,
 26 Mar 2025 12:47:25 -0400
X-MC-Unique: SSdqDKYuPVmH9_TTs_fDew-1
X-Mimecast-MFC-AGG-ID: SSdqDKYuPVmH9_TTs_fDew_1743007644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAC6C1801A12; Wed, 26 Mar 2025 16:47:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EA9C180B486; Wed, 26 Mar 2025 16:47:21 +0000 (UTC)
Date: Wed, 26 Mar 2025 16:47:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Valentin David <valentin.david@gmail.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Valentin David <valentin.david@canonical.com>
Subject: Re: [PATCH] hw/smbios/smbios.c: Add missing NUL terminal to string
 from path= parameter
Message-ID: <Z-QvlvtsCErUo7_M@redhat.com>
References: <20250326155254.2273939-1-valentin.david@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326155254.2273939-1-valentin.david@canonical.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 26, 2025 at 04:52:54PM +0100, Valentin David wrote:
> Without it, it seems the data gets garbage at the end of the string.
> 
> Signed-off-by: Valentin David <valentin.david@canonical.com>
> ---
>  hw/smbios/smbios.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 02a09eb9cd..7522e9a172 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1283,6 +1283,7 @@ static int save_opt_one(void *opaque,
>                  return -1;
>              }
>              g_byte_array_append(data, (guint8 *)buf, ret);
> +            g_byte_array_append(data, (guint8 *)"\0", 1);

That is inside the loop body, so it is appending an extra '\0' after
every 'read'.

The fix for this issue is posted here

https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg05826.html

>          }
>  
>          qemu_close(fd);


> -- 
> 2.48.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


