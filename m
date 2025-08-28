Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756CCCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJD-00006H-Rv; Thu, 28 Aug 2025 13:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureAn-00038A-TG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:04:22 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureAk-000465-Q2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:04:21 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d603cebd9so9422847b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393456; x=1756998256; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CYDMswmag37+JJm6Bd7BwDTkeMUpaMigsM0nVos7cso=;
 b=AW5wNr44CepwoXet2HxPenrX+MYF4sjr8UUW7tsoiaGpsEJfXGCXKTta/u5B+gcAXT
 bUd49pE3zvgN5UfQM5qoJGc99UXthKdV4/8Zy7jwAnwQhY6QbHD1bB7Lya8e1EmNvaul
 zamg5LsToed+YA4QDGZhfEsU+l/p4+sESUvQhMszbUnh5X/F+ZQISXDhJHszovvWci/Z
 vB7OiQBLDT7z8HKPzKJmW7nQRqayj0ShoAeeGm+SIuiqO/Qq+IEfJ+Svz6AgSWn0q2Tr
 EiptROvtIU/saAXu6/YcFM6UEewx0Q675GbiyKlhXCFqBl3sFBSaH2tmOrxgVNxLVAWC
 4VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393456; x=1756998256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CYDMswmag37+JJm6Bd7BwDTkeMUpaMigsM0nVos7cso=;
 b=b75N6nLaRnYVCkrriu0Bka2SUapiP94qf1t6zO3TPb5+OodTOF2MXofV2Ni+kSyN8Y
 icpgML6xxwmEQbvyUGU2PW6DiNAngBb70ZESum92p0wU6MXwHmfbTgoLR99+L2dWzbkK
 SjHYiyPe7sbGyU4X5yM6MueGINB4uvuhMxC2rBgjn2ECFjW9sfkkak8EL8568sWcvOvT
 SO8oPD9yNskkCzTn/r234f1TigSxvdbWHC1Ecge+YoVfpPUZGksly4u2FPup62wqvyQY
 1TRusrKkXAaN0DcUXIFlNTX43LrmKG/XGMDPMfx1h/NahpZ4kS6q4ZTOVsk/BSOrUONR
 8vuA==
X-Gm-Message-State: AOJu0Yy6EPJJdZmOQJTVxbUfIRc6juA7W8zkX224AYKpZf5itopTB7u9
 oL0glJuwOb/7iPiXHwo6ew/al1Dxy7jIn1m5UrMHco4VNiEpg8/Nwxls+lNgSt0d53J+lHt4BA6
 l7+bOJJ56iAzMJTRof+e/IM9iyPtr7NLsWYQdwZ/RPH2P3oc22Ooo
X-Gm-Gg: ASbGncup6WDXLjcfoSooPBvAQbdb1DIwC5YUcH1h+bxaX5QewJkmmxt1OarEQn87FTW
 YxN8uPIHiqJ5cI/6cGifnuOW8XgrW7i1eEj/RuAnqSHn6ldH3jk/5l7AcNXC2FWYWakqdRbk0S9
 WGVPkD8WfLk/FYBVIxv4Xy55fq6KEayGfk/GhGmtB3NWssg5UEYVIO/64vmwGdTFjAkkd9VsSdz
 mPj2LOt+CXTz6IF2jk=
X-Google-Smtp-Source: AGHT+IGPt7EypGgTkHHXBbiV1ZebKkmvJSvHGOF9WT7NA6kWvFLwxXxTMW1EShYGsYuok0zZrAfghF1WVugyQKrKtAU=
X-Received: by 2002:a05:690c:ec8:b0:71a:2d5f:49b1 with SMTP id
 00721157ae682-71fdc2f0d76mr228138107b3.4.1756393456525; Thu, 28 Aug 2025
 08:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-47-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-47-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:04:05 +0100
X-Gm-Features: Ac12FXyLudmq8DEBYQsu31D8-aOEeZp1PcR83DxfQpwKRj4r6cNTcMxOy-1YS80
Message-ID: <CAFEAcA9xYJNko8TR5xKu9+Zr_0NiLKuH7gRDAh3keN2fQ5ccxg@mail.gmail.com>
Subject: Re: [PATCH v3 46/87] linux-user/mips: Use target_ulong for
 target_elf_greg_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> The target_ulong type matches the abi_ulong/abi_ullong
> selection within mips64/target_elf.h.
>
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

