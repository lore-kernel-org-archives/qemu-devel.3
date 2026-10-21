Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F5606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A0pnSYQn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQT00gC9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQvU-0002KG-QB; Wed, 21 Oct 2026 03:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQvS-0002Jr-LE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:39:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQvQ-0002UW-HG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:39:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jOOk3573340
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cax2pBRDbr2Xm6CbmueXDN3yLx48861NkjOE4zPq/1Y=; b=A0pnSYQnnPMR+/6X
 Ee3MXzbMVouG04kBTPXBQFLH0+wmJa/zl1JTTcuWjIfHhr8QLSfjTjUqVTAMpgqp
 8gFgalzKBwOpk87j2FrlExW/P6DZb+cAbEGw2DGmJ/5jbnvgtxmSaw/cFCYCS2N0
 16DZ5U4nsaYRPoV48Lp2yZ5mt96WhMNc/HiOobRq6dDwnKVBD6U+1rN5AQd85Rv3
 c+i5Im+eHrY1i6PEaBJwqV9KCKSQzaxeKiq3ul3BzMeWwBNSiXL/OLfbkhm5nOSX
 hsfPHQov8j+vf7Q3JcX0XyDB4MVJgf8oLNXMppCW2c7Q9ouQI24f2tqjMMh6aMS3
 UJ0+9g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9htm49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:39:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917a2de2cc1so6675036d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792568390; x=1793173190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cax2pBRDbr2Xm6CbmueXDN3yLx48861NkjOE4zPq/1Y=;
 b=gQT00gC9U+eIy/4xzvxYlRyY2Xqo6IQO0RrxkDvNl/MEUrVUjkGgXUwU7Nu6vYpCaF
 HWB6GF3nV4z7Wl+HScjDiQ8xoUT21yKqb8mU+LxRQpT8BKRdnuybXdrSj9qM5Gxgwl6w
 uQ/0kg8+HuR4RcnwJI1RU3p070+U3liBEmghMsIHdGlxqz/19EcHhHFvj5pDQapWyn3F
 v1yKxD4EJx0ADEcTdIC4IymPbg0wLAt9QXHtlwLkUYvBZazAWAi/puEpwOF7zf9yBeN/
 GsWjpQbpKUfKAycMULtkqxM6JOrx8i2VkpXxDMGYxy3b5J5ESgbkJ6JHWeQ64RUBY6/R
 uIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792568390; x=1793173190;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cax2pBRDbr2Xm6CbmueXDN3yLx48861NkjOE4zPq/1Y=;
 b=w1rH/K73x7bDyf8u6yov7ZKgiq4N1wfaTE9SMRKweDHj+8KK/hT4ydD8VAptmGO1Qp
 6Yfkw50EXAk3zjh6xRVKIqnXj920QeiyL/ldXHBgFy5HKPSbrAOyU0oMvy1yRApCY3Mg
 zQ/Gb/XAdC7EpONbOQg5bTecqo+n4gQJ5049QTGcei5jRqcmF5Bu1uY/tGE8jCxRjOS3
 sYMTHR6RY02JeEA4UZpNPtXtoBNrN+Uf06MSQ0bROF0HDVL48Ai+2SKkbJGao6R4M0zL
 dyVAL0lULS9hahM4Ju/rIRSiM/NMw0gN7uyIBJqvaGVzn6hmnW+OLVgKGAc+oghWLtmI
 tMSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYJAFnnCNycp6444b9DMZP0cxWGcSt+jJwQaxNUKqjHTVMPmc7733B08KNxIFrAwwU6z/zBCKd3LkS@nongnu.org
X-Gm-Message-State: AFq9FYIUJ6k3fKUzZzD3kukNSpRY76r1sr8++RzvFy0IRNUiIgno3KlJ
 cKm//1Ws843uBYsNStpZhaNijUixLAY2XKcoWaXzw/0TvOGNSyPfV8haZ1Q1+7ICCDbSzKN/Pha
 wvg5mkWe2ViyP3nrrJ5BRRnDEecejirP94+NA41dXRFtM/lCxih41ce/2ig==
X-Gm-Gg: AYBFou0BfEA+OaZMlo9jA5dH3a/++/hWPx3L8XpWLdGooRzDAPJ46LM3WkoO4oJKgfg
 dCdFDiZPuEZ7fDq6KjcWThpYf5lYpF3pORnXSK71du+2WCZcXaveToq+lhenkUiyz+iTWCyT/ec
 CgAS2akmE4uHFPM01OLyevHQlfQAZJzeQKxeWIRPy3JahaysYzaRGODzrxfXrIa6sXH2a+DyPba
 zrxDWc+Cip95uSe79wWIyNFczc+Qtaub9GEede9XPMUuXoj7WiOSrjD3dkSLHLBAsvWVxhz8EIj
 iRYKtCr8cazGC91gDsB5t7HesQjsIsxToHh1Pn3MM4A3GD+k9bcMkLsDEyIDagvsgmamv18FiV4
 TRs4JBrH6p7tbrJFV5xIaVELSRGZO76owig==
