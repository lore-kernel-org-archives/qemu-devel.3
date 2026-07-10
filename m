Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9F7C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 04:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi3E7-0004Hw-DQ; Fri, 10 Jul 2026 00:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wi3Da-0004EJ-1y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wi3DX-0007lg-LJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783659121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtYxdUumivFpFYm38wlusrJpJq4Z47hPBxqVyT7+WcM=;
 b=MXsiZZ7hUq4AkPefXMcMhjdkiAJ5kQN9u0hFMyKIbnn/a17GOpaUJcKWLvFtQKv9igzEU1
 Pr7vgujo7iErKBiET/2P4p7pbAL3XtvS5dFlKrt0ADNYiYw3jBNbp3VQd2pqsDFvynsRuC
 i0bNK5AAOdQnhX3gowUohbswtgFv3iM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-hR3BWRIjMs2Sjfzb4xOGIA-1; Fri,
 10 Jul 2026 00:51:58 -0400
X-MC-Unique: hR3BWRIjMs2Sjfzb4xOGIA-1
X-Mimecast-MFC-AGG-ID: hR3BWRIjMs2Sjfzb4xOGIA_1783659117
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1E2D1956094; Fri, 10 Jul 2026 04:51:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.47])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C13AF180029C; Fri, 10 Jul 2026 04:51:55 +0000 (UTC)
Date: Fri, 10 Jul 2026 06:47:54 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/4] Dockerfiles update for 2026-07-08
Message-ID: <20260710044754.GA604145@fedora>
References: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RzXQmSOBXeZQ6e9n"
Content-Disposition: inline
In-Reply-To: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--RzXQmSOBXeZQ6e9n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--RzXQmSOBXeZQ6e9n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpQeXoACgkQnKSrs4Gr
c8i8KggAnIuYwWTw+jzgIy5mz7K0IJoXJNfKL8qgXb8kAgGxgZ0xqzaMnRtvvRsB
DHvehgB+jhcUymivGSC1bkQJcC8zkd4CO4kAHAL2hJTxUBGgelXG/rww91GmvbRN
D2VyDsNJEdSrxnldr2j6qNXoZd3MGNdw2dCTPgbfNf9RxCbnGzGZsOcbHLuBzf1b
LURYo4lHuBkIoXZbRyZISzPvtcL2UXu8/0ny8dxYxTV54Jse9cV5AjoegqUrFF+2
hWOuMiY9Buo5aqMzMyutdm4AgR/faC15wmPQpRRLJfHf5QfEvwVSlx7wg4AFl+mX
4XO3rt2LApglqXa6CQxnVoPtgfyqMg==
=+RKe
-----END PGP SIGNATURE-----

--RzXQmSOBXeZQ6e9n--


