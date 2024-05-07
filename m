Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93D3C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LS8-0003AN-Tu; Tue, 07 May 2024 10:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincentfu@gmail.com>)
 id 1s4LRz-00035x-Qv; Tue, 07 May 2024 10:05:49 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vincentfu@gmail.com>)
 id 1s4LRr-0006OJ-Uw; Tue, 07 May 2024 10:05:47 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7928c8379f6so333204285a.3; 
 Tue, 07 May 2024 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715090737; x=1715695537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lz03ktbB87kbj1bh2vbGYQw5eGInfnGzMjCMYI69ORY=;
 b=O//sGcpkAcIsFaLus2oxzqb/KJomPXgP76abavlH9Ha1ngpPI4jHbgFJj/b4fGokdN
 W4tG9n6qHw8cMWuQA+8g+7jj6hTKTGPvVyeCrH7rc2khQjRpamTK0qYJzlLa2QOaXe4A
 ZJ2ZqNY6ugbi6rNP3wtwpEyWq3iL5o0ZNTKpCVKrPxa9z1rYig+0MFNpd0QMKfzIXBcB
 lF4jMX/Vpda1VfmPORSx+bTwg+KHmuPQBRBTtg+0yPatPDwQCQ7BsK/ofePWztGxdMd5
 vdQ4MBJOXfa8xbUYNmPH74sx1ecdlSC70fewVROshD7jRFvoZHjrjTeHIcNl1JffDJKM
 8AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090737; x=1715695537;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lz03ktbB87kbj1bh2vbGYQw5eGInfnGzMjCMYI69ORY=;
 b=pOLf2BDl5GHhtI38Tk5o3vpSyOROzORkOsQfRRjzUaMD6m6I1jew0fbdh/zOPovT4X
 opLGDEuxbav4avfFgrYZdXJO0BU+3hUbpuVi4XXUGRGw5UKCboIabvntOPV8I6IlDxGy
 osuKx3C+ZWyaS3eFpFAKPMnzw/6J0SWe1Swkw0QV1qmdjaFUUOkeMd2Zzk3kEtf4otC6
 2G3JwO2eDhTsrJh7MkQjzDf+uUDzN00E8+PhszFa7hym3v7DzxX6YfKcGb20DaqrUx/x
 OUPXtHqa4hCuYJH0aWxld+lKQEYWG8LSw+XDNbaShJPMdlKBwBlk6CPvBVsdU68rk8Xl
 KTjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV89G+SViJuqif6dJHSgbXU4+yTTLsFdeILiHV3FLvToevqtZnpmI1oCcoQq1yCzycnYqFaskp7Kl9KULmygu4RZuzOCy8=
X-Gm-Message-State: AOJu0YzELPlDtFOaQWHRwJHheO1wGNZFTmCXdAsesFyEc+Q36H6mNwci
 /bE8b+438qCVdjm2rIc6yLMUyIPedpbi4jzEQd3n/6IWR8dR0Cb5OLhEDA==
X-Google-Smtp-Source: AGHT+IEp/dtMEacV4mdq3X0KC1y+OHLPMdm7gzIJNKpFy+IEaHxu01LBQXdWKg8IayHlBwzmeu8uBg==
X-Received: by 2002:a05:620a:d5d:b0:792:a2d6:993a with SMTP id
 o29-20020a05620a0d5d00b00792a2d6993amr3655057qkl.48.1715090737501; 
 Tue, 07 May 2024 07:05:37 -0700 (PDT)
Received: from [192.168.1.206] (pool-173-79-40-147.washdc.fios.verizon.net.
 [173.79.40.147]) by smtp.gmail.com with ESMTPSA id
 y7-20020a05620a44c700b007929ca64e0fsm1730313qkp.5.2024.05.07.07.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 07:05:36 -0700 (PDT)
Message-ID: <888fce70-768e-474f-8526-fa05b41540c1@gmail.com>
Date: Tue, 7 May 2024 10:05:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix mo field in io mgnt send
To: Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>
References: <20240506-fix-ioms-mo-v1-1-65c315531850@samsung.com>
Content-Language: en-US
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
From: Vincent Fu <vincentfu@gmail.com>
In-Reply-To: <20240506-fix-ioms-mo-v1-1-65c315531850@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=vincentfu@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 5/6/24 04:06, Klaus Jensen wrote:
> The Management Operation field of I/O Management Send is only 8 bits,
> not 16.
> 
> Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 9e7bbebc8bb0..ede5f281dd7c 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4387,7 +4387,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
>   {
>       NvmeCmd *cmd = &req->cmd;
>       uint32_t cdw10 = le32_to_cpu(cmd->cdw10);
> -    uint8_t mo = (cdw10 & 0xff);
> +    uint8_t mo = cdw10 & 0xf;
>   
>       switch (mo) {
>       case NVME_IOMS_MO_NOP:
> 
> ---
> base-commit: 84b0eb1826f690aa8d51984644318ee6c810f5bf
> change-id: 20240506-fix-ioms-mo-97098c6c5396
> 
> Best regards,

Reviewed-by: Vincent Fu <vincent.fu@samsung.com>

