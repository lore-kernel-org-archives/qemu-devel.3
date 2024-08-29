Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D439C71135
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbin-0002CG-SY; Thu, 29 Aug 2024 05:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbiZ-0002A7-LZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjbiV-0007JM-Q9
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724924721;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EyORP3+zF5JtTrp9Y77TbkVN28YSYE6K/fmlbTTg8ko=;
 b=S6qcLcmc+UA7L4npK51dZyiTx7ctZgiiy8Gz3w4bMeqwewVz4NLfjxkMg6uKpD8IjsTwSI
 /zcWRqkFbuvSA2cM6xI9/gIiONm2mr38oqbruRyZlsoKYHp70W8e3ZMyBITsXZh6UynpBJ
 0tTuU3JT7Pp79qplysdFjNBYW3KCZpg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-LfPej-pvMDewwmWjbZ222Q-1; Thu,
 29 Aug 2024 05:45:17 -0400
X-MC-Unique: LfPej-pvMDewwmWjbZ222Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C82711955D45; Thu, 29 Aug 2024 09:45:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD7530001A1; Thu, 29 Aug 2024 09:45:12 +0000 (UTC)
Date: Thu, 29 Aug 2024 10:45:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 04/35] Bump avocado to 103.0
Message-ID: <ZtBDJVk8oh0Nvrwr@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-5-thuth@redhat.com>
 <2b371db2-88c1-4c1f-8f1a-56c0cb6f8dde@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b371db2-88c1-4c1f-8f1a-56c0cb6f8dde@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Aug 21, 2024 at 12:34:45PM +0200, Philippe Mathieu-Daudé wrote:
> On 21/8/24 10:27, Thomas Huth wrote:
> > From: Cleber Rosa <crosa@redhat.com>
> > 
> > This bumps Avocado to latest the LTS release.
> > 
> > An LTS release is one that can receive bugfixes and guarantees
> > stability for a much longer period and has incremental minor releases
> > made.
> > 
> > Even though the 103.0 LTS release is pretty a rewrite of Avocado when
> > compared to 88.1, the behavior of all existing tests under
> > tests/avocado has been extensively tested no regression in behavior
> > was found.
> > 
> > To keep behavior of jobs as close as possible with previous version,
> > this version bump keeps the execution serial (maximum of one task at a
> > time being run).
> > 
> > Reference: https://avocado-framework.readthedocs.io/en/103.0/releases/lts/103_0.html
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > Message-ID: <20240806173119.582857-2-crosa@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   pythondeps.toml        | 2 +-
> >   tests/Makefile.include | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> I suppose we now need an ultra wide monitor and set the terminal
> COLUMNS to a value >= 512 to not make sense of the spaghetti console
> now (my laptop terminal is 48x150 full screen, I might need new
> eyes). (Compare with commit 44055caaa5 description). See for example
> some lines are 267 columns wide:
> 
> $ make check-avocado AVOCADO_TAGS='machine:ppce500 machine:mpc8544ds'

snip

> Anyway I don't mind much and don't ask/expect anyone to fix that.

Hopefully this will just be a temporary downside, if eventually get all
tests converted to the new functional test framework.

> 
> On macOS:
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


