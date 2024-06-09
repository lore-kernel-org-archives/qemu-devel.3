Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46730C27C65
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 18:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGNAT-0001nM-8a; Sun, 09 Jun 2024 14:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sGNAP-0001mb-VY
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 14:21:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sGNAO-0007Fx-5v
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 14:21:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso2794856a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717957279; x=1718562079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36r+wmlrRaNtAsJgXwkzBYW7LdIpldMycsDHIfyCZSc=;
 b=CUDsrInfk5sJveZ4iz9z2wCOOS5sO1KplDTRhNI4qgS2O0gKM0r1D04UFkOLrp9gzY
 2mhpBrYB2tGrasQ+kJ5nhB4IwRdXEnb1PO+tbY7Fa1c2bzN0jvGU7IoooFezR669lWHf
 hJm33r+uM7iBLowof07hsHGgiHMXjFUutwLl3CLUX8vFIVyuugTn0g9PeX/Gc0ZrNJ8L
 ZwLS2qKT4ma3o2IkMwAF1h7PJJL5RczPZ9KprJGly0jiTJ48TnOJptDh8jOv7g4NCNUD
 cWBXegXK8VLYYFaSDdYLKmiY7eNGCF23mPd/721gjRlTSlx2xjoLspXmWp7w71V41Mo/
 SKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717957279; x=1718562079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36r+wmlrRaNtAsJgXwkzBYW7LdIpldMycsDHIfyCZSc=;
 b=BtfvytoMR2qRcMalWMPGyMXohxInk8RMU1U0Pzno/i9j70OFY+L7sSEuJNVhs1+BGs
 1Hfav9bZuAv65cH9ABaNtKc4Z+ugGB7xdUUIlB21RpuAH2lI4RItNCJNWq7LXH4Th70C
 t0KIRv/3xbwZVJDQy0YbZaUM9wgiCbQrA+PN12chiEMAouXJzOfM6pF+y+flWSCgi9Hq
 452fhkGgKkX/DHAa5rcAP4tXXO+3g2BOPjFECbsHH2O8LELHk/Rx+ybkn+Ls7BAIXAff
 KD0JVQjWmtKPk2xBXMCYafLthj9yzAgwiznL/tX0mPDh4+8TWn0umG0/svVs9qEdtCi7
 leOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUesm3B8ZBbLf3xiRGhYT34lWYO0jU/WwRpTL5OQTkLLNut5pknxMyfM6yPlpdDDxzqHhBwJVZZnRnRandXvJ861Dcphaw=
X-Gm-Message-State: AOJu0YwyhCZtSA74Nz7vGUSNF6B//0d9h3BKxdPTTH+GnOVDEmlshTuT
 R+SMK+SwNjfTQe3SiJ1hrDE3R2zlyWvv6/8TgZ4j3LkLDZs+ydE3RUGPC+r9wXw=
X-Google-Smtp-Source: AGHT+IFkm27fW05OV1/h3c2+3phd5xnUeNzuHJqPFh0oSeNYD9KCeOQw3+PQ++zwPtJZox9gVL0yGg==
X-Received: by 2002:a17:902:d501:b0:1f6:efd9:bec4 with SMTP id
 d9443c01a7336-1f6efd9c1bfmr47150145ad.19.1717957278646; 
 Sun, 09 Jun 2024 11:21:18 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6d870b504sm46495855ad.200.2024.06.09.11.21.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 11:21:18 -0700 (PDT)
Message-ID: <12a71f79-d400-41c7-be53-49fa7ff7466e@linaro.org>
Date: Sun, 9 Jun 2024 11:21:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] hex queue
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20240609005705.2809037-1-bcain@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240609005705.2809037-1-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 6/8/24 17:56, Brian Cain wrote:
> The following changes since commit 3e246da2c3f85298b52f8a1154b832acf36aa656:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-06-08 07:40:08 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu  tags/pull-hex-20240608
> 
> for you to fetch changes up to 1967a1ea985299c090dfd3efc1e5323ce60d75df:
> 
>    target/hexagon: idef-parser simplify predicate init (2024-06-08 17:49:36 -0700)
> 
> ----------------------------------------------------------------
> * hexagon: idef-parser cleanup
> * hexagon: implement PC alignment exception, tests
> * hexagon: fix for HVX new-value store

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


