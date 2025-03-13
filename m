Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6E3C28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscZq-0006Yr-Ed; Thu, 13 Mar 2025 03:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscZk-0006NR-6s
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscZi-00073o-Rz
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zi9QiemWOR3G7pf3lNnFkKrhxQmKcVtf+3iRj1kKPao=;
 b=Ijn98ZSm9MLFcWIw5WaVD1w3sP+qK64tLehGWQE3jcOl6anAD/m1RYhGx2Fl2pNqM+WH41
 0hO6mMEnqTA/W90/rg/nR31tHxA8S3AKel8MUWp1Aiz/Xk4QY0zfwZvcxRlvGtWMz4OoCa
 uJHLJPjJNl3vcU4Kh5AMPhHgarL7/jM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-oM1SeDBBNsKj8yKgVa7eWg-1; Thu,
 13 Mar 2025 03:01:43 -0400
X-MC-Unique: oM1SeDBBNsKj8yKgVa7eWg-1
X-Mimecast-MFC-AGG-ID: oM1SeDBBNsKj8yKgVa7eWg_1741849301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CFE319560AB; Thu, 13 Mar 2025 07:01:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C4811955BCB; Thu, 13 Mar 2025 07:01:39 +0000 (UTC)
Date: Thu, 13 Mar 2025 12:27:19 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: zhuyangyang14@huawei.com, qemu-devel@nongnu.org, fam@euphon.net,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 luolongmin@huawei.com, suxiaodong1@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com,
 wangjian161@huawei.com, mujinsheng@huawei.com, alex.chen@huawei.com,
 eric.fangyi@huawei.com, chenjianfei3@huawei.com, renxuming@huawei.com
Subject: Re: [PATCH 0/2] qapi: Fix qmp_block_set_io_throttle blocked for too
 long
Message-ID: <20250313042719.GE1074020@fedora>
References: <20250308101618.721954-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zjNsR7EZsYpKFOcn"
Content-Disposition: inline
In-Reply-To: <20250308101618.721954-1-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--zjNsR7EZsYpKFOcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The idea of adding a timeout parameter sounds good to me.

I think it's safe to call bdrv_drained_end() after the timeout fails,
but I'm not 100% sure. Maybe Kevin has thoughts on this.

I left comments on the patches.

Stefan

--zjNsR7EZsYpKFOcn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSXqcACgkQnKSrs4Gr
c8hgvAf/el0OdcaPeKkC577YFXuwukxhPgmmoHHftx+mkDiFuhbr3wFsdbyra1wy
kf2RPhTa09y6X1V9Eu6dsaJkRp/JjN7bvRe0Lg9iFIrXcmcAi6o8cQxoTOs9x8oq
sOae/YkV6mq1mSVkh22GP+GqHlQu75rvq/zqtsKvlAG8PKWjwUx2FUjJO2OB+5e2
mo4pSaaPWJ4YhsvZ3UR+UqR+mWLzTI78EoKtFjJg7YM2a3gqpdTmMEJZ6L/hFBJ+
wCfb/CXjCyzTvCVcI/ofWNdFlctLz1mH3eVycXw6adijsPKxuR/pIoyixJyu7/7C
ZNqNtFjo46tI5BVoYan47tPSuLkAuA==
=02G7
-----END PGP SIGNATURE-----

--zjNsR7EZsYpKFOcn--


