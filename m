Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9517DCCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v93gN-0001Uo-NL; Wed, 15 Oct 2025 11:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v93gK-0001US-2j
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 11:44:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v93g6-0001MO-VM
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 11:44:51 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-339d7c4039aso5958072a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760543066; x=1761147866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M8MafHlX331yXv6ySIjantT9b210yLjf/tunh0P7I/g=;
 b=K7eMOlxKuSN3bEL+hgBM15H1XtCVLmQh+Dc0cIDbg7E0HCZ1JBNncZSlqdg+BS0JJ8
 B6BZ1sS7Kj+nFx/6XROtd24PfOpQ67lJB9vDmhf0F4qrltDd+w98JuB9lzLg6JF+uJlR
 J8pX7U0oc7tEhvZavLYJQCnJjziLBtjfrdoJVqVD5wUS4oUrZXWEGpUzAjFizXbpsdjO
 7jIEl1Hors2+jrAuD7BfnHS02qPDujdUuvtV89SIQK9k3zJ3eh1mSPscxHKVKJrDEzhs
 s3qznCCnze7/hJI9DjQjzVt8wxo80csQCEv+5/D2Az7wUqCOb6NE7caZxpnjkKvLtkvC
 g6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543066; x=1761147866;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8MafHlX331yXv6ySIjantT9b210yLjf/tunh0P7I/g=;
 b=R+3Rt4EKyvatIFybDHNlhgAqcIRKWj+u0QfNbPyBX/Sg24eCiQv62mxttVNEFjNn8g
 0TGIMdzA+mKZJi53+k2Gys9+Nfat/4iNSGV3IThsaheLaNMRwfk/lmr1JOEQ7S5Kzpy6
 DghL62A35Xm/Qk88UBxNu4YnqSQrLkZquyIFHA1ntrqwq5IyROMcpR7htbnH1aax5/Nw
 NX4aArwFDeNLTeImTSzPIJ7UrL6Lh252UiF5sjG3zSmhlSrEd4ez1YExV8ja2wKwJEtr
 TgiZm7Rv8c5UaoZ/SUaZr3ao/XD6hItdomXYpLqZ9WdzohYgBtOW7tjMbVjiOpJBYUCV
 j6LQ==
X-Gm-Message-State: AOJu0YwzBi2T0awwd8wJr1HHcbbnt+XwhqWvbGPQOnFcR6Dfj77tEOdL
 YfdbznzMRSiLSvVURg7/5OGlYgdAgRiWNOcRfotycg08JM7vM4jIV7MSnw8usL2S7F/RS3BLjLJ
 1QjCHnac=
X-Gm-Gg: ASbGncvQLY4eAKJK1KKknNHfqvKOGsHPPTVmBVQCexS+GevM8lPKtmK3+U9VGxVAxnD
 plQ5IsK8DwHGkV173UyIucE+QLAUNsEngw3Q1CiblTc1cRN1DPkPCNB28mhuImqvfL39KvneSaa
 0FMTyH3QX1FrzzfObjCGnA6TJ+r5k6CcQNw/mKLpHUIgYDDJEnVRhY1pBrYkxKCQnMPCOz4PA4w
 mH/I/vzry6WXe1wlKaNq4K1rMFrwH2KRKq9Zna2WxJy3OlvcCTyJJveuoRv2HYjYOUDMhVO4PwI
 VtJBMrQ7aPrKpb3vPW2ZBiUpbCG6IXLIYo+wjbRpFtGV/59omeP/K3GVLDN/jljqlHYXvdHm6sA
 O5YJxus2P+3WDwOA6tgncTujSZ912tkEB0D4VuL+mevM6E2SkwGn2ec7bW7oorAtJvjU4SA==
X-Google-Smtp-Source: AGHT+IFHNiNVYxmFg8I/LDvXx2ronbSJeEtJ5fZKIIQhqF0HQC7qBYnUZ3ncPthZ/B2thyQnALnBVw==
X-Received: by 2002:a17:90b:1d10:b0:330:84c8:92d7 with SMTP id
 98e67ed59e1d1-33b5112973dmr41396758a91.12.1760543065990; 
 Wed, 15 Oct 2025 08:44:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b9785378asm3049437a91.1.2025.10.15.08.44.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 08:44:25 -0700 (PDT)
Message-ID: <0e31c19b-8466-4c97-b1e5-85ee6698abc1@linaro.org>
Date: Wed, 15 Oct 2025 08:44:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] rcu: Detect accidental reuse of rcu head
To: qemu-devel@nongnu.org
References: <20251014191944.2225735-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251014191944.2225735-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/14/25 12:19, Peter Xu wrote:
> Peter Xu (3):
>    qht: Zero-initialize qht_map
>    tests/test-rcu-*: Zero-initialize allocated elements
>    rcu: Catch rcu_head misuse

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

