Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB5C02193
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdn34-0002xb-2K; Fri, 31 Jan 2025 04:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tdn2z-0002wo-VC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:10:46 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tdn2x-0008PA-I3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738314637; x=1738919437; i=deller@gmx.de;
 bh=ubx/D6nZaXQqCtSccisp8eGuLg2MVfvE+hjXqAcOWj0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mb3YgCtLN6rQ5khZJonyv90eaJPf+P5MDFhBeae9Pw6h//LH7x1qzdK3kMc0sYyK
 K3jyUtaiaGjBUq06Jl9/CduPMF/LJcIfra/KDvSNftNQ4QR4dseVApXn5J8MFeSPS
 QMNNBByeESQWl/y8tNt7IiJqlu4nKbJouFuh2JMnFRbSB3JcY/L1G5PvnPR8N/sdk
 6p4kXfok/cL/IPxRlk4qE6tgn/gsp2P47c1EgBTEHorB0/JzY0ZKibUIngoLb4Xdw
 k2gZoCE2pMmFJ1aGFORfmShc9KY/uLiZZ7z5jISWqODaMwHvi5BdAcEz5BlzKT2lm
 6MMKGakBDShFWQAELg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1t8b6Z3T5b-00bEd1; Fri, 31
 Jan 2025 10:10:36 +0100
Message-ID: <fc5a2a4a-76d3-420e-8ebe-e8c482ddfa9d@gmx.de>
Date: Fri, 31 Jan 2025 10:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 8/9] target/hppa: Implement space register hashing for
 64-bit HP-UX
To: Michael Tokarev <mjt@tls.msk.ru>, deller@kernel.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250130132915.16846-1-deller@kernel.org>
 <20250130132915.16846-9-deller@kernel.org>
 <4365fc64-1684-4994-82ad-daedaca3266e@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4365fc64-1684-4994-82ad-daedaca3266e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lo8+Uykk+rHfuXKrHxseD59IlFyMx/poQlKz4tfpL41X21tXBaE
 dcDUNfun9u/Zrj1z7In0hBsg2dOAQmczD72sGnjclOPk53tkhptyPInczzYl0xOk4+F755i
 R7b/fcEdrR9R/y66JePGDdBNSZic9UWWdOFljZMdPxxclEfExCtIpKLHcmKMcXhegvTNYbc
 eFw2x4ah5HV9VkfmEcr1Q==
UI-OutboundReport: notjunk:1;M01:P0:9QP/d1v7iDA=;TOiGH4KX6Ygee6GTNAI3vRJyFm1
 bqP/zJfcrBptclr4D6fWI9qVe5oyLvu3kr0NXPu7OUgAHaSXFx1+IN4fBTwVfWJpVSmPNlFUf
 Ra7ih1VuoZBmrEBJyA3X+04dyaSy+hTYqXU+u1j37c4s0tG/lykY367X0qopdBSk1AdN+jM5Z
 Je5BVxbVtaUwJ48Rwu/TdNockStUsQEyN43RcbmGTvDVDg/GcMSI9rX1RSwLDjL3HjC6unrO5
 R1qb6gJIGQ5jiZXHuUHy+lCKWSsVlMwAgzSXZk0h9G0ZQyNEAiucC3fetu9DQ9ug6OT5gvZ3O
 hUIyImTsSfHzBAssVrc6HBIVxdsP+fvZ8BXI6pv8v99m9Jn5rJCvaq09y4CsoHjapxDyFx4xe
 gUxZ4Tr+TyUqcRyITkpcYkQJPjhC1PThU9k9jxRADWbex5N+dTMuCLpZfntYSjySAdeZzgWV4
 mkKWKUqooOmrHlXoApI1SrzhakA4wc57b038eWaAChQNiIaxhe/jQ4cEUJc6xkw8meOrDQ43d
 xqZTpRXR54MpBttFxy8Ycicy5RprTr/fZef5Tn/4BvBRT8p6LvfQEFYWH4pLcQ3q7PwdghgVo
 f+LAK66d7rPX5WHhugxkRgqve8kUCbzlVXVfR7BP4F/oNqlhRkao4/Jw7oaPsLWujPmrMC5NI
 P3jUPLCY5Helfq0jXfjxmeofwTMdVfPKq4Z+yh4ovrKqegCrYAqgheNegCeym+XApTlSAp3sf
 rwtkSDgfh+A5Jo+IDyI7z3XqxP8FyeYyfNd+KCdKo66XzMtOnaIof2Sqs/7wSpBdxO63NmPln
 LAtN8Nr2Xz8Ok9GglthegHIv5qZJWmCcUuQHXgoHSq2QBMUwr52Q0Zj9wyvwiGDoiYW8EiNh0
 fD190k4YpG9LedOzBIOajDpqYx98IXwM/eZxmYZ4KJj8ZWfUqi6C7uT7EAv8m0/8BYlGZ/0BO
 V/MDvxABaT1dWiJX1zER2X/jhh4p/fFvzKY4f2PVNIJbNCL0lZRgY2zuN4oWD+ZFelOK3nOzj
 AHvh0uwMg32zf8CgW0Lethn3jk0u9b7oWGhKq9RMQuiojNv4sqKlwAYtMV3je1ZjZKUygsM3r
 z68QLS722/Qc5IKYrmR4QQcT/gGFs6t1Ugh0RgaPoMHwnLHpSHyvPkGuJTtLavUtQgHBiaMBU
 ZpWGygHNVQA5l1YH4uV6hJi+eLWZZ09VESnafEkekpOsgAbr3cSd67507HDkT9o9x+wou7zi+
 A4+ixo0fO09dpwq0WhxmsG7nxrLtmbE3/7s6VKmMxOac5RsoAYsSVhAEUS1yMDQJytCX6J0bZ
 GF+b+zRIVujRxMIyeR1u+rC0S6WZWoaKDKnzX53P6OxUnk=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/30/25 20:06, Michael Tokarev wrote:
> 30.01.2025 16:29, deller@kernel.org wrote:
>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>
>> +=C2=A0=C2=A0=C2=A0 if (ctx->is_pa20 && (a->dr =3D=3D 2)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Update gva_offset_mask f=
rom the new value of %dr2 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_update_gva_offse=
t_mask(tcg_env);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Exit to capture the new =
value for the next TB. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->base.is_jmp =3D DISAS_=
IAQ_N_STALE_EXIT;
>> +=C2=A0=C2=A0=C2=A0 }
>
> This fails to build, it looks like:
> ../target/hppa/translate.c:4621:9: error: nested extern declaration of '=
gen_helper_update_gva_offset_mask' [-Werror=3Dnested-externs]

Indeed... there was an
  #ifndef CONFIG_USER_ONLY
  #endif
missing...

Fixed in the new pull request.

Thanks!
Helge


