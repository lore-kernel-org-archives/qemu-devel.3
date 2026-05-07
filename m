Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyuP-0005fT-5y; Thu, 07 May 2026 09:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyuN-0005fF-DJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:36:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyuL-00027Q-Vb
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:36:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso10723155e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778161012; x=1778765812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QuCrcF42+Z4BI8YJv5rTRwwA2VmZ6mzsZ7yd6fMHN9o=;
 b=FhjokjLd8EXHzv/gcrzQK+LiLnfNpya23mAcHghJ+eplXOCAEKE/A6S7WulMk//2TE
 Dmj1aSpiaRmh9FaeY9F7fZhoSrtGWKtfK29Ws1PjNA5Fr204/GLIyJhsA+JUh7Sbfgf3
 OGaIH82gQAYXYWLzsHN21AMKchFwcg25+zUHue8xvXWTf+40CVf5wx+tVY9ooQQg7ZxZ
 ORr1yA9D0hoEtElQcaHh3QFT55qMuSjGGuGfrRiPWzcc7yXVUV0s2XqOZ4zOw6KVop3M
 x6FjS21oDcQ3uH7VU2FbhARpSUcZFG8ooVxM0B8LsGpEALt1XChirWE7aB2qRg0zVAuU
 khcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778161012; x=1778765812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QuCrcF42+Z4BI8YJv5rTRwwA2VmZ6mzsZ7yd6fMHN9o=;
 b=P2q6tqN5Jw6FF/wva9rzT/UUEB5ultISvn4MoVxXKBnntUqzVPRKtt/sUyxSKgjgDL
 NTT91MDhbC0neXs8anccP0ateu54fBwlk6BieRtjdp2GwDEPCyT2fX1o/hjl4CfymkqA
 vIOtc2fMZ6oXF1GsRjRl5QJI8McmZvHTB4/cqOFGHUlc2ucg3KxGxgnB/wrhDx9AW2wN
 P7G/Ib4waIiriu42xVD3gyH2MZ4GyktSDcDdO7qXb0Z6AzVAhvR55hoCppfO1FmxeJZD
 Ia1tVy672z6H0adV6rB3P6wndMJIhRzxkzPlKIogywyuXTOvSSdqxa+OoOFmylDJ7g1T
 tsOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rK8af5+5WjrP0mfvmUmJFvWQYGLR3ulmOIghc48ud+zJeuQydo+t35glTCZfFo0g/XBMtDheSZqMw@nongnu.org
X-Gm-Message-State: AOJu0YynzXC0vjLwmcfeRQkO9kxt2o5j97L88UJqciKGKst6qbqwdkCi
 16iC84ej9LZ6Qk0vo6k63PlBnJIm+ueavYUSIhcIqlVOjQ/2ZgdyblaIn8NjWNH10Xg=
X-Gm-Gg: AeBDietv/t0MYXtQ+0fR6daw+9dnGNw8wN9uT1g/MnbBvJXNL1HkQHyvbrQ3say0brL
 6I7lXENbMLPpsu70oMg3NPIdhMHG1jKyTRd/44QcQH0l4Ug7/zWLm5bxJc0GUWs20MkYJ66x8z9
 ImZWJuU8VuW05bQFsIBDGTU6e9uK+3ATUW2f33F55nTMooOp/XkkSuF9Av7/QKAHcwdt+6f3FNQ
 Ydlxc2wp7Mcq2S0A5X+NSI/vbEA4fuAHtkrcpFqzm9NpIw7BbeWpTHMJOEXUnCdrgFUShoKUl6V
 HZNpFOg/tiKBuODFK7OaLDYECgQa9I4Zu/ZxNY0ATVKcoMOuxQXsgyWEQnkKZiK/Qd5RvqWOYu2
 NG/5ogY4/Qv0BRr9TVI1f7AFoG0DoK+25DvX70Frc4AIDeXT8hkQgr2TIZS+CVbkHdnbApN2MCz
 AubH1DWuK0zCR1Fqw8XK/miB24UayECRI47VUcp2RX5SPqc0cp9HQY5fKgkSshqksjIxIUZ8nRp
 ivqEddh4yRHwsg=
X-Received: by 2002:a05:6000:250c:b0:43e:aefa:db84 with SMTP id
 ffacd0b85a97d-4515d5c65ddmr13559836f8f.34.1778161012231; 
 Thu, 07 May 2026 06:36:52 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48911sm20514533f8f.11.2026.05.07.06.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:36:51 -0700 (PDT)
Message-ID: <e27d7002-ab82-4c5d-b6da-3366e01c529c@linaro.org>
Date: Thu, 7 May 2026 15:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa: Allow VDPA to work on big-endian machine
Content-Language: en-US
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260427144746.1498-1-kshk@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427144746.1498-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 27/4/26 16:47, Konstantin Shkolnyy wrote:
> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
> "unable to start vhost net: 5: falling back on userspace virtio", and
> VDPA became disabled.
> 
> Convert the VLAN ID to LE before putting it into virtio queue.
> 
> Fixes: 8f7e9967484d ("vdpa: Restore vlan filtering state")
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> This patch was reviewed several months ago but was never applied. Resending...
> Changes in v3:
>   - Add Reviewed-by: Akihiko Odaki.
> ---
>   net/vhost-vdpa.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Queued via hw-misc since acked by Jason.


