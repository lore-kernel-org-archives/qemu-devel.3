Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8C0EDF156
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 11:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqrn2-0006zD-UK; Fri, 13 Feb 2026 06:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1vqrn0-0006yd-VD
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:56:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1vqrmz-0007zk-Dj
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770983808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtti+Vx55/bmLfGmi4sKDGkfYPrA1F7rnsHJ9kExjbs=;
 b=fXpQPO904cEbGDjFq54BizbjPMXwmG3TMXipOcMQF9v2BZZUVEMpfXAOdvlDTfb9N9zXZb
 lCNSjJkitxgWrl/+MdG9rTbqs48jdj6pfh7s/Myi3xbvwWzB49U2SUcDUuQi+yj2XemEe6
 /yf+rVWzHx/A2OeyEZV+XMjbL68x09c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-pocs15bDNueHAG4ZIIdRxw-1; Fri,
 13 Feb 2026 06:55:24 -0500
X-MC-Unique: pocs15bDNueHAG4ZIIdRxw-1
X-Mimecast-MFC-AGG-ID: pocs15bDNueHAG4ZIIdRxw_1770983722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0CAF1800365; Fri, 13 Feb 2026 11:55:21 +0000 (UTC)
Received: from antique-laptop (unknown [10.44.22.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 813151800668; Fri, 13 Feb 2026 11:55:16 +0000 (UTC)
Date: Fri, 13 Feb 2026 12:55:13 +0100
From: Pavel Hrdina <phrdina@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jan@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
Subject: Re: [PATCH v2 24/24] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Message-ID: <aY8RIXzUVqcTiCkd@antique-laptop>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-25-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rFthhvOpjXrkCOot"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-25-skolothumtho@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--rFthhvOpjXrkCOot
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 02:48:23PM +0000, Shameer Kolothum wrote:
> Introduce a =E2=80=9Ctegra241-cmdqv=E2=80=9D property to enable Tegra241 =
CMDQV
> support. This is only enabled for accelerated SMMUv3 devices.

Hi, do we expect that in the future there will be some other option
named `{newplatform}-cmdqv`?

I'm asking mainly from libvirt PoV where current RFC patch exports this
option only as `cmdqv`.

Pavel

--rFthhvOpjXrkCOot
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAmmPESEACgkQUi1kczAH
4YwXJxAAzxLGTFEk8AYToDcWpSfGXAMyAky90wsZlLkzOjm5vQh4BZn9MrPXlSdK
DcpwAScqeCb5NJ4GaC8K65xorog6zWg71E/chdhe1kXJpnxSWF/DvwbKHHdEDoiH
87gSNDgoU2NIPri5TpD1nd4rK1JBFkjnSU+DlSR8u+Lp5jJgqCDBUZWQLHdEPFnu
TmQQJRvDDV3uSILRuB5KfhP20kPwMbFduWOa/KF4cA1PzCn0Ef715xeJeOGf6tfr
muolvlgO8178IMHpS/2z0JibeRwPchxVcywSDiIv2nQxLj2CYXG0F4V4X0955ZIc
zSyWq2O2ZcRxI2L+v/DUF6p2ObRITq5NdLaPvcevaQ2xyUoTzZLRs0MX1NESDxii
zpgg+XrMrw4+rlkFEyK85BKMxVUh7U0V3YYn77qm4fFRITRH0EhAAM/JVagaPZ4V
RgQ4Hc0T5mOIz2Be7r9e+3D2Fwr2Gnq8JuOAmGGeDsZAfrOz2mFjItGUQXPUpDKO
rvbLvnfPhUspy/iETSJfYw/CbYCOeKVPG1lvntFnEnNDLwSLPLKm2OV2ObjjDle/
48NbxKZrksmSRnZjd/NuwVX+9GUIafjR72wAZdi4UjGX6yDG9kVwQhgxpdGeiNsx
3U4j8wz20mYCYpvjlHMJH8Q8BL8FIi/yqzpJJJa8YrIUfHc64qE=
=tuQI
-----END PGP SIGNATURE-----

--rFthhvOpjXrkCOot--


