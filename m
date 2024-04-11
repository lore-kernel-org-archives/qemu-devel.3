Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E65CD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupXX-0003kR-Jt; Thu, 11 Apr 2024 04:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupXV-0003jz-Rp
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:12:09 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupXM-0004hE-Go
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:12:09 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5a4f608432bso5407868eaf.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712823119; x=1713427919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7kl5fzxtpqRU+NHflcgCJYmSnKhnHZw+TqHOxGfrl+c=;
 b=eMtWeY65d6WU399AjWio/MnRR+PoQq+f0Sdtp4P3XowmczWiQqRhDwlO2keoBYBqWz
 gEg0IufZXhkDJeE6l0Z2LBjISMOS7z0St2VS6MPkmaAADlGFD3v/LboWbNBPxCU1HiIk
 l951aaUQN3XN/n08uVUXDbIRoT+NMIE519ZTYfbc4Zn18HLnFR0QSXbqgVwnxde6MTsw
 GjovA8tFhqhcBO8oWTwouW7/YkV1deB7wNkt/WH1UPmN7LdEjoTOzmD8uMFsgvmM6ftl
 SpBn6j2VBwcydgohlgr/EjgW0Okjb/7+uM6qpheEMoe8cy2b1TyKazoUBbAynPhFPDnL
 iVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712823119; x=1713427919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kl5fzxtpqRU+NHflcgCJYmSnKhnHZw+TqHOxGfrl+c=;
 b=fQK+7gazQ9GVLoEUfIa+QxBRfQoEWTjbF8hUuba8cZvSZzn3A2w0I7Yqk3Y6oYL4RL
 X55O1/uchJECGFAyvGLUM9nhmENzNEA9h4Cb0LpmDEa7FEFj+UdPb2jJZ4KnoAO3/Yka
 WigXpOQooQwPnnJPKVrDVzirb6Ttfw5Vn3fP1YrtOqhDNiNl5XynKy4DEK2CDPpo52Cm
 gvy++V7rLSlRvbLban0B/O97Xdq0+F6yNqO2fclxV+Q0dA87gH26bug9l9JjbyYX5Qlq
 WuTm8g7pYaJcmERTZlTZzKErA4J9X5R9OngyxiuUUvnO6fb5gFx0hVERh91MyUml13AV
 7HEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSjW6lIhvMwHmNm6LiJTME+vs0rIv+6+X3oroXJfptkl/BFf3AlTpIQRkQJ0IwxsW2znESHrXr9GtcM2xnl8JP9eYKM9Y=
X-Gm-Message-State: AOJu0YxMFT+AWOgHGmDRd6v9H1B3aXhggOg+XjctcVqFY25x3jkSr4I6
 mY5ktg9CFnejdyLL2yR8DZ6saFqbwScocnkK2jFsGVLBvDXtWoBu0/FJRxtR/AE=
X-Google-Smtp-Source: AGHT+IHCrVjy9Kq3VfzLxdBHQBFiC/K1W3e3NDwkLqTEGZ7MAm+IyxVL7WwXFZzb9/cOXeHeb6MxJA==
X-Received: by 2002:a05:6870:505:b0:22a:4b4c:23dc with SMTP id
 j5-20020a056870050500b0022a4b4c23dcmr5020858oao.33.1712823119318; 
 Thu, 11 Apr 2024 01:11:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fv12-20020a056a00618c00b006ece85910edsm729695pfb.152.2024.04.11.01.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:11:58 -0700 (PDT)
Message-ID: <ef5ba0a6-9d23-4455-9bc0-090fa8882e37@linaro.org>
Date: Thu, 11 Apr 2024 01:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 16/19] target/i386: remove now-converted opcodes
 from old decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-17-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> Send all converted opcodes to disas_insn_new() directly from the big
> decoding switch statement; once more, the debugging/bisecting logic
> disappears.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/helper.h                        |   11 -
>   target/i386/tcg/shift_helper_template.h.inc |  108 -
>   target/i386/tcg/int_helper.c                |   34 -
>   target/i386/tcg/translate.c                 | 2172 +------------------
>   target/i386/tcg/decode-new.c.inc            |    3 -
>   5 files changed, 11 insertions(+), 2317 deletions(-)
>   delete mode 100644 target/i386/tcg/shift_helper_template.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

