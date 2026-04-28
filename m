Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DD5FF8870
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbfP-0003Gt-Ev; Tue, 28 Apr 2026 02:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbeQ-0002ZB-NL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:10:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbeP-0008F4-0Q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:10:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso74814915e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356627; x=1777961427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FgSipo2+qlmdUmx+mOMt+/6ZHVUHxr/oXkMKbL8Lekc=;
 b=zUmgQmnx0/kxyi9kzMmfayYWU22f1SGiuOMCv42D4V/7TMAXqgQW2UnTi4h+miJ96/
 6PsZdgF926G9uP25p3MlHbTNofs17guT+bc/PvaU2km8Lio5RiXFfaV0alfafWKVTjuL
 vvFmFL711Vm/NrqVIxqXxoSpgRLCp0TP3h0qX0XAw0fKsWnY0z0RZDQaQIUw4Hgbtg2F
 EX1TZH26JXw/BOUpkvrwi5Kwp6zcQq2pc4QOPwy06ZlS0E8+b/lUwrDDITNlFpaYP+O7
 B8RQxWkQBkxXV+UlowxNXtRxcEplIN+e+cHg+Yz+wSFW9FtFyTNoVfgv6EhyB3tBT038
 07dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356627; x=1777961427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FgSipo2+qlmdUmx+mOMt+/6ZHVUHxr/oXkMKbL8Lekc=;
 b=B018usz4XxUw16BGu2337h61JH3weJBePyXLoMHWhGsCg5QjSijcnX8EoZYOoIR88P
 K2flRHGOTGyyb1rXhdv59TA+EugycOo2cdq59ydOn6m7n4RDnMZyaGSXzR/81IM6KKkW
 CHSZAE/QWBOqSJEyxYa6gOnczxd+wRhW06YlaQds3iOT26GYWOWP8JFnpi0AnaVfHYL5
 8esHlZHXn7gn7OKELGmMDwRwZVZrj64uHFcMAQAqmOOSrn6CfZ3YHGIhLlCVt0byuUMN
 H3mfFpRM6mx9v3i7J/hxoCBxVLrPlQUj29FMCDsjQ3gZ9EGSQGwTRESuhNtLOuBEHHPh
 /E8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lMdR7mbnXLqH1eCq4VymD+ZpQk6WJsrey0OjgKxYFT9PJfP79Be4zFzTrP+Le8Ru44v3Pp/B/ZzOa@nongnu.org
X-Gm-Message-State: AOJu0YzYoS3cGQBBKuzkGOwmfRQL7mSdOEPcIilRnxoUImXlWS/8Zb2n
 sb55d7lEGhfPkxCZ296fP8Q5S4mf15C4g/dpaHL1Hk0jheMUV08akvqatTPhZpwr7nQ=
X-Gm-Gg: AeBDieuSQj9R21s3oifQKzTiIR3YVFX8pDebrhUDnv3+oFCiVlobbzkFqM2MPe1hrjd
 8NGXr0Wb61XoEr1ZuPntfHU86HxPO5DcVQJfLsVN+FlekkZyFehr3NWZ8Dhy3YuTIS28N7YgWO2
 mJsbgFgVY49tBxuuc2fVIjGmCY8enUj2fZzKdpgU8M0XxoCL3omEC+fYL3B8vSiLDHm5cBCMZRs
 WmpFECsKhjnGFAwuKnDNIAFR0HujN3fjLlnBXEYbIkcbbr61jmwNkLqSYdOhq1hMDGDMwAVIIG1
 OffGdERITbnZohqDNv+9+Bpv3ofQIivo8d6qIFesJZm3QdOpBiLhI+zRpioqqDczkrBTsWWkV6C
 srYzDuIm/PvYiD+CYmdJQESwFFAxFv8ASpsRDa6KLhbSAivEpUWEbkwQUaNqx9jmn5CCb4C9eyu
 OyeSEdVnvzwmbClRatEKd6B5UkJjztNUpNLi5bD6o9J7gxIGx23ooVWtxb+yrVrWmMSTWtjk6st
 MXL
X-Received: by 2002:a05:600c:a405:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48a77ae0456mr19890625e9.5.1777356627270; 
 Mon, 27 Apr 2026 23:10:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77b24035sm26684215e9.9.2026.04.27.23.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:10:26 -0700 (PDT)
Message-ID: <2fccc9f7-c317-4913-aa6f-1d67c0cc04a4@linaro.org>
Date: Tue, 28 Apr 2026 08:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 57/84] fpu: Split FloatParts{64,128} to softfloat-parts.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-58-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-58-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Begin exposing the intermediate representation of softfloat.
> Start with just the representation structures.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h | 88 +++++++++++++++++++++++++++++++++++
>   fpu/softfloat.c               | 69 +--------------------------
>   2 files changed, 90 insertions(+), 67 deletions(-)
>   create mode 100644 include/fpu/softfloat-parts.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

