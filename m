Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56CFC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 17:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcTBs-0007LF-Bw; Mon, 27 Jan 2025 12:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcTBn-0007KC-AV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 12:46:24 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcTBk-0007H4-Mb
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 12:46:23 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e479e529ebcso6115430276.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737999978; x=1738604778; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7KuWQeQiyQZs8vKz+HO7IJDBNknrbKCj4huQPcEDTw=;
 b=gj/wxJlbwtoBkrI1kIBa5fBDeejJaJwBQoNcBroc3YzgovkjgA5KrB5G7715jZoxSP
 oLdrclEujOB2Mp9WRZa6bub6NRtau7zqYMAiISfTThx3YxbujK31wH5xw/as2V9E/dnK
 1P4zROTupNru/Gvq1MCIhMY8QANVIpO8d7hvYgd89Q04En0F/mjd6gr12b7ZDI6pBs8W
 wYvTQuKoUhRLAD7F/AeNvojWCSRvATQY2RlKLx9pW2yAGA44jzoGpKw1POt2iYQrRd2W
 Sshm4qYxVlEicATInsQRBuI1Xu9dDoi+pULCIJl3i5EE6BMomhCGGzsViDDkf1SJHzPx
 SEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737999978; x=1738604778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7KuWQeQiyQZs8vKz+HO7IJDBNknrbKCj4huQPcEDTw=;
 b=uD38HGqISiXthmZdCbz/cH7jOhaZOl3uoEXCrIig7kK6j9NA4l+fs75XXGlkIdyi/1
 xXklG8iXge57uMeCCDTTLC1eGWZCr4Y6tt1P+zMMilw91SioxhIPy5y28+7nuHqHeviE
 r+d6roWeU2XHbMBfHw2VJ3RWoIA80nznxtlx6+ShafEYPE57t/F5ucn3vPaPkz+JOupY
 +rlhRjUXixkt/FJnlUR2R4dfpBI34+ylkOafM5y5jDeCMlJgOB0HHvFnFiDrtXL3hH2p
 Hotdo7G5hpET5BBb/2SpMOasHyg1aOAvsjjiBrKgkJgNQca7r6UvL9B/0NhLnUK4hF3W
 UNeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkDlEo0GrA6Aoth+l/abM/Cn4DJXnWhqEYNdv+vr48xzUlVa57v+cHdfkK84CSKA7JkqFel75An+d6@nongnu.org
X-Gm-Message-State: AOJu0Yyp5KvDhbvEC09YIRFfT7Rj6w0Vb31nteOc5cAy+FE0WNagcNG2
 sL4Xqx8KAuuaqQxVhvOMug3c1/9wr6GtYOmwoHe5CCBOX5by2ChYOzmULyYBsReSD3zT3pTSvpT
 paLf4GYp4J8FJq7b1VGRD1/1ZdCclZpnqspySOA==
X-Gm-Gg: ASbGnctiW8QkyIv8Mkq6tmJDRUKQvgZrxJ0OT5d57jjHPWlL2hX8Mr6z94LeTup8AdO
 QpUDTEOsrAB380rvB6SuoV8yfWoF3iGoFwLY+y7RUmKup8rMsUyelNDO4sApmjHg=
X-Google-Smtp-Source: AGHT+IGKpf3d00JtxArcGcZFBu5UVDjKIst54jiNDDBlxlfqB8nRBIRS7kQZdYg/PHGRBUM3SArt6Y9MQmLn9bh8zrw=
X-Received: by 2002:a05:6902:15ca:b0:e58:dbf:ed09 with SMTP id
 3f1490d57ef6-e580dbfeff2mr19792783276.3.1737999977918; Mon, 27 Jan 2025
 09:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
 <44f75f64-4480-4cd2-a907-cf0638568e55@linaro.org>
In-Reply-To: <44f75f64-4480-4cd2-a907-cf0638568e55@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 17:46:06 +0000
X-Gm-Features: AWEUYZm8sMG5unPcPpbt3OKYYOFqyQez0DHE4xsldHB5reLwWiyQNNtCODjhQoY
Message-ID: <CAFEAcA_BF_b8r8cOJVsk13qEQZg0BS5F16s9M6NFLQVHZBfq4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Deprecate iwMMXt emulation and associated
 CPUs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 27 Jan 2025 at 17:27, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> On 27/1/25 12:27, Peter Maydell wrote:
> > We have one test case in check-tcg which purports to be checking
> > iwMMXt. In fact it is doing no such thing: it runs the test without
> > selecting an iwMMXt CPU, which means the iwMMXt insns are interpreted
> > as FPA11 insns by the linux-user emulate_arm_fpa11() code. So the test
> > prints garbage and then succeeds anyway.
>
> Uh...

It had me confused for a while, because I'd convinced myself
by code inspection that we only enabled iwMMXt if you
manually asked for a pxa2xx CPU and not in the default 'max'
CPU, and then I found this test case that we were running
with the default CPU type and which was apparently passing :-)

-- PMM

