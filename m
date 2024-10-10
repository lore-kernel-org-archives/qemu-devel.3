Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C72CF11C8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvc5-00016z-OR; Thu, 10 Oct 2024 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syvbw-0000zB-Ed
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:01:59 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syvbt-00027d-Pe
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:01:55 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5398e33155fso1376841e87.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728576111; x=1729180911; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MnR/sBvrXv04CJNl4kKHysTRoA7mZ3Osim7fZIzOSek=;
 b=kYpQdanXgvt1fo+1JME4lCq7GA6osCpnbsRpfcu9MBPmUSCuo5YfrVNO0SckfiU5Yq
 swoI4MlY4Bzkq/HvTHWXqLgaTmQTOMB6eP406fVhJbBUsqn+tCHUcJ7eOhtd3InxzV8J
 17dpwG3d+maSDxeY03ncHSTIR6bI/mJTHnk0ekPoSMHYYUWFJ/+iu2Ft966hkKVpPDwV
 K665BOqZGOcZlzdvmcrwl8z/JdXwTvQxLv9fjCcUKeSP0Js3vUR8g0DOfwXSePK29Bqb
 Q9aK0UwRmE/yZSeiNFHyeAyELrSrnXbugrKUmpzFf2f9cWLPXayV2eLq0qCb0fMvkCiq
 UL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728576111; x=1729180911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MnR/sBvrXv04CJNl4kKHysTRoA7mZ3Osim7fZIzOSek=;
 b=r7Fw1xkmJ30VuV/KHW6NJC07PkMC8aSDW3cQEXZknr4lSUCvsTa4Fvje4GNr73i+jy
 TJaaINcmUbvfHhMwy/rEVQPwxeF8P7IiXCyvgm8tEfyb2lLR2mRvINVOKa3wqoxem5qF
 bweJtx+659MhFu72N1SGZDDcOP7wy6jU/MY9ChdwuifBt3IyqT1j2Q9Y4ycr4+yvHEVR
 PncLG+W8crgC5cOeTn/yj7JZRQdXnFGG+Npi6cPeOszcILn2W4Y2wjkzmN7PJiiVM3Eh
 1NM23OjQ8mJcm2DYXKRdNsw3JK7bD0MbgURREqjK7PAKiD1ruqSDVjxKtsoIrDjYQSi9
 wF8g==
X-Gm-Message-State: AOJu0YxZ/S5ps2DnLHdM379NGoGTwxPyG4T2XFQ6VznsaAR7wrAH4on4
 n0d+FGeEFcp5ny3Hd2DUNA1Wjh2ix4vUhBL/j18avfpURoA0Ws3jUw8KbpsTIBargbp8lbYx/uj
 U21XW/R5miXZ8jW3GIP3iOqNhU9kTemSSsyDMujhqvK2L2iBW
X-Google-Smtp-Source: AGHT+IG56QYKu0rd3137BcMDQwEPlH6yn2p3uvdoh1B5SJOkVtlCs7UB6qQ1fHT0mbt2pgxkNKIi91c9mzjW4B21fPs=
X-Received: by 2002:a05:6512:104d:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-539c495877cmr4867708e87.45.1728576110077; Thu, 10 Oct 2024
 09:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241010150652.1814677-1-pbonzini@redhat.com>
In-Reply-To: <20241010150652.1814677-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 17:01:38 +0100
Message-ID: <CAFEAcA_R_vwPYs=1VUZzDnqxijM59Mg+frc7tp-D3W5McFJ77Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/archive-source: find directory name for
 subprojects
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Thu, 10 Oct 2024 at 16:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Rust subprojects have the semantic version (followed by -rs) in the subproject
> name, but the full version (without -rs) is used by crates.io for the root
> directory of the tarball.  Teach scripts/archive-source.sh to look for the
> root directory name in wrap files.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/archive-source.sh | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 65af8063e4b..7c7727eab58 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -48,13 +48,33 @@ function tree_ish() {
>      echo "$retval"
>  }
>
> +function subproject_dir() {

"function" here is unnecessary and a bashism, but I guess that's
the way the rest of the script is written.

> +    if test -f subprojects/$1.wrap; then

We should quote $1

> +      # Print the directory key of the wrap file, defaulting to the subproject name

Probably worth commenting here what the format of the wrap
file is (i.e. that it is a toml file and we are looking for
the "directory" key in a [wrap-something] section).

> +      local dir=$(sed \

https://www.shellcheck.net/wiki/SC2155
says we should write this
         local dir
         dir = "$(sed .... \
                ... \
                subprojects/"$1".wrap)"

to avoid losing the exit status of sed.

> +        -ne '/^\[wrap-[a-z][a-z]*\]$/!b' \
> +        -e ':label' \
> +        -e 'n' \
> +        -e 's/^directory *= *//p' \
> +        -e 'tquit' \
> +        -e '/^\[$/!blabel' \
> +        -e ':quit' \
> +        -e 'q' \
> +        subprojects/$1.wrap)

You could also write this

      local dir="$(sed -ne \
        '/^\[wrap-[a-z][a-z]*\]$/,/^\[/s/^directory *= *//p' \
        subprojects/"$1".wrap)"

i.e. use a sed address-range to say "operate only on
lines between [wrap-foo] and the next line starting '[',
and within that range print out the value of the directory
key". Definitely shorter. Is it more readable? IDK.
Behaviour in corner cases (multiple [wrap-foo] sections,
multiple 'directory' key lines) is different, but none of
our wrap files have those weirdnesses and I don't think
they're valid wrapfile syntax anyway.

> +      echo "${dir-$1}"

I think you want "${dir:-$1}" here, so that we get the
argument both if 'dir' is unset and if it is the
empty string. Otherwise (at least in my local testing)
you get the wrong thing for passing it 'keycodemapdb' or
other wrapfiles with no directory= key.

> +    else
> +      echo "error: scripts/archive-source.sh should only process wrap subprojects" 2>&1
> +      exit 1
> +    fi

Personally I think
     if test ! -f subprojects/"$1".wrap; then
        echo "error: ..."
        exit
     fi
     # normal handling here

is a bit more readable than deferring the error-exit to
the end of the function.

> +}
> +
>  git archive --format tar "$(tree_ish)" > "$tar_file"
>  test $? -ne 0 && error "failed to archive qemu"
>
>  for sp in $subprojects; do
>      meson subprojects download $sp
>      test $? -ne 0 && error "failed to download subproject $sp"
> -    tar --append --file "$tar_file" --exclude=.git subprojects/$sp
> +    tar --append --file "$tar_file" --exclude=.git subprojects/$(subproject_dir $sp)

We should quote: subprojects/"$(subproject_dir "$sp")"

>      test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
>  done
>  exit 0
> --
> 2.46.2

thanks
-- PMM

