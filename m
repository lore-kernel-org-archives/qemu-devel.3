Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D00C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf4yT-0004EQ-5l; Fri, 16 Aug 2024 17:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf4yR-0004D3-3D
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:59:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf4yO-0003Jf-Eg
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:59:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-201f2b7fe0dso17737555ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845542; x=1724450342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/dniErBS6hMq8xEq5Fg0wgOb71Iaca5X7TpgOallUVY=;
 b=xla403l87X2nq4ZcBimkOtSlLs1ktqUsA6C58pY67dBLjNxY9wNPfI3OtGbOMQo22l
 p8lJvwx1JnC6ziZw/NTXTwsx1h/CrU6FrBgtZVtUQ7LE9mnAIQzFHakKTRTdjdgFtoLr
 CgnLnT/RB2KWhNKBGZ6YqpNAa4odl7iJMy7RIa4o5tXKFKom+3NcPEYa4YHivGZQZlYF
 sj1uY/Qw2K1AFokn8P+AzRH9argUdn6MTtimtVZdCfWiSVXA/xe5MH+Xxfr+/ClcoQNf
 ZSxIAGYX81w5aJxDCrnk10desRQvl4xOyx12gEmILQpPG6EsvTi6eeXBO4Cjo/FYSaWp
 V8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845542; x=1724450342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dniErBS6hMq8xEq5Fg0wgOb71Iaca5X7TpgOallUVY=;
 b=lVZJAB+H6OHR82hZpch/TOmQbLahwO3r7QlHjpFWEKwNLo3usKsSmB06zRP719aMwb
 qurrVa2ADL4ma0gXpt2AyfI0FJiLQ58p3Lnvx2DPE8PeeEq4N4/g2cX1N8Wkln8SAnir
 AwfqAjfJ1u3CKlAhxwxNq78a4xHqUKXyzS9ovwbqubpOtF65hQKG+sha9QDfqKBc+ur8
 ZsYqBF47Y+uYmftLGUrIvQl8KdOP11zBEARQ57JxBzVyU/4fwCiKscryx/VoDxHx4K9k
 EzwWgsgIlVhw/Zee4uwJStWXxADob/9DRIf5h5WN27zpIoehfNQrpsTcHku2mFlJv+xh
 T9xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1N+5kwhrHdFuOJvs4aVN+029tWmaiMgpBKbgjyaITIvAuqp0LYYxZ88ENFWrvRp4kVxKeRqjOuEs2ZqpmlyYqFOmiFmQ=
X-Gm-Message-State: AOJu0YykGMrvbVTi52nGA67lb8bSD4khB+qCjZpqoGo0/aKqwWYx0CD8
 Ze4QI3sOmRkUyvSRl74t63A1UExfBzSBwnnZEkYhgxkFpNLtm/7Yy1ruvlD7gOE=
X-Google-Smtp-Source: AGHT+IFzo67zM7kbsvskdKDLTyhCW/2GWXALnhc4FL9J/SJaPQRG8FQ961Id7Doy57KHGZXfsY7HCw==
X-Received: by 2002:a17:90a:d44d:b0:2cc:f538:7cf0 with SMTP id
 98e67ed59e1d1-2d3dfc396a8mr4696306a91.4.1723845541951; 
 Fri, 16 Aug 2024 14:59:01 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2b65a3fsm2438591a91.8.2024.08.16.14.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 14:59:01 -0700 (PDT)
Message-ID: <78afcf65-cdd2-4b04-996a-38715cef941f@linaro.org>
Date: Sat, 17 Aug 2024 07:58:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
 <557ad237-9a46-4dff-9177-bd4b2108d26c@linaro.org>
 <87h6bk3a9k.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87h6bk3a9k.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/16/24 22:47, Alex Bennée wrote:
>> No, not a bug.  This is a host addr, right there in the name.
>> Returning uint64_t would be a bug.
> 
> No it's:
> 
>   * Returns: hardware (physical) target address of instruction
> 
> I was kinda assuming that was what the underlying host_addr[] fields in
> DisasContextDB are. Are we just saying its QEMU's vaddr of where the
> guest physical address is mapped into QEMU?
It's QEMU's host address of where the guest physical address is mapped.
That's why is says host_addr, and has pointer type.


r~

