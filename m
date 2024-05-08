Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF74C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4kEV-00032b-C0; Wed, 08 May 2024 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kEU-00032A-0E
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:33:30 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kES-0002Gd-Ji
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:33:29 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-43b06b803c4so29040771cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715186007; x=1715790807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bdJKZQBeD/htTOdpd2BVzeJlIN8KSfajb0seiVLTxrU=;
 b=CGacNmTuPFqu0JVn4eF2oHzLn5eivdHurpDS4AihEnVJZ/MIzaDEZPBpT8LJy6L7sv
 D1jRXCY3m0rG2XmEV+h0Xq5wiuZKgScvXLh+Z7g2jiQUp1BPzxe6YypQep5iyPIOqKGq
 c6OC3av/EmQRGPLCpnw0wJGg4yl11y+YwWf716ClcCD3t8bqF8/FsQq6TLMPC62MySq0
 AcQ8FZdeVFS4dARbpKQ+z/nU//w8uXwZGpLFdTC+IHKvQ0YoiCwMWUPkmNEvknKRcCxb
 9/JxXjTiSF4ZUX0NwLi81Q85HmfdHmFaPN9QZPFAaB8Ra09WXPNxOi+wN6dwQT7oVF47
 N6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715186007; x=1715790807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bdJKZQBeD/htTOdpd2BVzeJlIN8KSfajb0seiVLTxrU=;
 b=Xt+yet6949xGUGebsC/9Esox2DAQ/EptOYS8O2d9ZPtZxG0311fOLQ9J3huNFotYfZ
 /0e2Rw/1MHCuEtNzBAuan1V+H6QGeT3hfi+/9F2BzZu8Qiu52dAtpM38v0pjiK5uPK71
 iEGyvlQOiktbX+p9ubAR6U0VDY3ACj3pv9/a1b2+V/9atRy1p4CSvrdHC3yFhetBfhro
 0n/hA/KJEukI77IL2FG6j/zSTuVFigfJO/DmHN4Luyp5PL0Q0I678NL/X2v1CiI1yk4Z
 /kUEColzmCsbtUoa4S3oyZ6XB+5LA7zu3gUl66QRbXQBqVMDjGLq07M3hbNe7JXNORfG
 PHFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGRbfVtqkMkTU+gkQgtpu465SCNHiavSGfnCptqrvkwqRjZOaFNNUI81iLqcCFcPT4MIDo8hbQMSFZkkvBl6l25ZfVHfw=
X-Gm-Message-State: AOJu0YyC8n2fBiFxIOc24khwafjGHCj9nLfvoabmefG79R9tmrBsZwpm
 p+UhAJmKTm1mIywQJI+SfG+sm0E8HP3rh67fb5sA6tJhdtr8E0zbff21+u7ZZqU=
X-Google-Smtp-Source: AGHT+IEEmlzoe6KrQ9cC7cBghfClPVYAUS8Kf+Y5dhROV698rPDqdoCPo4aZ5hfQLBUrAiUIU/hgiA==
X-Received: by 2002:a05:622a:144b:b0:43a:c024:97e6 with SMTP id
 d75a77b69052e-43dbf4f77dbmr33106011cf.11.1715186007185; 
 Wed, 08 May 2024 09:33:27 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 fi4-20020a05622a58c400b00436bb57faddsm7809699qtb.25.2024.05.08.09.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:33:26 -0700 (PDT)
Message-ID: <ad9d3c22-625f-4dab-97b2-bbab716d9e56@linaro.org>
Date: Wed, 8 May 2024 18:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/33] target/s390x: Fix translator_fake_ld length
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x834.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> The ilen value extracted from ex_value is the length of the
> EXECUTE instruction itself, and so is the increment to the pc.
> However, the length of the synthetic insn is located in the
> opcode like all other instructions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



