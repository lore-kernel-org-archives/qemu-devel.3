Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AB1F3C269
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbV7-0003yG-JI; Mon, 09 Mar 2026 10:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbV5-0003wk-7P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:22:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbV1-0001yU-2w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:22:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b790af67so4815186f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773066141; x=1773670941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3nmA8ejU5Uu43VCllfciqU/HhbwiQXCppfytgeBv4U=;
 b=q8H4VKfDgT/p8X4nyUnbwu/NsVOMnGWZaFJueLQnjkZ6sGtEWM5C610y/fMNvR/Zhf
 6XWcPkUwhDI+cP4chvr4AR+rzl28qwI2DWJugYhpT0f4zjtsae+TMs/NmMY4RE6NmNeF
 NR8+nOFkBqBucn/jMVx8aWbFzE/ychx3fFw+aCoYyaw5oCn6pqLk8c5FcPd0ItrBDu3K
 93JhSNy1A9ExBjV0rqreZrdZSCUYFlCbUD628eJBra4pI4sEQuLnDwPI8IRrdSs+1Yqc
 CNsxi1hlLJuIrygFsQJVzZ40ocWA17iKLaIZ8vlpPiGQShxbtCl55ydFTsJ8ykmJ6iCw
 gUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773066141; x=1773670941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3nmA8ejU5Uu43VCllfciqU/HhbwiQXCppfytgeBv4U=;
 b=dt/Bhq3C2YQH7RWDkAomUU/16BiOSxO5QZERIqw9IEIMGvY05xxz/mYQycqTL7MYn4
 D3bzPO8NbDaDh0MA6VXPzb0vzhOcBmMXKCKEEXuPt4je3fkJ9/om8C1A54u38evFrFX1
 dwhqBhVjEQNwedtlZP150N0xzdtQ18ewx7vorE0oYwaO2v106Jd5kOInwyYqon5RYDNQ
 GqxBXrvPDIrEpgdfW72MqtWBsy6ha2uGzmhPH3V4r0uctLUCYqRV0QXQniRJTR72HNvX
 7RSUbTTTY2/YQlTpctTtUQTcGNezonD/9qBv+rM4UOFJym7Xfd3LhbeVIwYm//SAqMHB
 KFlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdGkFItHMJiD76Z8yElaX01H3PbbNbQYhdnl7Z2J6pC174NuMqizargKztr0f+V4eLzIi9qfXZKxQL@nongnu.org
X-Gm-Message-State: AOJu0YxgG/CNlQyNlxdvnRi3hsj5RhLS2HX0YkdHUss/P4rVNoZUN9qf
 xQOli9mtT7wa2DXXnz0/+aCOfwNq5ciMRIl+G5t+/7X6cnP6/LYdhnM5su9khBY1ZL4=
X-Gm-Gg: ATEYQzy0JCJ2mR9K1FoK1qWBmB5yzCZ/3u/5RFYqwC21W108WftF2Xr2HE9AfheclVM
 L7okX/RuINjGp/SgkGRk+QIgi/2v+arDBZjhdIAnu5Hq5IkZ1mQFWB5GrXLVuCL6HIA6Sz1+PG9
 pi4Ttn9Xeyv5z+//mk03dL/+TBjnRDJmTXj8ryrm3lkKIiR05CIiCYig9nL5GsAUczbQSC/c8NH
 yhrIFbsOYw5RqXyNItNLhVMoSRcNC6CnUm14SkWIYsC0DnjXgdNO5srTVuriXtPZ3wTLYwr+CF+
 /X/0ZiRWb0/q9EwUzGowlv9dlUQcYmW49oVGW+nH16S3sORFlyRSfMfI8jfjZBj+OKnWQpfngCt
 U5/IswHsPvwYkks7XkM9oEUx+R15wVqj//5TuCupOMrOYd+X9FxrbeegMvB8u9wRTTmM2w3klG2
 v+qJS/r2fLUyqFag7VI0HUKcYEM44ghr73KRnPLMuv946/Ib+NEa8klrYEKGZ7anPxwqCsdvM=
X-Received: by 2002:a05:6000:288d:b0:439:c9fb:c552 with SMTP id
 ffacd0b85a97d-439da556c78mr20829758f8f.19.1773066141287; 
 Mon, 09 Mar 2026 07:22:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d968sm25946325f8f.6.2026.03.09.07.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:22:20 -0700 (PDT)
Message-ID: <67aba5fb-8db9-4589-a346-f08b45eed39b@linaro.org>
Date: Mon, 9 Mar 2026 15:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ui/dbus: fix leak regression
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <20260122113144.2046899-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260122113144.2046899-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 22/1/26 12:31, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For some reason, during refactoring, an extra reference leak was introduced.
> 
> Fixes: commit 7945576cf2 ("ui/dbus: factor out sending a scanout")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

