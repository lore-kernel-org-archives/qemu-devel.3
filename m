Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B932EC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4fb-0002b6-35; Mon, 03 Mar 2025 07:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4f0-0002Yx-HX
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4ez-0004Qi-10
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741003956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1/uL7QMeZ/HKkWcVh3g7XU6eWlvQhlfuKF+kAGI0Hg=;
 b=NwTlpAe/eaJnZe4Fj1eUgjAC9FBfpzdGnlw5LtqEB00DRBQPrHa+RV8h8FdZ2Nn6Hfnf3k
 BdNUXpyQwmcnh3Vr6YALOFgJIbHdPQ+tmpsOttLheTZGAfPZ851diBVEhzeGOq8RNYdKAa
 dc7d4ywo2M/z1hkC02r/hAAQLoRgUP8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-OZMeZ8j4PTaVUPQzMP4mqQ-1; Mon,
 03 Mar 2025 07:12:19 -0500
X-MC-Unique: OZMeZ8j4PTaVUPQzMP4mqQ-1
X-Mimecast-MFC-AGG-ID: OZMeZ8j4PTaVUPQzMP4mqQ_1741003939
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C94071918165
 for <qemu-devel@nongnu.org>; Mon,  3 Mar 2025 12:12:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA8491800362; Mon,  3 Mar 2025 12:12:17 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:12:15 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/34] i386, Rust, build system, QOM patches for 2025-02-27
Message-ID: <20250303121215.GA215581@fedora>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+Y+5KkS1FBNjqy8m"
Content-Disposition: inline
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--+Y+5KkS1FBNjqy8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--+Y+5KkS1FBNjqy8m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFnJ8ACgkQnKSrs4Gr
c8hP2Qf/cA61oOH+nd37zR7vLLOrZN1Ky/l5/Zt4WhNZ3NUlSLmOJOhRE9p8gBOU
ifwwG6vn4V8mqZJ45S+rPHoNYRyL8v/lOh/8svyadwXx2CCRm247TeeXDk8JExVs
LD8vVwFOzx5hS+BC2SKYMCmEo/SfScVLa2zihHimsl/w7jPJiEYokvzyu983mCxW
4zD057ksfjvUwqG7a07D5QQkEs65C413/ZyQ9yS1zAdfOe7E/Tg0/wOSQMv1rNMP
wCwZG5eJH/mAnZ++lLtnUC1AlsWVHqi5k5hqvbiSXWRCcawBIBcgYRLGfOrZY46i
Q9yFm4y1ZZxyinyS1KfrB7aozjerXg==
=P7Om
-----END PGP SIGNATURE-----

--+Y+5KkS1FBNjqy8m--


