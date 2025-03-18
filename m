Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9BBC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tudrM-0005Cg-W7; Tue, 18 Mar 2025 16:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1tudrE-0005C9-HR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 16:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1tudrC-00031q-Ge
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 16:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742330892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zuT64oIogBWQIExy1yR68qY6PND7dClun7k2YmE+5O0=;
 b=JZ7ky6ttvw35YWa0Stj0KDq2zaHMFO1sE0mRb9il1JkvAlV72+w34saOZ8nYe4alS5tVCN
 xRIegwn+J+pEmWiYlnzrvFJYVt/l7jYB4ZUMt0ylXaBhcVzI54aDmTPzQ5GAB0BPQ5oKRG
 5YHRFsycyXYjz28qnxL+qADSkcRjBvM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-rDfyS_Z2MBiOi0GzAtZN8A-1; Tue,
 18 Mar 2025 16:47:03 -0400
X-MC-Unique: rDfyS_Z2MBiOi0GzAtZN8A-1
X-Mimecast-MFC-AGG-ID: rDfyS_Z2MBiOi0GzAtZN8A_1742330822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67345180025C; Tue, 18 Mar 2025 20:47:02 +0000 (UTC)
Received: from antique-laptop (unknown [10.45.225.218])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 950B91828A83; Tue, 18 Mar 2025 20:46:59 +0000 (UTC)
Date: Tue, 18 Mar 2025 21:46:56 +0100
From: Pavel Hrdina <phrdina@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/3] scripts: render_block_graph: Implement proper
 argument parser
Message-ID: <Z9nbwHwod6KgEmHg@antique-laptop>
References: <cover.1742315602.git.pkrempa@redhat.com>
 <00eab2a417ecdb7f0ea7eaf3880806f3309133dc.1742315602.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HNTWtEKrh3M/Z1EW"
