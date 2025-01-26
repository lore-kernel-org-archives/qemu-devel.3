Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00706C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 09:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbz66-00005h-Bv; Sun, 26 Jan 2025 04:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1tbz64-00005K-7C
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 04:38:28 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1tbz62-0005sS-Pl
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 04:38:27 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso6185016a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 01:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737884304; x=1738489104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYXFH/NXmdJOu2qSI4OYG8rVdkXuwqjNWBjqnq2+yJA=;
 b=jVeAr4qczYbXwzQamVdy+QxoVWZcY41NABcR0l2OTjyR+Fhhmk5/8Aj4dlPYvuitvA
 9U16jXpz8e1RaGXRazorm/ADB9ZmMKBE8VHuZtbSXwwT2lRux6M2TBRq3dHR8wz2TQPy
 f9q4oY17EEhMqVEKriyXDdDGKiFL+Z8rJuBHjf6O++7+/bZBGTvoqVv8TVXdcS3w1m6l
 1Cx7MS/H7MOXeSCTxsKtOqVCdC/dmwpvoWH4+ahIXERmTRJ920yOTQEauP9IDehJTw/1
 ddpC4M5w8QzJOdjoWFIPMsxMXkARwsOlKqJosB45jBrAJskBq2Jwg38s6Ztpzz9hn9Ji
 zKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737884304; x=1738489104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYXFH/NXmdJOu2qSI4OYG8rVdkXuwqjNWBjqnq2+yJA=;
 b=Xp62lc9Ur4IsFnxcXI1HA0usKbNw6PpgGUNGvY88uVwifhLpLj7K5ua9nebLnrCz6e
 kiqeCtu+rnSah+MkSdot0vjahV/9QNvOIP0hD6TQVLicuFZge5Wj+16a5OMQLJvT17RL
 xVUNYxe7pDU5bg8uQbO38CaTYR0XZ69p8POnU7oMxvXdIwbfERz+qhOvaZLR++WDQZ61
 BJXGvuit4wJy0tRVkxRYUerCA+Oy60DdpPZwl8l3Iy2mIYGjmzhpfl1azbH27wFWSp4e
 r7j2WBs+c2iyxfOQwRbQ5fN62ItRPz3frNtO/p1q/2nrGvUvOzYuhZJkBKy9m/YF5rIF
 Q/ag==
X-Gm-Message-State: AOJu0YwJS3ThVWO60WbZvyrkwkYn8KT+bQKkIo8hZoqy5Bbr6rguSYFP
 GqVq1ED/oXtwcP9IzsVzQ46UsxsnK50prc5x3cucVaXQDALe/bkrXaCaTDtTqZeY2s0rxli4Oad
 w6eR1Zvw2eLD6JI5iOQ5pfVlrdLg=
X-Gm-Gg: ASbGncttP3QwoWqdDpBzL/vVjqJrlHW82qa1PGxSJuuMRLhiMDPUcwda0kkCXjsWqk7
 u5GJ5BhK/4e5w84CcMfuYe9Y+v+FgPp/G25vOOUPwdyB6VN9JS+R8Q5AuTFlsdRI=
X-Google-Smtp-Source: AGHT+IGqVvZdXnz2+Xr9q6hBvmVDSzZ9rePGU3HMi0I4Gn+lnCteHs++nccnsrXNgyBXPqjIaW4AymOBHGk8ojKt/rQ=
X-Received: by 2002:a05:6a00:4647:b0:725:d1d5:6d86 with SMTP id
 d2e1a72fcca58-72dafb91467mr54034310b3a.19.1737884304599; Sun, 26 Jan 2025
 01:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <20231013212846.165724-10-richard.henderson@linaro.org>
In-Reply-To: <20231013212846.165724-10-richard.henderson@linaro.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 26 Jan 2025 10:38:13 +0100
X-Gm-Features: AWEUYZn_EzrcM4KIR1X5J_psumpQBJAlIMxh0XPIe_OZfdvpFYgVq4P1j969Cs4
Message-ID: <CAAM0arN7MW4+HYHiBDYa9YOqvaDVcDn4sOczAzZM1Tbjb9CsVQ@mail.gmail.com>
Subject: Re: [PATCH 09/85] target/sparc: Move FBPfcc and FBfcc to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=a.tarasenko@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

On Fri, Oct 13, 2023 at 11:29=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sparc/insns.decode |   4 ++
>  target/sparc/translate.c  | 105 +++++++++++++++-----------------------
>  2 files changed, 46 insertions(+), 63 deletions(-)
>
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 838f4cdb1d..9ab3f2eb82 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -6,8 +6,12 @@
>  &bcc    i a cond cc
>  BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
>  Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=3D0
> +FBPfcc  00 a:1 cond:4   101 cc:2   - i:s19                 &bcc
> +FBfcc   00 a:1 cond:4   110          i:s22                 &bcc cc=3D0
>
>  %d16    20:s2 0:14
>  BPr     00 a:1 0 cond:3 011 ..     - rs1:5 ..............  i=3D%d16
>
> +NCP     00 -   ----     111 ----------------------         # CBcc

Do we have a convention, when do we use "-" and when "."?
I plan to add a few instructions which do something with special
registers on OpenSparc, but would be nop in QEMU. Shall I use dots? Or
rather dashes?

Regards,
Artyom

