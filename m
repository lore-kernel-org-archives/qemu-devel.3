Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B3AC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzRg-0004Of-8d; Mon, 19 May 2025 08:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzRb-0004O6-1c
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:18:12 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzRV-0004u2-Mb
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:18:10 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70ccf9a4ab3so9811147b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747657083; x=1748261883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcugEXOb1spjfpRz9S9C9/ucAjX1t6xqzJEkWPM6L80=;
 b=l6OEsj7zmd7vM6HEfzjpMLnahM3MJkOEnM3VxyrWrIs+c3W6GHhj/3lz0VvWpAS3ba
 lyTmkBSeDepmk/rOytFH0KjfD5PECVhOw5PM+BKMTyNc4qiD8DoZ43DUshT/mHbcDC4p
 DLzmyis6bESVoqahrg6RmhqVJrreO9UulncFqKHXSecmtxNUc0Y52jKvEG72wBSPUy6U
 xLPoXLjvABJt8KCn/5/aPBQ6mlycx3sYOwLTOcodlgR5nk5kwnzmUYO3TzAk0s32vBqF
 e+ZjerNM4tT11SrgiwHSOv7jQ3BkoDz3UbekkLDOen7rVcociMkvNZ0vXC4GGU6zY8c1
 I9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657083; x=1748261883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcugEXOb1spjfpRz9S9C9/ucAjX1t6xqzJEkWPM6L80=;
 b=MjPZ1+JwLWSTn8Jy7tcLab7WEtMvakWHr8TVTKEnj1KqwyPCNJOUbk5FSTK7FjHdvq
 L27WS4kbLN7Ae7HorpQn2PMimbSDxBknQnf3y7cWTtRItyixqGWfvQeO3C364+DmoM9a
 ppI+dudK1zmNEW16CwoASoKiQ8iOVhknacUA5vfH4cxfRQYPMLS4EgmFEajuqQXi9WfF
 dbxT80unstIdjNfyRg/ehcCdATiv/YwSUsrksOfU9ErMybRt6pU7NNzPwVgdwGsvP6gv
 VoaFsa0V3440utqIhDLftUStBIO6Z9iUqAvf0YJhKBOTTjQjwkY0bM4KvvVqGrmYHxuY
 eSNw==
X-Gm-Message-State: AOJu0YxoUhC6nJkX1tS9rEjv5pZOqcXRLgpcp4Qjb3NvJZoDY6lGm8YX
 aLT6XvA3CEoZLWOhLooFrAOaoxqzvpYvrMsUSSk/XoyOgSRsjOxfBk0aH73wzvHDMdQYsruW8b7
 XLj+73QUmtQ3pl3C7/6JLVupl0M/ene7iBbMILWqdOQ==
X-Gm-Gg: ASbGncsBUzGPNRMwIZsXod3MOd6Jwu0pKLcmBAb7qc1tdsELs5SLv6ZouMXVS/O34Se
 TaVhnnbzHSspQXRAUbYYXm2YGleUIWo2fPDgB6ooAC2a1q2lF9yjP9/D/FlODsFrz9nrQFJUUE3
 fNhac/f5cQLxNkYNJ6fZPJ5QLhQBJOnCUykQ==
X-Google-Smtp-Source: AGHT+IF0KfaYvCRXT01kfBIMFditagIIFwxXMwd5G/K5WwieuCyTf5B9Obp0wH47Ak44qpg8ZptoS99pwqi4E7lK//w=
X-Received: by 2002:a05:690c:4c11:b0:706:ca86:d79e with SMTP id
 00721157ae682-70caafcfcc7mr169685847b3.19.1747657083130; Mon, 19 May 2025
 05:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-4-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-4-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:17:51 +0100
X-Gm-Features: AX0GCFtNasbikXasWn27olaxvp_tS0tS50oP2nPauHEvbT0UaCw5bpPxzl_cTdI
Message-ID: <CAFEAcA8yRg02JNj4YaRbYbwwHAukm90k35M+uOQ8aw+7CQ2FVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] scripts/checkpatch: introduce tracking of file
 start/end
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Some checks want to be performed either at the start of a new file
> within a patch, or at the end. This is complicated by the fact that
> the information relevant to the check may be spread across multiple
> lines. It is further complicated by a need to support both git and
> non-git diffs, and special handling for renames where there might
> not be any patch hunks.
>
> To handle this more sanely, introduce explicit tracking of file
> start/end, taking account of git metadata, and calling a hook
> function at each transition.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 109 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 106 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7675418b0b..b74391e63a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1417,6 +1417,38 @@ sub checkspdx {
>      }
>  }
>
> +# All three of the methods below take a 'file info' record
> +# which is a hash ref containing
> +#
> +#  'isgit': is this from an enhanced git diff or plain diff
> +#  'linestart': line number of start of file diff
> +#  'lineend': line number of end of file diff
> +#  'filenew': the new filename
> +#  'fileold': the old filename (same as 'new filename' except
> +#             for renames in git diffs)
> +#  'action': one of 'modified' (always) or 'new' or 'deleted' or
> +#            'renamed' (git diffs only)
> +#  'mode': file mode for new/deleted files (git diffs only)
> +#  'similarity': file similarity when renamed (git diffs only)
> +#  'facts': hash ref for storing any metadata related to checks


> +                       $fileinfo =3D {
> +                               "isgit" =3D> 1,
> +                               "githeader" =3D> 1,
> +                               "linestart" =3D> $here,
> +                               "lineend" =3D> 0,
> +                               "fileold" =3D> $fileold,
> +                               "filenew" =3D> $filenew,
> +                               "action" =3D> "modified",
> +                               "mode" =3D> 0,
> +                               "similarity" =3D> 0,
> +                               "facts" =3D> {},
> +                       };

The 'githeader' field here should be documented in the
comment block above.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

