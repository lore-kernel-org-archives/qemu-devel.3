Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD190C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKtR-0000Yf-N7; Tue, 06 Aug 2024 10:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbKtP-0000X2-JH
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:10:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbKtM-0003K9-TC
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:10:27 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so87269766b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722953422; x=1723558222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+iuLrjv1EYTavwai+E1U92Gf2MOmaphr+yKTvDMCsI=;
 b=eAkCww80b0Y1fYD8tqDUo1Sdk2bapdv/B1NdXcEt3WXQknA+SSLd0gJeGtA0fsYv8s
 UUMaQiak54eVZFK6+fEzCpirbVRDeS5zojdGt9G8H2RuqDPb5mTltWSC0Vyom9/lmWnN
 2BbwjDJGmC/Fmn562Kq6kGXTDk9DHDiByOXi1KsZCACXeACJb+4O7zgIKfAEavjrWpWC
 oV6ovcnPcXWuVop1eEFwxO7cmUakMR59BfZcMos1wH6+h9C/rt/qOkqSvQ1suD83tsNe
 gw8p5PxahsEodpcd4LOyZ5aD8uE+fhT0wjm8mTR2/nGl+aaQX3Vog0XyY/pk0zUqwZso
 ScjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953422; x=1723558222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r+iuLrjv1EYTavwai+E1U92Gf2MOmaphr+yKTvDMCsI=;
 b=Vjh6fm7GaV4TKpansZApw02NeX3x6QMNXV0SbF0Sbk5U+y6eK6zUwmhoL2h37IkRKC
 jnQXGpsJ2AysJh8OsVh20L50uboLZvrwz1rXhifxEx9HigS0TLrxc6eX4bjgqbR75HXe
 Dk2BvYQ7Cxy2KRtcdbxhifJScSnB0MkyLhb5tGxuJY7NEb0+UkS+8sYzbZUnMrwdjqhn
 12bk7bRwDrDJ8k7ajmxM6l1u67LxG2KfgngkDlMyuv62pmO5xB/5MWCbL6T5JbnaNL9p
 Jz8Dd4rrXdBCvW88Y+bhr0RBboQZEOZgho1kFEjQSizIuoDRS/qhRU4oPUb91Zxvv6DY
 mOxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn5u7xChwtucSAs27CVq/RpbgE7lgIen3ccl9Kwcjz8Uh1Txedd+0fJAgxGz7GhOwpPvMSc78k+6JF8PRlxrn9JXQU9ws=
X-Gm-Message-State: AOJu0Yxn0cAtd52PxGRhTtvIv4IRY3H71Pm2WDu3sOhjQZe+RZ9DjrFk
 u1FWCfnRX5W61bbhix5nethL9cny+7ElCYBVC/In0wSle6lC1pPs7DQjjJbwmXs=
X-Google-Smtp-Source: AGHT+IFOBkMmuR1GK1P/BfIK5rhMix1myqhjlFnBz0HeXKIyLBRAxeTtQOtlKwE/Ow1f5b+3F8P8Aw==
X-Received: by 2002:a17:906:c114:b0:a7a:b070:92c6 with SMTP id
 a640c23a62f3a-a7dc51060a2mr910651066b.50.1722953422023; 
 Tue, 06 Aug 2024 07:10:22 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e7eee0sm560499366b.149.2024.08.06.07.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 07:10:21 -0700 (PDT)
Message-ID: <51aadce3-a8ce-4b33-9aa5-8994675c0349@linaro.org>
Date: Tue, 6 Aug 2024 16:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Fixes: Coverity CID 1558827
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.ibm.com, dantan@us.ibm.com, milesg@linux.ibm.com
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
 <20240806134829.351703-2-chalapathi.v@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806134829.351703-2-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Hi Chalapathi,

Please prefix subject with "hw/ssi/pnv".

On 6/8/24 15:48, Chalapathi V wrote:
> In this commit the following coverity scan defect has been fixed.
> CID 1558827:    (OVERRUN)
>    Overrunning array "s->seq_op" of 8 bytes at byte offset 16
> using index "get_seq_index(s) + 1" (which evaluates to 16).
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ssi/pnv_spi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index c1297ab733..a33f682897 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -729,7 +729,7 @@ static void operation_sequencer(PnvSpi *s)
>        * some operations may cause more than one frame to be sequenced.
>        */
>       while (get_seq_index(s) < NUM_SEQ_OPS) {
> -        opcode = s->seq_op[get_seq_index(s)];
> +        opcode = s->seq_op[(get_seq_index(s) & 0x7)];

seq_op[] has PNV_SPI_REG_SIZE elements, PNV_SPI_REG_SIZE being 8.

We also have NUM_SEQ_OPS defined as 8.

get_seq_index() returns SPI_STS_SEQ_INDEX. Being defined as
PPC_BITMASK(28, 31), it is 4-bit width. (I was wondering why
not have get_seq_index return a masked value).

I don't know this area, but this code is not very clear...

Alternative to make Coverity happy:

   seq_index = get_seq_index(s);
   assert(seq_index < NUM_SEQ_OPS);
   opcode = s->seq_op[seq_index];

>           /* Set sequencer state to decode */
>           s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECODE);
>           /*
> @@ -834,8 +834,8 @@ static void operation_sequencer(PnvSpi *s)
>                    * transmission to the responder without requiring a refill of
>                    * the TDR between the two operations.
>                    */
> -                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
> -                                == SEQ_OP_SHIFT_N2) {
> +                if (PNV_SPI_MASKED_OPCODE(s->seq_op[((get_seq_index(s) + 1) &
> +                                                0x7)]) == SEQ_OP_SHIFT_N2) {
>                       send_n1_alone = false;
>                   }
>                   s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,


