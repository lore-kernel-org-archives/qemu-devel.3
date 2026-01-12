Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0483CF45C4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMhJ-0003Jr-Sy; Mon, 12 Jan 2026 13:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMgv-00033u-LO
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:31:01 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMgu-0003su-84
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:31:01 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8c2f74ffd81so696349885a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768242659; x=1768847459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b6uieIeewOukCboSZ9Dv73+Ty/KZCrHe/78Xtt0TLNE=;
 b=Ow0YE1/jBSoHUgRmSX38oN8L3Xgy9fNDNIPmHZL9qKhDrmqQ/S46rwudJhBzshib7T
 y2C3INCjfntBTdzL/DfWf7m7lJdNWA0V0tGZm+EIl1AiJVtSPGm7wCf3Z6QD1x6Hu24L
 ZfpmydvwuXRVagL5UprxkpjbylK1vLPCVDrtRfNiyEXtA/Fco6qG8KJcaAcN104upZ5Z
 Bgjkq+c7GqrJurzuWWTbixQeo1mL/hFjGH3LH1MgLcyTdhEQnNJfg6clE1IRazROE0ZT
 dqMqiLawFN+m3WFkvwNpMnMzuNE02SkqB939I/yd83CWy0O42fov7dv3tnQsLtPsPMLY
 q+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768242659; x=1768847459;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b6uieIeewOukCboSZ9Dv73+Ty/KZCrHe/78Xtt0TLNE=;
 b=pmsXZ2poZ2r5jJDVm6jWUZJ/4/7M/mPfKnYEDU/hzjm6yjCq8FylHwp8u84hGdp+J0
 x6TbddCHAvQqQVq16HmrHBML6409BJKc8ynyAqf43SOc0jOfdLI64qo9w5vEsl/m2w4q
 P30GLk+xxf4Qnl4n1cuSA9rBmrLJrnx+WTWwm0RFRWeypW1ScfIOZsaEx1yntwUqiOYo
 May0Ew55hdOUpA7nzHbAeUGaFSLRMjXDtwmNHx0r++lwZw6fjxp4zsRECUlWN2V2xlGI
 b59QRieFgPEmbPww0SIjbXk136IevPmkjKeBGC+vzNkVc2Ua+PsSAzJnaDaQb2DCm4cg
 YD3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi+v2a8u2TC/psY7gQOCbPwGtmfSiTQpeLSfmM5WNDyS7tC49RWXA8FyTXEqfA3epunoSdMrjtuIwD@nongnu.org
X-Gm-Message-State: AOJu0Yy6hlPyDIC2SBd2J9opBHaZLuXeGno9w2mNP/wt9q8g5Qi5qd/p
 kSVaKDXi88MxImsi0kPLnDEv5NGWvQ6bck0Fx35nRBYgYLi29zF2D3Gn4lej8HCGxIs=
X-Gm-Gg: AY/fxX7sinnrg0fLmnGfRpIzSzkfyix1sl17ARiP1PXoWN8t5N1JPLOgkMwJ3XbS1/n
 Ienum25v72BRanjlqGBbnT+toXojrPLGp8w1dNAn0uGZR1kgIfgWtj8Yh9jb3i08L5eLh5sSy41
 da2tjKXNXOnMiJu6nvyMXe+vo4pEh5VCbrKvwJATrCQTHBUWWRYsSJ71vKeQFNMDhxQ5UNTQkbe
 Y1ubp2MK1b35jH2nxuFhAovvf0o/N+Cy8QDORkP3rLPjD/u8Db4Rmnr9YH1djRJ9dTzfz3Wf2Gp
 1BpkeITIfsHHPCtnX2iPm9+Z7bhOEgfVdQWiXM8vxOLoVFQgb8UPHRGCu1qVUZFY8YM9jnoOAWX
 nwRL7w5dwFP1b2KSUy10rCFw5SSDFYRrfAfIhqcJ7Nk69/vqD4Ex7b78fEWPjpcYyd/MQwvAtOG
 mm5J2lXotOyuZDi21iGifYYqubhp1lpMFJ/Ufe4OR2
X-Google-Smtp-Source: AGHT+IHyKdY31X6JhZTGTCqjtSjy8LzixrM+DoJyatb66ZQzQu6CgLwCtNs4/vLmVnh9S1M+RQ3rrw==
X-Received: by 2002:a05:620a:44c6:b0:8b2:6bdf:3d15 with SMTP id
 af79cd13be357-8c389368a47mr2711934385a.8.1768242659004; 
 Mon, 12 Jan 2026 10:30:59 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f530907sm1545997985a.39.2026.01.12.10.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 10:30:57 -0800 (PST)
Message-ID: <de570b00-7c14-49cb-82b9-3c91f1258fce@ventanamicro.com>
Date: Mon, 12 Jan 2026 15:30:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] target/riscv: Expose Zvfbfa extension as an
 experimental cpu property
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
 <20260108132631.9429-10-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260108132631.9429-10-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/8/2026 10:26 AM, Max Chou wrote:
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b3caf26704..8eab992154 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1377,6 +1377,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>   /* These are experimental so mark with 'x-' */
>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
> +    MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
>   
>       { },
>   };


