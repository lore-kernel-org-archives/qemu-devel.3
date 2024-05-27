Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BBFC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXEo-0005ln-FB; Mon, 27 May 2024 06:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXEk-0005kd-UH
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:05:51 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXEi-0002B4-5o
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:05:50 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a620a28e95cso735305866b.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716804346; x=1717409146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+hEEHJIC5uVFBMlcdR74zcUnxkFqg4432y8WTQMsI1U=;
 b=MG//RpP6mvnaG/eKHxwbc1SjDCvpHfBZnHvzJBNPTrK7RNlsaNiNBjbpAaxG/Jjuhb
 IDh6dZDf5bI0iSboVkzulrpdGPbsLGCfC9D+dNmp9MJndlGQXgwOAOtIYPG3BtltCU5W
 Z4t6iht3kJ525biykk0GbaRGUzd2dWPey8tBLVYgUKi/yeQ4HCGCfWIEyjgAN9vawp/J
 UeEWOpHlvCCumFlzkyXns1NpIkgYXH5mdaQs0iVD1ixSLH1b4nrWbga8rh+WyJDKeaxa
 3Tf51tWF5kHXnmYTlF+npTm3cJ2OmLB7rhvDl74YgLIty2eI4toEn748iZHVBZMCoCJW
 Bltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716804346; x=1717409146;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hEEHJIC5uVFBMlcdR74zcUnxkFqg4432y8WTQMsI1U=;
 b=MMr7fepRNreunOfsl0rULzDd5Z1tuwcBzOAOJshYuqqtgTprBRmXytu48jhdHQBZYT
 MNDi8BurefyPMt/jtM3aKekyVA08YRcJr3cp8h7wlu00ipAuQmZijHx7Ck24mZNnIa4O
 GKqMWDmvjzs+rMeGoXaal0+UCOBsuYOUDaSH/dkkyWVZ2W5D/NzYCs1GCpMwsRAXUh3+
 YXIjNaTQatYuAGCEYx7fhhCyoLdNNlYr9xy8rWJ7OD3McN4n+DDPMaDlzcDVhDg8iuKb
 5QVkpvgcDyla/PJJcHmwjMw+w3i9aRyxCiggJMeT9WrrvLa7puUHJ+p1YC4rvMda+oXL
 l1kQ==
X-Gm-Message-State: AOJu0YyXfklz+aCpHs9omPlLqviYko4bbJm0zYHGYcRg8hD8QiYZhy9S
 CfnKjpO0nqKiCMCSfs5LA8wyLhKzR1Tw4OrVSWLRpF9sG7+aDcFOUns6ymC5+aVZwXolfftQ40U
 48Ec=
X-Google-Smtp-Source: AGHT+IEKbzBGSnXciq3D7IMyCf1pjF/lx+6sW87x8cOVCOeSQV22VdO1ZcLw+dLPXZ3U6JhEkjWymQ==
X-Received: by 2002:a17:906:2898:b0:a59:b359:3e18 with SMTP id
 a640c23a62f3a-a6264f013c2mr619669566b.47.1716804346572; 
 Mon, 27 May 2024 03:05:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda6d74sm471599166b.201.2024.05.27.03.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:05:46 -0700 (PDT)
Message-ID: <ae5f561d-275e-4d01-8fc0-6da2bca4e91a@linaro.org>
Date: Mon, 27 May 2024 12:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] lockable: Do not cast function pointers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev
 <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
 <20240524-xkb-v4-2-2de564e5c859@daynix.com>
 <a972e12b-398b-4843-a7d5-1fc66fd03bce@linaro.org>
Content-Language: en-US
In-Reply-To: <a972e12b-398b-4843-a7d5-1fc66fd03bce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 27/5/24 11:57, Philippe Mathieu-Daudé wrote:
> On 24/5/24 07:35, Akihiko Odaki wrote:
>> -fsanitize=undefined complains if function pointers are casted. It
>> also prevents enabling teh strict mode of CFI which is currently

s/teh/the/ (also next patch)

>> disabled with -fsanitize-cfi-icall-generalize-pointers.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2345
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/qemu/lockable.h | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


