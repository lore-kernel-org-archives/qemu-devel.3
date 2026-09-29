Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2061EC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBaGU-00042i-A1; Tue, 29 Sep 2026 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaFr-0003uR-BA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:00:42 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaFp-0002c6-OS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:00:30 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so17782275ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790697628; x=1791302428; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uEsMF6FEe1NyyH3LW5JFoMkxQGNwq5tG40KlfFvxfrQ=;
 b=ghRNm3txOQJZqnCBlxn/V1zuPv3IaWXpANWiJEtWl5PbN4HTGbzhQRY6OpOmh7K4zM
 7Dx0EbVhtAMEJJKSKtsLpY5jqdiRUVsDeAaC8/lhL9P7MMQ9BZs3+xSL539YgxWwYnCn
 7SUR5ObFxKyKddmuaov2B0UsZM0KY0nimvFACAanHFTvxRh25225KhNOAx9jrD5faz+K
 Wb39sc5KebImam8rfjgkbAuP/zwE09t8QLck/XAC99wbmis4vfN2OWc0P1w6S78PrvQX
 aK/u2aWla1P/h+88lhVxX59OLA3Qan673f0MjHKEokemMuq9a19XvvRCSZ4Xns9oPPuC
 hiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697628; x=1791302428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uEsMF6FEe1NyyH3LW5JFoMkxQGNwq5tG40KlfFvxfrQ=;
 b=kqwNxgfJq8I6I5WAi5G8ctaMNPP7AxfkTZbC5oCM561jbYsr0Xa5/2i4RM7RddcRwj
 inv2TPecqhbO6JBFBHL0KfZzbiTqcQ27DbdPU5S7wkq1lvp5mCkD4lfDsTR/bWEf1kQt
 tWwwY5gqKEc9y0PVM35uaw0sQSDEvX1NkZK133GIHV4FpHhlyt9h6CiGqz3tQD/0ecLF
 NOKbjrZ5TQbuucfSxMLfOSaaw6zzweM6KRMwlUveirURJklh08rIp03hoyvCgb+Pgb2a
 VHiS2ttL0HCgHI6Gq2Cpueuth5p+r79vEYpf0ZSXu3cch9nMMg5u7rD6LO1DW7VD24+x
 8hXg==
X-Gm-Message-State: AFq9FYJKKhooRPfiflaIkE6Em8qtG3NW0X/H5EGAaNu7ZzuJOSq/AXcp
 kVjq410sz3a76HZ6ecR+/S6033ypTWKt4SFzQYagcQfm8xV5NRwEnDH80hQxoTatZI4=
X-Gm-Gg: AYBFou30gSQMp2BwMW62P0khkrnNdRHBM3bXq4lrtKOnV8CK1kVgI4SSVijDfzbv+72
 aS4qxX2ujon7XnSxLvUiS7/9xpPd55DxdbqzLjKYesSo/kkZ1eUo+Og3RXXVqD118TiYtG8fSek
 SJ3Cdh9snt7x3i2OfVuOJsWJEOFMv9mVDNw0NOxHqrtpBJ6YRioYw2nz/31W5f2B9KxaA2xFqlX
 dqYLmD7p23UEZAqJjc/fxkAgWzy9FcjXRnPr8o21WIEAuMl0R523OBa7YcRu03uG60Hw65viZ5S
 SOnA1L7d7xBE3bTN1Xa9z1krbRrqeR2mJXpssmh8Tz3awv2F1tlRhE8INLE3RDZI5T9Ha6dtT0a
 PDixNei1O9KyAzAKZCZJlhSSQSLltjraufRWzpVk/DifktZQJDZrBcyadLVF4OxwMLkFaXDKgTI
 WMa13FjM6+rR+bIDSIbBD+bfIVRcoP16+pBj2RpjU2S3DcdBtnY3wDQs0Z81QSpepy7Bkkg1Nv7
 FSoEJXnDo0ErewNvDztDe+X
X-Received: by 2002:a17:903:3848:b0:2df:5a29:ea5f with SMTP id
 d9443c01a7336-2e2ba4028e4mr43398145ad.57.1790697628196; 
 Tue, 29 Sep 2026 09:00:28 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df9146ed7csm58986725ad.80.2026.09.29.09.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:00:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 00:00:24 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 07/11] tcg/riscv64: Return success from encode_jimm
Message-ID: <arvf31AEdoJeVu2s@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-8-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-09-13 14:08, Richard Henderson wrote:
> Centralize the range test for this encoding.
> Directly OR into the insn value.
> Assert success in encode_j.
> Use encode_jimm in tcg_out_call_int.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 46 ++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

