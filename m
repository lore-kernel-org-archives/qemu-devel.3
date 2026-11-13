Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C606A6DA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QRlzYcTT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvrP-0004F0-Bz; Fri, 13 Nov 2026 13:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvrM-0004Ec-DX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:18:48 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvrK-00062f-Jz
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:18:48 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8b5c3288e6cso586834b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794593924; x=1795198724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qMkF8NH+LDT41ZAKDzQfSGCSoKOMHjtIkGOkv7UPy/U=;
 b=QRlzYcTTRK8RzikOPZ76zYjZg8AKQUNfFZcg/wzcoRKY9s0gsF78sd24wexqu/N3kb
 y1qlvDN+izrxCX6Eq6HoDnUv8KOl2a2CWPc4SjDe2ibj92X7BXCh0dF81CfdnJsMguMA
 oJEd6wGBLa/N80wik7E2h6hLHSCANP4v1FJlgLtJUt0cUWfBRykLZerSH9aHC448bYdd
 UgTn18FaD0VShz7KB0M+M+i0AFikBgEJJCAjkpXO3Q88Hb+pzcpxnTR9mUodcyxi6jWW
 FWBcE+WxmDrZBaMNIR+spZlRjfCRwi2/Y6VHcWIImIptCL+4Q80OEmeqL6qkFqGCwIcV
 kyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794593924; x=1795198724;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qMkF8NH+LDT41ZAKDzQfSGCSoKOMHjtIkGOkv7UPy/U=;
 b=BpnhLTXwV69nfVQAje0SiUgYDXSgz9AbsEnpg8ltQkqN1Zc0w7kOaiaoRgzeRc63yQ
 rK4cBmlOObk6c6J9rSuXFeLBUN8f5kGcHgEk5ZV6v6fJWxGsM/X5wf+6cD4ISz9wHpTR
 gBBoTCqxuKoDrejquBPIHR4mE6L/F8bm9fKUA1YZBUnlgWlwig0Jfl1nRP2U2mb+wQ+n
 vQq7G6ZSLdpLtiX1qBJSuvCgx8pu5anXZuJ3Bgm4Q5NmPgW2WYTtbuJtpBqpV03HjrqW
 0tMKW/wBIqQRzp2U5TGmbh/Ydak4MOQ4yavTVpIhiCvfg9QABuOBhr43QHfC1paD9s6m
 tdcw==
X-Gm-Message-State: APuU4Z/jGShMufiKoELX4zo21jW7f+7y2O0wP2g95QqLEOpSxs3KGLVt
 pmmdgnFQ0UqUNhABwg1TUjwUI7RmOcgiC0ThnGaaFHwy6N9mtgbukldr2g0A4GWNsHXOv77NH8j
 cfEihGyg=
X-Gm-Gg: AYBFou1fgrFb70MubbuSV7FPyyNthyTKE9EkEwyzmu2Fe2osFy6ewWG19/4WgW10Jbx
 1uvWm3mmw802mKdy2CauWEO3AZY0dT/9475Ck1eQEUQnIJae3j6N1EgMrQum3eTwhN00vHogvJq
 UCpwwXGFkj5xxcBjrhx5MCu0c6enYZG3o+9ro13Z35BKN0Ld5pzI5UGCby4IJ1IGlLhs/DR26It
 dMK9jC2xt1TyekPaRiFcM9ACA/k8h7Y0Zlh92OLElxvPOaLuPN6OwmtrtW2kyKD4dtCkfXpFszK
 8ixOkkrthq6rGcBMT2H6vD9hkxfCnAQRQ+Tn4X+oZzc8X00cIymijbXksudtBGze2y0Pvu4t2Gi
 DsFUp9mTA0hWigTfFB8IX5kZb2TvKmtSbpsHaCOQMiOEdr/3DqKS1cv/l7ZlGH9rh/o7RYXONcF
 1Ns05UVE1WWXBXjYh5BCQYjhMRQT5uIJ7kTglI2w0KRT/ShyA/F3Jtu2irr4JwOxcKjA8lEKfW9
 cARhOl3IpmoNDN+zuUFc8PAEzJ09C3tj9ErYluZrpC66AyTvBcN7fHy6eVUw1r7cKxpWoF5zcHN
 zwYbA108G/lQUdEv2tKMLn5a7mM9Nk9yddIhq/XIDbtcYFH3VqjxKPAHl81M67MA
X-Received: by 2002:a05:6a00:2e05:b0:8b6:594d:702e with SMTP id
 d2e1a72fcca58-8beb7d1c7ebmr3890697b3a.53.1794593923750; 
 Fri, 13 Nov 2026 10:18:43 -0800 (PST)
Received: from [172.31.6.230] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed12a97f9sm1403092b3a.14.2026.11.13.10.18.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:18:43 -0800 (PST)
Message-ID: <e54b27f6-7130-475c-b2b6-b7a477de48b3@linaro.org>
Date: Fri, 13 Nov 2026 11:18:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: use gen_goto_tb for vsetvli
To: qemu-devel@nongnu.org
References: <20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 06:40, WX Chen wrote:
> +            tcg_gen_brcondi_tl(TCG_COND_NE, dst, vlmax, not_vlmax);
> +            gen_goto_tb(s, 0, s->cur_insn_len);
> +            s->pc_save = pc_save;
> +            gen_set_label(not_vlmax);
> +            gen_goto_tb(s, 1, s->cur_insn_len);

Did you mean TCG_COND_GEU?  Surely dst very large results in vlmax.


r~

