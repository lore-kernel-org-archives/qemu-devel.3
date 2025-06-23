Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C6C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 11:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfh1-0000J5-3Q; Mon, 23 Jun 2025 07:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTfgr-0000FN-1l
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:50:22 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTfgo-0004wA-Pj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:50:20 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e3c6b88dbso28585317b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750679416; x=1751284216; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R6G6AHQ5JO83imH+f9MvoISSS5+J1L/rrZuJI2gKIN8=;
 b=hq4uUIEGHgoV0VeIB0dM4zmJvo3XD9c47JaM33c03KMZ7wUcMQ1vf8WmIQdm5wc6wG
 4qOB98I18VynUjwS+NSB/w820wCF2rpFum4AVlbuUQfYR60HbPdcJNvk5zauplObTWOk
 f2L47XoIA/V4B0xfoBU+9f4q9QJImwPZg/xullQvbIrB1nb/B0+sUpXz9gDEAvzaMFP1
 h/bD1UErFdSh5fW1z6oS41f9xZ1WWgjuzfM+qGBdmqpxPLFTySHg+8LrFT3vspBjvvx+
 fMyhcpYB1BXuqhrpfwH1nTSMuLRDL1AeRid8zw5hERxKwLVC0OApFIKq23aLYrrbLmIT
 hf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750679416; x=1751284216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6G6AHQ5JO83imH+f9MvoISSS5+J1L/rrZuJI2gKIN8=;
 b=KBOP4PapMYFeA8Q7Y4uJh5FMDCce6aa6+mgv9g6CsgA3ldhQj+ZHR7NKaor5NnXaPU
 oFde3WdbXFOCE87tpoX4XMnPo6BX8PM7fsc77b+4IblsYa0ewdSgjvf5VyrC8RSS/27+
 M8MaNq/J/bNu/XChSQR3IewBcZttVzMitjudqzJ8ag/ZbKCm7JJrFmyzxvyJDj+Eu09T
 3GppOxnth3g2k9HUt3wC8zePoPIFBgpc5eDzfkSgzLROsiHcROOV+8Wuo9kVXOx2PFRn
 NfxKvMQMxXL/Q4nzZo8BLbaEdAFZ09t9iKqqEyGzQG497PX6+AEq2NR6OAuMrBFFYesv
 MJnA==
X-Gm-Message-State: AOJu0YzswuxKU/HJ5Vm3Flm+2OmeUW3mTDX/VjuNG82YzlzcobHax1+g
 47Bsu+oq9NeSmqNlCYGmC31+GH9p/O1VV/DGaNwVaBxNvUPNx2HBNBkipRDSeIVQ/hF491xBx+l
 hr/lVhJBQhZWhi7PQOFM/VdCyR9ytUTIoJmWZqWu/Hw==
X-Gm-Gg: ASbGncu4aLLws1f3wcA5L7pgi+NLk/46i+KeLIawcwj4X6mvSWRcPlqsLYIFgV27bcS
 Eu7/zGJT24e9i1q3MBpMYTTnypCUa2jyAvX64InFEHn0FT6OipfAtiXiVSvX6WY9RvSRC8ZXxbW
 3ANR+e4CjQmTgE0UMoa1FB8sDwAOhwn/IqO+BBOkeuuzeaib5TUpbMoqE=
X-Google-Smtp-Source: AGHT+IEc3ILu+gouK5roA9RD2ekSa5Ks8UEz9LRJqWJEMNR7CS6EwRJcb5WKglA7VSRtSICulWYyh3+59MylxlIFrio=
X-Received: by 2002:a05:690c:4d4a:b0:70d:f237:6a53 with SMTP id
 00721157ae682-712c63b79d9mr158863447b3.9.1750679415665; Mon, 23 Jun 2025
 04:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-17-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 12:50:04 +0100
X-Gm-Features: AX0GCFvOQsLj2E4uexw8LsZkPtzJTGPv9K1aVDWOSeKyS1e9L9cPkwi-ha4DREQ
Message-ID: <CAFEAcA_XgjWbHKPTJuj9coxYK5UccDBx+Gg_kvMNtEFsdC=+Ag@mail.gmail.com>
Subject: Re: [PATCH v2 016/101] target/arm: Add ZT0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is a 512-bit array introduced with SME2.
> Save it only when ZA is in use.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     |  3 +++
>  target/arm/machine.c | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 052ca20283..465fc188d0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -715,6 +715,9 @@ typedef struct CPUArchState {
>      uint64_t scxtnum_el[4];
>
>      struct {
> +        /* SME2 ZT0 -- 512 bit array, with data ordered like ARMVectorReg. */
> +        uint64_t zt0[512 / 64] QEMU_ALIGNED(16);
> +
>          /*
>           * SME ZA storage -- 256 x 256 byte array, with bytes in host
>           * word order, as we do with vfp.zregs[].  This corresponds to
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 6e73368ef9..6986915bee 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -321,6 +321,25 @@ static const VMStateDescription vmstate_za = {
>      }
>  };
>
> +static bool zt0_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +
> +    return za_needed(cpu) && cpu_isar_feature(aa64_sme2, cpu);
> +}
> +
> +static const VMStateDescription vmstate_zt0 = {
> +    .name = "cpu/zt0",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = zt0_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
> +                             ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

I wonder if we should have an ARRAY_FIELD_SIZE(), to do
the equivalent of sizeof_field()... Though we have no
uses of the written-out form currently, so it might be
a bit too niche.

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

