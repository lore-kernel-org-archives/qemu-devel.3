Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB01E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTN1v-0003OR-Bi; Thu, 02 Jan 2025 10:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTN1o-0003L2-Ur
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTN1n-0008NS-Bi
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735831345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H+QlUM1zkdSFag+41bYiD6t+yfg0BwmFnc5kXcd1A1E=;
 b=ID5mOjehpn2yX7lbqoW3KDZ8GqRQy6FJUxFc9KjsnyYJhEVs0QoBx4X+JEmJHxAg0/eyxK
 1K6pvP3k+dyzuzO1fTGnxnRTfyB01BYX/onUsbgF+cGouoZIJkiMPEdLY2IbDchO+yiq0N
 A2WMjeLjV6Hbf+rAV6uvRU4TbW5b/po=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ksPKe5hFMpGT2I79I7guNQ-1; Thu, 02 Jan 2025 10:22:24 -0500
X-MC-Unique: ksPKe5hFMpGT2I79I7guNQ-1
X-Mimecast-MFC-AGG-ID: ksPKe5hFMpGT2I79I7guNQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467b5861766so235131951cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735831344; x=1736436144;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+QlUM1zkdSFag+41bYiD6t+yfg0BwmFnc5kXcd1A1E=;
 b=s9Qfr+qNF6ja0Hyknchsal/7EWxz5Z6h4zobOKQWtuO6bujeCNMWM7NVYYjMOBw7HN
 48znWcUhPITzdDjNQ524XGRaIHdtLAFtZbnDc+DqxmlIaAhOLvPllYZMeMej6N4QN6Zm
 LPrTCoBhgYlMxJz1kzDRMuuMilZ+J0wo7lMtyZR2GtWZluz/CWsPHonnHZAxv/94ZNRW
 lpVyknGTu2x8r1sWsr7mEF30PrzTpywnFl3phD1nryZY5E4ZjT2kRdz3c0PstO1O5I+Y
 tXbrpvsjkk6Ox//XM81fZiwSwCceHDitiChEZV2dNuaEZRi+cV6p/aAxN7kp2kKl3Yy5
 E3vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ5InYYAhQ7GPrZeSLXeRruH01AExk2w6bGMtaINmsseiU3E7I3KjdtT/I+RvtTOmVsVsi3NIOSRbH@nongnu.org
X-Gm-Message-State: AOJu0YyGXirUv+sl6O/8kn5mWHbRzovi1oX4Of2QzfVKluMXpvI+1zlu
 QMDMuGd3o7KUpg1n2DNEwnmJeraDhoqeFBtWQ1tCclTnGC0wlJ4wm25zYHsFNgYn5AKn4h65P57
 BWdTSVIEfIAGpStQvL0o9NyqukfyjfLFvcxW+A/Pgfv20/PWqIoEs
X-Gm-Gg: ASbGncv4PHd5tnFDCQtmcRMXKahkfNS4OEYlMKzRp00Sydl6KA0AEeEyOFJPUBCBsJI
 c91ciLIlmsUFglQh8oU8rdY/strnmZmQ9EzgyFvepKUdKFeKEi6j+4gH79/9VoRVTZCsH3sJzPa
 /7FR7tRrtNeYgzfpHjto1BZAYPFO9C3G2Zt/b9a59MwPEoaDxYSZqvhZFDwWBjDOkGYSMIcqhSH
 guG4gPK8TY9ykbUhVt67LKs2Gs4MOOWnZgPN83sSqjJXYnopK1XTaeGgiTTbKf89GxswM2z2CJJ
 yUmM3P62RLi1
X-Received: by 2002:ac8:7f8e:0:b0:467:7441:270e with SMTP id
 d75a77b69052e-46a4a8b2aeemr630211471cf.6.1735831344146; 
 Thu, 02 Jan 2025 07:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf31YnxpaCBla1NuV+18MXIJvDzKZzF8ZGN2dQQy+OGZ9UC3mvv+reK8dPIra2q3OvfsCU2g==
X-Received: by 2002:ac8:7f8e:0:b0:467:7441:270e with SMTP id
 d75a77b69052e-46a4a8b2aeemr630211191cf.6.1735831343853; 
 Thu, 02 Jan 2025 07:22:23 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e65181bsm136800791cf.7.2025.01.02.07.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 07:22:23 -0800 (PST)
Message-ID: <5d40b27c-1f86-4295-a1d4-9174866d785c@redhat.com>
Date: Thu, 2 Jan 2025 16:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] tests/qtest/boot-serial-test: Correct HPPA machine
 name
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
References: <20250102100340.43014-1-philmd@linaro.org>
 <20250102100340.43014-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250102100340.43014-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 02/01/2025 11.03, Philippe Mathieu-Daudé wrote:
> Commit 7df6f751176 ("hw/hppa: Split out machine creation")
> renamed the 'hppa' machine as 'B160L', but forgot to update
> the boot serial test, which ended being skipped.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7df6f751176 ("hw/hppa: Split out machine creation")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/boot-serial-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
> index 3b92fa5d506..7759e8c9702 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -185,7 +185,7 @@ static const testdef_t tests[] = {
>         sizeof(kernel_plml605), kernel_plml605 },
>       { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
>       /* For hppa, force bios to output to serial by disabling graphics. */
> -    { "hppa", "hppa", "-vga none", "SeaBIOS wants SYSTEM HALT" },
> +    { "hppa", "B160L", "-vga none", "SeaBIOS wants SYSTEM HALT" },
>       { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
>         kernel_aarch64 },
>       { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },

Reviewed-by: Thomas Huth <thuth@redhat.com>


