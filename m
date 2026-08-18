Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6D9C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGHZ-0000zX-1X; Tue, 18 Aug 2026 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1wwGHX-0000x2-9I
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:38:55 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1wwGHT-0004aW-NH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:38:55 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836c590b61eso66030897b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787045930; cv=none;
 d=google.com; s=arc-20260327;
 b=UNULHS7AAISSYFcDQ0Bj8XvwqopK8JY5tT5Vcu07ywM+f9Mufk/syguynH0mexwajs
 4YgwbdkevJXUrXzr6aghb4y5VXSaCQFh9i+W2XUysmbbML39Hl+0WsPHLZM3X7EYfiVf
 EiF06UiWDT9jMQOz83wjj2RSs+bOJXn3YPrMuhDTPu0nPVZp/v/XVA+THLet5+fx6lnG
 A9jaFN6PP8sNWID5H+1xMnjaEHnF1L9K+e8IofHU2praXl/7JwYIHh11b03WtbIFlqfL
 vCeGJ4rr4QjIzy3BxjJ2s8UpaTe5P2hqvYiXEiiNbvQphade0h9EA9gqmWLPLNFvoAC4
 sXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=B3+pAcCLUpOwfkWDtGhR5K6pZ7x513bZrNz7rbVoOiM=;
 fh=MeNEHI+KXqzrVMI1EV50bS9PNAg7ElEbOExhOeAb3rQ=;
 b=KZGuCL5RwsRG8g8fQtGdrxqU3Ti/VtKs86tmTTmvuJj1nQwVfEOTs4G86KZLD9UiOd
 FX+E+MnT9xFBn7YC8CRhKwc63KqDe8HfQhI54ybKUoCkIPEu5jSSTST8PJJqLE1v1KTQ
 zmO9b7Z3HN/hJ0Q5RDULqNs3PaTeJNjayjN2aB0rsdAS8Y3PxOzlWNw2p8vPF6rBG687
 EnqdG8DRRYgacxWtqEice0p//XAnprLORTHx84g1yqAKUsGqoUfHJQn8G1EekYjTycE+
 LHHYCpIPlacBvpZWR0hWWwmHc6GoLGQaTjpZ4Bw53NoNof3A3YgbmgUe8SWHHartEjxt
 hQYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787045930; x=1787650730; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B3+pAcCLUpOwfkWDtGhR5K6pZ7x513bZrNz7rbVoOiM=;
 b=fF2YODtiBG73aytbzUAUS3fIu3JO73hmUnd96bsKNtnBODqRC3WqhLS1tWHjFOrs5c
 wS6TWlz7UmXpT5i3xM0cC2SfNLnJaoe+jtULIN8AgCsjXfiWRxGngZPED4WaykFBskTh
 3bJew/mU+PggOLh433UmS7Ms/rjVmpHiYxVbaLXeT8djGr9ADxP12O8sCZxpbQH9/SrG
 fdH/huEpzxhAWiO53XNhi2VkrVsyHvO6mu6bYHnPF8/ZF233N5Lx36D7adaCllVIccUH
 fvifj//+1PATi9syayYfiIV4Xt8oLIeiylU0InqKEIXC9zyia+rFs7j5dZ5UoenyrCYS
 s1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787045930; x=1787650730;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B3+pAcCLUpOwfkWDtGhR5K6pZ7x513bZrNz7rbVoOiM=;
 b=EkUqg424cZW1innKtmxYYzMwhDBZ4wmXiDPilag3B+hFW7/Njwg/Z63g8lA37T4WuM
 53lBD/o69tBCV5+Bnk96xIkhCDHlI6xmvIJLIWPck+rsYKyiq4jVoVASUCQG39c1IWBa
 M6EYazbJyYDINNc6DMD0xf6U+RxzJVK9gCpAlrXOKePjOe6o+XOETFvFKk1R3/OV/vec
 K4cWM2D+grgGgQG49TBhZR9wcvBvvUlGa7uxknk7fOnUAFhPZMWam4tZ+zJE8H/2nW7U
 9rbq9dyAAV5PB2DDV69ygU+JZQcl4VQSFMAz0+Vsjy9cO4dTKvDW/FM8bHdjc4BNtdPK
 MsIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYpgYuTU2OuSX7lcTQFd9UnWJ3+MAGV+agNE6Leigu+PGA6+HspNmwVlzvS8Tdy7x2pdkKGhzFFBTt@nongnu.org
X-Gm-Message-State: AOJu0YzdFUzbk/Mc1xR+vO2a076nMyaFX2vaIxdXTQRqcpQE3Rpoc3Nb
 OJkuGMv8s3vr1oCCJ9cg+3j/KQvR6/vogcg/6wMZxrHI1PHxzEMdU4wZk5RPQM26u0xUc4q67cI
 UY1qX/Cgh9lSgX/VNuUjEL3CaUhbIA1U=
