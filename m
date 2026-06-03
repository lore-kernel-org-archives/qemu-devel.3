Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1110BCD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUiGS-0002AF-3p; Wed, 03 Jun 2026 05:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUiGQ-0002A0-5r
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUiGO-0008M4-SC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780480311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhvYFFg1Nr9EdfYJPNMhPgpDaNqgYUuZWzCVNcJrWfo=;
 b=gTDkMSPehoypPmcTW+3mouoPcVRnwCSFGiIL9Ywl942FsWPRu/d5lXNWirHktchhxiz95C
 +cmYhiVUiT8TpwbdHNPIIOsI0elCOLk6EcMoynNz49z+xa0teskLQ7TxxDSZp9hoqFO9yb
 ALYo88PzTfVJ7d68WRGOOYrArUPhPZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-R9GSO8pxOV6P69SFhIhxxQ-1; Wed,
 03 Jun 2026 05:51:46 -0400
X-MC-Unique: R9GSO8pxOV6P69SFhIhxxQ-1
X-Mimecast-MFC-AGG-ID: R9GSO8pxOV6P69SFhIhxxQ_1780480305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9117C180064A; Wed,  3 Jun 2026 09:51:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0B6B30001A1; Wed,  3 Jun 2026 09:51:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EEF621E6A01; Wed, 03 Jun 2026 11:51:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Li-Wen
 Hsu <lwhsu@freebsd.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@mailo.com>,  Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: remove stale Cirrus macOS build job path
In-Reply-To: <20260602162457.828969-4-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Tue, 2 Jun 2026 12:24:56 -0400")
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-4-stefanha@redhat.com>
Date: Wed, 03 Jun 2026 11:51:41 +0200
Message-ID: <87mrxckl3m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Commit 984b192bdf37 ("ci: drop cirrus MacOS build") removed the Cirrus
> macOS build job. The MAINTAINERS file now contains a stale path that
> should be removed.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff33eb630..0c0c8c0a37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -701,7 +701,6 @@ F: scripts/nsis.py
>  Darwin (macOS, iOS)
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
> -F: .gitlab-ci.d/cirrus/macos-*

We also need

  +F: .gitlab-ci.d/macos*

>  F: */*.m
>  F: scripts/entitlement.sh

I posted this as

    Subject: [PATCH v2 10/38] MAINTAINERS: Fix F: in "Darwin (macOS, iOS)"
    Date: Wed, 3 Jun 2026 08:40:04 +0200
    Message-ID: <20260603064032.3733394-11-armbru@redhat.com>

I wasn't aware of your patch until Philippe pointed it out to me in his
review of mine.


