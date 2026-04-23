Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A33F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFunP-0001T6-BD; Thu, 23 Apr 2026 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFunH-0001Rk-8N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFunF-0004Cl-FL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776953556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6C/0B8cU/0IwcODdLMB0bDBMYQXNPT63q6maXaMZI3k=;
 b=aw3rK+MgbM3B8Uwfn+FjLh3tbPsqouQHPYdbt04OVPBoYaiyvuYMpBYCMXj8SshgAhiS/+
 /spTTpOq+q+PXx8WuxKNPUQlee/Ah6cWxond05+araFboacLzzaVsx0a7DWM1QkmU9/ClW
 D3k76rRTa5SHobo8znxdjg7jdjOYefk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-buvphrE8NaaAl2bqhxZFKw-1; Thu,
 23 Apr 2026 10:12:34 -0400
X-MC-Unique: buvphrE8NaaAl2bqhxZFKw-1
X-Mimecast-MFC-AGG-ID: buvphrE8NaaAl2bqhxZFKw_1776953553
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44AFC195609F; Thu, 23 Apr 2026 14:12:33 +0000 (UTC)
Received: from localhost (unknown [10.44.34.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E9A41800357; Thu, 23 Apr 2026 14:12:32 +0000 (UTC)
Date: Wed, 22 Apr 2026 21:03:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/2] Update email address
Message-ID: <20260423010333.GA517410@fedora>
References: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HtOlEauWNjXWgKfZ"
Content-Disposition: inline
In-Reply-To: <20260416231824.349872-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--HtOlEauWNjXWgKfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

--HtOlEauWNjXWgKfZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnpb+UACgkQnKSrs4Gr
c8gBrQgAohn99/muA7PR+pw5qqKI/u30evBXvxKjO3rAzLI8fRELCnElslaKjuZr
zQY5tjpzvrDGe5rjLLP6q6MuOk/FxgqZERGwDnFjAHacmrBEXhGnjrUOv4VBbEPM
uQB3OFrNls/zwJYnMwIEZCZ/VEaRl/kwmKcEEPS+RV5Db6txpgxjCd9osaGuvbys
tVzLTM9Drg7Aj5osZRnNBkA7OUfzkU7QtmTeOkem4ues5lUxplxCFtJf9f03Qs1F
NPAqnEJvBok7ZjUKrlhpZfLtmcHndBsADxj5pq+MicPYbVq/l16rn6V2lnRaxS19
TCzBZsIciYGUm8rIoAc4CMQFvxsBWw==
=N07C
-----END PGP SIGNATURE-----

--HtOlEauWNjXWgKfZ--


