Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87214CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE5T1-0001cQ-Te; Wed, 29 Oct 2025 08:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vE5Ss-0001bz-LR
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vE5Si-0001j7-JN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761741567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qACFUBNIMYvW6fI70JKrJG+xNX09l6zny8LGviMMAE=;
 b=cdw59R+DoU+ieUIFms6CzRY3+AdcfxT5w7GWjmdBZFz8efeMJX1VJAZFdr4Xehtx9/bSmQ
 D09AAg4lzOjtbMfXxx7MJ5J6zyYHbnP0p9MjHWGdzoP4iLPFtO88oTDenXsosveGT223Un
 BNRPJtJSe77lHKoKZ7cIsyUjMALpKyc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-D2ic94gzPImNIPd7JVWSQg-1; Wed,
 29 Oct 2025 08:39:23 -0400
X-MC-Unique: D2ic94gzPImNIPd7JVWSQg-1
X-Mimecast-MFC-AGG-ID: D2ic94gzPImNIPd7JVWSQg_1761741562
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 863A4195608D; Wed, 29 Oct 2025 12:39:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 091FF19560AD; Wed, 29 Oct 2025 12:39:21 +0000 (UTC)
Date: Tue, 28 Oct 2025 14:25:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: AWS CI Oddities
Message-ID: <20251028182520.GA66764@fedora>
References: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org>
 <CAJSP0QU9M1QEXjKBjHtq2NgHu0FUTC4rXMxB657BsdxGvcs1ew@mail.gmail.com>
 <CACPOWh2o0q0usrKv9C3cR39p5OpwLzXnwzwJbqYRFs3n-w9bnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zJv11xBMfk97FBOm"
Content-Disposition: inline
In-Reply-To: <CACPOWh2o0q0usrKv9C3cR39p5OpwLzXnwzwJbqYRFs3n-w9bnA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--zJv11xBMfk97FBOm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:41:32AM +0100, Camilla Conte wrote:
> Hi Stefan,
>=20
> This can happen because the worker node is out of resources (likely
> memory) for the running pods.
> We can set a memory minimum for all pods, or we can set it per-job.
>=20
> If there are some specific jobs that are memory-hungry, please set
> KUBERNETES_MEMORY_REQUEST in the job variables.
> https://docs.gitlab.com/runner/executors/kubernetes/#overwrite-container-=
resources
>=20
> Else, I can set a global default.

Hi Camilla,
Sizing each CI job requires memory metrics that I don't have. Does AWS give
you any insight into how much free RAM is available on k8s worker nodes
over time?

Gemini suggests that Kubernetes Metric Server can be enabled and then
`kubectl top` can be used to monitor Pod resource usage. Alternatively,
CloudWatch Container Insights can be enabled in AWS to get Pod memory
usage.

Once we have data we can either raise the limit (assuming there are no
huge outliers) or label the outlier jobs (to avoid overprovisioning the
normal jobs).

By the way, I haven't figured out how to access the AWS resources from
my own AWS account. I only see the total cost from our accounts, but
don't have visibility or control over what is running. So I'm unable to
investigate the EKS cluster myself at the moment.

Thanks,
Stefan

--zJv11xBMfk97FBOm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkBCpAACgkQnKSrs4Gr
c8gG/QgAukhkqkMpuOshuCwYG89lZaeA0LD6dpoPZOco2tz/MUXkbRFl8zK8taUD
sHqpdE5FC4NDoxL0LZ9X0/KzsuJST6hM9T7nzuNQ4bH8jL1PQLaCbKTH2VVPo0SP
oy1Xp2ALw0DsW7MO4SQarG1VebSdx/SeTqW4y3QvkqJssma/CxdAHSlzQmBMF/UC
0YHx+MnTHCVO7yW5mCpNoz8GczoraluXPXrj/x0jnuHGwTkDswEqwd70jWYMClVU
30UFFjjDhYJXbb/ik5aRLOJfLoZMMRUJjELtSGKhf0cdBh7b4FZZKudLtwWOuKvc
vRsPwt3bpFuUnrG5/EPme0PRnh52sw==
=pHPf
-----END PGP SIGNATURE-----

--zJv11xBMfk97FBOm--


