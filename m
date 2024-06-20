Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C07C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJJc-000565-CN; Thu, 20 Jun 2024 11:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKJJZ-00052l-Bb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:03:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKJJX-0004bd-MF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:03:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f992388bbbso8861195ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718895782; x=1719500582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H0iR1CqklhYsZeAcPYGBAPYi4F3ACQBXDV3k0qU66nw=;
 b=CQ62+7YA1bqnTcsA0AiuiOto+EHAcJCeXKKJ2qxyDeGyiGG8arZkAAB+U00JNjrVgb
 8Zr51gCE+zkmGZr3t9mae14x7z2RRJhoQF8m8/+GwXbeFcjyVggPHRfD9F0MKNUsnOKX
 AsWW3eWoBi+kDd8cPOkvSWMgLKz3VkTNBeshMZTbCrBgule8jp8xPBvQbmvyaDlOIOBr
 Ml59VikP1cHzVxNGq6836dHxukS3jZ27y1JBcjq06hF6rYtNYX3+rjqa7fTpxNPp9hzl
 oC0szaFc5y8vON55Na3z4TETLbKbBFq2+4IBiqvqeCraiZ/ye+miOZK5v1l3BoXHorSB
 pAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718895782; x=1719500582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0iR1CqklhYsZeAcPYGBAPYi4F3ACQBXDV3k0qU66nw=;
 b=O+CBLMoYQtLqy9z9QshpG4A+UdfrP5WqLBmBowlsAFotJhlK1rFgE2MgtgXOxOt56H
 3kyYkU2aSIA9Fab0AePBsSGbBpVmPftM+jgBu8nU8mdDodbkrxpmD8Wf5kouvuJGiuyJ
 BRcWJs3UHMp+hTmZLzfUf/jt9/xBb6o9T6zPLQ9HRZ2XZ7nR4PreoPr6MeWJ8IY+CtfI
 FlIz6CHxRZukYfvVvVsbwMPX0A0szjl7dCvvp/LCukfQ+rv3qalkwVZ6UXaFINoJznXy
 4K71MP7czkvrd6WM54D2ybi0G9YjwpE1QYK8OntZ/q8feWYC24iD1UFBozsGrHYoQX5E
 QZjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbC+jlnYajV7uAyO55UwYGxqiezZXnr8WGHhB+acTM4reUFZPBceEc5N6KioCbG4mmZ9meL728gPgQNhzSF5ngi1ENzb4=
X-Gm-Message-State: AOJu0Ywq1Vwn7e8Bof99A5qP+1gveNk8KmUDruVoB9CHYRi8MUpT14sV
 bRD+Hz5hCv9dAzEFJ1m1Yff/k9JXtdeJ5ak1OwnGXUOmWs8tx2UQW6uux3TeTNg=
X-Google-Smtp-Source: AGHT+IEb7MK5QgflqL7je+8bDBCw1SAfq130A1+AxaqyqwaF8yKVTHb8jwKJlEIARoy+xM/SpDSbHg==
X-Received: by 2002:a17:902:f64c:b0:1f7:38a2:f1e6 with SMTP id
 d9443c01a7336-1f9aa473e72mr63536555ad.43.1718895781790; 
 Thu, 20 Jun 2024 08:03:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f0580dsm137956765ad.208.2024.06.20.08.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 08:03:01 -0700 (PDT)
Message-ID: <64d018d2-ab53-47b3-963e-ad9abf41896c@linaro.org>
Date: Thu, 20 Jun 2024 08:02:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/i386: use cpu_cc_dst for CC_OP_POPCNT
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240620095419.386958-1-pbonzini@redhat.com>
 <20240620095419.386958-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620095419.386958-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/20/24 02:54, Paolo Bonzini wrote:
> It is the only POPCNT that computes ZF from one of the cc_op_* registers,
> but it uses cpu_cc_src instead of cpu_cc_dst like the others.  Do not
> make it the odd one off.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.h           | 2 +-
>   target/i386/tcg/cc_helper.c | 2 +-
>   target/i386/tcg/translate.c | 2 +-
>   target/i386/tcg/emit.c.inc  | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

