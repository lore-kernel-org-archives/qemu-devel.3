Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E48C3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRDy-0004mw-Fa; Wed, 26 Mar 2025 09:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txRDw-0004mY-E9
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:55:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txRDt-0002r6-LP
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:55:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5ea062471so1146284a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1742997311; x=1743602111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09g9flF/oFbPk/xe12aV0T7C1CZv1MMQKeIeigDsuyg=;
 b=cTu1yjOj7IJapXNdjw6te2fqlOLvqrsRE9WimRwSNaAPoPeaLfTqOOulZFaju8UdRb
 jIRiocPA3lTJHs9kgNbHfGdBMqtbTJTAwrNLQxqFT6B5ctZz98QVT3HV2R0PPicw+HP1
 uwObF//y3/1ua99FGOnbS7Eq5yfPDJljkTrVVvOOoItW0DFdXp/wzMjEQTwexS3FIqCK
 2NYbeuPCSWJkvrP9GPqCZ205Sr6BMQAeTnUB9R07eTOa7QLOwtkcBmYo4IDT3Sl6tjV2
 aRiSPZov0h1RHuQdMdBDl8C8RHLWlaKEnzThS542RteZSE1DmppJFvepwukF0hRW6KfR
 s7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742997311; x=1743602111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09g9flF/oFbPk/xe12aV0T7C1CZv1MMQKeIeigDsuyg=;
 b=A5xcA/lQM41Kyd9/wisGunV9sK4D6MW3AqQz1zCgBLAbJzPpJ7dGavgaBKoUJB/SLf
 LgEhk8XtaqJp69kWplsvfu5fFQWCjiNWRxv+dUkUAH7zPZnvO9d0tsrEP9QsGv5OTuhR
 PjMUGUY62ClmF2kiyuk64i6UVKlKyXYB0bybI10t8O08xS7YhRL4OkgQp7KYFeFCl4FV
 YZKkE7VbkstFd6gTZJoPRZdU7Id1eAF34b8L819QUdAwOzZ2rRgH7Roy+Xo/VxpO6F/4
 7oB4f+sAKt9k4zi74SGNQynrl2l7GidYlwrUXdZ9/3Dw+9+mdDxyBcT/KlWpkQAOEI7T
 fSUw==
X-Gm-Message-State: AOJu0YyqH80mWSrAjeuQ1Yx/hlD/Twh6vODQ0srZ+MNHI9+g09PeeFQL
 MOqjzwGGPBb1sCZfDo5ArjzU3iWiS9keiZIbImw+zcQOJfO/phsSQzcjS/TvIyDGaHpOTuNaJKN
 Yv1fsZPjDmr2HetxQkb1ZbAKkbFMpR+Vice7jbQ==
X-Gm-Gg: ASbGnctYoMgPHqLKEFXMEG3bU34OD+Zd2XwLerHHOPBx9z3lu3FTMRNJ0j7a7kCMGc0
 U4idTMeQz6MMA72J0A3XdsRxM5tu33/STU0t4dAqeFQNBywQc08h6Ut+XWU5B23axWUrAvfDZ/k
 TgmmW3NiJoWYteqOUudiJk2MjfjA==
X-Google-Smtp-Source: AGHT+IEiG0CeRMjBSef4h/Nzd6NaSXk29KG6VohzUbm3x01H+sT5g1bHGQ3/DS0VYich/lBJlU2lhLusNVycWnvqaOw=
X-Received: by 2002:a05:6402:524f:b0:5e0:7ffd:a6ef with SMTP id
 4fb4d7f45d1cf-5ed1440e615mr2630334a12.5.1742997311425; Wed, 26 Mar 2025
 06:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250326095224.9918-1-jinpu.wang@ionos.com>
 <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
