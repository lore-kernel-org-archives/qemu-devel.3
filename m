Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E8FC6181
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spDEk-0003lW-RJ; Fri, 13 Sep 2024 16:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1spDEj-0003kO-Qg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1spDEh-0003FW-Ru
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726260585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yeE3nFufKuzgQOPwegOpsegZMGv879hjaZpIQBj9fh8=;
 b=fz4povp+70n7i0PIPv7qcmefMMF8DSLbEq+50BShL5wiM1XcEP+7xb8F/CeReHGf/U0AI8
 wy5jvZEAhO2LdKNs5MJtBkld9V9kCmcdUHlKUsSLFZSE6HX7VoI/DFWdMaHykZHus1TaN7
 lSLygnOKO+I2/IvJpCZJ2ezHzrt9uW8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-ewECCnTSMLuXNVmnEgW0qQ-1; Fri,
 13 Sep 2024 16:49:42 -0400
X-MC-Unique: ewECCnTSMLuXNVmnEgW0qQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95A5E1955F3C; Fri, 13 Sep 2024 20:49:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A66D13001D11; Fri, 13 Sep 2024 20:49:36 +0000 (UTC)
Date: Fri, 13 Sep 2024 16:49:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com
Subject: Re: [PATCH v12 09/10] hw/nvme: add reservation protocal command
Message-ID: <20240913204925.GB351354@fedora>
References: <20240912111917.81477-1-luchangqi.123@bytedance.com>
 <20240912111917.81477-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4hpcIU2VjEXhDTfW"
Content-Disposition: inline
In-Reply-To: <20240912111917.81477-10-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--4hpcIU2VjEXhDTfW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 07:19:16PM +0800, Changqi Lu wrote:
> +static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatus *nvme_status;
> +    NvmeRequest *req = reservation->req;
> +    NvmeCtrl *n = req->sq->ctrl;
> +    NvmeResvKeys *keys_info = reservation->keys_info;
> +    int len = sizeof(NvmeReservationStatusHeader) +
> +              sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
> +
> +    nvme_status = g_malloc(len);
> +    nvme_status->header.gen = reservation->generation;
> +    nvme_status->header.rtype = block_pr_type_to_nvme(reservation->type);
> +    nvme_status->header.regctl = keys_info->num_keys;
> +    for (int i = 0; i < keys_info->num_keys; i++) {
> +        nvme_status->regctl_ds[i].cntlid = nvme_ctrl(req)->cntlid;
> +        nvme_status->regctl_ds[i].rkey = keys_info->keys[i];
> +        nvme_status->regctl_ds[i].rcsts = keys_info->keys[i] ==
> +                                          reservation->key ? 1 : 0;

Missing byte swaps? I see byte swaps in nvme_read_reservation_ext_cb().

> +        /* hostid is not supported currently */
> +        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> +    }
> +
> +    rc = nvme_c2h(n, (uint8_t *)nvme_status, len, req);
> +    g_free(nvme_status);
> +    return rc;
> +}
> +
> +static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatusExt *nvme_status_ext;
> +    NvmeRequest *req = reservation->req;
> +    NvmeCtrl *n = req->sq->ctrl;
> +    NvmeResvKeys *keys_info = reservation->keys_info;
> +    int len = sizeof(NvmeReservationStatusHeader) +
> +              sizeof(uint8_t) * 40 +
> +              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
> +
> +    nvme_status_ext = g_malloc(len);
> +    nvme_status_ext->header.gen = cpu_to_be32(reservation->generation);
> +    nvme_status_ext->header.rtype = block_pr_type_to_nvme(reservation->type);
> +    nvme_status_ext->header.regctl = cpu_to_be16(keys_info->num_keys);
> +
> +    for (int i = 0; i < keys_info->num_keys; i++) {
> +        uint16_t ctnlid = nvme_ctrl(req)->cntlid;
> +        nvme_status_ext->regctl_eds[i].cntlid = cpu_to_be16(ctnlid);
> +        nvme_status_ext->regctl_eds[i].rkey = cpu_to_be64(keys_info->keys[i]);
> +        nvme_status_ext->regctl_eds[i].rcsts = keys_info->keys[i] ==
> +                                               reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
> +    }
> +
> +    rc = nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
> +    g_free(nvme_status_ext);
> +    return rc;
> +}

--4hpcIU2VjEXhDTfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbkpVUACgkQnKSrs4Gr
c8hcbgf/YRU12QWGbRaA+bOE1j9wonPFkv2ERtspBS4+0HUztE5ZlHEAsQJwiUYg
1D8bdJEOaZPKnuCLbOyYU3Yoy1972H5XF6GjdtsgaQ25x7D7viVZemjGPRKzafAX
qZ9deMWfoO7GhsAHeqz+e/7e89xnFzksNlL3NGn8x0+XcgEkOn4C1FgzpGZGv1Ed
ILU1SZJq6EKc2wMB+8akose0KaSQTm07pkd4oXVRTCZWjfwUTvkJ7lAWO3COX8J6
VuGdlTk11TYFz1q6YLlREVHiMBeOJIdoTz297uBs0DUCWAbWaAxgdAO1VnF1bkmg
XgMQhrK+hcOuyWzy2788tGmJUP+wTQ==
=lSOt
-----END PGP SIGNATURE-----

--4hpcIU2VjEXhDTfW--