X-Gm-Gg: AR+sD11P4ippHrfu/+/qY/V6tGt2lV/gfOHuGoGUym6DwyGvV3s3DEfx4r04h+k8CB1
 2TvmSYUvNxBLNgbMaDtixeJJrWSP5alg6eXpL2kcJe7RANAV0sGLPTebLyh6ViayqXiZr35G2b2
 x9xCDJeZ9B2vVA81TAezRhbSrIdxHTTYbFqnAxtTBATXxVg0UYp5+k6HccnDuMySsfJPMSPBtZ2
 PCf2ApCqu8dnRJlUFCBA6mhWMjOMmxGTzMVTzmbW6f6U0u+8clb/S5nZFMaM9sWirVcZbb6aQSE
 9JeEWfMuDYhgwr8juiFVWZoFr/Vvb4FFhtqam+UoIvHSb0k=
X-Received: by 2002:a05:690c:2701:b0:81f:64e8:d86a with SMTP id
 00721157ae682-83712ac20bemr122591357b3.30.1787045929957; Tue, 18 Aug 2026
 02:38:49 -0700 (PDT)
MIME-Version: 1.0
From: Huiba Li <lihuiba@gmail.com>
Date: Tue, 18 Aug 2026 17:38:38 +0800
X-Gm-Features: AcwNN1UGG6zfDliIAOn4fjqFGcKXKEuFQQ_ADDFjgHon0NfPjC_BDLP39DooDZ4
Message-ID: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
Subject: [RFC] block: add an overlaybd image format driver
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000da3e1f06594f0df0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=lihuiba@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000da3e1f06594f0df0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to propose adding a QEMU block driver for the
overlaybd image format, and I am looking for early feedback on
scope and design before sending patches.

What overlaybd is
-----------------
Overlaybd is an open-source image format (
https://containerd.github.io/overlaybd/)
hosted as a sub-project of containerd (CNCF graduated). A disk
image is a stack of read-only snapshot blobs plus a writable top
file, in a layout compatible with OCI image registries: a base
image is stored once and shared by every derivative image, and
data is fetched on demand rather than pulled in full before boot.

Two properties distinguish it from qcow2/VHDX/VMDK-style chains:

  * Lookup cost is O(1) in chain depth. At open time the per-file
    indices are merged into a single in-memory index (an
    extent-based log-structured merge tree), so a read never walks
    backing files, and per-file index caches do not multiply with
    snapshots.

  * The merged index is small (about 300 KB average for 50+ GB
    images in our production data), and because extents are
    variable-length, writes land at 512-byte granularity with no
    cluster copy-on-write.

The format is openly specified:
  https://github.com/containerd/overlaybd/tree/main/docs/specs/lsmt.md
  https://github.com/containerd/overlaybd/tree/main/docs/specs/zfile.md

Reference implementation:
  https://github.com/containerd/overlaybd

Overlaybd has been in production at Alibaba for years (Taobao,
Tmall, Alibaba Cloud, Function Compute) and is used by Azure AKS
Artifact Streaming, Databricks serverless compute, and several
microVM-based sandbox platforms. The design is documented in two
USENIX ATC papers (DADI, ATC'20; FaaSNet, ATC'21). I am one of the
overlaybd/DADI authors.

Why a QEMU driver
-----------------
Today overlaybd images are served to VMs through a kernel blk dev
and a userspace daemon. That fits container workloads well, but
a native QEMU driver would let any QEMU-based stack (libvirt,
KubeVirt, OpenStack, plain qemu-system-*) boot overlaybd images
directly, with QEMU's usual amenities (backing files, block jobs,
throttling, migration) and no extra daemon on the host. This is
beneficial to agent sandboxes.

Proposed implementation
-----------------------
A new block format driver, block/overlaybd.c, written in C from the
open spec (like the existing vmdk/vhdx drivers) rather than binding
the C++ reference implementation:

  * v1: read-only support. Local layer files, index merge at open,
    raw and ZFile blobs (lz4/zstd are already optional QEMU
    dependencies). Writes can be served by a qcow2/raw file on top,
    exactly like booting a read-only backing image today.
  * v2: native writable layer, and lazy fetching of remote blobs =E2=80=94
    either composed over the existing curl driver or with a small
    built-in HTTP fetcher; guidance welcome.

Questions
---------
  1. Is a new in-tree format driver acceptable in principle, given
     the format is stable, openly specified, and deployed at scale?
  2. Is read-only-first a reasonable merge scope for the initial
     series (with iotests and a docs/interop/ spec page)?
  3. For remote blobs: compose over block/curl, or fetch in-driver
     with a local cache?
  4. CLI surface: point -drive at the OCI-style JSON image config
     (which lists the layer blobs), or expose per-layer options?

I will write the iotests and the docs/interop format page, and add
myself to MAINTAINERS in the first series.

Thanks for any comments,
Huiba Li

--000000000000da3e1f06594f0df0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I would like to propose adding a QEMU block dri=
ver for the<br>overlaybd image format, and I am looking for early feedback =
on<br>scope and design before sending patches.<br><br>What overlaybd is<br>=
-----------------<br>Overlaybd is an open-source image format (<a href=3D"h=
ttps://containerd.github.io/overlaybd/">https://containerd.github.io/overla=
ybd/</a>)<br>hosted as a sub-project of containerd (CNCF graduated). A disk=
 <br>image is a stack of read-only snapshot blobs plus a writable top <br>f=
