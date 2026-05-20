Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD110CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkmb-00019b-QN; Wed, 20 May 2026 13:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkmZ-00017V-B2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:32:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkmX-0006Hl-TR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:32:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3429523f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779298351; x=1779903151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afRBcGJZaxZyWumDXRYkMJZ1DDVT72g/NpP4pLTAXMc=;
 b=AQvC+wFhaH0QkTRNytMOHn/q56eYJ/V2Xux/FU+3TGhxtZmW2YEgci0RHZk35Leh5U
 m0x6/EqT9Kx68TzCLQD1R/nlUgwQx2FGgwXy1o0b0AMdlgqK1W6O5uFhfivi+M/PWoWw
 it11WO01/SWf/cyN9yknNPBCh3XJHgETjlV1Qdi8+UJWyGrrAY3kHSwZ6pVCaKHwIw4i
 iND5I4VwsXnDducZMbtA74aHDnCRDtSKrG/2qh6QtTuEjXuLTHGMojdXK62tw0a2hRM6
 s6oOtbq/c7RdXqt3j0j2lh/2XQ8K1b44Yjqqm1ddBtR7RTkuUwA1RAGk9oNnn0J6Rhbi
 9ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298351; x=1779903151;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afRBcGJZaxZyWumDXRYkMJZ1DDVT72g/NpP4pLTAXMc=;
 b=F/EfG/8mQ+duGCiWs2hFg9GmzvgzyeGgRhuwdWxT5cnqfIK9QSh4GT0awnG1+1aOYb
 XYJuKnxid//94Z4ME5q5kOWGEfFxn12zl4VRsZOc1vlwGDl8qocqtMcLoJT+1SJ0wVvp
 3q58btSlyQP5/NIvYLXlOoODa4HotdiQPQVTz65AnTodPTCoPREztefAt0rnJVTwp5IZ
 81Hidtf9HczKX6bXbA/Yo/VKVAgICXjCVP/1DqcU5vtFr8XVrJPdcXL5zUX5uCYJDWf5
 m+aHCX+1q1ifDJMfB+p51fjR1sx/cT0Dg+nI6mhzpfwlLqjPdkRuWRyE0alh9r536UaX
 B5pw==
X-Gm-Message-State: AOJu0YxwUA0WAb5Xh3RtxVw/0gZ7wKuUGtZdVb8rmvtKVHPxoYhNB+yr
 weDG4x/HYcYDIAT3FPJ24UqbsNbbDjTokwsruPAq/7wleTqs5k9oDwXEJjkqlFK8iT//8/jqLnl
 2BN1xjAI=
X-Gm-Gg: Acq92OExIBBztg3lnqnaOfX3PU2ZUv9ckePqFu4tV06qPJjfvyyYXFbUviiFWsydNMT
 5mYhggmWL2vjTr+Ur6a6+nxTRE+c81NqmCgeEG0E8zQk7y77s0FkBgsMTxG4NqlrN9efDx+xDKd
 zMi1SUAEQ7BQNXVmuz42GHsCv/fBWWNIFuB7kVW+WantHakVTefPqLmigqkoqrkOJgpKPiZhdlE
 K0+GTrDzzgyjezeiSNiCupGh9CAHEm30r+puqACfk6oKlTLL6zm0pIxUh2YSh5x+TQvmeXgqEsx
 zHdDp1sSefYnu8BmkxxSr2O1BszWy1nv4iiWQntgEohXPT/1V+g8A0qCTgiZthLBRDvXVNWL5LV
 NCXu1rnW2i3WzIB/by+QEg6sqiZtaNlc2L99lovbfNVIqRsYxNRVgwO2SwLYKYowyIOzL+y0OAZ
 hrb/Mi5qd5QWrB/t9M+5T8t6KY6TUVPDNo7LjwyP/sk5lMxv33F8A5bRdqGkdpFizVhxl7R5mlj
 qXr
X-Received: by 2002:a05:6000:471a:b0:452:f380:5508 with SMTP id
 ffacd0b85a97d-45ea0aac013mr717130f8f.0.1779298350661; 
 Wed, 20 May 2026 10:32:30 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6449sm55497577f8f.37.2026.05.20.10.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:32:30 -0700 (PDT)
Message-ID: <a70840dc-3e51-43c7-bdb7-4ce0301d00d5@linaro.org>
Date: Wed, 20 May 2026 19:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 19/24] target/mips: add Octeon MTP instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
 <20260520172313.23777-20-philmd@linaro.org>
In-Reply-To: <20260520172313.23777-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/5/26 19:23, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
> partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
> pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
> For MTP0, also set P[1] to zero for backward compatibility with
> Octeon2 VMULU.
> 
> Legacy single-source encodings have rt encoded as $zero, so the same
> translator path also preserves the older Octeon behavior.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
>   2 files changed, 27 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

