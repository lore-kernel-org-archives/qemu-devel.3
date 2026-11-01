Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Jme9bGmm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNZ6K-0004hF-Kg; Sun, 01 Nov 2026 12:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1xNZ6G-0004h3-FW
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:12:08 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1xNZ6E-0006Ki-S0
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:12:08 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so2839472a12.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793553124; cv=none;
 d=google.com; s=arc-20260327;
 b=Jr8dmUXD/HuCMKVL/mToPlEj4SB0zr3RMQelxGSdmUdNpsPr86IQ7S0Vx8Ts+n1WeS
 ZQIFyCC6N+Re9TK2QAfBvMmD27sF37p86hZFgzlghkaRWsGZFKU1UL3WVljmfKR4TPw2
 DyMB64x0nCauNXeN4pUyUf8afcdTShmRcFqVdvCjlgtgZgtunWEYHjJdvQB7lznLZ67C
 dZJY17QbgxqlW6XZkugVVsPG1QUBN2f7nDI/DZ6OXGbK9FAnBEpKfyyWpUyASd5NfhxN
 2LtXwjXLWIPQWTm+zx1DDBuVVVYI8hfMpTxBmJcQUzALkNJlxbsEGiKTgBhiEy90BrXj
 ktiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 fh=JAnDNkSkWqCq6HKVzvYXIOstaTHBuKFabkCviXZobgw=;
 b=DAXlLWxBYxXWv8+n+wSoIyzNnahG3AWtak2HQhMedvW3FEoZvukUElSBD73b12p+ew
 ePqQYdfpDr1U5qFKMP7g1da0Z8fujZVbZom8oehzUmnYaFlEa8iIDCKtL54Ql8Vy+ggE
 79lh+3ESDTrS96ofkD0gqQylBUF8U6/G3gC2LSnjvEnFKLooX+86H0EyZHN2F+m1mOvq
 y3iNks+vTyHp2PRY5egFH0EzqpIT+I4vH/RgEAwDCoSmgcqZ22fJmGcBYzr1dhpYK8Rx
 Ovn4mr4LtcxlHzADfI2JBOm5cRuiXbnN7HUPAxvE1wJSuwOLl5jz2R6DGumEQBG1KWAH
 f6cA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793553124; x=1794157924; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 b=Jme9bGmmUHf0OEyJLJBQuRIt6PTvkPXX2o0aD/VENI5s6ZpFBxsFJeRgwB+6UG6EwI
 jJrqznu+pUFXJMuWOSt4Z4muLQcHy9DOcQAG9UmNvrUNyYQqeUv2jWWjeRYycCfH/ckB
 xHlVx4KYHjtJymzagc7klrOrCGLJKFc4MYqtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793553124; x=1794157924;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jxMbUWd3E3b/BAPkDFwX18VQcTmUkrojickDvQY3aa8=;
 b=Gs/rxn7oYVy2cwjPIKnzCYCE4n8IwtFd3Lp3hKOOqeOA9g/8KtrCyhvLBlCmr8fRRp
 4rE9Agjt5/alwv4KTx6W+6GVcFXU4DcGSJKgxd4W4/U6tkn2FiWH+sp4aKmzj2LXxkmG
 ZQJaivcFFiPIb5AGC9rBdQZTlAC0dM3UMc7r25tCdotviRslUDZGH7hA9iX8rLMyCwS2
 KsIDHgIWIizjb/nyhtaElAJ2NrQvSqx47sO9sb7IQbKCBTEu6lQ6x44nIlUiH9q/O+T0
 v1ZZppjIohoHR/7yOBd+d9Z2yfrkwqocgEV56j8LIsL2ApglUcM8WsKVA5uV92lN58to
 mT3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhNqwN9TOzFv4AjZ/TciqeJbF6Ut3d/53vJRB+utAla6INKn843aWDn5LxxE0ECgt5ncIuGYQ2QBEo@nongnu.org
X-Gm-Message-State: APuU4Z9mJZWudttmgAAoqHoICF6UfOWT2rPx3IM13DE6d0cg7lCkVheL
 cQvDdcCat74sdLFxOKA/kDjk2YTWbF+uAqHCIJlyuolQesf3AYGFvchyqdUzYl759M+nx8Bp91W
 Kvga8gUXgDAso7qAnRWC+krmWYrP8iH1VFtwq2ETh
X-Gm-Gg: AYBFou31ZkZPqz+FUhWwjC1OoAu8XeoXd/Ph/qyZXqjQdLHHtgngcNt+HjTNV2oqQIJ
 25nYKn4K2Zf+dtAjdjcEnJC2XMEnLYLZzv1d3FsYh3US8+1NMpJ6n7+tVchG+xdDYwWeDBbnCpU
 j0Fo/Qk4rfagC5JXgU3Ymt+p3hRTDSB14x3pbMZhgNCEgsv6LxXKkcl42fnz77tyoJ6ua3JFiRW
 8HcD7ENVjxXWjAOZqFHfS8ek5g0wyEH5NbVjfEZYinziAMXVjObvt/Pqo5qgnJkdbcFteSNt08q
 E9Yvac+dzgAO+9wHZE9Tfbgco5z12keXt7ubNMje8N1Qd4Pl7hIOIjrDx6JpTZvGbR5U1yJqktr
 0O+GrqY8i9KPVhBZXC6fqJKOPyajMUbygjWoYPoB9qUIzHFWp6sw1UnXtapdz4UC6Hi+Icg8=
X-Received: by 2002:aa7:d511:0:b0:6b4:29f9:1e72 with SMTP id
 4fb4d7f45d1cf-6b4d33765admr3864909a12.5.1793553123707; Sun, 01 Nov 2026
 09:12:03 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 09:12:01 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 12:11:53 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028054141.2933271-2-bin.meng@processmission.com>
References: <20261028054141.2933271-2-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 09:12:01 -0800
X-Gm-Features: AclHuK_pBJpEjm6OUmRKnRUF14DI1_WUhed_UG5zgu6kV8Ae7IP6OENoywWxO0I
Message-ID: <CAFLszTjfx-te2tSUn64AOB-LC8kisXrZ+3D5=X4vufsO35ffwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, QEMU <qemu-devel@nongnu.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=sjg@chromium.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bin,

On 2026-10-28T05:41:38+11:00, Bin Meng <bin.meng@processmission.com> wrote:
> diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
> @@ -6,4 +6,4 @@ F:	board/emulation/common/
>  F:	configs/qemu-arm*
> -F:	configs/qemu-arm-sbsa_defconfig
> +F:	configs/qemu-arm64-sbsa_defconfig

I suppose the configs/qemu-arm* line above already covers this file,
so you could drop this line, but anyway:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

