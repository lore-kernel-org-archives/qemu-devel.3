Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdLS-0004q9-3Q; Wed, 07 Feb 2024 03:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXdLR-0004pb-53
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXdLP-0008Qe-1c
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707294706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VGiiG97nhIhpcAT1eGncvbp1ia5S0zLJgbLOx6ggnA=;
 b=PFfNZa7UNnopeuSvRxPSDLjaT1qP//ynY217wLfVhivKPRqtz6/Noh9ZoMB1YEpqovOGSM
 1tMuFsGQQUX9lJh64+lVo1nBgsxJCrTXtwmFMZ4yTEHinA7DHfiqCh9DrtLSGHdRm/a99f
 fR5F5q0nxpAS/ok65i5UpmIMjoFoCjU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-cUYmojkANgiIAAMCoagfIw-1; Wed,
 07 Feb 2024 03:31:42 -0500
X-MC-Unique: cUYmojkANgiIAAMCoagfIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAEC81C04B5B;
 Wed,  7 Feb 2024 08:31:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FEF2026D08;
 Wed,  7 Feb 2024 08:31:37 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:31:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, eblake@redhat.com,
 eduardo@habkost.net, fan.ni@samsung.com, farosas@suse.de,
 hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: Re: [PATCH 06/15] qapi: Require member documentation (with loophole)
Message-ID: <ZcM_54CNKzemVb4-@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
 <20240205074709.3613229-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205074709.3613229-7-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 05, 2024 at 08:47:00AM +0100, Markus Armbruster wrote:
> The QAPI generator forces you to document your stuff.  Except for
> command arguments, event data, and members of enum and object types:
> these the generator silently "documents" as "Not documented".
> 
> We can't require proper documentation there without first fixing all
> the offenders.  We've always had too many offenders to pull that off.
> Right now, we have more than 500.  Worse, we seem to fix old ones no
> faster than we add new ones: in the past year, we fixed 22 ones, but
> added 26 new ones.
> 
> To help arrest the backsliding, make missing documentation an error
> unless the command, type, or event is in listed in new pragma
> documentation-exceptions.

If we want to really annoy people we could print a warning to
stderr during docs generation, for each undocumented field.
The many pages  of warnings would likely trigger a much quicker
series to patches to fix it to eliminate the annoying warnings :-)

> 
> List all the current offenders: 117 commands and types in qapi/, and 9
> in qga/.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst                  |   5 +
>  qapi/pragma.json                              | 119 ++++++++++++++++++
>  qga/qapi-schema.json                          |  13 +-
>  scripts/qapi/parser.py                        |   7 +-
>  scripts/qapi/source.py                        |   2 +
>  .../qapi-schema/doc-bad-alternate-member.json |   2 +
>  tests/qapi-schema/doc-good.json               |   4 +-
>  7 files changed, 149 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


