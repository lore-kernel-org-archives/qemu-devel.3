Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1C4C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLdL-00057W-T1; Wed, 13 Mar 2024 06:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLdJ-000577-Qz
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:14:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLdH-0007PP-UN
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:14:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-413ea3219feso2435055e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710324886; x=1710929686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PwhWyn50qXHO1bbVqKgZl1Y1vudx2oQCDhpVnkkHSsw=;
 b=AkriaQKYAw6ck+82OHVDjMXXCzf4lWFmpAndHaB6qUBpMiAqGu5L+VISf1QBT3rU/U
 C5V+uQKcDqPdMUGKPxvG72ZmNbJQHUZ+rqts6IM4lUJnRSV59x9gK+PXpknIkhhkPnVX
 66wogcgaFHsXwd6Tz4hzGJ7/W9QYD5gsUGkYYpj0hmIa/CR0EZ5XrzcbyKT+ujR1+p3e
 R8HAqbAX+YcZ3YSfwj4nufi4m69r76jqesAf8z9GhNMqo5GAUHTe2ia7BIGfKRfAQpd8
 /ADDD+IWCHjHMIRWLK+BMejP49hZpwf1tZBFI1HygoELZ0p7CRgcgmHMGsArZr1GE3HM
 8ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710324886; x=1710929686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PwhWyn50qXHO1bbVqKgZl1Y1vudx2oQCDhpVnkkHSsw=;
 b=KPF1IA4GMVCWX9h8E4l8dEAoXglz6F7TudFbAhkGGCtbVJiCRD0awMnVjp6uU3tJB8
 fUQOurxf7RhTm/Swd7751yxJPBjpN6uoTwe/tfkzXXOwEHnU1CbZFxZJudzHEPDfYViI
 xZfLzSDXKpsFAA3CeUykfg2sEHCzVhCXE5Ylzv35xMOlvBFoJA2nMQdgue+Jc0mQE+N/
 8Xd1f8aN+3KUgyMWB+SRDk7zF3ZKFSywkyUVq4IudpfAFqZ0U16IK1ZzMsXDQJCQEpPk
 MmTG/lCLzzaikhwTi04xLEOP0ASxaZmA8rbkN81Q9R9syDmZTcE+0eGq1W5554/j5FfP
 508A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbZ4idi7UPQcI0zAciXhCizRam1fd6Q+EE09T4El7hJq+LkKzPHB/bpk9PgWLChnuAGdt7ywCH9Kx2ODGXnCXUX5HKTKY=
X-Gm-Message-State: AOJu0Yz4ABqqFBDAdySg50Yslcv/fbQ5X1eS9yFs3lEJiws1cXqxdw2R
 kDTblddNqJM//SzgEwBch+ynZkmRInu5MHGGLyVe21RtCnvyNHcJH/GMXMbRy7Y=
X-Google-Smtp-Source: AGHT+IHvobvWl3pHWkfrGDFaEUXdU2c2AjxsVWkzUSusGf53GGgwuLFsrAqdh8G5jZITyAc5iFneTQ==
X-Received: by 2002:a05:600c:5404:b0:412:d493:19a3 with SMTP id
 he4-20020a05600c540400b00412d49319a3mr8716092wmb.12.1710324886207; 
 Wed, 13 Mar 2024 03:14:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a05600c4f1300b004130378fb77sm1867029wmq.6.2024.03.13.03.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:14:45 -0700 (PDT)
Message-ID: <c74d58f3-ea02-4596-b5a6-15122709b9b9@linaro.org>
Date: Wed, 13 Mar 2024 11:14:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: document PCIe Gen5/Gen6 speeds since 9.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Lukas Stockner <lstockner@genesiscloud.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <7a27998637b347c287b6a1c1394669e2769fa8e4.1710312598.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7a27998637b347c287b6a1c1394669e2769fa8e4.1710312598.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/3/24 07:50, Michael S. Tsirkin wrote:
> Document that PCIe Gen5/Gen6 speeds are only in QAPI
> since 9.0 - the rest is since 4.0.
> 
> Cc: Lukas Stockner <lstockner@genesiscloud.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Fixes: c08da86dc4 ("pcie: Support PCIe Gen5/Gen6 link speeds")
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   qapi/common.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



