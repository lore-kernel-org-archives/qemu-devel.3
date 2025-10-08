Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NBm-0008Op-8L; Wed, 08 Oct 2025 01:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6NBk-0008OB-Gr
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:58:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6NBi-00006u-Ri
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:58:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6399706fd3cso5724192a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903088; x=1760507888; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jhy/DBu18l9W0KU0J2WfawTflYpedUTU41RUKZFJFzo=;
 b=GspCc8QjogoOhllGwHloaC4BhULHSWc0E2145Rk9O5n6/Wprc/RtcZeekp9NAsKjBw
 IOJuwRLRICtbv50XtVOvgzC7mJI1xrOBtR6bQoK3iCOS2xDTU79eHJ90tY1GK/QP0J3v
 bBF0HCLV0124Oz+6gvl1cVi4gLx4ZQrxhTkC3DzE85HnU3Vx9YUpVtqga2wuipeFkltA
 0S3pthB07bVJxpn1XqMBOJtF909ob7g7n8kbKaBOXzUpgFh/wD+/TwlBjFHsp4HAxx1M
 2fJNBO9GA+cSElyRnSCktibDPcHb1kR0j0e7biF/mHSwEmDx7EsBNpwiA6o8Q8o1ntjE
 BpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903088; x=1760507888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jhy/DBu18l9W0KU0J2WfawTflYpedUTU41RUKZFJFzo=;
 b=ANGEGwT5mdNu754h06a8iGW5ZfDoj45nFxTp4+0e420K+IZ61LMjIbeQfka4uGZbqd
 1VCTDpctm44ir3YgWDX3OQCarVSBwys68qBoOlXCMas+R67jusu36zsXh0E2l16FY6pS
 5EXVXi+ctwdeK4oF5WTQ/lYF87GxGgGVAzVyQJnzdxdudXI4J25YMch7bcvErCTnaczu
 xrT7gFU2C4AnHDIb990+aXS8u7Nl0JVswaCpcyPTOmvyxfPLZ4nE6RtA/OxQRlOR1yoQ
 AdA2P0fIWEP6VCf+nL/hAnTnaRCCj/w62ssoO71PaBVsQVY9CU6K0o0hPFXK1t/CfVwa
 Q7zw==
X-Gm-Message-State: AOJu0YxbnHeet3f5SJgMhC45kaR+kPtnW2we/UIcYia4leIOvj7sHegv
 7xWhdzXnQT5PW5PPlPuwBEl6b0etNWR9JgssvbTWHlO93XRH3UgR5W4++8PhHCkqbl0bej8AAVB
 bEvXHZRkSqXpRatBh01CX/KTH440WzfiDHmEzUqlx9g==
X-Gm-Gg: ASbGncvOcv2pG1y0Nq8k6/20GgkBxYzV4p1/qKlYg10NeI318IztJe1pjIKE5IzmL+k
 Z80jsh617+7ltvKc8WuDr2/aiZkv4Vptb6csCvWdAZNcStl/H4Q/QT46Hph/zIy44ZRpbBTnn1d
 rzsU+VLMHxJDfG/hgySy8485fluW4f1QlGSTpFEuAroVtpFrZMY9b6YRJOsGOXw56J0k58yWQwU
 dAUD0nr3n8nYb/Uci7gR4Xpj9+sdUVnWuKCOr6ysyBN9CI=
X-Google-Smtp-Source: AGHT+IFRVkqi04OC7CSLfpbjBpYgwM4LKBNfgUNbgyA+BLz4uYIT6Dgyoe01LS0hek5KzIAyhoJoGPc/ERaLO0z4Zw4=
X-Received: by 2002:a05:6402:27cc:b0:636:9129:882f with SMTP id
 4fb4d7f45d1cf-639d5c5ba09mr1647185a12.30.1759903088329; Tue, 07 Oct 2025
 22:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251007194427.118871-1-stefanha@redhat.com>
In-Reply-To: <20251007194427.118871-1-stefanha@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 8 Oct 2025 08:57:42 +0300
X-Gm-Features: AS18NWDwtYIGx9-r6OW3FHUCd4epsH2aA87-OEvKl1mxsOS0FmfeqaIPo_LcQss
Message-ID: <CAAjaMXbP+LQxNTJ038cukJnaUcv+_U=-AY8JyHMVeSVnNsxG7A@mail.gmail.com>
Subject: Re: [PATCH] rust: fix path to rust_root_crate.sh
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 7, 2025 at 10:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Generated Rust root crate source files contain the wrong path to the
> rust_root_crate.sh script.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  scripts/rust/rust_root_crate.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/rust/rust_root_crate.sh b/scripts/rust/rust_root_cra=
te.sh
> index 975bddf7f1..f05b8d0210 100755
> --- a/scripts/rust/rust_root_crate.sh
> +++ b/scripts/rust/rust_root_crate.sh
> @@ -4,7 +4,7 @@ set -eu
>
>  cat <<EOF
>  // @generated
> -// This file is autogenerated by scripts/rust_root_crate.sh
> +// This file is autogenerated by scripts/rust/rust_root_crate.sh
>
>  EOF
>
> --
> 2.51.0
>

