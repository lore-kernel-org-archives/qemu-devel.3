Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E523CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riezX-0007Rn-Dy; Fri, 08 Mar 2024 13:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riezU-0007RK-BI
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:30:44 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riezS-0000NA-Q5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:30:44 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e627596554so910697b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709922640; x=1710527440; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLb6M5f4Mbfef99Y+oYRyiFfhLkz4lf3ZoCaYvaeQyo=;
 b=NxjHrrIifyxjHetRyzmU8In7ZcCtibgm73of0povUn4nj3tyguzw37/qJ6SqU7EAtT
 Znyx6BWRiykf5FGNzw44XXsiLjix09i2CgBpd+mTtWZTHOQGlCRLB1WJGw4zY184dHzZ
 dDNzztAmT+6QYgFxhty/vDTAIuHr8hIxEKocOxW9tOwaER9VKUyDgCocJIT+i8m2xrlW
 TOdA2KQDD/7yGyiIQn0TJiHDge1BRQ6ej82S258Dbl5x0vhIBZJUgRuFa1GXjKeOmYj/
 RA3z6RVhyTpoZ9OsknNoOKOKBQJ4+ZL8OCmnwvovsKaleGFEwMxdwHWsbcEB56dfGprN
 RWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709922640; x=1710527440;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLb6M5f4Mbfef99Y+oYRyiFfhLkz4lf3ZoCaYvaeQyo=;
 b=moC8xqZWWtx88rKp5xpZnnmfqf6vME7Hau5v2CdqZr6BjClGmb1l1QrOykgiUL2yqa
 RZEpqXWZjC2UoWSb9cr4T1yc81de7j30qBXqNk1jWFF4LVUrle4kxkWxgOd4TSjrzx2G
 NWFRT20BwygQuIy2eZubPMzcZGsNlcVXJ07sfumWn+Xvk1ONZvmOIaQH3dhrWzt4JEOB
 H7EqzlU/dRCXL8rkIz/OJQ1VKytmg3KbVo+ockIN6QilSkFCWq62jdBWUe29Hznj2u8O
 QgJpuH7+hR1ZhXem2sNc+7HHvVEjPMu8Exk65YrON68/ZVivD4HWn2HyZwIZrAhTOuw7
 zfVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVukXrRV/5QLm7v8nMTkafdSkdzQlH1S36l4nuVrDg7vU12yUgGSFaaKcg1PGNr6daPMPt+EOcBhbq4uCdZIuaZULPoBa0=
X-Gm-Message-State: AOJu0YyoTntjtW5g86Iy/UmVlwq7Pzw2rntKaXY0F7DQIUaS27DX0BXF
 eCJjccOnFE354Ca+ac6OlklW1I4qgXsmOQ7tHd4ZwlPGbNTRonhSDXMo6SSiYq0=
X-Google-Smtp-Source: AGHT+IGIp9nDfUzHxd+1xFnm9eu52SiDMQVVOoLGW7zjUZT9atUpwYyTL2hbEvcqVF5VflSYJ+a8IA==
X-Received: by 2002:a17:902:9897:b0:1dd:5bd6:50c8 with SMTP id
 s23-20020a170902989700b001dd5bd650c8mr4378051plp.64.1709922640288; 
 Fri, 08 Mar 2024 10:30:40 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:7e8e:216c:3f1a:12a4:d415?
 ([2804:7f0:b401:7e8e:216c:3f1a:12a4:d415])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a17090341ce00b001dd1096e365sm10409679ple.281.2024.03.08.10.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 10:30:39 -0800 (PST)
Subject: Re: [PATCH v2 4/5] gdbstub: Add Xfer:siginfo:read stub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-4-gustavo.romero@linaro.org>
 <68dc0d72-ae67-4e7e-8c1f-670aa59e92c9@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <322b8643-d595-4ce0-1f11-5e6ee1138638@linaro.org>
Date: Fri, 8 Mar 2024 15:30:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <68dc0d72-ae67-4e7e-8c1f-670aa59e92c9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.994,
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

Hi Richard!

On 3/7/24 6:13 PM, Richard Henderson wrote:
> On 3/7/24 08:26, Gustavo Romero wrote:
>> +void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
>> +{
>> +    unsigned long offset, len;
>> +    uint8_t *siginfo_offset;
>> +
>> +    offset = get_param(params, 0)->val_ul;
>> +    len = get_param(params, 1)->val_ul;
>> +
>> +    if (offset + len > sizeof(target_siginfo_t)) {
> 
> If you save the siginfo_len from gdb_handlesig, you can place this in user.c
Shouldn't all user-only stubs be placed in user-target.c? Like
gdb_handle_query_xfer_auxv and gdb_handle_query_xfer_exec_file, and since
what controls the inclusion in the build of user-target.c is CONFIG_USER_ONLY?


> Is it really correct to reject (offset == 0) + (len == large), rather than truncate len?

I think this is correct. GDB mentions briefly that an invalid offset
should be treated as an error. Thus, I think that a valid offset but
a non-existing/invalid (large) length should be treated the same,
cause in the end data on invalid offsets are being requested anyways.


>> +    /* Reply */
>> +    g_string_assign(gdbserver_state.str_buf, "l");
>> +    gdb_memtox(gdbserver_state.str_buf, (const char *)siginfo_offset, len);
> 
> It seems easy enough to reply with the exact length remaining...

I think the correct is to reply an error in case GDB asks a data
we don't have rather than returning anything else to satisfy GDB.
If offset+len is inside target_siginfo_t, than that's ok, otherwise
that's an error.


Cheers,
Gustavo

