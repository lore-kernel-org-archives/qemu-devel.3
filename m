Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEED606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FJx3P7Tl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN72k-0002En-3p; Sat, 31 Oct 2026 07:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xN72j-0002Eb-16
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 07:14:37 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xN72h-0006Vy-FU
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 07:14:36 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-84a248254f4so1118885a34.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793445274; x=1794050074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WVv/3bkisRYRdlfFClJ5cDFn91epNXKOYWPEusM/npU=;
 b=FJx3P7TlWwdgIi8Hq31XBcb5BaG2g0kuVO2dgZVlcceyEjsLyCc0dmMtjx+eEHWCBN
 JxBq5kA37I+/MFOXSRc+EI2/vaikWN/7b4NwmuwTQye/BlD/ySIIwOe93NTJchqtYZ5G
 +DmsOrtuWGCsKBuxKS0rr11mAxzkbmUlLurnzpkSZPQdWP1UerABXAIEdm03t8wtiQEB
 M7MdWgbwsTqUKEM98SdWUhOHlLFA1+jck/nIQDrDnhw75IW5mh1MeiLVTaqUkxqnigLs
 3w0rbOyFXtbg0HoD+k0T369+DVU9YUICEkF7rxvtDq7kquYH0/A98L9PH6cp87W1/9Hd
 6ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793445274; x=1794050074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WVv/3bkisRYRdlfFClJ5cDFn91epNXKOYWPEusM/npU=;
 b=KXC4P5lyz78MgRaLmsx9SiDp31wefx3KDxOTcKEvDp4qoGOSLb6aU3LitXOK9Y1yKQ
 UqNzXAxMC5dKBWSDSf+aKQf7zBwljIzvaOqn6K6/468jEhflyoSl0ElxnpiOvqPqtjke
 V3DIRMtAfHamfukaB/vt6VIaNfg+89OY5eXUHbgkLZjfJ41uXUimNKuSj0Jh0BDOM57M
 rawMfpxz2PH2tp/HSGSsazM1X6eP1bk+LUBoJ75cMViUcVTi+f8ytB6qz7N/3OA9TQjl
 lQ2rTtw8d+ZDXFM1tqIxGENP7mcP2jQhzBE9W2G7Hwsaioe8flxGLWgqnttLbxohwqZA
 3Q7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByZ7xgMUrMxdylVBAD0wdo+bXGZabDF5gIjRQlsT8NgD35bzyx1zh6jCBN2MhK36dpr3wZrF194aKDE@nongnu.org
X-Gm-Message-State: AFq9FYKqGTpSj3oIYJjRaxLYbbHgZ59dcGFk9OC5gEgFb11G1E7EbwjE
 F0RHgx0aWPeF78stO48uP0vmneAlDB9DzXq9l6C6EM2Pn47dqd71XOUg2/sP+7KdJolf6buDOf8
 MJ9yz
X-Gm-Gg: AYBFou3KchIeSDxgionFFa/FASLgnrb0VByGbq/Haw5PAX86YgWnlq4i/Eb1/Y8OVh+
 9j4xe2VE0tK7HPO9JQ+yoU+Ep+0XEPcqiNp0SmwRyCYxx2HFaGWx56vhaariMWMNr+LiFGkIiyK
 t4IcYy9rJBx7GMatgnRgSnPopDSJHcmJj36bV5unximaVpJ8P+CLpx5VGEuNJnIkGnq/KUcrKeU
 mchUAbvG/+eJYPcEovh3MVJLZhiL423pHujPINsr5nFylxkly1kiZqTZs3AXdXsPQqX7QZN4/Q4
 oSbdOJinK5rahX5CHcTDdUMJe1kgI2tdiRyu1t9A8AsCO9pvuglaDfPwZlbnbDgLJDqVWhBkOT2
 Q2v1M/YmM/6/0ro4b2wrTz/rc/nQpee4YjPHMBtaNNCGE4bmHTkceZANySMNemrIhFs+K+73RfG
 cKmSNIEtrz+Gr+kd6dNAQ6lWSKaEGl5vhtsjbRlENfa1mKDRu1cE/LM/MNNHXPdhQmkb1o0efyI
 DxsuYIioT518jz4XLxidUYyXo9x9+ZrVoXXgra+QOzeIGpPYDhh1zqqiuM3k7FkRFUs9MeaM4de
 h5vw8oShxRPbRwDZO74DXQgcq0tuW2mA3kffrcV4hc/4
X-Received: by 2002:a05:6830:82f4:b0:80c:d34f:5f5e with SMTP id
 46e09a7af769-85d364551c5mr3484059a34.23.1793445273657; 
 Sat, 31 Oct 2026 04:14:33 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f2325sm4253637a34.20.2026.10.31.04.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 04:14:32 -0700 (PDT)
Message-ID: <4011645a-aa55-48f1-8b0e-83379fad7a62@linaro.org>
Date: Sat, 31 Oct 2026 06:14:30 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/10] Various ASAN & tests fixes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 16:14, Marc-André Lureau wrote:
> The following changes since commit 7f36b1fbeb1f6f070cd5f8eddb3edbcafac15440:
> 
>    Merge tag 'pull-tcg-20261030' ofhttps://gitlab.com/rth7680/qemu into staging (2026-10-30 08:16:19 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/tests-fixes-pr-v1
> 
> for you to fetch changes up to 02292db33e050fc68eec423c27d459ac4c28694d:
> 
>    tests/xilinx-zynq-sdhci-test: fix GIOChannel leak (2026-10-31 01:13:57 +0400)
> 
> ----------------------------------------------------------------
> Various ASAN & tests fixes
> 
> A collection of leak-related fixes.

Applied, thanks.

r~

