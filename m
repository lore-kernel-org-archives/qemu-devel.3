Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C54AEA794F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 00:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnTe-0005MQ-Of; Wed, 04 Feb 2026 19:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnnTc-0005Lu-O5
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 19:44:08 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnnTb-00061o-2G
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 19:44:08 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so218733b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 16:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770252245; x=1770857045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIdWBqERGDkCuHAmynKNfKDnv+WTnjtlLCkOUkA+s9U=;
 b=yYwBZuqpQuAFFmEM9/W/gPDJZFrAt5owy4UZdQg4eYe9OP2oeHA2YX8sGFRnnYkaAy
 4Hxk+aJ/m8yB9XiZE2W4WOtIA3KuWJb7FGy/JUOsBRRoJDKvdl+IeKceQdNSe473wBx+
 Mho/7Kblqaoj2rjburVDhBwpLC9ZOgFMAOX7+epyN/5yhlQe+a9EDvLos2npAhIxYoN6
 fHycJt1VsWwIztSFXUH1w+bkSxNCp8y1w87suMI/o71/G3rn8avFhEPBE2JC185z07+C
 dbAIsdl3Fg9xd0TCw4Dcp3U48ZhIK65bzr8U+iKTqIpx70ZH3gcor2HrJNi9ojD3w1Tz
 wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770252245; x=1770857045;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZIdWBqERGDkCuHAmynKNfKDnv+WTnjtlLCkOUkA+s9U=;
 b=LE/pc6LTMJuXmWLcueAeth8s3TlG+CEkb5RjR0Kx8DEczJPoUeB6EGRSaFOHr1n5EF
 +3Gpqwe1Ig8zzNG9D0MDgpiisKSoY+UkZeK+iJwdCjJ4AoVWkzmArSO3g+nGjs8JzsgF
 RAZGRZzm1YYLlRErS2mKL9tRzZ+9Vp5Yl9ZVQgC4Ys4rMp1D6htBeuHVLNhf93uW0w0L
 wLWSVE+MTibrGIHJpih5KKTc7aVp2rpaOxoSlXt57pCFA8JY6vZ48Nv3xbkwPWDm9/XK
 pb9w/nrmnEarvtFpKhd7sqEcdBlfcgNzDQLwBfnlVAVzLHWvRaLMl+lUvvl8p00PFv/V
 rhPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhT8wvV/UoSwL3354WLfn3G/Dj/2q8NY5+uXvss4PpOeI2G/KfKzyanoxkP9H01jzlOUaubbqO2tUz@nongnu.org
X-Gm-Message-State: AOJu0YyoSdwRB270V5HEoi6phRAVcFT82YwlFOiyI+F+kxOiTHCyQ2AF
 IV44nwEsIlVPdnICmX1UF6V+U1HpOx7ShQ8Ncn/csK6Uqa4YLsR5djrq1uJlBc58Wo8=
X-Gm-Gg: AZuq6aIV/rFbdUtg38jxM8p9A6D2IL44wNNRGVr/vyxDWx4CEBTLKmq6m4jE3Yi4etc
 BXg97hWuaQUY1iCH0urBM9fHyNx4NE38qiT9MbSReKAogHSl/x0bap57VuqwBsCpRdkujq6wBoj
 tr8o7cKG1T8D937AOwkOVrxNDLmIxTDgLt9ZmDEn4lL55wzWr6QWzOkeWICAi6stXyZ37oLcNCn
 VGGQ0bI5kRlW6JdoU41FotpmOCRNbcDxN0QPERREKLuEtZAIUUmm+9WxckHhjdX1dUQzi1hsASl
 /u0VJvKrPB16iDCWoT5jrEIxbxR3L90+KIoBq2wCS20xqAJfPaNItcAHfQM+jk9O1oJ7BFtLFTq
 lGm25yyYAok75kl6uDRQ+1d5PUS2VniZjpB6EodN6+IIjJ0dNXRV8GuulEL/5QOePoXmVLVQLcd
 CrDbEenrl0372wUVRJ7QiTa1OZogp7draAUDD/2sGA8eXv01b6rmB888iKUmBmkwsMBja3uJdQ3
 gRE9UIajauJYxYEbbCJwQGYONfO4V/nINon0PvEGg==
X-Received: by 2002:a05:6a00:94c3:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-8241c5f5ef1mr4693031b3a.33.1770252245260; 
 Wed, 04 Feb 2026 16:44:05 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d437c74sm3619325b3a.35.2026.02.04.16.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 16:44:04 -0800 (PST)
Message-ID: <1c6c21c5-da0a-4356-80a9-208d0e147356@linaro.org>
Date: Thu, 5 Feb 2026 10:43:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/sparc: Replace legacy st_phys() ->
 address_space_st()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260204215304.52757-1-philmd@linaro.org>
 <20260204215304.52757-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204215304.52757-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2/5/26 07:53, Philippe Mathieu-Daudé wrote:
> Prefer the address_space_ld/st API over the legacy ld_phys()
> because it allow checking for bus access fault.
> 
> get_physical_address() already accessed the PTE stored at
> %pde_ptr and is going to update it. Assume the address space
> is also writeable there. The SPARC v8 manual only mentions
> faults (with error condition bits updated) in the READ path
> but not on the WRITE (update) one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/mmu_helper.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 5a58239d65e..a6f76a1ab76 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -190,7 +190,9 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
>           if (is_dirty) {
>               pde |= PG_MODIFIED_MASK;
>           }
> -        stl_be_phys(cs->as, pde_ptr, pde);
> +        address_space_stl_be(cs->as, pde_ptr, pde,
> +                             MEMTXATTRS_UNSPECIFIED, &result);
> +        assert(result == MEMTX_OK);
>       }
>   
>       /* the page can be put in the TLB */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

