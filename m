Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A855CC6B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 00:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Sm2-00051Z-Bo; Thu, 02 Apr 2026 20:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1w8Sm0-00051I-HN; Thu, 02 Apr 2026 20:52:32 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1w8Slv-0003cH-QR; Thu, 02 Apr 2026 20:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202602; t=1775177536;
 bh=69SJj6SyLHhTzx7sxXWcNj0oPGwYP+ziwDPYCDPLbuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKnZ20KDU8qv1K8MpDm5ZppUQfI7joAn0tYkKb5iaRcdRDPWHy5dHGLRIH/dVhUDL
 z3+H8inx8C3frOdjmQOODr9quAWW1UFYfaj+Ef0Enn10/aT9MKmuT8g/Mfz20rOycT
 UPIjTf5oOyprN4/U1eReV5k81TsrAMQH1dBL4jnGSlEUf1w35H/79ku5JoCz0kQ3H4
 lg/MwpDE4HyW+ResZv6UsEvIP6RJ83xxHqB9/4TWSzjrydJi1Fn1tqOXV0lqc5M9dm
 W8FHb3A+wkFXVbI6BbUW6wFCDVI6EW01Ii7thKKpWw1RcdyMnoRC/jt/Qf2CvIxLDu
 LQ121dmisEkng==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4fn0YX4MNfz4wT1; Fri, 03 Apr 2026 11:52:16 +1100 (AEDT)
Date: Fri, 3 Apr 2026 11:52:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 02/33] system/device_tree: add few parsing and
 traversal helpers
Message-ID: <ac8PO_EpAiWxczDy@zatzit>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
 <20260402215629.745866-3-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bbeq6yawVZfWWRwW"
Content-Disposition: inline
In-Reply-To: <20260402215629.745866-3-ruslichenko.r@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--bbeq6yawVZfWWRwW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 11:55:47PM +0200, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>=20
> The patch adds few utility functions for parsing FDT nodes.
> The helpers are required for upcoming Hardware device tree
> feature.

If you're building an entire fdt based machine type, it really seems
like you might want a "live" dt representation - the flattened format
is great for communicating between things, but it's not a good data
structure if you're actively consulting it.

>=20
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  include/system/device_tree.h |  22 ++++
>  system/device_tree.c         | 194 +++++++++++++++++++++++++++++++++++
>  2 files changed, 216 insertions(+)
>=20
> diff --git a/include/system/device_tree.h b/include/system/device_tree.h
> index 5667ff9538..bc378d38d0 100644
> --- a/include/system/device_tree.h
> +++ b/include/system/device_tree.h
> @@ -116,6 +116,11 @@ const void *qemu_fdt_getprop(void *fdt, const char *=
node_path,
>  uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
>                                 const char *property, int cell_id,
>                                 Error **errp);
> +
> +const void *qemu_fdt_getprop_inherited(void *fdt, const char *node_path,
> +                             const char *property, int *lenp, Error **er=
rp);
> +uint32_t qemu_fdt_getprop_cell_inherited(void *fdt, const char *node_pat=
h,
> +                               const char *property, int cell_id, Error =
**errp);
>  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
>  uint32_t qemu_fdt_alloc_phandle(void *fdt);
>  int qemu_fdt_nop_node(void *fdt, const char *node_path);
> @@ -191,6 +196,23 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fd=
t,
>                                                  qdt_tmp);               =
  \
