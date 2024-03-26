Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD6FC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpCkt-0006Y7-Dq; Tue, 26 Mar 2024 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpCkr-0006XA-Ew
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:46:41 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpCkp-0000e1-NX
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:46:41 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d6ee81bc87so9383401fa.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711482398; x=1712087198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDD3WfJY/9HlHMBatu6zAc9jZ/h4veUfHEkl21PnCXI=;
 b=Hn3WTQt01jbQF0A/ZI1/tEEacy0ePSVhKaib1a1LVkrRBRbK6B2cG92PIruLf1ucLZ
 mJ36QwCJ8rsUGn1DR5+TX/cClTtAfj22BPC4qekKTPSnfj3koOyzjZqzK7Gp/tltZ8r0
 uZJjmaT9Vu1at0MNy3Lx6SZt6dyHao02AQOMgQzt/fpX8t1DBs8VpeGrTlDC7NQzUs9h
 AoaO87Kf/Y1iUWTi6SMr5jUaCy/FpmOdjOJAd2xmcochGwFBY4FGHhquPQosrLip5k5M
 dI0dLhLgijc8+2lBscl+tnwPj4zawKuWnoI/vHjGO3sFv5pN2mO+XDI1tCbeyhav7jtH
 OURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711482398; x=1712087198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDD3WfJY/9HlHMBatu6zAc9jZ/h4veUfHEkl21PnCXI=;
 b=bTwvcyjmxVa+KMOHBcAjr365mB44R8mNGX2CIEx0GCTSDkoy+jFJavFuBcOWArskE9
 L77eU4KQJc22h0ZNoqvLwgl8getl5XIUqzAZ6VxVGSWsPgmvL22cZnYFBk3s2mfq+hhS
 vO7O2EfW7puhdAgKl2NdhsX5ql5gPMocOxww7ZBy/cASh/hWT8MhKxyZvlTG5+8v5CFa
 TcaG0v7kZBpLRfUys/Ryi1iz4q9ciGKTwdnH7zL9oDCwCNNNLkDj82bHPF3iHRZzq7aJ
 yZ2hYnP3FJjWbSrj6vZzbW0dosGPlTTntxDXZ782H+4QCGqIN/uj8dGfhJSrvEZHgntZ
 O02Q==
X-Gm-Message-State: AOJu0Yxga/v9RxggI6ESFHskR+yn6RwuEWR6mw8TrtciBnf4pbNiBRUN
 vLz2ohgcVze3qC743JaCwQ7ekoQxIh3cFzdttxs2V4lE9FvN5mj0tkUteSVbWot0PN9nRVGUYAj
 J5TPfWEUFL5Y+5LxYUGy1gbpBk9D658WWX5snAA==
X-Google-Smtp-Source: AGHT+IEmLGGorcYcLyICoWf4RvojwR+/nc94yT0eGCRcFhkrU0fzpMVG2dpXDQ3efv+uWf5Yc7iO5yAmzRpDiw+/jB0=
X-Received: by 2002:a2e:9044:0:b0:2d4:4b13:3413 with SMTP id
 n4-20020a2e9044000000b002d44b133413mr460680ljg.22.1711482397783; Tue, 26 Mar
 2024 12:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240326154505.8300-1-philmd@linaro.org>
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 19:46:27 +0000
Message-ID: <CAFEAcA_uKn1gBmDnq5o4c_Ht1qA8tAarzBSNs-fCao0QvZYtow@mail.gmail.com>
Subject: Re: [PULL 00/13] Misc HW patches for 2024-03-26
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Tue, 26 Mar 2024 at 15:45, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 096ae430a7b5a704af4cd94dca7200d6cb0699=
91:
>
>   Merge tag 'pull-qapi-2024-03-26' of https://repo.or.cz/qemu/armbru into=
 staging (2024-03-26 09:50:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240326
>
> for you to fetch changes up to ccebb9ae352eea63cb1491cb829e4cd0f7576f1c:
>
>   ui/cocoa: Use NSTrackingInVisibleRect (2024-03-26 14:32:54 +0100)
>
> A pair of "WARNING: line over 80 characters" are ignored (82 chars).
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> [hw]
> - Do not silently overwrite 'io_timeout' property in scsi-generic (Lorenz=
)
> - Propagate period when enabling a clock in stm32l4x5 mux (Arnaud, Phil)
> - Add missing smbios_get_table_legacy() stub (Igor)
> - Append a space in gpa2hva() HMP error message (Yao)
> - Fix compiler warning in 'execlog' plugin (Yao)
>
> [target]
> - i386: Enable page walking from MMIO memory (Gregory, Jonathan)
> - tricore: Use correct string format in cpu_tlb_fill (Phil)
>
> [docs]
> - Fix formatting in amigang.rst (Zoltan)
>
> [ui]
> - Fix cocoa regression in platform fullscreen toggling (Akihiko)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

