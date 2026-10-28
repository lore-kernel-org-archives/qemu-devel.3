Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB2606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lW0PtfDn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM77X-0001oN-85; Wed, 28 Oct 2026 13:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM77U-0001nf-OJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:07:24 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM77R-0002nv-3N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:07:23 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b05bf699easo12989057b3.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793207238; x=1793812038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f3tyY3jvlZy2VDzI4QwOHeE2/gts38cVyVdTaCHsmRU=;
 b=lW0PtfDnL3uxC76Xal89FEhT3/iXiHuBLaJccsZXsdQGIdljre/UqtwVXCReYvLhgu
 +5naApxLYbiBhbgIn075XUQE1iJNzvl6QnDzu+qPINQD7LsCnG7z34GmvjnFmOfAS9Pb
 nwYHKWsDHh2ZICn6cxE7XZAk2fYgxYBo/cPrhNWgTe9C0Shed1TN54opJmWqAg/2WgGB
 HhHkqYyeHPQdM1KDn97dYdLfOA9rI7DaPsj1dyreDyNLnMvgdz9/Ij5CNMQeZow/zeTk
 XijcntongJyZ0vfMARtK7Tki2H0XoBu8VXf9eIBbYEwnGNM7zz6/2/M8XMQyhken9yzg
 WHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207238; x=1793812038;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f3tyY3jvlZy2VDzI4QwOHeE2/gts38cVyVdTaCHsmRU=;
 b=bM++a7ZGjG8PQv0Fw0T5C9715GiDQRAQJ1PIL4cbMZP9GYciB9IpKWVRxz8P5Dlcyz
 1CpJAC4FI6b9EVZTalTbeje36MpNeZL7q83X4Wq4vKn1syJIcNe6Bz862spzdS5+uAzp
 jWgUQOsQgtNqJbIhFq0ETvz7mB+ZpyyGY8393nPyKEScPAXaYSprtpLi30rml8zFfWkc
 3ArEabNSs0LLHFep+bbLW0q6K83GTd3Iw2sGqQ4reEeSyJL+gFmg8wGFsGKr9HqnSJkp
 JCU5Jx0yZp9keH7vIHfKkBri6ogG7a8anoi1pnHQTnRw/5twAplsG7KtvzR1yFj+gP/a
 QRlQ==
X-Gm-Message-State: AFq9FYK3h5/Ofjtgn45YUAQLEnXp7uOuPwEMerM03ln8ZiIdSA1jNwWP
 MrKyUTPWDQHQYgzuaZY4IC9Go5UxAwWRbVrvAFY9ZIFNg60XmV1+T4f4cRTeRxW6xK0=
X-Gm-Gg: AYBFou2Zpi0zHD5nUgnGUpREy+fESbeWcazAAFab9a+WSJd6QRtVL2+xPAOJ/xxiXHa
 ttzQ2AxpJ9okdFyPe/EnbHf+YK3/s1qyapiuAgh2+rDufiGfmweBgCSn61tV2KoFzC/oI2G0UIE
 QN3F7t86cHNzEAOjYRvmeni2OuGE4oEad5G+t2kAUiQOBLRUpuM0ewpiNmJmuMYLPK6uiZvI9Hp
 laXuUgYbGVG8gTbgGd9PPIyI1z2s9IVVbQdgn3wVKHjBDtXOzQr7KXhlEEamArudHqMT302R5wD
 Zj3GcOwFYGkJTwe9UYttlk4RN/dLT+E9yD/5LO/4yajtqmpghB7TNMEHalaKOGNOFK1JqR35wUW
 01Bhn2RzTk9sdsQqrdL0C6yCXPVARws8PsZrVsJi7zszoAqCeaSswVDmvHtIO0erG5WudVtg9MQ
 MiFSvY6jum6lf6DU3nsDDtroSNB52pZmmmA0rXgA2OMi5GNPeR+dw7v72JZYH3fFT2ZxLQh2DW2
 tyBkMCIopa5I97YQ7fWPdB5QpWVQmRv/LpuVM32qUoC3ORSM+4qhyGYXO9a81XYU54tNJ3ERYnu
 +2StXE+HIsJjw/QpXyRJ0+gpsnrX4pBfMqXHWFNL3XKqbtmqatso5KdjocRkHDrsWLHKmL9De9X
 3zTed+yO3djw=
X-Received: by 2002:a05:690e:4852:10b0:677:c582:b1f6 with SMTP id
 956f58d0204a3-67a7bd345famr1181205d50.72.1793207238260; 
 Wed, 28 Oct 2026 10:07:18 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e5bdd05sm31959047b3.28.2026.10.28.10.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 10:07:17 -0700 (PDT)
Message-ID: <61610def-983d-4672-b9e4-73e12636bdda@linaro.org>
Date: Wed, 28 Oct 2026 12:07:15 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-3-richard.henderson@linaro.org>
 <CAEdQ38G13HN0Le+sSmVXsv4WHYBD+-sM-VPAsYiEKgE4Qx7MUg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38G13HN0Le+sSmVXsv4WHYBD+-sM-VPAsYiEKgE4Qx7MUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1133.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 11:40, Matt Turner wrote:
> On Wed, Oct 28, 2026 at 12:32 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> +    if (sh == 0) {
>> +        tcg_gen_add(type, dst, base, index);
>> +    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {
> 
> Shouldn't this be "type" rather than TCG_TYPE_I32?
> 
> As written, riscv64 never emits lea: its TCG_TARGET_lea_sh_valid
> requires type == TCG_TYPE_REG, so for I64 we always fall back to
> shli+add and patch 15 is dead code. On aarch64 it also rejects
> I64 shifts of 32..63.
Arg.  I fixed 3 of 4 instances the last time around...
Thanks.


r~

