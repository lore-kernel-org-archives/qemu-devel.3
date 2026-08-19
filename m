Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4A6C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTve-0001yU-Io; Tue, 18 Aug 2026 20:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwTvd-0001y4-9N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:13:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwTvb-0007FX-IT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:13:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkWHH2775489
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NlymEI+yGyt3qY+BQvqBBdxm8DNNC4O+rcbm1SGwfto=; b=WFfRjcF7AImOTw4K
 hlwGfJnmne9I5fxtLqQifV1mmhiQewptwoe+kJObwVVjeJTAHgLo/Aq9TJ3U3kq5
 ACUeUrrpcqOd1lGOrxsl5iTGUzkkxeScH/r2/HOwiLwn8ugVFeKch3bwz7fQM41T
 b7BSH6SI/V5N9OXfWSsodl0nQJ9HzXNuP5S9MqNPevOlZajsX/9Gx+gswgX2OT9B
 IjAo+M+KLEJamBNe9JaEalAEVP6som5knHihGMpKDQM8oiBGSUhZZ5dvCZv0Pu0N
 1o4v8S3Cq5OcT59iSCLycppuhpsIhXe4/fsFkxeOB2FMbRM8kSTponU6veynp1ak
 JotyiQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yftrg8j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:13:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e538afe65so77447385a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787098388; x=1787703188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NlymEI+yGyt3qY+BQvqBBdxm8DNNC4O+rcbm1SGwfto=;
 b=Lk98R2N2l9URnrnR7tllc3xAfa4EnyM3inqroVKeAZttqF8PqykfOM6pdEb0DT6q3A
 am91mF8SgpuTrP1RLNNiD/R+Qp1RqqQcb1s5glNuRDO8OKx4Y8yva/xEOaJwRmrKNbKA
 iPTK9aqKNVTqJ3uC/mzIuSId8DT/fK6rwrirogUiyGLL5o58nDFbQLT6DKmP+3AIDlmH
 KC20rRVGtwYmk7r95k8iMskRxB4uSuiINt7KHxvfadCEo/kevxw1YFNQiuc2xAsswckr
 a649W8UKQg8Wwlx49Czu18VLNAWGQtapDJ7R62lSLwi8+jHmqsPQDzb6mgdtCJoj3NKm
 3EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787098388; x=1787703188;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NlymEI+yGyt3qY+BQvqBBdxm8DNNC4O+rcbm1SGwfto=;
 b=sqR2Zu8377e63rDB1Y2pnu9htLrAiWrYH/J2xjrRWGAGcYtd2hz57qlpDktw+KmJOy
 58Z38wL8TweAXkBR/5x3lXx2I35rlG4nXu7Zzv8mhKdMsjsA1EfUH9qgD/gJGY+Yei+1
 E/VzYc5oEXoK+v4Nqfkn/ZsUMSYfVXgtbZIUg1aN6LCzKLYaRMzFkgwiv6z4PZ8nRjpz
 16sOs8HQ+qod3KC3mPJ08TTWGl0YG9TObXs+vrxL8u1JWmF+w4abHGC1v3+ZrBJnqA3O
 vRG3pM9AUT0EQG0gylMtKsJMUqZo0n58TsKQ5A6X7zQxJUiSAH/OXY4UmndGfupXMxG/
 c2Pw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqmnlXHNaADB6eTnhYb/Qta5rieb9X8haYchrg2FI7rRaSoo/i6g4f92nZt7z3g0aS3KKaKgW+gVlP@nongnu.org
X-Gm-Message-State: AOJu0Yxh9W3AIz8D6Ik1647cTr2YVT1f7Xreqh0vqsw+R8i1KVzD7sx7
 c3HATEKPgKOryTcDlSPLBlISasHbGG5821xOBHe/n2QDlOFpSLR206icqo5xbrvv/yrENkKM07m
 KaQTwtkwhj5IjBUvsPEb3DlegN/d2LmW5dhROZUp+Juojkcrrbi6TI6Z4sQ==
X-Gm-Gg: AR+sD13kOdQAmUanil3zEMJkN/sKtN28p5esoGWO7mMWyboo2wiqeq58qy1znnPZgj2
 +FsgddNLKlwPrlgcXneX7y0r5qzDYlg7roifQs++alCpe/GI6WS6oZxWDGwO5R8zXKdMJmtMGtG
 PORkvfBjsQ+1/nFpDx7HfEu/Y+GCjKev2e7KTjNw+aHhPoI9x8vGYucvzH+SPzJsywUwpxmccMf
 hNztGBVECls5eSYT905MYoz8npZKImppmEq2Exvz1Sl62j2jjrFPeWT+rJYI4oybGYjmjZZawTQ
 uxsWz0fkcZOa+GnpelF23rdYfky478D573iH4na0GtKF08FZn3xdNowVBz8AsYou8cesaAy1wQm
 IDAt24ZVq7nxOoaZJt0vKzjPoE4tCQBdpDBI=
