Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3883C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfXV-00053t-Jd; Tue, 18 Jun 2024 16:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sJfXU-00053a-LW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sJfXS-0003x9-Br
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718742882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUZfC/EpQ789z9/C2pcug55GL9wfL842JnnCXv695Lg=;
 b=RysnfdRtMMImuUAg9//i0n6GuS+fvF+Tog78cKcpUd4nd3eGJYEBDKbTvjOLl9RVxd/IMV
 qNJoTTGaAuO2k77OpOSQzHs5o7s07psr3295dXUtDhH9xJsL6Iv9CmVG6djoUbLY37iKSI
 BJhUpsoKgXFKIHrjSLEeLQQmFybq3Fs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-wfcHsibdMEqgj9NWaCQbjg-1; Tue,
 18 Jun 2024 16:34:39 -0400
X-MC-Unique: wfcHsibdMEqgj9NWaCQbjg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C449A19560B2; Tue, 18 Jun 2024 20:34:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.119])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F6613000605; Tue, 18 Jun 2024 20:34:35 +0000 (UTC)
Date: Tue, 18 Jun 2024 16:34:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH] migration/savevm: do not schedule
 snapshot_save_job_bh in qemu_aio_context
Message-ID: <20240618203433.GA29065@fedora.redhat.com>
References: <20240605120848.358654-1-f.ebner@proxmox.com>
 <20240606183638.GC198201@fedora.redhat.com>
 <6d64f07d-1638-44dc-848b-b307c0ebd0ad@proxmox.com>
 <20240611140449.GA366375@fedora.redhat.com>
 <08689bad-80f3-4cc1-bdd9-39df04b40d89@proxmox.com>
 <CAJSP0QUJ2dsAgMaoesTSF7Ni+EPQsCxzOavTvU0sgj7h+7vkQg@mail.gmail.com>
 <1975e2c1-6c66-4249-8380-219b5f1c0ef2@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tWaPEFnS8EZ1k7Jm"
Content-Disposition: inline
In-Reply-To: <1975e2c1-6c66-4249-8380-219b5f1c0ef2@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--tWaPEFnS8EZ1k7Jm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:29:13AM +0200, Fiona Ebner wrote:
> Am 12.06.24 um 17:34 schrieb Stefan Hajnoczi:
> >=20
> > Thank you for investigating! It looks like we would be trading one
> > issue (the assertion failures you mentioned) for another (a rare, but
> > possible, hang).
> >=20
> > I'm not sure what the best solution is. It seems like vm_stop() is the
> > first place where things go awry. It's where we should exit device
> > emulation code. Doing that probably requires an asynchronous API that
> > takes a callback. Do you want to try that?
> >=20
>=20
> I can try, but I'm afraid it will be a while (at least a few weeks)
> until I can get around to it.

I am wrapping current work up and then going on vacation at the end of
June until mid-July. I'll let you know if I get a chance to look at it
when I'm back.

Stefan

--tWaPEFnS8EZ1k7Jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZx71gACgkQnKSrs4Gr
c8haAggAqKPTY9aABkaym7Vluvtm1jmXw7x51KR4Pdg1oJ63EBNYZ6j8Lh3UBS84
1cUaVfFTaUa00OlX4QyuUOzjOf0cUjbP3NJuUL+IPbHChaIemeaFAClHFpEiUmUC
bQk0BrhQeSfgYQN2PMriclXPUnA7aJq9SMxP44hVzHG349DByEbP8n3whhDC/msn
/4DuazXX2pEnKhMUYpIRBDfJqU6VMPNlb3k7QfN2vCvDczCS3HsJ1HIS2zqV6763
7ZotgL51i7IJaL7/xZteJhw8MBJvQZ/cU2rxwe9sSEn/kMh2VfEp0qPAhNm1+DX/
l4hZkEahT8dSabfGkd0KirFyFRP4EA==
=g02L
-----END PGP SIGNATURE-----

--tWaPEFnS8EZ1k7Jm--