Content-Disposition: inline
In-Reply-To: <00eab2a417ecdb7f0ea7eaf3880806f3309133dc.1742315602.git.pkrempa@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--HNTWtEKrh3M/Z1EW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 05:36:03PM +0100, Peter Krempa wrote:
> From: Peter Krempa <pkrempa@redhat.com>
>=20
> As no argument parsing is employed the script is hard to use and when
> running without arguments it blurbs:
>=20
>  $ ./scripts/render_block_graph.py
>  Traceback (most recent call last):
>    File "/home/pipo/git/qemu.git/./scripts/render_block_graph.py", line 1=
35, in <module>
>      obj =3D sys.argv[1]
>           ~~~~~~~~^^^
>  IndexError: list index out of range
>=20
> instead of an actionable error. The user then usually needs to read the
> script to understand arguments.
>=20
> Implement proper argument parsing via 'argparse'. The following
> arguments will be supported:
>=20
>  $ ./scripts/render_block_graph.py --help
>  usage: render_block_graph.py [-h] [--socket SOCKET] [--vm VM] [--uri URI=
] [--output OUTPUT]
>=20
>  Tool that renders the qemu block graph into a image.
>=20
>  options:
>    -h, --help       show this help message and exit
>    --socket SOCKET  direct mode - path to qemu monitor socket
>    --vm VM          libvirt mode - name of libvirt VM
>    --uri URI        libvirt URI to connect to
>    --output OUTPUT  path to output image; .png suffix will be added; in l=
ibvirt mode default is the name of the VM
>=20
> Usage then requires one of '--vm' or '--socket'. In libvirt mode the
> output file is by default populated from the VM name and the '--uri'
> parameter allows overriding the libvirt connection uri.
>=20
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  scripts/render_block_graph.py | 53 ++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
> index 14b2d02ec2..7a6738410c 100755
> --- a/scripts/render_block_graph.py
> +++ b/scripts/render_block_graph.py
> @@ -23,6 +23,7 @@
>  import subprocess
>  import json
>  from graphviz import Digraph
> +import argparse
>=20
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
>  from qemu.qmp import QMPError
> @@ -91,13 +92,19 @@ def render_block_graph(qmp, filename, format=3D'png'):
>=20
>=20
>  class LibvirtGuest():
> -    def __init__(self, name):
> +    def __init__(self, name, uri=3DNone):
>          self.name =3D name
> +        self.uri =3D uri
>=20
>      def cmd(self, cmd):
>          # only supports qmp commands without parameters
>          m =3D {'execute': cmd}
> -        ar =3D ['virsh', 'qemu-monitor-command', self.name, json.dumps(m=
)]
> +        ar =3D ['virsh']
> +
> +        if self.uri:
> +            ar +=3D ['-c', self.uri]
> +
> +        ar +=3D ['qemu-monitor-command', self.name, json.dumps(m)]
>=20
>          reply =3D json.loads(subprocess.check_output(ar))
>=20
> @@ -108,15 +115,41 @@ def cmd(self, cmd):
>=20
>=20
>  if __name__ =3D=3D '__main__':
> -    obj =3D sys.argv[1]
> -    out =3D sys.argv[2]
> +    parser =3D argparse.ArgumentParser(
> +            description=3D'Tool that renders the qemu block graph into a=
 image.')
> +
> +    parser.add_argument('--socket',
> +                        help=3D'direct mode - path to qemu monitor socke=
t')
> +
> +    parser.add_argument('--vm', help=3D'libvirt mode - name of libvirt V=
M')
> +    parser.add_argument('--uri', help=3D'libvirt URI to connect to')
> +
> +    parser.add_argument('--output',
> +                        help=3D'path to output image (.png suffix added)=
;'
> +                             'in libvirt mode default is the name of the=
 VM')
> +
> +    args =3D parser.parse_args()
>=20
> -    if os.path.exists(obj):
> -        # assume unix socket
> -        qmp =3D QEMUMonitorProtocol(obj)
> +    if (args.socket and args.vm) or (not args.socket and not args.vm):
> +        print("One of --socket or --vm is required.", file=3Dsys.stderr)
> +        parser.print_help()
> +        sys.exit(1)

It's possible to do with argparse as well:

modegroup =3D parser.add_mutually_exclusive_group(required=3DTrue)
modegroup.add_argument('--socket',
                       help=3D'direct mode - path to qemu monitor socket')
modegroup.add_argument('--vm', help=3D'libvirt mode - name of libvirt VM')

The only difference is that it will print usage `parser.print_usage()`.

> +
> +    if args.socket:
> +        qmp =3D QEMUMonitorProtocol(args.socket)
>          qmp.connect()
> -    else:
> -        # assume libvirt guest name
> -        qmp =3D LibvirtGuest(obj)
> +
> +    if args.vm:
> +        qmp =3D LibvirtGuest(args.vm, args.uri)
> +
> +        if args.output:
> +            out =3D args.output
> +        else:
> +            out =3D args.vm
> +
> +    if not out:

This needs to use args.output otherwise python will complain that it
doesn't know `out` variable.

> +        print("--output required", file=3Dsys.stderr)
> +        parser.print_help()

Probably use `parser.print_usage()` if you decide to use the
add_mutually_exclusive_group().

Pavel

> +        sys.exit(1)
>=20
>      render_block_graph(qmp, out)
> --=20
> 2.48.1
>=20
>=20

--HNTWtEKrh3M/Z1EW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAmfZ28AACgkQUi1kczAH
4Yzk+w//TXlJavBoRdvOwh5L7NqUgqiUegFq8H9f3knlY/3hL99qGtsrZXNyL+iV
MKBDa0LiFW0gtBkrdyCLchDc529HvdtO2ycEbb7N1EesGnu+Snmow+VahYDuTjWV
BZ9Jeo/39CBTKEAXnZb12aOJ3ELl7MYuhY/G5VkTNxx+6OmI8FXlgFPWVbQXyodR
V5/L4p0EIulu69Z6Vq9GQMfzU+4EBZa5RJ70UsCUozdEPenhPAnq76+WvwMbXMXm
GZVZbsVcddq5S4cg84/DxKun7RFp59rJ5IJg0nWeFom0uwmlb0ZJdVWVDWVf74Ql
lt9IdEAqxkhjvNMcuiDRYZ5Pvj+0cuEkH5XIXvNEf3Alq2Nq3C8lAVmJnWw7g3PK
O1Clz9xqHJSG7Mxe0+pAZ6IN68g8KCKPPPhvoh3MNjppmuMiRbcOdVYQeFcT6KZj
GKo54w+/mNkD1L4FwCxfRJkoWUKX2rk87zrWQKvnWbuWc8ja3AR73z8x9llWPbnj
+d+7bRfMv31eR/YTmE5EJ+eNGBrHFw+D/i9ZgCGh+Lqe+ObMVjybWSC0+cAfWQOM
hAyOi8ZJBUH6rm3sMLmiJNGl1llw7l2QKzvHWIOuaLUF6T7TvJj4eRZKmGubuOG1
RPEtzHzvtyRjYcIoqsImtY2x6UEOIeKw3qGsVHDeiQc65qR7KUo=
=PGHM
-----END PGP SIGNATURE-----

--HNTWtEKrh3M/Z1EW--


