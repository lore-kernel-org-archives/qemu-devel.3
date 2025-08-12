Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5474ECA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 23:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulyaE-0004i6-CQ; Tue, 12 Aug 2025 19:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulyaB-0004eV-RB
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:39:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulya5-0007mt-9r
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:39:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61571192c3aso7141503a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755041935; x=1755646735; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGVJuOdGi3lf9ncLyJNgP9sm6StYfYbLwyEqG7mTAPg=;
 b=K1jxHIEENBfvDfa3Dv2nYQ1taMfmBHRXS2T6k+9tJDH+vzl2Mzy7cTRVZa8yB8LngT
 KDjL/vTwC9KyqObZ3sA9elb0ly16O5ZG8CNklIjhx8fdgiIDy/ccFXTcJlzYkoZsZ9Cr
 geIGgTpKOz/vbcxnfi98TmaAwracUyVL5fs3i5opWGuo3ExqFJzSnnttrrM/lmVlbivz
 xdVvppJAxOwj87ERVq5mG5XjxXiwB2kB147wO+1vCbUH19mL4dG5oqDpI+C58znNHgjj
 pnyu9H4dIZIyS1F2AETan9QPIT0jtwXUCg8cJl58AJXgHepK1BOCTnBcRDe8g1aYOmfx
 49zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755041935; x=1755646735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGVJuOdGi3lf9ncLyJNgP9sm6StYfYbLwyEqG7mTAPg=;
 b=qcXvOgChwt4QJmrJn6IczfpBcNxP1YIJHi4gluAsvzwHZP4lzdEoheJg24CzyzUwwY
 KxvSNRWj8bc/90eibHyldCbNLlKUGo/RC47dl7Qbh62GMLcLq6gum86v/KrPIg8H18N5
 oPOJwAypSCcBUKY/M6UCl4S3Ymq3KFgwDcmfj2zsh0fWKJwAPP1yDul1KY0oMPwfIsNC
 oTVmnM68OVu5Yzb0+UEk6xbmQ1ugoc6z63MeTUAG3y87HTP6MLfepcMUaJW4rWmKGzA9
 FtS2L6seXKewNsd+lvrwLbtwOK8cLUBN4OFHVZR2+9euaAbv8AR0lROuofSVmb73gBsV
 42wQ==
X-Gm-Message-State: AOJu0YyaHnfRj2DqV7kbidXV4iroWjXKjgsiQIPJqlNZ8caaq/ZRgIpA
 3uJg/sdlPyUF5S1t97guMYrYJFPCLgM/Mc2f8XwZInz+MBX7m4Xp9ady3Xu4IDo36MqEYognQ/S
 UGNse+AtHdksi8Zu6YxXUA0H5mseGGnY=
X-Gm-Gg: ASbGnctsqUulbao48N0cJKdtE6NFAfZJxBmvYEfGh8o1NawKRK0tElzPzKg+Dw51KZk
 n5Sx1rsVaSJWDelscY5tV5tb8ZQIKUTlvvWygi+ByYHm8yswNxFlDPM3kk8ME4VWgJpZJLDKiPV
 Nqp2IIdLt4uK4McBaTcqp3tou4NhCWfAhRDkQeAC8mjloU6bLORTFNft4t5JIAqq6tbmft+3MC2
 4xyFQ==
X-Google-Smtp-Source: AGHT+IFHtpaxAcJpCY0ka1+Yn4MRe+5wTHd/ODrusQqGSMQpAzEStgorCCf7YUD/buov4UfP4lmArcfRlSgBoSR0YTU=
X-Received: by 2002:a50:d78e:0:b0:618:5fad:4e14 with SMTP id
 4fb4d7f45d1cf-6186bfe1536mr487771a12.27.1755041934494; Tue, 12 Aug 2025
 16:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250804162959.330060-1-alex.bennee@linaro.org>
In-Reply-To: <20250804162959.330060-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Aug 2025 19:38:41 -0400
X-Gm-Features: Ac12FXxr5cm_Fw14AQhUGzjzvUHzx5cupDgwHLU0rhGFGGdk4iueanL6ZlSgTYY
Message-ID: <CAJSP0QWiidjNpGpPi0UKYjesYzKeS=VRxxXRcHOA2S7oysVdyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] readthedocs: don't build extra formats
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 4, 2025 at 2:29=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> We don't build the PDFs ourselves for the hosted docs and it looks
> like rtd can't manage building PDFs now they have gone over a certain
> size. Disable the extra formats so we can at least have the online
> stuff again.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .readthedocs.yml | 2 --
>  1 file changed, 2 deletions(-)

Applied for QEMU v10.1.0-rc3. Thanks!

Stefan

>
> diff --git a/.readthedocs.yml b/.readthedocs.yml
> index 0b262469ce6..639f628612c 100644
> --- a/.readthedocs.yml
> +++ b/.readthedocs.yml
> @@ -21,5 +21,3 @@ python:
>    install:
>      - requirements: docs/requirements.txt
>
> -# We want all the document formats
> -formats: all
> --
> 2.47.2
>
>

