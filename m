Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E5BC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGiv-00043q-2a; Fri, 24 Jul 2026 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wnGit-00043F-Jd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:17:59 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wnGir-0006Jc-2I
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:17:59 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 9BAD6EC0112;
 Fri, 24 Jul 2026 10:17:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 24 Jul 2026 10:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784902674;
 x=1784989074; bh=2X+XFpBkEUA97yMOZ3qJ+oTOTQJKg/ruYmZ+HsVo5Dk=; b=
 aSk3REx9wtEQLiLh6z7QWF5rwoUEz8aKdbs25WVyGJDqBS1pLlxWZ7wKN6VfcebB
 VA+Rl8LdVEdcv4gEVE/N29TbzXqMTDMjfJu+gACkHeHEuwf4Mcb5jPUj+ISuu5m5
 6m5ZDcT6ihZcjLRvg/FthM6gAD029IysYzVUZe1EyudWhcRBBW+6ijWVdACgOsuT
 vDzQtEXGu1WfDgSf1uoe9MgXe/sD/RZdj0KJE9O6vimM8/A60GZT+gtmS0R1cNtB
 wZC8en7k3rvqcz9QYiIlg7ieMVetKv8DQ8Sz8DSga4RhYNrVdxH3/oOLfZGqnI/3
 xYdl25inFKfjf/uUJZrz/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784902674; x=
 1784989074; bh=2X+XFpBkEUA97yMOZ3qJ+oTOTQJKg/ruYmZ+HsVo5Dk=; b=V
 vtxNJo1SlMOVp3aNrytQPPCnbsa1VADPXyYISTp+8MElRLiqweddjdV/nGaWVbp/
 Hl2aUWN81ynajLCgENTnX6Kb0k5IgHwQSqOCSc25ansUSpI10Xc62VVYZ93NcUEd
 kXwNL82DS2DyNGMJcmhJktTi2SYb0pszbxPYHvMY4zr+Ztxvd/aShv8j6hi0hLn4
 AFuhtFTRYoz8VT/gzwcxenhMXwzdGMGxPAY39aiVbO4NJhvvfr2C6rcZqpO2+4Ue
 HLDNUeFnYQGJ223eP8NZyYPc13oo3er4lVv8cbInAKtdg9eo4jns9zPWOyERry3d
 QtTfDjpzOt6p+NbVCD75w==
X-ME-Sender: <xms:EnRjatKf0vdMi_MA0nrs57X40VqgWMEyf-uj3m1AfbkPLO0IPMVXjw>
 <xme:EnRjapQ5bjwCWDkgON78u4pi5zzqj2QJSnQr_ZYdifeLnrdPIvUnqZcZP72rPkMQN
 zWsFSqsfMu7m26k0jVcmeU1iGDigYsWpMFTffNRWeMdG-AYAHw7>
X-ME-Received: <xmr:EnRjatqF7Jxta05B0u7UhQ9YpOD1wHVak9Vc9I1ayTv6xJWuvnZNnHiIfXLdYQ>
X-ME-Proxy-Cause: dmFkZTGXewPuuQpvnkjIrfgwsEHPZj60s/VfAnf4rMo02Wn+b8CSrH6Pd+58E8HeCkbFnE
 cNSBmu5y5UH+Zq9AwYcQyJ7M9tRJGXbQNEiRj6rk7ygx4QyT068xgBEtLYgKrNMYA337nr
 2lP4/Xzs2IdFCiwu6oiY0fyHfI4FTXidghdpafscO2pl2YyHnuXdH4nv4r4WcnjyD1j2Le
 CIFBJtO8TyIrIkaGwKIji62HTX4/oEBv3jITCyRA1wmYfQK7LCjoIJNaD1h1A5HjrSn7lO
 SnIdM8l0wrxP2Kbx5rNiurrUw0BEbWpbbvYeCj/5sJZvVEt6yXfbzKxkO0+Y0QxVL5QnXe
 Vx9+EzOCo6XVX+zbOF1NkYX/2plx5+t9jLwLdotcj2tKIhtT9g5PBUxZqHQFL19xxe6QuI
 NcPqI9EgJEZxJ9acke1avb0jbgFooe8KfeGpOFjExduKmDm+rr7SrfwgUKr6YVIEZO1JXh
 gN9pxoyLZm6Y+mqNZrKu53nzpn5W81e/QunH4eYiNNYbCghkH9Wnu77qU9D8QxPW07+xPM
 HsEuAfPkpRbgaRDjMxYtto/OQsZAeXZ0xcPJQ0Z1mxspf94bK2R9DieW/PrRmW/lA6Eci6
 Pnmt4eh8xzEbc/Ml2qlegDbTS2Qgo1B800NB8G1oyIRc6vktscwKSa2LJFmA
X-ME-Proxy: <xmx:EnRjamqaHSUg1ICR950xYOeKzo_AHsAa6CLFA6Dwzkq9k0zn0iNHqg>
 <xmx:EnRjavMI-BlJocoM3M1-EDs3ZKWyQksoMzzdXXFYacAh4h5jjGScCA>
 <xmx:EnRjanwvyrmm-ADsMRza2AdKhD9Hi9G_zuTIcSiYSBnz_ytR-9IbWQ>
 <xmx:EnRjaovVUL08gH40YsAQ77qLBtN-ovYiGNTeTEBfIntA4MiLcjqNkw>
 <xmx:EnRjaiUX2LYmXSDFEi0r1PLBP_M9JckriWwx7RXtm5szgFisYf-KkeQM>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 10:17:53 -0400 (EDT)
Date: Fri, 24 Jul 2026 08:17:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, mcasquer@redhat.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Fix ROM load failure handling in vfio_rom_read()
Message-ID: <20260724081750.65449051@shazbot.org>
In-Reply-To: <20260724092413.348354-1-clg@redhat.com>
References: <20260724092413.348354-1-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.144; envelope-from=alex@shazbot.org;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Fri, 24 Jul 2026 11:24:13 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> When vfio_pci_load_rom() fails, vdev->rom is NULL but the memcpy
> still computes a source pointer from it, which is undefined behavior.
> Guard the access and return a 0xff pattern instead, which is what
> hardware returns for an absent ROM.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a3147d28665abd29fd804bd08bdffc3c7440033c..16d4f70ea58c9e5b174dd5795=
0df55dc2ab91f6f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1176,8 +1176,13 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr=
 addr, unsigned size)
>          }
>      }
> =20
> -    memcpy(&val, vdev->rom + addr,
> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : =
0);
> +    /* If ROM loading failed, return 0xff pattern */
> +    if (vdev->rom_read_failed) {
> +        memset(&val, 0xff, sizeof(val));
> +    } else {
> +        memcpy(&val, vdev->rom + addr,
> +               (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr=
) : 0);
> +    }
> =20
>      switch (size) {
>      case 1:

I thought we guaranteed that when (vdev->rom =3D=3D NULL) that
(vdev->rom_size =3D=3D 0), thus we end up with a harmless zero-sized memcpy
here.  Also val is pre-initialized to ~0 so the memset() is redundant.

Does this actually change any behavior or is it only meant to sanitize
the undefined (NULL + addr) pointer that's never dereferenced?  If the
latter, I'd drop the memset and note it explicitly as a sanitization,
not a fix.  Thanks,

Alex

