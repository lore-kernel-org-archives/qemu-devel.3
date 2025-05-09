Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB623C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNMq-0008Az-Vm; Fri, 09 May 2025 09:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDNMM-000894-9G
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:01:56 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDNMI-0005cj-0G
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:01:49 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c27166ab3so1517914a34.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746795704; x=1747400504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQsF9mqwSbgDJ5bQ8HV06//fNEUBkQooAKcBqu9nO0g=;
 b=xDauNmtcQGMV4NjxW5m5Gmvu+yKCEgacCVci2XiSooiwDi/Ks2J7m8GQexa7qCXgQL
 dZ2BokHWypxvFhAlfTX4q/hY6uWFDeSMRd1LlrlAWgIWF+/Wm/uKDvma+uoyeBKac8l9
 nmSTlqYtVHKCL9XpERBGS2A/3o/TbnExKmEz+pmUbwtvfmDKgc6LX+K2dTqQZ0qK6R0f
 YUF/CUcfBoVI2L3Z6f1v2qUJkHST/FVg0Fqod1YNxvvpTmm3nmInvlRieadxWCubfWYw
 O0C4bWYo83Z5RieU/pL3kbJpfuSRQkZ4Afqll0LPb9DNtiLC4mWsauRJ7UJLzWIgqu5q
 Cukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746795704; x=1747400504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQsF9mqwSbgDJ5bQ8HV06//fNEUBkQooAKcBqu9nO0g=;
 b=qJPIkMdLGuSkWE2I72eluxEfz1/1ZWGtjHrUvASI2JPJSdJcMWx20ed16XuWUBgiuj
 zK5ubFkh+f3GQ36h4pl+sLhwdkXpMR8m+4gfGIK14kwE0X1shraYqXDHYDbVP5fbXoNq
 oeqV6kasoNUzySacR41qqqPAA5mXXxvcSDo3A1nrLLNdJbAACrDhLzKlkyZzRVIyAmkj
 6PElgaJIOppXL1jMbVjfvySISOITczG9Nba5VLRh5FYqSJtbDZcJ+rPD9+IMcjzHCmix
 xRvI0VXnnSo/dDgrt4g8x/HnMpMfiEVGMzpUzUIaBhhQTRs97+xoC+PzXH46fek5SkH6
 L2Nw==
X-Gm-Message-State: AOJu0YziQpbiDSChUM/DOtqqV8hQkQrfkOiCQL2qoLlmk9W7UWG7jOUe
 J0G9jl73dKsEfICU/O9Pfexl8WRoeURV/mUmkqvKIA9tyFeC+4o2mUoy0CI4Y2bjnKIqNSavvbk
 jK8qYN0VtCUF3csUo7FdiPtri49VdEnTf6hqdew==
X-Gm-Gg: ASbGncvq47wK23co2KwK2N7OuQhSqdnVVinqs6sfisyv7yhxsoyi2+Ipb1ac56eRxje
 Kjc3x19RITBppge2ghhhfLXY1i9mdBlfgp8HE52jo8Jv/z3FsYs8rsjdK6lCWlkQ6/k5Ljhuqwm
 q09+L7LWCcQc1CpvJOUVDEso8=
X-Google-Smtp-Source: AGHT+IHeW9zt451+Pb1WqEVsy96NkHzgtFyM7yTG87NOHI8U6I4MJM0Zkuov52SV4aZ/iOk/+mNkDGvPJiJyqy8ZXBQ=
X-Received: by 2002:a05:6830:6688:b0:72c:320c:d4ed with SMTP id
 46e09a7af769-73226af8b1cmr2397397a34.22.1746795704124; Fri, 09 May 2025
 06:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250508170100.876374-1-berrange@redhat.com>
 <20250508170100.876374-3-berrange@redhat.com>
In-Reply-To: <20250508170100.876374-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 14:01:32 +0100
X-Gm-Features: ATxdqUEHfogPs1UzVraKCKiXAL6OdTR5njOEYnP5Ub3HLDUkgX6yoGZWvFBfHso
Message-ID: <CAFEAcA92ozQyydi6ZKc6+-bZ+-ArXDksnWtb7KJb53hmD7BKAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] scripts/checkpatch: reimplement
 SPDX-License-Identifier detection
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x331.google.com
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

> @@ -1442,6 +1457,8 @@ sub process {
>         my $in_imported_file =3D 0;
>         my $in_no_imported_file =3D 0;
>         my $non_utf8_charset =3D 0;
> +       my $expect_spdx =3D 0;
> +       my $expect_spdx_file;
>
>         our @report =3D ();
>         our $cnt_lines =3D 0;
> @@ -1679,9 +1696,38 @@ sub process {
>                         WARN("added, moved or deleted file(s), does MAINT=
AINERS need updating?\n" . $herecurr);
>                 }
>
> +# All new files should have a SPDX-License-Identifier tag
> +               if ($line =3D~ /^diff --git/) {
> +                   # Start of file diff marker, report last file if it f=
ailed
> +                   # SPDX validation
> +                   if (defined $expect_spdx_file) {
> +                       &check_spdx_present($expect_spdx_file);
> +                   }
> +
> +                   # Reset state ready to find new file
> +                   $expect_spdx =3D 0;
> +                   $expect_spdx_file =3D undef;


We already have a point in the code where we say "ah, this looks
like the start of a new file" (under the comment "extract the
filename as it passes"), and it looks for two possible regexes,
not just "diff --git". Maybe we should combine these so that
we have something like

                if ($line =3D~ /^diff --git.*?(\S+)$/) {
                        handle_end_of_file($realfile) if $realfile ne '';
                        $realfile =3D $1;
                        $realfile =3D~ s@^([^/]*)/@@ if (!$file);
                        handle_start_of_file($realfile);
                } elsif ($line =3D~ /^\+\+\+\s+(\S+)/) {
                        handle_end_of_file($realfile) if $realfile ne '';
                        $realfile =3D $1;
                        $realfile =3D~ s@^([^/]*)/@@ if (!$file);
                        handle_start_of_file($realfile);

                        $p1_prefix =3D $1;
                        if (!$file && $tree && $p1_prefix ne '' &&
                            -e "$root/$p1_prefix") {
                                WARN("patch prefix '$p1_prefix'
exists, appears to be a -p0 patch\n");
                        }

                        next;

(side note: seems odd that we have 'next' here but not in the
previous half of this if()...)

                }

and move checkfilename() to inside handle_start_of_file(),
and have the spdx check handling done inside
handle_start_of_file() and handle_end_of_file() ?

> +       # End of diff, report last file block if it failed

and we would call
          handle_end_of_file($realfile) if $realfile ne '';

here too.

thanks
-- PMM

