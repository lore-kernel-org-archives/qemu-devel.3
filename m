Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D615CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLlF-0000hD-BP; Wed, 13 Mar 2024 06:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLl9-0000gk-NY
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:22:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLl8-0000qV-1i
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:22:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-413e9965782so2663645e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710325365; x=1710930165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+BI/6i0gL+6M8YL/8mPol8WJCNYmfxUuQj71ivY0tc=;
 b=crH9Bx1eyp7MoKwrxIySbPrgrdd1fukU+PeczUI9uaLzraiFMhwZ1xswp5W4IA5DKD
 ROnB9TQt0A4fg9cYSylnWUOETiOOIq3o5/MVWKshBBMAa7QO8ZtdHFqH2fzOFQNI6l6u
 FGQajaXnG1hH5iv+gZ1E9ktm6wxFf9aeqOC0UtbtdE7KZkcBox0yhj73lcV4wUTU75to
 WsUWasVb4uokuozaEWyb7+MSd9VDVViMAnt5FbF31jRWCG9EkLCVQeC9YGVYQwW8aaV8
 fCqijZt254mbWCjm5bqZSmAL+EgPmTDImobspECabx+T/pw0o0yWVYP3uIGSAjudgGcK
 tdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325365; x=1710930165;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+BI/6i0gL+6M8YL/8mPol8WJCNYmfxUuQj71ivY0tc=;
 b=DKVaoKTllFB4CDc+JrmNLzxdciQNPYeqldQrdsANEoZV0BgDbQVZovbqh7vjxoo3Zv
 pmuZ69Li1ZH+Hihf0bgtMLwUQsWFIFH/vb0qOY2DXP52ApqgyxOO7ufL3fMz7zIiDqSf
 83YGGoe0lb/KrPbabM6ewgGZSkWR5iiXP11p16U5WfXVU2WtQWo8VorFYkvzU31T9p8v
 f0GXojPUKrA5as38znQQuiAvaGj39mBE2hZlAIxXve7sXxieaDSH3ezTUb7TnTdD50CY
 feBLaOfLjGbi5twefBkkjqwLSCRwI9v9Gi54ABGpZrrSd5pRyRYNF0F34m3bper0vXK/
 cluA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOup3KgA0jGi2ek9FiRldT8BcOgGx9I+UyMrLcwEXERtJcUqOwGghzplpt8KrmMu6lChu5MPTK690SR8qty49Yt8Fb8pI=
X-Gm-Message-State: AOJu0YzRvDGgsOtOP+tqZ3JTc3jRAXrV04ddwWb3YT1YSK0pfkF4ARDQ
 n7GBkH3PUuT8OofJ/waaU4kmIHimA910YNWU5Lnyl+TwdpdoWKimCtRVtPldJ8M=
X-Google-Smtp-Source: AGHT+IFM/oUW0hiZuifrN15y3gGEf1hZ/G1eu6aN5V5iEr1S9gmkyoMz4dtdOw4I9V/V+gkFQvzpJA==
X-Received: by 2002:a05:600c:500d:b0:413:1828:b8fe with SMTP id
 n13-20020a05600c500d00b004131828b8femr2052759wmr.21.1710325365470; 
 Wed, 13 Mar 2024 03:22:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b00412ae4b45b3sm1874074wmo.30.2024.03.13.03.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:22:45 -0700 (PDT)
Message-ID: <b1607b82-cfca-4461-a2cd-ac3cf8344bba@linaro.org>
Date: Wed, 13 Mar 2024 11:22:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: document PCIe Gen5/Gen6 speeds since 9.0
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Lukas Stockner <lstockner@genesiscloud.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <7a27998637b347c287b6a1c1394669e2769fa8e4.1710312598.git.mst@redhat.com>
 <c74d58f3-ea02-4596-b5a6-15122709b9b9@linaro.org>
In-Reply-To: <c74d58f3-ea02-4596-b5a6-15122709b9b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 13/3/24 11:14, Philippe Mathieu-Daudé wrote:
> On 13/3/24 07:50, Michael S. Tsirkin wrote:
>> Document that PCIe Gen5/Gen6 speeds are only in QAPI
>> since 9.0 - the rest is since 4.0.
>>
>> Cc: Lukas Stockner <lstockner@genesiscloud.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Fixes: c08da86dc4 ("pcie: Support PCIe Gen5/Gen6 link speeds")

(BTW if you have to repost your pullreq as v2, you could
squash this change).

>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   qapi/common.json | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 