X-Received: by 2002:a05:620a:4148:b0:937:123a:3b11 with SMTP id
 af79cd13be357-9371e309730mr109458585a.28.1787098388089; 
 Tue, 18 Aug 2026 17:13:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4148:b0:937:123a:3b11 with SMTP id
 af79cd13be357-9371e309730mr109454985a.28.1787098387649; 
 Tue, 18 Aug 2026 17:13:07 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d23sm1038657f8f.22.2026.08.18.17.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:13:07 -0700 (PDT)
Message-ID: <a21cf4e9-7e42-4118-94bf-778c03e16048@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] accel/tcg: skip the can_do_io stores in user-only
 builds
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-4-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818174247.649526-4-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FIorAeos c=1 sm=1 tr=0 ts=6a84f515 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RRnN5sfBe9EQPApPXHgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE3OCBTYWx0ZWRfXyHk8au8Rpfli
 Zt/IXzV0HXiRYf4L6u1ywlSJZ0PoSCD4kTGDOLEocujGYwfRhgLjUBV7pn8skEqvKj02l7IgYah
 0Js4jUtOZNXFsQV/8BQjoegNXga4nEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE3OCBTYWx0ZWRfXwZoBixmcFjIc
 eTs6QwbYdL0fFKIwxBfJJe00erHwdvhKTI4v+N50OVGwl+OQ9kaOVIIGiOUs+RzwDcBG8Yp4CT1
 Aax5CBEAa8ZnYy1iBKl5q1zwBp6bDzfFuv8RM5QBA1x7fJTe2h5CbzLj3KLXo0y3OnPyZLFFysz
 g9nUkxqCN+pH+KQEW2b7i0/NdzROeFvzHgUD8JxSIbu7/qjOBh8I8eztOGYAb8/J34tlj1XyDO1
 bqgh7z/VW6psnTihC2yWfRO2gguPoWZvr/bZ/xyT7v1e6oxG5gdvYR+nqdcshcqgg3W6GR8wnDP
 ST/pODXSStq7PNyDzU9vPYRvTRYfVmxRuUhqu+oYRK7x5i9Mj+gM3Smh0J9n3/Rsfqc8MC2o4zM
 rEqf8OpBz6AdoaTMOGZoZqopErPohuieeIwvgsOKtBAsPF5fl5U1mq2aXRxvaU9wX62Ohin2V9z
 fJjZoJRI2x0BuYqwh2g==
X-Proofpoint-GUID: 4gdUiVbe8LRFKDKA6eufFthEQe1Uu_qU
X-Proofpoint-ORIG-GUID: 4gdUiVbe8LRFKDKA6eufFthEQe1Uu_qU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180178
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

I presume this is v2 of
https://lore.kernel.org/qemu-devel/20260817190038.580257-1-mattst88@gmail.com/

On 18/8/26 19:42, Matt Turner wrote:
> Every translation block stores to cpu->neg.can_do_io twice: false before
> the first instruction, true before the last one. Nothing reads it in a
> user-only build. There is no memory-mapped I/O in linux-user, and every
> reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
> tcg-accel-ops-icount.c.
> 
> Two stores per TB is not much on its own, but TBs are short. An emulated
> alpha gcc 16.2.0 compiling the SQLite 3.45.1 amalgamation (255k lines,
> -O2) executes 34.2 billion TBs at 6.04 guest instructions each, so this is
> 68 billion stores for nothing.
> 
> Measured on an x86-64 host, LTO build, on top of the preceding two
> patches:
> 
>      before: 1,469,729,281,442 instructions
>      after:  1,402,816,253,499 instructions   -4.55%
> 
>      before: 120.97s wall clock
>      after:  115.75s wall clock              -4.32%
> 
> The emulated compiler produces byte-identical output.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   accel/tcg/translator.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
> index cd7d079fe0..85bb21e911 100644
> --- ./accel/tcg/translator.c
> +++ ./accel/tcg/translator.c
> @@ -23,6 +23,9 @@
>   
>   static void set_can_do_io(DisasContextBase *db, bool val)
>   {
> +    if (IS_ENABLED(CONFIG_USER_ONLY)) {

Excellent use of IS_ENABLED()!

> +        return;
> +    }
>       QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
>       tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
>                       offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
> @@ -210,6 +213,10 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       /*
>        * Manage can_do_io for the translation block: set to false before
>        * the first insn and set to true before the last insn.
> +     *
> +     * Nothing reads can_do_io in user-only builds.  There is no MMIO
> +     * there, and every reader (cputlb.c, watchpoint.c, icount) is in
> +     * system_ss, so skip the two stores per TB entirely.
>        */
>       if (db->num_insns == 1) {
>           tcg_debug_assert(first_insn_start == db->insn_start);

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


