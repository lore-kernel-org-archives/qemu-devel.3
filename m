Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1F1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1Qu-0000Vt-Ac; Thu, 11 Apr 2024 16:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1Qs-0000UT-Bk
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:54:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1Qp-0005Zk-I2
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:54:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so182345b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712868842; x=1713473642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8kFh1bUn8wCBoA1if8y0uBAHiFo2LlhWP35Q9LZcmac=;
 b=gTRX1uXPm8KgL+Dv/TxVHJl7CFYTBBS+ShbzEUijYU6djc4UdkMW5zzaFJM7MWKmLb
 35z3vLN9hXEIDG8QkZAu/jiBBWoQ8MHD9gtDm49GnCF765nFnPe0W4Z3Bk8oXJKf5nGX
 hAYwsMLVPfKUvnEGMukm/TOmEIUNh1hkpqaZOs0KxGrvZHtwbRnxO/l/XsLL6j5N1OOl
 iaVnUI+jYv70tMgOeipwMfiBal/0L2+NkZkQjU/azZ7BatR6gaus5r25rxxIshSJriYa
 dkEQWgrej2P+I+ZuTSC3+0D5HARgLJNQoAkMFzZKPUFuqInOkogB+Q5WPDTHsiceB2sR
 B25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712868842; x=1713473642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8kFh1bUn8wCBoA1if8y0uBAHiFo2LlhWP35Q9LZcmac=;
 b=RjGxp2RZtHTCGDrS0Z+9/IvhMeKBhFPE/YXNAqyPGd+Xs03Z4utAdh/m3Q47AF0j/R
 ZzCK1nlxvzO3fb7eLJ8/uixB/zGoIMu5R0rM7/+rkPcffwCeLTJLBt58TPDC6SyFH4O2
 8UrCexknSDE05tju/xp067Wpw3jHkvKmXjU51hCiv6Kf1l7GYd9lxXxiC8a/1fVz+t7M
 RgiO9BVjwcbrHRTkYuMrnrkTG4QbbwTlK39YXrcxNXJAPyh+1qv9dBsjbMs1ewAEIci4
 1icn2CXT8wg6x1EeVfjcHY3l+q8u+RYP8mh1UYh9sE1i6tZG3gUIJLEiQExSvFIXO9FY
 XxlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4ZiVJKHMgyVdKoISTytdhiI6ZpOJ81nQ64B8xRzZ5SgjI3VM+j0x5TdoPRxse0jIEQTrLgYK6G9nfyOKnjalSK6u10d8=
X-Gm-Message-State: AOJu0YxEoJ8LPrlcUQ5vjD0lYjvKgnsYBt9NjmspdC4xuFWTOo3rD00G
 7Yp2P1WUo4czroPIl9lwWhJmDW829yWDzQpd/Cbtws+MaR0/KsM9+ahNJiSLJgI7ikeg99UtLx8
 S
X-Google-Smtp-Source: AGHT+IGhwDwTvu/oVHL3FjD7DKK3UiGEfPIxSmLGl0pvfSCqJ9QsuCl4iHV/ZPYJK3cWiCd55C+2Ew==
X-Received: by 2002:a05:6a00:939c:b0:6ea:c7bd:90e3 with SMTP id
 ka28-20020a056a00939c00b006eac7bd90e3mr1040492pfb.14.1712868841223; 
 Thu, 11 Apr 2024 13:54:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 z3-20020aa79e43000000b006ed38ae38f2sm1594967pfq.121.2024.04.11.13.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:54:00 -0700 (PDT)
Message-ID: <170e5227-2ae1-4028-bb70-c2b5559dd068@linaro.org>
Date: Thu, 11 Apr 2024 13:53:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] hw/scsi/scsi-disk: Use qemu_hexdump_line() to
 avoid sprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
> 
> Use qemu_hexdump_line() to avoid sprintf() calls, silencing:
> 
>    [105/169] Compiling C object libcommon.fa.p/hw_scsi_scsi-disk.c.o
>    hw/scsi/scsi-disk.c:2659:14: warning: 'sprintf' is deprecated:
>      This function is provided for compatibility reasons only.
>      Due to security concerns inherent in the design of sprintf(3),
>      it is highly recommended that you use snprintf(3) instead.
>      [-Wdeprecated-declarations]
>          p += sprintf(p, " 0x%02x", buf[i]);
>               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/scsi-disk.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 4bd7af9d0c..4f914df5c2 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2648,16 +2648,12 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
>   
>   static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
>   {
> -    int i;
>       int len = scsi_cdb_length(buf);
> -    char *line_buffer, *p;
> +    char *line_buffer;
>   
>       assert(len > 0 && len <= 16);
> -    line_buffer = g_malloc(len * 5 + 1);
>   
> -    for (i = 0, p = line_buffer; i < len; i++) {
> -        p += sprintf(p, " 0x%02x", buf[i]);
> -    }
> +    line_buffer = qemu_hexdump_line(buf, 0, len, false);

This is adding "0000: " as an unnecessary prefix, because it's added by qemu_hexdump_line.
I think having qemu_hexdump_line as a primitive is good, but probably the offset argument 
should be dropped and printed by the two callers that need it (mostly qemu_hexdump).


r~

