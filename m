Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568EAD13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYg7-0007c1-Bz; Mon, 26 Jan 2026 21:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1vkYg5-0007Z7-7n; Mon, 26 Jan 2026 21:19:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1vkYg1-0005xi-Ki; Mon, 26 Jan 2026 21:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202512; t=1769480365;
 bh=5iJ2V8n3zPcV7UvvPjzyfXR/PUeHMFYrBHQkiH8a01A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tX7s7ibLWklHRXqcyYVzc8kOeombtScnekeTn3IjBDbDWJ6VXXedADG7v5WBPUDKP
 JwredxZtB+bbOV7l1GDrwg+W7wi6X9/YUvYb10cMLmV/JjrkGDXFWqGQI4zxpbbYcO
 XEHVEjAHLzEnMZuiby+C3LAbT2jTvMKS3JsJJXTW4Xm0bhop7EiU2oTkic7bFBFgcU
 kCH8iq+YNSOwDQJGJ26/pBI3Kc/jkB2oJUYra9oZqsD6oU4D+71P0eX927qxO3bTKZ
 0+GovOyvKbDyNbAuwLYN3me+dUP5Z1nFUNVLbq9olt7XWnP3iOQ41muN2ZKDylTY4E
 fs0tN2gF1LIsA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4f0TcY4qX6z4wDK; Tue, 27 Jan 2026 13:19:25 +1100 (AEDT)
Date: Tue, 27 Jan 2026 12:56:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 01/27] system/device_tree: update qemu_fdt_getprop/_cell
Message-ID: <aXgbYR9Sdu7dIHdY@zatzit>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <20260126174313.1418150-2-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tzRUzN9NRwtK7ve3"
Content-Disposition: inline
In-Reply-To: <20260126174313.1418150-2-ruslichenko.r@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--tzRUzN9NRwtK7ve3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 06:42:47PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>=20
> Update 'qemu_fdt_getprop' and 'qemu_fdt_getprop_cell'
> to support property inheritence from parent node,
> in case 'inherit' argument is set.

A bare bool parameter is pretty ugly and requires updating every
existing caller.  I'd suggest adding a new function for the inheriting
version, instead.

> Update 'qemu_fdt_getprop_cell' to allow accessing
> specific cells within multi-cell property array.
>=20
> Introduced 'qemu_devtreedd_getparent' as it is needed
> by both internal and external users.
>=20
> This will be used by hardware device tree parsing logic.
>=20
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  hw/arm/boot.c                |  8 ++++----
>  hw/arm/raspi4b.c             |  8 ++++----
>  hw/arm/vexpress.c            |  4 ++--
>  hw/arm/xlnx-zcu102.c         |  3 ++-
>  include/system/device_tree.h | 32 +++++++++++++++++++-------------
>  system/device_tree.c         | 33 ++++++++++++++++++++++++---------
>  6 files changed, 55 insertions(+), 33 deletions(-)
>=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c97d4c4e11..829b8ba12f 100644
[snip]
> diff --git a/include/system/device_tree.h b/include/system/device_tree.h
> index 49d8482ed4..f34b8b7ef9 100644
> --- a/include/system/device_tree.h
> +++ b/include/system/device_tree.h
> @@ -96,27 +96,28 @@ int qemu_fdt_setprop_phandle(void *fdt, const char *n=
ode_path,
>   * @node_path: node path
>   * @property: name of the property to find
>   * @lenp: fdt error if any or length of the property on success
> + * @inherit: if not found in node, look for property in parent
>   * @errp: handle to an error object
>   *
>   * returns a pointer to the property on success and NULL on failure
>   */
>  const void *qemu_fdt_getprop(void *fdt, const char *node_path,
>                               const char *property, int *lenp,
> -                             Error **errp);
> +                             bool inherit, Error **errp);
>  /**
> - * qemu_fdt_getprop_cell: retrieve the value of a given 4 byte property
> - * @fdt: pointer to the device tree blob
> - * @node_path: node path
> - * @property: name of the property to find
> - * @lenp: fdt error if any or -EINVAL if the property size is different =
=66rom
> - *        4 bytes, or 4 (expected length of the property) upon success.
> - * @errp: handle to an error object
> - *
> - * returns the property value on success
> - */

Spurious change to all the whitespace here.

> +* qemu_fdt_getprop_cell: retrieve the value of a given 4 byte property

This description is no longer accurate after your change.

> +* @fdt: pointer to the device tree blob
> +* @node_path: node path
> +* @property: name of the property to find
> +* @ofset: the index of 32bit cell to retrive

s/ofset/offset/.  But, in any case in libfdt context 'offset' always
refers to a byte offset, so I think this is a potentially misleading
name.

