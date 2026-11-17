Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KaWncFV6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOpR-00061w-Oo; Tue, 17 Nov 2026 14:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOpK-0005zk-QH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:26:48 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOpJ-0006Pl-4Z
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:26:46 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso1176395ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943603; x=1795548403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3YvFttkHLRcuwIxCLfFaoavYhiOZYN7o8oeECAy5OA=;
 b=KaWncFV6zLAn39mx2qBmJ+pb4a2qzQOHKxRsqEVew945bXvMuxclfQlLhQTIGJkjj+
 bmCpRf9RfPcdmZMwILflAks/mSAXh0aODcbB3jjBS5CREyRq0Oya4eBIvaJ6hH9lel0R
 TJ5I2YHM+fYqjzmCakmWb0j2m+rTwEtuCugm2S9k8C9cOhC1MVTFKb2arDWOd+ac8C1f
 0zVMgVvJmpqiHZeqCpLwsG9AfP9om36BAqMAMRDO5dQndvJ0f9SaI+HJuiRxTqOHZ69p
 saQlFMbZsWusqcjhX4kciX11Sg3ZCZzEq0Az3ttmr5Shm4MqgdyOV1/JKosrOeTabbF+
 NRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943603; x=1795548403;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3YvFttkHLRcuwIxCLfFaoavYhiOZYN7o8oeECAy5OA=;
 b=sH7Ch+SS1/T5IgGDtJyL8E2o5hh1WjJmsGaWSMzQtGIur3iYKcAbTi8lT3JfQVuofC
 C6CGY+/YrtNQOhb/xmvnnD1gByiBGBcHTyhkfoKloo3MvIWisUkLjkfWFKDRqBrKxE2w
 ttnOsedfXpx6DyWvXXXCxId/w+xgDYIp/AWZWbbo0UwYGb+3Z0oN2HGALY4apx7pyXdl
 Dkz9i4B2yc9/2uQtC7HYURA4tefB/wg2pnpEFz/kij1Ac0tXZFvWgtPyAZYpxjdbkguT
 Zv01KVG13/8zYWaUh9chP/WKUBdj2n7SkJB3rYmskZ3RFrfGweHEUfr7gKE3HalPSEQp
 2SAg==
X-Forwarded-Encrypted: i=1;
 AL+hErGDgCuojpXzJR6lc3YUYnDKNgO+X1aDKy22y3pI74X2fBY+eWNx4G/DYHVC63u0AAQehNh3OEMAFuUC@nongnu.org
X-Gm-Message-State: APuU4Z9LUH7GzS+Wpz1tRXhZ+oDdgp7YhojBS1I71BUuiZfyoWsZlcTD
 X2XJAKI55GGn2negUrDRnvIVZBriFrdrAZvl8yH3iTiMLBNHqilzQhE68xX/14deCf4=
X-Gm-Gg: AZFdTZeAKtMOBBpYZGLcpFoIWPtgQr5iFvISTdtP7hn2N5rehZnruJ6fxBdjPRYKXfj
 v9fODVM/nBM5iabbIPerWVzlubzNbey1/4Cv/L/fMkK6XuRtuTvc/TpmS7ggZ7SvyPBaoYPZSvE
 gkW6Hk0IsB2xPGKqv6/EpWzvXew7tcZjyxH1z+5d0QKbob/fgigMdUzD1ixDe2/PHlTU/+OW7u1
 YcCfA6922Lx1rG2PRlPffrQ3eSMUrjNoCb52hOCCJVM6FYw04T73YBO4qFWI40vummSbV6s1rxt
 eZAR3T++Je6Y0nTtFnxTzhBVY1FJl6XyZ2qN4nE3XXOB/sE7nBjiSwBXZEI1RDwrFd22sMsmUGs
 yJpiJp21KMSnNX2to+FegPfX4EC7qTAOsuelxQGaneo1o7ylEGDj3O6KWxDGGA3L1m7rN7dhfke
 4kpiGyGGxevSoSsUxeOzD7NYxs5uXgwtg0Ox7NrleaVe/WMicYWhYdsqBtVb/WPKPmiddWgcDCb
 UZ8YNiFvGF9wUip3a7IohS5El6WQOG7whYN8PJ2namA/J8hU/JhvzPelBtqmK60ocg0/+QpK7N3
 Jyzj2omDIQBeJ0XOuvKQdlnP6nQrxi8NZcY7ApFnANAfZx1xnYx7MuhRO7yDzrxXz4clecM=
X-Received: by 2002:a17:902:ec87:b0:2ef:e285:7085 with SMTP id
 d9443c01a7336-2eff7525e22mr2622825ad.44.1794943603461; 
 Tue, 17 Nov 2026 11:26:43 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6246213sm1813785ad.56.2026.11.17.11.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:26:43 -0800 (PST)
Message-ID: <4d7da53d-8c5a-4080-9407-a6f4e186e3d1@linaro.org>
Date: Tue, 17 Nov 2026 11:26:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] target/mips: Don't set forbidden slot on
 never-taken nanoMIPS branches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-18-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> BNEC (rs == rt), BLTC (rs == rt != 0) and BLTUC (rs == rt) are NOPs,
> but flagged the next insn as a forbidden slot. A following branch
> then raised RI, and a fault there got a wrong EPC/Cause.BD. nanoMIPS
> has neither delay nor forbidden slots (MD01247 p.12), so just fall
> through.
> 
> Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
> Fixes: 14668cfaaf4d ("target/mips: Fix emulation of nanoMIPS BNEC[32]")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

The problem would appear to be elsewhere: Why would 
gen_compute_branch_nm *ever* set forbidden slot, given that nanomips 
doesn't have them?


r~

> 
> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
> index 68e9ca9cdb03..72d72f6f84a0 100644
> --- a/target/mips/tcg/nanomips_translate.c.inc
> +++ b/target/mips/tcg/nanomips_translate.c.inc
> @@ -4370,26 +4370,20 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>               switch (extract32(ctx->opcode, 14, 2)) {
>               case NM_BNEC:
>                   check_nms(ctx);
> -                if (rs == rt) {
> -                    /* NOP */
> -                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
> -                } else {
> +                /* rs == rt is never taken: NOP */
> +                if (rs != rt) {
>                       gen_compute_branch_nm(ctx, OPC_BNE, 4, rs, rt, s);
>                   }
>                   break;
>               case NM_BLTC:
> -                if (rs != 0 && rt != 0 && rs == rt) {
> -                    /* NOP */
> -                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
> -                } else {
> +                /* rs == rt != 0 is never taken: NOP */
> +                if (rs == 0 || rt == 0 || rs != rt) {
>                       gen_compute_compact_branch_nm(ctx, OPC_BLTC, rs, rt, s);
>                   }
>                   break;
>               case NM_BLTUC:
> -                if (rs == rt) {
> -                    /* NOP */
> -                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
> -                } else {
> +                /* rs == rt is never taken: NOP */
> +                if (rs != rt) {
>                       gen_compute_compact_branch_nm(ctx, OPC_BLTUC, rs, rt, s);
>                   }
>                   break;


