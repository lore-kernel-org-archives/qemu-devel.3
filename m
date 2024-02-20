Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7569C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcOzp-0003JP-IC; Tue, 20 Feb 2024 07:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcOzn-0003I5-Iy
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:13:11 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcOzm-00037X-0x
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:13:11 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-512c4442095so800303e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431185; x=1709035985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fz3rhuMyIR5IIsO7/TNcMXjTgsSoaEjkhP7dkLH7cWw=;
 b=Jhmau/Nqoet6NwnHa05uG7dTCee2hKfr5xPsL0JZskZPfJ4+S+tSUHZIvAEuWqqtQq
 M6VGIXaTinJke2v3BM3d/O+PnkoRB/dEP4nqZFEbOncC3tC31P+tGR3TSGCU0xfVxy8N
 tnU3EztSd0BAY0oPkd2qObyYEx451ctuO2ilntLBlafNcl/pqevpzObkqUemki47NVtp
 aUrftrVdx6cIuYJeWdL2hX91TT67nAhyI8bcSP5jFZd5eXgOSiemnBXE2f468E85Dn7O
 BW/yP8aQPHOfz0mqgfkwSF0roOQThnqB+tg0BfKGecSuxAYbTQvhj/9faZDIrf7y/jGv
 TRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431185; x=1709035985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fz3rhuMyIR5IIsO7/TNcMXjTgsSoaEjkhP7dkLH7cWw=;
 b=QpXcZ1CA4FbqR7bWJbhstpQi6u4mbLa9bIeJn/nsnJS1lp+UMfuNum87CuwaBldAw6
 PBIgDPuNYtRsKcfAvCKTAN1rYgJiSfFvCSP+zWcyvIWKXiKrE/cfo6Su4uMpaVz+IXvl
 NdGxdFCvSWpfH8hmZNfINtoC81Vgty/VzPIrbUsr/5ADQrjkxF00nNxTEQ/eILRm6mVY
 ydggknFNMkEmavQFsQo6sKTSx0e8IaVH18juyUCEby7G4/oc1VgEtHp/GDCbj9yEiZWu
 V4ZnrqqE7L1v3hnXIiZLESDrN9FvoxNWhwScq610EsUtPGAQEOludgG5jfAxidx+yrrm
 TEpg==
X-Gm-Message-State: AOJu0YwilouwEWauJ9A/tWzPf7jG1Smvw0wg/nU+js/o6aao2l1bCWGY
 Iturn7FVuITuw23QLS/c0A3s4I9PTwd7A4iUZUcMKb170G27LV+WKGZJ6H4erN8=
X-Google-Smtp-Source: AGHT+IH+EXFyNV7jWsEV9f5xkqv8o3Y3/P646twrfUOYqq7Fu+tCJlKQOi0OycRhl8mlnY4wyPx58w==
X-Received: by 2002:a19:655d:0:b0:512:ab03:f4 with SMTP id
 c29-20020a19655d000000b00512ab0300f4mr5101336lfj.37.1708431185189; 
 Tue, 20 Feb 2024 04:13:05 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 l8-20020a056402028800b00564427855b5sm2711413edv.44.2024.02.20.04.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:13:04 -0800 (PST)
Message-ID: <ccfe5f39-7c49-4778-b0eb-a3e9c0c97a7e@linaro.org>
Date: Tue, 20 Feb 2024 13:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/21] include/exec/memory.h: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <16e84fbb3dec43ee349a8ea5dd945c9630630bb3.1708419115.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <16e84fbb3dec43ee349a8ea5dd945c9630630bb3.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/2/24 09:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   include/exec/memory.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


