Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0115C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3rW-0001Va-MZ; Thu, 08 Aug 2024 10:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc3rR-0001U0-26
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:11:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc3rP-0003OR-AG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:11:24 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a1f9bc80e3so397650a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723126281; x=1723731081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mtpjTQuLzutYFsT+uhhXcKRFpZ6Y+znR3RIJNFzK2t4=;
 b=V4wJt1d59V7oWqJgODgjS/Rpw6JBr8YiJVMZQZAUeG5fy2M41rurl+vhLUmp1CiCV0
 pmgiQ2X0O2/+84PRtkuNTVhE1wuf2Mm+Jlz02ts9FBGwpic4/qPV+Y1c7xA0IHzsWsHw
 SbYKwSYDexmoHcXQh91Fe6seyIQyZpHlqsoW/KNtAVLwILicpznqbZS7HPpILI9XIyFn
 /ooCVBAi7foFTX5p4YojqF55mF6RVBVYxl/m4IqUGon18YW6M4PEeIrSMqqsnApVl+jw
 1Aae/GaCe88KA/9y2ULbqZQ/aXdfyTlOlZrm+leOzEKbhePE4yQadnwS/PMZxYfsAtAp
 UQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723126281; x=1723731081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtpjTQuLzutYFsT+uhhXcKRFpZ6Y+znR3RIJNFzK2t4=;
 b=fwgl4FCYR0ZR4KIMNp3pov5a+xkz4voBHfxCa3sHj1R+FkF6wXzdvgmHTvPxl8RsBI
 vfNk6d8L1KlwJSUkl5yzImfRoiLjlPLbeX5lP6aKO8zzeB65B6T41B/FJv+mllA07Cik
 jZePNY8+UlaWrwk3JDG5htkVBy6OYkXIe3y7etxFMMX6UTFog6quSrL8DDhS42gDZzUm
 aCOB82PF0MOQgUydGOtye2C60DZ7OAgGHbQ9magqLPzpRdOqVAtZ5SJubad+4/Z/0C6x
 ZexMFlTcSSmkd0W0ZAygYF90DH42e96lrfEBq0Gdu6K6Sv+8E19MRM9Jh8SqDrsd9puI
 WH1A==
X-Gm-Message-State: AOJu0Yyf6I3HwgU8pvcV2ClKiVZtQdDEAq7kxSHEPP67zd27rDF7jrRB
 9Nv0QPMYaPbiOveytMNfibrc/iKwl/foVaw9YvHtRIgna6B4gihcVSA/QLCiSPCnuK5PL3/dyYH
 6zyclL3gOwbHs9dbFae5YRIdHLhZTkebCxYbC3w==
X-Google-Smtp-Source: AGHT+IEsk8KvH+K9k5OoBIlkoxi7H2uStHZfai1dgdMfnZZrRTTNod5npTzWEiMBtRMjsP/ABVmHRKYNMVejNVvDwJg=
X-Received: by 2002:a05:6402:5207:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-5bbb223941bmr1956689a12.2.1723126281274; Thu, 08 Aug 2024
 07:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
 <20240806134829.351703-2-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240806134829.351703-2-chalapathi.v@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 15:11:09 +0100
Message-ID: <CAFEAcA_AXzTbgC9chFoaYU_XxFSxGA5OE+iwHJn=X23idZRd0Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Fixes: Coverity CID 1558827
To: Chalapathi V <chalapathi.v@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, 
 npiggin@gmail.com, clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com, 
 saif.abrar@linux.ibm.com, dantan@us.ibm.com, milesg@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 6 Aug 2024 at 14:50, Chalapathi V <chalapathi.v@linux.ibm.com> wrote:

The Subject email for a patch should say what it does
in terms of code changes, not just list the bug number
or coverity issue number, and it should start with the
prefix showing what part of the codebase it is changing.
You can look through other commit messages with "git log"
to see the general style.

> In this commit the following coverity scan defect has been fixed.
> CID 1558827:    (OVERRUN)
>   Overrunning array "s->seq_op" of 8 bytes at byte offset 16
> using index "get_seq_index(s) + 1" (which evaluates to 16).
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  hw/ssi/pnv_spi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index c1297ab733..a33f682897 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -729,7 +729,7 @@ static void operation_sequencer(PnvSpi *s)
>       * some operations may cause more than one frame to be sequenced.
>       */
>      while (get_seq_index(s) < NUM_SEQ_OPS) {
> -        opcode = s->seq_op[get_seq_index(s)];
> +        opcode = s->seq_op[(get_seq_index(s) & 0x7)];

This doesn't seem like the right fix, as Philippe points out.
It's also not any of the possible approaches I suggested
in my email in the other thread.

 * if we're confident that this value really can't be more than
   7, then we should assert() that
 * if the value might be more than 7 if the guest has done something
   silly, we should arrange to detect and handle that error
 * if the hardware really ignores the high bit of the field,
   that should be implemented in get_seq_index(), not in its callers
 * we should consider whether using a local variable instead
   of repeatedly calling get_seq_index() might make the code
   easier to read (as well as helping Coverity)

>          /* Set sequencer state to decode */
>          s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECODE);
>          /*
> @@ -834,8 +834,8 @@ static void operation_sequencer(PnvSpi *s)
>                   * transmission to the responder without requiring a refill of
>                   * the TDR between the two operations.
>                   */
> -                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
> -                                == SEQ_OP_SHIFT_N2) {
> +                if (PNV_SPI_MASKED_OPCODE(s->seq_op[((get_seq_index(s) + 1) &
> +                                                0x7)]) == SEQ_OP_SHIFT_N2) {

This doesn't look right. If operation 7 is SHIFT_N1 then we
do not want to look at operation 0 (which is what
"(get_seq_index(s) + 1) & 0x7" will cause us to look at), because
operation 0 is unrelated. What we want to do is have this condition
be "if (sequence index != 7 && s->seq_op[sequence index + 1] is SHIFT_N2)".

>                      send_n1_alone = false;
>                  }
>                  s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,

thanks
-- PMM

