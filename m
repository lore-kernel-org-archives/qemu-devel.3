Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ADDC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2SbJ-00070A-1p; Thu, 02 May 2024 05:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2SbH-0006yf-E4
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:19:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2SbF-0002yi-QX
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:19:35 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso1003239466b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714641571; x=1715246371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e25XlIJbSioeHagDL8/kzm2Nd+PqpodTl56gMEOQ6kQ=;
 b=mHAeDGTvlVaSF5yq1THCRTN/k/Hxkt94+FCc0u/DfZCiQiHTyBCPZJSPI0Z23otrIy
 +fPsJU3QEm6/RFrbW0BuiJphSNCTcct0RFOW8/qv5gO+pFd+XRNLRH3TyTKHd7jPw+/m
 FCTa25FB4ct+ZnVv9yEENdNXRbcd884xb0VMm6nyoJRmGZ0CQvCqqHgFnoMpOZw+LVKD
 pe4NXpbBXUSjVkZ/5JYVJYgD0qqOrddn/ukWwwr3Kb2ocDZ5Wv1I++XEe6RJvh/Ld7T/
 8PmmRjTwxC5lapF5J/Em+UgA3k7/xuDkDKsc6UECAVSHwdVWftBSFyBSP/AovlPl01Mh
 oZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641571; x=1715246371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e25XlIJbSioeHagDL8/kzm2Nd+PqpodTl56gMEOQ6kQ=;
 b=sJqATwHoV22BmqAejQps0CKqUERV5K+ga7bBc0MWe/fFrLno1qHVkTrbbpJNkglR6V
 n12Y5VblEQTt1IGElR1DtepI8UUIWp2TXYqA3FL7R/q+Gs8p8esm1QmZTn77mtaeuj9a
 7EIS+BP3PhVtIwks7n3n1uGgzI/e2GwnCsb67Z63e2Xn5HggR/db5JiA0KZDA9roBuxK
 ypI19FDz1llTedLhl9Css1bsCjRici7EawTSyu9ZS4nqTZQ0Z+JPjU3LYiDjv44sWqI5
 f12NL8OzrnvuU0ueq/aPSA7lelk2lHqGKMrKcx/jCOgvDvfH6AI1CTJFYJsxKY8aTAoV
 2CLA==
X-Gm-Message-State: AOJu0YwImA6jKxw4CeNS4mdOJmPwKouFGXx+y6PWsUmVQlqkDsjriblB
 OEXWIor3oNA876wnJ14IpHHb+JtpVJRY2WkZQCYePBwIQfLRRh9KonslXKptB0Y=
X-Google-Smtp-Source: AGHT+IF/6Ft6E3Ax+MvZnqMqLnwIB93CNvqvguGe6/FsxM73WuW9UDjOrZBiTP9RXpQHvfCO59GEng==
X-Received: by 2002:a17:906:b801:b0:a55:59e6:13f5 with SMTP id
 dv1-20020a170906b80100b00a5559e613f5mr915564ejb.26.1714641571226; 
 Thu, 02 May 2024 02:19:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a17090626d800b00a46d9966ff8sm319577ejc.147.2024.05.02.02.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:19:30 -0700 (PDT)
Message-ID: <8c487804-a706-4149-abb3-c2495247f09f@linaro.org>
Date: Thu, 2 May 2024 11:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration/rdma: Allow building without on-demand paging
 support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Yu Zhang <yu.zhang@ionos.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jack Wang <jack.wang@ionos.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>
References: <20240502090547.87824-1-philmd@linaro.org>
 <ZjNYhGQTFBQHZgga@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZjNYhGQTFBQHZgga@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 2/5/24 11:10, Daniel P. Berrangé wrote:
> On Thu, May 02, 2024 at 11:05:47AM +0200, Philippe Mathieu-Daudé wrote:
>> On-demand paging support was added in libibverbs v1.2.0 in
>> commit https://github.com/linux-rdma/rdma-core/commit/e500adc7b1
> 
> That is 9 years old, so I'm surprised any distro we target still
> is so outdated. Can you say what distro you're seeing a problem
> on and what version it has ?

This is Oracle Solaris 11.4 SRU, released 2 weeks ago:
https://support.oracle.com/knowledge/Sun%20Microsystems/2433412_1.html

I'm not sure how to detect the version, I'm seeing downstream
patches applied on top.

