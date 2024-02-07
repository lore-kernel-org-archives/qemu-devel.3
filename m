Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2084AC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 00:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXW14-0006Kp-4N; Tue, 06 Feb 2024 19:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXW13-0006KS-5A
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 19:42:17 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXW10-0002We-W5
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 19:42:16 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so18465a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707266533; x=1707871333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30DPEycfmWSXCU7TDrYySe8jRD3IsUapg4uPH/BoFWI=;
 b=KF877FoKEAdxYeVR9cq9mdbIJmAc73zTHkZjpDgrIk16oTDR1Mb36AoRRqeiGkGGso
 4m5R0TkteU9Cm1v4ELfj08E0PhH44febCv8XhaPCb2Svqv3RXExNooYbvmJfJl3H3eAp
 up5SAFL77mblXiSVw9clCTc1X80od22AwjIc0QZaRvpWCE7coMjpIM+GpuLQFm557K8h
 R+SQs5V8zjsrOKpzewkr93X2f6CNtguy1xhTa+F5/L2CCghpkT7wqXpUQmFNOO7fd9ax
 hwaUCZMtNgBSd4QNfLDbEd6ESw88NOWa57fa3Q9EqfGONjNx/R71GdQRYS3mTr4pFYZ2
 5TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707266533; x=1707871333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30DPEycfmWSXCU7TDrYySe8jRD3IsUapg4uPH/BoFWI=;
 b=cbhU6S7VU6Aq5yRPtDPfkSgfkzm0325vk1+pzkIbaFdTdtWS7J+ZFNeGFzNO02DUl5
 AYBrQK6QnlCPlBj2mi/kUcSToeQKN8q+1MJJvDY1jRboYku0+G6IydFiKX6u1kDWv94p
 Ut/Py6NbX4oBSIZqee+F0mlgddHSlEs8qWqwOOemD1UmxzsvQasJuQSD2FFAZyYh5HN/
 2vqtUP8T/ZtndnYMFTvXpIc+2g5ywkM+zFMSgM+FZQ4HKmmNiErPMVLPLmnrmt6uonNv
 aitymLAqnPIocwZJbwREEHr2m4JPinFKq2BOXIuYz6hY2OINhOjcYRxQa+/kCdtVyQ1e
 7E/w==
X-Gm-Message-State: AOJu0Yx+V3Clhidc78c6R4Ro0ksKKP2i2iFkLmWSjaaNLTp1dYv9LQO+
 S881QuifGDTgNrGJ1VCbmEtfrNcBm3yEDon2hg4Nnu+MfJ6RLYIdeMfn/bURqi0=
X-Google-Smtp-Source: AGHT+IE8WB3uZtetV+WK6MTasvnTB82xj/RzzIL/wNyMBoXzvJfWNUdgyyH7Rhq7NAc25bvGvf0tGA==
X-Received: by 2002:a05:6a21:8ccb:b0:19c:8a24:82e1 with SMTP id
 ta11-20020a056a218ccb00b0019c8a2482e1mr4010128pzb.17.1707266533117; 
 Tue, 06 Feb 2024 16:42:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ZQE8LWx92nl4A1DoJspdDtwln5T73PpSQePQRmdqkwa0/I/znm+d2UE1gCNm+Xjp7QTZ4wO98/ean9zfNH9Ux8Of4ZzbO3UN3Pdt4RhXbfx7kFHuoBO9tKeI0mgkUglUIGKUAdnY3bxgMyNMJEV9lulIsCGw
Received: from [192.168.0.100] ([43.252.112.155])
 by smtp.gmail.com with ESMTPSA id
 ie13-20020a17090b400d00b00296540086a5sm2406332pjb.23.2024.02.06.16.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 16:42:12 -0800 (PST)
Message-ID: <013d6bb4-1021-4c33-8b03-dc01a62d8c03@linaro.org>
Date: Wed, 7 Feb 2024 10:42:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/arm: Fix nregs computation in do_ld_zpa
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 qemu-stable@nongnu.org
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-3-richard.henderson@linaro.org>
 <CAFEAcA-ZNwm=OJ6u+e57kyRFnjyR+Br=ZCbOodbQwBZzrjVnhA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-ZNwm=OJ6u+e57kyRFnjyR+Br=ZCbOodbQwBZzrjVnhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/7/24 00:46, Peter Maydell wrote:
>> @@ -4600,7 +4601,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
>>        * accessible via the instruction encoding.
>>        */
>>       assert(fn != NULL);
>> -    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
>> +    do_mem_zpa(s, zt, pg, addr, dtype, nreg + 1, false, fn);
>>   }
>>
>>   static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
> 
> What about do_st_zpa() ? It's not obvious what the 'nreg'
> encoding is in the a->nreg field in arg_rprr_store, but
> it's definitely confusing that do_st_zpa() calls
> do_mem_zpa() passing "nreg" whereas do_ld_zpa() now
> passes it "nreg + 1". Can we make it so the handling
> in these two functions lines up?

Yes, I think there may be a bug in store as well.
Comparing the two is complicated by the cut outs for LDFF1, LDNF1, LD1R and PRF.


r~

