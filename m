Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8E2C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJo7-0000vm-HS; Mon, 17 Jun 2024 17:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJJo3-0000nH-4E
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:22:27 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJJo1-0004Uy-G5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:22:26 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70436ac8882so3600975b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718659344; x=1719264144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y36ZiYqkAIJ6fWa4QGmtNTHrqRiR/+P64PjK5zzGgCE=;
 b=meMTCMX/t+WgCD8ZU0RLhs5ul6+7CfGopPK9xbpQm2gzCIVsQT6oKx4WSzGbfJUKAW
 9jXHbQ4cmErzgI/7XsgqAz/X3vgoLeLITmPFzii/3MnfEgf8V7MTqYg4mL/uOnbD1TI8
 JSh1B6ENFjz2zaYY1TVqJwPj5ni3ApmhDNsN6Z4pfOIYuIp6uU08eQeneYRRZzRwwrtQ
 WE6CMonOFoL0yts2cPbJsSpnYfpcDA1EMijsDNiXLXopHJ0IeXfNkjWZs/0PsunzmUg0
 LPTvMG6119SfCVTw6Wn5DHbf7+idjfmkMO1ty78hvkJstZygnYG+Z4QuRiot2fQT+14r
 Uyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718659344; x=1719264144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y36ZiYqkAIJ6fWa4QGmtNTHrqRiR/+P64PjK5zzGgCE=;
 b=t7+wJyJjsJHX81+FwBKaeIHrn+tUxYqP8gK/ov1xu8uyS+DK1fSy55eycV7dlZW5fk
 C80WdNLmYib3xXOhrucyF1LFg0FX4//4ZqLKJ/eYstCB84Bx9SW9csIMakhtXfvKI4L0
 1bYk6vacKReCLHklK5iDkEElVIdgM1f6D0cQ++QPp/SGwe6iQFQ09l4P7ckJF2keBVFn
 vn3+qgJ9CC8gMpzczr+pEJS/xtVHLDO/uPJI5TK7UIUn3QPidCUSHUSrKWqodVfHNTS2
 tC1TVwfYtBADBVLZISRyDJToexlPAJlMTHNb78Vh+sEuJkZisphNj/VbG0JiSE41ZsKp
 TY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEaCOUmtXPvTZTZ7lRNKXGSdbCASaZvLwB/gIC9plWcQVTImngcT/9bvbMDLzJiMdQdZfykWg+iEvxQDxJrAu2DjTRXSc=
X-Gm-Message-State: AOJu0Yx61NnrMbfII/sKgFaApRpOmpP4ECMdyCK+qp7qre3F46fl9SZA
 tnSa/huU7DX94L0mmTOJFC/oPaDYoWnJ1/YEkwRhzBXdYHcoINRa3BmXtEkm10GTCdlMur3ANdq
 Z
X-Google-Smtp-Source: AGHT+IHnAXhsqCqB9GO0DkyjIITvRSmP4Xfc9KUtbsxk7yYTg0wBLg77a3KKYDcmZBBpMIl6XosOiQ==
X-Received: by 2002:a05:6a00:1817:b0:705:cade:1f50 with SMTP id
 d2e1a72fcca58-705d721898amr14778672b3a.34.1718659343653; 
 Mon, 17 Jun 2024 14:22:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb91b62sm7759672b3a.203.2024.06.17.14.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 14:22:23 -0700 (PDT)
Message-ID: <e54bfcdb-d0e9-4e76-9451-e457546736ec@linaro.org>
Date: Mon, 17 Jun 2024 14:22:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Dirty page rate and dirty page limit 20240617 patches
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
References: <cover.1718638495.git.yong.huang@smartx.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1718638495.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 08:49, Hyman Huang wrote:
> The following changes since commit 05ad1440b8428b0ade9b8e5c01469adb8fbf83e3:
> 
>    Merge tag 'virtio-grants-v8-tag' ofhttps://gitlab.com/sstabellini/qemu  into staging (2024-06-15 20:13:06 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/newfriday/qemu.git  tags/dirtylimit-dirtyrate-pull-request-20240617
> 
> for you to fetch changes up to e65152d5483b2c847ec7a947ed52650152cfdcc0:
> 
>    migration/dirtyrate: Fix segmentation fault (2024-06-17 23:29:21 +0800)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


