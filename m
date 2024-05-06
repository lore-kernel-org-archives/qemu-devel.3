Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C61C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44UP-0008NE-LS; Mon, 06 May 2024 15:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44UH-0008MT-Ic
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:59:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44UE-0004Qd-Uz
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:59:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f4178aec15so2020124b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715025535; x=1715630335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R9F4NDprLnA4MX1RYcjtn8a59V8nr2rMP5GKIrekoOs=;
 b=GOrUhIwdTgsHmcUTQXs/Bw5jRtUD2azYbUYrnnls11Y7JVGWLqGBZvXYxUHLMkB+0U
 EvT/BzBjWw/h4FGH3yRG/3KkTPRaBLHW3c60d8T1tnCGey0NweoDnkOMcD+DSPQpueSL
 L0DHYfrSvPfvd+g5cF/JyiQHM7ct6vikFgq1fWNZbA8E/2CbHmsqchInNF2EbZZJCy7L
 HJDSantenszA1XlKYSBrT6Gj8F6gUqQM6YPjVbM8mEplmgpVpwoli17PBZJQvSUD50fB
 f9lwqPbDLMcmFaPRafNioK0bB7o61z76qpWsTbu8/RbyqWiuFb0Jq87ipqRIIcCFne2A
 VaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715025535; x=1715630335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9F4NDprLnA4MX1RYcjtn8a59V8nr2rMP5GKIrekoOs=;
 b=RsR/Zwb1e2DsTIR2VD+gKPWJC8gZUQcJgVGXBz3YCpAMCWNiB4h0Gyd9rS/sSy0Lzg
 kUpeMpR0NTfFMypRFX36n9VkTYskGez9RvWfdO2AhjXoJk+P1TSEGS7RG5E6s50XslXI
 CZEcHj5MevCz/sAqOIwEUpaZ/k6qqTKkIlabh+clmf0mEEl3QvD9mlvE5MCJ/1Cm9yBv
 d1pFd8+haKIgQlINQJemMgoPBoA1uBI/VC8JHOkZAIPVOwEZ8GRLXZxFMvdb5xHGgSvK
 EMk0i3F8+5DeA3dpo7UJFz1iMjV5vRo0SyT3waAdNTxbwiLAOPVhhGDOXT9rTN30EfHv
 kVhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrKATl8JvBRtRQJnHfiy7SXvl+DI4ikQRJ72mPtyspg+VU41jaHmT5szJ6dD9p3wJZVSyVqwVgeHakin49xUVIyy5F7Uw=
X-Gm-Message-State: AOJu0YzrDqOhObBL7z2gtKkBBgCBP0Rt5+iX6NxHK2ZEfl/xK9S9yWGV
 6vHHKMPPgInMwqVlbINzk3aeP1gHOpAO37jqUJca7KGcRS0sKNJri0WjGRPTkD8NOwDJOBfACXM
 2
X-Google-Smtp-Source: AGHT+IFGoEZt1rS80xBQQZ3tdgcAuv9Z0/TdsgFG9K0IXv3c/AD0F8T9b3pyiAvIwKpkNiCR+/wyFw==
X-Received: by 2002:a05:6a00:4606:b0:6ea:950f:7d29 with SMTP id
 ko6-20020a056a00460600b006ea950f7d29mr11936683pfb.20.1715025535256; 
 Mon, 06 May 2024 12:58:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm8096151pfn.187.2024.05.06.12.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 12:58:54 -0700 (PDT)
Message-ID: <279b336d-4fda-4868-8ccf-855326fabef8@linaro.org>
Date: Mon, 6 May 2024 12:58:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] QAPI patches patches for 2024-05-06
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240506110254.3965097-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/6/24 04:02, Markus Armbruster wrote:
> The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:
> 
>    Merge tag 'pull-axp-20240504' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-04 08:39:46 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-qapi-2024-05-06
> 
> for you to fetch changes up to 285a8f209af7b4992aa91e8bea03a303fb6406ab:
> 
>    qapi: Simplify QAPISchemaVariants @tag_member (2024-05-06 12:38:27 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-05-06

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


