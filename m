Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B5FC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGbLN-0006xy-Dw; Mon, 10 Jun 2024 05:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGbLL-0006xj-Ng
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:29:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGbLK-0004WY-67
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:29:35 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57c83100bd6so746795a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718011772; x=1718616572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SgeVwZV3Py5E4X6cJdtDiUm/oqLKRGwhomy9+/s6+A0=;
 b=PapxTeaGF+CRE2IREw+Ey5fjYZsZiKwmAmkRX+dBQP8KZbeTSFNfSgNuz5qMyyC0Fm
 2uQZymUjOcVslFNiw/kZBHKXZSTG5X+Hv8ZjypsLfrhUxk0j4oW3fxSZbhL+2tLQTC0e
 8IrVyrh6sNMUkmVAKXAcvTvH75B0nDoNWrAY3KkJmAYnvfKsJlQSg8pcuM/swEAzlhh+
 knCpyvuSmXDz+feOI7gc+4AoM1d3LQ4uCzE0Ca0/p1XGWwp/qTSUPWbvcR8mzu30+Ecu
 YdZ7p7Scxe6BI1glZ+5QipjOb4ds2ra0MbpdFsdL/tUeFbieaBD/HYnOR6/TvbktfxqA
 SEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011772; x=1718616572;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgeVwZV3Py5E4X6cJdtDiUm/oqLKRGwhomy9+/s6+A0=;
 b=mGpO36YWPzZqeRwuLTyP6gL46psHJrEw8rzVOvjROFAa1pi1o/2MSUj+7F3JbNjYM0
 QG9E0V6fg1oL5bkRi7MGvCUCJu1CWVjXlwophZwLajWuCSTJ8nktgbxRmWoDLc3flBjM
 lV852sKtOmIAFGwm4ljPw+r+ifuIpw+Q0qS3lIdrCfNPxuPTvp7pVaTAcpYUbVQJ9FSX
 NKFkkyIEBxFXrG5cYe8S9n5jgrZ1Jy0I1khfEoASzhugNsm38YQPIyPvg+UPRxmbSyos
 BneNvFhlXC8nJhKVhQ1uuTLahz6fL3MrUxK7CNe7YYWUopdsCfS7iAlYWfeZ9I11ktM3
 HFsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC+4dEorWF930lRRKkQDDg4vjN/HGOll94tkWZ/KFqs7lZI8ye/vFaiChnJA6XcGjK8ZMXBjXg0SsnP0fktp+vvNxy0Aw=
X-Gm-Message-State: AOJu0YyhTEeRrhMpnEIL4BfXdByGBnQwPoiuoRckDDyCBmNU/iwZcY3h
 6L9hqrLuODw0U4e0VUAKeLslqOlV9GxcjB4hQczTTuHnrh8D7dsgLnBo1pURm3M=
X-Google-Smtp-Source: AGHT+IH+eljsqd0wVgSnZFIxdoR2z54Fr//heh3ojr2mT9EpEBGiM6rerJF1b3jfG5TA5b3AZjQzrw==
X-Received: by 2002:a50:9314:0:b0:57c:7ed7:897a with SMTP id
 4fb4d7f45d1cf-57c7ed78a37mr1431057a12.27.1718011772022; 
 Mon, 10 Jun 2024 02:29:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c75ab6297sm2736432a12.14.2024.06.10.02.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:29:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CE915F860;
 Mon, 10 Jun 2024 10:29:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/3] target/mips: Restrict semihosting to TCG
In-Reply-To: <aea6bd27-6c59-4257-ab89-18809444f8a8@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 7 Jun 2024 15:48:57
 +0200")
References: <20240530145349.41309-1-philmd@linaro.org>
 <20240530145349.41309-2-philmd@linaro.org>
 <c2kx2jt43pcujrfx3szs3wztny7i5bvb3gypmw73dpcf5izvbo@3ahkvdtgrfl5>
 <aea6bd27-6c59-4257-ab89-18809444f8a8@linaro.org>
Date: Mon, 10 Jun 2024 10:29:30 +0100
Message-ID: <877cex16yt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 7/6/24 13:08, Anton Johansson wrote:
>> On 30/05/24, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Semihosting currently uses the TCG probe_access API. To prepare for
>>> encoding the TCG dependency in Kconfig, do not enable it unless TCG
>>> is available.
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   target/mips/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> xtensa and m68k also `select SEMIHOSTING`, were these missed?
>
> TCG is the only accelerator they use, so it is kinda implicit,
> but you are right, I'll update for completeness.

So I'll wait for a v3?

>
>> Otherwise for patch 1 & 2:
>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>
> Thanks!

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

