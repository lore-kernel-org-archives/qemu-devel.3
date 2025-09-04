Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F070CCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvblB-0001Pa-OT; Mon, 08 Sep 2025 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvbl4-0001MK-8f
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvbkh-0000XO-UL
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757337455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJAbJMVZVyzAKM99Gi+nIm58temUD7N50bpfdgXIpKw=;
 b=UNsUJNp6k1LT/6cZaTOul73ywfSsIwQfn3HwQNUSF2VySTCzLb+dychujbct3G9LbWPB4W
 Uhz3rc1gVq0eVyYPl3276RMHVG7nly5JwDpK+TH9FKNvWpuo1XTXpp799t/SzRpHAAvco3
 PZz1K9zhUmzLB205IcKXGObF9WwpdWA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-CFruAQNIM_O0UzT9ePg6mw-1; Mon,
 08 Sep 2025 09:17:31 -0400
X-MC-Unique: CFruAQNIM_O0UzT9ePg6mw-1
X-Mimecast-MFC-AGG-ID: CFruAQNIM_O0UzT9ePg6mw_1757337449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF596195608B; Mon,  8 Sep 2025 13:17:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A7F71800452; Mon,  8 Sep 2025 13:17:26 +0000 (UTC)
Date: Thu, 4 Sep 2025 21:47:31 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, dlemoal@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <20250904194731.GB122855@fedora>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-5-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NLVjvN3KEsUWxDgy"
Content-Disposition: inline
In-Reply-To: <20250904031058.367667-5-wilfred.opensource@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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


--NLVjvN3KEsUWxDgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2025 at 01:10:57PM +1000, Wilfred Mallawa wrote:
> +/* From host to controller */
> +static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
> +    uint8_t secp = (dw10 >> 24) & 0xff;
> +
> +    switch (secp) {
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        if (n->spdm_socket <= 0) {

0 is a valid file descriptor number. There are additional instances in
this patch series where 0 is treated as an error.

Please initialize the spdm_socket field to -1 and update the if
statements. Although you can probably get away with relying on never
getting fd 0 here in practice, making this assumption makes the code odd
because the reader doesn't know if this is a bug or intentional.

Stefan

--NLVjvN3KEsUWxDgy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi57NIACgkQnKSrs4Gr
c8jrtQgAl5B0qNjCyvJvWA9JEEaZyCRsWSYdNVd+lkCk8PMfdBYr+RN4Rul53Bcn
j//ljmpAPxa3m3iI3MHNPb5Evy2J1RAIU1EFoeenh5yz4b8rtT0Bz0BmY8zXkG7/
kZfwecmUnQG8HtL8SoO70YKwGX0La3Uy8kQZcpCfc9WJ13A0Kh5C+9sZoszqUhk5
eyLI1H1ZldHlPL01R6gNnjeYriPWN5RFLPGKrKRvp1AFfJIy6J1ZYDY6ODRWgrmX
HbNZOWht/w2EWRZR/7E+rXnAb8y/cOOqwzEdMaH253ZhnB2tAysNhFnHB/UhnIXo
8snsmU/kjHaDIj79v+Zsk0M5nv3+2w==
=pUUA
-----END PGP SIGNATURE-----

--NLVjvN3KEsUWxDgy--


