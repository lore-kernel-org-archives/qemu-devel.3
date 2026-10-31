Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F2606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qA2P6+SJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN8TV-0007y7-RJ; Sat, 31 Oct 2026 08:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xN8TM-0007wq-R1
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 08:46:13 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xN8TL-0005QF-B9
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 08:46:12 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-3282db206d3so1323473eec.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 05:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793450769; cv=none;
 d=google.com; s=arc-20260327;
 b=f3p8NvOdxXCUDczkmK5bFs8Zq7a7BsmQdZPKDvX1P0sKHmFlZzqfVwc2ZZA2lc3cBY
 OKId5F6v/vAi6F7Ao4WOMs3zEe8b20xa7T0Hz8shvWFqiuAwX6yZ979sYULejiQOoDqS
 sROaEAb0iG9s6diaiDxvZSK+DZyGhiNqRHea5zi0HM1srb6r0BV6sAvXfFrbTUmf4RF7
 asrye9cgw6JjJ6bol1a/1L8iFncy623wabIPCAH36nEffm22Asu6M8ISBmspn0VT7MWx
 dirT0U5C6xTzSOjMe6WEBD/GCc7mAjJthCvoS7NcChPORHJ/OLSXmHkXsN4AXWNXMN9s
 3jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=455+lLfkx4dPdzOmM0qfbMg8PgfKzClX2czFtPiqW6I=;
 fh=S6fSvPiO0yORx0KTdr0k7WxpKHBXOfXrr7XgJW07kYs=;
 b=OCipOoAY3i/bRiYLd3jH9tK1AjGlSjE7zMuwNa0lbwTIS077TeDrm/KRmiziaeupaG
 KpdsiupNs4v4rpUZhoaBP/T2xf+6A8zqtXhXuKL/lp36Ad0uFfAVKMBf8Qa74Tu9/iHp
 lRBic3L0V+symNlnCLZb7owBVHRRYaEdzQihQMu962aSarPDDqKNiE5Bg60Cl1jXIJdp
 ajfIDVWHXvdh66DJquXglZHp9bU/56uGz6cuqmTeKdkaG27k2TjkZSWySY/RTc7OhvSf
 /JgnXMojDw+4Qrf1WndCdCXmhVKv1j9Xi5lgPQzuqr9Gpfcw3NNEdyF3ttjFn0d9didU
 GUSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793450769; x=1794055569; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=455+lLfkx4dPdzOmM0qfbMg8PgfKzClX2czFtPiqW6I=;
 b=qA2P6+SJL4NC6cZhwPNDCvWvrqAZ9eIDYXOc6TReM48iPammDMTK3evw43zGD50uf9
 835Lsz1XvIHFoLtOyq6CBLrmXozMABOybFN98dMMv4Vp+vPSNIhfFTc3n/sSCNCDBmb2
 Q/lk1LT1r8vwIpJtQiJ4ix+gj0FV3AQ3SRXJ2YPgZsWCcqoaUHvkEaFIU7DQMSaSmlsB
 2dYssS2CL5zLMSVXIEhYPoMDswh8RloeiYBlD5MiE8xsM4R/rBsAq1rWXSW/pUxCEoGH
 opxJnh+I0+3j8cai+IS9BExRldAUqNxCZFCUWqrmTpzZU026OiwLUuMWGVldwU3CtVXc
 SK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793450769; x=1794055569;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=455+lLfkx4dPdzOmM0qfbMg8PgfKzClX2czFtPiqW6I=;
 b=dhclNdsUMMH1SLFPxXFxe05dYQw+E9Rglg6FZUk8dRMdpIm65JEFGFH1suO0LxTilU
 b3WYJwBgfeJjRl6ABbFs2PblbWPhMwS3M7tDZjy6BZJWL//GMNqlP3bHEPjLSX0RJdiI
 BWKIPpcyUVWVcCX1VH8+l/pNX2GKauPORux6YGNhiaiXGsFXn2L9NEtjDHrXitAp7kX2
 bu1mWlhxd6m9+/KIhwj3PjQKyzvhIZ/ffpAhESo+WMR1ZOWGta875Z8V9g/TRfP4+YYS
 mr5IiEB5LjzJ5LcXvwpQu56cATQRH5kcZG+mtLnWfDemgZxKHEYUHHW0ectspNA57Ny5
 yWMg==
X-Gm-Message-State: AFq9FYKHcjPgqgJOpSy79JY8IoS5+zEn0kIDfo1+iLKu1Db1ASIMMkD/
 I56wU/FdMfSQ0WPuRmATctJ/g7ac7/vH7UAX5sDk4a7xhkU45igPkM3DXRYJLBwDj7OW8WkikYw
 Slw0owma7o7HEg+WHv/seLVUqmmzDRz8=
X-Gm-Gg: AYBFou3/fUmvL2SpZrFsfQoT5KWHEfLySNPaQoTMGYwmuW0jumMhmyG+YnSYCRjvN8B
 p03PbIiZtUjJUuQNysk1saijJ+nm1qDLeyCKkSG5Kef0vp8K8WbDb2X0idIglI6AYUK6MeT5VXq
 yVcf/1DNkp5H0BaUR84xh4VJ1Xip/vrgVuM3ydN/TMY1iUZJ1HB3HgRrnShw+PRPbyWw+cKmuGJ
 sjpb/dshSEYv8fdr+ja1/iLAEVXYpThwVu29QPp9kUbD6h29jAjdCEUEYLpJ/sA1B89mrLPVPFM
 OKMN7pfuS7IT975TPDG4E13atn1u0HIENyiANeo7xb4PW6g2ligALPeM154xrlesa7ueF3Ti4RY
 iirnbAGgcuhcyPJbS2IF1CYMOxThB3xL7oVkjIVWJTJf9r63ytWJmZbu2xzvAD7dfeqoY
X-Received: by 2002:a05:7300:8e:b0:36a:119d:a099 with SMTP id
 5a478bee46e88-36a422062f9mr8249558eec.5.1793450768940; Sat, 31 Oct 2026
 05:46:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016122113.226920-1-apolivodaa433@gmail.com>
 <050e339c-e1a3-442a-91fa-1f79aa9ae9c1@redhat.com>
In-Reply-To: <050e339c-e1a3-442a-91fa-1f79aa9ae9c1@redhat.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Sat, 31 Oct 2026 22:45:56 +1000
X-Gm-Features: AclHuK8xSPxyZDyEivmE7AvEaUQqqENk-Uv_ZP2o55XEze0qYs5N8J417WJkNWU
Message-ID: <CAGscdFuAFSuz+PLSpnPQzOqyZ2m56U10dG1D3invMkNRsvN-8A@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Reject VPINSRW with VEX.pp != 0b01
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

>
> On 10/16/26 14:21, Andrey Polivoda wrote:
> > According to both Volume 2B of Intel 64 and IA-32 Architectures Software
> > Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
> > VPINSRW instruction can be encoded with VEX prefix only when VEX.pp == 0b01
> > (which implies 0x66 prefix).
> >
> > Currently, QEMU allows decoding VPINSRW with either VEX.pp == 0b00
> > (which implies that no prefix is used) or VEX.pp == 0b01.
>
> This is not just VPINSRW, all MMX instructions have the same issue.
>
> I have sent "target/i386/tcg: reject VEX.NP for MMX instructions"
> (https://patchew.org/QEMU/20261031082849.1306244-1-pbonzini@redhat.com/),
> which I already had written but never managed to send.
>
> Thanks,
>
> Paolo
>

Ok, will check that patch then.

Thanks,
Andrey

