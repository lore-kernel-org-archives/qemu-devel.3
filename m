Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE8CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwLp-0003Mb-Rp; Thu, 21 May 2026 01:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwLn-0003MP-8X
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:53:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwLl-0004G1-Cp
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:53:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so40808825e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779342819; x=1779947619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GxSsFMPclGUrgOFtzjZKMnxovhNU50xHXhdhf59A2eA=;
 b=M5SrGMDtIDYwSbK8BGEqE7nzL7erca9TtDGlPb90X+AnMX9NXnxpWiw9zmNBN6MxDm
 7tQaT1tS1DhG+xEc+zoXENMKk+X2mCTN5NvLpgFgmc9YxOZzf3tj2lbtOMgCJFr/V4vD
 KdBPmtAOkUDJXhVkD1ypXPoT1GggFxW8Hp5kpnb9VFSfWhA43gu7oFqRLYE20X9RXiLf
 WLHd6CBJUp/MjnZw6Hajk/TCeFQBsdk+MzL7NsAYP7RC0bgx56VLGIA2dItt+RrAz0M4
 by40gtmjx4jIZzKZ8BxqM9c0DT/Q38hfeXARTuhprgxXKqMMCd7bP4jf92Tgpm2bvyTI
 U+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342819; x=1779947619;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GxSsFMPclGUrgOFtzjZKMnxovhNU50xHXhdhf59A2eA=;
 b=cD2VEZnBS58/3hOxNvFqSVZ6FdCdp4g/3nRbWpoZxynNr6Nkg47RA0ClcyZhefOreS
 MFxx7Z4xREFCajBV7C4YbZ8F90V6F2q9N34YufZ7mo3WVMjMHh1GVje59cfDk/60XLNU
 5xwF+T986xTeHwoP1FYATz4VJb44dOkKbWjo6LZo6wmyU4u/HP1pRG47UnUaxVfCpUcw
 OTf94lDNZU9GIIxMEd4j1dFa2v+PXPlp7wAkrXlLWTWCQy9tYPUEpNKqiqHfUoi6/Bja
 GQLYlxfAv63d2GQVJNxzvOKPr1Y3GB+1s7Kp4XiXKiqCnkNB6ire3NcG40DYAZENAp8o
 no5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nI10MYG9F+li02HpjBpnpX8Oh18TvDv7MGPWfIlOXaTN8+PiXuDJ55lCQ+564F5J40+6Nl6FbZAJ0@nongnu.org
X-Gm-Message-State: AOJu0YzbasfXaMWLePd09RAXjNHVSGndZHvXog1O2S7dGnNj0Hc8AMbF
 b4WlSsUU4b1/gB2fw5zD6hoSgm8hD8PRkEoivYAZfJsp3cLQCWpK6a0EV8SoedcdUnQ=
X-Gm-Gg: Acq92OFPvj5YkVxccefOEf5LoPs2vLX+FahDqKQ3Pw1dK16utYX2lG20EQxKLC41et6
 gpdY4W0PzWLiFqQxP5y+MQhTDMVwIVGxBlOk1M010jurjHxQ8V67IgUq+MpoBsnFMBbWWitQWea
 q+nHXNB4Qs2QtykvQo55ts/Tq343lB5DaT1REZzye222hur033ppkOpAT+5LOFSEVRBU9aalM+V
 oers4rN/Dkwitpceu/TbH+005PDjS1QpvOoMCBhRzNQlTTM0uSCj+HwLH3kx/ALGQ1u8X5HL50z
 mIu3dJ+bqeTuyRicDm6qLCmYTWPaSAA6OWXLd/O0MLWvUAenHIjUmZy+/wNHSfY4xha/bvJeB9v
 v7jCz8ji3vodk2Swvg8tgJDLvmOd3Lpq1U/NjLh1HF7Z90u2GnqzywMyVt9cbWhJ38A0eHO1dDa
 PrS43yKfRV2FXzSCmND99Jl8JElJ+Ms2aVXVLcC41hxcuif3RestZsIADlBscREs8d+w==
X-Received: by 2002:a05:600c:5295:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-490360d06d4mr13370905e9.13.1779342819361; 
 Wed, 20 May 2026 22:53:39 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035adf173sm10634275e9.0.2026.05.20.22.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 22:53:38 -0700 (PDT)
Message-ID: <b2059395-9188-4621-a15c-cad1055e46a3@linaro.org>
Date: Thu, 21 May 2026 07:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/40] monitor: move HMP-only fields from Monitor to
 MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-9-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-9-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> mon_cpu_path and reset_seen are only used by HMP monitors; move them
> from the base Monitor struct into MonitorHMP to properly encapsulate
> HMP-specific state.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   monitor/monitor-internal.h |  4 ++--
>   monitor/hmp-cmds.c         | 17 ++++++++++-------
>   monitor/hmp.c              |  5 +++--
>   monitor/monitor.c          | 16 +++++++++++-----
>   4 files changed, 26 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

