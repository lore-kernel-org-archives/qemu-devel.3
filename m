Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC28C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nLc-0001U0-HB; Fri, 03 May 2024 03:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nLb-0001Qq-Fs
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:28:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nLZ-0002MW-UP
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:28:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34ddc9fe4a1so1341190f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714721324; x=1715326124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Ts9qOZ10GlhUqTs/b2JsCFVWkQo27tep0tXXUQsncE=;
 b=UoObJ5zvjcEp2Le8xXfVR0iayKUmk0qizNxOopRXrCtkUNLH2f0mNdoBN8FkCreBOs
 tipGtLWuNi56YDh3uMsyJlaGqQdCHQbh/gkByjiFWzelJPSpcDMfayC1jrb9s99iJT0A
 Zz6JPOowr6Emgy2IjPIqJ8O5xYTj5p5Qi0gMOSpggRHy7nxTqtgw4J+lR/e20S2zfAtn
 KBRDcAkNQYpDTf1WJxr7X9Yjy6P8X2NRm2uK6JW8BWqo4V5ZTuKwAXtrWXTDIiiN6Xcx
 dg5svX/6nDgpZayhlWkSDaOY6Afwh27Q0CjoZzbB61h5LeHu5p0YC5jS23PN1T0r8lyn
 O7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721324; x=1715326124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ts9qOZ10GlhUqTs/b2JsCFVWkQo27tep0tXXUQsncE=;
 b=unwFo4cUed8NMVuSOx35euON+pKk3k3dsYTgW/4M0UskMTJKsZShAwKYexIRVlQfyn
 N3KgbofDSJoeoNnKBmRAb7v03686iHGJB44h/a9HDDQFeyXFn45dnqJ9qQS/29MYGVIY
 F3p1xfWD+Bq0FbfKIiM3iFLTIxkxylXyKkPFGGSTv/btzImU9R5g2fC/rHKBVvk6rwKN
 ZUDYLfm12RfHygG07JYGtpRirrdSI9+Yi2HH97HXO5jxhKZVnW3r/VtxjAhIUEZ6Bd6L
 +a5kwRmyB9vFp9a5LuBHqk3J3CIG+zg5WfdeWkLcE53JtW6spxauAMxQwpDXtw2qJFl6
 ZzSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHHscV0O8HSxWzTkq1vwwLnmcK+FeaZ8pyebnw5a4/B4Fc4bRQ2qYnizbTNPY+SE90K0YSrIAJtCSGQDkA4/l6mK9pGIE=
X-Gm-Message-State: AOJu0YzQ6TirmvqJIX1jtr6/e3TJ/8A2AsFCo1d1xPQox3oxBjDzh0Jj
 iJueAdn99y494yO1/QFe2OoYSYL5SN7p7JkfGU1QJ/N0mWEBeAzScgwzXXjMNvo=
X-Google-Smtp-Source: AGHT+IEf7mDvXvjkXZilyxXDj9TrAugMsn2bFVvtiMgLDGD1WZenfMqJDNiWT2wyP8h5wR8weKgckQ==
X-Received: by 2002:a5d:5644:0:b0:34a:687a:8f66 with SMTP id
 j4-20020a5d5644000000b0034a687a8f66mr1257461wrw.45.1714721324388; 
 Fri, 03 May 2024 00:28:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 g7-20020adffc87000000b0034d1fe44278sm3055320wrr.39.2024.05.03.00.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:28:43 -0700 (PDT)
Message-ID: <db57c861-e066-4fd0-ab25-ac1eb2a93b6e@linaro.org>
Date: Fri, 3 May 2024 09:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] qdev-core: remove DeviceListener from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> It is needed in very few places, which already depend on other parts of
> qdev-core.h files.  The benefit of having it in typedefs.h is small.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/qdev-core.h  | 1 +
>   include/qemu/typedefs.h | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