In-Reply-To: <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 26 Mar 2025 14:54:59 +0100
X-Gm-Features: AQ5f1Jq2uxj7YWrcgjc_zerZ_6EqbySsKpYmPbTIg3Ee-Kdap0zZFt6U7rSZ74o
Message-ID: <CAMGffEn514ySdg+OEmq2dBy2gyaVaWm8Le5+YyZ=Uu6gnFd9cQ@mail.gmail.com>
Subject: Re: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: michael@flatgalaxy.com
Cc: qemu-devel@nongnu.org, farosas@suse.de, peterx@redhat.com, 
 mrgalaxy@nvidia.com, Li Zhijian <lizhijian@fujitsu.com>,
 Yu Zhang <yu.zhang@ionos.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::532;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 26, 2025 at 2:47=E2=80=AFPM Michael Galaxy <michael@flatgalaxy.=
com> wrote:
>
> Excellent find. Thank you very much for checking on the history. Hopefull=
y my comments were not too hard to read. =3D)
Yeah, it's pretty clear.
>
> FYI: I've since left Akamai last year and now work at Nvidia.
>
> Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
cool, thx for the review. All the best at your new job.
>
> On 3/26/25 04:52, Jack Wang wrote:
>
> I hit following error which testing migration in pure RoCE env:
> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices=
 in your
> systems and your management software has specified '[::]', but IPv6 over =
RoCE /
> iWARP is not supported in Linux.#012'."
>
> In our setup, we use rdma bind on ipv6 on target host, while connect from=
 source
> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> fine.
>
> Checking the git history, the function was added since introducing of
> rdma migration, which is more than 10 years ago. linux-rdma has
> improved support on RoCE/iWARP for ipv6 over past years. There are a few =
fixes
> back in 2016 seems related to the issue, eg:
> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks=
")
>
> other fixes back in 2018, eg:
> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespac=
e
> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 para=
meters
> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE r=
oute
> 3c7f67d1880d IB/cma: Fix default RoCE type setting
> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
>
> So remove the outdated function and it's usage.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Cc: qemu-devel@nongnu.org
> Cc: linux-rdma@vger.kernel.org
> Cc: michael@flatgalaxy.com
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  migration/rdma.c | 157 -----------------------------------------------
>  1 file changed, 157 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 76fb0349238a..5ce628ddeef0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, str=
uct rdma_cm_id *id)
>      trace_qemu_rdma_dump_gid(who, sgid, dgid);
>  }
>
> -/*
> - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
> - * We will try the next addrinfo struct, and fail if there are
> - * no other valid addresses to bind against.
> - *
> - * If user is listening on '[::]', then we will not have a opened a devi=
ce
> - * yet and have no way of verifying if the device is RoCE or not.
> - *
> - * In this case, the source VM will throw an error for ALL types of
> - * connections (both IPv4 and IPv6) if the destination machine does not =
have
> - * a regular infiniband network available for use.
> - *
> - * The only way to guarantee that an error is thrown for broken kernels =
is
> - * for the management software to choose a *specific* interface at bind =
time
> - * and validate what time of hardware it is.
> - *
> - * Unfortunately, this puts the user in a fix:
> - *
> - *  If the source VM connects with an IPv4 address without knowing that =
the
> - *  destination has bound to '[::]' the migration will unconditionally f=
ail
> - *  unless the management software is explicitly listening on the IPv4
> - *  address while using a RoCE-based device.
> - *
> - *  If the source VM connects with an IPv6 address, then we're OK becaus=
e we can
> - *  throw an error on the source (and similarly on the destination).
> - *
> - *  But in mixed environments, this will be broken for a while until it =
is fixed
> - *  inside linux.
> - *
> - * We do provide a *tiny* bit of help in this function: We can list all =
of the
> - * devices in the system and check to see if all the devices are RoCE or
> - * Infiniband.
> - *
> - * If we detect that we have a *pure* RoCE environment, then we can safe=
ly
> - * thrown an error even if the management software has specified '[::]' =
as the
> - * bind address.
> - *
> - * However, if there is are multiple hetergeneous devices, then we canno=
t make
> - * this assumption and the user just has to be sure they know what they =
are
> - * doing.
> - *
> - * Patches are being reviewed on linux-rdma.
> - */
> -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error=
 **errp)
