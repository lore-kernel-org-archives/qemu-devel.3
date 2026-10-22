Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CC606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NkYj1mhP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqNA-0001cq-1r; Thu, 22 Oct 2026 06:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJqN7-0001bP-9i
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:50:09 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJqN3-0000ds-Qw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:50:08 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso251474666b.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792666202; x=1793271002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6dJgUIAr937ULoZCwHqanoDo4JFDo6siKBpOeUPBQEo=;
 b=NkYj1mhP7Xz9xZkQ99YSOCY6Q6p6CJsDt2/rwYnbvN9PrCQigCozMqGHDvj29iLKng
 WRQf90D1z/GRfBxx5/AMO5BeFWg+BSEu97HJlDIl/ePPmIbRk+spSCUUWvWkY+1lXOsc
 3APk12XJ3EbJEcHxoxD68jvmVMWp8L+Myr4qhQ9N/Snq12ZoWG5GeWGgvzYTT/31e7+I
 V3KLA8sbZvTOvJxkuA3cyfrHuIrIuWN+VwGZFuzhTCr4Cc3ViZo9t8jB4YxcNkOzONie
 QNUyyE5H3vf2DFxoXs2Zhx2Xl2JNJSI9SaTGuKbnJEkEx+wnzB+Ua9GCYIl4ZYIbCyfF
 NYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666202; x=1793271002;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6dJgUIAr937ULoZCwHqanoDo4JFDo6siKBpOeUPBQEo=;
 b=GCQyyEg6chrJiiKAR20uTi3XNdWBrKSYZQAnaAGaBwdTmYM49ahsUs8St31sRfxE+1
 Ao3SlAv5A1rXCJ/ANx81anvlG7gOjFzV30D/U8Q7UWNc+tZ8x18FteFX0J+wvO0nAdGB
 SGZDHOKmNzUOg/tNo/1dgh+X04dB+FFc4+HiFGkUM6+qoA7IvTEJdYeQ1gGsQZA0/nS1
 YLFwxeFX3vKqMxqmhNzHzC1p8VQsbC0GruReccdQay/tW6udy/S+W+LjwqY6SDJn04RG
 KFPu3g+JabAWKrIt1Yu3tLidRddW+YLVWCZbSll+97mXz8dm3jdBPx8NdA5bTivy0Wpc
 TEtA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQpa6+lwEtNVXrmCdkUMBlBz+fClj4M/N6J3NMTlZUwns02H9bcydFK3coKzXz2C4+PEqVIK2KnIgO@nongnu.org
X-Gm-Message-State: AFq9FYL8mdeGWwqe83qny6eL8hHyK5MjoVDCiuBTV0EyZxUyymq2PMb4
 ejDWAgSMqS3FIKVVbalSC1EuK7FqrsCRt+ImFeliZjXvyzc94Zalfda+eaw3his5sHE=
X-Gm-Gg: AYBFou0t7xp+Cr+2FdM4/1wvbht7knJTMX2sa8FyreGO0Ec6im0/dJfiJXZOA6mvkff
 Mi+K59/iL74TyobVFlwUPYijt5cKwTSvAApGgMhSSmTiF8ecBjOROr8P7HGqUqC4rgpoxsmZh5Q
 SzVxn0wTK+wNNOl2gX3srxw23u2M+zL9aqcsMzGX9RqkPs3S7y5wJcsPWsibl6XGr5MAStp6cmB
 KZ0YQxMyJm6ULvzGt7vJsUwqk3KhJJ+D+hphISCZFUL1BB1xLRa3zTNL1pAzwyEE5E1+m3LqfKd
 TVbpGrtGUF6r5UL6AlBxqMdPHX/huygISQQ9iIYAUHtD8BphcRsdRFnsrahE0Es9t0IWwQ+2MZT
 BzyWyLHynrm9RwdpWzanjZOwRkHI7atfHy03CKQXRFLH6hhHMTpEO0qzlDm5DT3lXZhcyKy3D/w
 Xo1Y3qUYrUxLq/Hg/tmrDGkxNs9tEKGbw2K2OOOW/hYII/+1kF8lt+jTByLNLCjfvqMiWrhqGov
 RMKwVzQfJEpn5qbUG/QS2diK67OGI7QmLIJ3ltZ8Uyn7hshUF/nLp/7JK8ZQVK1Th2if3OfOCVG
 UEcUnI8MXiAjpFvdYdVuJUsJmywZJGEmO3ZlZV/2sBWvUF6c8aRSg7pmBda8
X-Received: by 2002:a17:907:7ba0:b0:c33:ae8b:817d with SMTP id
 a640c23a62f3a-c4679746245mr516041966b.46.1792666202425; 
 Thu, 22 Oct 2026 03:50:02 -0700 (PDT)
Received: from [10.25.47.227] (195-200-20-154.mclarenap.oninferno.net.
 [195.200.20.154]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a5102cbsm89608966b.13.2026.10.22.03.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 03:50:01 -0700 (PDT)
Message-ID: <236dd2b3-1d2e-4561-b3d1-cb4409f9dd9d@linaro.org>
Date: Thu, 22 Oct 2026 12:49:54 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: fix pmp sanitize error for x-rv128
To: Peter Maydell <peter.maydell@linaro.org>,
 frederic.petrot@univ-grenoble-alpes.fr
Cc: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20261022075219.312757-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20261022075219.312757-2-frederic.petrot@univ-grenoble-alpes.fr>
 <CAFEAcA-rw1_a5q7jB_Rx3KoH2_aPE48odM_99kx+Tz_J_LYw_Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-rw1_a5q7jB_Rx3KoH2_aPE48odM_99kx+Tz_J_LYw_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 11:16, Peter Maydell wrote:
> On Thu, 22 Oct 2026 at 08:52, <frederic.petrot@univ-grenoble-alpes.fr> wrote:
>>
>> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>>
>> UndefinedBehaviorSanitizer reports an undefined behavior due to shifts
>> larger than type in the handling of the pmp configuration registers for the
>> x-rv128 cpu.
>> Adding an "i128" version for the functions accessing the pmpcfg registers
>> to properly handle the 128-bit case.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
>> +Int128 pmpcfg_csr_read_i128(CPURISCVState *env, uint32_t reg_index)
>> +{
>> +    int i;
>> +    Int128 cfg_val = 0;
> 
> I think you need "= int128_zero();" here, to avoid a compile
> failure when Int128 is the struct type rather than the compiler's
> native int128 type.
Yep.  You can test this with --enable-tcg-interpreter.


r~

