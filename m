Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A65D58E43
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 01:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwsHj-0005Rx-Ny; Sun, 01 Mar 2026 20:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1vwsHh-0005RF-8u; Sun, 01 Mar 2026 20:41:21 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1vwsHc-0002QB-CH; Sun, 01 Mar 2026 20:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202602; t=1772415666;
 bh=5CGnuByR+PiSJKTt9hCuS1FXmYxUhx1apUJhdtu4oSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fJkL2vUm0ff5Qzv/Q3OW+aQAbgFvkP3Dxdv+9cWnxuvDx7F21ekvqI6WzOjfBuEm9
 ESBCD9XZ+sLdYDhK8COGv9T8I9fQZVN7Vz91cuEt02BXgGEfXlb9fG+BaN2NELrNHz
 3Zx2QlJWX/xMbtDgYeTrQVBi2LNy0Z9v3PLgW8liX5GuIgkOOh3fW87d75/GYbfBDK
 7DX6vcGFD7TX8rVluxpr4RXmQ1TKKaAsw26vhvX7+LDrNU9znXk1+7w13je8obTDgO
 RRVz7ii4JeuPLFDbA3Z0vFSenwn7yzSVuYnO/lGbo2P6572BfZm58eWvXpgNT3jor3
 lJufCBRbNFVkQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4fPM8f36pdz4wC6; Mon, 02 Mar 2026 12:41:06 +1100 (AEDT)
Date: Mon, 2 Mar 2026 12:40:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 02/33] system/device_tree: add few parsing and
 traversal helpers
Message-ID: <aaTqq27wf7i9bzKy@zatzit>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219143332.3316679-3-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RLbUy8+aQ7HiuPuQ"
Content-Disposition: inline
In-Reply-To: <20260219143332.3316679-3-ruslichenko.r@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
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


--RLbUy8+aQ7HiuPuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 03:33:01PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>=20
> The patch adds few utility functions for parsing FDT nodes.
> The helpers are required for upcoming Hardware device tree
> feature.
>=20
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  include/system/device_tree.h |  30 +++++
>  system/device_tree.c         | 221 +++++++++++++++++++++++++++++++++++
>  2 files changed, 251 insertions(+)
>=20
> diff --git a/include/system/device_tree.h b/include/system/device_tree.h
> index 5667ff9538..9d6b570bdb 100644
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
> @@ -191,6 +196,31 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fd=
t,
>                                                  qdt_tmp);               =
  \
>      })
> =20
> +typedef struct QEMUDevtreeProp {
> +    const char *name;
> +    int len;
> +    const void *value;
> +} QEMUDevtreeProp;

If you need this, it really starts to seem to me that keeping the data
structure in fdt is not the right choice any more.  I've thought for a
while that with increasing handling of the device tree by qemu, we
should maybe have a "live" device tree representation (with pointers)
that we use for manipulation.  Right before boot, that can be
serialized into fdt.

fdt is, fundamentally, a serialization format.  Direct fdt
manipulation with libfdt was really only intended as something to
allow firmwares and similarly minimal programs to make small tweaks.
Once manipulation becomes extensive, fdt is no longer a good choice of
data structure.

> +
> +/* node queries */
> +
> +int qemu_devtree_get_num_children(void *fdt, const char *node_path);
> +int qemu_devtree_get_children(void *fdt, const char *node_path,
> +                                     int max_paths, char **returned_path=
s);
> +int qemu_devtree_num_props(void *fdt, const char *node_path);
> +QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path=
);
> +
> +/* node getters */
> +
> +int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int pha=
ndle);
> +int qemu_devtree_getparent(void *fdt, char *node_path,
> +                           const char *current);
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
> index d2db7bd355..fc34c660db 100644
> --- a/system/device_tree.c
> +++ b/system/device_tree.c
> @@ -464,6 +464,103 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const cha=
r *node_path,
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
> +int qemu_devtree_getparent(void *fdt, char *node_path, const char *curre=
nt)
> +{
> +    const char *sep;
> +    int len;
> +
> +    if (!current || !node_path) {
> +        return -FDT_ERR_NOTFOUND;
> +    }
> +
> +    if (current[0] =3D=3D '/' && current[1] =3D=3D 0) {

strcmp() against "/" is maybe marginally more costly, but clearer in
meaning.

> +        return -FDT_ERR_NOTFOUND;
> +    }
> +
> +    sep =3D strrchr(current, '/');
> +    if (!sep) {
> +        return -FDT_ERR_BADPATH;
> +    }
> +
> +    if (sep =3D=3D current) {
> +        len =3D 1;
> +    } else {
> +        len =3D sep - current;
> +    }
> +
> +    memcpy(node_path, current, len);
> +    node_path[len] =3D '\0';

This assumes node_path points to a long enough buffer.  Returning a
g_strndup()ed copy of the parent path might be a nicer interface?

> +
> +    return 0;
> +}
> +
>  uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
>  {
>      uint32_t r;
> @@ -631,6 +728,130 @@ out:
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
> +        ret[i].name =3D propname;
> +        ret[i].value =3D val;
> +        i++;
> +    }
> +    return ret;
> +}
> +
> +int qemu_devtree_get_children(void *fdt, const char *node_path,
> +                                     int max_paths, char **returned_path=
s) {
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
> +        if (cur_depth > 64) {
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

--RLbUy8+aQ7HiuPuQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmmk6qoACgkQzQJF27ox
2Gdkjw//T9IbkkK9KCLGFsVQW4pPfAUnIaiHy05xT9eGHi6OgRCMNGA+QNAHECqO
c8s61bshPZZRkRvchtGRtPdAb3HTWyxNMQg6iQ2fpUfQxhnF6hvOrNMWsfFH0SAC
5tW2xXeUrYQQcRv05pMaE4TDUv7h0gS4Llrg5hKa6uUrGMVmvX7OgjNrb6yFcoc6
oeeIUKB2On/TDB5OV9KhJLGjAc0HGxs34p7LJM8rRMsVPu8IUu2VEem1RJp8PK05
3yAm5x+NUQRGqetzKpCeWsYxUeY9x94LHJ2ISm1Z88tuPAQzGvH4bUcUR29dejKD
RATQSf/cpU5iEqJGMLKpIHelHfwJYAwUfMPPTqQGVoHgNjf5wXk6MMTJdbLMLmxR
uYFV1tct8jqqPJFSUAf3LLbH+1N3Jqc+tJMtIBTg+ANwDt8OqhpWVSgkJsZhNr0k
5nEBcouDD5SL2xsXzoCOEsfIvfODfshecQM5xDhX/RduGvDCHB4k8KRTGYuxbo/g
XCn8f43V9OhL4LCep2xYbHk4dkHGGyCu+WHWVG34Vot1C67p1Dyi+qM+szrOsd16
l9afFffF5QeeEzLFsVmtFpNZSwm4hvWvQRobAyYHdseI7PGAI1aIcHXd60r+Xwc+
Y7j+2uiMs108DAa9VWVpSuWOwfV8vpa62raQiWrfwijFh69XGkw=
=L5nK
-----END PGP SIGNATURE-----

--RLbUy8+aQ7HiuPuQ--

