Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14474CD5BC9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 01:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSPlr-0003qq-6D; Wed, 27 May 2026 21:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wSPlq-0003qe-3U; Wed, 27 May 2026 21:42:50 -0400
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wSPln-0001tG-LB; Wed, 27 May 2026 21:42:49 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8539F7A007C;
 Wed, 27 May 2026 21:42:43 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 21:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1779932563; x=1780018963; bh=yGKJzctrGbaVi47rSn7KDiYdo0zw5jOo
 sUDB8r+8nTQ=; b=fXaOoaX8aQAds3SXqu4KhTOEk5ViZ2ZDh/6SXMrjbHszi3tC
 LqkqtE9j8g2wyCpEEX3t6MVW9caPhmyBhk7CojFWoZSd9dwJQclwzC2I76KarI/W
 vzxpH/qGRKblOEEibAN82v4tTx+ceSomn4hbrtCh/yGy33jL0K+UZHEbNhvmLU7h
 y6BtwaUEQUEsCpSKlHoaRmYA2j6h59emoeRxJVNMXRAHhyqwM90098krgjNP+njl
 v4jqSyHV+HikZQ+sddwn4aA6GcanDToDS6B611CPumysxb+WLHo+7p2xtSARVAaF
 ykt072FISOlbbIJVUiw57B1TvVEP5ql2XDiWkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779932563; x=
 1780018963; bh=yGKJzctrGbaVi47rSn7KDiYdo0zw5jOosUDB8r+8nTQ=; b=L
 pI3VtXg5fNug/VUIViKeP35IOFh6yztP0kbrS9bAlN84ABJcBraosq9jookAnrrM
 pdwL1sDIOWwKfTGc5GDio1XPWo0VU+na/7nmdtc1klX9P8JRewEL7hMZLOqMxrJW
 WkAJ9jInnxO81oFh3If0M86FUGMFFb7mxIZn+pueMMSuBu6a64auuZy+xwu9PGqG
 Pp4n+CSuepDP6z6g2YVYrfvzIIgQR+guAv1rqsIMcIi3/HHwvKL+87HC7C6+GptH
 BjrLdW75OzU8e51V9Y9zIAJYS1wBCshoQ09pIKsBfJDZCeGJtkshllJZMlLbwnHb
 NpgR6j27n41cHcQ3iMtyA==
X-ME-Sender: <xms:kp0XamRMXEPUQ0PW3Qb_Bp8Pk_Md68Ibh3mmqHV2hD1t-aGtSrFuYw>
 <xme:kp0XamkyrZqkKAvgOjluU1khiJ3vQ85k8Q3nm5K11QXxHuAboNtwG1euAjc1EWJ8i
 RIusMOF9sgK2DJuquTe9Bdy-hIpZUk7gVEpv4OHNXT-WCWorQ47IlIG>
X-ME-Proxy-Cause: dmFkZTE7WXlnf3FwmIOJRjgR43ireJrimXZ+RvtaNSy0S/aS1NXZGrRjYFqfGzAP0ZAPmQ
 PM/Gtc3RQOyncEo4gkPnl7Yh+JNInWBWSzmQDtf5tVHU8uZ21xY/mIXQ6qBpT8/n8lF0EM
 rKIrpbKWB3wRq+Op6w+llr9v9l/2wCJ6WT9/ol2LClw0DUPIbKrPqYoULmWFh+XWvCqKun
 jcJjWs8fxJzbrYsP2xfpQ2vgUvZFtp3/U8T2/HnbmWmS5KJnAzEvLpwzz8rletoPkVVVFZ
 RqfbH3HX8kb2W9KBndj605mJIimpkwQdEB/rG4X8HUPI6ljOV7Df85gFY9Bwz8H+Y/4+ID
 dh3dU8RvBef0KuPtlZPmffgiaDMU9IhCZaviBbFIDQXlcvSNKGL+0vZXb9qlzkygCPfSkX
 A7Iu8EowHJAnY4tbgSNqolDR4MQsJJwjmcTX2uQcNaIZY12s4smtFCqs5FgCXDfFXYdeDy
 V4YBSYVgPa23DepG4tX8BNHbEQVny/etssaul+9ZmrTC/0yE7DR7IxjktbQc6gcWlXI4WQ
 o6ev6Bb68f581/qFDG/Miaa52i+00lhHVgFaJjbHjv7yaJkcSQENF+/ti65lf2zdZAPJc+
 vUH83BlIYT8yY7opu2IDh+9vUfvcwPEMae9WMTBLLJxBuq7XA66bOLedghbw
X-ME-Proxy: <xmx:kp0Xar5xEpsCG_gx1FykPNNAZRfQNfyGTpSTchHJo0SoML2gBB4r5g>
 <xmx:kp0Xaq-BgIo9np36oFLnCwpHu2NYKomsCzNfl_-RkVNAdYfr52--Yg>
 <xmx:kp0XaiXNaDApFnlnZfboLMTH79rvHa87aQeo_jo8YbuWVi3DrAbv9w>
 <xmx:kp0XatqRc4fm_DWvcyDh4u_98FEhvhOQf2SFQ1O5mcWJkh6-NBmmIA>
 <xmx:k50XanbEeNAmd5nrizR0CZ3RYr-GOvMTVnm6HKVHqg8pfive2_noC9hH>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 495DC240009A; Wed, 27 May 2026 21:42:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AYx57xV0Epx7
Date: Thu, 28 May 2026 11:41:56 +1000
From: Alistair <alistair@alistair23.me>
To: "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Chao Liu" <chao.liu.zevorn@gmail.com>
Message-Id: <66b5cc30-a02c-4b80-b553-df3ee30416fe@app.fastmail.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

