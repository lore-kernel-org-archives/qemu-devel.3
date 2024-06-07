Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED6EC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:24:05 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFb7b-0001TF-UK; Fri, 07 Jun 2024 11:03:15 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFb7a-0001Sv-9i
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:03:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFb7X-0008IB-6f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:03:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a50ac2ca1so2893296a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717772589; x=1718377389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dMb7RN07FQqcaFQUYgecxzhzyNvGM9EE/+F8PyXU6uQ=;
 b=OzqRglnIp5O3qIJ8skaAV4Uf8NMb5AoZXc6yok0HcFhqr58vdazyoySbe9/9DD3l0F
 oPBpqDrUZLKLX/02UGczeli8bBV7bn1ptXFKN+rV8BTNp/FNuuT+xYQAyEH+qa/f5XlK
 xBR2wfPz25xLaj7eGuR5DBgvJhc6jiQJF69B4OPNMI6T8YqVeHZmY5cAlihYxbk5zJ1E
 rU1onmtKS3qM4HxZrKfOM9lNpk+8vd493YB7GCtb7sL7uS29BhLawOtb2az70iZGqDne
 blYaE8oD39vbI6B5FTUq818xri1oIvoIt2hMMlkakcjXADlJG43l7A6LvoM1fLVtMOuP
 /gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717772589; x=1718377389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dMb7RN07FQqcaFQUYgecxzhzyNvGM9EE/+F8PyXU6uQ=;
 b=S/XNM9Chq1uCNyhFwgtX0fEK1wlV7ANS5xdAMUUGRGm/msuoG9Uyn9l3UTbprtCtE/
 KnC9fGcND44RUCmOfY/NyWkRZal4si/irKFVpOTmJG06SlB0l4+6K4dusPrer7vr+giy
 8inui+jre08l60BjqC4PYo0Tzulu7H3glg2tVgqA7PgAhW8b+gT3jL0ETjcnspCpHPbw
 Yydm9CdMC8KnZTOv6ArrQ5ENFkhsoEE3K1PJv1loiXeDVPeqOk5B7fGc3dJjIi1pBMcU
 LChHae/GotkAuXINpJaAU5nuc50kkOitZhThunC79foOOznBPzah2BY4SZ/I1PIZCX7V
 fyqg==
X-Gm-Message-State: AOJu0Yxb5CTWqBLNmu8oXn+gKCwmEDEFNnPa/KJjUonWvL4c6AjH+HET
 HJcnBv4A382yC25kK/bAyvhFHWSVyc9Aw5edAEe4itBBSHusIMPV6ZMthHQSI7lnHEfQuLlJsCU
 oDIU5+iQUM2fM9REHkYmh+cgT44gsXy9Py2xr6w==
X-Google-Smtp-Source: AGHT+IFxP+sHTU2Ivvmp3W4YjTbactG3bjwB32m3lxcUoSlZE1CvzbU3POtkOBAZKIaDDjl4T8VaUob3IlGfWbeY9NU=
X-Received: by 2002:a50:8adc:0:b0:57a:4c22:c0 with SMTP id
 4fb4d7f45d1cf-57c508ec32amr1561427a12.10.1717772588924; 
 Fri, 07 Jun 2024 08:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717403572.git.jeuk20.kim@samsung.com>
 <5c079578d2e46df626d13eeb629c7d761a5c4e44.1717403572.git.jeuk20.kim@samsung.com>
In-Reply-To: <5c079578d2e46df626d13eeb629c7d761a5c4e44.1717403572.git.jeuk20.kim@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 16:02:57 +0100
Message-ID: <CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com>
Subject: Re: [PULL v2 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, fam@euphon.net, 
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com, 
 j-young.choi@samsung.com, minwoo.im@samsung.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 3 Jun 2024 at 09:38, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>
> From: Minwoo Im <minwoo.im@samsung.com>
>
> This patch adds support for MCQ defined in UFSHCI 4.0.  This patch
> utilized the legacy I/O codes as much as possible to support MCQ.
>
> MCQ operation & runtime register is placed at 0x1000 offset of UFSHCI
> register statically with no spare space among four registers (48B):
>
>         UfsMcqSqReg, UfsMcqSqIntReg, UfsMcqCqReg, UfsMcqCqIntReg
>
> The maxinum number of queue is 32 as per spec, and the default
> MAC(Multiple Active Commands) are 32 in the device.
>
> Example:
>         -device ufs,serial=foo,id=ufs0,mcq=true,mcq-maxq=8
>
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Message-Id: <20240528023106.856777-3-minwoo.im@samsung.com>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>

Hi; Coverity reported a potential issue with this code.
I don't think it's an actual bug, but it would be nice to
clean it up and keep Coverity happy. (CID 1546866).

>  static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      UfsHc *u = (UfsHc *)opaque;
> -    uint8_t *ptr = (uint8_t *)&u->reg;
> +    uint8_t *ptr;
>      uint64_t value;
> -
> -    if (addr > sizeof(u->reg) - size) {

Before this change, we checked addr against (sizeof(u->reg) - size).

> +    uint64_t offset;
> +
> +    if (addr < sizeof(u->reg)) {

Now we changed to check it against sizeof(u->reg).
That means Coverity thinks it's possible that we could
have addr = sizeof(u->reg) - 1...

> +        offset = addr;
> +        ptr = (uint8_t *)&u->reg;
> +    } else if (ufs_is_mcq_reg(u, addr)) {
> +        offset = addr - ufs_mcq_reg_addr(u, 0);
> +        ptr = (uint8_t *)&u->mcq_reg;
> +    } else if (ufs_is_mcq_op_reg(u, addr)) {
> +        offset = addr - ufs_mcq_op_reg_addr(u, 0);
> +        ptr = (uint8_t *)&u->mcq_op_reg;
> +    } else {
>          trace_ufs_err_invalid_register_offset(addr);
>          return 0;
>      }
>
> -    value = *(uint32_t *)(ptr + addr);
> +    value = *(uint32_t *)(ptr + offset);

...so Coverity thinks that this write of a 32-bit value
might overrun the end of the array.

>      trace_ufs_mmio_read(addr, value, size);
>      return value;

Side note: why use uint8_t* for the type of "ptr" in these
functions? We know it must be a uint32_t* (it comes either from
the u->reg or from one of these u_mcq_reg or u->mcq_op_reg
fields, and they must all be uint32_t), and using the right
type would reduce the number of casts you need to do.

It also helps the reader a little, because using a uint8_t
implies that you're indexing into an array-of-bytes, and
if you were doing that it would be a bug (because both of
it not handling endianness correctly and because of it
not handling alignment correctly).

>  }
> @@ -423,13 +802,17 @@ static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
>  {
>      UfsHc *u = (UfsHc *)opaque;
>
> -    if (addr > sizeof(u->reg) - size) {
> +    trace_ufs_mmio_write(addr, data, size);
> +
> +    if (addr < sizeof(u->reg)) {

Similarly here we changed the bounds check we were doing.

> +        ufs_write_reg(u, addr, data, size);
> +    } else if (ufs_is_mcq_reg(u, addr)) {
> +        ufs_write_mcq_reg(u, addr - ufs_mcq_reg_addr(u, 0), data, size);
> +    } else if (ufs_is_mcq_op_reg(u, addr)) {
> +        ufs_write_mcq_op_reg(u, addr - ufs_mcq_op_reg_addr(u, 0), data, size);
> +    } else {
>          trace_ufs_err_invalid_register_offset(addr);
> -        return;
>      }
> -
> -    trace_ufs_mmio_write(addr, data, size);
> -    ufs_write_reg(u, addr, data, size);

thanks
-- PMM

