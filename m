Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B15CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 05:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPZoa-00016y-8F; Wed, 20 May 2026 01:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPZoL-00012s-JM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPZoI-0002Wl-MV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779256177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+Lj+YmRxdra409msIlD/8r1AmpqU0NaR/kdmKFmbfI=;
 b=G1cwZU6ggmc0IUvxA5OOrenj6fwMO8Lnp5+txHLAhzWL37+3rCSUvVmD2GoUPifjhbPxYU
 LxNR9d+bRIv3akJBPaCq/HvIA1UahLXS76p34LE/30sGIr6D4DFWz0eBgx5sEIPLNgHfVg
 scvq4xuJqAsPLFTz3FkzRfE39FnT5o4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-7vKp9EfWMbu4xZUt7Xwp3w-1; Wed,
 20 May 2026 01:49:33 -0400
X-MC-Unique: 7vKp9EfWMbu4xZUt7Xwp3w-1
X-Mimecast-MFC-AGG-ID: 7vKp9EfWMbu4xZUt7Xwp3w_1779256172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 724DD1956046; Wed, 20 May 2026 05:49:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04E5730001A2; Wed, 20 May 2026 05:49:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 942F821E6A01; Wed, 20 May 2026 07:49:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Yuri Benditovich <ybendito@redhat.com>,  Andrew
 Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Yuri Benditovich bouncing email
In-Reply-To: <20260513072703.9710-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 13 May 2026 09:27:03
 +0200")
References: <20260513072703.9710-1-philmd@linaro.org>
Date: Wed, 20 May 2026 07:49:29 +0200
Message-ID: <87y0he1vh2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

>  Final-Recipient: rfc822; yuri.benditovich@daynix.com
>  Action: failed
>  Status: 5.1.1
>  Diagnostic-Code: smtp; 550-5.1.1 The email account that you tried to rea=
ch does not exist. Please try
>   550-5.1.1 double-checking the recipient's email address for typos or
>   550-5.1.1 unnecessary spaces. For more information, go to
>   550 5.1.1  https://support.google.com/mail/?p=3DNoSuchUser ffacd0b85a97=
d-45c62bf01dbsor217235f8f.7 - gsmtp
>  Last-Attempt-Date: Wed, 13 May 2026 00:02:47 -0700 (PDT)
>
> Cc: Yuri Benditovich <ybendito@redhat.com>
> Cc: Andrew Melnychenko <andrew@daynix.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0790d13505c..64849c6e866 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4487,7 +4487,6 @@ F: tests/functional/x86_64/test_vfio_user_client.py
>  EBPF:
>  M: Jason Wang <jasowang@redhat.com>
>  R: Andrew Melnychenko <andrew@daynix.com>
> -R: Yuri Benditovich <yuri.benditovich@daynix.com>
>  S: Maintained
>  F: docs/devel/ebpf_rss.rst
>  F: ebpf/*

Yuri posted a fix some time ago, but it fell through the cracks:

    Subject: [PATCH] MAINTAINERS: update ebpf reviewers
    Date: Sat,  6 Dec 2025 11:33:45 +0200
    Message-ID: <20251206093345.71031-1-ybendito@redhat.com>
    https://lore.kernel.org/qemu-devel/20251206093345.71031-1-ybendito@redh=
at.com/

I'll pick it up.

Thanks!


