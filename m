Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D473F54AC6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52zb-0004LJ-Ur; Tue, 24 Mar 2026 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52zX-0004Ku-5b
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:44:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52zM-00081f-8G
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:44:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486b96760easo12566575e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774363434; x=1774968234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jj+Z3ZSW6zRWI7mPeSURHkNR2tbGWmRJyZFTKyjqj9g=;
 b=MAFNtNp0MhS2arQjTwOobVgmtKyikvtL0zUKUuq0UDzhH/cMy1XUfNcuSM/3t+pXh/
 1eLQ8lk3LeWpU9uBE0PR+JjVjJY0seDNP5odF7nizNx4Jg3HxwNqxAt2MvP+7iKG/AfK
 +xcGgiGcus9VdW1wQTOT4spN7nd2B1ViBmp+1EO68kBSiXqbzH5y3kzF6ce0XGhFa3aA
 S7II7eob97Fwn+SUvxBWKZzYsV8aXh6iU3fK3O7Vcg3dqa9Spr2kwTPed6JomqJYVwG1
 OZD0JQl0uPVQ7Jq5XXr3mmHdUnVh8Savmrbn9OLO6i0+S81jefJuHIlAt/6wXCSrMcPk
 Ta5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363434; x=1774968234;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jj+Z3ZSW6zRWI7mPeSURHkNR2tbGWmRJyZFTKyjqj9g=;
 b=JhMi8M8LViYDum08biqc7baLRwJT+Iup0cge4tVFQlzU13PH83lIft/E4t78JVeKJu
 iOO49uVm5xlqIDQqCGfdZR7jiy50+4TA+UkRidbix/1le4t18TA3bQBBVtHWagFg086W
 /klmP0RS2dEfa/g+fMPE9qw+IzMBwTBdeVemSdzTuXF6b84HuI28Fc6HuKPbN/MjzzmG
 1oz0sk08OXBY2E3CfFnxoqhPHXqjUo6iqL9k6xpcOSbuw5EbmKRgmNvt6yf+1wnq5VhZ
 pfiKdJJw9UYM+5ihJQ6lzLDnxRmYYBIB3KguhcvNz+dEG2FwArYmpICT1IL6nc0Qz/zR
 MULw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1BjJg1HEAiQohHWx/79YhIsBNp+/RuTMa96UN+4XPikS1+761SBFvOwHyRrDJttePpUMg5ItWz/bU@nongnu.org
X-Gm-Message-State: AOJu0Yw88rvKOu2WXH+Gan6UFLHCbVMzAwCL4i4pkO44bAZ5uS6sl4UD
 MuKicrA6sdqdNQbZp/WT+2xkFkNjMhcekp4OR+xad9ipenZrNaZ2sK0UBL7Fp/r7OypJ79Ozcmp
 o9jtDZ/Y=
X-Gm-Gg: ATEYQzwQianion1+N107ZUWYeo11KIyma2ph3Iht2GGAvSmYBLMYB015UvemUjzvdEK
 /go572lwVDP6VzxlpkHtBVxycreUHc0S5PMMZU1XtoRNG9SOuYTZgJnrcqlWIOycmuTf6+Ei1Ge
 WVCYUm6jAl5aMEm2Lp3WcpNdPrGhqrRYzOzWmoKcpNT+yr/Rw56zaM3COuXtC9cKdY/bO+wY+xD
 RTQ6QSyRcLV92HAbKAy5Jgy0H/xgxjzb38MbUAiog6srb53JZJYBL55Wjqqjqf8Wt8O3AYHe+mH
 UhO0Eym/29CgGYtjYXzswz1MdpoqtgVMn+5crMpGvjiuwwge/xAxjF8ujqSxYBNesNpVYoGK0So
 XSeULMnFNSp8efcrLrl7Cv7Y/VroDZGnJEgO0Cd3ksFnNQHSzvGbV3McMZNrvSgJmjH3uSNb7mo
 gu1kXlAc3Gad4CVMWZdGTlc9GLiTUj2E+vSaBe+QaIQMkl0OJOeydufcOdNPhCljpEgg==
X-Received: by 2002:a05:600c:4c97:b0:487:2b7:18d1 with SMTP id
 5b1f17b1804b1-4871609d1d7mr122235e9.33.1774363434381; 
 Tue, 24 Mar 2026 07:43:54 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714decsm34706153f8f.31.2026.03.24.07.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:43:53 -0700 (PDT)
Message-ID: <21126fa7-ea3e-4de7-bb4a-b0958cca54a1@linaro.org>
Date: Tue, 24 Mar 2026 15:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char: clear dangling GLib event source tag
To: Matthew Penney <matt@matthewpenney.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260305213308.96441-1-matt@matthewpenney.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260305213308.96441-1-matt@matthewpenney.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/3/26 22:33, Matthew Penney wrote:
> Clear dangling GLib event source tag when virtio-console is
> unrealized. This prevents a stale tag from being used, and
> maintains consistency with the rest of virtio-console.
> 
> v2:
> Use g_clear_handle_id() per advice from Marc-André Lureau
> 
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/virtio-console.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Merged as commit 34aad589019c8687fb3b19ba79d64d97071a7205, thanks.

