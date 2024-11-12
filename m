Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E96D32D84
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAo5d-0008GO-NH; Tue, 12 Nov 2024 05:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAo5b-0008G9-Uo
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:25:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAo5a-00017a-Dt
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:25:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso43062535e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731407137; x=1732011937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xy4UuM2QMxM9UiRnRfdnixF0H2+1fnYxvg3KvFylEt4=;
 b=VBoJDe63VtXXWf8ScpO9N6E3xuyAbFzZB3gchflYFzmfO1QCqzNaH3+zWTRl+dL5q0
 qf/PmwR/SJjPTatbI4gnLkqj7vmpvpES3RSm2vhy+Jix6S9/Xf3+N+RTl/Clh6VurpvN
 Bf8g/bDO1/eKnRaK/CNXIcqgf77alZ245eiTX6NNDkDTm6I2zn1tP+ezDOYF7/MGG+7m
 eOOd6vfYtezSbMIT7Gqp6TxY8ta/rxd/MqSr5uGc4gqy9yTUi4gxf3/uzzPoTXajKkE2
 uT5kB6vQvPWmWaxd+Y/agCaoULmjRJnRi3w6eH1nONK0P3h2QK/J6yrywatW7KhJ1l+L
 M1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407137; x=1732011937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xy4UuM2QMxM9UiRnRfdnixF0H2+1fnYxvg3KvFylEt4=;
 b=u6Y/HtCfT9jcV8DVYqVpqTjfB39M6vQVhM9IMAYgWs0wqSliNNy2dE9Q2aIoAfQC0/
 3G16tuvHXmwRGc+N+fpGHRnd1kQ+IxaoZCO6k27uzXVbfldCMR3/p6nxH6izffjGJBew
 VvCk5thdMTWax9WfYEMYwFs6vm3pRpYRz1DLPrV7e7bJ5WGD4hWicNaw3CDP9Y83MxRv
 wUhlLM7EUUNV9tG8zimoNJvcA+kFhWiI47PaJd561lfhyZlieRw83BxOoI1SfJWXoN/i
 9B6Q/wehXbNstBnJmbmOk0I+nGK33hcRLUNjTBJwVTKiaZEyT2ZXOb47u2ymN4jgkJlX
 vlUg==
X-Gm-Message-State: AOJu0YxmPMu7nS1+p0lY7HakZLnsqZySJ42JrXZt8TYFc0ud3u8skUay
 sYbTvJI6nVv+DRgVE9fEVv+oIzGMfiOrWp14In1DVOd9q3gbhenKXtESO6uBDu5PyZXYYK91FQe
 r
X-Google-Smtp-Source: AGHT+IHKH2DJnRmT9ehGAuHonn65l2Gasrpjq8q3KCdFuCEmpSDGCFePiEOcr7iZayqkaWIBIwbcaw==
X-Received: by 2002:a5d:6d85:0:b0:37d:4e9d:233f with SMTP id
 ffacd0b85a97d-381f186b5eemr14625605f8f.24.1731407136706; 
 Tue, 12 Nov 2024 02:25:36 -0800 (PST)
Received: from [192.168.69.126] (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr.
 [176.184.43.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea841sm15517487f8f.70.2024.11.12.02.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:25:36 -0800 (PST)
Message-ID: <24fe8063-c2cb-454a-9bed-00988948f188@linaro.org>
Date: Tue, 12 Nov 2024 11:25:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself as the maintainer for LoongArch
 VirtMachine
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20241112073714.1953481-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112073714.1953481-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/11/24 07:37, Bibo Mao wrote:
> Song Gao is will be sick leave for a long time, I apply for maintainer
> for LoongArch VirtMachien during this period, LoongArch TCG keeps unchanged
> since I am not familiar with it. The maintainer duty will transfer to him
> after he comes back to work.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


