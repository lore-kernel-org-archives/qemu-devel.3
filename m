Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBF9C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkCs-00020a-1U; Wed, 05 Jun 2024 02:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEkCm-0001pr-C8
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:33:04 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEkCk-0007KO-BM
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:33:03 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso173374366b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717569180; x=1718173980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A27/N9dRfrACsXd0tFL3y2S0qQNwsncqEhvalm+oz6g=;
 b=CeCP4rPV4d/hdqR+x84OwT6n4arJXxHWoqX3Z7Qd0pd2/dIr5Xgj4jOeTo069BNLEx
 /SxoJpAZwx8yjs/Ln8rvWqz4OFh7mF8oWcIEdjelBYnsqmfhuKBUWkK6u2fHYkmCTMUZ
 H2wH+jkunM61QatWcuaDcbmPgyw4n35TZ1RmrghPcjH3D/CK/FMVTa48VPMtHTQ1xn69
 Abjch1BOUP5OnKk+gig8HuW3Y8zEGrwIdBYkEpo0YoE+xcKG44rS4aZpt+EDaAzWmUSJ
 vXvJASH1H2UwTuewLzGqpCGALk0Bi1in18wXtmsSBTsRzSpyL2I4UQLfMOkchzRoT8Lb
 JAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569180; x=1718173980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A27/N9dRfrACsXd0tFL3y2S0qQNwsncqEhvalm+oz6g=;
 b=hCOb9yqcJrkSFrH3bsTRIV0aEgRpxLkZfNzXbNcX0tU72skBd315vtye1bqh0rsgfT
 T4uMg4gwk9qwODZiHJRjul0NqPCb/hQ7IfLcP3+vD7wB8q/bSTMi0mOG9uNASn7N0cn0
 gnHXB1tI+GQ0wunBKE8CMgATy3lx89Tq0ZcJg6C+c8ZCQqlbTrKtEba4bx5wQdQrdYzx
 KULZ4ibMfS6yWMt8QlbSee1dZmIe4NPrMl7DqbJnsnGN3CZYnSdMwR3TPWg+9+OMtPOT
 uqf+DXwMemxfPH9i4mT5UKtmmTCAP1HtItKGvlYl86IFDKFY4UjQdkXp+zVRu4lhUU6W
 w65A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtSXObsz9MN00p89NrfAZgiru+f8F3GiITTA5PSaLmp/TIDjFmFPYAqD/cEPxbVby7sT3QXYZvIkACVZuXnk0zb01/Ji8=
X-Gm-Message-State: AOJu0YxPua3HtYfbDOi7UYEBnW8xxwhjFtoh0Cn+w5h8idKzF5wE6V2F
 AbKIQ9w/XOLtjiW1/P0WS76n/2qr4b/LcdKn6HLwp7SCbZ9EFg8BlBgKGCIJiuE=
X-Google-Smtp-Source: AGHT+IH0gqqQZdB9EpGPBp0oGCwOy2OF25ZP0uULfEzUZ0pwFJroG37mrYoNDigxtAua/+bbBbbJng==
X-Received: by 2002:a17:907:c85:b0:a6a:7e39:2a3c with SMTP id
 a640c23a62f3a-a6a7e39380amr29498066b.48.1717569180278; 
 Tue, 04 Jun 2024 23:33:00 -0700 (PDT)
Received: from [192.168.60.175] ([92.88.170.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e728b92fsm507495266b.60.2024.06.04.23.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 23:32:59 -0700 (PDT)
Message-ID: <1b9abc4f-428a-49b7-b541-cc189063a3b0@linaro.org>
Date: Wed, 5 Jun 2024 08:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add reviewers for ASPEED BMCs
To: Jamin Lin <jamin_lin@aspeedtech.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: steven_lee@aspeedtech.com, troy_lee@aspeedtech.com
References: <20240605060310.1946803-1-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240605060310.1946803-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 5/6/24 08:03, Jamin Lin wrote:
> Add ASPEED members "Steven Lee", "Troy Lee" and "Jamin Lin"
> to be reviewers of ASPEED BMCs.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)

Thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


