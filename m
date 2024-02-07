Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFC1C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXnBh-00062C-Jd; Wed, 07 Feb 2024 14:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXnBZ-0005zT-RM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:02:19 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXnBY-0007wy-57
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:02:17 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5602500d1a6so1192631a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707332532; x=1707937332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0e1Ozh26siZnoU9VGZDH09QR1A+Fe636EHreHEpzeE=;
 b=E/x4bcqg2X7ngOvqK5teumjg+DhZdSZg34Zc0+Oc0EbTSNGN6E8gVLRLRTeMgX2Et4
 tsMaFV/AhN7CKXG+5wlHDzkthxuDOCyLbMkmJQsyvZ7CRJGbaV6J2V3d5KzTodMWqUlX
 r8lxm5xcm1jOEfzRmTBl5WNoiV1212hrpcdnC/LGshivNIOdpnoNw5GiktWkgP0Z0TVs
 y11myZfYUhjQP7iOtof28InSe2/cLtvZerS6LMwJOjneEXR3nui670szXCeECFTYpvnh
 51bPux/PLvi0dZArSPdzPXtO/EROkWr1IhWUlkO4SHfI+SpAjmretvdqJTg/spAamhjq
 JtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707332532; x=1707937332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0e1Ozh26siZnoU9VGZDH09QR1A+Fe636EHreHEpzeE=;
 b=eY/1K6zu/GR9KQPHrMJFu8YKK7J4BVR+SQvANuFqfty1NWxNMUBwFTpSaOvsBSfljs
 R1B76UGMwLJR6UfT9nozalzBBagc/JEhP9gZGYc94ub/MsV8/Ddbw6aA6+t4lHS/P4G+
 OmEGUWx0f4PcT510z+OOh9K8hCwi7Vi4igjFQNoasjuyhtWgywZk0O7xkJsWopeZ5SCc
 d0F8gFXZfaMdYLuGQ3CVGDVveyxJ221oiIYLQtELvVHpqlzht6eOSXcOCYaYDy/vIATR
 a9z1S9OKo+5jfc3dLY1qTa8i4toH5QBmf+ThAQWHmStzrLEwICvw7Yqey3+9Rhm0BKXY
 lqRw==
X-Gm-Message-State: AOJu0YyFah0sOv2L0oesv7BV4MMKmRMaXDeIClWEgOPQ/AkZqF6aHpuo
 nWq7SzbanbokXx8B1dMAiWe9gevKv6iTOpfeCaUDeS4EW5QAMNS54nR3QcHFUy60KwZOWeaFNj4
 UiM6YRMnN6D/I4f0oFkrUrcIHSYgzig+GmAs23asXsWxnY8VZ
X-Google-Smtp-Source: AGHT+IEh3dpjJO6GPfLobwFhQdqVHZyMs0FaPIB/7ZpXgRUtMcoPUOr6ZmWUJeBoQTCX9D1o2lInVZIglgcUjHoSmk0=
X-Received: by 2002:aa7:df95:0:b0:55f:39d3:6d5e with SMTP id
 b21-20020aa7df95000000b0055f39d36d5emr4919741edy.39.1707332531715; Wed, 07
 Feb 2024 11:02:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1707328606.git.mjt@tls.msk.ru>
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 7 Feb 2024 21:01:55 +0200
Message-ID: <CAAjaMXaF3z4DriMzy+isdBZHOj4dWe-B2U0UFy2Kjk=8zwGbgA@mail.gmail.com>
Subject: Re: [RFC/INCOMPLETE PATCH 0/8] Attempt to make qemu-img options
 consistent and --help working
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hello Michael,

Such changes are long overdue. However given the complexity of
commands and arguments, maybe it'd be a good idea to write a code
generator for the command line interface, This way you could also
generate --help outputs, manpages, shell completions just from the
command line spec we'd use to generate the argv parsing routines.


On Wed, 7 Feb 2024 at 19:58, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> This is an incomplete first attempt only, there's a lot left to do.
>
> All the options in qemu-img is a complete mess, - no, inconsistent or
> incomplete syntax in documentation, many undocumented options, option
> names are used inconsistently and differently for different commands,
> no long options exists for many short options, --help output is a huge
> mess by its own, and the way how it all is generated is another story.
> docs/tools/qemu-img.rst with qemu-img-opts.hx is yet another.
>
> I hoped to fix just an option or two, but it ended up in a large task,
> and I need some help and discussion, hence the RFC.
>
> The idea is:
>
>  - create more or less consistent set of options between different
>    subcommands
>  - provide long options which can be used without figuring out which
>    -T/-t, -f|-F|-O etc to use for which of the two images given
>  - have qemu-img --help provide just a list of subcommands
>  - have qemu-img COMMAND --help to describe just this subcommand
>  - get rid of qemu-img-opts.hx, instead finish documentation in
>    qemu-img.rst based on the actual options implemented in
>    qemu-img.c.
>
> I started converting subcommands one by one, providing long options
> and --help output.  And immediately faced some questions which needs
> wider discussion.
>
>  o We have --image-opts and --target-image-opts.  Do we really need both?
>    In my view, --image-opts should be sort of global, turning *all*
>    filenames on this command line into complete image specifications,
>    there's no need to have separate image-opts and --target-image-opts.
>    Don't know what to do wrt compatibility though.  It shouldn't be made
>    this way from the beginning.  As a possible solution, introduce a new
>    option and deprecate current set.
>
>  o For conversion (convert, dd, etc), we've source and destination,
>    so it's easy to distinguish using long options, like --source-format
>    --target-cache etc (-t/-T -f/-F is a mess here already).  What to
>    do with compare? --format1 --format2 is ugly, maybe --a-format and
>    --b-format?  Maybe we can get off with --source (a) and --target (b)
>    instead of filename1 & filename2?
>    (--cache in this context is global for both).
>
>  o qemu-img convert.  It's the most messy one, and it is not really
>    documented (nor in qemu-img.rst , eg there's nothing in there about
>    FILENAME2, -B is difficult to understand, etc).
>    At the very least, I'd say the options should be
>     --source-format, --source-cache etc
>     --target-format, --target-options
>     --target-image-opts - this shold go IMHO
>
>  o check and commit - inconsistent cache flags?
>    In convert, cache is backwards (source/target)?
>
> At first, I tried to have more or less common option descriptions,
> using various parameters, variables or #defines, but in different
> commands the same options has slightly different wording, and in
> some option names are different, so it looks like it's best to
> have complete text in each subcommand.
>
>
> Michael Tokarev (8):
>   qemu-img: pass current cmdname into command handlers
>   qemu-img: refresh options/--help for "create" subcommand
>   qemu-img: factor out parse_output_format() and use it in the code
>    (this one has been sent in a separate patch, here it is just for completness)
>   qemu-img: refresh options/--help for "check" command
>   qemu-img: simplify --repair error message
>   qemu-img: refresh options/--help for "commit" command
>   qemu-img: refresh options/--help for "compare" command
>   qemu-img: refresh options/--help for "convert" command
>
>  qemu-img.c | 352 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 226 insertions(+), 126 deletions(-)
>
> --
> 2.39.2
>
>


-- 
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

