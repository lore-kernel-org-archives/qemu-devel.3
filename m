Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73106606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=jT+4lQ5W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOFN-0004KY-Q6; Mon, 23 Nov 2026 02:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xVOFI-0004IA-7b; Mon, 23 Nov 2026 02:13:48 -0500
Received: from smtpout5.mo537.mail-out.ovh.net ([51.210.91.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xVOFC-000838-G6; Mon, 23 Nov 2026 02:13:44 -0500
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jXxxQ24ktz403q;
 Mon, 23 Nov 2026 07:13:30 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon, 23 Nov 2026 07:13:30 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.147])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jXxxQ0y15z1xnp; Mon, 23 Nov 2026 07:13:30 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E3C731B44372;
 Mon, 23 Nov 2026 07:13:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004c2ce8ae8-b942-47be-93f6-3c06bc4a629b,
 B6C8A908DA241A829C2EE32824EAF31EC75DFE0A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 159.26.105.2
Message-ID: <39176a72-7756-477a-842b-e277ec07d321@kaod.org>
Date: Mon, 23 Nov 2026 08:13:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] m25p80: Clear write_enable after page program and
 flash erase operation
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
 <20261110-m25p80_write_enable_fix-v1-2-3a2abc0072b0@oss.tenstorrent.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261110-m25p80_write_enable_fix-v1-2-3a2abc0072b0@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 16688651370230230061
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFL1YKstmikY/X0MbgcgAFyYbipXDYws8jjC7gM5NrccUKXT4PzO09mVxwTSlDmo0Ms+mfViiLde4Pjhu3EyiIbIyL+QPGsCjW5Pmu1eS0Ua36GioMShMQLi2whT8d+vj4hJTZY9Hnuw3qdKJ5WwLr/e1svXEIPCHtqQCiaiNRtlYwz45NvCkICzW/cSZUP+6WE0/iwKsTVNsSCa+29bnD68I7aE5j5gUIfizJ0ZBUkmsLa3NS5JxUc6IWBJe0Op9bJ0qYz+KBcB0eLBo1CQuFIjV547H4DCCWoc9LB65C0whWme7PF3lvbFRJr4JXuQKs2D8WPpT+/FadidY1HSK5QWPfPO1F3JIpJyK5cqhG6bvsLGcwVJtF3wqDahcysTBDZ68154Sx9iPknbd0ZslJdAiVJ+llKDi+fWfqAx679AJuvIGO0rg7o/JE75qSPZnG+T3Ap3MBzgvsI1aYUj7cBFG4ucNwk0ltaL3RIsHMAUbruWvvOZXhyBWMhnTuwH2q+fhV8GKL6hRZuVX4gdYahtQmdsxE+9tPDhT2YzRkCPxK+4dxm9tCdYP6I+UVb+dCshdQebVNG8XKeSa8l6D575wJ6o4IHPZidryLHYrLvQ3BoOJqgGjIzD3EGLObeq7uSMe80ZOCOT9IUNiXpSu+pm1GMsx/cJshoaz7r0rmGcw
DKIM-Signature: a=rsa-sha256; bh=XLipqwcUZygTRa9Tf1DQDiVbFLYGHS/bUTy2BF7+SX0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795418010; v=1;
 b=jT+4lQ5WaZA6fXwI6/3EeZG8YjnDRLxGYv3kxwq9me0531kg8y1IkvqkMEQjjTkwJZiUgDxm
 lqAik3liqZW1pQkZECxVlgmZyp1Zk4a21iawjCuopKWOH1kt4fZew0WT/o4YZljRaoCLt482A+N
 YwFz3WpjA2e7y3/OgcRKXSa34WRuVFQWTrtMAT0Snb2d7SQ1E+FujjUMFSgJzni9JjKYUY056JY
 dc2nIbOVbkwDmLUX7NpKiTKJFibhqDhroG7t9c7XmL8YX8Lr9Ak63WwZWUB9SVI1vSE5J55FTjl
 bqOFuegIwvKzxNDO0FWQJ908i2phaC6KfTtrmQrLOOe6w==
Received-SPF: pass client-ip=51.210.91.24; envelope-from=clg@kaod.org;
 helo=smtpout5.mo537.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 19:11, Anirudh Srinivasan wrote:
> NOR flash drivers in EDK2[1] and its forks[2] poll for write enable
> (WEL) to be deasserted at the end of a SPI operation to indicate that
> the operation has been completed. The m25p80 spec[3] indicates that real
> hardware would desassert WEL at the end of page program and erase
> operations.
> 
> The m25p80 model does not deassert WEL at the end of these operations.
> Update the model to do so to match hardware behaviour.
> 
> [1] https://github.com/tianocore/edk2/blob/3c890c11dfdb5908dcbc84f977dddc6c6d43789f/MdeModulePkg/Bus/Spi/SpiNorFlashJedecSfdp/SpiNorFlash.c#L987
> [2] https://github.com/spacemit-com/edk2-platforms/blob/0b8b7182d8a20a771b97a487d0e6f4ab89fb3492/Silicon/Spacemit/Drivers/Spi/SpiNorFlashDxe/SpiNorFlashDxe.c#L532
> [3] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICROELECTRONICS/M25P80.html
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>


If this change is to be merged in QEMU 11.2, could you please provide
a Fixes: tag ?

Thanks,

C.


> ---
>   hw/block/m25p80.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 545e0b5728..cedfec67a2 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -650,6 +650,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>       }
>       memset(s->storage + offset, 0xff, len);
>       flash_sync_area(s, offset, len);
> +
> +    s->write_enable = false;
>   }
>   
>   static inline void flash_sync_dirty(Flash *s, int64_t newpage)
> @@ -1599,6 +1601,10 @@ static int m25p80_cs(SSIPeripheral *ss, bool select)
>           if (s->state == STATE_COLLECTING_VAR_LEN_DATA) {
>               complete_collecting_data(s);
>           }
> +        /* Deassert WEL at the end of a non-AAI page program */
> +        if (s->state == STATE_PAGE_PROGRAM && !s->aai_enable) {
> +            s->write_enable = false;
> +        }
>           s->len = 0;
>           s->pos = 0;
>           s->state = STATE_IDLE;
> 


