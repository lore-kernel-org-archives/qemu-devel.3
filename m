Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F1C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbe1-0006cm-FY; Tue, 05 Mar 2024 15:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbdz-0006bR-D5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:44:11 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbdw-0001QC-79
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:44:09 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6092a84f4so2396344b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709671446; x=1710276246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P9k2biLPUbINbZY8mZhoZ0TQXk7gMWJSyi4sPzemapE=;
 b=PkXhwh2bJj/1TOvn8UMSzjRYa1djT3p9tSlLeNUGLfe0nJVp/sRkD+iFcsDSCy4J7h
 0/RmNxHYN3HkLQymKbP0AtZJuL5G3mciDQYDDImXbXzhCBizdn0UyKSdLKnZjy/AO8hd
 RfJ84kL7ZC635NRTzvRQxafb2/bJa4o9qSCJOi3/Pxkrx1GAlui8CeUi7ESPgnUb7ugF
 J6BG5OVAoFsdC0TZuL1XgT0FpwIG34FCSh4o/pwfscHM/6Y2CS6khkS5SOBbwykNt+ar
 DzwZVgzp8ihuoQNsLQBgYo3lN1+79/byrxQ3O2qj93YXWHPiQMMwYpCJNZORYgi6+zku
 96Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709671446; x=1710276246;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9k2biLPUbINbZY8mZhoZ0TQXk7gMWJSyi4sPzemapE=;
 b=xGg5lzqqUNQSUUSz/nfafW7rAWGJXlG+X1j1SWfZ1dPOWWqU2Pq7uooSCIQbV6Cwb6
 wkdRd8dNA1F7CIZf35sO624cV4Cd9SzJDdzxhL61ckSNtpR84R++OozKKe02nMLySGJv
 OozSBpXie0mHh0zcZEwwQRu9h2BAi73gEoQ2gHQXagcUrr4zWXT//J0FiLxEXxssE/Ii
 W5P7g34+vyBcTQKt1PL8VZaAyTZxOFl690EmWLIpf7fncJq9n+SVTkqE2f0qJaGHq92V
 ysc04o3vw5CkIkwYo8M+YI3Jmpm/e340EGPB5ozfg8EVWDaUGxnPax76LpIFSPl0TyMG
 PSeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYAKekLPRMq3FFNm3gFNRDMtIRePCfxnmj17Yf8oZuLzDLpN/AYwjbAoVvPMyySH02KzMZMmawrLLqXhlUSb0evRQ/V2Q=
X-Gm-Message-State: AOJu0Yz8KfYQLmvq0Ru4gGJAfu0eEJd57zgU823rp7jwSiuc4suPGdc4
 94PIg9r3Yl9FYmwT7o3b88iesspUcY+Y/Y2EUlxcZITITsZY7cTCXNxMqHOdmh1r/mjLoyrePKq
 3
X-Google-Smtp-Source: AGHT+IELWiZaQIfdoiSmSOctbGQGK5Yhw+4PFtJz/xJLCLMibjRj+n9mlfEaG+oS4o6UYkLtMm46hQ==
X-Received: by 2002:a05:6a20:4e22:b0:1a0:cb49:60a0 with SMTP id
 gk34-20020a056a204e2200b001a0cb4960a0mr2483302pzb.36.1709671446536; 
 Tue, 05 Mar 2024 12:44:06 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 du6-20020a056a002b4600b006e5933a0da9sm9390944pfb.165.2024.03.05.12.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 12:44:06 -0800 (PST)
Message-ID: <9b32b7c6-8883-46a9-aa0f-c3120eb84691@linaro.org>
Date: Tue, 5 Mar 2024 10:44:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/29] {linux,bsd}-user: Update ts_tid after fork()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
 <20240305121005.3528075-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305121005.3528075-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 3/5/24 02:09, Alex Bennée wrote:
> From: Ilya Leoshkevich<iii@linux.ibm.com>
> 
> Currently ts_tid contains the parent tid after fork(), which is not
> correct. So far it has not affected anything, but the upcoming
> follow-fork-mode child support relies on the correct value, so fix it.
> 
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> Reviewed-by: Warner Losh<imp@bsdimp.com>
> Message-Id:<20240219141628.246823-4-iii@linux.ibm.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   bsd-user/main.c   | 1 +
>   linux-user/main.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