> +* @inherit: if not found in node, look for property in parent
> +* @errp: handle to an error object
> +*
> +* returns the property value on success
> +*/
>  uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
> -                               const char *property, int *lenp,
> -                               Error **errp);
> +                               const char *property, int offset,
> +                               bool inherit, Error **errp);
>  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
>  uint32_t qemu_fdt_alloc_phandle(void *fdt);
>  int qemu_fdt_nop_node(void *fdt, const char *node_path);
> @@ -193,6 +194,11 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fd=
t,
>      })
> =20
> =20
> +int qemu_devtree_getparent(void *fdt, char *node_path,
> +                           const char *current);
> +
> +#define DT_PATH_LENGTH 1024
> +
>  /**
>   * qemu_fdt_randomize_seeds:
>   * @fdt: device tree blob
> diff --git a/system/device_tree.c b/system/device_tree.c
> index 1ea1962984..41bde0ba5a 100644
> --- a/system/device_tree.c
> +++ b/system/device_tree.c
> @@ -429,7 +429,8 @@ int qemu_fdt_setprop_string_array(void *fdt, const ch=
ar *node_path,
>  }
> =20
>  const void *qemu_fdt_getprop(void *fdt, const char *node_path,
> -                             const char *property, int *lenp, Error **er=
rp)
> +                             const char *property, int *lenp,
> +                             bool inherit, Error **errp)
>  {
>      int len;
>      const void *r;
> @@ -439,31 +440,35 @@ const void *qemu_fdt_getprop(void *fdt, const char =
*node_path,
>      }
>      r =3D fdt_getprop(fdt, findnode_nofail(fdt, node_path), property, le=
np);
>      if (!r) {
> +        char parent[DT_PATH_LENGTH];
> +        if (inherit && !qemu_devtree_getparent(fdt, parent, node_path)) {
> +            return qemu_fdt_getprop(fdt, parent, property, lenp, true, e=
rrp);
> +        }

This is a pretty horribly expensive way of doing it.  On a flattened
tree, findnode_nofail() and devtree_getparent() each need to scan the
tree from the start, and you do both for each layer of the tree.  You
could instead scan the tree once from the root, updating a pointer to
the deepest copy of the property found so far.

>          error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
>                    node_path, property, fdt_strerror(*lenp));
> +        return NULL;
>      }
>      return r;
>  }
> =20
>  uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
> -                               const char *property, int *lenp, Error **=
errp)
> +                               const char *property, int offset,
> +                               bool inherit, Error **errp)
>  {
>      int len;
>      const uint32_t *p;
> =20
> -    if (!lenp) {
> -        lenp =3D &len;
> -    }
> -    p =3D qemu_fdt_getprop(fdt, node_path, property, lenp, errp);
> +    p =3D qemu_fdt_getprop(fdt, node_path, property, &len,
> +                                         inherit, errp);
>      if (!p) {
>          return 0;
> -    } else if (*lenp !=3D 4) {
> +    }
> +    if (len < (offset + 1) * 4) {
>          error_setg(errp, "%s: %s/%s not 4 bytes long (not a cell?)",
>                     __func__, node_path, property);

Error message is no longer accurate.

> -        *lenp =3D -EINVAL;
>          return 0;
>      }
> -    return be32_to_cpu(*p);
> +    return be32_to_cpu(p[offset]);
>  }
> =20
>  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
> @@ -633,6 +638,16 @@ out:
>      return ret;
>  }
> =20
> +int qemu_devtree_getparent(void *fdt, char *node_path, const char *curre=
nt)

This inherently needs to scan the tree from the beginning at least
once, but the implementation is much worse than that.

> +{
> +    int offset =3D fdt_path_offset(fdt, current);

This scans the tree from the start.

> +    int parent_offset =3D fdt_supernode_atdepth_offset(fdt, offset,
> +        fdt_node_depth(fdt, offset) - 1, NULL);

This does it twice more (one for fdt_node_depth() and one for
fdt_supernode_atdepth_offset()).

> +
> +    return parent_offset >=3D 0 ?
> +        fdt_get_path(fdt, parent_offset, node_path, DT_PATH_LENGTH) : 1;

This does it a fourth time.

Since you're starting from a path, not an offset, you could instead
chop off the last path component, then do a single fdt_get_path().

> +}
> +
>  void qmp_dumpdtb(const char *filename, Error **errp)
>  {
>      ERRP_GUARD();
> --=20
> 2.43.0
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--tzRUzN9NRwtK7ve3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAml4G1AACgkQzQJF27ox
2GfN4A/9FH6aQTRZ4+V3t8NU0CLLdsqqOVpixDppTcyjaqOLf+8Oi/8qBM2vxh55
dn/k6sG3DuT+/172nGdlAhRHwsSArQBBHYY9PFRuUgCrgBB9zXhDFjuD5Joz8qTm
rMix3iHUaiLeMXeWzIB8YAkbI5bncdAwdrdHEqeiG9zTpFCc2S1xsfAYzZ6/9+Uc
3+mEjW2eTgd6oE2ebns+a59//+z1qEih28unfATyx27zMVkixxNhlfLl8xehUcp9
WjFCoG/D3XknzWqejH5zR4WsWp01DJ1scKz+rDxni0LontfVvfRqzRPbnoCyTPD9
m6TfQj8/yY1IRNHa0CvpeF+KzxihwUsKMpEMUoyt2M57zZRk/n0LmHtFOUYEZzUB
X9LgOot8n/cghZJ3F/o8QXQ1+PzYUFXfAgkVpkY543hzbbTkf4zQe/xzkzel8/6B
vFx/SivznVbminf5qU8kLNcr4SS5g7oR5RI7EIJNsFZBWw62JesSs0XBWX+bxmFz
UWusVJqgPEtxA4EGmUCMqlZq6DfWQv5fsLbsIiuJnSWvGeAaV0ois4SS4RudqasP
Vbce9p2m6A+vo7BvdMmXKawIxOgalc+fbhzGchGQIeEvAraEI4BFwcpesrcvW2IX
oaTTKbhCbPsl6zx7gR17+Wfr/5b51mg8uEke9vwdyqzEh8HLZfM=
=u3Rl
-----END PGP SIGNATURE-----

--tzRUzN9NRwtK7ve3--