ile, in a layout compatible with OCI image registries: a base <br>image is =
stored once and shared by every derivative image, and <br>data is fetched o=
n demand rather than pulled in full before boot.<br><br>Two properties dist=
inguish it from qcow2/VHDX/VMDK-style chains:<br><br>=C2=A0 * Lookup cost i=
s O(1) in chain depth. At open time the per-file<br>=C2=A0 =C2=A0 indices a=
re merged into a single in-memory index (an<br>=C2=A0 =C2=A0 extent-based l=
og-structured merge tree), so a read never walks<br>=C2=A0 =C2=A0 backing f=
iles, and per-file index caches do not multiply with<br>=C2=A0 =C2=A0 snaps=
hots.<br><br>=C2=A0 * The merged index is small (about 300 KB average for 5=
0+ GB<br>=C2=A0 =C2=A0 images in our production data), and because extents =
are<br>=C2=A0 =C2=A0 variable-length, writes land at 512-byte granularity w=
ith no<br>=C2=A0 =C2=A0 cluster copy-on-write.<br><br>The format is openly =
specified:<br>=C2=A0 <a href=3D"https://github.com/containerd/overlaybd/tre=
e/main/docs/specs/lsmt.md">https://github.com/containerd/overlaybd/tree/mai=
n/docs/specs/lsmt.md</a><br>=C2=A0 <a href=3D"https://github.com/containerd=
/overlaybd/tree/main/docs/specs/zfile.md">https://github.com/containerd/ove=
rlaybd/tree/main/docs/specs/zfile.md</a><br><br>Reference implementation: <=
br>=C2=A0 <a href=3D"https://github.com/containerd/overlaybd">https://githu=
b.com/containerd/overlaybd</a><br><br>Overlaybd has been in production at A=
libaba for years (Taobao,<br>Tmall, Alibaba Cloud, Function Compute) and is=
 used by Azure AKS<br>Artifact Streaming, Databricks serverless compute, an=
d several<br>microVM-based sandbox platforms. The design is documented in t=
wo<br>USENIX ATC papers (DADI, ATC&#39;20; FaaSNet, ATC&#39;21). I am one o=
f the<br>overlaybd/DADI authors.<br><br>Why a QEMU driver<br>--------------=
---<br>Today overlaybd images are served to VMs through a kernel blk dev<br=
>and a userspace daemon. That fits container workloads well, but<br>a nativ=
e QEMU driver would let any QEMU-based stack (libvirt,<br>KubeVirt, OpenSta=
ck, plain qemu-system-*) boot overlaybd images<br>directly, with QEMU&#39;s=
 usual amenities (backing files, block jobs,<br>throttling, migration) and =
no extra daemon on the host. This is<br>beneficial to agent sandboxes.<br><=
br>Proposed implementation<br>-----------------------<br>A new block format=
 driver, block/overlaybd.c, written in C from the<br>open spec (like the ex=
isting vmdk/vhdx drivers) rather than binding<br>the C++ reference implemen=
tation:<br><br>=C2=A0 * v1: read-only support. Local layer files, index mer=
ge at open,<br>=C2=A0 =C2=A0 raw and ZFile blobs (lz4/zstd are already opti=
onal QEMU<br>=C2=A0 =C2=A0 dependencies). Writes can be served by a qcow2/r=
aw file on top,<br>=C2=A0 =C2=A0 exactly like booting a read-only backing i=
mage today.<br>=C2=A0 * v2: native writable layer, and lazy fetching of rem=
ote blobs =E2=80=94<br>=C2=A0 =C2=A0 either composed over the existing curl=
 driver or with a small<br>=C2=A0 =C2=A0 built-in HTTP fetcher; guidance we=
lcome.<br><br>Questions<br>---------<br>=C2=A0 1. Is a new in-tree format d=
river acceptable in principle, given<br>=C2=A0 =C2=A0 =C2=A0the format is s=
table, openly specified, and deployed at scale?<br>=C2=A0 2. Is read-only-f=
irst a reasonable merge scope for the initial<br>=C2=A0 =C2=A0 =C2=A0series=
 (with iotests and a docs/interop/ spec page)?<br>=C2=A0 3. For remote blob=
s: compose over block/curl, or fetch in-driver<br>=C2=A0 =C2=A0 =C2=A0with =
a local cache?<br>=C2=A0 4. CLI surface: point -drive at the OCI-style JSON=
 image config<br>=C2=A0 =C2=A0 =C2=A0(which lists the layer blobs), or expo=
se per-layer options?<br><br>I will write the iotests and the docs/interop =
format page, and add<br>myself to MAINTAINERS in the first series.<br><br>T=
hanks for any comments,<br>Huiba Li</div>

--000000000000da3e1f06594f0df0--

