Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC285D13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYg7-0007bm-7h; Mon, 26 Jan 2026 21:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1vkYg5-0007Zn-EZ; Mon, 26 Jan 2026 21:19:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1vkYg1-0005xj-K2; Mon, 26 Jan 2026 21:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202512; t=1769480365;
 bh=KGhjeXDtdly0uwSRaVbnWN6sCXBfU4dNE7K1a/6yJcM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q4/Wz73/zH3VGBiCTSKI5C1i8SZ5ihSJEiqay+pxbCiaaQ55cOcsn+wqB1CDh5EK9
 YHa1bZlJDQnbSOEFtAXfhn8GYNJmJfg2RFXm2wieOEsv8xzzBFq7dBmcqAzHJOeOKf
 sEH4R28yfRA+bz5buRVACTP1+JO+sqleZLBpGIMJZ3rH+O8sH/V8Sd1u7wT6tQAJtw
 gEPmznmHH2ztnCJ7HTzS1Y5P1d2Lmdga2IET3W3limWlDTg5MZsSWRo0uRwHZGYgul
 HOQnVXbysFUDIFTIquGWqLC1JROCAybKwxLNWuf/q0BxSPFcsl7flORC4WZ1iY9ejf
 fUgcv9W5Z/MkQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4f0TcY4zFqz4wCX; Tue, 27 Jan 2026 13:19:25 +1100 (AEDT)
Date: Tue, 27 Jan 2026 13:19:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 02/27] system/device_tree: add few parsing and traversal
 helpers
Message-ID: <aXggp66YwLpvM0_4@zatzit>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <20260126174313.1418150-3-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QKp7YyVGUp8inaeB"
Content-Disposition: inline
In-Reply-To: <20260126174313.1418150-3-ruslichenko.r@gmail.com>
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


--QKp7YyVGUp8inaeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 06:42:48PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>=20
> The patch adds few utility functions for parsing FDT nodes.
> The helpers are required for upcoming Hardware device tree
> feature.
>=20
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  include/system/device_tree.h |  30 ++++++
>  system/device_tree.c         | 203 +++++++++++++++++++++++++++++++++++
>  2 files changed, 233 insertions(+)
>=20
> diff --git a/include/system/device_tree.h b/include/system/device_tree.h
> index f34b8b7ef9..458dbb74b4 100644
> --- a/include/system/device_tree.h
> +++ b/include/system/device_tree.h
> @@ -90,6 +90,13 @@ int qemu_fdt_setprop_string_array(void *fdt, const cha=
r *node_path,
>  int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
>                               const char *property,
>                               const char *target_node_path);
> +
> +uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
> +                                     const char *property, int offset,
> +                                     int size, Error **errp);
> +const char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
> +                                    const char *property, int cell,
> +                                    bool inherit, Error **errp);
>  /**
>   * qemu_fdt_getprop: retrieve the value of a given property
>   * @fdt: pointer to the device tree blob
> @@ -193,9 +200,32 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fd=
t,
>                                                  qdt_tmp);               =
  \
>      })
> =20
> +typedef struct QEMUDevtreeProp {
> +    char *name;
> +    int len;
> +    void *value;
> +} QEMUDevtreeProp;
> +
> +/* node queries */
> +
> +char *qemu_devtree_get_node_name(void *fdt, const char *node_path);
> +int qemu_devtree_get_num_children(void *fdt, const char *node_path, int =
depth);
> +char **qemu_devtree_get_children(void *fdt, const char *node_path, int d=
epth);
> +int qemu_devtree_num_props(void *fdt, const char *node_path);
> +QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path=
);
> =20
> +/* node getters */
> +
> +int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
> +                                  const char *cmpname);
> +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int pha=
ndle);
>  int qemu_devtree_getparent(void *fdt, char *node_path,
>                             const char *current);
> +int qemu_devtree_get_root_node(void *fdt, char *node_path);
> +
> +/* misc */
> +
> +int devtree_get_num_nodes(void *fdt);
> =20
>  #define DT_PATH_LENGTH 1024
> =20
> diff --git a/system/device_tree.c b/system/device_tree.c
> index 41bde0ba5a..7091a4928e 100644
> --- a/system/device_tree.c
> +++ b/system/device_tree.c
> @@ -451,6 +451,50 @@ const void *qemu_fdt_getprop(void *fdt, const char *=
node_path,
>      return r;
>  }
> =20
> +const char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
> +                                    const char *property, int cell,
> +                                    bool inherit, Error **errp)
> +{
> +    int len;
> +    const void *prop;
> +    Error *err =3D NULL;
> +
> +    if (!errp) {
> +        errp =3D &err;
> +    }
> +
> +    prop =3D qemu_fdt_getprop(fdt, node_path, property, &len, inherit, e=
rrp);
> +    if (*errp) {
> +        return NULL;
> +    }
> +    while (cell) {

In DT context, "cell" refers specifically to a 32-bit integer value.
It's not the right word for which string in a stringlist you retrieve.

Also, most of this is re-implementing fdt_stringlist_get() from libfdt.

> +        void *term =3D memchr(prop, '\0', len);
> +        size_t diff;
> +
> +        if (!term) {
> +            error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
> +                      node_path, property, fdt_strerror(len));
> +            return NULL;
> +        }
> +        diff =3D term - prop + 1;
> +        len -=3D diff;
> +        assert(len >=3D 0);
> +        prop +=3D diff;
> +        cell--;
> +    }
> +
> +    if (!len) {
> +        return NULL;
> +    }
> +
> +    if (!*(char *)prop) {
> +        error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
> +                  node_path, property, fdt_strerror(len));
> +        return NULL;
> +    }
> +    return prop;
> +}
> +
>  uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
>                                 const char *property, int offset,
>                                 bool inherit, Error **errp)
> @@ -471,6 +515,22 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const char=
 *node_path,