> -{
> -    /* This bug only exists in linux, to our knowledge. */
> -#ifdef CONFIG_LINUX
> -    struct ibv_port_attr port_attr;
> -
> -    /*
> -     * Verbs are only NULL if management has bound to '[::]'.
> -     *
> -     * Let's iterate through all the devices and see if there any pure I=
B
> -     * devices (non-ethernet).
> -     *
> -     * If not, then we can safely proceed with the migration.
> -     * Otherwise, there are no guarantees until the bug is fixed in linu=
x.
> -     */
> -    if (!verbs) {
> -        int num_devices;
> -        struct ibv_device **dev_list =3D ibv_get_device_list(&num_device=
s);
> -        bool roce_found =3D false;
> -        bool ib_found =3D false;
> -
> -        for (int x =3D 0; x < num_devices; x++) {
> -            verbs =3D ibv_open_device(dev_list[x]);
> -            /*
> -             * ibv_open_device() is not documented to set errno.  If
> -             * it does, it's somebody else's doc bug.  If it doesn't,
> -             * the use of errno below is wrong.
> -             * TODO Find out whether ibv_open_device() sets errno.
> -             */
> -            if (!verbs) {
> -                if (errno =3D=3D EPERM) {
> -                    continue;
> -                } else {
> -                    error_setg_errno(errp, errno,
> -                                     "could not open RDMA device context=
");
> -                    return -1;
> -                }
> -            }
> -
> -            if (ibv_query_port(verbs, 1, &port_attr)) {
> -                ibv_close_device(verbs);
> -                error_setg(errp,
> -                           "RDMA ERROR: Could not query initial IB port"=
);
> -                return -1;
> -            }
> -
> -            if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND) {
> -                ib_found =3D true;
> -            } else if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERN=
ET) {
> -                roce_found =3D true;
> -            }
> -
> -            ibv_close_device(verbs);
> -
> -        }
> -
> -        if (roce_found) {
> -            if (ib_found) {
> -                warn_report("migrations may fail:"
> -                            " IPv6 over RoCE / iWARP in linux"
> -                            " is broken. But since you appear to have a"
> -                            " mixed RoCE / IB environment, be sure to on=
ly"
> -                            " migrate over the IB fabric until the kerne=
l "
> -                            " fixes the bug.");
> -            } else {
> -                error_setg(errp, "RDMA ERROR: "
> -                           "You only have RoCE / iWARP devices in your s=
ystems"
> -                           " and your management software has specified =
'[::]'"
> -                           ", but IPv6 over RoCE / iWARP is not supporte=
d in Linux.");
> -                return -1;
> -            }
> -        }
> -
> -        return 0;
> -    }
> -
> -    /*
> -     * If we have a verbs context, that means that some other than '[::]=
' was
> -     * used by the management software for binding. In which case we can
> -     * actually warn the user about a potentially broken kernel.
> -     */
> -
> -    /* IB ports start with 1, not 0 */
> -    if (ibv_query_port(verbs, 1, &port_attr)) {
> -        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
> -        return -1;
> -    }
> -
> -    if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
> -        error_setg(errp, "RDMA ERROR: "
> -                   "Linux kernel's RoCE / iWARP does not support IPv6 "
> -                   "(but patches on linux-rdma in progress)");
> -        return -1;
> -    }
> -
> -#endif
> -
> -    return 0;
> -}
> -
>  /*
>   * Figure out which RDMA device corresponds to the requested IP hostname
>   * Also create the initial connection manager identifiers for opening
> @@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma,=
 Error **errp)
>          ret =3D rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
>                  RDMA_RESOLVE_TIMEOUT_MS);
>          if (ret >=3D 0) {
> -            if (e->ai_family =3D=3D AF_INET6) {
> -                ret =3D qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
> -                                                   local_errp);
> -                if (ret < 0) {
> -                    continue;
> -                }
> -            }
>              error_free(err);
>              goto route;
>          }
> @@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, =
Error **errp)
>          if (ret < 0) {
>              continue;
>          }
> -        if (e->ai_family =3D=3D AF_INET6) {
> -            ret =3D qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> -                                               local_errp);
> -            if (ret < 0) {
> -                continue;
> -            }
> -        }
>          error_free(err);
>          break;
>      }

