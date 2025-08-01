Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70694C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrSP-00067O-GF; Fri, 01 Aug 2025 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr9v-0002nJ-SY
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:55:02 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr9u-0007db-Cb
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:54:59 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e8fd59485d8so1164933276.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060094; x=1754664894; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XDlRvUyvHuP2/2yskYfdWg64eajmSUmCG8SYp0PdHIM=;
 b=z2PBXEoP3IKzh+e99gWOvO+d5SWJq11RVw5IcPx7rcvfYqvsERhH71hiqvTbdPc0xI
 PBD8RKN+6XnjXT5ltnDaDwnwSfjx51rO2FKseBZgyexNGVdocQafw9rAYRanRhgpcJ6y
 hEMmJWyoQioCU412/8aQWM0lEMFwg53xGznEPi5Z4gOcLJE8qWac42bRr3G3vYLUj0tG
 D155DxsxtCps4X5HE86t/p4kAzrrSXICP3ocfR5z/2pO13y1fdyQH0TemXi8frlfLnF8
 68GQhyMMh/lcKER6Pc616dNRi1sIh5nvp8F8WuS1mcpMBNsrKZFWZBWx6JfKViuKY9kd
 Xkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060094; x=1754664894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDlRvUyvHuP2/2yskYfdWg64eajmSUmCG8SYp0PdHIM=;
 b=tYTpdpw0JHt/q85XFQlTDCeiKIphdHJn1eGbURiUX2MDOhDtbaPlIromJeH4xECs59
 23lDChUpaAO+sh2XsXAYI7a8Bbmekj6cXNFMRenUL976gmyvD+wCp8p7ctLcghuVDEqQ
 m+/UCnTHmbOsd4GJAm7tKnRoSd1nHFvdfnkesWK2+8i2oE5Ix0HnJNWNY3OsGulSFNWa
 y9CBKycIRe20iGCFlVgQaYexOqMFd83k2XQ/GA5ii+hGoDkjzuAaRPMPa8DcLz4TyIRN
 PW7XyF94nuuRVfAadvpz7FUAmbiXL0KwDM3ealW1/5LZ52YlVTxsNffb7ru9qSwRSLDq
 6/yw==
X-Gm-Message-State: AOJu0YwJ5Nx1EoDDIk99Mm8jEOL4xWF7zLLr6V3tcmoKVZglOa9KtBj5
 6g2Iq0zOrJqancr3iNE7mCq8oqqZx2k32swNGXQaQAOK0C6REZXkGCZoqj/ZjYMZEZMvr3INWW5
 eKkWXfOVpDGzL4MRyXQRxICPYqkMqygat+deQyixhwQ==
X-Gm-Gg: ASbGncvXO49uyXS0uLk7QquX7x1YvMWV6CqDc9hJJHDmcycLRSG8MXQZO7ir+iBAg3g
 3eVM2vOlZjmyza4ENBExXQxoypxgZEl5shb5QPpCWKkocGQHvAHSczHLHswq+sStShEu/FBmMLw
 NSMLq1dCFG6hw98sCr1uOkSMhdh3Az++zDM76s937Cb1yaNsVspaDh9CNQP3v6sf4tqbnQ6anue
 KrWGgf2IeuxzW1z6Vo=
X-Google-Smtp-Source: AGHT+IGLJ1d79ki4QkDd6Uyy+S7CmIuU3xRy4ryeXxp2ZmKzJ6eb3yHW7GkwZXOgg6c9fMhFjdC//PJ/AuL0hqBM8f8=
X-Received: by 2002:a05:690c:7107:b0:71a:38ee:1ff with SMTP id
 00721157ae682-71b6d77bc79mr35147987b3.25.1754060094436; Fri, 01 Aug 2025
 07:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-7-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:54:43 +0100
X-Gm-Features: Ac12FXw4k5ypik6lrVxbd5xjSEKXIggzieT4zd-CTVVZ-0KX5flvl9ESxRMhCkY
Message-ID: <CAFEAcA-Da_Y4OSeH_cfmmqU5fMVvL4L_EtFCcOnzE=d_JDpuJQ@mail.gmail.com>
Subject: Re: [PATCH 06/89] linux-user: Move get_elf_hwcap to
 loongarch64/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Jul 2025 at 01:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

