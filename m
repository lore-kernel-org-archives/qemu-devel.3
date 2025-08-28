Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB25C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urYwG-0003uX-K8; Thu, 28 Aug 2025 05:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@cloud.com>)
 id 1urYwF-0003te-Me
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:28:59 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mark.syms@cloud.com>)
 id 1urYwE-0006w1-32
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:28:59 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afebe21a1c0so110603966b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1756373335; x=1756978135; darn=nongnu.org;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AOdA+ChG2OJRi9GeaHFeK6eceIsji99wtnfgd+DpFZg=;
 b=Tb3VByAMDGbcxsnjEmhPa7IoXNewByJH5zKdSzs+chcwxQZrFQrwv1JNvyrM3KmWIY
 HvP45eFfsalN3QTT5p9AwAJwrzdMCHIZiTKZ3S3W+bcNZ/dw5L4jM+LNVUW2wgpzTvqD
 K551GN4+alRgqiW0u+ycZqz3CCZ2mNWCOwENc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756373335; x=1756978135;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AOdA+ChG2OJRi9GeaHFeK6eceIsji99wtnfgd+DpFZg=;
 b=opi9wYWypkDfYZDZav9vHGEqwhUIc7iUUWhBPUcXA/sWkpXj+i40HfefkXS9fxNXq9
 twlzDBNGA10KTCjJgdHmpWopsJx4GHFzSJkjdepheL+mzjd//iQr3iTrm/ThzfFqIwBv
 k+8YAL0HfnZiay+04djH+DgnlEEi+UycLqkW1jOJTH7EUjaXSEnKXPiKpzX6ci7/so6X
 A7hfLf5+8edVF/3SYcEv7MDsNlDuaVuxJDOHiffrhLVQoWLJi0Ee7i0hb/wSFClOhGQJ
 7Ui7J1aaAg6XHAWIGtNQrdpQarc1YclTV5SGpXrsnpslYMzaq3gT51HP2bjAfO9vMAmx
 bwTw==
X-Gm-Message-State: AOJu0Yzh7FkZmhsoSRrz2H23fIwhysGpRYt4xKogyq1CxvGpooYtFp6s
 rM09p9D65u0DyKzdVZkIMm3+jHL9CgbAf9jBxipn1/Xc1gcVCD2af3bvPgbboJ4ohNOSe1Y6BvA
 mFUzqtSNWlumh9yRtSHw6bS4uHF0VXbAhN91zi1mrAToXwClp0OOsGHI=
X-Gm-Gg: ASbGncsH9+2Qc1/LYiNMAqMjx8Bp9SLeO43WgHac0Ow25RPxgQQ4O/g8BXbWipBayyQ
 UWAUMHSnDy2rWWAQf8CCXxznN7CmJjQQmFpW2PcBQTrSBq188vb9pks7qTwePR2f7dsxtDb/9Ui
 7YbbI+4sr2ufhLyC1/Jn/KeqD6kgQ5l7uO9tVS1MIPF22F5ySRAnF28b1j8GbNQpL8C2WH6mVAg
 RWCd9Ni
X-Received: by 2002:a17:907:846:b0:ae0:c690:1bed with SMTP id
 a640c23a62f3a-afe2954f636mt1705321566b.51.1756373335437; Thu, 28 Aug 2025
 02:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250827160841.351707-1-mark.syms@cloud.com>
 <aLAHoR3BtBz9G9Q0@Mac.lan>
In-Reply-To: <aLAHoR3BtBz9G9Q0@Mac.lan>
From: Mark Syms <mark.syms@cloud.com>
Date: Thu, 28 Aug 2025 10:28:44 +0100
X-Gm-Features: Ac12FXymndS46AxopGxYj9mkgbXiK1MJvc3NVcHdjpqTRtoppZ-Zsa6da0bUJvI
Message-ID: <CAPYKksW6df6cAf6fcH_gKj6+0tVADGtyKw-2weryr1pPfTqHsQ@mail.gmail.com>
Subject: Re: [PATCH] [xen-block] Return BLKIF_RSP_EOPNOTSUPP for unknown
 operation
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=mark.syms@cloud.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> The comment in blkif.h contains:
>
>  /* Operation not supported (only happens on barrier writes). */
> #define BLKIF_RSP_EOPNOTSUPP  -2
>
> So in principle BLKIF_RSP_EOPNOTSUPP is only to be used as a response
> for BLKIF_OP_WRITE_BARRIER or BLKIF_OP_FLUSH_DISKCACHE requests,
> however blkback already uses it as a response to unknown request
> types (like you propose here).
>
> Would you mind also sending a patch to adjust blkif.h in Xen to remove
> the "(only happens on barrier writes)" part of the comment?

Sure, no problem

