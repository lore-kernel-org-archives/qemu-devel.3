Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73300CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVAC-00046P-6z; Thu, 30 Apr 2026 13:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wIV9s-0003R5-V2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:26:43 -0400
Received: from 8.mo533.mail-out.ovh.net ([54.36.140.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wIV9o-0005j4-FT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:26:39 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g61L94yVdz60bW;
 Thu, 30 Apr 2026 17:26:25 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 30 Apr 2026 17:26:25 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.211])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g61L9154zz1yWl; Thu, 30 Apr 2026 17:26:25 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 98FE312E3B06;
 Thu, 30 Apr 2026 17:26:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0045a52405d-64cd-4768-82cf-e5c71d11a058,
 9F47DE0B15482FF6BC55B1CE858CC0DAC5AE7A4F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <2b4f5cca-f064-4326-863c-9ab164e11c44@kaod.org>
Date: Thu, 30 Apr 2026 19:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
 <20260428055254.76581-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260428055254.76581-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10430618215129394200
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEgGWTxKP2OrnC9CrTg7KM5rhzmqMsYXlRL5OXDqVkEp5ZazjpU5sB6KcjkXimWtlf3F63zWpprfqAJMGlaLNZamW2cx0JNyvNqOBQTYOeg+MjoLLEXsyHf67COpTMx4tsMEMHLwBFb7aSd2IlD5Oh1+oxEUV0jFPf6mEgQb4xz2nhETMnv1Tnd9WLkFX9fdpRhogPzHYVJOK8h/HqIUh8BAXzhw6KcWrvoZXwYCpnlQmGG11GueMxAF34isofA6j3qMKaIWZg49wIYK5JPXIokZ1cbK1TdJ71EPA6foUZSPmTZFv8c+Puv3X7uRCzeqLTRq8UWLo4ahb+5zXkNtQEHH1rPPZW3yij1T1O6U7BuZ9KTeFbPZ6yazqdmvAKEWxKu9lKKSk/tvwUF9KBMN+SdQTm5IdEf+o3+Fres2PDIN2HW9RRIUc2e5js4X8VUnGCnZnw/MT4NDB229LA64laoaAbvueNrSe9HEE0SCKG3QiTzuLmaL0TrLbyxjKI16Uo8Y/hCKb2UMCpQ3KbOmnSUlvzh56SmsBpaSmPLiiCDdsXMB1oBd5Q7VILB3HShuoA4766ZWWzOgMD0SSmq+Bwkhmtr0vBXU9Op7kMhaA4vDMO5mk9wqexfrt36Kb0i3sPPeflTPVahRfSt1+uvneYB0J1BXP37DETb5HoFPzaovg
DKIM-Signature: a=rsa-sha256; bh=ktVqB4Cjr+fw3mxyKs0wKBnXRD6VXaPPYkedZgFeZs0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777569986; v=1;
 b=evvKmoOkrO7ho5p34NzsA5ubi5JPXdVA0Ki2gtazGensl5JZcDs+1MFgTL5szzMaFLXoC/oz
 OpdSqMA9V5clT6hdzI7rvR27iO1eMAlCUSBd/qi0/6/EM+wxMc4havn21EVIqkamIupzUfUFs7z
 0ioFTTA3EkWnUgcKtDl6KwJ/KPlAH66ATK99nGt6NqnLIB1aO4e2bQdlObKNGDK3wonfC+xIaHi
 erUX9e7UCUew0l+bDvSzvCTTtGbRm2vxqaRMy9symcnxnt+atURctKtKpablsYKo79mTrKfXtVd
 ncb0nz9ZKq2u651Gm/TuAKdfNnpCEcFHPqeT8U3h3+T0A==
Received-SPF: pass client-ip=54.36.140.183; envelope-from=clg@kaod.org;
 helo=8.mo533.mail-out.ovh.net
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

