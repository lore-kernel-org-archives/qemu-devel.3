Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C8BC44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfct-0007Wk-6O; Tue, 14 Jul 2026 12:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfcg-0007Rb-7x
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:04:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjfce-0002J2-F2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:04:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcQvQ893442
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 16:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nq4tAT4iJ2H4KYEtI70t/543lStLhv3eGzbVriwA2w8=; b=nhapWrfcb0NjAOaL
 VooXN8TSBjg4Suj93+BnMebRIn7+qQ6HT7LjF5fdrhUMkrQ+fiUIM0DQuSrhh+yN
 O3EBJ+nvXdLRqIIbbqzpq4MaI7YNY2Er75a6vw7Pvdo1OTzuYBJZVPQJtGtBpUZp
 OZ26IEYnR55F0ras7KCu8cLNaAR5A6fb9ZVdFjnoUW1vRFQi1yhzjMANb5Pp+xCz
 Covc8i4pV5H3m9yOr4Bp0cynUSM06o7MiR0iBkchOjUQAUmzw4ZaC/gTgR5zcbU+
 DNOyfDSt69XvmQk5C0NvR+BvlP7u9rUEkmS4JRf52qSZNGwyqXhLU30yYqW13pEX
 2L3PmA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqrssb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 16:04:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so1248116a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784045075; x=1784649875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nq4tAT4iJ2H4KYEtI70t/543lStLhv3eGzbVriwA2w8=;
 b=JyOrJDYNLa+0LExstchJvNPoMBkPM/FD5KEdtc/jgRBfXIiOTW/cKOGChBAG41i9Rf
 UMX/PUOKcL4LgTsYgo/oFRlGvKyheusfIgmpxNt/hcbMKSPUHognBsAKRtQETLelLpp7
 XoHCtD2Qstm8FpNEK6ECWArnRe0r5b55wtxz5+nXnVqK9Fab44Tt80RwDbJn4n+GGMSy
 2tPqroNDSjcPNzxuu6fysZspMWd3VSB98RqKGcWRHHORPfsIVcF1J4IB/Kln0GKZ9HtG
 dIf7xiVM429JKy63Q1DEbyX8XqADuqTCCE7HscjVhwVtpskWx5ObNs0waPDpYM9xVzMQ
 vppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784045075; x=1784649875;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nq4tAT4iJ2H4KYEtI70t/543lStLhv3eGzbVriwA2w8=;
 b=qoT0xc9HzGF6cg91IUSRuJfXU/OZIC/Dloz+jY7Iqe4Lf4GbYiqyqd+Xg3p+XHBuKT
 0CSh/2Emy5tKIyWhmqbOTMnkW2WvQ4AMZnB6uooGlmZrvcMvCZQRlLZjcIzxYPnmuLzq
 m+Fm4SdNb2NsI/J3alld0cZ+CSKCzxuD76Dm40IZjsXLOnFa5zqwYKniScz0b5H/ad/H
 96ByNA2n1Du8vfk1noweRlM3GnI92Emaj7uG7aS8sAmQ1knUoS8w0HTlVgcR7S2rk1x7
 oNM2u/E7sLgPn+uV6RVOdDBvgZblR2F7vpq0xKJBwoEp7tN+GNy8qGtjrdK+DTSFQwPI
 tnZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RosL1LMvZzIA1gTuVvLqZy5jBYmrA04uTJcCHCs1mUGcbs27t81Eyyk47DxQlzugJXnprmbF0PpzymV@nongnu.org
X-Gm-Message-State: AOJu0YxEo46yAjuOvFngL1RSoTkqwDSdibEeecU8vQ82QRimZ74yEBbI
 AZRThZ7lqaJH1qMSiTDFQ/3XdC09+DK97ZeJxdx6BIrtYuJUCArL6HuZjbZ9HCjebqQPYGRTaNw
 3BBYKxhKTURSFuqlB9Sgz0RS4AbzxmQPpfxqLl5FVIXIbo1InrKxrJJEVkg==
