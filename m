Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EB9FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS8p-0006Oc-MS; Mon, 27 Apr 2026 16:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHS7z-0005bF-V0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHS7w-0003cq-7P
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777320017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//qEtLV2HrLAh6YsLoV0cKqeUTS8WEvY/9pxL62lJi4=;
 b=RmgwFiC8V5v4kcXyB+0NL6SBEZKNoeBCUT/KBVRBOnqtn/IFiKVfVITGvnmodeDbRtpASX
 5AhARTeCi73LjVxNCqGQSkAgn1zygI/tnpDiD9c7zWtdZxZ6JSxxrt8oAq+RXeGbnqJtSV
 mn2GAA4ia+XRsBqgpQ9lwph6jNBlFdE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-z06SsD0dOoGEH5yjM9EbVA-1; Mon,
 27 Apr 2026 16:00:14 -0400
X-MC-Unique: z06SsD0dOoGEH5yjM9EbVA-1
X-Mimecast-MFC-AGG-ID: z06SsD0dOoGEH5yjM9EbVA_1777320012
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B26A1800464; Mon, 27 Apr 2026 20:00:11 +0000 (UTC)
Received: from localhost (unknown [10.44.34.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 341A219560AB; Mon, 27 Apr 2026 20:00:06 +0000 (UTC)
Date: Mon, 27 Apr 2026 16:00:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v6 8/8] tests/qtest/nvme-test: add migration test with
 full CQ
Message-ID: <20260427200004.GF218226@fedora>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-9-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7b4qN08BrJCgGtZF"
Content-Disposition: inline
In-Reply-To: <20260419130139.15554-9-alexander@mihalicyn.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--7b4qN08BrJCgGtZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 19, 2026 at 03:01:39PM +0200, Alexander Mikhalitsyn wrote:
> +static void test_migrate_check_nvme(nvme_ctrl *ctrl, test_migrate_req *reqs, int num)
> +{
> +    int i;
> +
> +    for (i = 0; i < num; i++) {
> +        NvmeCqe cqe;
> +
> +        if (reqs[i].handle_cqe) {
> +            continue;
> +        }
> +
> +        cqe = nvme_wait(&ctrl->admin_sq);
> +        g_assert(nvme_is_cqe_success(&cqe));
> +
> +        g_assert_cmpint(cqe.cid, ==, reqs[i].cid);

Please check the endianness in this patch. I don't see an le16_to_cpu()
call here.

Maybe other NVMe DMA structures or registers are also not converted
to/from little endian. This test must pass on both big-endian and
little-endian hosts.

> +
> +        #define GUEST_MEM_READB(field) \
> +                            qtest_readb(ctrl->pdev->bus->qts, (uint64_t)&(field))
> +
> +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[0]), ==, 0x0);

I was trying to figure out why phys_identify has a pointer type although
it is a guest memory address that cannot be dereferenced in C code. I
guess the reason is so that the GUEST_MEM_READB() macro can use the
address-of operator instead of explicitly calculating the offset of
ieee[0], ieee[1], etc? I found this confusing and potentially dangerous
(the compiler won't stop the pointer from being dereferenced if someone
does it by mistake).

It took more time to review the pointer trick than the straightforward
approach would have taken. I'd avoid it, but it's a question of coding
style and up to you.

> +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[1]), ==, 0x54);
> +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[2]), ==, 0x52);
> +
> +        #undef GUEST_MEM_READB
> +
> +        guest_free(ctrl->alloc, (uint64_t)reqs[i].phys_identify);
> +    }
> +}
> +
> +static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    g_autofree gchar *tmpfs = NULL;
> +    GError *err = NULL;
> +    g_autofree gchar *mig_path;
> +    g_autofree gchar *uri;
> +    GString *dest_cmdline;
> +    QTestState *to;
> +    QDict *rsp;
> +    QNvme *nvme = obj;
> +    QPCIDevice *pdev = &nvme->dev;
> +    nvme_ctrl *ctrl;
> +    test_migrate_req test_reqs[] = {
> +        { 123, true },
> +        { 456, false },
> +        { 300, false },
> +        { 333, false }
> +    };
> +
> +    /* create temporary dir and prepare unix socket path for migration */
> +    tmpfs = g_dir_make_tmp("nvme-test-XXXXXX", &err);
> +    if (!tmpfs) {
> +        g_test_message("Can't create temporary directory in %s: %s",
> +                       g_get_tmp_dir(), err->message);
> +        g_error_free(err);
> +    }
> +    g_assert(tmpfs);
> +
> +    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
> +    uri = g_strdup_printf("unix:%s", mig_path);
> +
> +    /* enable NVMe PCI device */
> +    qpci_device_enable(pdev);
> +
> +    ctrl = g_malloc0(sizeof(*ctrl));

I don't see a g_free() call for ctrl. Use g_autofree?

--7b4qN08BrJCgGtZF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnvwEQACgkQnKSrs4Gr
c8iVlwgAql3/bHHUea4AkEsrtxImgYAsjpmXgLU5DO1BGWY321jb0qb3/yp8RSWy
GTKphtBdgjEOUtkALdxhzNlrWqpCbvbljEoM9NdjYLrMVQqU1dCKa+USyphaKcLH
z/3lBG+wUe4pzh87ub5Q5FGdyvxkuV155sk/ZKygX9785Rf8B/pqHcS6RXPQTotE
XqzvT/5Y4ALltYwHI2RoBu2Y5YPIZeveYu/YdHpBDeobnby9ydvZ0FJAucQCPYyZ
HU7Eeqo11wVok6NszhEvsFGuJ1i/6unba3rVzViTWgquLNAQb49sjkuPWpU3CO/n
g4oJVloZIJtF+wGSwDd7dB09hVsn4g==
=p78z
-----END PGP SIGNATURE-----

--7b4qN08BrJCgGtZF--


