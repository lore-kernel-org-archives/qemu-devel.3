Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924B7C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtwn-0006jE-LF; Wed, 05 Jun 2024 12:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEtwl-0006ip-Rb
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:57:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEtwj-0005ij-Rb
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:57:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b594deeso415845ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717606627; x=1718211427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ivNRCoWzoKJkM4Rajc1TZAG+O3u85hpoRCh1sEEYW9Q=;
 b=SI9lT0Va+4SjfCadHO/JpVYzOuT8myXH+Y6vdWJKv0fIIEgv87S4MJcdpt0VJTd3cD
 GIxhPeyglHN3nMcNAeoyPp0pd8CQeevzLLA9Dm0axVmQaLuis5lNravLJAjZS2bof6lc
 e6N8WZQBktdo8nn1t0JNHd52A4nbZZEJK6KonqNN/1lXiRDt7RhnzNYNaUe5PsrKDQ44
 fAyusBsxSlddwvpi6D7uyThbgxBi4ZCBLi59v3dw5HsawHXmhvChLLL1tgF6NmzERm1+
 XPu3ibwxYRp9u9AORbI26xEYFPuGF4pSn12b95lATOYm3MpxtE5EE8FH3CUDVptYqmdG
 c+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717606627; x=1718211427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivNRCoWzoKJkM4Rajc1TZAG+O3u85hpoRCh1sEEYW9Q=;
 b=Jt4yI8T217Lt8I0wEMzpvlTag9CO4mLWcmAaFMZgQ4Nma0QSnpuG53JTGkKT6TOHQU
 C/Jt730a76S1utFLArcRmRqfp1KKqPdiC7QC+1GcGljCR8Uo2/IBNjR31pqV6hg54xMA
 nCyCWH5pIliscrF12KFVrNcuVo/ukOOnen1nd5qWGFuYD9EIKqhB7RLcPRFC3TQtksI4
 mnjy9jsKy5q85Oqt2eLmgWOK4NZcUAaN4tQun2uDI5wBraNAqUlemm+Pj4BT+q/+r4a+
 cGlPF86kUVJmKjEpkSEWxuNgxDm+lB/bGPR0CkeluOz8Mr2h9cx0C+WKMhUMJkvsC7YD
 i26g==
X-Forwarded-Encrypted: i=1;
 AJvYcCViv0jUCZmtmAVYEngXO6tO41cCnBBhT2O38n4TATtEkCLSOr6+OKShvx21SyYVLsXXzw/5kmupOv+cHMtl56Q+JWuVxhs=
X-Gm-Message-State: AOJu0Ywe3SW/Y9L1HxmxuaXFHbs55+tCCYxdJUKy1gGbUo7qN/tY2SOm
 7CK6wSQoeuJ7H1zwH/DVQoKrscimwA1CjR7g3kcPvzhUtHhg5/1W0DC/Biwsok16gTFd0DPvFl2
 X
X-Google-Smtp-Source: AGHT+IHnwiXqnI4mv5lKrwA9z0l/r0jQk8XjNBpMV0nWZluNLO1cJGPOrxf8lmnL1tgQiv0/oWnDUQ==
X-Received: by 2002:a17:902:da8f:b0:1f4:8faa:cd68 with SMTP id
 d9443c01a7336-1f6a5a12e06mr34490615ad.29.1717606627349; 
 Wed, 05 Jun 2024 09:57:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6a21daa90sm25226015ad.63.2024.06.05.09.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 09:57:06 -0700 (PDT)
Message-ID: <3c947e60-e94f-434a-9845-8803fc536f88@linaro.org>
Date: Wed, 5 Jun 2024 09:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/46] mostly i386 patches for 2024-06-04
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240605090229.1704300-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240605090229.1704300-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/5/24 04:02, Paolo Bonzini wrote:
> The following changes since commit 3ab42e46acf867c45bc929fcc37693e327a35a24:
> 
>    Merge tag 'pull-ufs-20240603' ofhttps://gitlab.com/jeuk20.kim/qemu  into staging (2024-06-03 08:18:14 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to fc7a69e177e4ba26d11fcf47b853f85115b35a11:
> 
>    hw/i386: Add support for loading BIOS using guest_memfd (2024-06-04 16:44:23 +0200)
> 
> ----------------------------------------------------------------
> * virtio-blk: remove SCSI passthrough functionality
> * require x86-64-v2 baseline ISA
> * SEV-SNP host support
> * fix xsave.flat with TCG
> * fixes for CPUID checks done by TCG

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


