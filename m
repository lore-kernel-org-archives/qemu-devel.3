Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D64DFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISXw-0002Ve-Bd; Thu, 30 Apr 2026 10:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISXo-0002Sj-Fi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:39:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISXl-000385-8m
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:39:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso21055205e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777559947; x=1778164747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OjMn/mb8ojGsmuC+TVNzUwCgCzyFSL24LMWiHkmQcS0=;
 b=tg2xwsrtod2P81CKu7/BgkJqhICzI0r7TlSVrPn9Z3tFTnia1PmwFaNoqiVfVqYKoN
 XP2V3mLP5/kzwhFxZws6QSMmlv6scGpE2ISZ5gcYTfFsEasT0xEO84lvI1A2abmPDnjo
 fRq6IIwhFBvi1TZWODcP3Mj+reRm0WZeG43ku7ROyq1mDlhoBMbwY7JD9UtH9cenDum9
 TqU2F6USAHf7nd+J4vpxZGYWPKtXhqjOvoD5d5/DPoLU/48goK5rJDtcUKzBs8f05ZhI
 Ny8aYNumpb+9/jpT2JfRUq4QC8jmVVYrFB7avMFyj/+oT88ZimJB66QUD2AX4n+cTiFu
 XKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777559947; x=1778164747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OjMn/mb8ojGsmuC+TVNzUwCgCzyFSL24LMWiHkmQcS0=;
 b=oaM+6zP/v6OxGzqA7ycUOaCiRBAXJtGUHK+8X8KC+m1JK9KkitDXli63ecLRg439Vq
 LIpqbHd5hTZsnLUyjUCQ8n1yQur9ftqnNMSrN7ouOwc4zBXi78tgaVV+ybz5y3H0Slf7
 /QQuArRfaxYx5r6e13RFtKwGnFFIuH8EsXwyupQieq4o9BUezVwjB5pOom3whRX3Dk2c
 hrW7uiXQsV8fvGDdhRibt2BFHxd84locXFTSs+6FY65282V1zAVBXCpqbWEw6TlMaM1u
 rwbVuKyT36gemVK4HM1FS9fG3V6gRFlKcA8pJM3uxoviwG/Q3WVYf8X5pIJuDfVFcE1W
 DiNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jWsazrVXBsMAJhG5mA84PGQ7750sPNQTuDNJz37SpP3OuErk2LyRmHyi95p0slbo1vvtfFHuL7Ikr@nongnu.org
X-Gm-Message-State: AOJu0YwB+Z2ZmDnKBv1xDUk4EU0bLR8ueZ8ovD1bwY2/IX4xhB7PrK2i
 +96pD0x0FS6Qbtprn4u1SMi2E2bMeJyrHDF2mStJzllNlLhjI6y+1kPO7/d1BMx45rk=
X-Gm-Gg: AeBDievzbQQtAVUWqa1Z2B5nxYZxgP5av5HOqTGxh/xup6RK2XDBrPorEWWbUtLK/WO
 LFDW902HvekaGzxiuhxxKtLQBlj6xjJ0eFjaUQXPOcwGS4RFFObchyWXZZZMVGq2xBS41sXiqy9
 UNUH+AhOlHVzNaeBVxLFOv+4K7lzu51Jw+nIutA03MtZc3Faghd+t1z41/oBB1tBKLA7pBm8EWd
 M5eokd72U0YyOdxDWJqb/17od/25K0Vc68jpeK78QDfjqRyklPTiFZvog5uRZ7hAgJw2m0V0a3o
 6DJwdV0FmoSgn/5h1H/wSMJQtMWqE1mNzwVsuwD8bJrlon0DbpUutB9xfX23VjDEFFDd22q9pBW
 LvGBaxgjbG1BmPEZOCPCY9zMsxexEv6A+nFWC87tpXA7fuQ3uqd8fBiR/GdC6aMDBaeQfsmF6Cf
 dIAXv1Kc6HRG+Kz/5eLCa8zaLfH5zMh/Jy/XwYk6MwRyX7lumTrTivHbn9xWWibbNk0swvexw21
 NhU
X-Received: by 2002:a05:600c:4b1a:b0:488:aa33:dc8f with SMTP id
 5b1f17b1804b1-48a85dc37c2mr27192005e9.0.1777559947022; 
 Thu, 30 Apr 2026 07:39:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822d4b57sm177135985e9.15.2026.04.30.07.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 07:39:06 -0700 (PDT)
Message-ID: <e5655674-ed63-4f1b-a6ea-28992db38a8f@linaro.org>
Date: Thu, 30 Apr 2026 16:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/25] monitor/hmp-cmds: Use cpu_translate_for_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-24-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/4/26 11:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> HMP gva2gpa command implementation to use cpu_translate_for_debug()
> instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   monitor/hmp-cmds.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

