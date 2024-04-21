Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FB6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rya9n-00061B-2z; Sun, 21 Apr 2024 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya9f-0005z6-Ri
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:35:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya9d-0000EJ-4r
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:35:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed627829e6so4113701b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713717300; x=1714322100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6t9EefEmzisuG1L2p4hGtTQ70qJuaPEx74sbOjwAts=;
 b=wfx3xiWPrldH2UKHJabMkOX+vdehxUlT0azTlsZBb6NJa9wf968xHCdqw4I5p2qOrK
 ynv9jo0IFtuqfdQ0u9XpI/JvDXU0N66mDQgjKE+V09RUnSE9l3nr4JS9bdXJPku4a1Dg
 wWGdb70a+tCZg57ohUkp3OFPQnDORuuLf6Tb+02uBDVNJ5jIwGInU5pyGnC8E5K5Lcik
 NI8qGDxWm0uJJJYNOur/LjN1Lwljcm00pe0g/KHe2A4sH6w/N9lKiRhGQJk/mZ1kNNAK
 nmo8ttRMzkhil7HBdhBATnsaRLhapllCrcfHlz6HPSMvSqhFC/gD6tIPrnEehzPKDgJG
 l7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717300; x=1714322100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6t9EefEmzisuG1L2p4hGtTQ70qJuaPEx74sbOjwAts=;
 b=VMjriqg1dFfSJ1p3GqdYhEPJr6wQ+HiaQdWpe2WglPbe9b1rI6A+qVnlxqRQqW7Wor
 x/FbQwkcsJpEHLyI77mZD1J4FDUe/gQvkxRiuSjDrM4THY9ZBwr+3pn8MIDrAsBBTfg2
 hUzFVki/u6s972RIAHyVWVkVVo3Fla/OVm9xHOdnwvXQ3cLQdImCHvj2TVbnpzN7hV+g
 Co9jvQwz8ykDa60rpT6jz9W/mIUoTiquiEp5jAzeTzZe480LpfitIj1FKgPqlQQk7Vc1
 WyMXm6s8B9ylvL1aVvyRUQq1VfI3wdItwqZpoShxh+HjqbVk6NoSOcpZmQf5naV6ogcL
 x7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDh6GKqg0jv5jlVrG8P6AGVokh1E90OVXoGZhJqlOm2oGmuFMavfottP3vm1aFv602yPDmF7F5OepvB1z0GO/xnfziRc=
X-Gm-Message-State: AOJu0YxgZ5Lb+uBhb2FYO2WqawDtol75bnQXGUcVEllEmxPFOf9UpdJe
 kNrl6Xh9IaEN122LRzXMCbs/R+9uHqfVvutyuAByPqZcg4LlbBIbEp4yk0+6Tfc=
X-Google-Smtp-Source: AGHT+IH7YQdim60+w8EMS96zvtkJSJdEYf34/+Dc/fkRjZYLoIdv2EQ1QOt2nfLrRO4M/uy7oPdm7A==
X-Received: by 2002:a05:6a00:1910:b0:6e7:4abe:85a0 with SMTP id
 y16-20020a056a00191000b006e74abe85a0mr10548531pfi.14.1713717299699; 
 Sun, 21 Apr 2024 09:34:59 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 k17-20020aa79d11000000b006ea858e6e78sm6313352pfp.45.2024.04.21.09.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:34:59 -0700 (PDT)
Message-ID: <d69a848b-0450-4058-8167-bdca2998d924@linaro.org>
Date: Sun, 21 Apr 2024 09:34:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] physmem: Move TCG CPU IOTLB methods around
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> The next commit will restrict TCG specific code in physmem.c
> using some #ifdef'ry. In order to keep it simple, move
> iotlb_to_section() and memory_region_section_get_iotlb()
> around close together.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/physmem.c | 50 ++++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

