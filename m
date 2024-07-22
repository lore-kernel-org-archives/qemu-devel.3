Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1942CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0WU-0001F3-9G; Mon, 22 Jul 2024 17:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0WQ-00010r-Sd
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:24:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0WP-0008SA-4n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:24:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so31852475e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721683479; x=1722288279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQmlgxAH9frE+MB5y7q3Nk6y378Ms759NKEkIfMV3aA=;
 b=DGi3tclRCBuXepKzTuktbzNmXiEnl7QggsziZaHiP0ZoFEvgOLEtlQ+e22znFR543b
 lyVRN6hDfyL2OsVhf//+p2/8+xxJWrQs1G9Cp7nPjj6I8pVhVal5+UTw5Q9fRG5bh4ME
 5hBUQAoaSpF/GiDmDMgUvmnGt9/SWqX/j2omsfMSSUCdg4X7N+48OP1hA0Fix6Nth9qI
 AAzzmqPMk8/anezK8aP+IQPtnXFsfMJdjF+8ltrT+eRnS6/gJdjRQL+Az5wq6HQTz9eO
 1LEssy2sNaQu2v2Rxwb9DU0IopONmx4bqXHCNYrrB5pPnxTQf26m0ipbpbyN3m8AqJXl
 o8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721683479; x=1722288279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQmlgxAH9frE+MB5y7q3Nk6y378Ms759NKEkIfMV3aA=;
 b=bMBuSeb5SmiuQQnaV7c4ix7OeA1A4odSh0RcJKjYFdMzLLuDVPMjKuOMuq1lFhJrxC
 eyuCePqp5+6uYG7m8/hU94Fsc4efsZynJubNGr4jG1VLdCa/PB27BktzPm6yfquMhDcy
 0pjR6rRzkf1pj/erLpn+aAXUZ0x4+uw3gSYSja8S32hO5kA87q5PSbokc3NTZ6ijjwvR
 x8vIroVTFvIWAWP0g6e9Wan8PbAI/udvzsH0Bs+glrm3DCQpVNRPAWekHPX5qyiYiHQJ
 nCm8zYT2DEYveQMbfqOSGgxc50Yw/iZn2YZAZrK5r+fbHxtsZEKgQGreXN6NUGs3kQps
 xJdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx8IsjiKJBACCZBpQrIwxRTXmHSIvjEYre1XiuRVlqdWbuUYaozk92maetHB5GBalidKrphQJXukwwJRga+XL6Cog3zFc=
X-Gm-Message-State: AOJu0Yw95udU8dD/u+2LQxKdPi4tUdY9UYTqqlJsW5UE+2AH1q1+EV35
 DslmOgmwPYJ2zdspIyD89sgyQQ3tQdx5mhYRhhvG7iW04oZ7KmIiydwWCb1s2m0=
X-Google-Smtp-Source: AGHT+IH2rba/6LBS8bhDvVMf3xlaKgzNhvXi+AQ/p8JMADU8a1VDGCb5MnQPH0P2plPPCPAod9tMhA==
X-Received: by 2002:a05:600c:1d96:b0:426:5ee3:728b with SMTP id
 5b1f17b1804b1-427daa28651mr59071125e9.13.1721683479504; 
 Mon, 22 Jul 2024 14:24:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a7257esm167810725e9.28.2024.07.22.14.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:24:39 -0700 (PDT)
Message-ID: <365e4c97-63f7-4cdb-bc3f-0853ffec85ca@linaro.org>
Date: Mon, 22 Jul 2024 23:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Ui patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240722200619.135163-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722200619.135163-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/7/24 22:06, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> 
> for you to fetch changes up to 903cc9e1173e0778caa50871e8275c898770c690:
> 
>    chardev/char-win-stdio.c: restore old console mode (2024-07-22 22:25:46 +0400)
> 
> ----------------------------------------------------------------
> UI-related for 9.1

Thanks Marc-André :)


