Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4053FC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 23:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roX37-0008U6-23; Sun, 24 Mar 2024 19:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roX33-0008Tn-NB
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 19:14:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roX32-0006TI-92
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 19:14:41 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso3082061b3a.3
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711322078; x=1711926878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v5UhGMdnNONA7I9apxg26+dqxT0YlCsG7D5Fuet+OlI=;
 b=zk8zmngyqVlLTCGzq2k41lW+Rd1NuV0s+KIyeJ2L84X8Cn1yv38KRkDeLrR6Zw6kHk
 IvvHTGNFBhtTar4/pMP0qTZTxML3Xag6ZRsFInp7JLopkjkfPTfUivG8tEImCk1DeO0X
 c0c1FijOGwdIUNRu7lmZXoeLsOLGUVvupKe3ihI6r5trbjMlVC0QaUqt+d0M+w9zn9s5
 OL1jv4yUil9nqR/IZj4tGwTZGDe4M4x7dSsr2dDF3RrHej1Bo96pY6S/0YwUIkdrG2do
 CKiIF4K2pG9+9QHRCOuyHLRXDOk2rCUVuf9RfVwnXrkKrT8rmc/qfS0ZkwmQTsia4Xra
 rH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711322078; x=1711926878;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5UhGMdnNONA7I9apxg26+dqxT0YlCsG7D5Fuet+OlI=;
 b=g9zEi9sr9k87W4a9tDOBRu0ejaWmB3IaZ+AoFOd1z0mLUNKrYv13xJefB38XjADL2c
 JOelNwODzueCQh67nRXh7e7eNcopYrow752NL282jeq1ZpEW1+h4mB+OOft/257LsMl3
 +QhLF1M/P4ADo7l2+5/PS/IDjfYvSKwruE7EhweCaxlm4vIJxAsWPSeNDd6u+KE2OqMy
 03hMTViRx84FzwJvEqAH8fcVHkSSjM6h66l0CBLwggfAtGdNi05NTkPTRiSppWu48bBv
 PESmQmb42Xj5e55wUY/Lgw6Joa62PPqqK9MFbIAidK0sfZZuy3+7w2iSWRR7ozsux7QX
 UsVQ==
X-Gm-Message-State: AOJu0YxsRZA4ZLbu4usnCqCkV3iVQcu8zqXxLzJp88SnZFLOfSryAyX7
 dOpV3JIBR9b17Dmt5yl5LVH3bbDMoAqR0kA4RGAFg2i0FUcdivPT1wVqg408rs4=
X-Google-Smtp-Source: AGHT+IG45n0hXZwYZ1tCZe7tOlVCM3aMHyLdslzIZXjL8UMmTqbMlucmjwfvoIyeLD2DZUPWUdw2sA==
X-Received: by 2002:a05:6a21:6315:b0:1a3:b93f:530e with SMTP id
 wu21-20020a056a21631500b001a3b93f530emr5430582pzb.23.1711322078652; 
 Sun, 24 Mar 2024 16:14:38 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 hy4-20020a056a006a0400b006e6a16acf85sm3119611pfb.87.2024.03.24.16.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 16:14:38 -0700 (PDT)
Message-ID: <7785c89b-95eb-4b56-8fbd-5f14fba7de08@linaro.org>
Date: Sun, 24 Mar 2024 13:14:34 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
 <87o7b31nhj.fsf@t14.stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87o7b31nhj.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 3/24/24 08:41, Sven Schnelle wrote:
> 7f09e0: val=000fffb0301fffff r2=110e0f0000000001 r1=01fffffffffff600 phys=fffffffffffb0000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
> 
> 'val' is the value constructed from IOR/ISR,

Is this byte swapped in some weird way?  I do not see how 'val' corresponds to any of the 
addresses we're talking about.  From here, the string "301fffff" appears to an 
out-of-context grep hit.


r~

