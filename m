Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AD606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tfKLEzMA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOJjb-00063y-8a; Tue, 03 Nov 2026 13:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOJjZ-00063X-JZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:59:49 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOJjX-0006HF-OU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:59:49 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1815388a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793732386; x=1794337186; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjfyQfy5EO6T7cqM1mm/lGkAgE18E4V1yV903QuKr2M=;
 b=tfKLEzMAC7PwZxstzcppcxPFsrqPzjqQsujGbNOGlN7KygBoxr5YUw3yJ0M/uHNWqh
 mnk/76odWZggysDdJiWK2M+iGMcwcM7cGes0ywI6bH5wabdC+t1pU+oEnAi0eR0cf0d3
 co8RKN2z2cLTphfHTgT4YhB7uYxI0z8Fl1pguF1zhTq1AC404mLY1vrTOeS2+1CxtYkF
 DD9ZtG26q8elZf86VkWuZqd3HwD0ucjxbomvUidIutIeX6y/4ReJiwtrEa78wVPg7xVQ
 Lg3X7VF0ZnERio/lzSfi8IR5TQMGjzUYkgd80j3eleOJqzSoixGt9NEdq19ebgE4ZeHb
 XgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793732386; x=1794337186;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjfyQfy5EO6T7cqM1mm/lGkAgE18E4V1yV903QuKr2M=;
 b=mb3t7fZjP4Ihtddrjc2FBO/qapCW1ybIay/KU3UmKkT/kDtX5cWuxcCeRqDXxyuTYt
 KYk/BHhWPf9naqliGiy7uOafJNQ9VFdjRJDX1/ES+L1GUq95a2Av5dMyKloZMdIWPPwJ
 hjYxxEXscn+yxL4jlFHZ/U43sURFAuvybOzVDg8pJBecHhzJKsbTcsw5wK4UHwtEanP1
 SCgaNGxWjuzy86ExQY4BSUabwDb/ZGSz7Hza6iE1j/+UbXQXgXEji0FFhgm6V4egxfwA
 9yK/YysJm2vM9LjzsjEBRi2AaB0eUQYzdReynw2zmzGPICYlgy2KHC3+1o2Y5bJRft58
 P1hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz05EEA5t4fxSF7QoWDBwE1/vlVSNzplcn0u76T6DkJ5Dk/N8+uFf9Tjf1O4+HRQYHJsmVnYjOysZ5l@nongnu.org
X-Gm-Message-State: APuU4Z+4PoufNUO+0x99keB1qHvLkxFtFTqIHJsZ6Ed5nXOcF5KENaiY
 rRDSVvDOMTl+hqEqJv6zsNn/vhBsG/KCzfHxG0IAXu6N04tBVVzQjRiD9GyhbSP99go=
X-Gm-Gg: AYBFou2lICzsPBw/WgzBWX8e5Wlow3WmtSPo2Xj8MhydyAos94aEfcUy0XsViZ2SKdP
 hj25haSs0mu2g8RLji4+MtD1fvTXf4JlX8d3IoomDZkcXL5UxwmlCloJy9dTNyKVOov1vA6FG1u
 1K+ga1OSnK1V3UVsnsyhjJTgRhc80ZPgOXhssWFHO6OYQT8jKO5LtuYGTVP9CEv71Vh///ghC+c
 LhFi8eUouNSMQxERdG2SY67SorYkyhmRnyi5MeJRdR5nAMtqq0786GEpSPzKeF/eJxh9kH12JOX
 ufEldWAFJrVCpkMpn/b9UAKTeHKvFcyiVsYRYRJ541CvgYM9qiqPi3R40XlbPR+GW8uknN/V6BB
 juLW1d8Wg1OH4jaOOX8WluhfRr7sJ/ddiVHY6srP5obDMcb4dhfSlPXF3xaGCm5KDiDWsSq651x
 IUX+O/QxLXJep+A2ofWM8ZF+Mu4TGB0CD98J6XwBL5xNWY3lP3ur2hmkxQPIQM8XBcwVDoCFY9h
 2vjbQSqiIhWuGREu2eBclsFBtcDSibS3kl0GMIQzChiOVoTHQq835j+LpGWV+YfpsD6VdZHUBhV
 DVbMMS9JyEsTzqTd4W6DSOVIP705fDJDChlZ43SKGHQlg9vJtxBFQ2mc6TTlKJuv+Cx8kA==
X-Received: by 2002:a17:90b:4483:b0:3ac:9259:1234 with SMTP id
 98e67ed59e1d1-3ae8979ba8emr11422066a91.39.1793732385957; 
 Tue, 03 Nov 2026 10:59:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b09445f7b3sm264830a91.5.2026.11.03.10.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 10:59:45 -0800 (PST)
Message-ID: <102e313c-1193-44b1-9908-a03c01a85e8d@linaro.org>
Date: Tue, 3 Nov 2026 10:59:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20261102185831.1880189-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102185831.1880189-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:58, Stefan Hajnoczi wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to 3b68720390b98f21e26ffcff8874851b7b49b7b7:
> 
>    trace: remove 'trace_event_get_state' wrapper (2026-11-02 13:52:14 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Daniel Berrangé's 'disable' property removal and associated cleanups.

Function signature change in here somewhere that didn't get propagated 
to rust?

https://gitlab.com/qemu-project/qemu/-/jobs/17710633655#L4275

> error[E0308]: mismatched types
>    --> /builds/qemu-project/qemu/build/trace/trace-hw_char.rs:236:14
>     |
> 236 |       unsafe { (bindings::qemu_loglevel & bindings::LOG_TRACE) != 0 &&
>     |  ______________^
> 237 | |              trace_event_state_is_enabled(_TRACE_PARALLEL_IOPORT_READ_DSTATE) } ||
>     | |_____________________________________________________________________________^ expected `()`, found `bool`
>     |

etc.


r~

