Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F200ACCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEn1y-0006pD-Fk; Fri, 31 Oct 2025 07:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEn0J-0005s4-3y
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEn09-0005Mp-M1
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761908935;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuKUsLF+5wvSuf9Y1DCuBrqjrmVYGUz4XI8FqPs3GqI=;
 b=CHHE7SVWrENrzK1I5trvjhT8YuuVp1JLuk4V4TYenI1NVU1JcX06pwEUcnArfuUNQqDTQf
 ML/CvGcieYajVUcCtVVXIjc5m9AaJwx18Q8Q+Q6X+Pcl6B7MLNF8S7E6QwOzuD37HOtVcZ
 m51uQl+hlKe+jdNGZgcwHOWY4blK/vU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-tHh3fEIBMECbxgRGUG_sNQ-1; Fri,
 31 Oct 2025 07:08:52 -0400
X-MC-Unique: tHh3fEIBMECbxgRGUG_sNQ-1
X-Mimecast-MFC-AGG-ID: tHh3fEIBMECbxgRGUG_sNQ_1761908931
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E12661956070; Fri, 31 Oct 2025 11:08:50 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D320830001A1; Fri, 31 Oct 2025 11:08:49 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:08:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/checkpatch.pl: remove bogus patch prefix warning
Message-ID: <aQSYvpAuQ4PHG1E8@redhat.com>
References: <20251030201319.858480-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030201319.858480-1-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, Oct 30, 2025 at 11:13:19PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Remove the 'patch prefix exists, appears to be a -p0 patch' warning
> entirely as it is fundamentally flawed and can only produce false
> positives.
> 
> Sometimes I create test files with names 'a' and 'b', and then get
> surprised seeing this warning. It was not easy to understand where it
> comes from.
> 
> How it works:
> 1. It extracts prefixes (a/, b/) from standard diff output
> 2. Checks if files/directories with these names exist in the project
>    root
> 3. Warns if they exist, claiming it's a '-p0 patch' issue
> 
> This logic is wrong because:
> - Standard diff/patch tools always use a/ and b/ prefixes by default
> - The existence of files named 'a' or 'b' in the working directory is
>   completely unrelated to patch format
> - The working directory state may not correspond to the patch content
>   (different commits, branches, etc.)
> - In QEMU project, there are no single-letter files/directories in root,
>   so this check can only generate false positives
> 
> The correct way to detect -p0 patches would be to analyze the path
> format within the patch itself (e.g., absolute paths or paths without
> prefixes), not check filesystem state.
> 
> So, let's finally drop it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/checkpatch.pl | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


