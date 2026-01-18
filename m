Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9631CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 02:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhIuT-0001Jj-P1; Sat, 17 Jan 2026 21:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhIuS-0001J1-15
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 21:53:00 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhIuQ-0000OV-Cy
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 21:52:59 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34b75fba315so1477500a91.3
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 18:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768704775; x=1769309575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RK0Xq3CK36nBPiaJ8q6UT3fsYkGCyOiRdGdwbQYuY9Q=;
 b=rFhq5f+0eSgffUm0X2R2BuPx0/rTnJvM5jiToHr/BISM3OJXE4F2fCDElX09UXfaF9
 5FOhJi457Q8nxd8gVOGNyYpUFq3j3amhQbYwj7Qu/Z9PC3cuvXPg3LSU8U9TUHniKhUy
 wFMSUnLxV8karHCUd4Zcx9JfVtinSuoNtYSS6/LErNQXSRclmRgYtcvnsSm7V4ve2dVB
 wLZwRzsrcyVZtMxjs/4yQmGIoepor8kW25rcn8EWQLvDyoaNrMr3VpNDPc/SgH0z18Zd
 Facnc5cH0eDKugaDV5ZHr2vQR5I+FKTsTXK3aD0ae3/pHTHRJscg9W0iKJB5JRQDTpDe
 VDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768704775; x=1769309575;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RK0Xq3CK36nBPiaJ8q6UT3fsYkGCyOiRdGdwbQYuY9Q=;
 b=qWPMMCmxUdjtbHZRG1d3xP5pdWFqHnoM10V2rh7YbpNKIgep+GCSt/PHsz+Yv8FPWO
 niTfRQii+OP/xSXhFagD7fvW6a0gr2/jJElsF4oxEU8r8RTyNusfFEu7pNy/Lvn7bIG2
 2cBZUseCBHiOwECPXxjPNOIUO0FD0R3UyL6JqLFFrYPGUt2vYSmL+zOIDq0vqiIU47Nq
 rQIQSrQWnofinmxXF1rHQSKZ6dlu7r+C3TxMRkikNAJosilE5Jiy0yWBl3KDtNw+N7AV
 46WRH2BDX3sZgtnqv4qdz+S9GlkSVoSZzf3NANBF6BLyHM9HrXELz5h2QhNAcdiAoI9+
 CixQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVCb8b+J9yQVCDSznqO4nCJ5BKD9eewyuFhylfsCnh26rgFZ7hXgxfKT0m2O+qNdwUbc5YlMIzhkRA@nongnu.org
X-Gm-Message-State: AOJu0Yx2cMSYQ3y+32ZhXQwHnwHr2BYtkGdlGCtsw4+HP2OdcSey+yH0
 e7mlEWTijE5Jr+dBhkLQMNQ1Pw1h0Xi3djBaKKbjZ0Cxa8ZwiRLkesaJn5gAv/62J2Y=
X-Gm-Gg: AY/fxX4OrRTeiI0VXyegbuIMqXm73i5pGZ9EfS9QSFMgaKpHPjqjY2oFs0J/eRT+rvx
 ikBw0Z2vx3nNqUoj+JXwHw6mHJjE3RdlMDQslVLKLzjGMOoMDbg9ma1WOfdoqMpCKB4dm3I+MFp
 Zfs4DAJNNU36pG4mV+hFVryRhO9EGAkdjoTJKFPDwUZJMzvhwU12wz522IZ5iPcEfpLPS4eMwg6
 Ww2TZcYyUZU/9Kv+YHmOxPhctdfsixwgbidjM2W9vpNAwTHJ4iR7Vmx5ylNdZGXcleOLIiijONA
 6+03YFTCxOO/QYKzGVKoWcPJvUtxi6xT7SPCVsWIF3vkrNGixp2jPeDOLrHvT2+maXjq1cGGEjd
 9RwSnOy++dxu5ovNQHVxpmr6Y+XMbnJIOj8Bf/OC7TI5aK9HogHsuPNFuZZ+w9DL2o6m4IU/yBU
 ZIAhJfp3MehcJz+vs5nOqtiwK9w97xAw==
X-Received: by 2002:a17:90b:4b47:b0:340:29a1:1b0c with SMTP id
 98e67ed59e1d1-35272ee0e7dmr7836663a91.7.1768704775414; 
 Sat, 17 Jan 2026 18:52:55 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35273298968sm3013448a91.0.2026.01.17.18.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jan 2026 18:52:54 -0800 (PST)
Message-ID: <c7711177-ac77-4c6b-9d07-14588edff5c9@linaro.org>
Date: Sun, 18 Jan 2026 13:52:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tcg: improve instruction selection for extract and
 deposit_z
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260115135453.140870-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115135453.140870-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/16/26 00:54, Paolo Bonzini wrote:
> extract and deposit_z are similar operations, only differing in
> that extract shifts the operand right and deposit_z shifts it left.
> However, their code generation is currently different.
> 
> extract is implemented as either SHL+SHR or SHR+AND, with the latter
> chosen for "simple" cases where we expect the immediate to be available
> or a zero extension instruction to be usable.  deposit instead uses only
> AND+SHL, though SHL+SHR would be just as usable.
> 
> To get the best of both worlds, introduce tcg_op_imm_match to check
> whether the processor supports the immediate that is needed for the mask,
> and if not fall back to two shifts.

Hmm.

I have a patch set that's been stagnant for a while, now currently waiting on the removal 
of 32-bit hosts, which delays expansion of extract and deposit until optimize, when we can 
see then input constants.

There's probably some overlap here.


r~

