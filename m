Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F1CCD5BD0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 01:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSPsu-0005le-L9; Wed, 27 May 2026 21:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wSPss-0005jl-WF; Wed, 27 May 2026 21:50:07 -0400
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wSPsp-00055V-MQ; Wed, 27 May 2026 21:50:06 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D600E7A0081;
 Wed, 27 May 2026 21:50:01 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 21:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1779933001; x=1780019401; bh=zcZT1M9cJKbvq7KJb6YBVeysSMi3swiS
 zYWRRjFpZS4=; b=GUw11e30HzNDg8RDxwZZVnihDTK6sNrxct4fxoojboQiJ2Wy
 5YGTwO6kN9Aun0hFteO78ggQ9qggtbxJEY59dkCp/nBc9z4BY+rKHKjagC65zShZ
 qS5XUKgB9304UvOtq4Y10VNN4SNhaRKR1KQ3HL96FFUQpg3jXefUXLjRekC7gRCi
 ORpkqsS2dlDQkgf9VbmoeobgE8xJjxiF/XkgKz0lcGZqINHteQNUiipownxfVt1Y
 UsEOr5o9j1qElLCsYYgku1A9j6ryJIxjtm4DEfSXsnAa3CNzydzrEESJFQrXpLrA
 FJ/w6Oxs5UZLz10MiSSmgWvYwu6cr6lXN2kBJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779933001; x=
 1780019401; bh=zcZT1M9cJKbvq7KJb6YBVeysSMi3swiSzYWRRjFpZS4=; b=B
 xVU88vYBQtRWgOFvICS1iShpuIZ4EP3s6BCM73zEZspc5OVZ9jkYEyRdfuUCo/md
 VJ2nhkv8uoqvfdoc/Y3Ur6jFstHz/XcatfiZq9lnXCLtc5vXKc0HJ4rEi3JacxIQ
 tVyZD/cEX+NqcoXvRjISMRmqBVP4UAJUHgdv6bPt1m29u/GG/wWIC/mfHSLFugq/
 V6pbObMdoQcrOUBm5BIZBvfwUWkTA3+402/jGGetbZv4BaiJQUFpNeIXn2WbQGfg
 Tl+59biYzzIWi30RGgWxC7bFuF8gVZXk95Ai8cY+hAvPY9li+JNE5p0xjn5DhcZ8
 PEEjF7heIbFUDlCIB49+Q==
X-ME-Sender: <xms:SZ8XauhoLJiJ3eNktjJyZ0uCXbevE2l7XoSALJdQPnwKh_f8p0Sw0g>
 <xme:SZ8Xap3ul3L7Hr4qA6hRWSQuDqFrNMUIMjHl-FkY-EXlsllpuMf2vxL-kj3BRZtPF
 CH8wEI8Pu3g0hJiCIGlcoZMvzgXav-cVh-NysqcmwsOdWoKoUXha9E>
X-ME-Proxy-Cause: dmFkZTFJa4KO7BdOjZ/etUBTDyzDgXHd5T/2Low2AgbwojPJYvKBRXatjTHf2CXdtNlTH4
 /mpV7oY9/+KRgJFRHx4pZsGQOSv6GpP1OrbMuCeu8KyaehO+AviHmf2Y2DY4ZMXHgcd4dY
 wzM1RZHiasF36p16bq81I0Wbn0O9SoB+CPFfV0f5e8gl57f03/Zn24WzfYK0EfUzHt9iDh
 I0DxxCf0RCrzaNT3FweHH6gI/EMUiXM8z5lDKr7awNx+XoRHmlJ+NIaM3cqjkjwijkQxhL
 /35V7gJuAA+cAVN1OzTz6u1FEdrsAd0AjSCEZragIlVEXYS4hAD8XX8UuZLg4G3oodrgls
 EekbN3+wZYDJVIwkeDu5H7PIRlHViDuiIgV3JPjIqxwqpM5qfBDQgMhyV4nLQVbC43Sn/h
 1fM+jQRFuCRbZxWQsY8d3n27OdVr6zcAxsPwq6/iwVziGrycFMXhNkqyv3cwdC12hq+DA4
 j+vlMx3J00NlmOLzd9FOXvkCwj0Zsz5PiuY8O5ne0WXoANaYuvy5rr1rHfygBhxEZSMiEd
 8plhpaCmyMvSMmJpehCEdi6uZm48jt6k/hWbML/6r9pzIzFUdPYc//VzP5t3Y1iH1qy2Xd
 4gDFP7nQV5X5uho/S+tYrvA6+T2lgu4rfVljX33Ws63+NW4SVeeOBXWq4frA
X-ME-Proxy: <xmx:SZ8XauNcNwyGtOG3l6sa3YAO_8I_x_nULHV_AVD7Fjv_4W3vHPMkow>
 <xmx:SZ8XaknaJOBhNESDM_mdXfZe2t0r0QLzSqoG79eCv-8nW1R53hQwZw>
 <xmx:SZ8Xai6Cg6O7v8sZDW9Cp-MxTQAEVdNu9eEn41d9GHVLSs8aavzTsg>
 <xmx:SZ8Xao1_6D9kWzhdX3BlQlNnT_hxdG2yB0LbIVO0R9mvxRUWqqkgGA>
 <xmx:SZ8XahGPBJJ4HoueIlxwQswCjzWFfrUsUgc9LMUsg7b7bqy3C_ExcTSO>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 150EA2400098; Wed, 27 May 2026 21:50:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AYx57xV0Epx7
Date: Thu, 28 May 2026 11:49:39 +1000
From: Alistair <alistair@alistair23.me>
To: "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Chao Liu" <chao.liu.zevorn@gmail.com>
Message-Id: <e83c9538-3a9e-4ca2-bbe4-eec25d936a4b@app.fastmail.com>
In-Reply-To: <20260527213034.2094103-1-daniel.barboza@oss.qualcomm.com>
References: <20260527213034.2094103-1-daniel.barboza@oss.qualcomm.com>
Subject: Re: [PATCH] target/riscv/tcg: disable svnapot if satp_mode < sv39
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.153;
 envelope-from=alistair@alistair23.me; helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 28 May 2026, at 7:30 AM, Daniel Henrique Barboza wrote:
> We did a recent change to disable svpbmt if satp_mode < sv39 that was
> discovered via a gitlab report.
> 
> This time we don't have an opened bug but the problem is similar: RISC-V
> privileged ISA, chapter '"Svnapot" Extension for NAPOT Translation
> Contiguity, Version 1.0' states:
> 
> "The Svnapot extension depends on the Sv39 extension."
> 
> Do the same thing with svnapot, including the user warning in case we
> try to enable it without the required satp_mode:
> 
> $ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
>      -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svnapot=on
> qemu-system-riscv64: warning: svnapot requires at least satp sv39, current satp mode: none
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f8b2f04a94..c3006bccb7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -847,6 +847,16 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>                                       riscv_cpu_is_32bit(cpu)));
>          }
>      }
> +
> +    if (cpu->cfg.ext_svnapot && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
> +        cpu->cfg.ext_svnapot = false;
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svnapot))) {
> +            warn_report("svnapot requires at least satp sv39, "
> +                        "current satp mode: %s",
> +                        satp_mode_str(cpu->cfg.max_satp_mode,
> +                                      riscv_cpu_is_32bit(cpu)));
> +        }
> +    }
> #endif
>      /*
>       * Disable isa extensions based on priv spec after we
> -- 
> 2.43.0
> 
> 
> 

