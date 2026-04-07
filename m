Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0B3FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUP-0006OP-FS; Tue, 07 Apr 2026 14:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wABSU-0002iK-5c
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wA8Rq-0006XR-5I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775576076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8XADdrZibf57EGRy1RuBkmFPtyCoeV87C4j3jnniRGU=;
 b=eZywXy7PAkfAc1R4JoS4/3mFq1Yv9b4eeCxyWYobNuevVwIoEOjnWdzVpcRbiYOk9IYtNX
 2i/PoNOYRzvFgOarWzaYpneoEp+wlMyET4wqYDPifh+NIyy2I3yz5iG2CeAp/ShVDhralE
 zhYqEX8kt9khl2DSUbnqTmv1jVVNtqA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-6hmMVIHnMiibzsOlbTJKiA-1; Tue,
 07 Apr 2026 11:34:35 -0400
X-MC-Unique: 6hmMVIHnMiibzsOlbTJKiA-1
X-Mimecast-MFC-AGG-ID: 6hmMVIHnMiibzsOlbTJKiA_1775576073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E73195605B; Tue,  7 Apr 2026 15:34:31 +0000 (UTC)
Received: from localhost (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1307C1800673; Tue,  7 Apr 2026 15:34:28 +0000 (UTC)
Date: Tue, 7 Apr 2026 11:34:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 5/8] hw/nvme: add migration blockers for non-supported
 cases
Message-ID: <20260407153426.GA238768@fedora>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-6-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NNGxTyNILpv0+EUA"
Content-Disposition: inline
In-Reply-To: <20260317102708.126725-6-alexander@mihalicyn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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


--NNGxTyNILpv0+EUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2026 at 11:27:05AM +0100, Alexander Mikhalitsyn wrote:
> +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
> +{
> +    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> +    bool adm_cmd_security_checked = false;
> +    bool cmd_io_mgmt_checked = false;
> +    bool cmd_zone_checked = false;
> +
> +    /*
> +     * Idea of this function is simple, we iterate over all Command Sets and
> +     * for each supported command we provide a special handling logic to
> +     * determine if we should block migration or not.
> +     *
> +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
> +     * available to the guest, but if there is only 1 namespace, then it is
> +     * safe to allow migration, but if there are more, then we need to block
> +     * migration because we don't handle this in migration code yet.

What would be required to migrate multiple namespaces?

Thanks,
Stefan

--NNGxTyNILpv0+EUA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnVJAIACgkQnKSrs4Gr
c8jmawf9GDx5rqa2JBFvEUUWLF7X7uqfhGFAHol9kO0yMq9O8s+jutUU9EIj/uIs
Vps1X0XuRK/29Dr1f04bv74g/bF+FnnFSpStvRT6ixHek64gcgNpArVrEjDpjSA+
iGpuld01Ly0Qd73gWWWxb8JNFE0UGBGoJRB/JA4xAqGq5lrbYOedKAeqQoiBHEKD
sw/MfUyqJU7aXsNvQcmab8MWoNwk+UCCkRGxTJIaLfSVjLqSRKsP/tmUdtN/HlQx
qGsgsG1up1UKU6zVBftg+A41aQ/cJ7IVta/esRg9stFKD6vf5RiEzTsJBNH2RZ9P
wxHnpuSeBDMz6kLBWYYG5rJfedSYbw==
=x+XY
-----END PGP SIGNATURE-----

--NNGxTyNILpv0+EUA--


