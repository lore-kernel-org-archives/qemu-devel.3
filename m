Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFDECD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 06:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruRpn-0007AJ-Fq; Wed, 10 Apr 2024 02:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ruRpk-0007A7-BS
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:53:24 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ruRpi-00075L-Ex
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:53:24 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c4f23d23d9so3813533b6e.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712732001; x=1713336801;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j/p4arB/1qjsJwmHhZEC0s20YjGzZVU9g9hzrGCHVX8=;
 b=RRUEIJ86GKd2++ap9yiq8h3OyXC9ihPiJnrPkyHdZwczHrYipG61qQAVVodKyXohYm
 tdmjlFqkTjTsidZbb/Cum/vR29N7ocgzZWtFwxkLSE0TonkUQLubzlCesIWz0sFaKv33
 AguuJX6y2VVx+LIS57l1Y1qvgXUd1tnzyLm0bVxDIum3P33xgdEqwSKuKtTbxEGhb5vm
 NaphQ1AfA7isYcWS+Sjf44lsoCJFFM9wAe4dxRjdEh3LpAsjTLlxbwX2NwekkXaXOYbJ
 UKTfFznzDvCPz6JoU1GQOs1qpQc4YFvKqDqlNkkYREW1N2LeBC4XKILYuXBF+igCl59v
 ZpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712732001; x=1713336801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/p4arB/1qjsJwmHhZEC0s20YjGzZVU9g9hzrGCHVX8=;
 b=NE+221A3bVsaHz3nU7/T3MM2QgXsYOpHm0TQe3dCBUfJuXyjb+I66si7Ci2CJk+Kwg
 5PYEF9oY6+2jvH0NZKleo1TYv43l4bvq9fb0ALIzWgRTOy9qtHMjn3XoG2HjACd76Un+
 xQa1b+8yK0A+C7ERVlAYpr4+CsJJPUGjcrJYBvg+ygH9oiOykJCK6Q0Us3DIDBvJQpHX
 cNju7SG5gtXZgz8Fvx4hTiRVcQrrKvBKl4yB2luLNYFxylgE8SmOuMY7TRXG8033YlUR
 8zOzhXedIUTVmEEWRclCJkh67g0tMdoN5ES25vxTJpP/1Yg6Kj11RNQt0kgYNNa0qrI5
 dbKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoOmA2En537nutD8cHsfdE9vXKY5MX7N+cxCEycSHNqBDdpgHC7ky3TpzFaq++YfUL5moTz3yKPjQZ6u97Yt4Ay1hdE4w=
X-Gm-Message-State: AOJu0Yz7l18hEBZ+9Y5NQVkBbio/NAEs+CBzwlD1ltnyUBIN0NR3R0zM
 BVgl8jV1bJxelcnxh5inkhej5wATqNMd9XT2ttod2fYhkbmAsg8Gihk8Drl4SS8=
X-Google-Smtp-Source: AGHT+IFt2T6AxxDmE3AezdxRqhw0ughr1upTh9VMhOs4COEas5rBVWDTseEHsBTHy/Q+2pTP2UI+1g==
X-Received: by 2002:a05:6808:51:b0:3c6:ce1:e2d3 with SMTP id
 v17-20020a056808005100b003c60ce1e2d3mr471877oic.39.1712732000985; 
 Tue, 09 Apr 2024 23:53:20 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a63f64c000000b005e857e39b10sm9259133pgj.56.2024.04.09.23.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 23:53:20 -0700 (PDT)
Message-ID: <94c118ab-9cc9-4a9c-931d-7ba2b9acded5@daynix.com>
Date: Wed, 10 Apr 2024 15:53:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0?] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>
References: <20240409180450.31815-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240409180450.31815-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/10 3:04, Philippe Mathieu-Daudé wrote:
> If a fragmented packet size is too short, do not try to
> calculate its checksum.
> 
> Reproduced using:
> 
>    $ cat << EOF | qemu-system-i386 -display none -nodefaults \
>                                    -machine q35,accel=qtest -m 32M \
>                                    -device igb,netdev=net0 \
>                                    -netdev user,id=net0 \
>                                    -qtest stdio
>    outl 0xcf8 0x80000810
>    outl 0xcfc 0xe0000000
>    outl 0xcf8 0x80000804
>    outw 0xcfc 0x06
>    write 0xe0000403 0x1 0x02
>    writel 0xe0003808 0xffffffff
>    write 0xe000381a 0x1 0x5b
>    write 0xe000381b 0x1 0x00
>    EOF
>    Assertion failed: (offset == 0), function iov_from_buf_full, file util/iov.c, line 39.
>    #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
>    #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net_tx_pkt.c:144:9
>    #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:478:11
>    #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
>    #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
>    #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
>    #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
>    #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> No clue this makes sense, but avoids the crash...
> ---
>   hw/net/net_tx_pkt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 2134a18c4c..6a8640157f 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
>       uint32_t csum = 0;
>       struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
>   
> +    if (iov_size(pl_start_frag, pkt->payload_frags) < sizeof(csum)) {
> +        return false;
> +    }
> +

iov_from_buf() uses 8 as offset, so we should check if the size >= 8 + 
sizeof(csum).

However I doubt that it is worth to fix. I think it is fine to remove 
the assertion (i.e., remove the requirement that the offset specified 
for iov_from_buf() must be inside iov and instead let the function() 
return 0 in that case).

Regards,
Akihiko Odaki

>       if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
>           return false;
>       }

