Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66442C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEA4v-0001sw-Lh; Mon, 03 Jun 2024 11:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEA4u-0001re-LL
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:58:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEA4t-00065z-5p
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:58:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35dcd34a69bso3139218f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430309; x=1718035109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A5RRiVdQHLwMrDyuDk5ltQvUTNhrEjHn+1yo+nPkVx4=;
 b=WNPxfyK7BmCoZoDTQgzuqfLKMLgPPA3rM4/fZxBE7i0EP5NYapH4ny2IDEuat757sV
 MB7/Eczw531TAMStc8U3ljYDnAy4W52N8qme2roh7wrteGYME66Q87OCflDvLmsmmgyy
 h7kyjWYv8mJJI16DFHCje7ZKIVhZFCAU63X1vBSJq//1UOZnJZ44SbfQDkO7uAUNpBEX
 XNsMhPZ4fh7lDmBhhDaewkaBeCLPiO9tYXx7LliocMwEVjw2Wqh4oUCTgwdwGEuD1SNV
 ocZPTqJvyjbhhJrzku3X9qmysDym9bY2yC6mUUy+lYBmgZvykFaHWWE3D+Aal+IZWpL7
 1MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430309; x=1718035109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5RRiVdQHLwMrDyuDk5ltQvUTNhrEjHn+1yo+nPkVx4=;
 b=JVTzsDSOQTf7xFiSC4Pi927n25Hb6SBeuEw37P4nNJJUNzrth/D4lfdC97Ev8P7bxN
 khVjXt55Hmh37Ju9Jr1iUTdMSKi1edl1rEDbEP2qdVfyHvFQrb33x5AVIo5rUtT7PhD+
 SkhzFMbvfQf4+lIO1Q8kM4pEfEMu/tZfAC7fhI58hlfPYvt4gYL8yoP3lvpuxeO10G9P
 AubhixUI1ys7hfjk/6TzE/xSMhEwCsUqlRhGlPYtu2TRejf5l1dOvED//dWYvvt65M1v
 wAd07XDV7kKtzbpVpLuB9V6PuV2t7VCrrl9ZfDQXlrYN8cLzLQqdmBhB7yBIgblYJQDd
 xWzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPngGfrxiP/95kPoRTysZcj62dAevYJxUMW43i3/c1mtWcOM+IgpM0YU0bU9HbU23v7ewiYK1/mErIOt5hcgWWwWAr1Sw=
X-Gm-Message-State: AOJu0YyIJYKD859rWLjfa9IHqZzCP/tmCD+p1oT9XSRZSCsRzDgCo5qV
 6uSFaosBXfR6fwpG2qZAGd3JQmQtSLviVekLtKBSnRaNZh/O5xknroYNCKvqkco=
X-Google-Smtp-Source: AGHT+IGa9fuPHXdAbVSUNyirlT5EnGqPz1kg1z783F1lfhTT7iY3VbFXMPIL8UGMUtmxRK0eAijH9Q==
X-Received: by 2002:a05:600c:1c1b:b0:418:29d4:1964 with SMTP id
 5b1f17b1804b1-4212e00486emr78461775e9.0.1717430309492; 
 Mon, 03 Jun 2024 08:58:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42134555d2asm95386085e9.14.2024.06.03.08.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:58:29 -0700 (PDT)
Message-ID: <6a049c8c-4a73-4169-8e9c-f1cb81f1386f@linaro.org>
Date: Mon, 3 Jun 2024 17:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] softmmu: xen: Always pass offset + addr to
 xen_map_cache
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
 <20240529140739.1387692-5-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529140739.1387692-5-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 29/5/24 16:07, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Always pass address with offset to xen_map_cache().
> This is in preparation for support for grant mappings.
> 
> Since this is within a block that checks for offset == 0,
> this has no functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   system/physmem.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


