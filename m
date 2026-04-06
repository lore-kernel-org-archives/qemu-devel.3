Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55811E9D82F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 02:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9ZW3-0007yd-0Z; Sun, 05 Apr 2026 22:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w9ZW1-0007x6-0V
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 22:16:37 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w9ZVz-0007PH-2s
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 22:16:36 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso1964932a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 19:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775441793; x=1776046593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJA6+fg775IADfa/WyjSBl8TTwVrFF47Wn72BIAPQpo=;
 b=OvhDyLC8bt+rfi8TVV1pnjVWDOKkKMdcA6L6PR67uRiZnsMHqU0sNcZuzAgiFK51rs
 QLPO2F12n7jsMe/73/0F/tlbs88kinuYH44JtzLllUU0DK43pftxSR3sOkARKh9jsvCN
 IH003KOCjMFxVo/0EFO2bJlKpOzXdPW34l7viJefQG9mvho9XNZYp+e3b0RTpaz/YrCq
 P9hLohS7/sMn5DrbiLTf6yv1zkB2LN1Ui/8mfonEGeRCVxD01rCbTaIxqU/Mh5ixPZEQ
 wYEKt0x51c/6roNgj5y6SMCec3QWhY5lJPcFL3AcsYY/JN19IviQkEotUqT6LMlOLblG
 +hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775441793; x=1776046593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJA6+fg775IADfa/WyjSBl8TTwVrFF47Wn72BIAPQpo=;
 b=r2wqNMZJvn0tBtob30DJNBOIDMmNJXrxtTIEuUFhXNY2tAQeFDiWJAaNY2tLm+kjvS
 2ZRjSoafWFJLk/qMiNJDzJHxmbVWnBuOcXaI21OonXeBWFR61hs/rQcYh5MW6LZv1Wj8
 d1pEVo8QCNxjju/mYYSac0Ao21QRHLGBgHP8UnfVauzjUNHUOoodIHHOMYYttcwD9YFf
 v/8jXWAZCZwyD3TR7wZjwgiqvxLgvQ0oL3m2EhbVTW1gCbp23ZYPSP7D2IqUO//v3jsk
 UQG5ALxnd24P/1WQKsRRkHzbMxY9CRbGIf0CLX6nLUX1dOU+IMv3zrlRFb5xoAI9GpWF
 tsXA==
X-Gm-Message-State: AOJu0YzJ4ct6GQ13apn3t+LBkn7WtE9rQkAOnKIvbo+CTBQtjifIf4YA
 /vDjC4Y0+TwNJ5OypQtEcUeGgbe+v9aHcf6H664/hESPPuNPlWM+rU7b
X-Gm-Gg: AeBDiesQfM9NoiEJdW8zasK7LBrz02FLMQ5qLDo0y35zJEZuZwl/bo0EnpPf/5rYc4F
 INb38Y+T1orfFfWNaB+L20csU5cAd7w8fO0r2PouBEHeaupe7G5syHznwCkqYci9r/vYJrHdk8G
 KPCHoXaxx6q8NpUuTaaHUdCx/BrfAow9zu5qvpQnzwov7dw+eW6WHdpl0BjWdXKA12fQfhAF6dh
 cQstchNtQNnsevx/O1+L/OTIQ0B1TfVBeTgMpZwB9urPl3ot6InxRXsBuw84RqXJUGqbL+ufhf/
 qT2dJiSkK8g0KxI95/cvBz5DRwJmC2AK/SnRvM8LguZeGesDAFrWZEO8n/gajbrUz1f6U73k8YG
 zkEcxQxeDOEf6oFMOrNRc9LN6Gt2N7Om4FEHNmXqRyzS+ez1tXvJdsme3GqrCm+qLpbw13+gOCt
 kW+CESL2EUOZIR5VD2IuF7BsAMffj9pyIv9Iyk9oKS
X-Received: by 2002:a17:90b:4c8b:b0:35d:a2d3:5c44 with SMTP id
 98e67ed59e1d1-35de69d5567mr10099866a91.28.1775441792922; 
 Sun, 05 Apr 2026 19:16:32 -0700 (PDT)
Received: from [10.22.76.24] ([111.223.92.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe5e4ba7sm17291225a91.4.2026.04.05.19.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 19:16:32 -0700 (PDT)
Message-ID: <c09476df-123c-415e-b69a-b3ab2efc6715@gmail.com>
Date: Mon, 6 Apr 2026 10:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/readline: Fix out-of-bounds access in
 readline_insert_char().
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260402105150.274595-1-phind.uet@gmail.com>
 <CAJ+F1C+JxRRmaD+GZ_=F=kh3sjjr_f+Us8LQoGVPSn5Ue_MzLg@mail.gmail.com>
 <bce0d2e8-c06d-4158-bee1-476293458f59@gmail.com>
 <CAJ+F1C+kJ_jS1J8e9+ZOc-ENofusJ2kAifGzz1hwg1ob=D=hdQ@mail.gmail.com>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <CAJ+F1C+kJ_jS1J8e9+ZOc-ENofusJ2kAifGzz1hwg1ob=D=hdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=phind.uet@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 4/4/26 21:52, Marc-André Lureau wrote:
> Hi
> 
> On Sat, Apr 4, 2026 at 11:32 AM Phi Nguyen <phind.uet@gmail.com> wrote:
>>
>> On 4/4/2026 2:41 PM, Marc-André Lureau wrote:
>>> Why change rs->cmd_buf_index < READLINE_CMD_BUF_SIZE to
>>> rs->cmd_buf_index <= READLINE_CMD_BUF_SIZE ?
>> Hi,
>> my patch is actually change from
>>       if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)
>>
>> to
>>       if (rs->cmd_buf_index <= rs->cmd_buf_size &&
>>               rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
>>
> 
> Right, my bad. Wouldn't it be a programming error if "cmd_buf_index >
> rs->cmd_buf_size" ?
> 
> Maybe make this an assert() ?
> 
Hi,

That's right, I will send a new version to add the assert()

BR,
Phi

