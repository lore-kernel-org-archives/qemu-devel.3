Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB86C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNSh-0000dO-Ub; Fri, 09 May 2025 09:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDNSG-0000cc-79
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:08:03 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDNSC-0006CU-Fy
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:07:54 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e78e6396d36so1517609276.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746796070; x=1747400870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1c4pmcwWxFjlMLDuaWd+mWuEulRfH1Wrn6+TeiWWmYM=;
 b=eit5ZRZMslii/vfwFg1nn7PSbgExEdv3b2QuikLAGHYIVb3q/ByfV8Af+ZYzEiC2Qw
 YUJ1v50SYhAFKF3468Z2td7HY3EUOLq3fLVe1wuE8g4dZavSMQtQE6bZoe0XOM8beiBS
 J57ySike9jOH7VpvQUlZ0AehNVi+P9Ogp5/mqzduP+XxANxYelFq3nhuP4ZRT1NJZIQ2
 hjzfMQKa7vzme8KbOmwZMcuj/vyxCaeRe8Is8YfPLts5L9axQf2Z9ytibzY3Ox1i+9eV
 1UYLb0dWo9+EirZO8ok5eYcThh9QmRILQaj65W6+JnhV8XAQrR+8EIa0EailbTNdXxNx
 3fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746796070; x=1747400870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1c4pmcwWxFjlMLDuaWd+mWuEulRfH1Wrn6+TeiWWmYM=;
 b=Eutt0ct5cZgQqsNH9gPgL/wxne4o3Vs7+tFr5PWFqFOOiBkjuk6UeG1a7fE5t7Fdd8
 lmL+zJcNZgN+Krznk/m2RU/VdLdnQf7iuZ+hUObGBiDkBIu6NJhUs1xnWDbUUfl/2HJ2
 citxyF80Em0273H0XeYIGK4CwYKhE1Ghd4o++bBUl4NEoTiPWqHC2T5aJ/X/Frc5v5IS
 yHFFBNGN7zsR2yj3De0eSvgCETJPnlm9d2pKUfLROz60H3dzBRl+S/BeOss+AyVkV32j
 4AdnknvT/FQCsnccKTvw0uPXCtnWEfUKfochNED4DZhgCaGifrPcq1po5mkHng0Imb0N
 eIpA==
X-Gm-Message-State: AOJu0YzfdUCgw/Q8FTwS2RgteI6+Ok0m9Fs5mc2F/X7+QCLgV8rw/tXk
 lye7SahW6uwRjI4EH948vg2O+1C05bUEYXxJwfufWQ/KBlfEArK0sYTuyNP8+PKIO+bvuNL+E9y
 whvJ2jjCMRP/bz6qauCQR9bTSg4emp6dx7CIrGQ==
X-Gm-Gg: ASbGncsIq331FJ/sE1x+ey+RwXSm66C5UBkqcVKjEOURDFpaWl0lO+p5LRVInqO00ft
 gknCMYlaFw3SP0GaKewDLrqrVxfdr8ZHCchWG8oyPZiPK2VImBic3Q6cs8MnqgzE6RRB40EIeA7
 i8MrdJTKWP+/0F96cZHQvpiBnPAt/iCD0Bwg==
X-Google-Smtp-Source: AGHT+IF7flI3eyzghZXZTNa1TLKXUQ16YiRleVMAfJhZdFBgaX9CjAo5FkUftZN3DiYnBU8vYl1LyoNfH97QXHlXUTw=
X-Received: by 2002:a05:6902:1b03:b0:e73:930:cc30 with SMTP id
 3f1490d57ef6-e78fdc2fa00mr4173992276.16.1746796070059; Fri, 09 May 2025
 06:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250508170100.876374-1-berrange@redhat.com>
 <20250508170100.876374-3-berrange@redhat.com>
In-Reply-To: <20250508170100.876374-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 14:07:38 +0100
X-Gm-Features: ATxdqUF4K450sFmxhLaPX-Nc9qRxHEbcNd0EoUw61CdVeRMQbhT5F1qc1LmVKb8
Message-ID: <CAFEAcA-OYZeP2UCdcPq5OHe4GJ+dP7U4PXjLp0_JsbsaADHSHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] scripts/checkpatch: reimplement
 SPDX-License-Identifier detection
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Thu, 8 May 2025 at 18:01, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The new attempt at detecting missing SPDX-License-Identifier in
> new files is using the following logic
>
>  * When seeing a line starting 'diff --git ...' it indicates
>    the start of a file in the patch. This must trigger reporting
>    of violations in the previous file (if any).
>
>    It must reset the validation state, since this may now be a
>    pre-existing file being changed. This will be resolved by
>    the next rule.
>
>  * When seeing a line starting 'new file mode...' it indicates
>    a newly created file and must enable SPDX validation.
>
>  * When seeing EOF, it must trigger reporting of violations in
>    the last new file in the patch, if any.


> +# All new files should have a SPDX-License-Identifier tag
> +               if ($line =3D~ /^diff --git/) {
> +                   # Start of file diff marker, report last file if it f=
ailed
> +                   # SPDX validation
> +                   if (defined $expect_spdx_file) {
> +                       &check_spdx_present($expect_spdx_file);
> +                   }
> +

Forgot to mention, but our perl coding style in this
file seems to be generally not to use the & sigil
when making function calls.

-- PMM

