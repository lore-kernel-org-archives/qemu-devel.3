Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E93CC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjtN-00052v-4L; Thu, 29 Feb 2024 12:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjtM-00052d-Cz
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:08:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjtK-0001h9-FY
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:08:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d153254b7so760529f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709226497; x=1709831297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3cpsKVEi1A4vw5ep7BSjuLFvqcui+495yWBbf/0LF0=;
 b=VE50P1Bmm6oYsJEn3xo5DiKsjCsvZEwu+8IfXfdeR/eJ3XQ5dtatg99kqJX/uOt5qj
 rvPR4feflGoRvXuA4Rpd9OaY5CioxbYKzWTFW0HJOt3yAGQMBdGbeZRp3rjYDXe/NrSV
 vMvTAsrY82Kof2jWPAQi37dqaCxTAIu0nYcIyzzuziDFAmq+kurB6Qy2Rp85tCZMKHPo
 FTIKfXuyUsP7MEDKp762OjwQuQLVHf0WcAIUYYcYNEWRLTIx0EsWDo2jcXqnABTeZouX
 /dPDAPJTkMgUOuppnZhYPpIwsNMx5jSm7f3PyvIOOeoJyeY0WOVXBTE54Gc1pl9JztPE
 FSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709226497; x=1709831297;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x3cpsKVEi1A4vw5ep7BSjuLFvqcui+495yWBbf/0LF0=;
 b=SL9QS/Q5UPbkJ2qIAuVVOZmhT6ifJmjERr1fVIkdVF0RRt/afmjEKXnnaWAgWhjThu
 e9U015PnLUHItSXWeYpSMDaq9arRLPUHfmN0IYebU7YrCNHsBF+6m9O1Y+X693LlUqDi
 Ro/KFV36yDhJtJqoz/8eS3tBc9zBFn2cH6fx2plIXgg3O0a3j5NZKA97WRgn3BwJEnHx
 jEOa0SPSsCHSf7Nhtnm5QRX+NATtV7ESToOau3V4hlIJzTEzGQqtQzKXKvq1yD0Ix7vN
 GMG/YrWTskZ7ZGcNSGT92SDM7gZHNBn8wHCQsqm5OYZoWhc8XF0pcz6irT0EMaSS/qhf
 +EhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURB20DvJTqfZMsrwxie+jl8qsXCH/S5Avul4CgSsbVFtYZ8ZdmcLuEoHG7tG+w5mrN/XooLgt2ff77gr5umkLPpmIibcY=
X-Gm-Message-State: AOJu0YzNlp/duMuUrZakgDOYU8KBHri04e59AkQ1tG+HelwmwvVzeHFT
 XdfQzo/nlQjMZ5CuvGCmpctvUsyPa8dANgGNVOZjc7ZM30RmNH2AhXLevW1UBGk=
X-Google-Smtp-Source: AGHT+IG+3XqnXrGxntfPDXe+WVOZXh0cTUPlmXh1AQV8NTdY4MbJhq6RBqEANbojdsMOMlSGMWxdlw==
X-Received: by 2002:a5d:4f88:0:b0:33d:2472:eb8c with SMTP id
 d8-20020a5d4f88000000b0033d2472eb8cmr1916102wru.19.1709226496743; 
 Thu, 29 Feb 2024 09:08:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bt26-20020a056000081a00b0033dc3fe1046sm2305573wrb.77.2024.02.29.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 09:08:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 07F285F885;
 Thu, 29 Feb 2024 17:08:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sven Schnelle <svens@stackframe.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH 0/3] plugins/execlog: add data address match and address
 range support
In-Reply-To: <20240229150729.1620410-1-svens@stackframe.org> (Sven Schnelle's
 message of "Thu, 29 Feb 2024 16:07:26 +0100")
References: <20240229150729.1620410-1-svens@stackframe.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 17:08:15 +0000
Message-ID: <87a5nj6vwg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Sven Schnelle <svens@stackframe.org> writes:

> Hi List,
>
> this patchset adds a new -dfilter option and address range matching. With=
 this
> execlog can match only a certain range of address for both instruction and
> data adresses.
>
> Example usage:
>
> qemu-system-xxx <other options> -d plugin -plugin libexeclog.so,afilter=
=3D0x1000-0x2000,dfilter=3D0x388
>
> This would only log instruction in the address range 0x1000 to 0x2000
> and accessing data at address 0x388.
>
> Changes in v2:
> - rebased on top of latest master
>
> Sven Schnelle (3):
>   plugins/execlog: pass matches array to parse_vaddr_match

I think we've lost a patch in the re-posting. patchew hasn't seen it
either:

  https://patchew.org/QEMU/20240229150729.1620410-1-svens@stackframe.org/

>   plugins/execlog: add data address match
>   plugins/execlog: add address range matching
>
>  contrib/plugins/execlog.c | 95 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 16 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

