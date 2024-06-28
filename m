Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60827C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3sa-00018i-6s; Fri, 28 Jun 2024 01:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN3sV-00015z-Nz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:10:31 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN3sT-0008CZ-8r
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:10:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9b523a15cso1593795ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719551427; x=1720156227; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1E1hnsuUCubjcB6nP5lLhn0PAZbUvR58+Bxg/S99Qk=;
 b=f3r44KJ6z75EeFW3kzo9AuNzOirJbGiIb7PSkAiMcbs+ClANQUX6Qr3X+2eBXdrP45
 r1E2hCWUSJ/6WZ0ol3B/AZZmej0vVu2Wq4i1Ht95qhPlU7em0Kez4hdr/D8g5CIGX9hI
 PoZpZNQuAqMrORGbHf4a5dknRtXYQ3l48pgbhV0cvJ0l/VAlErIsnYvEQFMhToRZqPCq
 6ZVWvL5pVqiNtkyi5iVMsvRN3xEiwJDJkN7kJ73lScW0VsrWd6wXaROk1M7BcYKTpGOv
 /vEpGXioFZDogciRwFTcIBMZLNuVZPlKIgr+op6nKocMFB95fzrTXtnG3Es+1XUCCCnw
 o6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719551427; x=1720156227;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1E1hnsuUCubjcB6nP5lLhn0PAZbUvR58+Bxg/S99Qk=;
 b=qdH+g1gVRti4qyn1gcg+v+ehKXwEE/v08uckHV9NRSst+43eR1hAVUpIbS4YlECKA9
 UV2nSz6NfiIIY405ImQTYGDkeM6t+dchsIVGMCo/NPL7HSWMFOGsQ+RO0q8QjFdAZNNj
 LrmJcM3lWWUOjixabrCJVB6eZaLT/zGcr271SB85x//vPc6jeb+LLvTPWF1QDeh6u/5W
 kBtkK2wo++rrwJy+ej5qix1gGMvq+YiuYYr655q86Xln5x7sh1wCXJO51mhvs0KjaVHQ
 RZjgx+MdXW8RCIYNG5MoErHd5/jbnBV6eBAZ06WtiQ7zJj7B63hzEDizbTBPdtjjfMg6
 F3tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7k5g40NsCdBinNCx8C40SDrNEHHL2M0ZhA+KpB7qguLuKXnnH3uwGHmlmy2R0ju7GLnanU/r/XGjuQ4186YVJm/fPBDY=
X-Gm-Message-State: AOJu0YxQqd3LcPXxQXxcT/M/f1wsE86kCUp7YjPEvWQ6q4KPxEOczy4s
 nSADeAOA6uuZTbVDO7lSDGL1sv0pqhCvoFN4ZxgAItR4/iLiHm22BrYRKnomUM0=
X-Google-Smtp-Source: AGHT+IGpvE6rcyi+V3Z317HA1so2/ltdFsRFTO4eAWrL/d1O/nm6lHpr8HWzw7DhcsKd4Ha0iIwSRQ==
X-Received: by 2002:a17:902:c944:b0:1f9:b698:3221 with SMTP id
 d9443c01a7336-1fac7eeca16mr7139355ad.21.1719551425784; 
 Thu, 27 Jun 2024 22:10:25 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8c26sm6355965ad.110.2024.06.27.22.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 22:10:25 -0700 (PDT)
Subject: Re: [PATCH v5 2/9] gdbstub: Move GdbCmdParseEntry into a new header
 file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-3-gustavo.romero@linaro.org>
 <5ed0beab-52d7-4072-b6f0-feaeb9bbb72d@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <58a3257e-d2d0-1385-9c76-9262a9d5dc7c@linaro.org>
Date: Fri, 28 Jun 2024 02:10:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5ed0beab-52d7-4072-b6f0-feaeb9bbb72d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.174,
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

Hi Phil,

On 6/27/24 3:02 AM, Philippe Mathieu-Daudé wrote:
> On 27/6/24 06:13, Gustavo Romero wrote:
>> Move GdbCmdParseEntry and its associated types into a separate header
>> file to allow the use of GdbCmdParseEntry and other gdbstub command
>> functions outside of gdbstub.c.
>>
>> Since GdbCmdParseEntry and get_param are now public, kdoc
>> GdbCmdParseEntry and rename get_param to gdb_get_cmd_param.
>>
>> This commit also makes gdb_put_packet public since is used in gdbstub
>> command handling.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   gdbstub/gdbstub.c          | 134 ++++++++++++++-----------------------
>>   gdbstub/internals.h        |  22 ------
>>   gdbstub/syscalls.c         |   7 +-
>>   gdbstub/system.c           |   7 +-
>>   gdbstub/user-target.c      |  25 +++----
>>   gdbstub/user.c             |   7 +-
>>   include/gdbstub/commands.h |  74 ++++++++++++++++++++
>>   7 files changed, 148 insertions(+), 128 deletions(-)
>>   create mode 100644 include/gdbstub/commands.h
> 
> 
>> +#define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
> 
> Dead code AFAICT.

Yes, that's a leftover. Removed in v6. Thanks.


Cheers,
Gustavo

