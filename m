Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4286AC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmDk-0007CU-CL; Fri, 02 Feb 2024 00:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmDi-0007C8-MJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:36:10 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmDe-0000Wp-1R
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:36:10 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6e118b528aeso872213a34.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706852164; x=1707456964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1JttypaX8w/+DWfoFaRpMWB1CzUugjD4ophPdZ8DOg=;
 b=F5SlT4/sCvVdvImjbe/iEEI7686mzdgr527TExJ7TA8oc26R5HYEM8w8SbKGWANoOT
 te0DCzlmIKichRqrwQb5Z6l3Jkzm71mKLKW7YGVphQI6W3M9lMDud0BoM1QE2oFDbKDp
 QYZweDor23WaX2K+oBZL91gEajpD2Kkc24TbUQxN9ufYrbP3071RJkGtw9PHUIs114Wd
 meGj1Qh7z/fR/Gsi44ufnHEPn/thmmautpNwndXQKBiJNaB0eSQ4sv/1GyuXpM6e4MU6
 C2GKvlZClB315NWlPVFKp0IPiIz1DXsjDc+/Cvxmy9bQjh22nEgeD5Lak3jezrM2ifEb
 RawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706852164; x=1707456964;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1JttypaX8w/+DWfoFaRpMWB1CzUugjD4ophPdZ8DOg=;
 b=afyCvPBBY4iSDOGN3cgBYJaaddUPr77xPei60ekrw0xXknZkD5w81RZvwUv1qonL8g
 F0GOk8Tc9SNXaFDQqlEQiza9RUDsHrGSJiYAv2j2UnzkgmdP5nS3ljOGb9oYe3mT66Jg
 mHXPckkgRtvRiSt0YJF0sY2dFySTUoefgoBadqZTP/yGoZsI6a+ENG8LPL9gsWU3x2CZ
 w4iYrQRLabcfeJN1wHbt0y2BZSDbogW5jm+qnJEy/ZSoSgzeNaanHn/EpCyx90U1YDyX
 AxMiwWYgpOXxaarvD5cjRfKxvSP6N0nwEKGv7ednmyYosAKc6c2+s3V3eqa0aeQE+ng5
 rRlg==
X-Gm-Message-State: AOJu0YzfD2zcaS+Cfj3ymxOId++Vs3oMF1Tkbmwmhi91xAbpozMD0Jgp
 yb93fRQTXyv1X1pAP1gWtlCc4n/izPG9QVbGWuQzqYcV6rsBcA0PQwESru6q6jY=
X-Google-Smtp-Source: AGHT+IEkoSnYsnsBRmz3tzBa7OLHXITyuhFtsAhhxDc9SnxFfOXNUvRvqIy6RjCj3utQ7p4j2UWZgw==
X-Received: by 2002:a05:6808:2089:b0:3bf:bd98:3846 with SMTP id
 s9-20020a056808208900b003bfbd983846mr1042968oiw.6.1706852164442; 
 Thu, 01 Feb 2024 21:36:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCULJPybvSAXh1dGck9Tqz9S/1Xf75/tInwpHn6DRUvEbNacxVES4qPvhfJMt6v9JmNkoO0uMudnBmaKgPbDT0XIjLCJKZY=
Received: from [192.168.0.100] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 ld9-20020a056a004f8900b006da14f68ac1sm671703pfb.198.2024.02.01.21.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 21:36:04 -0800 (PST)
Message-ID: <bded37a2-1a55-448a-b1ac-5ba162930ab4@linaro.org>
Date: Fri, 2 Feb 2024 15:36:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] target/sparc: floating-point cleanup
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <a96a571b-55b7-46b4-a793-bb405ef10467@linaro.org>
 <b6ac778b-4a75-4c1d-812d-23e27f9a9b04@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b6ac778b-4a75-4c1d-812d-23e27f9a9b04@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 2/1/24 07:49, Mark Cave-Ayland wrote:
> I'm happy for you to take this via tcg-next if that's easiest for you.

Yes, I can do that.


r~

