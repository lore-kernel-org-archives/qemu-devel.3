Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28270C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzch-0000bQ-AS; Mon, 19 May 2025 08:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzce-0000b8-2M
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:29:37 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzcb-0005zD-0i
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:29:35 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70caa34282fso19158017b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747657765; x=1748262565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPy3CqDUi1VOdpjxxq3aVoh8QKAI1aZIO19c25lpVt4=;
 b=ZSpK8LFk2ye4nFbICjmfJLx/61tEQJbZVyDzNFu9AsnQym59uSAKdGeOMPzB5dOJyC
 9mi4QKi3Iw0xZIrDbTOmyXCmYkdTfR6eipv/4D0hp1EamcXfwPbp5HBUdQvgymScM2eL
 BVh6lQ4l+uh24oCVv5dJcJKo4i5Q9dOtNs7HsQVLM7kgwU7v73EMOgWNR4tH9/v1Xd5m
 +4Apxk2jbyyQYqd5URaKGXNw4izQedcII9U5JyTqUQtAYTU5YCYOgeDrdUeMiATgWYG0
 GViHAHIcYyEkN0vugDm5jP8DQOMRw/rg7fFIwyHlLGxSomK+UwOOUVs1TeIGUZj/mpl6
 0mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657765; x=1748262565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPy3CqDUi1VOdpjxxq3aVoh8QKAI1aZIO19c25lpVt4=;
 b=HtryZ8PN9ssb3Fh3d9wYFCDe7tPPbbm2uAtRsp1B+xnNrD8wI7febYN4McNYBLQNWD
 WV0M8dYXxO+SOChvnjX1LhQ20HVAV30DVRl/kf4sSYhkbRHaduxgVvcdwmcPbg0h3kEj
 /a66CvA+S2rTR3FKhcirbCoi2VSD+wRcEbxgXylJ94TXvFBx151ciBqcrV/RZt7EE5yx
 OhR2BCSmeCf4x/FKemthvgxKndAIyU2GG80m6UgsEexemZgOfo/nnJ7/71Nqncwnnhgb
 tybznGoRqA5N28Sm6054okhRaXDe1MUT/NSbtsP69psNoUUc0/EaoEvUyIi2oGHzmnf+
 ySWA==
X-Gm-Message-State: AOJu0YyjH7h/ELg4KqbC2SFCqY9LLl8SwUsAPFUZ8eLG5yJPpKiKW1OC
 DSE+D+YDtEDGfPN50695VqgvdbSQyH8c4rbdh8zdqgcuweRoBITr3MyG6bJ5qm3u/uSy9XpQjzk
 qjBUbfWCFy5+X329kwmK7NKVVvdGv2aRQt7nzY5Qidg==
X-Gm-Gg: ASbGncvHfZX0MfVYqFYAT5DsyFfjhjM6zrz7FTiiXItBoqYxPC8Du1IveeLXQwY87QJ
 LEeORsVDRUzs7YK2bLF5N6IFpY+i31mUoJ+Xe5UUzccSr5QWm0I9JWN6mP/g64xiCHVRPKGyBbO
 MIwLEoWD8IjVA8h8L7ZbLvuiJkXTWXi4G4qtKVFYTAC+aB
X-Google-Smtp-Source: AGHT+IGfpETL7YAV/aMhb+JTnVbEHoOHDv1rx4+vMggIQO3lgfTcOa3KzQX/FPOgcX9ANaK8OQcd+aQjhS/ISUszJX8=
X-Received: by 2002:a05:690c:560d:b0:70c:ae79:255d with SMTP id
 00721157ae682-70cae793035mr103747787b3.8.1747657765322; Mon, 19 May 2025
 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-5-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-5-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:29:14 +0100
X-Gm-Features: AX0GCFsznLsf9ujqhc8V8yNKSzKobIDY_8y1dkw7x235S6xIDnEYBXIxeSAmDq8
Message-ID: <CAFEAcA-jicD=aatno+6Vv4HS4MA+j+rQPrO6wFrUM8fYsF_hVg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] scripts/checkpatch: use new hook for ACPI test
 data check
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 15 May 2025 at 14:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The ACPI test data check needs to analyse a list of all files in a
> commit, so can use the new hook for processing the file list.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 61 ++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 32 deletions(-)



> @@ -1770,9 +1769,7 @@ sub process {
>                      $line =3D~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>                      ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\=
-]*)\s*\}/ &&
>                       (defined($1) || defined($2)))) &&
> -                      !(($realfile ne '') &&
> -                        defined($acpi_testexpected) &&
> -                        ($realfile eq $acpi_testexpected))) {
> +                   $realfile !~ m#^tests/data/acpi/#) {

Is the indentation off on this line?

>                         $reported_maintainer_file =3D 1;
>                         WARN("added, moved or deleted file(s), does MAINT=
AINERS need updating?\n" . $herecurr);
>                 }
> --

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

