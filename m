Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46164C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrHq-0004bB-CT; Tue, 28 Jan 2025 14:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrHi-0004Xr-LL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:30:07 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrHe-0004Md-Ri
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:30:04 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so10328218a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738092601; x=1738697401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5zmF0Lyv9/g2tkR5fdmKknYAOOxxSFTebSKafTWq1I0=;
 b=uYHfDklEwDL+DRKGBPzMS5/eHaJzvmGmFJaFTIxBf5S6w92oav7SqCamRa9Nq/LHyq
 NwdR0EzXWbS/1PsF2sAbHFASquCMo9F+SNEsqj36vbKMplwGU6x7PQUHrDdpVeGg2G0/
 CEoEsdsNnO7LeF5CPvcMdDX8KEQfG1wMHnuGSSFKgLuSFDxVDHiWizMgA7EJLuY48jER
 +5wyuEUDSqOLroIyvqE5n+demcbn7bb9Ijs7uUNm4YD8flKUTgcc26p9albRfMhX0fzg
 PxZU4QmD3yep7A+Sp4iiC4r6cQyY98a7QTFPt2lH/7F5BJdhLIaFTk2/fpfib/L0kbqF
 +dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738092601; x=1738697401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5zmF0Lyv9/g2tkR5fdmKknYAOOxxSFTebSKafTWq1I0=;
 b=J4+Eza0gfBRbTyuySescsvUGQamIkDg5MoTD0Iz86RWbvuo4U5oB/5XI/lkFFo5dLl
 zXsZpkt9Kd7+XpL/yaT4OUHj3tcNrLNFHu7dUBVRZf2wVqTWXx90wlq8DNvJZt1NtoQO
 gHKOUC00h3Wf6sTZ9mmqscWwz+/zAzD7AiKzEH/sT+kBTDUoEAxkPB+vSOZFqRQY7SZ6
 mpU9mETZ34e3YYc2WmcjSlIbM5imIWbq0jlwv5AsxPwX0qMrWN/a+PXFZL8+QqZRGCfD
 knY8egkR7zoQJvdprWW/MGHXUmBlWwwEQBbai7axigQPwap3r8Duf3pKR08bz92tZWhD
 vGJw==
X-Gm-Message-State: AOJu0YxYP4r4V6a7cc0//lAPLIBQ23lnesHRzSxJ8LqPQKTgnijJR7Ks
 e/4SrfT+JpnqfuOATNkmUTmyyxbWsRd6s2lMdD8qQMLqTmOYveCLyQekN4zZUU3o4HGr6JQOrQ5
 h
X-Gm-Gg: ASbGncukTRblbYBGGkfRpWm1DVLimr1CkJQ513Tu3ih6P0NKpSL7DMeTLkfc2eU7Yl5
 DO2mWtP+SdplbMsb2tcjmm8nbAH464RQ2djlmbkSaIhsTSi9qC39ziI6ZQr7mx5atk/IJd14tHp
 CTD/+BNgV7FY/LOn+mQ5DSv/e844U1+KSUq0JIJK89iNynP0Sj1oQPEC/VhGAXsr2MrD8/x4oqm
 Gdsz1/zrCDYr736FjEQscwRQcyk3Qe0pXtbzefzgpa08LFyq8S8PXELCM6MDPq31lws0VcbdIRz
 wvZjXWyss8quZoNG2ySOHvZ14B3Vfcv5LmTyyChObP8Wq6CK5ABZmsFDdntIH4JEZ0y0
X-Google-Smtp-Source: AGHT+IHY6IwO+EXXkFUTpKs64KTPpu9wuY21QNcAEeFroKzDQJ2KmQdq86NGLqmxyT0fTniboRcuAA==
X-Received: by 2002:a17:90b:5146:b0:2ee:c9b6:c266 with SMTP id
 98e67ed59e1d1-2f83abdf1c7mr306131a91.13.1738092601215; 
 Tue, 28 Jan 2025 11:30:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa83d7asm10805992a91.48.2025.01.28.11.30.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:30:00 -0800 (PST)
Message-ID: <aa745382-40e4-40f6-bec0-4012626f1fbc@linaro.org>
Date: Tue, 28 Jan 2025 11:29:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/qtest/migration: Allow using accelerators
 different of TCG / KVM
To: qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-8-philmd@linaro.org> <87ikpzt1xw.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87ikpzt1xw.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/28/25 07:04, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> There is no particular reason to restrict all the framework
>> to TCG or KVM, since we can check on a per-test basis which
>> accelerator is available (via MigrationTestEnv::has_$ACCEL).
> 
> The reason is:
> 
> CONFIG_KVM=n
> CONFIG_TCG=n
> 
> The check is about "there is no accelerator at all".

We perform the no accelerator check in meson.build on a per-target basis.
So you'll never have a qemu-system-foo binary with zero accelerators.


r~

