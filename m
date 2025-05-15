Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36645C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 11:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFX9r-0001RA-03; Thu, 15 May 2025 07:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFX9o-0001Qw-La
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFX9n-0001mX-0L
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747310022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5NqMkAIcIAL6YPzapGWpEHO26UQ67eH2SjqS1drOwo=;
 b=OivkUAjweARFJ8mJmJZRSc2zdulR4HwU8P6O+fW0VvicSy2/BJih0Y0WoENNzyksdNyT6N
 KSEkTHH8B0RAk7I1nh8ltPFnmxchLgIiwiHWQCukmcOgXwefbzjgcZ6/27oAl3s+K0LCD7
 ZMOzR8B3/XtYjsQ58/YchJky07gPQDk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-CA7Ay90TNqmQ5jAOvkYZIg-1; Thu,
 15 May 2025 07:53:39 -0400
X-MC-Unique: CA7Ay90TNqmQ5jAOvkYZIg-1
X-Mimecast-MFC-AGG-ID: CA7Ay90TNqmQ5jAOvkYZIg_1747310018
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A60719560A1; Thu, 15 May 2025 11:53:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0D6619560AD; Thu, 15 May 2025 11:53:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CE9921E66E3; Thu, 15 May 2025 13:53:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 devel@daynix.com,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/3] docs: Bump sphinx to 6.2.1
In-Reply-To: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com> (Akihiko Odaki's
 message of "Sat, 10 May 2025 15:16:53 +0900")
References: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
Date: Thu, 15 May 2025 13:53:35 +0200
Message-ID: <87plga2ips.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Supersedes: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
> ("[PATCH 0/2] docs: Bump sphinx to 8.2.3")
>
> sphinx 5.3.0 fails with Python 3.13.1:
>
> ../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
> Extension error:
> Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')
>
> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme
>
> Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new
> sphinx version.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Works fine for me on a Fedora 41 box (Sphinx 7.3.8)

Tested-by: Markus Armbruster <armbru@redhat.com>


