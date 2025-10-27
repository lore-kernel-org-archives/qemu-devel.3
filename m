Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204D9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJfo-0003MV-1p; Mon, 27 Oct 2025 05:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDJfk-0003MN-Ad
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:37:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDJff-00084G-OW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:37:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711f3c386eso33213065e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761557861; x=1762162661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPu0bqnsQhGYndXuHvbGgDJakg/DkGui2kIGOikK28E=;
 b=I9KVa4qRjnBZSaLflOGrisl27OkOMaDMUmKAJ0yr3XFVVfW3aRBStFhhKEbkkMkXFf
 0DGHvE6jZ4Jx91LRgP297mj4CodjqTQ/qsF2n+8OThlWiNKLzmIGrm64XaG64BBGab5o
 SwrylSB78vlhT02j/KPgnddZ5us995nj4+5h1xLvIPx/9v18HPa8SEp102dfn4TKoVX3
 SK4If8YvdVeeHJpAmlgSfEaKOWHd5tSoVPCPOg2nhhBHaxvfHd1+7yir/oXSbyJv4Kfp
 5bLQsK5r5j0IT/P6YHLy71s1DU+czEu320kJrJQE9NryUI8B5J/Wz3fTVuFaus6e7bFy
 BDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761557861; x=1762162661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OPu0bqnsQhGYndXuHvbGgDJakg/DkGui2kIGOikK28E=;
 b=nLAZjZcBWXqTRGU7xyroIaXT7J4cayHoLnjpeuO78X+GL4ramMbID0mV15C3c7edBl
 Q68/uZFH1MtAl1t93H6MWkJXaI+I1A6kI/HG40El49CuQz6F/sBjYtoyPWj7pC/qcRqh
 uI1IBLFDrPqGzU72zyGbDNCYp5MUrYQDNEyR2u3rS+YbwUii+Tln1MlS76NA5tQ+IDfM
 8llKEvwCkkzHOyCZaHSe8NxM5qzmSTaEgcs6Ng3pJI9ChI0GE86cebDb5ma0DNLojeGy
 EMlFBDvHFk4ZGmSy8PEXxv6Lb5eErRK6pUf+6htGsnF5oGiOsmyM1RrvlIS/goHcwyz6
 jDWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA9AFDRSNwYUaPFTf4NY4FRpnbbKrKQKgRkSErDllD4e3HFV+JQ3YCb9Lzu1A5qVyfrHPMqamajDcy@nongnu.org
X-Gm-Message-State: AOJu0YyfxbURmwTK+6KR+upkVZa5Cm0M0E9qqF5T1+lo19wbLHUhtdh0
 XOEE0moCpLq8xjtG9H+xdZyN74Sj5C8zA8wxqvd83S1eYJCc4/HDktpdwmo52Uqe6KFAqUSytQB
 SAU4LEUs=
X-Gm-Gg: ASbGncsycC0r323Sf4vTugaxnWE3QFKw4ZxsgCdWRzUm1LSDhygnF/owCeFRbTS1xC8
 OhjeAOGo3EMnxXm2iDLDDKnpjdLrccOtVzOhSKkYOtgGKdCu5V4vcMYoEjUtzkHBNi3x+94RNSN
 5O+x/pwa581kQ9YbnxaUisOGtN0Srd3TlN0WR4qOyE5MvV3xn3js6Xmhpy/FmMXDTYUji56dfPt
 i+YQ8V4o8mlDk2UxoQTS5545GcEWNVoEx1UvFc4aFvTWKtWyRHy9TSDuOS5IDs0Q27w6Jj6DVSj
 dIoYDojGgqX+OlRuqQA20wF4GmZWruSdK3uthOc8wIjmDHOfVBoGa4TT+tWXt1lrrhaJQ3ar+RB
 mFmhNAeK3zhKveA6F6+W/7adocBu6a+s/ZP2n+pAG1us6qP0szPSY4JAxc0KGzNdPr3FZvdGlad
 CuQT7Wm86y0kjMs9DoU2iz0/4HI8secQnwQVTLqNm+tg4Kbyy0yjd0Ag==
X-Google-Smtp-Source: AGHT+IGyCmS5pPS6VsK9tZ54aXqlbR5HTgx5nA/ohKKQmv2v+Rt8lYzchWc3iAtWCqQDiWDh5X8ASw==
X-Received: by 2002:a05:600c:4e86:b0:471:13fc:4ad3 with SMTP id
 5b1f17b1804b1-4711787847bmr318315885e9.2.1761557860963; 
 Mon, 27 Oct 2025 02:37:40 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd477c92sm126174555e9.2.2025.10.27.02.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 02:37:40 -0700 (PDT)
Message-ID: <8ab5581b-a31b-433c-b645-91b5c5734695@linaro.org>
Date: Mon, 27 Oct 2025 10:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ds1225y: Fix nvram MemoryRegion owner
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-ds1225y-v1-1-406888eb495f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/10/25 02:05, Akihiko Odaki wrote:
> s points to the MemoryRegion itself. dev points to DS1225Y, the real
> owner.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/nvram/ds1225y.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

