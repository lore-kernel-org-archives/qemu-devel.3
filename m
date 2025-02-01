Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F3C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 10:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teAvn-00054b-RE; Sat, 01 Feb 2025 05:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1teAvm-00054Q-Au
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 05:40:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1teAvk-0005A3-Tz
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 05:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738406450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=moJ//3piSwwac4eb7uId50fYmcgBfoxy4mkB5GiCLCA=;
 b=I6FnTeJk1Z48ycgG7/fchoRQcxy6MA6saHxgkuw7VrNMdOIB4HyH1Y4DErTT+Ym4tGRZd/
 Ei2fcLl1tIplT4SXqITXhai8HYoQo++UaLhn3rplkujkjSosYY6pLUBEWkpWN0rt0chsO7
 uPXFZOpb8bIa0ZDf2VQX7nkDZoz3R3Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-6TstWoYgNdepe3LZanbxvg-1; Sat,
 01 Feb 2025 05:40:49 -0500
X-MC-Unique: 6TstWoYgNdepe3LZanbxvg-1
X-Mimecast-MFC-AGG-ID: 6TstWoYgNdepe3LZanbxvg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 378181956080; Sat,  1 Feb 2025 10:40:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B87A61800975; Sat,  1 Feb 2025 10:40:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B010121E6A28; Sat, 01 Feb 2025 11:40:45 +0100 (CET)
Resent-To: alex.bennee@linaro.org, gustavo.romero@linaro.org,
 philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sat, 01 Feb 2025 11:40:45 +0100
Resent-Message-ID: <87frkyj6c2.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 0/2] Add me as the maintainer for ivshmem-pci
In-Reply-To: <f16985e1-ecc5-4439-ba4c-f9a6a4d06d10@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 31 Jan 2025 19:33:59
 +0100")
References: <20250123012212.716499-1-gustavo.romero@linaro.org>
 <35e2dcf5-d1d6-4326-90cb-22dc82023bed@linaro.org>
 <f16985e1-ecc5-4439-ba4c-f9a6a4d06d10@linaro.org>
Date: Sat, 01 Feb 2025 08:08:38 +0100
Message-ID: <87seoyjg5l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 24/1/25 17:22, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 23/1/25 02:22, Gustavo Romero wrote:
>>> Add me as the maintainer for the ivshmem-pci.c device, the ivshmem
>>> server, and the ivshmem client tool. Also, adjust remaining parts left
>>> behind after ivshmem PCI device was renamed from ivshmem.c to
>>> ivshmem-pci.c, like header files, Kconfig, docs, and build scripts.
>>>
>>>
>>> Cheers,
>>> Gustavo
>>>
>>> Gustavo Romero (2):
>>> =C2=A0=C2=A0 hw/misc/ivshmem-pci: Rename remaining parts for consistency
>>> =C2=A0=C2=A0 MAINTAINERS: Add me as the maintainer for ivshmem-pci
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> and queued, thanks for volunteering!
>
> Failing to build:
>
> docs/specs/ivshmem-spec.rst:17:unknown document: '../system/devices/ivshm=
em'
> ninja: build stopped: subcommand failed.
>
> docs/specs/ivshmem-spec.rst only mention PCI, so I could squash in the
> first patch:
> -- >8 --
> diff --git a/docs/specs/ivshmem-spec.rst b/docs/specs/ivshmem-spec.rst
> index 2d8e80055b0..e326d024487 100644
> --- a/docs/specs/ivshmem-spec.rst
> +++ b/docs/specs/ivshmem-spec.rst
> @@ -17,3 +17,3 @@ get interrupted by its peers.
>  For information on configuring the ivshmem device on the QEMU
> -command line, see :doc:`../system/devices/ivshmem`.
> +command line, see :doc:`../system/devices/ivshmem-pci`.
> ---
> But then I wonder if this document shouldn't mention the flat
> device. Since I'm unsure I'm dropping the series (patch 2
> depends on 1).

Simple oversight in PATCH 1.  It renames docs/system/devices/ivshmem.rst
to docs/system/devices/ivshmem-pci.rst without updating the reference in
docs/specs/ivshmem-spec.rst.

Surprisingly, this didn't fail for me in an incremental build, only in a
full one.


