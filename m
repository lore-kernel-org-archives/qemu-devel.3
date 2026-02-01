Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DD7E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfvj-0004TU-Gg; Sun, 01 Feb 2026 17:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfvi-0004TE-2U
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:28:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfvg-0008CD-M0
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:28:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso32099175e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769984907; x=1770589707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y3Zyhol3BGmPvUfenk9WcKkwT5d7ymNZRCPzmeKKV80=;
 b=KMqs0WxdFJwQF/2j5VO2tCOG7aQcvAGrMQgK7n7iwlZJfw6NZxnh0aBJrUSeM4O7jp
 cgbU/Etfr8097PTrfspxbWLEJ9kKar4MrrfOLDXC4h9aB8DFxHal0WNqZ7q0fBreQ1oe
 1YhMcH/LnSJh2KwCB3EdSZHd/0x4Y2hb/Y8GDq3OJNLMCx6d7h6pE+W6ZhDnuwX/id3O
 Jl9wJnk/7Jyh0ZoZMtK6aKjEZuaZPOrJ53tRuUCUPTveSoxFvfN66Mb5WqvV1aRS/ikr
 xquo1Oome1AQfWmvaC8oWwxX5rq0tzm/1bqD281oceIWw65k0VBmj5d55AHQ2T4r/Yen
 DSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769984907; x=1770589707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3Zyhol3BGmPvUfenk9WcKkwT5d7ymNZRCPzmeKKV80=;
 b=xTcoQXKpJ7euawcGh9O9eC2ohkWRgQP7PR3bRDb3P+7LXxDo+SP9CTBojMLwvI/m/n
 Q9xdpP9bnq0H3PQ9euWsArgqbRHy9t9yhGzJK8iVIJyLUrEnk1dBbdZZim5dzmJetEcA
 NpCuL8ImmiI7WcLzJehC6kNm1PLGdwpWyJLgSztn0S9acjwJLod2JNzyYhlsa9YMpTH3
 VUOJ7GLEdLnhj9VoRRsUfOov70OdxRv7++0XeLuxPqKuUjD7UdYI+IIbxyQ1xEj2zNgK
 8VGnVwbCPCWZMLffMl9+S/YKN5xFV2jHGYgto37P+QxPh8T4SqI7PfSE9zJXbLa8Srrr
 ADxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVMSoPuVlRVbcpOF2ibanJJlV98nzJ+KAbjVRaSRw/pyrA47131WvWkbZ5EWGQHmIih9p/EGV9vViH@nongnu.org
X-Gm-Message-State: AOJu0YxmSmzrR2Oj4NvQ32nyJYHGkhw3GgghVlJ4QOfFEzYQhAt7yHMG
 MJRvYy3k+A2nHGYXRIrCw8PJkgQHfOBdo0spcz3REhucSw2GI7QvRI/hGnDyIGBI1vIg9/Y0xwB
 XOc5KWEU=
X-Gm-Gg: AZuq6aKBZCrgfWrp4VE53mgQYimUIIV/kPdY4RECmBZirx3PDTrJazMyStE0DaxySql
 qVshyo4zTpTwvp96ruq5eERWolQw5B9AcQI09fpn8soUT3jPgVJSdkVL4HK9mQfg+eFjiVVAExR
 G2WlSPJ1hrX0/esCWHlIpmy2rddtU7lhvZ65CI2wWNcX8pzhIXoQyA20MdZvg2y+clq9TC2tYbU
 yihkdyY1V+59I0WxtNbPzPXFztQua0TLTIo66WrccT2/2lIE5WU71/3Pay4eqy4UzzM68BN4yCu
 1TQNNCmgOP+BqKYq0ZKIdTrfSqjdV+huAHtEEcgAuOb1cHgY5B4exraHInOjp672q95BpJS8lbL
 /4UMoFZeCxR3+PJvqoaaXVrPmW9N44o5F1oWpy1/pfi/ue7kZ60OHgO4row/6YetmuxeZd+QIBk
 s9MAvTFZqsFsra+ji+Dymbl8IivbI68TafTHzXSEEHW7AAhwNSu8gIW3QlGb4loAQp
X-Received: by 2002:a05:600c:c0cd:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-482db623765mr106869605e9.25.1769984907082; 
 Sun, 01 Feb 2026 14:28:27 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d98c8desm309472285e9.3.2026.02.01.14.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 14:28:26 -0800 (PST)
Message-ID: <41492c36-9207-449a-b1d4-beb980d494c7@linaro.org>
Date: Sun, 1 Feb 2026 23:28:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/virtio/: make all compilation units common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-7-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260131020100.1115203-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/1/26 03:01, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/virtio/meson.build | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

