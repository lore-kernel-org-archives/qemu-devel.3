Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6011CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruS2K-00028E-T5; Wed, 10 Apr 2024 03:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ruS2F-0001wT-Qd
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:06:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ruS2D-0000tZ-QV
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:06:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e504f58230so1249075ad.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712732776; x=1713337576;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mU7VvPrRg5PNgvQy9IT1f+2o0BkeTo0Au7a+y3lCFII=;
 b=P49AMvxnaBWSlUX7ifU6Jk/BlzZyve5CmM3V8KFlDH3kEz5V/ldSi5myLH1o5FMfKM
 19dy4w3AupXuI+S7+InYmcH7uGq2c+5jsoqborrF12DTLL6mtoCfp7u2F7WszZqxb2Tz
 +4Nz9oOjTBwzd5QDJOia4lKM3Ke82q53+vKdXPyJEMq/F54KypiYO35b2AjDCJvTbyJx
 k6ua0ZC+pkWXROI0b/yDYmzbiErKnxRMiW6TxN/IYmu+BTvcWD5/uy7tvHcjv0wCoNN3
 H2k6XV0npPEozwpS+6ynGiVQIDFJtuSKjqbsW2bn02WBydFHBOPjnAdbv+p9+FPOyfxL
 f/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712732776; x=1713337576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mU7VvPrRg5PNgvQy9IT1f+2o0BkeTo0Au7a+y3lCFII=;
 b=VK/luHHQbZ4lQAO11bEySQAFoZVMyzoohdgyhk5o9flZId4oe2ZuCWZrrtARst5Vg4
 yXiGhx4w9FXd9KB1JlgDgeraXAyiAqgvptQtBBLni7HPcTtsVfMivaelcjKzZEzV7TNp
 hFpHGGH2ZNvO6XV6fd3adWOPNF8pVomrP6lKV9n8lsC1+jQLJlF+yzUgybeQAuqmdjZE
 IS2tgQuN2KSyGegW8WhT/08pzR5Wul3e2rckCru/z/tQJ2+7/cKxXo9OBmjsmY5x2ngs
 INVhYMyVZNFWN+R0+ZD95IiiCIuCQCrEIOsOBmMjW09PK5frJe5xPDzsLJK0CEt0bWxB
 SplA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFE8I3ybFuCIV9dE/wUrNFAktIM1WKnxLVniqKOGMqNyWxcwNSuQ3ABqsNikukTYF0QssxBhoERvTXpAdeu9g4JyUsdWA=
X-Gm-Message-State: AOJu0YwcICFeJ9LxHpghiTQYojDrvQ9f1VI/FMl28pOVj/LWebK3Nfrc
 u7PXM2fvi/u5ziaqglAuCug7zjRAKtpg0LXntzVjLuVH9NvHa1faECSAZNs2gls=
X-Google-Smtp-Source: AGHT+IF8DVH6Y3D4lP0d28CBO2ly+hYuVQBU8mOUXGQokc3Hw8BvMn1F1XlNSsbZ5SGStN9qqG8c5w==
X-Received: by 2002:a17:902:b098:b0:1e2:7879:8be8 with SMTP id
 p24-20020a170902b09800b001e278798be8mr1553814plr.58.1712732776234; 
 Wed, 10 Apr 2024 00:06:16 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a170902d4c500b001e3f148ffd3sm6702102plg.201.2024.04.10.00.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 00:06:15 -0700 (PDT)
Message-ID: <722e10bc-f038-4873-ad14-891f3485e8be@daynix.com>
Date: Wed, 10 Apr 2024 16:06:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Zheyu Ma <zheyuma97@gmail.com>
References: <20240410070459.49112-1-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240410070459.49112-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2024/04/10 16:04, Philippe Mathieu-Daudé wrote:
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
> Cc: qemu-stable@nongnu.org
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
> Since v1: check at offset 8 (Akihiko)
> ---
>   hw/net/net_tx_pkt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 2134a18c4c..b7b1de816d 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
>       uint32_t csum = 0;
>       struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
>   
> +    if (iov_size(pl_start_frag, pkt->payload_frags) < 8 + sizeof(csum)) {
> +        return false;
> +    }
> +
>       if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
>           return false;
>       }

