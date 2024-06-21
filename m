Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B359C2BA18
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 00:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKSTK-0006eP-QE; Thu, 20 Jun 2024 20:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKSTJ-0006dy-HS
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 20:49:45 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKSTI-0007So-5U
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 20:49:45 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7e238fa7b10so57408939f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718930982; x=1719535782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sv4hkOrntD758aWSDNGWn7eZOQi7TmtCccR5SYSjfF0=;
 b=M/6ZcQa7ED3CvstyrP82IV7HxOUHl/dTN139DDn285Rws9cYFms/aOsy/NmCXudjhD
 Qqthsjvy1fj+77tF3vvoljenJ4vU1di3mi725xEEBz706BcS5kfYVK9uCA5pfuXi/jfK
 mR8cOfq5VyjRUFBPQo633N7xNoNr22jWq9pzr6oWXa7rSR159JMahIqWh1iuod7r+C2s
 eKl0Wr0lUBHx/RicPHN9Mabfj+XOthFf0rf9VcNzEK88BeN1V+d0JTDZbZU8YQR6TO7A
 MIZ4dsnlH+zICXuw7MvT+z9kwRwOWaDl/QzmmpXbUaGKF1AG45H1977dN1BvdE/u5/Fp
 8zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718930982; x=1719535782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sv4hkOrntD758aWSDNGWn7eZOQi7TmtCccR5SYSjfF0=;
 b=gZda/MRr91H3Bb5+doFM7bjOMWT99k2R331+V3MW02SvqGOa4tF1aHCFfP2vKs4mWo
 yti/Ie5TkJK21A+KhcgAk5e3K2Ty5RpLS+DN99kKne31Y9Zhp1NNzz6Qr4KvaRyoXm1e
 2iC6eyjXz7WNrNiGQZpSu9Ho/Z/c58keOc/llWXjYixt1KJ2SWXVcy5+GOxypi3rPZCt
 hNTOSAxnlafQaLjKu5ABaanAjsrf1GsnwX1YQh+Q/5HwTTRL5DbsTol6IRjOHBSQMj/R
 ZBYR4cYpPJvUoWRVnvXbncOYBhpK6JWKRRtJt/HELkhfYNd++Kd7CJbWgWcO41vD82I9
 dtzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCvxeWr7RceFcOzEQvNS/e14VUesfopWa5q9U0rnS0TWOgOvDPvzaQ7Gv8W2h/MNND//t2cKXekE5R8t/9jgLTZFvbxl0=
X-Gm-Message-State: AOJu0YxGlovszl3txpIFIOmOn3+XGas01H0//ZOuQkEDXHzYam0jPp0O
 wX0afb+LupEb57NscpVXTuayNrHPDI9J2tIUvZ089131/0Knz3YOXestVUJ0sPc=
X-Google-Smtp-Source: AGHT+IHkH0S1CwAVmiBW+5gqFpVn+L+tUlFB+tFAXXXAuCFC3tXdsty8mpYoM7eZBxT4DzbGZQnSGA==
X-Received: by 2002:a05:6602:154a:b0:7eb:81d6:c914 with SMTP id
 ca18e2360f4ac-7f13ede98edmr802605839f.4.1718930982202; 
 Thu, 20 Jun 2024 17:49:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716baf4acd1sm150873a12.75.2024.06.20.17.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 17:49:41 -0700 (PDT)
Message-ID: <ee45bc79-3120-4325-8bb7-9c670e84ecf0@linaro.org>
Date: Thu, 20 Jun 2024 17:49:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] gdbstub: Clean up process_string_cmd
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617062849.3531745-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd33.google.com
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

On 6/16/24 23:28, Gustavo Romero wrote:
> Change 'process_string_cmd' to return true on success and false on
> failure, instead of 0 and -1.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   gdbstub/gdbstub.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

