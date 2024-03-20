Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738E3C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzEC-00028x-QV; Wed, 20 Mar 2024 12:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmzEB-00028l-FX
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:55:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmzE7-0002ok-IF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:55:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso19336f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710953740; x=1711558540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWMB2p5eJiO2VVBRipyPskEQHb1oHz4BULZQJjBao/E=;
 b=Qo8P07fQtJbtIgGMC0UV4GZfg2JA9wr4ua4cUG0DZbQOFWvoPDulJuk2sfFVN1xsvR
 U/uAs+si8rUwWJ9CKFNFUDX8vhDGNYEia9IUoVUBR0sHFRa89APRh55ANqJVtmIbAQ/A
 okDT0NF3rp/XcyFSDH3rSdzE8nVPX9n7oPUJ1wpjC9JYNNP908bkHj7fAkYQHKVfTvDf
 D1jLQZYqMA/EmFWcB+Uix84q0XxNZNShebyGA9UchcOnnCx9UIFjMy7JgQWFgCdr78CQ
 SvoFRXgUy1pKc2TqJ48kLiNA0mgDq9YNcgsO9Y3+Wr7XK65FTOCG2ORYL54IuJtxhwiJ
 qGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953740; x=1711558540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWMB2p5eJiO2VVBRipyPskEQHb1oHz4BULZQJjBao/E=;
 b=rDXtE4pKFG8iOR2c8s0JrLooKNBtyZVpbH8sarvINTss/ihHblBeKzzvno/pszmO4J
 opqC6xhVsbPwVHXplkPX/7qNBOvl61fawblZz2/CPwCtpVGbJ9CBsEHZN4YOT8DTJrRO
 WkQ4NBtMWZli6gBKj21yf5EsDKUMi3U0mldmTfLW+0Q84OzQ+tyDsE2gpjLNJq7OQuuF
 x+kisrA58PFdI4rKcElUfz2GHJ+9wwXOYjWfMBY6dCtuaAXUKcRBO8xTLW4FWGGGB5fy
 UTsflEsW2v1e/byrn87MvbReKSsNesMOEKT7YBmWYIrncvctNjSiOxPmgR3hbc9V0gZ3
 4zPQ==
X-Gm-Message-State: AOJu0YynfoNFVnZQYjB3mGtcemTkS/W4UJ7R6Wr55Oh7T0J/wAEeC0PK
 eviHfDKgw1u8rRAyw9I8Ev6bcS/pIg31C+0d6zWV12q6V2jA2PRg5rzRPCtrElo=
X-Google-Smtp-Source: AGHT+IGlFE+Sk0hTGkScd1wTqYajSIe8qrtu5+zzpxKSJtl1h+ub6TvzisW/yfJMDvKAUeh585eDvw==
X-Received: by 2002:adf:f9cc:0:b0:33e:89ad:efbe with SMTP id
 w12-20020adff9cc000000b0033e89adefbemr1731683wrr.45.1710953740310; 
 Wed, 20 Mar 2024 09:55:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 bs18-20020a056000071200b0034181bea3b0sm5563171wrb.3.2024.03.20.09.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 09:55:39 -0700 (PDT)
Message-ID: <8209b18b-ac78-48aa-8189-4d0afdc8e7c2@linaro.org>
Date: Wed, 20 Mar 2024 17:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libqos/virtio.c: Correct 'flags' reading in
 qvirtqueue_kick
Content-Language: en-US
To: Zheyu Ma <zheyuma97@gmail.com>, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc_Mar=C3=AD?= <marc.mari.barcelo@gmail.com>
References: <20240320090442.267525-1-zheyuma97@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320090442.267525-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc'ing Marc & Stefan for commit 1053587c3f ("libqos: Added EVENT_IDX 
support").

On 20/3/24 10:04, Zheyu Ma wrote:
> In qvirtqueue_kick(), the 'flags' were previously being incorrectly read from
> vq->avail instead of the correct vq->used location. This update ensures 'flags'
> are read from the correct location as per the virtio standard.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   tests/qtest/libqos/virtio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 82a6e122bf..a21b6eee9c 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -394,7 +394,7 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
>       qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
>   
>       /* Must read after idx is updated */
> -    flags = qvirtio_readw(d, qts, vq->avail);
> +    flags = qvirtio_readw(d, qts, vq->used);
>       avail_event = qvirtio_readw(d, qts, vq->used + 4 +
>                                   sizeof(struct vring_used_elem) * vq->size);
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


