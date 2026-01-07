Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FABCFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdT5q-0003Ej-Sx; Wed, 07 Jan 2026 07:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdT5V-0003CY-W7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:56:34 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdT5O-0006R3-I1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:56:31 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2abe15d8a4bso2875964eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767790584; x=1768395384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EJ/8UO5yAHkGYW0pSPwXOZvLsa/TxganG/Gr4V707g=;
 b=Mw8yHKV3d3ByU7YUOtHk5B7E2dxu79h+Iu8qAnF9hizOhfyjvPTmurWVCseJeCX/Dw
 G69lS7GOfrx0v9Tm8oAVLxOYVqxBNB47zDV7qNL9tBKIfF7H9k+8TRJ7uwwBrm6Ij1IZ
 0pe2bXD2UDQoW56GCf9D+afKEGcXxw0F0TPn6MdXzewkIilRbp91jxfCnElhFnzan4ZY
 01SVVTxW+zELbLwg+gkAlYQOBpqUbCHpUq0ObVibBr3DW+ztQ1uf/0JvY+7hTRO2xzqw
 nhj6rXY/tRNKIYJuJeMfGMUd9m6DrZkVtDT9Ju0VGFaOADCJ1orR4lUtrURQVYKddo/W
 YywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767790584; x=1768395384;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8EJ/8UO5yAHkGYW0pSPwXOZvLsa/TxganG/Gr4V707g=;
 b=RXU0qRPr4yeTuEktC9MooNa8FGSngP7BUofaUqe1BspbzVArOWetODtVJGH2Vzlt6c
 i8fZ/H1v1AiyxNk4sOZE58P6v2K2nDSPkvJx47nlKgOHr5NX0xxQYx0zqSayMKTe1KHT
 D+vH7+DFUBUaFOmbyy2R/CwyC1WpF/IWeYuYyOMtRduJLb0lAFzvGZMQsYGcwJpGrjim
 16ZTTXwjtdSlByrtMQyfMaaFgSWP9wwSvSEVFnoWV64BVKVGkNc7NiIBLU3ySZGZRnDr
 Vc0jwAEoWzrkO5oAzexJb1iFZfyJntVX9P2pkLanfDHNrAoVMgsxKhp1U+giaq8zZARH
 ekWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn/2Xcbvr+qSMpyeJPRsR/ezpZEeJRDKI5LVo7UB4kzc1r38Vr4Y4U7bg0fh/bpGBLc+k/ZolmBReS@nongnu.org
X-Gm-Message-State: AOJu0Yy3RxfMw5hvRtyufZhjsOWy+ZCdRV5uLNHMAdNi7Y6Vmb+fMMH7
 nxkhV2DdVWInu5YPHPRptaCvoFVYAttfSnmmyi5s3wR+O6MwbhUSHblTNZ46tja73/FsCP1L2e9
 lzUTv2IU=
X-Gm-Gg: AY/fxX5gg5+hf1tTtGhDLXXXN8HM8av2+q7/zzauvQxUVaPGDO7l8kVeDWFY0DQR5SX
 ybF4HehCqWOHNkRcy/UnZg5SY5ThONWsC9pzfn51T5gLqzLWIVUDuNerIl7oolubEiLje5G9Tsc
 tku4OqW/95Osp9Y10ye3Es8brQ4W1tUwT+V8tUjZxyUTgkWI2YcJNKi0IfhjkMGCApyQp0MvQfl
 Zcamf/5PLX1oHoAiQIcrqdSXIXKX6TlBFv86lxiMyt5IbN12GEEaI1h1H6g5mF8l73mFSkJ+EVx
 FYAbvAho0pOmhUL2RsCpUNBbEmmjsKII4z7vjNeTpXCezScWYkffXpstXk+k/irUdZHoC81+Gvp
 CeK2FarGcwtCviLISkk7n3ILZ++Bl+j2XMtrf98I8IgqdSBVKL/gQVhcVKqkBSMZg14D/tnxwBf
 +jW47OAffuymL0NCZ749wIl2ZbkFzxvJ4bB8dDLVm1Swn8nUkDIrV4hEYXUHxUg8N5sV6AZtQSZ
 atAFndCoL8=
X-Google-Smtp-Source: AGHT+IEHYybT0Qug4hifoehb7IHw4YWYOSZQYYOdcrgPhJXcZmHG/2IkEsILeTOj8FhGFDHCWHbQzw==
X-Received: by 2002:a05:7300:2141:b0:2ae:5ffa:8da4 with SMTP id
 5a478bee46e88-2b17d200d87mr1711592eec.1.1767790583642; 
 Wed, 07 Jan 2026 04:56:23 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1706a1383sm6420530eec.9.2026.01.07.04.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 04:56:23 -0800 (PST)
Message-ID: <ba2d7b5c-dd6d-4b0f-b7cc-ef2d78bc0341@ventanamicro.com>
Date: Wed, 7 Jan 2026 09:56:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] hw/riscv: Add the Tenstorrent Atlantis machine
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Ran Wang <wangran@bosc.ac.cn>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260106055658.209029-1-joel@jms.id.au>
 <CACPK8XdxvLLsQxPqSyakxh2GeK2AcGeukcerswB2eyTfeghOGQ@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CACPK8XdxvLLsQxPqSyakxh2GeK2AcGeukcerswB2eyTfeghOGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dy1-x132c.google.com
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

Hey!

On 1/6/26 4:35 AM, Joel Stanley wrote:
> On Tue, 6 Jan 2026 at 16:27, Joel Stanley <joel@jms.id.au> wrote:
>>
>> Introducing Tenstorrent Atlantis!
> 
> Note that this was based on v10.2.0 and passed CI before I sent it:
> 
>    https://gitlab.com/shenki/qemu/-/pipelines/2246526243
> 
> However master has moved along and there are now some merge conflicts.
> I'll hold off sending a v2 for now, but in case anyone is trying to
> test, a rebased tree is here:
> 
>    https://gitlab.com/shenki/qemu/-/tree/tt-atlantis

In fact the (non-documented) practice in qemu-riscv is to send patches based on the
maintainer's tree (https://github.com/alistair23/qemu.git) branch 'riscv-to-apply.next'.

The patches don't apply in that tree too btw, but it's fine to wait for code reviews
before re-sending it.


Thanks,

Daniel







> 
> Cheers,
> 
> Joel


