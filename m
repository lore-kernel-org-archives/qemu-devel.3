Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996EAEF071C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLRR-0002bX-F5; Mon, 09 Feb 2026 02:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLRP-0002aF-5a
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:12:15 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLRN-0000Ud-Cn
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:12:14 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82318702afbso2356142b3a.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 23:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770621132; x=1771225932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R7ZO7/r9TnJ4WFv2EFr1+qCa2vL0XHJSurK7b1EVkkQ=;
 b=M5rUa2FGp+f33mLzSsbh4hoyvCcBOGPfaKNjcLTA0PhDvsxyw/tUHpzTRnXiryMVs0
 F+xv2264PF7jjuf3L6uifF9XIipnLzVbCblRi8k9vfCdUVzJV5SCFBNn3CCyARQKdQcV
 a1IeMD097mpaKU71/nEit5RGvxT8RXTzGf/EKA9LMpU/izaWkGSR+bHRPulNkxyExBHm
 0w6n+orosMKwvPwA+UHFUFKeF4OyVxtZy2TEvy0p92tz81gB15jnbOpwdyaeZwX4Z/2u
 TvalnowSyeOIY9ZCA8RIVCR47VL4rW3yNBGG6tCRLDxw0THkL+JoBvnZWqDBzmV2Mr1F
 EOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770621132; x=1771225932;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7ZO7/r9TnJ4WFv2EFr1+qCa2vL0XHJSurK7b1EVkkQ=;
 b=s6HgQefEOQ+Gv+rYNzVm+8KlJKr/wjX57x8pZIclaLuFib/pFqnpqk2YT1Jlw9oCzp
 QypM1uMffQLBGT+Q0Ks856E+9Z9c3n+N1ZLy5NTxo8x13w4EaYjKs0ljrUK2sgDs1rs5
 OpsKjsqrhmyTjnIsPVCoHDkDPZ6epOdLUnnGWIxgwTM6NY8fnEyXHJnpihhDNEW+lIKV
 W5sPehTk0HvL1uqrWzlhNtyclg0SjBYrDO15IPBiRDapkLjUziUpjHwOEbiZqte4PZ5X
 R/NDgSyQ8xpVzYMmmUgLhtOMwMrIewOeysi+w4OSktOlCwufApxWl6luTfCk6RigNP6f
 Wd/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuREf3ylFDOb57TP+Fq1sfpuE6CY6Cetqw5ny0GkOuR0hcDjjDFFPvlYe+Xw6+hQhc3LM/EM+styh/@nongnu.org
X-Gm-Message-State: AOJu0Yz6GD5U68zhL436+LNALOQNikxRhmvoHK8tTLmBqT9wzXYhhtmt
 do5dg7Ocpd9FUbOx282WBbgFq05MQY6bVwHomCg4xJJG9byUwPPdRDUdkEfL8/9GXQ8=
X-Gm-Gg: AZuq6aJYlg9SkLSFjY8GPI4+jyDl6/u1zwZTDTSJ/cTHVBTQhv8ddwnP686cjlf/1XF
 KkJcxEz6Pws001o3WC/awjK/IuqXdVSQeNLGK42VuZtagtnwUgwvbD9F88+NVjTSWes54OJpLNs
 3Q5xnwAanz+1iVtUoDk+DRjXOB1ydQDG9qArigSB+47bPO4T/fGSiG99qltj36F/tSmfkAJ4KzG
 gJtky0jkrABZjHSMuihe1D/dES1+RjmQEJQOmr5+u+rcDPi6grdGi9swKZJ3p81QvDWRWje3uH7
 4cQUuQJHmGsYOP/46Yu789jQ5k7AZuQcdXMZqWB5fGUrx16JHmPDYUVZfLqe5plcg1joeuKI/Mw
 gjU35ZaXwvbfxYlfIxIXmPyJ61lUfN8g06kVuiXM3wjQdNvvTD83vW9ZUxbkbyk2gfw1tb6bwQ7
 Fgsnc0d4HsiiGe5CWXx5zlJHI6RkZk3cxMTbwheq2k/KNla67orwmxHRef7ucl2R7myWmlMQKyU
 Rt2RGbKTBGW
X-Received: by 2002:a05:6a00:2296:b0:7f1:4:66b with SMTP id
 d2e1a72fcca58-824416f87cdmr10889671b3a.44.1770621131863; 
 Sun, 08 Feb 2026 23:12:11 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:7b35:2dcc:ff07:8193?
 ([2001:8003:e109:dd00:7b35:2dcc:ff07:8193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441695f7dsm9806795b3a.23.2026.02.08.23.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 23:12:11 -0800 (PST)
Message-ID: <995711f7-52a4-4ecb-b888-af766d4e3b4e@linaro.org>
Date: Mon, 9 Feb 2026 17:12:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] hw/virtio/: make all compilation units common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-10-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/7/26 08:19, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/virtio/meson.build | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 20356fba812..821366f5e90 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -9,8 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vs
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
>   system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
>   
> -specific_virtio_ss = ss.source_set()
> -specific_virtio_ss.add(files('virtio.c'))
> +system_virtio_ss.add(files('virtio.c'))
>   system_virtio_ss.add(files('virtio-qmp.c'))
>   
>   if have_vhost
> @@ -55,10 +54,10 @@ endif
>   system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
>   
> -specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
> -specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
> +system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
> +system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
> +system_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
> +system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
>   system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
> @@ -100,5 +99,4 @@ system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
>   
>   system_ss.add(files('virtio-hmp-cmds.c'))
>   
> -specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
>   system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

