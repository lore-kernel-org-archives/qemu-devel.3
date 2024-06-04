Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F914C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUQt-0001UP-2O; Tue, 04 Jun 2024 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUQs-0001Tw-64
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:42:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUQq-0001BF-Nj
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:42:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35e4d6f7c5cso3146611f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508551; x=1718113351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=setA69yRpB4Ul9s3sOZCXLVeunivTtYgRKHaS5hHCb8=;
 b=e+Dw1+jcgFpPcDfu/zXIGW3uiOaUZQNsuv1p9XmOU7QX8RDysOcUEAZnxqbCRWQgZF
 AIKAgQb85NqEVYI26E8zwR9872amAggiMmFrB4ImJ+kv3AOzAgQxPtwo+LrFc62o1dqX
 HKcq1sFwecNy6cpBKgQK2x1oIeKh82Xki8Rd1EjG3obdPClS+3X9ElcPFJ/mgO52GzJq
 6Zu8BlLynGZCZQKIIgLOVoNU5Qw4m1I340KYBeMlAcRUWC7Z3hNwnIF2QF2Ju732/KNp
 xN5/h7esYXQZIrp96SHEWpmD5cNg3SZZomBh+SbYY0fwpb2oseAmEU+AG1CQJgfjggTR
 oc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508551; x=1718113351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=setA69yRpB4Ul9s3sOZCXLVeunivTtYgRKHaS5hHCb8=;
 b=Kh1nIrV7jefE7cZ9JWBh/+KCW68NLcA6MFCltvrU8EtiWCpb2etAaOYCAkDzG/8Og0
 xTg4jSbzVtkLJ8qbnuJcppkUtUeCbOfEx8PBYrK5Fh1348n5JmqDe3qlSFQrc+Sh7Rvn
 aVFQmjRODg1H2yXeWJ9Oeuy3Xh+L9qYtrhs3EUSTDeeg+vD96LP0hk+IEQpZSFrBEI1q
 /I8PqG6q0h5Oeo8YBZFtJJn+IHMGe/hpo0m+1BlJpH/Sa89Yx5SS4mpiHUiB6VCfv00T
 qlD/HYHK2ijx0jpJqoFgZLgMXJQ1o90bT980NMRtutC1AEtMzqN9EaianlMYFX99iTmk
 MVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBNeTX3CM2Qy2ex91V5qWqPT81DxO14yFTwhaqmdk24QlqsUurbgSZo0Er+ismkbnBKG+QRuDq1QqpPBXjAcn+vhHSIlc=
X-Gm-Message-State: AOJu0YybD3/m4/OFmPP9epy7HcxU/DTby54tqcuitF2CWI6GYohDQk6/
 xs4GxyCTIdEIXWXkOPL1E6pbW54cgV7Gr886+F0tPg9s+M9ksiSxLVaorsdNtaU=
X-Google-Smtp-Source: AGHT+IG0/QWnG1jeyytjmfJrD/0mamH9rJfhlOzVn5oCeJDq2zBUdmh/wNKY5FoUAPBradt/Cp1ykg==
X-Received: by 2002:a05:6000:1b09:b0:34c:9a04:466f with SMTP id
 ffacd0b85a97d-35e0f3091dfmr8446042f8f.50.1717508550953; 
 Tue, 04 Jun 2024 06:42:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e5e3d1902sm4801185f8f.32.2024.06.04.06.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:42:30 -0700 (PDT)
Message-ID: <c432dbef-de18-4cfd-b355-11037b534e04@linaro.org>
Date: Tue, 4 Jun 2024 15:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/37] target/sparc: Enable VIS3 feature bit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 1 +
>   target/sparc/cpu.c   | 3 +++
>   2 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


