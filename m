Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDB1C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWsg-0002K8-0p; Mon, 27 May 2024 05:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWsa-0002Hz-Hs
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:42:57 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWsQ-0006Cl-Pw
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:42:56 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5238b7d0494so11782778e87.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716802964; x=1717407764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyvODRrv81uiXH22t5pifxSNXgowvqYEmLBu/IcEgeA=;
 b=wWRwOOIII+/eErvuN58+KrUL7C0x8RY71j49jstD91hDMyQ7yvmWw6TMnHAn8MheOM
 +H1fTxcWgR6mgJtG7I/ttLYcIk2a1O3yqafzHm4YCxmD4b2IfFh3rT/hB/9WinN/hix8
 0Orz1EsXSseXuLN/zQMNoRug9kZTHYvey8w6FXZkTkWMHC+x4RAYu/WlxaTee9S/la/3
 32khk9FnzEFLMfr3tYjef/xCy8KaMfKOpCMB9kiMT2WGjysbm9E12+smvmyMMkDfbxzu
 7jWQmj/VC3iMxBihn9HRZmjaJBMMhHoT9y1A+mcA8jX9ib47f23WxEUM+47cISLlVYp+
 L+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716802964; x=1717407764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyvODRrv81uiXH22t5pifxSNXgowvqYEmLBu/IcEgeA=;
 b=EOSG6u7w04uZVji6oKrOyKEpWHU9q+JutBmv47WA5af4cxoE7rnRT4Q8WH3iOVMI05
 fDF7sy36lIDM+Z3i9eITMF3oqb/+hxY9ej5Z/9FQC6ZXQ59wN6iNhsOR1F3vMdQRNGvW
 aky0uPYaParNfptDVCkZ2vbe4WSW1ywuiJxbhVT98tmFVSfcuVFjM7DUmyUx2DKA06N6
 rd/55dMuzY3ntWOI78FbTtJ8xibEmNY1TMnkUthGiQrpaP6Dl9sXI3O+OW43FpeN15m9
 aFKJ1tiFoMmxyJbJChMOxO6SNlEQlF/Yx/yRc6V+caSDi3MligY5b6lYa8+563L7ZvQK
 fFTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmd9uSBSt39snQBVtBwf9FLrKNrO4MYKfhXL2VNXDELEKsOKzTDRg/1a1zH7j6qBdNKmSLeaJTgrT/+JjT6qgoyuURmF0=
X-Gm-Message-State: AOJu0YwEVT2My2VDtPjfMsr8GMobXZ/4kmzl+g/9W93lmgM6QmzT1geE
 +GdlxRIRRHNIY3GRqMDJQBDq1kNDqDMKQaf84w32Q+XT881zKVJ8TVFwkwYxYI4=
X-Google-Smtp-Source: AGHT+IFzx566dC0SCiQZvP+xNzLsQ8qogwVx+TCny3z30L+vxdV+INcjx3iu8uMrAyNLbfxIDtNRow==
X-Received: by 2002:a19:ad4a:0:b0:529:4864:9c17 with SMTP id
 2adb3069b0e04-52967463e64mr7015616e87.57.1716802964111; 
 Mon, 27 May 2024 02:42:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579d69b49basm894555a12.88.2024.05.27.02.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:42:43 -0700 (PDT)
Message-ID: <c1656eb0-ebad-4b5c-b9d5-cd23db4d2a4f@linaro.org>
Date: Mon, 27 May 2024 11:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RISU 4/4] contrib/generate_all: Do not rely on ag
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240522212741.297734-1-richard.henderson@linaro.org>
 <20240522212741.297734-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240522212741.297734-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 22/5/24 23:27, Richard Henderson wrote:
> Use plain grep instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   contrib/generate_all.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


