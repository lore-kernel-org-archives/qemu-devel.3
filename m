Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE752D185DB
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoPs-0005KF-QJ; Thu, 08 Jan 2026 06:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdoPr-0005Jo-Fd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdoPp-0007dR-Rg
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767872576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LfQniR3YPWTg/wtyiOU/BUgL2JUzpXHzt15S+SLZcpk=;
 b=ROenvNv+VrSe4ZxDH3nxtXec9gUW3EhDgV8Lv+ssPLgcAhEx9/xQ4molw6spcGFyzOqgkH
 KfbMXJdKnL+j8NpLXM5MNNhE7+FeWLOz1Ddqn70aced0RLeovkPwQZkdwVBZAVnYjYKsaj
 DNM7zT6jOnGRdQ/iOegVEV4wgmmVe6M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-oloLIMVFMYSBM8hcc53cEQ-1; Thu, 08 Jan 2026 06:42:55 -0500
X-MC-Unique: oloLIMVFMYSBM8hcc53cEQ-1
X-Mimecast-MFC-AGG-ID: oloLIMVFMYSBM8hcc53cEQ_1767872574
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d17fff653so14679325e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767872574; x=1768477374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LfQniR3YPWTg/wtyiOU/BUgL2JUzpXHzt15S+SLZcpk=;
 b=CHvYF90+ECXIA1DUjua9r6g62Ypd2wga7URdVRdBCvAJXtqyY99A/J35ZZc4x7LFky
 u7GqnHabb8bzH+ojZYfmfhPEv4ovHxOjDTu/wnIibVzS6O6A3VPvBI2UADxHEL3dt9yh
 hgnrHzlGb/Izvm7+8zFvZ/6SvaEteFjFjF+pyUjSFMe2KfJ1h1xkuY4qYzc+pQ1mE05a
 altqlwPg7ndXzWxCjyCGmUQvU16h0i5TMAyenpq55Mum7EZQzuJhzf7d2LWJ10LdCGJZ
 gWneMRub5fJcz0sCmGZjGzi/cbCscEWzEueJo4RfeTmJ5uPEE4iPRfuU359EnvYRrwkq
 LdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767872574; x=1768477374;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfQniR3YPWTg/wtyiOU/BUgL2JUzpXHzt15S+SLZcpk=;
 b=AGoSWm1Pi8u63s76jSM6+Cz601bwXQpYPdgA1MbVYllNkYBZb6vufp3OrPCtyUjThY
 ZX2cz20k5ch25Gblu5k6dy21Kcu+UNjRF17boLjXGmCx60alg53EK/9Gr/HUYtNbFO8f
 QfsTTdZbylUuLduaHHva60OmOnSQi0JmRpf87W8SgfO2le0lHUEBaKjlfoSajxyDwCK2
 H48PoTaxQbuNemGZF8WEOIQtS3MbsUaYsLdA9JhyMolx5jpm7SKrS7CKmIvHO92xwfhT
 pgvciCNJ5656NTZcClWXhNUkhFbhYyvHQHSqM5GzUDJZSGDAoa1ypjQLQHF/edW6ldyE
 guCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMQeB10xegYtKy9/McPUfBNP6tLZ/SgRUAeuKug7JbvAbay4/nmGT47/gJf8ikFyLz+ZLXfSbM1jim@nongnu.org
X-Gm-Message-State: AOJu0Yx1g1efnWiRHCm4pXwgwrMKYbMUrlk9Sew5zXuChrdqPfMir02+
 NmAUblBb6wMLJDgldVomLXNXkeb/yLvxPw9dEujylr1H3vmGqxSIv/u3VDkGnpLsfncrpnDaWW8
 3NJzD3yrdYlIrrC3Az8sgkgeTRbZXzVCZ0zDGUe7fErRH+mpZ7OqtE9mD
X-Gm-Gg: AY/fxX7yQxlA0FRdrokIvkRo/KXVvQxztvj2F/U7ZQ5Q5f3bDqOzlt/xeDYySi4C2++
 jzVjZ/KOpoZaYRG4rwvzxH/yXoLIWSpW1J+NIjCubAkqWZ3QFs2r9D7aqE66i6+9NUAqGoK+0LM
 vlGNNzAxoknwBraQH9rIYWwzPn6No6kjRbTtWg1p6/BOlWvYAeKeupzwL2G89SMZJcXOSA41Eqn
 IGsy+6B9978UURIRgY0WNrcIKrByVMdE3Z0kuFNSv/r8+9IOQ3wNblg0zQDMMZasHtuEBxbdJEm
 V+z8AorSFbBUOeoWkN/+I5Sx4gon3O2PDeKbzr9GgSVXoqAMxRFZFo9isCFfJpypho1RHmbvBZc
 VqV9GjQg=
X-Received: by 2002:a05:600c:1385:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-47d84b0a227mr64238865e9.4.1767872573963; 
 Thu, 08 Jan 2026 03:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsbXWzBJMpi53YpF2fBaIw2bJG+pG/LOn8j2ifCffB6AFnIHOnZeX45lr+cx3zk+JRUnHXmA==
X-Received: by 2002:a05:600c:1385:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-47d84b0a227mr64238665e9.4.1767872573624; 
 Thu, 08 Jan 2026 03:42:53 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8717d9e7sm34030335e9.8.2026.01.08.03.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:42:53 -0800 (PST)
Message-ID: <09a03346-c3ca-40d6-8e65-da114b3d0606@redhat.com>
Date: Thu, 8 Jan 2026 12:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/50] tcg: Replace TCG_TARGET_REG_BITS / 8
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-18-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/01/2026 06.29, Richard Henderson wrote:
> Use sizeof(tcg_target_long) instead of division.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-gvec.c                | 2 +-
>   tcg/loongarch64/tcg-target.c.inc | 4 ++--
>   tcg/ppc64/tcg-target.c.inc       | 2 +-
>   tcg/riscv64/tcg-target.c.inc     | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


