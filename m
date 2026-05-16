Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3351CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 10:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOC1l-00070u-Mf; Sat, 16 May 2026 06:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOC1j-00070Y-J1
 for qemu-devel@nongnu.org; Sat, 16 May 2026 06:13:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOC1h-0000W8-Tu
 for qemu-devel@nongnu.org; Sat, 16 May 2026 06:13:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso273903f8f.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778926424; x=1779531224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aV/1cApKNwYVvN0e/S/LdinI4hIS4q6XIGhm/zlypPQ=;
 b=WIi1Wln5OcVmzNYzQMfFN4pZu5Gto8vuYKmzp683DoZh/sv28da9h0+HGlbqWwuv/o
 odspf+HPebPpRNu0I7hnav0WqBYo7SU7UWA/+5lUm3ZUsXMfTG6sgYcI0mp5TMmgHyOE
 e6XbUDebCmvrd2a0qq6qhDPQTZIykfUpLJbcxGKnC3Xk/MB/YTk8iLy/pvU1VwoUrdj3
 EVR/V6mt9PsYGrr0SFibPpjiiFvtcD55SNg/MUrntF3f6AyqLnEYtj2ssNhKau+czc/G
 pWlmAPAXQzxYhf8BTgQhub9bJCVMxSy1oJPyP+BzPkzqFIZGLfj05ZKwRULU0J6UaqOT
 lNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778926424; x=1779531224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aV/1cApKNwYVvN0e/S/LdinI4hIS4q6XIGhm/zlypPQ=;
 b=QJ2ixamd6vIP+MJf7J2Q6uNaj/3exGRCQFw4R8qkYZ616RtqrPjtx5aDfKW521k4BV
 YF3/HBCRaMyPiYOFI6cp29I7/Ul3WntNVGvDCuNYB0RvBnyEX2K/yymEVsJsTEwypQQ3
 7GpLJcvtHtJFRC9Tg7u713BZc0ZrMG2p17+h/wHFxxlqaL8oeodFAYNUgHWM6mxiPo9p
 QY/TgQdzaWqwWMpakIbdTGobjGH0qFVB4/HQvx0t0WloalnZqISRozFt3fpnJQc1mw4+
 C/Byi3FRM9aFuo7gngaD4gajhAwNny3dMqvF7uAMJzme6eUnhT3YGw8Jkhxyc2ojBqE0
 dHjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+82RQ4rG4m3l2u3HJRvrs4ARLa9Hjj4j3BjCKL8Kiw/dxy5jKErx0HB1Eivfsw1F9vipzbkDcT13XG@nongnu.org
X-Gm-Message-State: AOJu0YymwOj+avkZHm38V+mlm+b/XP2/p8XTi3i5NgTJ8BVGQSltgZBN
 jwXNwT8rAM05xZNBBWBudzOfgh56Ob3qrGeVuE1lJ0dNts4Shla/ZuZajukfH0KeIdE=
X-Gm-Gg: Acq92OGaD7/KQqkNW/2NOi4Wy9T2oQL421Txcbh6Jz6/zGf/XDGItknTfSNnjpn1ub1
 ebHNW7nvNerY/NGs3JvjNztYU4+FAr81MvuUt9RnxMKlrnoeOi9Jn4mtPtyQ2OSWwhqjrRDIGf/
 BnO4LOeS/r1TWjQ1+m8PfvI5ZB+cadABAci8ZUFkgUlzMtHSDr7OjL/aHc+a79hGz08N9jTbX4J
 xguKdG6mPxJdMG+2xR7x/CcErbUk002bC5v1/zrnHNfuaW8NWoI6drF91W36OVWa8xiV8Y29Szb
 BF+FAC0dG9+wddG8PhFicpV19vp5qG+02y8hWs5K2rrWEwTbO1c2UwiP2fpmLTn4058qsf40Qh0
 3SiDnjKMv3MTzVZ7EJMWto6GnW2rTcK2DITbbTTHEJ8ZgIR4oF+alRQR+QiQUHgHLtyqmMm4I15
 OWLUd/NfHvvT1jT9Y3DUbdcxuHjIHxBJ3RxICb6Ki32vGdfmLj1zkSisSfiSTqb3/D2g==
X-Received: by 2002:a05:6000:290f:b0:43c:f52b:8003 with SMTP id
 ffacd0b85a97d-45e5c5a576dmr10138116f8f.36.1778926424004; 
 Sat, 16 May 2026 03:13:44 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm20352838f8f.19.2026.05.16.03.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 03:13:43 -0700 (PDT)
Message-ID: <1aec7543-ea5a-482c-a42e-fb1cdb0e7498@linaro.org>
Date: Sat, 16 May 2026 12:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/vl: Free allocate memory for pid file name in case
 realpath() failed
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: f.ebner@proxmox.com, qemu-trivial@nongnu.org
References: <20260515143854.2010741-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515143854.2010741-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/5/26 16:38, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> In case realpath() fails, the code returns early in the function
> qemu_maybe_daemonize(), without freeing the allocated memory. Add
> a g_free() here to fix it.
> 
> Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/vl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/system/vl.c b/system/vl.c
> index d2f4044e5d8..7e2ed898240 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2670,6 +2670,7 @@ static void qemu_maybe_daemonize(const char *pid_file)
>                   warn_report("not removing PID file on exit: cannot resolve PID "
>                               "file path: %s: %s", pid_file, strerror(errno));
>               }
> +            g_free(pid_file_realpath);
>               return;
>           }
>   

Don't we also need to release the other paths?

  - qemu_unlink_pidfile()
  - pid_file_init()
  - pid_file_cleanup()

