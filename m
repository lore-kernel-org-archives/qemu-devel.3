Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB00CCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSsZ-0007kg-5e; Tue, 16 Jun 2026 08:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wZSsX-0007kH-5v; Tue, 16 Jun 2026 08:26:53 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wZSsU-0004FB-5v; Tue, 16 Jun 2026 08:26:52 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id AE8E61D00144;
 Tue, 16 Jun 2026 08:26:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 08:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1781612805; x=
 1781699205; bh=AKjZv89TOoI6X9TDvF+qmzCGj5yrq7xtcNsMYaxdopg=; b=b
 Fb5xn97w0pkybryEEZzNn/k/4pNsGoTmDoQ7WB1Q6U+gh6Hcp2yBx8FHhbJnnKpF
 tpV/Wp4mA52fmVOt7OR99Uk1ca8ldf2AavHgOG82IXGL8c+7v3uLcxXE3pXL46IK
 viEA+Ax5L64I+HNVcKxht8Z29p29AOb8oCB+TvXm9vRy3m6/5EyCLIArhkXPGPXC
 /UiLMxA2CmvCp8zyD/qUycFlgBBu0fRYXLE9nE1El6cDCwUxAr5NIzImUm57HblZ
 9PudJdG5ToNfbWadXbs9W1hS+Uwkxb1MkzOZVN9kEAChDPr/oKzEILiiKmsS/j1J
 OcquQbWwWLhNdkkILs7sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1781612805; x=1781699205; bh=AKjZv89TOoI6X9TDvF+qmzCGj5yrq7xtcNs
 MYaxdopg=; b=czSUO3+I8X3sNcI06U8/4lTCqE2CU1uqXKiEP+V6De5FJNY7Pm6
 kiXDFLjMl7utToiPz9kK5VwHkQglHHwAUZznu8mRdU7uuKlqC+v4DGfzPYciSaSe
 mT5DWMTovo5c2wxj7aioBqeCf7wve2dI/wTMsv45yXCk/I2XW7tpayVq7XU3lzkd
 vtZJhxNNpePba057BEf0NPoJjZ9yLcOWU8hUl/phP6HfxPaGkv0H7uCk3/2dbWED
 ECLVmel7dS6/NNB8LISmIgHb+QAk0noQWSbd1v+ZTxSqyVQHykkgi8CheTNytEAf
 M32cEGPYsTq4dVdeJISMpH1PqUDRD9CmhtA==
X-ME-Sender: <xms:A0ExakKLZVLparZLkTESt_rnWKPzcv-ip1ZT_kzoZHXyDVZg7lXGEA>
 <xme:A0ExalEVailso6avk5hf1qL1s-um781hvloxaXAYpTrWgBfwztbwZEG-_1uWUZo4F
 B8udkW4QLM6GTH4WbRZMVF0Cdg1RHaGy0mYLjxHoP7ybtLCicLmjaY>
X-ME-Received: <xmr:A0ExalDfqrSyvjPzjern7Mq_Z3RaXqdck6G5D2bwmQ235OIKiI3NXc7whXEwLA>
X-ME-Proxy-Cause: dmFkZTElN3f4R1Nk30RcN7llctDjoquB4F0yXg0MnAUZs+7cWvlhe2lNt2hmST2GihENQg
 tr1oO/VWKkfwkRA8IJ1AOAwZTjDAF0nEMKtjRFD3b3hS3uV+aMuAmnqFw9kTAb4t09QAgL
 h01OdhxIR28DNr4Nm9S50NxYtsHvuzIlXWhpUKxsRQjHjs68vXqXUZpCR9KIumITr1ftgm
 w3ilbPA9tTxInKOhjShoVo9UNHlwUMi75QoHyFRHXtHywdwfEuIllZBaatPOJxrfyad2uf
 mfBwT2+IIOEOCb53kwE8hlMXIGZRvLs0/ooBbGROqWLrLE5HC8gJmKqHybWtb0jPxmTVgj
 JiHKesj8DbVjSx3bqQnMXKhbj3tniHvUH42kn6YoxcM4maOpg0oh/idX+5uUR7NCt+UW1v
 HU04vAOZsduARlM8XceRuvZDRWSPgps8QW5RVWpZ4NMkllrAwe7Dxy8YaFYeRzSGz2hPfi
 SWnYgw5hTJQtJVo48YS6CHRz7/jZe/39HU13PNGxdIXt9nz/Vzl6gfJOsPh3r3ct2F8BTi
 rNrR/7uhVxU1nn2+kD5/zNP+bpDA76uLZz7ajAx1JuISE2slWtPNHR8SW9l4uGRHCTMsJj
 U/s/9z1cnakEhkXOYAZdQgWHKd3YrPhwoWQBw9zNgqxhhSKzFiujLjY/j0cw