>      return be32_to_cpu(p[offset]);
>  }
> =20
> +uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
> +                                     const char *property, int offset,
> +                                     int size, Error **errp)
> +{

Again, "cell" is 32-bits in DT context, you need a different word.

> +    uint64_t ret =3D 0;

Since ret is a u64, 'size' must be either 1 or 2.  So you might as
well just have a get_u64() helper (getprop_cell already does u32).

> +    for (; size; size--) {
> +        ret <<=3D 32;
> +        ret |=3D qemu_fdt_getprop_cell(fdt, node_path, property, offset+=
+, false,
> +                                     errp);
> +        if (errp && *errp) {
> +            return 0;
> +        }
> +    }
> +    return ret;
> +}
> +
>  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
>  {
>      uint32_t r;
> @@ -638,6 +698,117 @@ out:
>      return ret;
>  }
> =20
> +char *qemu_devtree_get_node_name(void *fdt, const char *node_path)
> +{
> +    const char *ret =3D fdt_get_name(fdt, fdt_path_offset(fdt, node_path=
), NULL);

This does a full scan of the fdt, which may be unexpected.

> +    return ret ? strdup(ret) : NULL;
> +}
> +
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
> +QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path)
> +{
> +    QEMUDevtreeProp *ret =3D g_new0(QEMUDevtreeProp,
> +                                    qemu_devtree_num_props(fdt, node_pat=
h) + 1);
> +    int offset =3D fdt_path_offset(fdt, node_path);
> +    int i =3D 0;
> +
> +    for (offset =3D fdt_first_property_offset(fdt, offset);
> +            offset !=3D -FDT_ERR_NOTFOUND;
> +            offset =3D fdt_next_property_offset(fdt, offset)) {
> +        const char *propname;
> +        const void *val =3D fdt_getprop_by_offset(fdt, offset, &propname,
> +                                                    &ret[i].len);
> +
> +        ret[i].name =3D g_strdup(propname);
> +        ret[i].value =3D g_memdup2(val, ret[i].len);
> +        i++;
> +    }
> +    return ret;

How does the caller free the structure?  Using g_free() will leak all
the copied names and values.

> +}
> +
> +static void qemu_devtree_children_info(void *fdt, const char *node_path,
> +        int depth, int *num, char **returned_paths) {
> +    int offset =3D fdt_path_offset(fdt, node_path);
> +    int root_depth =3D fdt_node_depth(fdt, offset);

"root" implies the root of the whole tree, not of the node where you
started.  Also, two full scans of the tree above.

> +    int cur_depth =3D root_depth;
> +
> +    if (num) {
> +        *num =3D 0;
> +    }
> +    for (;;) {
> +        offset =3D fdt_next_node(fdt, offset, &cur_depth);
> +        if (cur_depth <=3D root_depth) {
> +            break;
> +        }
> +        if (cur_depth <=3D root_depth + depth || depth =3D=3D 0) {
> +            if (returned_paths) {
> +                returned_paths[*num] =3D g_malloc0(DT_PATH_LENGTH);

No test to avoid overrunning the length of the returned_paths[] array
here.

> +                fdt_get_path(fdt, offset, returned_paths[*num], DT_PATH_=
LENGTH);

Another full tree scan for every entry here.

> +            }
> +            if (num) {
> +                (*num)++;
> +            }
> +        }
> +    }
> +}
> +
> +char **qemu_devtree_get_children(void *fdt, const char *node_path, int d=
epth)
> +{
> +    int num_children =3D qemu_devtree_get_num_children(fdt, node_path, d=
epth);
> +    char **ret =3D g_malloc0(sizeof(*ret) * num_children);
> +
> +    qemu_devtree_children_info(fdt, node_path, depth, &num_children, ret=
);
> +    return ret;
> +}
> +
> +int qemu_devtree_get_num_children(void *fdt, const char *node_path, int =
depth)
> +{
> +    int ret;
> +
> +    qemu_devtree_children_info(fdt, node_path, depth, &ret, NULL);
> +    return ret;
> +}
> +
> +int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
> +        const char *cmpname) {

The semantics of this make no sense to me.  It finds the first node
with the name after the given node, whether it's a child, sibling or
unrelated node.   I'm guessing you want something based on
fdt_subnode_offset() instead.

> +    int offset =3D 0;
> +    char *name =3D NULL;
> +
> +    do {
> +        char *at;
> +
> +        offset =3D fdt_next_node(fdt, offset, NULL);

No test for error here, before using 'offset'.

> +        name =3D (void *)fdt_get_name(fdt, offset, NULL);
> +        if (!name) {
> +            continue;

The only errors from fdt_get_name() indicate either a corrupted DT, or
bad parameters.  continuing at this point will not do anything useful.

> +        }
> +        at =3D memchr(name, '@', strlen(name));
> +        if (!strncmp(name, cmpname, at ? at - name : strlen(name))) {
> +            break;
> +        }
> +    } while (offset > 0);
> +    return offset > 0 ?
> +        fdt_get_path(fdt, offset, node_path, DT_PATH_LENGTH) : 1;
> +}
> +
> +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int pha=
ndle)
> +{
> +    return fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle),
> +                            node_path, DT_PATH_LENGTH);

