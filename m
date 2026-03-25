Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1581AFEA824
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5L2M-0003K7-4z; Wed, 25 Mar 2026 06:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L2G-0003Ju-BB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:00:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L2E-0008Gb-HV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:00:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43b87970468so969918f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774432820; x=1775037620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cd3A85oz4s9edgO4FnKC9F33nkywbXUmrVHTOB18MO4=;
 b=gABk0WmaXKpO2D698Epvx+hWgwLBwlqHP01pBi7YRQlhoeLcZbEFhyoLwFbISrw78M
 1quf8Y9cFy3+UG7R05OUplNK15BhQ5TOIzrbeJPfd0Z7veK+Bjt4Qaz1/RRTKkPi3oIW
 Dz9NQ1cKSjCGvdPToJnEcxc6yUxU6Fm7HRTihMWEMvrVAVaTlaZiKbd/5V26Cbyv+SNd
 03lwRA1+s78kxVZm4SzNjfLIC6oTslyHPqT+GJWvo49nYsQkE+HYyWWJvmbG7g4lvac3
 yjO4pgfc/yDcR543On1eQ6TQfbJIHgPLuLhghlEmYqk/w8dKF3tdpe8motRVt/zThQJF
 pSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432820; x=1775037620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cd3A85oz4s9edgO4FnKC9F33nkywbXUmrVHTOB18MO4=;
 b=MMJ6IEM5i5nn9yv7mUpBfRUTyVVQdQJKkiSy2S4JWR83R5EqRZkovDGdh7SFe7nuts
 Xxcs3ibUcE+aBELQQ9pbBe+2CMCFf8yNSmqqVkk7JCSrGmO/gMDDwXeNBRPY41zS8ZQ2
 RL+zqkqKkzxnMzmshTURXF6Y0rKw5CK/iNyb5Cai/gwVwgOc0+1zLhO8YV6XGZMHJiDt
 Rf/8jqn2C1aWHNcVuLoSXJvcB5JrVNBuCQw+sA4WCu6x2UTx+ZhmElJtarFVrobuu5iM
 xQZeeoP300O11s6Na9KS5wH/5dJ+2yuTfPOB7NWdiLBF02JL6AFnDrBBE0vH/vWpJ4w+
 7N5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcBWfbWPNXYKwS6g1VkEo5op+8J8aKPeFHT6S3ZPC/hfdZBWNRN+y/WXpPsZn+fDJWHndHzs9rtxKg@nongnu.org
X-Gm-Message-State: AOJu0Yw0+xaN7tg7IvLPBmuN/wsTXHRAZWobE4zf2f2MoNIDqei414a5
 r9lGW6i90FZA7tO/fqkNRNQ7c+Fz+JF9GfIokdA44DRBiMcULCsMQ7jjQgXujzPckhM=
X-Gm-Gg: ATEYQzxUM4gz3l7S3XO6TdhImx/Z5Hz3bZbBBqtF0GqDjJEUxHoRSSFxp25pBsUUUxL
 AOFj2wzKfKG5+YlNAy35InGw90DOyLx3E7LepIwqff8Axk44oNLbTzcKJOtk/5MCqh5zffOjVBn
 RDt/YsiQKP2Cp+U2tY/ckaWUryoswa3SGe2ha5r/inukJTeECtesqD/EX0jwYZeB2GDbRu8ejQG
 +1jIt3ZFOQL0563fGFv+piK2Lca2P1v65pWte0uiobHzbB9ox+otrgYfvP1EPjbCzFXyDbYv0oi
 SIHLhaXspmp1VRyQLYGUgUACuEIztOZyt9mQhQ241as1zdttv0r2KFGb/6Qg4HUwVGE+aVA4x+q
 CSamsY8bQfxB3kxRgU09Nh5amRFask8J5ERjZeQ3/3f1Nj/QkwtK5WgQpKExKeTymyGVRSQP5ju
 lXqGsp6428aYpfrERzsmpewAP6tIBpmoubQG4YKU8CdFXU2AdxrJxmAVqzR/EWecFmP/FnUP3PE
 BAi
X-Received: by 2002:a5d:584c:0:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43b88a88a42mr4031553f8f.31.1774432820183; 
 Wed, 25 Mar 2026 03:00:20 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b881757c5sm8298695f8f.0.2026.03.25.03.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:00:19 -0700 (PDT)
Message-ID: <2395a353-36a9-49ba-bb0c-824f308cc90d@linaro.org>
Date: Wed, 25 Mar 2026 11:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rocker: Avoid double-free of l2_flood.group_ids
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
References: <20260324193530.375628-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324193530.375628-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 24/3/26 20:35, Peter Maydell wrote:
> In of_dpa_cmd_add_l2_flood(), we allocate memory for the
> group->l2_flood.group_ids array, freeing any previous array.
> However, in the error-exit path we free the group_ids memory but do
> not clear the pointer to NULL.  This means that if the guest causes
> us to take the error-exit path and then later call the function
> again, we will try again to free the memory we already freed.
> 
> Fix this by clearing the group_ids pointer in the error exit
> path, so we maintain the invariant of "either it points at
> allocated memory, or it is NULL" (both being valid to g_free()).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: dc488f88806 ("rocker: add new rocker switch device")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3253
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/rocker/rocker_of_dpa.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

