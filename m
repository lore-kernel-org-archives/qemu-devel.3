Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6847C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs6r-0006cS-PO; Thu, 27 Jun 2024 12:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs6n-0006aQ-GG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:36:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs6l-00067Y-Nb
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:36:28 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f8edde24b3so4837695a34.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506186; x=1720110986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m+7MxFZ179gL6V9ugFXwfjI0rGpqz9h29yxsVj1e26c=;
 b=QTbYA4OaCsqzVhj3xGy9hczrc/8TndS4U09nJGsEWYsvyZLG/NqEgKN2yqtfQk9Fr0
 +oqLcE0HRj/1fhHksjeemM+uEi3jeuORkRf0WV1Q2Pp4ZN64NWR2OU0QHKM7WtLvn1u0
 VZIBYHM0fWr5594rLEQw7zinc2JfHaGqh+BJmV4Ofeu4Fq+T0xx4KhZ4pchhuF8eMl1/
 DiEvOOv++3QtgRIKrFQnCHWZdzJ+U0ujRkyh170txV0pgbhmzPsRinSNrGKsy/sfM6SS
 85xxvSdjXqSU6WRrXL/ypODcqz9eJ4OQjp1moYCcmC0bKjU/FD36TLxF29h2J5lLd43P
 mQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506186; x=1720110986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m+7MxFZ179gL6V9ugFXwfjI0rGpqz9h29yxsVj1e26c=;
 b=CfIMCAYHzuHkScJZDnfaOpVag8gg9DVSI/SOPFjseGe4Aji6yZC3JD7HH8ij2cz4WQ
 P/SCScHQnqzALMGSoQtra2XCrhaPndL+yw+0CHm/Rt8sjqSj3GJBvKGHEMR99ZhT61yM
 7VjA7A2YP/xr0n8QjUXCe1bxqrrSCkkZJ4enLz75ZxnDStMdKa1pZM02PPL1vAuannfL
 8o/elOy2u2EXnHk1bfgxOdiPngmCkIYsDlnxcerNVLtuJksb9LYwV7n81mKfcJcYfPvU
 b2tjhrM3gb2nmi1iBdYU/uQgrUDBvekOfZs8eltPS0NM67y+ZJOqYI/byl/sPQjYsuHf
 3kJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0fY2tlR3XwMfdgDnVMD1VddP+0OMSzcJOGJP4bQRLGM69ZBIXifFWpanacycDzyObHReJ3k7Fdc963g352gN8xOaQKJg=
X-Gm-Message-State: AOJu0Yw8qKcuSzUIywBkgW6WCSECLXp9VVgN8A0cW4n1bdcmI4Pk4RmG
 JG0dUOUnW/NLS6bXww4Xcf2IUHmroYGOsNxGve9lBw0OQ1jqYjNDOWLxTAAsaWg=
X-Google-Smtp-Source: AGHT+IEro0UgF27lfUCl/SKwzRd7WykHGBsK/j6DYP5BPFMNSTzqCN3mKDO0t3ggaTquWyM5zPLiGA==
X-Received: by 2002:a05:6870:9a22:b0:22a:b358:268 with SMTP id
 586e51a60fabf-25d06cc05bamr15237209fac.25.1719506185931; 
 Thu, 27 Jun 2024 09:36:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a072e5sm1565935b3a.105.2024.06.27.09.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 09:36:25 -0700 (PDT)
Message-ID: <8912f4c2-c98b-49bc-89f2-7120b540176e@linaro.org>
Date: Thu, 27 Jun 2024 09:36:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/i386: SEV: rename sev_snp_guest->id_block
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org
References: <20240627145357.1038664-1-pbonzini@redhat.com>
 <20240627145357.1038664-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627145357.1038664-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 6/27/24 07:53, Paolo Bonzini wrote:
> Free the "id_block" name for the binary version of the data.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

