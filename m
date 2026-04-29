Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD73FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHzuM-0005xF-Ki; Wed, 29 Apr 2026 04:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHzuL-0005wp-7b
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:04:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHzuJ-0006Hy-Iz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:04:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso84825695e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777449869; x=1778054669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ZRgCv1IXYdXB1Opl0lxnNpiSg2MAr0D0jxwTLYnBhI=;
 b=PVlrocXDoUbxejP5C6JCYNG71yU2SNTZG6ntqckklWQsPtzdOzqDKNZL8sDZ+xgyzE
 cAS8hMWTF2MVKqSf2sePSkZR4tknAiwvgCkwZl4suwVbnQEQ2TLC2hZKePH8xCKcqLFq
 +O5e5xvm41wOqs3TUk6S6gMz2IZ2Ed9iJEDorBANLbjiqfT0cDezmhn88T+cmT2Xiv6p
 NYZ00OX3X0dSSQdoqug9PvY8x04LaRnxZKGOaYXNeL/trphmEnkrywt6VodRySj8nicY
 vjkutETcjZIvcg+YcgrvJ6KAw9qzQ5MXmEa0fWoNRlBZyFBBL0HbxrQLVubUcEWpbwL+
 uj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449869; x=1778054669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZRgCv1IXYdXB1Opl0lxnNpiSg2MAr0D0jxwTLYnBhI=;
 b=k5DsOYXhDfUEHavuPuLyHMCVuxM50bQnTINhU1Ez53mSANmCiSrJ+0gHeKkhiPW0mV
 8Kqa0vjRIEklo75UDmjszoLlY+N0VrjPazHzAMSnqkYnmwvf6EdTkAh+jUEHTH022ao7
 Z2jkx6nF5eMbQ4jatjAptVBT7ybXGP6BNl7GsKjtVYvzyc5bC1hhPcCKAa/pU/WsgrNj
 D0w+fqf0Oa/DxmveN+NXeSe3B2LmYFz220k3WjWcOXen4wFmK7QEyfRNLp3R7+zD0nKn
 MInCuPBW73gOFgDw4tBfgNX8yuAEU288zjXBU+xSLBPQ0Pc4Hwrf271dNCSO1Qp4iyUQ
 YxaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VuO8yMG1xdEk9S/kXcIukFP8Q/TJlESDCWWpb81aTrkcjsJLxP5K1ugAhEy6NZh9hSZmJdYluRraD@nongnu.org
X-Gm-Message-State: AOJu0YyTJ7M/ebBgFuRz/hJfd9FXCL6GoEDO9KtefmQGbHuDNAj0KDok
 EvNuelqfho4/SX+cFsMmuv6rI95nLYGyeK75a8VEWoTadlvLt0/MSYxTI0A6TSJVOTA=
X-Gm-Gg: AeBDievxNZbb/E54TejlejI8N8seI3jMtoXlqFENoDjn8zehEoUxLvsBjT4a9myWnx7
 xzy7a/iF1tjOuhb4Uj3Lc8tM+L09zM1pukCRm2yG/krH430vbELhDeu1YWPLrKH8m0Mk1q2h6Og
 nHWObfwEolIDaE2wI8su9KAs2P3riik6e6XrWrVaHQwsFJXYvCtLTpf2+gYVL6BfLnb/tMn/And
 iMU9F7IXF0+LrkWKD+SG1lCHaraQpbKcV7wZp0EzqxOVKbOaXxgJHBSQyKbnx2LWfNNEfC+qg0M
 9oS66NMrtdMASiAK2GG/wxG7zDc15Z5UiwTemOJhCyBItmXfUXzMJg8X7l2vqfjaGEQhuiOAzAv
 1UHPU4ARohK1v3A5c6T87kmOZSP7pvg0Q/KU5/YIghRdP56+tZTMXImZW4HPrH58GaFS51L/8Tt
 CqrBIfT84PrhWWLOkCTNxVN34WPI3xAOcZwxcTZ9lFfQMsQrnzhn6dHgpw3k9/gS5sUiNBbAtCO
 7VA
X-Received: by 2002:a05:600c:8b04:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-48a77ae03ffmr94237545e9.2.1777449869359; 
 Wed, 29 Apr 2026 01:04:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bc87e46sm39165085e9.15.2026.04.29.01.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 01:04:28 -0700 (PDT)
Message-ID: <708ac3f4-bb55-459a-9506-77751133c973@linaro.org>
Date: Wed, 29 Apr 2026 10:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/vl.c: inline qemu_opts_parse_noisily() result
 checks
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-4-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260429062004.36582-4-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 29/4/26 08:20, Bin Guo wrote:
> In qemu_init()'s option parsing switch, several cases assigned the
> return value of qemu_opts_parse_noisily() to the shared 'opts'
> variable solely to check for NULL, without using the pointer
> afterwards.  Inline the call directly into the if-condition, matching
> the style already used by QEMU_OPTION_action.
> 
> This affects the following options:
>    -drive, -numa, -iscsi, -m, -mon, -chardev, -fsdev, -fwcfg
> 
> Cases where the returned QemuOpts* is subsequently used (e.g.
> -acpitable, -smbios, -virtfs) are left unchanged.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   system/vl.c | 37 +++++++++++++++----------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 0e1fc217b4..0e0d3cb761 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2961,9 +2961,8 @@ void qemu_init(int argc, char **argv)
>                       break;
>                   }
>               case QEMU_OPTION_drive:
> -                opts = qemu_opts_parse_noisily(qemu_find_opts("drive"),
> -                                               optarg, false);
> -                if (opts == NULL) {
> +                if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
> +                                             optarg, false)) {
>                       exit(1);
>                   }
>                   break;

For clarity I'd also squash in this patch:

-- >8 --
diff --git a/system/vl.c b/system/vl.c
index cab8106984a..237334236aa 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2842,3 +2842,2 @@ void qemu_init(int argc, char **argv)
  {
-    QemuOpts *opts;
      QemuOpts *icount_opts = NULL, *accel_opts = NULL;
@@ -2921,2 +2920,4 @@ void qemu_init(int argc, char **argv)
      for(;;) {
+        QemuOpts *opts;
+
          if (optind >= argc)
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


