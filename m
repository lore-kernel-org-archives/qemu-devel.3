Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7146CC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmGUj-0001jb-Am; Mon, 18 Mar 2024 13:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmGUh-0001gO-52
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:09:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmGUf-0005aD-6H
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:09:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e036b76725so5404025ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710781787; x=1711386587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MWnQGFFggnDL0umUTjk/Br6lRKLYQ129nftTmiDoAlk=;
 b=k3bJJUUproFofHHFLeJqIzWl0FBQVe+DLwdJrc9g+MK+wxACdGjOejjC07rIaABF1v
 CgPVJxEgvHQr3XW4AQdlm6rHmPu3AW+QXOhw21jqKHrz0fzSsctZAHSoicdDckT8iAVO
 gscBZcybo13HvoQGTva6JYH+tdnRfU9i1BAvuyAyDsgPdfSvHbcq4yzF+IWbAu2kRsID
 PbXzBbWpWJsiw/0IN0Z1Ppkjx3dzADLEu/u1bU5SpJ3OKXMVeCdchpVE/+wuV7PiTyqz
 aw9Tg8gKON7sHkC4SuumOVGEJj6o+YgBD7ggo8Go24lggIO8L3A1pNOmb3K4PNS37Hbv
 VXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710781787; x=1711386587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MWnQGFFggnDL0umUTjk/Br6lRKLYQ129nftTmiDoAlk=;
 b=r9ILOpStrBXOnGiiAfMpJUf3QCpRnOHto+xB8faNLVPB+kR2e1pYAfTarhVD7BGFEa
 eGqMtnzqEXAC38RipxCoZe218yzVXM8RvlPTv5TXV5hRl7HRd1sCGKJdt4eKMJJRuJwd
 9shvy0KeL3ZinPpByZmArlJQMDl5w8KVT7nSjgtlV79myJW+MYhxKzCSWWIKw3uTak6d
 8tXcGmULCZoSER58opYz0lsGf3LZCdd04qOL4tdPub0bpnyUqEDiYUnZzOLQC0+6Wank
 kp1tkz8DVzm5SduTHOyxpPVkcKhlsvjS8tsN/swjE7+5WfkuIWoPrYlv75R6Mw4J3Qtx
 PYCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfDDrOuklmJAY1pcm88vMSXJLzehErX6CeCE2yyXs+dq96EBKnq0JsHF1d04OcUqEGnpvrrKI3rLkVT7Mje1SENgvdH+0=
X-Gm-Message-State: AOJu0YzTbTrTAWFB67nzvwK3EQozaRzrqD3ichZ2gGRLNZ8Hln+p1tyb
 QmrWVip3R2MpvVhUQVFgOfHx0F08GJjOJlbBPZQsZpMsRrHzhIo6RnxbGZRE+pJbGiXKM/WoK0J
 z
X-Google-Smtp-Source: AGHT+IFVWDVIZ+yfvrPhhdWGkLKcu5kwRApzX0hOCfyHCbESEeZilaH1fIedmQeVuMj7YWDyDum9kg==
X-Received: by 2002:a17:903:2281:b0:1df:ff0a:7130 with SMTP id
 b1-20020a170903228100b001dfff0a7130mr308331plh.33.1710781787617; 
 Mon, 18 Mar 2024 10:09:47 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b10-20020a170903228a00b001e01c1124absm2928654plh.171.2024.03.18.10.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 10:09:47 -0700 (PDT)
Message-ID: <60c3fc50-9b48-4f79-b9b5-2ba08c2faffc@linaro.org>
Date: Mon, 18 Mar 2024 07:09:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] 64 Bit support for hppa gdbstub
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20240228201434.1515893-1-svens@stackframe.org>
 <87sf0ouk1u.fsf@t14.stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sf0ouk1u.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/17/24 20:32, Sven Schnelle wrote:
> Hi Richard,
> 
> Sven Schnelle <svens@stackframe.org> writes:
> 
>> Hi List,
>>
>> this patchset allows to debug the hppa target when running in wide (64 bit)
>> mode. gdb needs a small patch to switch to 64 bit mode. I pushed the
>> patch to https://github.com/bminor/binutils-gdb/commit/fd8662ec282d688d1f8100b4365823e57516857b
>> With this patch gdb will switch to the appropriate mode when connecting
>> to qemu/gdbstub.
>>
>> Sven Schnelle (3):
>>    Revert "target/hppa: Drop attempted gdbstub support for hppa64"
>>    target/hppa: add 64 bit support to gdbstub
>>    target/hppa: mask CR_SAR register writes to 5/6 bit in gdbstub
>>
>>   target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
>>   1 file changed, 45 insertions(+), 21 deletions(-)
> 
> gentle ping - if i followed correctly only one patch was reviewed so far.

We can't really proceed until you get your gdb patch reviewed upstream.
All that will happen in the meantime is that qemu make-check will fail.


r~

