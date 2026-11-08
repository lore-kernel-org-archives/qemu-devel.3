Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB7606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WTMNx1gF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzff-00036p-RW; Sun, 08 Nov 2026 04:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xPzfe-00036U-4A
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:58:42 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xPzfc-0006bv-Li
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:58:41 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67bf3c6654fso192956d50.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 01:58:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794131919; cv=none;
 d=google.com; s=arc-20260327;
 b=RhnbHEEdooRFBu5avdOIhKkvE8VJr3dJyXuQCk97kCgFdgvyjJMW4fVjGmex5Z1xRT
 SKvis/zXVnkyzN/9u4+m+w5ob7KlW4ZlA1LzSIwtddr0zpumVWVoDTDF9Zogaz9a2K43
 9npNoSVOZOE+nFwtiwMuiJwIZIp8w1lH1lhVKSgpBT0hatoz5xFrlZWqAYOFrPKPG68u
 PkqQlMtROoX6GIPPx2m+OJBK819kV86PjbzC5tbnHcWGU3E7+h/rYRXv0vviRq4R2XMs
 6Ws/DRs9cxhAeytur4CezsxZN1kjnooQe478XVAgB9bdmowgOTi8TP36DmlSRtw6+J51
 i2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Y+hHbmmokTnKllUl/wFT6yyNmX5sqe2sX+VKXoLTWw=;
 fh=YILow8gqAZtX5KhDhkBgTgDpXVCqDdA9NAaXJUhYvDk=;
 b=RRKMeUtygD5fCBLmMYW3BKoTu/Tth/zfvohGV5BEqLs8uqFVm3M3jQbaAOl17TSCKe
 WsM/p1BUz2OUDw11vmVR3kiR1HTz/Zyx6CGh+fiFL4RU6MpjFSzIKw7N9OOFeLhnWT3u
 PpK/3FclGZGgezlXSVt9dY3T0t5CMU5fqqMbA0bHFm6IgAmsp3D/GFIpnxKgPN/5VCIq
 G9ejOCJrRuXShneaRCfeJnowAa3TyHDbajjUK60WWX9iKUGVy18HGXZvXXmdKXu9VlTb
 f3TtdTWtiYxBCZjXxNM66RPpPlyPRj5Stq5WEkCRWayvOAVNQVEBMaNRY6A3KxwvizX/
 olhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794131919; x=1794736719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Y+hHbmmokTnKllUl/wFT6yyNmX5sqe2sX+VKXoLTWw=;
 b=WTMNx1gFjY0+xgRw1O6EYyKIPv2ZH4wCt5ihTXa/+1M9X+poo7+lQCJ/3ArMswxaDb
 s4UM576z8YdF/AE0deEE3t1yRNY0As9roA57DjZpLWYtD6iNgt7KUeLag7rJS2WTHnLA
 87S6cJBS3dYckZXLtAaCfy6HhO1urPX/Lgg2OhiZ/cLYdLqsAtmkC+4vVFBZNXCLEp8J
 kFIrjoCeOa9TnP+53Uj0YCjYaD6PbUBRtwvEg2LgQr59txN2ePGnMNvhNIiedUZAn2aI
 D6L5r2xwW9BgjOL4dgdOdmR+bwWKlQS0wNVxoAENipF7UkYVb3QPFPIikkla/V9HEpdu
 Ukbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794131919; x=1794736719;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Y+hHbmmokTnKllUl/wFT6yyNmX5sqe2sX+VKXoLTWw=;
 b=OX27nR5GEr3efTEYjl9yREAKxmU3nLjgvRrnk63+kQphPOKS6wRwhkLoV5hs9n+ATl
 EEKEcwRcktuzra5DtrM0NGUjBBY213LdNrmYGEegGQ0kvMZM9+zvFFrHoLYKl0hEzSkB
 oLZX0ErFSCqa8nCnh/QuxA+6R0Rw889e+rCFQmB8mH5oQ0cI1BlJXrVuRnz3fkmaAE/X
 /8u3PjUpQ/DkGGqMWhcaeAhbYTLcHntBH/7+Ie4n5/q1RBIhkZVHM1g97wlf3ANY40Ld
 gqtxVygZo+e5DrwYpKLwHtOTYWzw8uy07FdZrvPvWSm1k7j5PVFjTg4p2VxKtsdc2k9B
 Hipg==
X-Forwarded-Encrypted: i=1;
 AL+hErFhxWx1+TXVfyG06ycgQaCZxpcaYPncu3n6bg4Bxk6rJvftgPL3xOcnULyKgrMI3mfM1FQSa39mDld4@nongnu.org
X-Gm-Message-State: APuU4Z8ubg2peG8XojjMt09JKlw/GYPY7xR41Z1wz1cyotQeVa7TunPB
 drOrUWMWF1t+SgicdoUGjPkT/Kbim64Gtgq92by/GHHJFrLJGHeHOaF6lUO+F+ZaHx8kfYYERsj
 zvh1sfOEHPC7W8hKWQCB9G4ebM+6gn6I=
X-Gm-Gg: AYBFou0M2tbmcxt2LSedkSL7C77lWqszPkACZGQsTvtnrf6ecandNlc0fqTs4NrorBN
 lmcv/bAJVAjjbiYUpjX99AQD3N1mdXpF7BtdT8GvinB964ajFSWEvdN+vveLaGx2/GlKgqypFDz
 IsILWKA0H3JogNCEn265LdsYvmWp5wfu5A+J1YJhagNuaqvoOwpOpHqV7gyGBmFMcvlyvj9vVPG
 8KzRJzQ8AN++XqTusk75wOzhN+QiIX5yF6f8jmJQReZwuKY6UVXZSa8CGdJtfs5xMeYoLmV7jIO
 J0ixCl3Z3UaEriGCpbdWjpgaUYjTsvgnh7z0PhV84+P683M4sNnr0FVB7RXu2OAcuUO7B4A01Zu
 Z7Js6ny9Iu3FMwrYZOBh1vtOzbOmOrZfRhO1n2ZXMWQRL7WHEpvw9x1HorFc+bchnjjVnb6Mfte
 Yy
X-Received: by 2002:a05:690e:43cb:b0:677:d5bd:8349 with SMTP id
 956f58d0204a3-67c3d9cb4c6mr314836d50.63.1794131919270; Sun, 08 Nov 2026
 01:58:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104173329.706635-1-bin.meng@processmission.com>
 <20261104173329.706635-12-bin.meng@processmission.com>
 <96682bf3-9c32-6d15-05b0-31315501b05a@eik.bme.hu>
In-Reply-To: <96682bf3-9c32-6d15-05b0-31315501b05a@eik.bme.hu>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 8 Nov 2026 17:58:26 +0800
X-Gm-Features: AclHuK8gyvlOfDMuxAf9vhXeRh_qHr_zkl2r6Vlsf76fNeKev_5FTDHrlqWKqXI
Message-ID: <CAEUhbmVCTPZ01Zo1jEvOp_7YTLwf9RkNAZLcwMj9JFV8y_pkzw@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] target/ppc: Register IVOR42 on e6500
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 6:32=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Thu, 5 Nov 2026, Bin Meng wrote:
> > The e6500 core manual defines IVOR42 as the LRAT error interrupt
> > offset register. U-Boot programs it during interrupt setup, but
> > currently the QEMU e6500 IVOR mask currently excludes bit 42.
>
> "currently" is doubled, one of them is enough.
>

Will fix in v3.

Regards,
Bin

