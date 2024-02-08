Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1ww-0008TT-DE; Thu, 08 Feb 2024 05:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY1wv-0008Sm-MF
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:48:09 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY1wt-0006a6-5S
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:48:09 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5116dfe1d9dso679128e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 02:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707389285; x=1707994085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1RjzGXtc8b/dFiKljzwEpkXvIyxAciDbn9c6btJVx4=;
 b=aVzuTaKEbHuHPbpvAaLLoyJ4qdZYN2gnNXgfOi7+PlWpRX4F1diVOR0/Rr9v9uaHim
 KaLDS0XNTQJyf0W0w5iiqu8Nqj9d7QvSyc8enl2tBauQFyYJZJkVALEfD+gq3Doj+IFi
 1bpwZAmk46GJSiOmQMDxLwu2cwT1Wu69dJr7tyM8J/kPlj1AsvU+7RrjsTgGkmfbhwJr
 DvB59i+t3QoZanaAGi8AvSA6ZWyrxYKw1SdBw2Gev10aPPUBRKZgjCJZMo2OWTU4icGj
 8gWogqOqiRds4AiwrhCSR/QFizPXvftVS23Tx6cLDW23kXnfV+rHX/frLB6KrEMMbTgR
 JtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707389285; x=1707994085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1RjzGXtc8b/dFiKljzwEpkXvIyxAciDbn9c6btJVx4=;
 b=gl/ESKTiEl1d2cRtppKJFOIcakASG9P1iQPWsh9GMkwfjrrBuSrOdOglEMSi4/021g
 4r4hoSSi0qK3NqcYby4jaKHRD0kl1tZpwsN/nHhl/Tw6cbx03YoLjhqYaTsZk0wgwwHH
 CjVqD5RT0QLseWJrKUcDda3eyhrFRqlzedtZLwN8QEcMykEX2TE//LhBkVZsjvwqq6Ip
 +dKxT5HH2TO86kNHhSC+KEDf+Cf2x7+CI1KsvTJNS7qZSK9eLBRSnUIeS8YHMC4nygj8
 /Sg8OQP+LIsyXytjtaEg1UB/vtFDJf1hgU41PDPr7LD2Wdl7CBLSsQXf3Gxt6NIsb2zk
 gd7w==
X-Gm-Message-State: AOJu0YxuT93q0cCTqYJejXo8G4wtvLszWUDYjZ07EnQ6IxE0E1nqG52O
 IuTb2J4dssHZ2rZc7qvz+tdAl0xR++d1g9GkfTQ+PiHMSlVdv0jAq1Ud/xe9Z1Q=
X-Google-Smtp-Source: AGHT+IGM9WtE5A9wdvGqfTaLg8r/N45VL46G+iXdrdOc1sYed6JAtLeYQLhzYEkPsO+oldXEaTLNug==
X-Received: by 2002:a05:6512:2039:b0:511:6534:61d4 with SMTP id
 s25-20020a056512203900b00511653461d4mr3927019lfs.35.1707389285044; 
 Thu, 08 Feb 2024 02:48:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU6MH6R2HQS+w7WCBY4wgVKrPk2Ie2EpmaLhdfs4Nkxcn12rLgwWDUWNqzaPzAKqhiowZe7po2FD0SAyGbU386otS7IEdNh31cWd5VgQuCNnGYSvYS1dhCpyJ2WQwsUXkeJTRvhAop2+8JdwSPQ1EqcCldv
Received: from [192.168.237.175] (226.red-88-28-0.dynamicip.rima-tde.net.
 [88.28.0.226]) by smtp.gmail.com with ESMTPSA id
 n38-20020a05600c502600b0040f035bebfcsm1249802wmr.12.2024.02.08.02.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 02:48:04 -0800 (PST)
Message-ID: <ffe07fee-0cda-4517-a64b-031cb922d806@linaro.org>
Date: Thu, 8 Feb 2024 11:48:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iothread: Simplify expression in qemu_in_iothread()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>
References: <20240208101657.15962-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208101657.15962-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 8/2/24 11:16, Kevin Wolf wrote:
> 'a == b ? false : true' is a rather convoluted way of writing 'a != b'.
> Use the more obvious way to write it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   iothread.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/iothread.c b/iothread.c
> index 6c1fc8c856..e1e9e04736 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -404,6 +404,5 @@ IOThread *iothread_by_id(const char *id)
>   
>   bool qemu_in_iothread(void)
>   {
> -    return qemu_get_current_aio_context() == qemu_get_aio_context() ?
> -                    false : true;
> +    return qemu_get_current_aio_context() != qemu_get_aio_context();
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

BTW using the same pattern:

-- >8 --
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index ec98456e5d..d074762a25 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -582,7 +582,7 @@ static uint64_t 
zynqmp_efuse_cache_load_prew(RegisterInfo *reg,

  static uint64_t zynqmp_efuse_wr_lock_prew(RegisterInfo *reg, uint64_t val)
  {
-    return val == 0xDF0D ? 0 : 1;
+    return val != 0xDF0D;
  }

diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index 301e61d0dd..bdd73bd181 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -183,5 +183,5 @@ int main(void)
          return 1;
      }

-    return should_fail_count == 6 ? 0 : 1;
+    return should_fail_count != 6;
  }
---