On 4/28/26 07:52, Kane Chen wrote:
> There is a mismatch between the Aspeed OTP model and the Aspeed SBC
> model in how the guest-provided address is handled.
> aspeed_sbc_otp_prog() passes a word-indexed address directly
> to address_space_write() without converting it to a byte offset,
> whereas aspeed_otp_write() expects a byte offset and applies an
> additional shift (otp_addr << 2). This double-shift confusion means
> that an out-of-range word address can lead to a write beyond the
> allocated storage.
> 
> Fix this by adding bounds checking on the word offset before
> converting to byte offset and passing to address_space_write().
> This matches the existing bounds check in aspeed_sbc_otp_read().
> 
> Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Cc: qemu-stable@nongnu.org
> Fixes: 1a00754ccf15 ("hw/misc: Add Aspeed Secure Boot Controller model")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3436
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   hw/misc/aspeed_sbc.c  | 14 +++++++++++---
>   hw/nvram/aspeed_otp.c | 13 ++++++-------
>   2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 065e822e70..8b74dca13c 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -159,13 +159,21 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
>       MemTxResult ret;
>       AspeedOTPState *otp = &s->otp;
>       uint32_t value = s->regs[R_CAMP1];
> +    uint32_t otp_offset = otp_addr << 2;
>   
> -    ret = address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED,
> -                        &value, sizeof(value));
> +    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid OTP addr 0x%x\n",
> +                      otp_addr);

This log event could be on one line.

> +        return false;
> +    }
> +
> +    ret = address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
> +                              &value, sizeof(value));
>       if (ret != MEMTX_OK) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "Failed to write OTP memory, addr = %x\n",
> -                      otp_addr);
> +                      otp_offset);
>           return false;
>       }
>   
> diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
> index a60289000c..1a9d3841b8 100644
> --- a/hw/nvram/aspeed_otp.c
> +++ b/hw/nvram/aspeed_otp.c
> @@ -57,12 +57,12 @@ static bool valid_program_data(uint32_t otp_addr,
>       return has_programmable_bits != 0;
>   }
>   
> -static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
> +static bool program_otpmem_data(void *opaque, hwaddr otp_offset,
>                                uint32_t prog_bit, uint32_t *value)
>   {
>       AspeedOTPState *s = opaque;
> +    uint32_t otp_addr = otp_offset >> 2;

I think 'opt_addr' is a bit confusing. It's a word offset.

valid_program_data() could also use an 'otp_offset' arg and
I would introduce a small inline helper to replace variable
'is_odd'

Thanks,

C.



>       bool is_odd = otp_addr & 1;
> -    uint32_t otp_offset = otp_addr << 2;
>   
>       memcpy(value, s->storage + otp_offset, sizeof(uint32_t));
>   
> @@ -79,26 +79,25 @@ static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
>       return true;
>   }
>   
> -static void aspeed_otp_write(void *opaque, hwaddr otp_addr,
> +static void aspeed_otp_write(void *opaque, hwaddr otp_offset,
>                                   uint64_t val, unsigned size)
>   {
>       AspeedOTPState *s = opaque;
> -    uint32_t otp_offset, value;
> +    uint32_t value;
>   
> -    if (!program_otpmem_data(s, otp_addr, val, &value)) {
> +    if (!program_otpmem_data(s, otp_offset, val, &value)) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Failed to program data, value = %x, bit = %"PRIx64"\n",
>                         __func__, value, val);
>           return;
>       }
>   
> -    otp_offset = otp_addr << 2;
>       memcpy(s->storage + otp_offset, &value, size);
>   
>       if (s->blk) {
>           if (blk_pwrite(s->blk, otp_offset, size, &value, 0) < 0) {
>               qemu_log_mask(LOG_GUEST_ERROR,
> -                          "%s: Failed to write %x to %x\n",
> +                          "%s: Failed to write %x to %"HWADDR_PRIx"\n",
>                             __func__, value, otp_offset);
>   
>               return;


