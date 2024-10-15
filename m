Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3DFD216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iqk-0004Bm-1R; Tue, 15 Oct 2024 10:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0iqi-0004AN-O2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:48:36 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0iqh-00071R-9c
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:48:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cd76c513cso21380195ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003714; x=1729608514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DaPzjuRqRL2zXed1O5DcMjojZ2T/loMrT9xDsA/eNJk=;
 b=PJQjJPxmlSJdq4UlBn8X3637I20rXT7BWUO9SV/1/F0ZpnOBPB/6UlpYXPcYYn7933
 U4kr6XJi52MzGjP+6UnOLY7Z8Sbr3Ho5VhdzmOojOOuQ9h/ucgwnZBargEGX/C0WCz84
 XP3rCwZFOlXLy8kHMp7CibYYaOOQ56bH43cpq+TXxujwoCAf7a9L5+t+7gwZwpNcuRGW
 3fEpJMtjoEp9t+NytW67YWcu0OFmroAFUOESKerBUa1JJSVommbDUzIA9lEH6vxL7JjE
 mC08gjDj0inyU6gXTCCbGwX0xPs55hArDBhN22+neqOHWLDzD/avETbOec94HvApcRvf
 dijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003714; x=1729608514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DaPzjuRqRL2zXed1O5DcMjojZ2T/loMrT9xDsA/eNJk=;
 b=axS7Et1895WFkp9BTKRANNattV2zEwpFO2VkhKFOTbwSuUXwL/gl6tQTbdju699HUD
 SJegYuRzJ3l4oWclV8IU9HqKlEN1dMhDnAtE8pn/99q8meAMLmXGUa86ba3/dhcHaR96
 QjCVYHICgnd9/6xqdXsBDL26/FNjr1cVBC4lkCjsVcs33vsGdPbQt6+2iPOpH6eelZp0
 T0gPKWbZoeqZFr8wb8t0vFYChLDNRuhqv/XNfmetviq9gzJo2V1jBPXEdHngwGz3xi+o
 QswKbAcSTSEn0KaLkV24oLJMoKcAUxRWI1T2pLMGL5uo0rnOKJgnCj/lUuKqxHke2iAJ
 IZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe17rKtTF79TsdaS7onKORujZPyFfXAJu+SFXqZnASU9sJf1PqlggskM7I4tqcHYIYap8FJ53Wk97m@nongnu.org
X-Gm-Message-State: AOJu0YzrFzye5/ZSuhup+ahVAK92ALLRcnpvi7ByjV7LwVNRJ4UVrikP
 5xvfkYyh7Mm8V4yO4Kael4Be3y6u/ZJYBsxOZiuEnA1I74K3+RqnPIuWIZsiSB8PTG9o2xRuLFJ
 X
X-Google-Smtp-Source: AGHT+IGI5G6u6UOkW8hs2EKTT67LtzKAVsCGjUQBHrI10s+AczfQmAAC3z8Tf6pyanuvZC3hGJtwIw==
X-Received: by 2002:a17:902:dacf:b0:20b:6f04:486f with SMTP id
 d9443c01a7336-20ca14716e2mr174011225ad.18.1729003713961; 
 Tue, 15 Oct 2024 07:48:33 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f9d32esm12952045ad.96.2024.10.15.07.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:48:33 -0700 (PDT)
Message-ID: <b69400d1-c1cf-42ca-b64f-41c0ec672cb4@linaro.org>
Date: Tue, 15 Oct 2024 11:48:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Clean up unused header
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
References: <20241015140922.385470-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241015140922.385470-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 15/10/24 11:09, Gustavo Romero wrote:
> Clean up unused (already commented-out) header from syscall.c.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/syscall.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


