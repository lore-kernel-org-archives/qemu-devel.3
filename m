Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97C0C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRmN-0001Ka-B0; Tue, 20 Feb 2024 10:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRmL-0001K2-8q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcRmJ-0004Om-L7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708441886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDX6r7uEnbWmW6+G8ibmjkZE4BLLdSAH75Ap0zCNylk=;
 b=aZHtV6QVl/4Wwh5Nkg7gxAPXwh39Bi4Z19MakFZ+FBYDodE4eu9+B/csrSp8zepzM49jGB
 3x+0xPnCKr61pZIfPKaj+83xhd/fUSz+l2vm2wvzuo3ojQtNBfusuPn6bPQyUPFiLJw6Ud
 2Jhv5s+EGgL3iMhZgo0qpbfuRUUg8yo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-LWYLRThqNByD0vZ9JPpuxw-1; Tue,
 20 Feb 2024 10:11:23 -0500
X-MC-Unique: LWYLRThqNByD0vZ9JPpuxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3049280A9A3;
 Tue, 20 Feb 2024 15:11:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3AB1121312;
 Tue, 20 Feb 2024 15:11:21 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:11:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com,
 eblake@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH 01/16] tests/qapi-schema: Fix test 'QAPI rST doc'
Message-ID: <ZdTBGLCuLMrFJDGy@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
 <20240216145841.2099240-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216145841.2099240-2-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 03:58:25PM +0100, Markus Armbruster wrote:
> The test compares Sphinx plain-text output against a golden reference.
> To work on Windows hosts, it filters out carriage returns in both
> files.  Unfortunately, the filter doesn't work: it creates an empty
> file.  Comparing empty files always succeeds.

lol, opps :)

> 
> Fix the filter, and update the golden reference to current Sphinx
> output.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/qapi-schema/doc-good.txt | 21 +++++++++------------
>  tests/qapi-schema/meson.build  | 10 ++++++----
>  2 files changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


