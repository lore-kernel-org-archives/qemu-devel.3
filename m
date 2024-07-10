Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20C7C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZBV-0007xI-Ca; Wed, 10 Jul 2024 11:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZBS-0007vl-HF
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:24:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZBF-0000Ah-36
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:24:41 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c97ff39453so4445068a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720625067; x=1721229867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xod015XjG5hRcMElnAlLSHhA3/Bj7Yi8LHTROpY+dlk=;
 b=Nl6VX3RyS/53qaF7SO7QkXzl/ZEtPJ/tPJ1WbKgB0oy5fyeawwCR3ybHHhVUFuaw6z
 4PWOo3DW608Bqw28iDWoUhmTsr3eMYKUENh5Sbe5r3WtAUq7KxrT7EFUyYZJJommuP3x
 ybEDgx5LhuEIy6lU98yc+ArUOcH5JEYEizprm+yxofs8I/vfC38mxc1E6WI2aEG4xdDu
 z+2eWiLAtS3NLM5taDTSr7PQN1AZfpejWPaia5AuuHxvmou9LYR83C1m/gHEaUMhufwF
 ylO+VbcWAYQv8bEWSZ5Yqo/bQli5NIc+rSCdrulMS/GpaWqR8sg4kmu1DV/ZOn7UcwEL
 1jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720625067; x=1721229867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xod015XjG5hRcMElnAlLSHhA3/Bj7Yi8LHTROpY+dlk=;
 b=hpDg+s8Y2ZoXkJ+m1pUuI6cmn/IHb0x1IQneJUPn2AQy3JIgTcUqbIS6RBKgsxS1Yl
 qpHFEn1GUjSUX9eOlWc/6aJV4QXz6Fc6q9Wqac6Jkfo5FC+9Q1Qxwbs7B8cQZ4yS42+D
 rf/Qp7MpmXm1uDtNe157kqLZZgaPeTpL29BJUXMknG4HDtKNrjujY94JVawxi1UXC6Ht
 qL7fQ3xsVUbW8XLoYkEkhRDJn6hQEpD6uMyLj6KA2/WTIp5L2SAwpUSs5g6OXg521LOg
 J20eAn9GoI2tqB0fEcGa5WWZplyh0dGWNB/3fxC/5ps6GPTZaocM4M3/NScHbD/F9i1Y
 DQhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4XTiylvNGiimD+PMBhHbsNrwxF/UtVpmSR74URVN483ipU8bPOwDYFG0iFumgPGRR4mhhV3in5gNcBxT/nZ+buQ/MjTY=
X-Gm-Message-State: AOJu0YzxAmVicuT4bo/4rBXWg7GCGRDKprzOJUsFyY9j0DsqWJc2Tn2q
 gv50V2GBfVG0wj8OHo6cya7N/Ij3TajnGj8y4YDpNTswQRtvAnHYERhMM4KNn0E=
X-Google-Smtp-Source: AGHT+IG8RwgLcAa9l9Dkoi7FTZsB0z88UGn1Ts4Nqhnp3Y+nv3jfvN4AO5QcLXF/FE2NeDnQLAP7rQ==
X-Received: by 2002:a17:90a:c698:b0:2c9:7849:4e28 with SMTP id
 98e67ed59e1d1-2ca35c72208mr4574342a91.27.1720625067422; 
 Wed, 10 Jul 2024 08:24:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ca353d00e4sm3913267a91.50.2024.07.10.08.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 08:24:26 -0700 (PDT)
Message-ID: <f1314aff-ea45-4a5f-8020-1a10efa2600f@linaro.org>
Date: Wed, 10 Jul 2024 08:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/i386/tcg: use PUSHL/PUSHW for error code
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> Do not pre-decrement esp, let the macros subtract the appropriate
> operand size.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