X-ME-Proxy: <xmx:A0Exav2-pFzPVSWXWP59icpgXDEEi9h1yegC6fyllS_tqqnARBTXDA>
 <xmx:A0ExaiNC7qbHDHXOWyYyKOI5tSwdHdClp_5i7Vx2Y3yaDF_cqGV1HA>
 <xmx:A0Exas5ZZr5WtHwFGDnEPCLTlddxs9tMC4ArRB_L5ZTKNRwi2wv7qA>
 <xmx:A0ExavbsDDcmhmf791Jtw6kQikgGRTXJUrkIYzCcV8gKn_yaEuyQbQ>
 <xmx:BUExanQUQezEM25293VwVDuTFLNdFlHC1WOuVgCXxASFaSYNk65VIQzO>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 08:26:43 -0400 (EDT)
Date: Tue, 16 Jun 2026 14:26:42 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v10 8/8] tests/qtest/nvme-test: add migration test with
 full CQ
Message-ID: <ajFBAkR87ro_CrU_@AALNPWKJENSEN.aal.scsc.local>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
 <20260611180842.6390-9-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TQ/nd/kayTdWZ675"
Content-Disposition: inline
In-Reply-To: <20260611180842.6390-9-alexander@mihalicyn.com>
Received-SPF: pass client-ip=202.12.124.146; envelope-from=its@irrelevant.dk;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--TQ/nd/kayTdWZ675
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 11 20:08, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> As suggested by Stefan [1], let's add a migration test to cover
> rare scenario when CQ is full of non-processed CQEs and migration
> happens.
>=20
> To run this test:
> $ meson test -C build 'qtest-x86_64/qos-test'
>=20
> Link: https://lore.kernel.org/qemu-devel/20260408183529.GB319710@fedora/ =
[1]
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
> v10:
>     - replace %lx with 0x%" PRIx64 for q->doorbell
>       [ fix cross-win64-system test ]
>     - get rid of PAGE_SIZE macro and explicitly request proper amount of =
mem
>       [ build-system-alpine test was failing on PAGE_SIZE macro redefinit=
ion ]
> v9:
>     - check-patch fixes
>     - added qpci_check_buggy_msi() check to skip test on ppc64 / spapr pc=
i bus
> v7:
>     - fixed endianness bugs (and tested on s390x machine)
>     - code style changes (don't use ptr type for physical addresses)
> v6:
>     - test added
> ---
>  tests/qtest/nvme-test.c | 419 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 419 insertions(+)
>=20
> diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
> index 4aec1651e6e..f9395cc252b 100644
> --- a/tests/qtest/nvme-test.c
> +++ b/tests/qtest/nvme-test.c
> @@ -8,9 +8,12 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +#include "qemu/bswap.h"
>  #include "qemu/module.h"
>  #include "qemu/units.h"
>  #include "libqtest.h"
> +#include "libqtest-single.h"
>  #include "libqos/qgraph.h"
>  #include "libqos/pci.h"
>  #include "block/nvme.h"
> @@ -142,6 +145,420 @@ static void nvmetest_pmr_reg_test(void *obj, void *=
data, QGuestAllocator *alloc)
>      qpci_iounmap(pdev, pmr_bar);
>  }
> =20
> +typedef struct nvme_ctrl nvme_ctrl;
> +
> +typedef struct nvme_queue {
> +    nvme_ctrl *ctrl;
> +    uint64_t doorbell;
> +    uint32_t size;
> +} nvme_queue;
> +
> +typedef struct nvme_cq {
> +    nvme_queue common;
> +    uint64_t phys_cqe; /* NvmeCqe* */
> +    uint16_t head;
> +    uint8_t phase;
> +} nvme_cq;
> +
> +typedef struct nvme_sq {
> +    nvme_queue common;
> +    uint64_t phys_sqe; /* NvmeCmd* */
> +    nvme_cq *cq;
> +    uint16_t head;
> +    uint16_t tail;
> +} nvme_sq;
> +
> +struct nvme_ctrl {
> +    QGuestAllocator *alloc;
> +    QPCIDevice *pdev;
> +    QPCIBar bar;
> +
> +    uint32_t db_stride;
> +
> +    nvme_sq admin_sq;
> +    nvme_cq admin_cq;
> +};
> +
> +#define PHYS_ADDR_OF_FIELD(T, base_phys_addr, field) \
> +    ((uint64_t)&((T *)(base_phys_addr))->field)
> +
> +#define PHYS_ADDR_OF(T, base_phys_addr, accessor) \
> +    ((uint64_t)&((T *)(base_phys_addr))accessor)
> +
> +static void nvme_init_queue_common(nvme_ctrl *ctrl, nvme_queue *q,
> +                                   uint16_t db_idx, uint32_t size)
> +{
> +    q->ctrl =3D ctrl;
> +    q->doorbell =3D (sizeof(NvmeBar) + db_idx * ctrl->db_stride);
> +    g_test_message(" q %p db_idx %u doorbell 0x%" PRIx64, q, db_idx, q->=
doorbell);
> +    q->size =3D size;
> +}
> +
> +static void nvme_init_sq(nvme_ctrl *ctrl, nvme_sq *sq, uint16_t db_idx,
> +                         uint32_t size, nvme_cq *cq)
> +{
> +    nvme_init_queue_common(ctrl, &sq->common, db_idx, size);
> +
> +    sq->phys_sqe =3D guest_alloc(ctrl->alloc, sizeof(NvmeCmd) * size);
> +    g_assert(sq->phys_sqe);
> +
> +    g_test_message("sq %p db_idx %u sqe 0x%" PRIx64, sq, db_idx, sq->phy=
s_sqe);
> +    sq->cq =3D cq;
> +    sq->head =3D 0;
> +    sq->tail =3D 0;
> +}
> +
> +static void nvme_init_cq(nvme_ctrl *ctrl, nvme_cq *cq, uint16_t db_idx,
> +                         uint32_t size)
> +{
> +    nvme_init_queue_common(ctrl, &cq->common, db_idx, size);
> +
> +    cq->phys_cqe =3D guest_alloc(ctrl->alloc, sizeof(NvmeCqe) * size);
> +    g_assert(cq->phys_cqe);
> +
> +    g_test_message("cq %p db_idx %u cqe 0x%" PRIx64, cq, db_idx, cq->phy=
s_cqe);
> +    cq->head =3D 0;
> +    cq->phase =3D 1;
> +}
> +
> +static int nvme_cqe_pending(nvme_cq *cq)
> +{
> +    uint16_t status =3D qtest_readw(
> +        cq->common.ctrl->pdev->bus->qts,
> +        PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status));
> +    return (status & 1) =3D=3D cq->phase;
> +}
> +
> +static int nvme_is_cqe_success(NvmeCqe *cqe)
> +{
> +    return (le16_to_cpu(cqe->status) >> 1) =3D=3D NVME_SUCCESS;
> +}
> +
> +static NvmeCqe nvme_handle_cqe(nvme_sq *sq)
> +{
> +    nvme_cq *cq =3D sq->cq;
> +    uint64_t phys_cqe =3D PHYS_ADDR_OF(
> +                            NvmeCqe, cq->phys_cqe, [cq->head]); /* NvmeC=
qe* */
> +    NvmeCqe cqe;
> +    uint16_t cq_next_head;
> +
> +    g_assert(nvme_cqe_pending(cq));
> +
> +    qtest_memread(sq->common.ctrl->pdev->bus->qts, phys_cqe, &cqe, sizeo=
f(cqe));
> +
> +    cq_next_head =3D (cq->head + 1) % cq->common.size;
> +    g_test_message("cq %p head %u -> %u", cq, cq->head, cq_next_head);
> +    if (cq_next_head < cq->head) {
> +        cq->phase ^=3D 1;
> +    }
> +    cq->head =3D cq_next_head;
> +
> +    if (cqe.sq_head !=3D sq->head) {
> +        sq->head =3D cqe.sq_head;
> +        g_test_message("sq %p head =3D %u", sq, sq->head);
> +    }
> +
> +    qpci_io_writel(cq->common.ctrl->pdev, cq->common.ctrl->bar,
> +                   cq->common.doorbell, cq->head);
> +
> +    return cqe;
> +}
> +
> +static NvmeCqe nvme_wait(nvme_sq *sq)
> +{
> +    int i;
> +    bool ready =3D false;
> +
> +    for (i =3D 0; i < 10; i++) {
> +        if (nvme_cqe_pending(sq->cq)) {
> +            ready =3D true;
> +            break;
> +        }
> +
> +        g_usleep(1000);
> +    }
> +
> +    g_assert(ready);
> +
> +    return nvme_handle_cqe(sq);
> +}
> +
> +static uint64_t nvme_get_next_sqe(nvme_sq *sq, uint8_t opcode,
> +                                  uint16_t cid, uint64_t prp1)
> +{
> +    uint64_t phys_sqe =3D PHYS_ADDR_OF(NvmeCmd, sq->phys_sqe, [sq->tail]=
);
> +
> +    if (((sq->tail + 1) % sq->common.size) =3D=3D sq->head) {
> +        /* no space in SQ */
> +        g_test_message("%s head %d tail %d", __func__, sq->head, sq->tai=
l);
> +        g_assert_not_reached();
> +        return 0;
> +    }
> +
> +    qtest_memset(sq->common.ctrl->pdev->bus->qts,
> +                 phys_sqe, 0, sizeof(NvmeCmd));
> +
> +    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
> +        fn(sq->common.ctrl->pdev->bus->qts, phys_addr, (val))
> +
> +    GUEST_MEM_WRITE(qtest_writeb,
> +                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, opcode), opcod=
e);
> +    GUEST_MEM_WRITE(qtest_writew,
> +                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, cid), cid);
> +    GUEST_MEM_WRITE(qtest_writeq,
> +                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, dptr.prp1), pr=
p1);
> +
> +    #undef GUEST_MEM_WRITE
> +
> +    g_test_message("sq %p next_sqe %u sqe 0x%" PRIx64, sq, sq->tail, phy=
s_sqe);
> +    return phys_sqe;
> +}
> +
> +static void nvme_commit_sqe(nvme_sq *sq)
> +{
> +    g_test_message("sq %p commit sqe tail %u", sq, sq->tail);
> +    sq->tail =3D (sq->tail + 1) % sq->common.size;
> +    qpci_io_writel(sq->common.ctrl->pdev, sq->common.ctrl->bar,
> +                   sq->common.doorbell, sq->tail);
> +}
> +
> +static uint64_t nvme_admin_identify_ctrl(nvme_ctrl *ctrl,
> +                                         uint16_t cid, bool no_wait)
> +{
> +    uint64_t phys_cmd_identify; /* NvmeCmd* */
> +    uint64_t phys_identify; /* NvmeIdCtrl* */
> +    NvmeCqe cqe;
> +
> +    g_test_message("sending req cid %u no_wait %d", cid, no_wait);
> +
> +    phys_identify =3D guest_alloc(ctrl->alloc, sizeof(NvmeIdCtrl));
> +    g_assert(phys_identify);
> +
> +    phys_cmd_identify =3D nvme_get_next_sqe(&ctrl->admin_sq,
> +                                          NVME_ADM_CMD_IDENTIFY, cid,
> +                                          phys_identify);
> +    g_assert(phys_cmd_identify);
> +
> +    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
> +        fn(ctrl->pdev->bus->qts, phys_addr, (val))
> +
> +    GUEST_MEM_WRITE(qtest_writel,
> +                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_cmd_identify, nsid)=
, 0);
> +    GUEST_MEM_WRITE(qtest_writel,
> +                    PHYS_ADDR_OF_FIELD(NvmeIdentify, phys_cmd_identify, =
cns),
> +                    NVME_ID_CNS_CTRL);
> +
> +    #undef GUEST_MEM_WRITE
> +
> +    nvme_commit_sqe(&ctrl->admin_sq);
> +
> +    if (no_wait) {
> +        return phys_identify;
> +    }
> +
> +    cqe =3D nvme_wait(&ctrl->admin_sq);
> +    g_assert(nvme_is_cqe_success(&cqe));
> +    g_assert(le16_to_cpu(cqe.cid) =3D=3D cid);
> +
> +    return phys_identify;
> +}
> +
> +static void nvme_wait_ready(nvme_ctrl *ctrl, int val)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < 10; i++) {
> +        uint32_t csts =3D qpci_io_readl(ctrl->pdev, ctrl->bar, NVME_REG_=
CSTS);
> +        g_test_message("%s: csts %x", __func__, csts);
> +
> +        if (NVME_CSTS_RDY(csts) =3D=3D val) {
> +            return;
> +        }
> +
> +        g_usleep(1000);
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +static void test_migrate_setup_nvme_ctrl(nvme_ctrl *ctrl)
> +{
> +    uint64_t cap;
> +
> +    /* disable controller */
> +    qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_CC, 0);
> +    nvme_wait_ready(ctrl, 0);
> +
> +    cap =3D qpci_io_readq(ctrl->pdev, ctrl->bar, NVME_REG_CAP);
> +    ctrl->db_stride =3D 4 << NVME_CAP_DSTRD(cap);
> +
> +    nvme_init_cq(ctrl, &ctrl->admin_cq, 1, 2 /* CQEs num */);
> +    nvme_init_sq(ctrl, &ctrl->admin_sq, 0, 4 /* SQEs num */, &ctrl->admi=
n_cq);
> +
> +    qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_AQA,
> +        ((ctrl->admin_cq.common.size - 1) << AQA_ACQS_SHIFT) |
> +        ((ctrl->admin_sq.common.size - 1) << AQA_ASQS_SHIFT)
> +    );
> +
> +    qpci_io_writeq(ctrl->pdev, ctrl->bar,
> +                   NVME_REG_ASQ, (uint64_t)ctrl->admin_sq.phys_sqe);
> +    qpci_io_writeq(ctrl->pdev, ctrl->bar,
> +                   NVME_REG_ACQ, (uint64_t)ctrl->admin_cq.phys_cqe);
> +
> +    /* enable controller */
> +    {
> +        uint32_t cc =3D 0;
> +        NVME_SET_CC_EN(cc, 1);
> +        qpci_io_writel(ctrl->pdev, ctrl->bar, NVME_REG_CC, cc);
> +    }
> +
> +    nvme_wait_ready(ctrl, 1);
> +}
> +
> +typedef struct test_migrate_req {
> +    uint16_t cid;
> +    bool handle_cqe;
> +    uint64_t phys_identify; /* NvmeIdCtrl* */
> +} test_migrate_req;
> +
> +static void test_migrate_send_nvme_reqs(nvme_ctrl *ctrl, test_migrate_re=
q *reqs,
> +                                        int num)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < num; i++) {
> +        reqs[i].phys_identify =3D nvme_admin_identify_ctrl(ctrl, reqs[i]=
=2Ecid,
> +                                                         !reqs[i].handle=
_cqe);
> +        g_assert(reqs[i].phys_identify);
> +
> +        if (reqs[i].handle_cqe) {
> +            guest_free(ctrl->alloc, reqs[i].phys_identify);
> +        }
> +    }
> +}
> +
> +static void test_migrate_check_nvme(nvme_ctrl *ctrl,
> +                                    test_migrate_req *reqs, int num)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < num; i++) {
> +        NvmeCqe cqe;
> +
> +        if (reqs[i].handle_cqe) {
> +            continue;
> +        }
> +
> +        cqe =3D nvme_wait(&ctrl->admin_sq);
> +        g_assert(nvme_is_cqe_success(&cqe));
> +
> +        g_assert_cmpint(le16_to_cpu(cqe.cid), =3D=3D, reqs[i].cid);
> +
> +        #define GUEST_MEM_READB(phys_addr) \
> +                    qtest_readb(ctrl->pdev->bus->qts, (phys_addr))
> +
> +        g_assert_cmpint(GUEST_MEM_READB(
> +            PHYS_ADDR_OF_FIELD(NvmeIdCtrl, reqs[i].phys_identify, ieee[0=
])),
> +            =3D=3D, 0x0);
> +        g_assert_cmpint(GUEST_MEM_READB(
> +            PHYS_ADDR_OF_FIELD(NvmeIdCtrl, reqs[i].phys_identify, ieee[1=
])),
> +            =3D=3D, 0x54);
> +        g_assert_cmpint(GUEST_MEM_READB(
> +            PHYS_ADDR_OF_FIELD(NvmeIdCtrl, reqs[i].phys_identify, ieee[2=
])),
> +            =3D=3D, 0x52);
> +
> +        #undef GUEST_MEM_READB
> +
> +        guest_free(ctrl->alloc, reqs[i].phys_identify);
> +    }
> +}
> +
> +static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    g_autofree gchar *tmpfs =3D NULL;
> +    GError *err =3D NULL;
> +    g_autofree gchar *mig_path =3D NULL;
> +    g_autofree gchar *uri =3D NULL;
> +    GString *dest_cmdline;
> +    QTestState *to;
> +    QDict *rsp;
> +    QNvme *nvme =3D obj;
> +    QPCIDevice *pdev =3D &nvme->dev;
> +    g_autofree nvme_ctrl *ctrl =3D NULL;
> +    test_migrate_req test_reqs[] =3D {
> +        { 123, true },
> +        { 456, false },
> +        { 300, false },
> +        { 333, false }
> +    };
> +
> +    if (qpci_check_buggy_msi(pdev)) {
> +        return;
> +    }
> +
> +    /* create temporary dir and prepare unix socket path for migration */
> +    tmpfs =3D g_dir_make_tmp("nvme-test-XXXXXX", &err);
> +    if (!tmpfs) {
> +        g_test_message("Can't create temporary directory in %s: %s",
> +                       g_get_tmp_dir(), err->message);
> +        g_error_free(err);
> +    }
> +    g_assert(tmpfs);
> +
> +    mig_path =3D g_strdup_printf("%s/socket.mig", tmpfs);
> +    uri =3D g_strdup_printf("unix:%s", mig_path);
> +
> +    /* enable NVMe PCI device */
> +    qpci_device_enable(pdev);
> +
> +    ctrl =3D g_malloc0(sizeof(*ctrl));
> +    ctrl->alloc =3D alloc;
> +    ctrl->pdev =3D pdev;
> +    ctrl->bar =3D qpci_iomap(ctrl->pdev, 0, NULL);
> +    g_assert(pdev->bus->qts =3D=3D global_qtest);
> +
> +    test_migrate_setup_nvme_ctrl(ctrl);
> +    test_migrate_send_nvme_reqs(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
> +
> +    qpci_iounmap(ctrl->pdev, ctrl->bar);
> +
> +    dest_cmdline =3D g_string_new(qos_get_current_command_line());
> +    g_string_append_printf(dest_cmdline, " -incoming %s", uri);
> +
> +    /* Create destination VM */
> +    to =3D qtest_init(dest_cmdline->str);
> +
> +    /* Get access to PCI device from destination VM */
> +    nvme =3D qos_allocate_objects(to, &ctrl->alloc);
> +    pdev =3D &nvme->dev;
> +    ctrl->pdev =3D pdev;
> +    ctrl->bar =3D qpci_iomap(ctrl->pdev, 0, NULL);
> +    g_assert(pdev->bus->qts =3D=3D to);
> +
> +    /* Migrate VM */
> +    rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", =
uri);
> +    g_assert(qdict_haskey(rsp, "return"));
> +    qobject_unref(rsp);
> +
> +    /* Wait when source VM is stopped */
> +    qmp_eventwait("STOP");
> +
> +    /* Copy guest physical memory allocator state */
> +    migrate_allocator(alloc, ctrl->alloc);
> +
> +    /* Wait for destination VM to become alive */
> +    qtest_qmp_eventwait(to, "RESUME");
> +
> +    test_migrate_check_nvme(ctrl, test_reqs, ARRAY_SIZE(test_reqs));
> +
> +    qpci_iounmap(ctrl->pdev, ctrl->bar);
> +
> +    qtest_quit(to);
> +    g_unlink(mig_path);
> +    g_rmdir(tmpfs);
> +    g_string_free(dest_cmdline, true);
> +}
> +
>  static void nvme_register_nodes(void)
>  {
>      QOSGraphEdgeOptions opts =3D {
> @@ -168,6 +585,8 @@ static void nvme_register_nodes(void)
>      });
> =20
>      qos_add_test("reg-read", "nvme", nvmetest_reg_read_test, NULL);
> +
> +    qos_add_test("migrate", "nvme", test_migrate, NULL);
>  }
> =20
>  libqos_init(nvme_register_nodes);
> --=20
> 2.47.3
>=20
>=20

--TQ/nd/kayTdWZ675
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmoxQP8ACgkQTeGvMW1P
Dem7Fwf+NadoShZy+30gOstn+l3Bwic33lG2X6fp2NNxKpvbXvX40lN1XXE+fXDD
ECNhKfaFxi2ZvRwn8NCZ2AKkq5xnMTe6GmjC8USz13XE9KSxw+TEcbH3WxOugfg/
78TZVwvRAZnvYjY3dbbzHdg37zydTvTJX1iUhtfEHe4QBHADjyk5SxF2SHfiJqzS
5UnRgwCYoX5dA8rAvPcJQjNAH49CWxnRH2HozdQMobkz+rt8krda70mUUIZOgnlo
xeylJdK2WOFkmPJMa22mlmw1AtiaqpQeRoALxUSEDAZAq9lSQKihBSKwfJg3ztrn
E+M0BLU1BM1mTOxM/M3Jg2c3O0j6SQ==
=jPtk
-----END PGP SIGNATURE-----

--TQ/nd/kayTdWZ675--