Two full tree scans.

> +}
> +
>  int qemu_devtree_getparent(void *fdt, char *node_path, const char *curre=
nt)
>  {
>      int offset =3D fdt_path_offset(fdt, current);
> @@ -648,6 +819,38 @@ int qemu_devtree_getparent(void *fdt, char *node_pat=
h, const char *current)
>          fdt_get_path(fdt, parent_offset, node_path, DT_PATH_LENGTH) : 1;
>  }
> =20
> +int qemu_devtree_get_root_node(void *fdt, char *node_path)
> +{
> +    return fdt_get_path(fdt, 0, node_path, DT_PATH_LENGTH);

The root node's path is "/" by definition, you don't need this
function.

> +}
> +
> +static void devtree_scan(void *fdt, int *num_nodes)

"scan" is vague.  The name should reflect what this actually does.

> +{
> +    int depth =3D 0, offset =3D 0;
> +
> +    if (num_nodes) {
> +        *num_nodes =3D 0;
> +    }
> +    for (;;) {
> +        offset =3D fdt_next_node(fdt, offset, &depth);
> +        if (num_nodes) {
> +            (*num_nodes)++;
> +        }
> +        if (offset <=3D 0 || depth <=3D 0) {
> +            break;
> +        }
> +    }
> +}
> +
> +int devtree_get_num_nodes(void *fdt)
> +{
> +    int ret;
> +
> +    devtree_scan(fdt, &ret);
> +    return ret;
> +}
> +
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

--QKp7YyVGUp8inaeB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAml4IKcACgkQzQJF27ox
2GcZ/RAAg69OUjFtixegYb661CXwxbX0BCwBLULlrndy4i8wYWR975leWkOIBaoB
oTISvpAGfui8pADIwQiL7Fay+ES9isZDOYHfjdQDWrCVsDBZjtrp3Ra65yfSGycL
VAeANBO5x819qKG7AxsZNgXeJtRatGtMTcoIFZisK4pjsUVkTQSXGe34rgqS1+na
GvB5Uw7eBZKbZfEeBJnf39l/d8qOrSYgfNaxP2u4SabNiENgUi254U8M4wBhGB5q
TIe0n5aUzhlYeEBMhwR9nEEMd76/q3Ni11o5BxAbUHeykwe9boAun4DckAIq4gDz
X+wqgoUMROx9JsVPPsoYT29eY95mSOd4aXz4p4MMComg+fRbRavC2XdmFWJznSDp
+4zShp6Ghr64gQdyVJBWxEUHpr90t5G8Pxixxza9HiJXXjXhqtKPyk8UxJ8ZFK5k
TbWvSUtIK006cV+KuI+B4FCa4rtuNqX59cFXEUe5x/lg7KHyGgecKL6NW+jOs8P2
3iINcHh21/6eEEnu6W4aEObCr8Wez79fdvrB8zLd3dvLEE5MITYAopJr3c0eHND/
NTS943DiXWdCKyjPI3DCeXorabVfwWYOI059oAZ82+8RTPAYFXin4bszGKyW+dJu
8n7T8QrGGwjpkh74VLUvmYoNReesBBJ3Iepnn8Z3yFW94m3G/qg=
=MSdu
-----END PGP SIGNATURE-----

--QKp7YyVGUp8inaeB--

