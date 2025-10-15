Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B09CCD184
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8raJ-0001r9-4v; Tue, 14 Oct 2025 22:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8ra8-0001qY-UI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:49:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8ra2-0006LH-Su
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:49:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63163a6556bso11937661a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760496565; x=1761101365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6qjZYlED9cI5ZqDFGB24BCtY1bwwgj+Qp3FAx8995M=;
 b=GS8BBr2cjTBvdO1DaoUBw0hsO98/wLjBCI1UbMNnQgGzZv+sUt7VDovt1wI0SxkIFR
 u27H6I7bS4qYfHoIEScDYbf2xYIfuaSg1GKxlwIS6/usNIukTigf1xGAXxPe7ZYYSjKV
 7LKWjDOHgPTFQobJqLYxHNqgNXXUzj4ClCihul6JDnkN+x6oxxL92EXUjtnE9IftZrXZ
 Wi7XN+BSSnke7gI33fYIA9n91Al55j3AXIL/wfD97pMyttsaFu8bU4l8UNO0I3cCNEBE
 jkruP0Ac+oa/kqEcnJdZyJlupDmLZwChq8tqzhqH6UXFixkHWra9hr5sgP0M/8bgL+Pu
 siYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760496565; x=1761101365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6qjZYlED9cI5ZqDFGB24BCtY1bwwgj+Qp3FAx8995M=;
 b=QxPzNR3dnOeFCTbERwbgYnBmN9pyqx3UI5B5Fkk/1mQL7Q0DzXsWFgpgJ9Wdq7RxmA
 8iQSDxdjjVg6yTIblJg9ELVjTC7FQ5S2XtXbvTOXTMfHgYzXesCtB41swgGQaMpbaTlE
 M1zKmQw1YDwYNG3ny3eJia7zIWCSJQL8Sfr8q2F94xpoWbON5jJzAKqQQ+OyxMPwKK5I
 aDdE1E5wPZ/yirG9fr8HTijoy86o22o+he5b+wGtSmep2bGMLhfwDKP6Z7CLztHQKieK
 7sen3zz9+OW6bbQ4kqSI2iXvdOdFPasuVajWyyLEFMFXA6vMqAznf/6BX7pOLYlAIkjY
 kzTg==
X-Gm-Message-State: AOJu0Yxbed9vRsNg7/jet3ddj/sIP9+a+95vUdgEx+WuOZtcYQjXXH6K
 LklxOmckX+S8p66rXjfj+Gbrw78NEQvD2kgdS3E7Nk8AsEtX9sv0MFWXz5K0SlFMcDsHWO/WzC3
 eH5CHWUUdNV7Wi3ivFLBQAE9qxbSKA3g=
X-Gm-Gg: ASbGncsVRHMzt5c100z8EihVf8CE3JbJbREW6hUvXb6GfW1QDwrbbyFLN8+LqQC9hW5
 OmByvTEkLUesIs1Auz/DdgMGcE6QB470ppdqv6nVPlqKwAWAtCeSBoD/JVXIZoGUN/u1LgFFQqa
 geUtXZgSj4Sg15aK3lQkK5AfcN1NeViABtL0VU8kLVtMA7j4d5KhcKEw+c7V1gGx36nYDlyKD6r
 ENdRyL+XvxYxzCuSIzeSD7R+xyu/wnanXKPuJqVzmPaGA7+2LWYV8FDNnzJC4OtzpeccOLt5/Lg
 vQ==
X-Google-Smtp-Source: AGHT+IHHaTUvHcpDViXjqVRzXZIChBsVG8+g6HvIsqXs0iFGU8jo4cyVPt7J9fyPy0gRtb4fHY1J/0d1mKHNouTFWuw=
X-Received: by 2002:a05:6402:d09:b0:62f:3721:fc8c with SMTP id
 4fb4d7f45d1cf-639d5c7019fmr22465706a12.37.1760496564567; Tue, 14 Oct 2025
 19:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <0e246345-6296-4df2-8f1e-4c8beb9532f0@linaro.org>
In-Reply-To: <0e246345-6296-4df2-8f1e-4c8beb9532f0@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:48:57 +1000
X-Gm-Features: AS18NWAFuRVyghTm2mNAFC5jlzxFOrOYfpqSLYMxn-jYT2ljz4Uj2CJyWxwcDkM
Message-ID: <CAKmqyKPZpUaXd7K6qfu-q4xSmGF-mmPA+p14ROi85KE76aW0RA@mail.gmail.com>
Subject: Re: [PATCH 00/13] target/riscv: Centralize MO_TE uses in a pair of
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Oct 15, 2025 at 5:45=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Alistair,
>
> On 10/10/25 17:50, Philippe Mathieu-Daud=C3=A9 wrote:
> > In preparation of having RISC-V cores changing their endianness
> > at runtime, centralize the MO_TE uses to a pair of methods.
> >
> > Except the 128-bit LD/ST change (first patch), no further
> > functional changes intended.
> >
> > Philippe Mathieu-Daud=C3=A9 (13):
> >    target/riscv: Really use little endianness for 128-bit loads/stores
>
> Are you OK to queue reviewed patches 2-13 (independent of patch #1)?

Yep

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> >    target/riscv: Explode MO_TExx -> MO_TE | MO_xx
> >    target/riscv: Conceal MO_TE within gen_amo()
> >    target/riscv: Conceal MO_TE within gen_inc()
> >    target/riscv: Conceal MO_TE within gen_load() / gen_store()
> >    target/riscv: Conceal MO_TE within gen_load_idx() / gen_store_idx()
> >    target/riscv: Conceal MO_TE within gen_fload_idx() / gen_fstore_idx(=
)
> >    target/riscv: Conceal MO_TE within gen_storepair_tl()
> >    target/riscv: Conceal MO_TE within gen_cmpxchg*()
> >    target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() / gen_sc()
> >    target/riscv: Factor MemOp variable out when MO_TE is set
> >    target/riscv: Introduce mo_endian() helper
> >    target/riscv: Introduce mo_endian_env() helper
> Regards,
> Phil.
>

