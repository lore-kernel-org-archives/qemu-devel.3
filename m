Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54733CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9Xp-0007ui-Lc; Mon, 12 Oct 2026 02:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9Xm-0007uJ-VT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:29:55 -0400
Received: from 7.mo528.mail-out.ovh.net ([46.105.34.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9Xh-0005JX-UG
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:29:52 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4j36yL6dVjz66ny;
 Mon, 12 Oct 2026 06:29:46 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 06:29:46 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.135])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4j36yL5H8Bz1xqK;
 Mon, 12 Oct 2026 06:29:46 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 782B6202C97; 
 Mon, 12 Oct 2026 06:29:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00492f49ffa-7432-474e-926d-89b152d273b4,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <77d5886d-faeb-4b74-a5a4-3f1345f6df10@kaod.org>
Date: Mon, 12 Oct 2026 08:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
 <20261005064418.3060881-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261005064418.3060881-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9104589598801374219
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGozuVG9jSO2JIBtu19+2txrNfPlVKdp8komCYO50vvCFlLSJ41wIumPOYxYQ201PmuMZEZIn6L1tiafXpB2uZLkrm4eaM65oh0A0OJPhXTBQAfCDcCoa1g4/aHAtJGhBlxxOm5Gt7NET0Q6n/2QzejW5zB3WRnrz0NbUZUGnA8b91XdGwp9a8QAaFspb9xvGFd7Dm8PV64vZw+yvumceWz3gdBAKCxXdYjU96IuVx4Prh42A5+t5C7OLIpG76XtpFB4hgFdQBfHFlNFvMX4IJ/H8snfHIbOzq5N2rXODVmfzE9pXSIjtbGSx9d2p7cQshNUXVJiYJYFyv25eCCI/O4tumYY8PAgenz+CgedFtvYB1vmptmE8DKNaRGN46HMJVOl9Hz+b7gdk6wvmCjdWP12Y1WsXTom87xxl6cVnSFA/yuRbXHupnZG09z6Q29SU1ax5eSoe12OPp9VT5tZZZMcLpH6CvdS0fvR53vUljJFc6B2oYtj28BIZ6jIR91gHFF8Rq7pvpLVh8Lg312QCr2UitMA9/WpI5RAWuyf+e/1NIIU4ap1u8P1g76z8RuAG2rQLtoVr3cwUWFMqHlcfMfJPwTXkxkRxA6xdba535xk8vc72IMp0i5TggUk0OIRdWSRrD62/aT4WN1M1oqFfRNDQF3lCyl77gitckS5O2X0g
DKIM-Signature: a=rsa-sha256; bh=YkihjhbIfCverKglnweQSafsyHmXVgiD3tTa0CR+daA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791786587; v=1;
 b=R0mpnt7+L9IyQ7snDx7Y6YCW506D+G19QDQ3FYxvckwIvCUcUxLsQ7FckWV0oW0WDg0A6t38
 nrPmf0Wypzs6yl/SGDX5QkpkS7QnRDssZTxExGlFNAfoovNC0njoxxcsvSaB+bmyKo5F50zwEI7
 ZMZUAq6oW1WfUBzu3kHrobrWESljPr/PPI0aAQTdMb9HCAZPFDDsjhCZnnmJdjT8LgoSbhjLE2K
 lkn/CzrmMjyIIDE8wHshoTFwKJTRmXDSh5labfiDTkiK1ds4g6rPCSzr56O9KcyOBpWt8PKXlAf
 Q4dLJ+J0yzUZZ4f2IsgLRWb9qgKMurCuDz72xVqNaEf7w==
Received-SPF: pass client-ip=46.105.34.81; envelope-from=clg@kaod.org;
 helo=7.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/5/26 08:44, Jamin Lin wrote:
> DESC_OP_EN is the DMA mode. It does not tell the direction. The write
> handler used it as the direction anyway: set meant IN, clear meant OUT.
> 
> Both directions support both modes. So take the direction from
> EP_CONFIG.DIR_OUT first, then take the mode from DESC_OP_EN.
> 
> The model does not support OUT descriptor mode. Log it as not
> implemented. It does not support IN single stage mode yet either, so
> that path does nothing until the next patch.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/aspeed-udc.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index 4572914e16..c48e2c5f1b 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -729,12 +729,17 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
>       case R_EP_DMA_STS:
>           val &= 0x77ffffff;
>           e->regs[reg] = val;
> -        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {
> -            /* IN, descriptor-list mode */
> -            aspeed_udc_ep_in_kick_desc(s, e->index, old_val);
> -        } else {
> -            /* OUT, single-stage mode */
> +        if (FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, DIR_OUT)) {
> +            if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {
> +                qemu_log_mask(LOG_UNIMP, "%s: ep %d OUT descriptor mode is not"
> +                              " implemented\n", __func__, e->index);
> +                break;
> +            }
>               aspeed_udc_ep_out_kick_single(s, e->index);
> +        } else {
> +            if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {
> +                aspeed_udc_ep_in_kick_desc(s, e->index, old_val);
> +            }
>           }
>           break;
>       default:

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



