Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABECCD199
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95Ga-00059o-Kn; Wed, 15 Oct 2025 13:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95GY-00057c-R9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:26:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95GV-0007ut-MK
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:26:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so3282988f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760549176; x=1761153976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOv/nppyZ32LfjeLPRywusDf0oeobpXwrsQhVToNr/4=;
 b=CWhFBkHy88ezBp3Oh6DLl4aNdbIK5SY+HhE1gB3Zuz+GrLqCnTDAwkn/IwtuzI883S
 8idNAgiVmqo+a15kGRIPRvt3Eu7CGX3hXEXkl/NTdk4zDp7BMt6zqlraQqDcgX42UT1u
 grg9OsJ6OqsNrR60RIHvS/ssitzye2mvRsF0Wp/QObHkTU65RuoBJp4ZF0Zbkf7pyI7D
 /F/M1/rkPeIEfDZ3vXEkuX7a4gvNefQtQU9IHRf7syWpq8AH7kwYT6cP3a4hb+15pw4n
 iwW2sZWjeMB94l4j+LA7DwLUyi1zMMj/0fbpOqoIgiiZu4Yn9e0OzMOO5eCn0XSyLuG0
 txEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760549176; x=1761153976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOv/nppyZ32LfjeLPRywusDf0oeobpXwrsQhVToNr/4=;
 b=lNh15KRg8vZ2/J4JNhAf7nOPOICqeU3nu+vjvZxow1KUvJ6/tBlBYsnycxVOIqgibg
 YzdJRZ68uhVYIwLCs/at0ZND5Izo9dYFfXbn9WqjbNBKIs48ibzys01vMlWq5YiN5fy8
 To0xHDY10sgVGA1EMplW2H3Pef1DDYyI7WcLIt7sW2TGcqDuExShJxP8gW7/RO4y2ng7
 M22jZc5zCzpbJtfnUUpOz3iXCO0BRR0yv6ISIhwjZRiSmRBuVE3LXHrj+KuKqEsKt66Z
 yHlZnW5n2zMo68R5eHobCCGXoP4gbofvDj4ZUasTdM581bwBPqW4xIvCRduZEmNz+FL6
 9bXg==
X-Gm-Message-State: AOJu0Yx9neapArmZkOGwSP9zCm9B2lYTti+CXseUT8/7Ck/M7sRhQeAe
 4jMy3YusQKhx0dABnasDjceJrpbVURTx4FFAwV9yL3oZp1gO4coaw7tWZKkNFEDhe7AWcaV/ev2
 PKiZlPGYZQQ==
X-Gm-Gg: ASbGncutEjzNH42zb8R0uoO61JJNIM1faL4QdCgMA2o4gjoRThBLbUmt39kYiR3gCWq
 snKzXcue7AC4zR7dxtNh3155s3xUZOgeYGXLyRagYAzSnai7l01aZe9JtQPLjKDrzt/b0Hnhj1h
 2+x+/+dmlJf+Gf85OZFbMZtbrb9GYMEPJsuR6yCHcgcqFCNwe2K497tDXxnsfM3iqBCmw1Kr/Dd
 8lX5Je6Pd18TTbz96vjncUA8/AP4t64WUHJsk5jNsMX2QvZGFrapQSAlbvcepc4VjKa2VW47FpW
 XcXeo9mNo5LSD0QN+FAe2LIaOxKKDaxhFOLASrYAnCbs3dLyg621owilxXpv/QhkMYfLe6FPXYe
 pYPi8lg0lKZvGCAiQPbXDzpOAX2AH0MGwFNcqzHkQDUvdBTAEoKIbqIlCUo6hBSBG9+5reOXyF2
 +DWxjdhvzAZboEPoXz3jqn9PY=
X-Google-Smtp-Source: AGHT+IFw2n+KUXTXATgZYGICXVGyaQfR1N6o5BF5mHVm8CAPTvKKvN+wY42OyBS2BVgQcSD+KwKeKw==
X-Received: by 2002:a05:6000:40dc:b0:426:d60f:746f with SMTP id
 ffacd0b85a97d-426d60f747amr9345802f8f.30.1760549176371; 
 Wed, 15 Oct 2025 10:26:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c209d8sm41830955e9.9.2025.10.15.10.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:26:15 -0700 (PDT)
Message-ID: <6c8afb23-dc17-466b-a440-19acb55b4e8e@linaro.org>
Date: Wed, 15 Oct 2025 19:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] target/openrisc: Remove all uses of
 target_[u]long types
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 10/10/25 09:06, Philippe Mathieu-Daudé wrote:

> Remove all the target_[u]long uses in OpenRISC frontend.
> 
> Based-on: <20251010031745.37528-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (13):
>    target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
>    target/openrisc: Do not use target_ulong for @mr in MTSPR helper
>    target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
>    target/openrisc: Remove target_ulong use in raise_mmu_exception()
>    target/openrisc: Use vaddr type for $pc jumps
>    target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
>    target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
>    target/openrisc: Conceal MO_TE within do_load()
>    target/openrisc: Conceal MO_TE within do_store()
>    target/openrisc: Introduce mo_endian() helper
>    target/openrisc: Replace MO_TE -> MO_BE
>    target/openrisc: Inline tcg_gen_trunc_i64_tl()
>    target/openrisc: Replace target_ulong -> uint32_t

Series queued, thanks!

