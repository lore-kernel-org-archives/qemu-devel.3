Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E78D32D97
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 19:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAwaT-00031r-JT; Tue, 12 Nov 2024 14:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAwaR-0002zk-Oe
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 14:30:03 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAwaP-0001Yl-U2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 14:30:03 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso972598566b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731439799; x=1732044599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eb/hyjEyBdVg3oj2DKt4wC0cY9gb+CsfpTS2HbjQ9MY=;
 b=ERicZTx96THch+b5QkqUVMgTWl7zuk+tEoGOo5sJAuoQgo2jl1qwxosBuUmZb17Tan
 lAIJVziPRlzbJOLQqHe7KrbWTytFMB4U4STxsG1Vdc6wY1cHiprToeMeXtFbSNL3BrI7
 9NIWN4V5CvQRcLbvJlGWYL86Q1QCnKWj9uKckbCVZZBsiJvovqY7eJ9P4k6ZLOKa7/PL
 OXDrA5uCvyFfCyJsYsw/4tqzMZ32AkDrRdvgZQd6nf7+PU+fBPPug9rLwwOKA4eYqnOQ
 pFL5lz4F8hK75PJWjhoR2QSroWGvt7IJrE0GWSf+tobsElJ4uPA77sVpoIY+LG7juX/L
 QX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731439799; x=1732044599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eb/hyjEyBdVg3oj2DKt4wC0cY9gb+CsfpTS2HbjQ9MY=;
 b=cUE0It2gsADkuqQr1Y857SXAclDqnCGcNyM+B44WVd6oQs5FGbhPrmYS2pyUJHJCwZ
 +Sj7p9jxCWr+78C7Qo3odb96K4E04xmkLILGPnxjl9i/UeuBVLq8wymjDdZsgRlUz97u
 CRlrR+P4oBgsfEY2IfxIb2kuED0sgxNsF1V/uj6AqicLBa70363mpDn9cDL1W5DFC5H7
 SPGq5duC1cAZEhl/zvNboQbVf/MibrbT6Uj+oq7b+dd3D5KW8qpAVBk2MEY2VBcZ/oWY
 st8/8qGwe9nFUSYMQtLTJvVUd4QPZCsS3Wj4RGpSaon3kmisTg+zv0XOS9rEp+Z71FXq
 5nTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX6Eun65I1kMQ+l3HNpI8owwa62M3+NPEKuP8pP5wYk83bYI5x2OAUO0Nbj/h65P5cOr3hEDqFfF4j@nongnu.org
X-Gm-Message-State: AOJu0YxZU2F23hIfSgagEhexxDd8RnEowA3Gzq0TVIvdKPTjhDYV601t
 C89N0pSBbSq8mPpwO9Ipm94FnaQ0WNu1/qIW6QA2G0uPWoDVgzFlOJqeV94Uhb4=
X-Google-Smtp-Source: AGHT+IGU4AsiITpLs3m0l9u7ZREtTFHN/+6eP+CCgTXXPRDPDARi050UXGtQMAgBdAbV76A0BdRA0g==
X-Received: by 2002:a17:907:97c7:b0:a99:ec3c:15cd with SMTP id
 a640c23a62f3a-a9ef0009412mr1733873166b.54.1731439799613; 
 Tue, 12 Nov 2024 11:29:59 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr.
 [176.184.27.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17651sm755006366b.38.2024.11.12.11.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 11:29:59 -0800 (PST)
Message-ID: <6bb5725f-1b4a-4653-84db-6edc04be33f3@linaro.org>
Date: Tue, 12 Nov 2024 20:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] target/mips: Enable MSA ASE for mips64R2-generic
To: Aleksandar Rakic <rakicaleksandar1999@gmail.com>, qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@linaro.org, berrange@redhat.com,
 Faraz Shahbazker <fshahbazker@wavecomp.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
 <20241112164130.2396737-6-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112164130.2396737-6-aleksandar.rakic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 12/11/24 16:41, Aleksandar Rakic wrote:
> Enable MSA ASE for mips64R2-generic CPU.
> 
> Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f
> from  https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   target/mips/cpu-defs.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index 922fc39138..e77a327422 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -678,7 +678,9 @@ const mips_def_t mips_defs[] =
>                          (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
>                          (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
>           .CP0_Config2 = MIPS_CONFIG2,
> -        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
> +        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA) |
> +                       (1 << CP0C3_VInt) | (1 << CP0C3_MSAP),
> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn),

See v2:
https://lore.kernel.org/qemu-devel/50dd60b2-f789-4828-9a7e-3becc6721964@linaro.org/

>           .CP0_LLAddr_rw_bitmask = 0,
>           .CP0_LLAddr_shift = 0,
>           .SYNCI_Step = 32,


