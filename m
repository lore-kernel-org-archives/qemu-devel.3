Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFA6F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcqP-00079b-8q; Mon, 09 Mar 2026 11:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcqD-0006tA-62
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:48:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcqB-00073y-Lf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:48:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so6155671f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071298; x=1773676098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WrIJBfxQwNwzS1oBLelbPb/WGK8n0y2uuv132L2kOo=;
 b=DFZGXbJxPTUIDWk5MYJZqvPpXbThdkJEhZlHvJmtxj+B14dLv9Gvorgli1FeBFBMZG
 K8LSI9RHpiAY8XvItRpGZYjrcRiqT9/mqTZ+XC0yjIvrPHyFgMtggmWLWz6pQh1tsYkJ
 +vl8l3UrVO15MPH6hTKKq7rlqkQZfnrJ2aVt1DkjWm+Qjyvnx7WNg3n3PXMXcPwAN4Cl
 QJeafhYZrdlY2Mwd6adUOXjUpK6946EbdFttOr2odlyp+aBxmWjhUrIibaZvPBMcnNgI
 ieSww5S1G7GS3lm64EP+m4GrPVklZm9ganTuRbgBcDtevRqXhen5hl+htFt2g7DnBCyJ
 Rhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071298; x=1773676098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WrIJBfxQwNwzS1oBLelbPb/WGK8n0y2uuv132L2kOo=;
 b=dYPBn+2FF4rymTwf5K6egK/TvTv77SANmE0iYDDKH3YGDkWhkNJm3nL51t+O8AxKTM
 pwpiJEd3LkoRd+FL5Oi6wC4urB3H2rkVwWCO9hvqzR/fJimJa2zJgzre69C0jz2eSlyw
 NY0Pcd6681zJz6eq3NUnTRWgpWDtPxTkgnYARacm5PCP2yaojZRlrnlBYN5l/57VumCm
 5n2oiMCTiUoQNrFW8Jyoj2aTNy/LluuBBH+0FQlDehBTUj429qT4HodQeL2tF7NE8Yv4
 C4ShLhiQKyxHcXo0ofRIUXT+k4OG7gKqcEDDPbRYft0ZNvWFmA3BJHTzKijvo7xCUCvK
 pyBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAJf133jpFUM4OQ4qOXtb6NDYDZzqrjK1gQJ8e7nZcTUkL+wkJhSGIgQy1rjBOJla5RAb32iV1LQ7g@nongnu.org
X-Gm-Message-State: AOJu0Yw8nWFRula0ja2yvgrWhFA0GSKINj7zzuphs6WEjzHiToR5uJzf
 5ZsT+OV3NViNiob6Ts6rHv2ktpT6Z9QyvOdSJe/v9XGocKKUHj4tEAenitQ7yB7Gj/E5EXoCmyU
 uvCjWUcA=
X-Gm-Gg: ATEYQzwE3qdckNTe/WukKZgouD8HRjtl09gYh64Okq/qvA57ScyCzmo+5jOJFvnHoCi
 YHhvBN4DIWitkuBux0RvEjPkpEiaFC+cFLmDxcM+thKB9m5KWTLf5Bu+6JbkiBNaxIakj+asIrF
 ctB1mEfN0maL3I6LQ5WVLL5Ey3QMNIFoFhAeUqSuQ6IIDo7okQ2ysBtpr68LOSFm6mXL+9iyGW7
 /LoOU/Jcg9SK/4nh0vivzzlTqPhvB100kVBgzv+OQ1Lja1XO3tZrjycrH3r3IEDxB7mxR84Y2Zn
 2DJYdimymgO3hD4oB1JBM/ZK4BzMph0+UEO7mYC2AACUVzugZlCVVXpknlxkSzsXrE2OiwyWs/e
 V7YP2nVFRnoSY3t0LGigqN+rM9mo1lAYTXP01aAOAHezfF0nWN4yfqIgN7ekWTP8wkoZRYfMyYq
 WXDhwmqDp4jRCSkP6tqFz41sbiYUAfKm/ry0kzumYtkoa1bJFgiupd1l5sdqN3F3quKg==
X-Received: by 2002:a5d:5c89:0:b0:439:c018:60ec with SMTP id
 ffacd0b85a97d-439da669595mr20260580f8f.30.1773071297539; 
 Mon, 09 Mar 2026 08:48:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad97be5sm28074533f8f.11.2026.03.09.08.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:48:16 -0700 (PDT)
Message-ID: <07a45602-8dcf-4797-bd79-b97cb8666bd4@linaro.org>
Date: Mon, 9 Mar 2026 16:48:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/riscv_cpc: Free CPU array in instance_finalize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
References: <20260309095328.1406779-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309095328.1406779-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 9/3/26 10:53, Peter Maydell wrote:
> The TYPE_RISCV_CPC device allocates an array in its instance_init,
> but does not free this, leading to leaks like this from QOM/QMP
> introspection:
> 
> Direct leak of 512 byte in 1 object allocated from:
>      #0  in calloc
>      #1  in g_malloc0
>      #2  in riscv_cpc_init /home/pm215/qemu/build/san/../../hw/misc/riscv_cpc.c:175:15
>      #3  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #4  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>      #5  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
>      #6  in qdev_device_help /home/pm215/qemu/build/san/../../system/qdev-monitor.c:313:17
>      #7  in hmp_device_add /home/pm215/qemu/build/san/../../system/qdev-monitor.c:1005:9
> 
> Free the array in instance_finalize.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/riscv_cpc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Patch queued via hw-misc, thanks.

