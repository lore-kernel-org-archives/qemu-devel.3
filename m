Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFCD1125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MMC-000132-A8; Wed, 11 Mar 2026 12:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w0MM8-00012c-HL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:24:20 -0400
Received: from smtpout3.mo534.mail-out.ovh.net ([51.210.94.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w0MM4-0002EW-FN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:24:19 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4fWGKC0J91z67kJ;
 Wed, 11 Mar 2026 16:23:58 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 11 Mar 2026 16:23:58 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.128])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4fWGKB2J7Pz1yFc;
 Wed, 11 Mar 2026 16:23:58 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A54F712E38C1;
 Wed, 11 Mar 2026 16:23:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0058763589d-1151-47db-bb59-a0ae1ba43b9b,
 7A8A5CC3985C6570B0E5DE6DFA92F911D35F4D79) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <dfe26524-befe-4eee-b988-286c994d1935@kaod.org>
Date: Wed, 11 Mar 2026 17:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/i3c/dw-i3c: Fix uninitialized data use in short
 transfer
To: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260311021319.1053774-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260311021319.1053774-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10889140952722811915
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF3+fbzXaAOQbl7zzoB6hGdyhDwhbARaUxIGEOOjD1MZoG+5m3fOadyFkmrP717aDC2ttO3XwARb1MulYK9o0MKUTRGtGK72dQxk5gWrb8JHZLaYKzNnWtrr7he/+MJ8RTdN/S+R3lg97qCJXHCYrvtFfsvdiz4R+joMYH9VmpGdtK/SAmuRekxRGD3jpZqG8EY0joL+kpmtiDrAWJSRi/OPFjzvAQGD5JIXuXf07fK6A9/kfpJX/ZyQKnTs0M2NqGhQb3csX8ZPxY8u4PGg6ls+2fGz3nSIOikaOQH+/XuXnxjd6kBT6sgGnFMSCWNbLWnKCiXoJ8uAoCIi8IycI25aeZYKkcHYYq5GNMXEEbnCfIyItxTqCghTI0rBCPePAitoN4JbUxqlOBQR6P1pZlsmwuX2upoLzKHDzLx5VVwomFEc74/xqWD9uB4WNYnNiuedOVxFv7GZWkrLXl5dxzFwbmfsC0hbndrauCmvlUXDyJvKPifqjBnsr9FgvynGoASarPzSuxT+30uZZV7MyfsqAD4P0gyRZp0L+HCBZntBrccz2UgFZEg+JxrR+CRgUsrCatn8vXvvGYvQpjtHQ88ct2JwgYiy1fmPay2tkbqNnXYIY+euBoEUzjD+tk29wcNpXNq19I+j9fYYqT0ct/NGiZau7RNb3wiMpBM/VTebA
DKIM-Signature: a=rsa-sha256; bh=KY0tqSoyNAS6O7/6dfy8jrgAozRErgXpBs+Nh6K7+Qk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1773246239; v=1;
 b=vPO9lMlFuqG5LCL2GEkJRuNYSAvBTfL+MqvZYHZ3wUP8wIeG+PQPvxL6plbN41ZndHGBy3tE
 gBb+J/0VX/Igie7REWqBeLkV99XoQhk9JhQ9/bt3jIFU3wPIDLILsrq9uXZFDSKjY3DDtMuCYD5
 TJyVDSHdS8tgDZ1FfpcCBAdrBDLlDuHDzN7PDzr+ieUUlOA9716EvHDSosfsVBSuFjxIKop/oDG
 2pGkojRinynsAZUPMlzQbuGIqFc0avdoKNj/Mdi5wY0EEv+38+ip14/Txqy+iyRIYEWUmk4+TpZ
 er03mo6L27TMMwyUI3BGtujE4iVJlxIMiTkYh1f2pENKg==
Received-SPF: pass client-ip=51.210.94.142; envelope-from=clg@kaod.org;
 helo=smtpout3.mo534.mail-out.ovh.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/11/26 03:13, Jamin Lin wrote:
> Coverity reports that dw_i3c_short_transfer() may pass an
> uninitialized buffer to dw_i3c_send().
> 
> The immediate cause is the use of `data[len] += arg.byte0`, which
> reads from an uninitialized element of the buffer. Replace this with
> a simple assignment.
> 
> Additionally, avoid calling dw_i3c_send() when the constructed payload
> length is zero. In that case the transfer has no data phase, so the
> controller can transition to the idle state directly.
> 
> This resolves the Coverity UNINIT warning and clarifies the handling
> of zero-length short transfers.
> 
> Resolves: Coverity CID 1645555
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

> ---
>   hw/i3c/dw-i3c.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index 3d8b95a14c..aa6c27c8de 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -1211,7 +1211,7 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
>            * ignored.
>            */
>           if (cmd.dbp) {
> -            data[len] += arg.byte0;
> +            data[len] = arg.byte0;
>               len++;
>           }
>       }
> @@ -1226,10 +1226,16 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
>           len++;
>       }
>   
> -    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
> -        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
> +    if (len > 0) {
> +        if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
> +            err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
> +        } else {
> +            /* Only go to an idle state on a successful transfer. */
> +            ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
> +                             DW_I3C_TRANSFER_STATE_IDLE);
> +        }
>       } else {
> -        /* Only go to an idle state on a successful transfer. */
> +        /* No payload bytes for this short transfer. */
>           ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
>                            DW_I3C_TRANSFER_STATE_IDLE);
>       }


