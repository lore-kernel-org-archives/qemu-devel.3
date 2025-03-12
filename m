Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8F4C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsL3C-00009e-NC; Wed, 12 Mar 2025 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsL3A-00008g-AO
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:19:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsL35-0000Wu-Ga
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:19:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so39634705e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741781935; x=1742386735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZfcXYpuTOSiYuEu6THYwSoOb7Gk4ZjOBugo00vh6ZYw=;
 b=PffVcRhN3aIXlOf9PdAEeA+fTnk82lGAlM2aRtqYy2V0SE63zFRvB8yhjTmBqjSP5p
 uOYv0/yVDDJYFP5TqvmRJ71SIdRbs7G+fkGUDi7M31Yx/tPbD4vzS3MFXj3xAgG126E3
 DkMVUkBDi4h/BPI7TeZHKjAz+xwPnacnCBrGkUEPpVP+Wm885PXshyJA87mV6QNoUdw/
 4of0TdWrpfotfkGzRLWk9jiNvPnLCDGv7K6Es/c5ln7LUo20ThtGw79DXzyaMXC0twuU
 +JD4ZgsZRPCNWQ30KVWKHTetZJpIiZEHaTEz6lrn5raHqOSstHme6p6d+bVz/xQ71dVN
 HZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741781935; x=1742386735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfcXYpuTOSiYuEu6THYwSoOb7Gk4ZjOBugo00vh6ZYw=;
 b=j5akkHpgBJkGYaEKNvohgaCESMDj62DWkmicvYu15mLtqaRSRmShjnHa0CgNL8QXTy
 x/0LzEQ7mB3VYsO6Jbeb+pjmMrd+VXv5gWaOh7ceZnro5xUXXjTPoa8J/WamnQkLvy0q
 f+pol3nVFZFg1GsY2pyLvVnQmpSJMeR2hs3RvncOS9ZC7GMfM+nLVHKThiMz3KTGAjxx
 ziUaP/RHBmzmnJL742MZk6sVNgoo4E8l7wJoTlITifkQngi/JZ3Dt6Majq+NM4oSNWQS
 PvanW7CXTZ88+HylI2Vrl7VNDrO4ucOxMJIhdpUOragwXUckXdc1OcmzkM+xzy3CDXtv
 BqmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsZ5AJaLj7Ui8WNhX3RC+nle0fYFi53GUPmTqYtyHDMxn5oDUrSsJgwidd96FLA0bjPjo+GmAbCI9V@nongnu.org
X-Gm-Message-State: AOJu0YyH8KudW/jc7zDwc5g1endVZrxSpdRGIFrH2hczNmZ0K+3RVmR+
 5UZKeu0vOgABvkkq7VswcdNlh1pZc2Cnrak29P7nQp6Km1m6WRnMmKPUPrZy1m0=
X-Gm-Gg: ASbGnctpR0Oi4sQSSoEs3uLuCwrGaEQk7odXoJIme6KVD2/7xFM4AHaPsoODk6F9uLX
 IZiNfN7fW+hBlR5JqepSK4ONJym8Dh4cSTh+KXoBLM2UU+FP2OuA6O2bb/8axwsCF8xAD11/xZW
 MMHMOOtFm19sgE7aXHMJ26AWaPEimbDIYyVrEoxW/tasTTVSBePH4NfZfBMbHgj2PJZhsx1Vj2b
 W7UXm9x6lFKxg0BxUD7s04wOd6UgsMAXj4KgxA04/R46j0mW/rbTgDdr1fqiv2hxjn8Ooq290W/
 NoS7hBbwwMUcaqcwze4q7seZYe/PsRZ2KDV5V+GM36R6hJm7IzauZ7CoQimsYZp70dBnAbltS+g
 zhzqWFQ==
X-Google-Smtp-Source: AGHT+IGYjQIfqlqq21Asd3AwbPEkSXn4UPJ2MqmMehCrzSMrYrBuUVASsP/SltSm3m4bMDOejZb2HQ==
X-Received: by 2002:a05:600c:1c06:b0:43c:fa0e:4713 with SMTP id
 5b1f17b1804b1-43d01bd1c94mr75196465e9.2.1741781935570; 
 Wed, 12 Mar 2025 05:18:55 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm21085934f8f.65.2025.03.12.05.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 05:18:54 -0700 (PDT)
Message-ID: <b9550966-3c60-48dd-b0f3-a6833bd59cd9@linaro.org>
Date: Wed, 12 Mar 2025 13:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230816210743.1319018-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230816210743.1319018-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Thomas,

(patch merged as commit 4f7689f0817)

On 16/8/23 23:07, Thomas Huth wrote:
> When starting a guest via libvirt with "virsh start --console ...",
> the first second of the console output is missing. This is especially
> annoying on s390x that only has a text console by default and no graphical
> output - if the bios fails to boot here, the information about what went
> wrong is completely lost.
> 
> One part of the problem (there is also some things to be done on the
> libvirt side) is that QEMU only checks with a 1 second timer whether
> the other side of the pty is already connected, so the first second of
> the console output is always lost.
> 
> This likely used to work better in the past, since the code once checked
> for a re-connection during write, but this has been removed in commit
> f8278c7d74 ("char-pty: remove the check for connection on write") to avoid
> some locking.
> 
> To ease the situation here at least a little bit, let's check with g_poll()
> whether we could send out the data anyway, even if the connection has not
> been marked as "connected" yet. The file descriptor is marked as non-blocking
> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this should
> not cause any trouble if the other side is not ready for receiving yet.
> 
> With this patch applied, I can now successfully see the bios output of
> a s390x guest when running it with "virsh start --console" (with a patched
> version of virsh that fixes the remaining issues there, too).
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   chardev/char-pty.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 4e5deac18a..fad12dfef3 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
>   static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
>   {
>       PtyChardev *s = PTY_CHARDEV(chr);
> +    GPollFD pfd;
> +    int rc;
>   
> -    if (!s->connected) {
> -        return len;
> +    if (s->connected) {
> +        return io_channel_send(s->ioc, buf, len);
>       }
> -    return io_channel_send(s->ioc, buf, len);
> +
> +    /*
> +     * The other side might already be re-connected, but the timer might
> +     * not have fired yet. So let's check here whether we can write again:
> +     */
> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
> +    pfd.events = G_IO_OUT;
> +    pfd.revents = 0;
> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
> +    g_assert(rc >= 0);
> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
> +        io_channel_send(s->ioc, buf, len);

Could io_channel_send() return -1 in this case, and if so is it OK to 
ignore it?

> +    }
> +
> +    return len;
>   }
>   
>   static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)


