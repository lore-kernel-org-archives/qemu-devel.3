Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6828C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYii-00039m-N2; Tue, 05 Mar 2024 12:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhYih-00039Y-BL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:36:51 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhYif-0003FP-Rr
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:36:51 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so44348415ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709660207; x=1710265007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=95nYO0UaFiV+d/l0+q8iJ/RyFhVI5G7HyqvN88MpakE=;
 b=quFNmExrtWmhEQNBlYvU+oDSxwrSxDFH0nzi0Zp/8XbQlEPr7mZ2ZIE2XSJiOOnj7a
 U5sEucHMPdqpIKrqWZMKdlpGbjKeea9sz6YW2MkR+ChT0BMQv07QnL7WyammVVlRJ9+o
 8ps64aHWi/vnI+5jEsDlmNdBePFAxWyHMXLgY0cXMgjTFlLWwhCnkNajerQqZAgGl2Ej
 +pptLs961r6rIYS4WjxX9DsdhUXknLrOWDYzBC2bMsbWtV7Akp+TJusPWD+mwLvIzKqr
 3qSUwRVU1JsW8EjXb5qd7fHchmUsKLXAY0b0sZ3Z1qkr+o+PIRK3ufGQQWk9X+rk2OA6
 aypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709660207; x=1710265007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=95nYO0UaFiV+d/l0+q8iJ/RyFhVI5G7HyqvN88MpakE=;
 b=wbw3N5iLiCTcqbvBCAL0VhC4hqd1YnE/IvWeKq5oVcaHyyK24O/v+klCR5EVu9WTnw
 ke5W4ZmV+omzr6u7Uj55jH1SL5f83Sdhp0W9jqbOnylGb8ruQnIKlQGILqoX9kw/EW0o
 S2XuYQNor7UMxGZmTAQ2fdQFA7yo9tlJy7AHe7YAibg7x+Z7D94I/ax8xUd6VAEmaDQ6
 +7XpGc6y7OZfBebJVavQ3rIPvod/dm+DYPjMhKQByO2MWPOHSgNeNenr3NWHina7gvDP
 y7ZmQukYJu9/3kbAhj4MP8OCRShZLDFtzTSf7+396E0F26MJgzPFOScQuUPbnuMaI56Z
 DgXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz1Jvh2q072ysOo3MRwG9sIGz75QQ/8EtcvxqovdIw2BGDHE3x8yORfgxUcLYlgcBMAAg0b6MoQbKu/qRgontrYi5ku7E=
X-Gm-Message-State: AOJu0YwJ1tz+1NKtWqHgZYCQCnpysM9vhfRokat8Mks7H4ujYBLspwUD
 1u27cgBDmVXv/WSN/oStHhr34CvauFejjmos2itAqktcf7O0syt4GOqn0pfJat4=
X-Google-Smtp-Source: AGHT+IEQSYLYiNoDcxBLv1+iWgqJv8X0+B0ne4lbDzuRUMycnwXEtb32OblcakrQAaWz0iZxHCNBcw==
X-Received: by 2002:a17:902:d2c1:b0:1dc:524:6da4 with SMTP id
 n1-20020a170902d2c100b001dc05246da4mr2793477plc.8.1709660207201; 
 Tue, 05 Mar 2024 09:36:47 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 rj10-20020a17090b3e8a00b0029996fd70e2sm9791677pjb.45.2024.03.05.09.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 09:36:46 -0800 (PST)
Message-ID: <7fff294d-0c33-4659-86c5-461d17840cb6@linaro.org>
Date: Tue, 5 Mar 2024 07:36:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] plugins: filter out the PC from the register list
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240305171218.3621274-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305171218.3621274-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/5/24 07:12, Alex Bennée wrote:
> +        /* skip the program counter */
> +        if (g_ascii_strncasecmp(grd->name, "pc", 2) == 0) {
> +            continue;
> +        }

The pc is not always named pc.

For s390x it is "pswa"; for x86_64 it is "rip".

For i386, "eip" is a component of the composite virtual address (pc = eip + cs_base) and 
cannot be queried in the same way.


r~