>      })
> =20
> +/* node queries */
> +
> +int qemu_devtree_get_num_children(void *fdt, const char *node_path);
> +int qemu_devtree_get_children(void *fdt, const char *node_path,
> +                                     int max_paths, char **returned_path=
s);
> +int qemu_devtree_num_props(void *fdt, const char *node_path);
> +
> +/* node getters */
> +
> +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int pha=
ndle);
> +char *qemu_devtree_getparent(void *fdt, const char *current);
> +
> +/* misc */
> +
> +int devtree_get_num_nodes(void *fdt);
> +
> +#define DT_PATH_LENGTH 1024
> =20
>  /**
>   * qemu_fdt_randomize_seeds:
> diff --git a/system/device_tree.c b/system/device_tree.c
> index d2db7bd355..1a70223712 100644
> --- a/system/device_tree.c
> +++ b/system/device_tree.c
> @@ -464,6 +464,96 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const char=
 *node_path,
>      return be32_to_cpu(p[cell_id]);
>  }
> =20
> +const void *qemu_fdt_getprop_inherited(void *fdt, const char *node_path,
> +                             const char *property, int *lenp, Error **er=
rp)
> +{
> +    const void *found_val =3D NULL;
> +    int found_len =3D 0;
> +    int curr_offset =3D 0;
> +    int temp_len;
> +    char **tokens;
> +    char **iter;
> +
> +    found_val =3D fdt_getprop(fdt, 0, property, &found_len);
> +
> +    tokens =3D g_strsplit(node_path + 1, "/", -1);
> +
> +    for (iter =3D tokens; *iter !=3D NULL; iter++) {
> +        if (**iter =3D=3D '\0') {
> +            continue;
> +        }
> +
> +        curr_offset =3D fdt_subnode_offset(fdt, curr_offset, *iter);
> +        if (curr_offset < 0) {
> +            error_setg(errp, "%s: Path '%s' not found",
> +                       __func__, *iter);
> +            g_strfreev(tokens);
> +            return NULL;
> +        }
> +
> +        const void *val =3D fdt_getprop(fdt, curr_offset, property, &tem=
p_len);
> +        if (val) {
> +            found_val =3D val;
> +            found_len =3D temp_len;
> +        }
> +    }
> +    g_strfreev(tokens);
> +
> +    if (!found_val) {
> +        error_setg(errp, "%s: Property '%s' not found",
> +                   __func__, property);
> +        return NULL;
> +    }
> +
> +    if (lenp) {
> +        *lenp =3D found_len;
> +    }
> +
> +    return found_val;
> +}
> +
> +uint32_t qemu_fdt_getprop_cell_inherited(void *fdt, const char *node_pat=
h,
> +                               const char *property, int cell_id, Error =
**errp)
> +{
> +    int len;
> +    const uint32_t *p;
> +
> +    p =3D qemu_fdt_getprop_inherited(fdt, node_path, property, &len, err=
p);
> +    if (!p) {
> +        return 0;
> +    }
> +    if (len < (cell_id + 1) * 4) {
> +        error_setg(errp,
> +                   "%s: %s/%s is too short, need %d bytes for cell ind %=
d",
> +                   __func__, node_path, property, (cell_id + 1) * 4, cel=
l_id);
> +        return 0;
> +    }
> +    return be32_to_cpu(p[cell_id]);
> +}
> +
> +char *qemu_devtree_getparent(void *fdt, const char *current)
> +{
> +    const char *sep;
> +    int len;
> +
> +    if (!current || !strcmp(current, "/")) {
> +        return NULL;
> +    }
> +
> +    sep =3D strrchr(current, '/');
> +    if (!sep) {
> +        return NULL;
> +    }
> +
> +    if (sep =3D=3D current) {
> +        len =3D 1;
> +    } else {
> +        len =3D sep - current;
> +    }
> +
> +    return g_strndup(current, len);
> +}
> +
>  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
>  {
>      uint32_t r;
> @@ -631,6 +721,110 @@ out:
>      return ret;
>  }
> =20
> +int qemu_devtree_num_props(void *fdt, const char *node_path)
> +{
> +    int offset =3D fdt_path_offset(fdt, node_path);
> +    int ret =3D 0;
> +
> +    for (offset =3D fdt_first_property_offset(fdt, offset);
> +            offset !=3D -FDT_ERR_NOTFOUND;
> +            offset =3D fdt_next_property_offset(fdt, offset)) {
> +        ret++;
> +    }
> +    return ret;
> +}
> +
> +int qemu_devtree_get_children(void *fdt, const char *node_path,
> +                                     int max_paths, char **returned_path=
s)
> +{
> +    int count =3D 0;
> +    int subnode;
> +    const char *name;
> +    int offset =3D fdt_path_offset(fdt, node_path);
> +
> +    if (offset < 0) {
> +        return offset;
> +    }
> +
> +    bool is_root =3D (strcmp(node_path, "/") =3D=3D 0);
> +
> +    fdt_for_each_subnode(subnode, fdt, offset) {
> +        if (count >=3D max_paths) {
> +            break;
> +        }
> +        name =3D fdt_get_name(fdt, subnode, NULL);
> +        if (returned_paths) {
> +            returned_paths[count] =3D g_strdup_printf("%s/%s",
> +                                                is_root ? "" : node_path=
, name);
> +        }
> +
> +        ++count;
> +    }
> +
> +    return count;
> +}
> +
> +int qemu_devtree_get_num_children(void *fdt, const char *node_path)
> +{
> +    int count =3D 0;
> +    int subnode;
> +    int offset =3D fdt_path_offset(fdt, node_path);
> +
> +    if (offset < 0) {
> +        return offset;
> +    }
> +
> +    fdt_for_each_subnode(subnode, fdt, offset) {
> +        ++count;
> +    }
> +
> +    return count;
> +}
> +
> +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int pha=
ndle)
> +{
> +    int offset =3D 0, cur_depth =3D 0;
> +    int path_lens[64] =3D { 0 };
> +
> +    for (offset =3D 0; offset >=3D 0; offset =3D fdt_next_node(fdt, offs=
et,
> +                                                         &cur_depth)) {
> +        if (cur_depth >=3D 64) {
> +            break;
> +        }
> +        const char *name =3D fdt_get_name(fdt, offset, NULL);
> +
> +        int parent_len =3D (cur_depth > 0) ? path_lens[cur_depth - 1] : =
0;
> +        int len =3D snprintf(node_path + parent_len,
> +                             DT_PATH_LENGTH - parent_len,
> +                             "%s%s",
> +                             (parent_len > 1) ? "/" : "",
> +                             (cur_depth =3D=3D 0) ? "/" : name);
> +
> +        path_lens[cur_depth] =3D parent_len + len;
> +
> +        if (fdt_get_phandle(fdt, offset) =3D=3D phandle) {
> +            return 0;
> +        }
> +    }
> +
> +    return -FDT_ERR_NOTFOUND;
> +}
> +
> +int devtree_get_num_nodes(void *fdt)
> +{
> +    int num_nodes =3D 0;
> +    int depth =3D 0, offset =3D 0;
> +
> +    for (;;) {
> +        offset =3D fdt_next_node(fdt, offset, &depth);
> +        num_nodes++;
> +        if (offset <=3D 0 || depth <=3D 0) {
> +            break;
> +        }
> +    }
> +    return num_nodes;
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

--bbeq6yawVZfWWRwW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmnPDy4ACgkQzQJF27ox
2GfyvBAAn4JQvP6WpePpp6QeS55Jp2Kgb7uaCPtb/sJt3g0DBJ7DuydDnmIer2AI
15lBre2vjlJ8C8UEby+x637hDJ+e2pVK16/qOdCQXlz/kKtX/Eeq3L2PTquOv84L
qXCuoZ26w7L+91OKvyg4Jgr2f0fxjTej3xLzwq22dwIlkvOfYtWNTQ0x8R2qrmM7
7NxFN7+3zOPoWD5KXa+LdjW6C7weAKVHb/526MntZ3teK6p355ALHnMY1d0uny5R
uRSkj4+PsFEK+b18e1HWHQEXGz1+Cb//wFiOBjKxjtN6rVdd1OPn0wMGDyDWHaq5
zKIGoCYS9Ujvzmweg3gJaiIvwWfwMr067gVzwFfm8c5qRRG4L/BqmNJfphjwR3ab
OQVEms19BFQhDokrIjI5FxHEpm4SyOajRuWnQ+xNG2EE5ilkA23KbNzNeTXEF03d
gvOczShqwV+B0HwgxaskOmHARyZLWFhe1cOvPgh0qRr8s4jebWk33wZ0RtcG8/bm
vEIrhavGJmeTJH8NPGFp/A5TPwBNCVMLQy2N6SHlcMFqmSy9tCq4fTtecCK7Bwbk
5e4tlzJwv6Fa6OFvDfTR3uTDLrvYDmuJOFO+XkEGPVvznEFUcovFFBw0LNXwP+qY
h20Rlwb32IcgvPVjah7/EG9Jj8uK1kTVNGwd73xItGYdRWJN3po=
=aYaQ
-----END PGP SIGNATURE-----

--bbeq6yawVZfWWRwW--

