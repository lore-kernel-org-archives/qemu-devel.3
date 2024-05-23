Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A128C25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sABYn-0006g2-Sl; Thu, 23 May 2024 12:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sABYk-0006cG-RG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:44:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sABYg-0007dQ-IP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:44:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f32864bcc7so14434555ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716482685; x=1717087485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUADGPpfskKTXGpqJzCc/aN20jy3lnejU+nFoByXjU8=;
 b=oU/Jif3zh3UcMuFCVGtycapax1pUaHo2Fm/qszeaXsT4+3BHzDZRIhyHdUcz1Rhbxv
 lz35z3ZIK1wdDjmk885CQ/HNTk7+HqPFTjroqVISzLVyhbxL83tk7Ian5nQ9pQBTGBOp
 XSQlcSGLe2tc7vbm0cSS0bpP6TWG6p3PbJhbKiVquv2MCof9LU05CT5il7V7E8g0FUQc
 wU/yaY8ifBTwqIR+atk9u0JqsP4VFyug/JXxn++OvBODWF+utdNiBh4NmDQTGgC0ehsJ
 TwvWJfLqOwIlQwykbq7cL6ANEi1veIXxUi2rB6zTEpSJ1ZNVUr3XT8GcSpjLe04gWPY/
 uVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716482685; x=1717087485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUADGPpfskKTXGpqJzCc/aN20jy3lnejU+nFoByXjU8=;
 b=AlzmkV2r/nX/q8v5BHWluKKbf7pxaLvzcQL7/IPyG7N0ZeNqcjPpuizNZ/Cn0HKSOK
 ga3u8i7WVLbWxhMAARlg55jaw3772qOOASypYEQ0aH2drBecrWw85jz42VVmBNQVeCgY
 eFvJ+RTJx130LHbq/8eFaDLQPurj/uL+pslPA/LxClwQA+z99NCj9kkafis8/3tLZEd8
 dScttxrxky5VUPycpyIHjbakTdf84qGPV9KTiqBLydG7+HOYHKB5u8vwITjE10KDgIcb
 4OpsA/StZhUiUtpxZMbic29/j3/DQbUJflDqxvsPpRzzznUok3HlG8t5tTecoZBumTvA
 Un1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWULqQT6H7nnRC3cHWSbaW3YOLSONqpvBU3ETAb6+uswuXZBxNyYe2WEzqdGoDdMpPZntEM6TvRwOjRBdGWw4zrB1M0JHI=
X-Gm-Message-State: AOJu0YxY+iLhvrXzM4D9BmakLw3fjQlpZ2/pl6n8n807Wh6cIWG1VcdZ
 G3YPAUI7j/lOMI1DmvHSnOjozgSXqCOq3rHHgwqj+WE4JIT/MCzoPHjMozEm/xQ=
X-Google-Smtp-Source: AGHT+IFB32dKWL5y91fKkJNB52XCLEFPtxAVLDQNwRvITsOaxIMStMe4OnCYi5n2n+2qLdNktKCL1g==
X-Received: by 2002:a17:902:ec92:b0:1f3:508:8339 with SMTP id
 d9443c01a7336-1f31c9e7377mr66638025ad.44.1716482685029; 
 Thu, 23 May 2024 09:44:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d385esm263788085ad.38.2024.05.23.09.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 09:44:44 -0700 (PDT)
Message-ID: <96a99c3e-8d14-48de-ad60-09762b7ab896@linaro.org>
Date: Thu, 23 May 2024 09:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240523014637.614872-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523014637.614872-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 5/22/24 18:46, Song Gao wrote:
> The following changes since commit 6af8037c42fdc3d20d5aa2686799ab356a9ee1a9:
> 
>    Merge tag 'pull-vfio-20240522' ofhttps://github.com/legoater/qemu  into staging (2024-05-22 06:02:06 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20240523
> 
> for you to fetch changes up to 6204af704a071ea68d3af55c0502b112a7af9546:
> 
>    hw/loongarch/virt: Fix FDT memory node address width (2024-05-23 09:30:41 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20240523

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


