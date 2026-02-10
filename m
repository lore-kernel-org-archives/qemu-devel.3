Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66118EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvg7-0003TH-RP; Tue, 10 Feb 2026 16:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpvfs-0003Q6-K4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:53:38 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpvfn-0003aI-Pq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:53:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43622089851so1310274f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770760409; x=1771365209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WhNWoYL0sz/11OXdQcmDlNOzfB4T6i7OJni/Y2r+4Ys=;
 b=BvervU2pZ+O2z4et6VielzV29fhK4pycp4Za47pAb/uxwrNkoxkBZax24/AjmkjdHg
 +s5yOEdSoY/kEfPn2Z2tLvvYPUtKvDikwXhaaTGqXVj3Siad8UVVlky9fNc6h1h5MOmc
 Euqe8TAY/awoPPXNKMGgjd78VAfIAPk3+jpsxQFjcZBIbjkfgXHcKgqBnfHFbwf6g5zU
 jJdGiGde9XzegACUf/3I//jTH4QM6MkI6qkEcUbXxO2vkpA3U7OSB0nLdokcxe3pa/UA
 UzFPhOQyfZc2Ha2Bn4ZmNo31IcJZyT/9eXs/o2OK0Fy5T82OyPxuBRVe+q7LJFlnOQrA
 u4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770760409; x=1771365209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhNWoYL0sz/11OXdQcmDlNOzfB4T6i7OJni/Y2r+4Ys=;
 b=DlcTFSWer0XerO+M9td0X8XqAYG9l7AlmHum7wJ2+iuQjw/yesynpResYNzcMOjf5P
 Y4a/pPgl4RqFc0WrIdWW7csAjK0+WNngJvfztr4X4P7J1v+7PigHcc7vVqujNdDrt1Ul
 sh6vb+GcAQJYsXOvnJ2TkuPjl3tBQyBDxU3gbf1wvOcoset4LQujvDO+zZ9CvsxMaoCc
 mQmdfCE1NkYhVBPj3sET7OISmleYoYbYUXgYZFcon6Eo83Tb4x+woYUvFFd5qOfFRLJB
 lRHO3lkYhO6ohfX2dJWKkf600jWyt1sBK/oS5tO1RwFULdPhI8QYWcvqxikQOePkhyFf
 OGbA==
X-Gm-Message-State: AOJu0YzWRgnZb8EdcRVULtFagsPezja3V568XDTTOTTg52OWIBKmjC6J
 tQ+FexbldW9fnthCHkzGsEHZUDVuDR/fxr4NX7MBoMVGXliYpJ4vSk8RwjkrJiGxIiE=
X-Gm-Gg: AZuq6aLMUAXzquUGbpiYEMrVaOtY1vi29RjgQ266jJtmXshDbaEZgL+/Ujc6GwQkUlk
 yP8QHxKDP5K9OXfplz+GIStV3nJbL1M+FdwaXyj4kOwXn2/yTclTyxkj1/AZ22RJ31LFqcdLnrb
 HJBkAOFt5ms+s9Y37640bFaVzvez5XK5SglEue7FHDSBFxdjxVBD18rhae3l77/HXQMiPEfwec7
 PgK7TXoFkKGAvFG4vcgBTgjXDkQ8KXczA4opL9bns4tDCUjKViQkEKrimSHAlQegnEP8QUXpdei
 xZ7ZXSJJ7A8NTXrqcwOXuNYMRLqKmZg8Uaz4P4xPW9jrp0pIKFiaSkVID8FBQN8sdTwW6zsgG43
 9zSXlhndZHP2tfqbXYQBIZ2mexsN77A9V1Po+5qUW4hUdSjz/wge/pRGUMvJ7eVwHhxR8NHwHhP
 LwRIveVMc7v123ZM98vke2C8MTSbrcsK3IHo7NLIzfOFFm/LXaa2VaAdjGzdbyYtSlZw==
X-Received: by 2002:a05:6000:3104:b0:435:a2f8:1533 with SMTP id
 ffacd0b85a97d-4362938b45dmr26947646f8f.52.1770760409550; 
 Tue, 10 Feb 2026 13:53:29 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436297455eesm37026748f8f.29.2026.02.10.13.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 13:53:28 -0800 (PST)
Message-ID: <bded12af-5f9a-4ee9-a6e0-f87dffe87f21@linaro.org>
Date: Tue, 10 Feb 2026 22:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bsd-user: Remove NetBSD supprot
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
 <20260210-bsd-user-rm-openbsd-netbsd-v1-3-8b8b0f50c29d@bsdimp.com>
 <def06a55-ab7f-4a2b-b43d-f9571c26a5a1@linaro.org>
 <CANCZdfpcVBpLMeZ3Wpbj_g+-_NpBd=mBKLfRQjp33X3GxtD-rQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfpcVBpLMeZ3Wpbj_g+-_NpBd=mBKLfRQjp33X3GxtD-rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/2/26 22:11, Warner Losh wrote:
> 
> 
> On Tue, Feb 10, 2026 at 1:56 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 

>     Typo "support" in $Subject.
> 
> 
> <blush> OK. Will fix.

No need to repost IMO ;)


