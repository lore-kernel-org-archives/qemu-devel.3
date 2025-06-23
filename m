Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04660C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeFw-0003YB-OA; Mon, 23 Jun 2025 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeFu-0003Xy-89
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:18:26 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeFs-0007uF-Cw
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:18:25 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e3c6b88dbso27947727b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750673902; x=1751278702; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BnEYRQCacYJlUGu0BTm72UmF7PCDIq4cgd1Y0t18Ty4=;
 b=WpoBDjhEkr+EIrFqHCCa9kpdj8CUrUcnEyNFL8naNl3yDOWusmcHPlJ66bx2JHRoX8
 L+EamymPEi3nFtbXVQn2DGF614GvGiS9RpXuIz0fKXZHVCeiNh1NqEEQoJxdDYe7No2a
 Pa7Hocofmc2XX+XtL8tXcRUIkvDFOcWGRbflcYS+GrYZ4YeFe5SD0qfT6a0RglLUqXYz
 A2E9gPWHZ3lJzdAmuqM1OyWWOnekP26axZzSmwZEbfBjyvASYgSu4to8buleLCAxw7VS
 XvK0g2zwFRrwMvku08DUNaI8p2fbUXmV6Ps9JuIcl0UIILYcY1JBf14JLc86Cqlp1FTV
 YVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750673902; x=1751278702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BnEYRQCacYJlUGu0BTm72UmF7PCDIq4cgd1Y0t18Ty4=;
 b=Vs9zkANvVKvl1Esese95j8f9TzyKAAMEtlZxOH6FuM09acGNqXSzKEtp3smUjIWy1k
 dv/7B0LSEuiE2zVzOKUPFCkE3Qt6yOBzKOxMIilcV3BPgMQCf2uQ8+NqfJ1NJrRfSkv1
 5udhKk0fbWC5v4PtF2NYnImUP91BLvlPHAnmljvJddDgBzPvFeHaRUH0pGlXXz1f0K7O
 sldYC4dmheB89c+05g6nZcHBHnuMreXXzeKgl5gd/QhAV9Crly7pwGGOLV840w6kPjLl
 Y+veln3RqipCu8Qa9gqj/AVUGyMXGKyLkLzrjgFvvge8uNM/j4PR+IrDXCtZ7vtcOof4
 qKjQ==
X-Gm-Message-State: AOJu0YzCDfZX2aR+DQ9qmz9RJ7iAeRUmhthPbwTPdzf3VGTNw4pobwK1
 GarJAEvg7PtunwXg2W67BnpuO9ZJbWaKur+4jB57Ubvm6U+cPp2P60+1FFOBObkaj6mWOPNyd24
 6Oqs6vgGdRCfT72cZQFh4xqWvuCqyQ2M0fb2mYVmalEjWvohC2v1U
X-Gm-Gg: ASbGncteFK3i0A+v5YS3lI6rs2uqsl9ZMPTaDTAs4Fu+TtvxzgNfY+yq8faRA1TfgdY
 4Dt5WIU9NRyerls+PoFbtToP8rXO8BgO2lxgm7k+mOhKUSjVRf46LQiBLWOOlApQ366PMXJvHJz
 8jhMkEpIxxAvRcT1zlB8zRWxgI/v9DNBpCpttnyDsAaLtv
X-Google-Smtp-Source: AGHT+IGgLChp5RJfTgIzoQ+lNU4phJUZuJXFlL7QAtOZZHzf/1b3WFbEpsbQYdcI2iCA3q6DKSN3pHaddLDIIS1+chQ=
X-Received: by 2002:a05:690c:dd1:b0:70d:ed5d:b4d2 with SMTP id
 00721157ae682-712c63f44f3mr185639167b3.16.1750673902031; Mon, 23 Jun 2025
 03:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-9-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:18:10 +0100
X-Gm-Features: AX0GCFuxqw-CoLHkJvFWqgzj6e7y4pQd_RkcWUE8hUfVe-oapKfgj9L2ceIQO3k
Message-ID: <CAFEAcA8s3tki8inBhq7zDhX1vU4DBGYh+kwVGgs7x8Yxw62Ccw@mail.gmail.com>
Subject: Re: [PATCH v2 008/101] tcg: Split out tcg_gen_gvec_{add,sub}_var
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Sun, 22 Jun 2025 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

