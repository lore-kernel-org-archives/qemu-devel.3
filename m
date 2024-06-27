Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DAEC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs7j-0007yy-Qq; Thu, 27 Jun 2024 12:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs7h-0007yB-Dm
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:37:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMs7f-0006Kv-VY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:37:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-706683e5249so4463065b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506242; x=1720111042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zir7XKE6clBsrINA+C6iyEvgwriqYTxebHRJ3lzfqDc=;
 b=zbAqITYGrcY6Q8LCuAuan/XL2Rj5vxve3TSbDf6/jqztI9Hh8cnnrKKbEU2XSU16b8
 h+kwhlwvHkZc+bFzcKBRsega2xNPfwGqKHqMiw52T36VTyhT8JeebBUDF5LZ6bCCNIin
 3t2ca9g6H8RxVP2G4xV8ezD5vCh5jNt2a9efjhevYSD87pWInFLI/emrZ0ql6DrQIMdw
 RWDu01PPRRilOs8QX88hpacM+AQyle++wXDGgA9uixFCvTBaEcQUIvqIuUEqQZEKB5jj
 w8IhqzANwAjbajWn87N543UFU72psezIx2ekzrcSxYqQR6HOWFab0nV2XFwR3bsLxDhl
 Hq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506242; x=1720111042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zir7XKE6clBsrINA+C6iyEvgwriqYTxebHRJ3lzfqDc=;
 b=FiAZNB6RC8KnwgnUXkRuEneowrCaO4rQ4LdRccFAFk5wksCLlxSCd8j58uoU1qlMBc
 rQSqa5bgzbQCzS9iv+lSVlJ7tAXLYIVGxLSALIE/soAgIEuYhYdoAs3QsX3R47gwYF6Z
 20gQYRSXAkrKYyKW9XURXIZo24E5vZodsIsdOCTh2GFFWQTuFb70Rfo9FTSmooOC5j5b
 bVuoGz++HVmDxAXNt+xruY1b1RViyOaslOUi1ATU9Tz10MIcz8Lc5UbtsvXl2aPHKFlg
 PwvM0KoEbgOH8O01tqWzCNi5tv2YfX4ufGplkYTz7ooxJ/AIlQ30CLJ4A6ALcCovXpgV
 Q3aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjbk/wgcJDtEAa1SFjifaR3ONmIINo37InfEGMmPkL7kjqfu9MqPQJ+xE7rCH7uFh/8uZIKEGTDb4W4SPYzUru5g8c48w=
X-Gm-Message-State: AOJu0Yxbc68Bst5qufljIuTzFlNNAzTS5g8LnohjGeDWNhI5oDzlvnr+
 8JCnEARifa/SwcA5oNwN0y00/YKbxi+p0WCfrkRe3TRzE4d0jfjo2qCVd5Yg4SUGmQrx1BX6QHJ
 1
X-Google-Smtp-Source: AGHT+IErbMDlewixesMQUKc2WbwHaDAw2vd6O+lOYZdpz9PVLe/5iLeIXKFF8K+zDovZ9hHbJGMQZQ==
X-Received: by 2002:a05:6a00:b50:b0:706:8a67:c3a0 with SMTP id
 d2e1a72fcca58-7068a67c5fcmr14198061b3a.5.1719506242100; 
 Thu, 27 Jun 2024 09:37:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b48cae2csm1572321b3a.29.2024.06.27.09.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 09:37:21 -0700 (PDT)
Message-ID: <c91ef4fe-7827-4fc4-92a5-cfdb296fd216@linaro.org>
Date: Thu, 27 Jun 2024 09:37:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/i386: SEV: rename sev_snp_guest->id_auth
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org
References: <20240627145357.1038664-1-pbonzini@redhat.com>
 <20240627145357.1038664-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627145357.1038664-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
> Free the "id_auth" name for the binary version of the data.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/sev.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