X-Received: by 2002:a05:620a:241c:10b0:93f:5bb9:839d with SMTP id
 af79cd13be357-93f5bb984bamr35663285a.72.1792568389717; 
 Wed, 21 Oct 2026 00:39:49 -0700 (PDT)
X-Received: by 2002:a05:620a:241c:10b0:93f:5bb9:839d with SMTP id
 af79cd13be357-93f5bb984bamr35661885a.72.1792568389192; 
 Wed, 21 Oct 2026 00:39:49 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb86540csm55389885e9.13.2026.10.21.00.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:39:48 -0700 (PDT)
Message-ID: <fc4fe38e-d3f7-4d46-aad8-613df57d9260@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:39:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] target/sparc: Add the SHA instructions
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-7-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021064640.3591682-7-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad86c46 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=FwM2K8eGO7t9ZhkUSWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMCBTYWx0ZWRfXxKpPWI+1T0Xx
 cDfIHGE6SYBpjOV6Kcaq2T56E4Y6D/WPYdbeG6GX0UcZP0M0kL+sGbyMaVhbufrJglH91fea9He
 6BKK6is1rFopKbKRtwT19wlKuUDUZCU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMCBTYWx0ZWRfX4CRJ6zW11CwJ
 MJlG9b4pLcy+4Vrd57QC/Q08qYM0GWiSNBvWZxwECFvYsPWD+UBLbpBbnza2DxnbZS1fwc6DNt7
 qqaqt3qyWF39WXSUPGr2obag69gE7cmOqWRg/zucr/2egpEGrtrK5WmT+xCKScVyo6p7tS3STp9
 qNl61QdVrF7QiW402WgFF8FFh+lZ5Syo1miWQ8cBtzRpazer/EASJ6UHDTCMtreYVeudAriVMH7
 EcqiGsSUoOqaFU/4CdBnY0LNej/LpdJci0Owwr7fIm//kkPIrNl5SEZ9VbZiL95Y+cXCfiaS4i2
 xA6Ffc35/LF1aTCNZ40ge2T+qjk/L8d7tj2yLe4ZW/lVPClQu569luSKIQThBSMKBziCs7llzBr
 exp+UNrL5W3zBON2zugj3k5NtZit4eAMkNcH5hEB++EyuXbzX+4fztmogyMbKOGUHcwqS1zbr1B
 /iHkWtIi7IN7oQ6vLXg==
X-Proofpoint-GUID: GW5OShU0Py6CAk25_TaplSTYVqvFNTyl
X-Proofpoint-ORIG-GUID: GW5OShU0Py6CAk25_TaplSTYVqvFNTyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 21/10/26 08:46, Stian Halseth wrote:
> Implement the SHA1, SHA256 and SHA512 instructions according
> to OSA (Oracle SPARC Architecture) 2011 section 7.115,
> using the algorithms defined in FIPS 180-4, and set the
> SHA1/SHA256/SHA512 bits in the CFR.
> 
> Read and update the fixed floating-point registers and mark the
> lower FPR bank dirty. Share the SHA-2 Boolean functions between
> the SHA256 and SHA512 helpers.
> 
> Gated behind the crypto CPU feature and disabled for sparc32.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 274 +++++++++++++++++++++++++++++++++++
>   target/sparc/helper.h        |   4 +
>   target/sparc/insns.decode    |   4 +
>   target/sparc/translate.c     |  21 ++-
>   4 files changed, 302 insertions(+), 1 deletion(-)


> +/*
> + * Compress one SHA-1 block from f8-f23 into f0-f4.
> + * Clear f5 to match SPARC M7 behavior.
> + */
> +void helper_sha1(CPUSPARCState *env)
> +{

Looking deeper, this is a dup of mips::octeon_sha1_transform()
in target/mips/tcg/octeon_crypto.c.

> +}
> +
> +/* SHA-2 Boolean functions. */
> +static inline uint64_t sha_ch(uint64_t x, uint64_t y, uint64_t z)
> +{
> +    return (x & y) ^ (~x & z);
> +}
> +
> +static inline uint64_t sha_maj(uint64_t x, uint64_t y, uint64_t z)
> +{
> +    return (x & y) ^ (x & z) ^ (y & z);
> +}
> +
> +static const uint32_t sha256_k[64] = {

Dup of s390x::K and mips::k.
(target/s390x/tcg/cpacf_sha256.c)

> +};
> +
> +static const uint64_t sha512_k[80] = {

Dup of s390x::K and mips::k.
(target/s390x/tcg/cpacf_sha512.c)

> +};
> +
> +/* Compress 16 numeric message words into the supplied SHA-256 state. */
> +static void sha256_compress(uint32_t state[8], const uint32_t block[16])
> +{

Dup of s390x::sha256_bda() and mips::octeon_sha256_transform().

Worth consolidate as include/crypto/sha-block.h

> +}
> +
> +/* Compress 16 numeric message words into the supplied SHA-512 state. */
> +static void sha512_compress(uint64_t state[8], const uint64_t block[16])
> +{

Dup of s390x::sha512_bda() and mips::octeon_sha512_transform().

> +}
Since this commit is reviewed, let's do a consolidation cleanup on top.