X-Gm-Gg: AfdE7cl0AOv+kCd8v5KONjrjxffATDZqNNVaUnHkPniUtiuxvfzAMR/YFz279bB0lO4
 bLiE+1fRBkF4jrpOirPAReeUPHRMpRTlPMl3A9fgtZc4L0v0vLMhp9/0Upnt1JCXlBMXt28o7Zq
 G+DcR1eYdpM5TlHjtLrsOsMbPsPKbumpIA58KJFLyFqAWtoEXi7OgszQMZoWVjmtdbBCtY+W75k
 N8wpTw54Cs+Ix66GokqqONuxwuSCJI+aKFDROpM3iW7vAYMBZY0OHJs0pUiKcTCHbsOA8D1tPgQ
 JOQ5zS3UUm2Een8T4aQH2Xr0NGKO8+Kxd5GZa2rwaeUWTwt59uOCoVQZ9lRST0sWcCNreVOGGlg
 tdJcDDW0F2JssoSrt4FaYDh9hoHSqaPdWkaqbg11ByYvwIxtncxYLU5H2lvgTfvkowqzk06JrW7
 z6Nxg=
X-Received: by 2002:a05:6a21:398e:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-3c110b15bd6mr13957469637.37.1784045075533; 
 Tue, 14 Jul 2026 09:04:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:398e:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-3c110b15bd6mr13957430637.37.1784045074962; 
 Tue, 14 Jul 2026 09:04:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31198cb2b99sm56188071eec.26.2026.07.14.09.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 09:04:34 -0700 (PDT)
Message-ID: <21ab74a1-3267-4167-ae04-e551eeb795ca@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 09:04:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: propagate qemu_ldflags to Rust link step
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260714021236.2361604-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714021236.2361604-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NiBTYWx0ZWRfX7sJwmDOyZGEr
 ZdY9pHbkWl/BYZArnxO9FzWRReVM3iYDRvLb6bzodyOt7SYzCai0mbufiBP/Uj8eURzKkwqFql0
 HsWHdzxeWXEWu/hyGRIG23I1thpjzJk/dZx5p2RGI5Akw7fJIBjfJNUkGEZd2DV6FwjqI0/4l/+
 Ew+8eBizTTjZzOVjHgeHNq8CTK0Yv2CR7qXridjABAauJSLC5m9IqsZilfgQt08mvHL7KvLuNm9
 pPxHhRIaGhQub0CrF6abBksMNMHEWRs81CSw5Sm3pg90SDkdExY8/f0YMK9z4et5RvfZXF5jwP1
 rs4gxtrTnqoHZ5e8TsYJWTpDPmEqtZTSHm2sgl2g22Bo3eiiSsvBeJKGlW4nI6jTBqdzNsEL8Rw
 Ln56EpQDJdXEO70NlApOy28pr/HTIk6PI1ir4sH81fTEGWPTKYLtATF2Hfl3Q5L94otTkF63Gmb
 OppadX/pfGpIIXRszGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NiBTYWx0ZWRfX47n7IhEUoYnQ
 lnZgGBPN61PXQ28s3H4xV3cZqKxzALt/4kPTenMGCTCsaofk4wmFTNfDikjLm7/mvueDB83Z54M
 d4SbAByQUkxAzJx6qai61WNrfujmjN0=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a565e14 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ys3snYJLOefIJBQsk0gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: WlcuYSQ_yv-JoHvuov9CezVNKmYSo1_C
X-Proofpoint-ORIG-GUID: WlcuYSQ_yv-JoHvuov9CezVNKmYSo1_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/13/2026 7:12 PM, Brian Cain wrote:
> Sanitizer flags are added to qemu_ldflags and applied globally for
> all_languages, but all_languages never includes 'rust'.
> 
> Fixes link errors like the ones below:
> 
>     -Wl,-rpath,$ORIGIN/../qemu-macros:<sysroot>/lib/rustlib/x86_64-unknown-linux-gnu/lib"
>       = note: some arguments are omitted. use `--verbose` to show all linker arguments
>       = note: rust-lld: error: undefined symbol: __ubsan_handle_type_mismatch_v1
>               >>> referenced by event-loop-base.c:104 (../qemu_before_fix/event-loop-base.c:104)
>               >>>               libevent-loop-base.a.p/event-loop-base.c.o:(event_loop_base_class_init)
>               >>> referenced by event-loop-base.c:105 (../qemu_before_fix/event-loop-base.c:105)
>               >>>               libevent-loop-base.a.p/event-loop-base.c.o:(event_loop_base_class_init)
>               >>> referenced by event-loop-base.c:58 (../qemu_before_fix/event-loop-base.c:58)
>               >>>               libevent-loop-base.a.p/event-loop-base.c.o:(event_loop_base_set_param)
>               >>> referenced 11240 more times
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  meson.build | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

