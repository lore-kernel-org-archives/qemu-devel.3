Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379C6CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfNH-0007yx-C7; Tue, 13 Oct 2026 12:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfLz-0005me-OP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:27:55 -0400
Received: from smtpout5.mo536.mail-out.ovh.net ([51.210.91.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfLu-0005K1-SH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:27:49 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j409s55nkz81Vx;
 Tue, 13 Oct 2026 16:27:45 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:27:45 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.179])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j409s4Br1z1xrh; Tue, 13 Oct 2026 16:27:45 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 0AF891B42CA1;
 Tue, 13 Oct 2026 16:27:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0085ace8e4b-655c-4a6b-adce-0d9c910a13b7,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1b4a0ea8-5c36-49b9-ba2e-e575bdc49f58@kaod.org>
Date: Tue, 13 Oct 2026 18:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/50] hw/rtc: ds1338: prefix the file-local helpers
 with ds1338_
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-11-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-11-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6629580130477190189
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGR6my3yR3/nvryo3txK0P1kcLJRA/d7vE2mcZt4FU0101Phy0w72x8NaAAitpVOKF90GjzO+qvyH4b9FwTtmpkhfLFjS0l12jss995+1+CSt9dRVdFIQNpyZdw8JMEP2OsUr8kvui2suot0yeCho3mnogfR4OTybzBtjNMkwH6rZtCoqReZ3Xspx71uofptYG14YF6LA5GycHnmvCu/0xVFDe26Q2EQYr+SnIunnR0fmLViQ427J1pKhXw57wm7RCqCjm1N0L8M3POU50m/6Bb5k0XLbMF/HIdLLyBBH69MTzgyhl3rYpvnCPplNoVIxflhu2FB8H46UP+iEogqCYPTusEQil43lR38Xf675RDHS5YbucYOcNy8BbpkTwu1BVbGGa/nKhZU2+jUIG2T78CHXBNsReA0u+cPKVnmV+vpGNOhHg5aDqh8VDdhSACLK7uTdZytGonNKQlv9LF46ypvkgwQ7KehEsRJVrtnxRXJLGpAGUyWLbdM5Zu06IR+WV2t51xf7TPphzeBqxTeugRyTySc3f5NDmgW5S2LXvcKrPgzjkU5Z5v5wQO3ixCB0W+G3l1lxVKOfCkQs+yTJtZiekRJl6R0gi+ZViZ/2lzwfr9ZjuumeZr+FbruXU4/pfcyrVVkvlx2eLm3ehUFrqf0E/GTMjbu6YIPgZ9xpBm+A
DKIM-Signature: a=rsa-sha256; bh=HNRiRRwq1pmiJdgMoZ0l3oA8GYphZqLM7CyDDGwwetc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908865; v=1;
 b=FuHlpZvC1OVAauekxzK6kclLTjdLCE/oIKLHHukZaZ72YLzfvRQWDV/a2486vyKy0q2LT5bs
 Gmm+c2zzLbbnxl9QzLfoE+AFGViFxLPYSl5cGYWHWj9LErABOaHGMWf5OLB/TcL/6EFcWc7btP4
 cpbWlBe7BHvYiQ+/rXiFs3444mg4eQPoctrdO7MMxVXm3aIezZU8x8MuMhFmnG53RcoOA/4LHhB
 HhNRLqRDjLVIyrVlmk14NxmbnKi5XouhRRWABwm+UWr8X3OYdkBAGIsJVQaMZJBRc4huS9+nFs3
 rPqref21xFskVG+Um8GrjhOOuGauKr48r7ymbTs6j/6XA==
Received-SPF: pass client-ip=51.210.91.14; envelope-from=clg@kaod.org;
 helo=smtpout5.mo536.mail-out.ovh.net
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

On 10/12/26 16:32, Emmanuel Blot wrote:
> Two static helpers predate the rest of the file and carry no device
> prefix.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/rtc/ds1338.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
> index 74aee6c746..1755a3a37c 100644
> --- a/hw/rtc/ds1338.c
> +++ b/hw/rtc/ds1338.c
> @@ -57,7 +57,7 @@ static const VMStateDescription vmstate_ds1338 = {
>       }
>   };
>   
> -static void capture_current_time(DS1338State *s)
> +static void ds1338_capture_current_time(DS1338State *s)
>   {
>       /* Capture the current time into the secondary registers
>        * which will be actually read by the data transfer operation.
> @@ -85,7 +85,7 @@ static void capture_current_time(DS1338State *s)
>       s->nvram[6] = to_bcd(now.tm_year - 100);
>   }
>   
> -static void inc_regptr(DS1338State *s)
> +static void ds1338_inc_regptr(DS1338State *s)
>   {
>       /* The register pointer wraps around after 0x3F; wraparound
>        * causes the current time/date to be retransferred into
> @@ -93,7 +93,7 @@ static void inc_regptr(DS1338State *s)
>        */
>       s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
>       if (!s->ptr) {
> -        capture_current_time(s);
> +        ds1338_capture_current_time(s);
>       }
>   }
>   
> @@ -108,7 +108,7 @@ static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
>            * START_SEND, because the guest can't get at that data
>            * without going through a START_RECV which would overwrite it.
>            */
> -        capture_current_time(s);
> +        ds1338_capture_current_time(s);
>           break;
>       case I2C_START_SEND:
>           s->addr_byte = true;
> @@ -129,7 +129,7 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
>   
>       trace_ds1338_recv(s->ptr, res);
>   
> -    inc_regptr(s);
> +    ds1338_inc_regptr(s);
>       return res;
>   }
>   
> @@ -204,7 +204,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>       } else {
>           s->nvram[s->ptr] = data;
>       }
> -    inc_regptr(s);
> +    ds1338_inc_regptr(s);
>       return 0;
>   }
>   
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


