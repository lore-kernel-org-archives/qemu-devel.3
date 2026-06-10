Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD96DCD8C90
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXAZb-0002S2-Kv; Wed, 10 Jun 2026 00:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXAZV-0002OU-WB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 00:29:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXAZU-000205-1j
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 00:29:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A45Dqc387410
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EciRQ08qHOwo1uINI2FcN/QQ7G9ZIg+h2VpqMuPVrLs=; b=XkzKK19l7Cs/WED9
 1kyxcb1KbGxk1uDwoifgPW344LZNBjvd7AkSpI4Yb2y05jfLF+cyMg+OshLZ1tSB
 rFmyX9tw1aeotbgoTjnWEC6s3jPerYK4fJRpsEkFOECH1u69ydx0tPr2PNfjcKsU
 50oUid8DOnJOVEy9q7WqMdBxVhwNnPdK6seT4yE6zf25cErsHkE9kWAMyLjMv6Aq
 r5C2gLeRpQpvskzQCtpUudPkCIQSoOv07KJDpMFQJ8BKHgaTTHORPflnFQSnlcD8
 CFcRErFGK9KnSB49QC4Rohok3oEdnAXj3vtjvd8RCp6zmhGxMeED4OJsqfj8vEC9
 8s5xFQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd820s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:29:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so6883872eec.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781065780; x=1781670580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EciRQ08qHOwo1uINI2FcN/QQ7G9ZIg+h2VpqMuPVrLs=;
 b=U47xy0Ng4HvfzEoPowO99PcSqd5cEAblMYu5CJdkWkUWI+TcP8xLP3J6RP3npTZ2CV
 oYoZbqtrFZabeEFp1w4K9l/hv50awh0Y7xl/GMn6tckJi7ol1+oPFLUsXHmX5SKwSNKS
 pwqW7wjbvW7v1ofOg+KZyMRQ/eepLY++1ibsSYoXo8wko5PFXe1MATVyb7lpECn9007t
 ZbGWeT/oSenajUHi+i6Jm0ORzt0PVw1Th7Nf2I5tBP6DLN4/tZILHbud6twQ4QbwtsCX
 xVOOoiXE1hHGyoUunK/iEDoMKd67/ttmxwgUlPTihwVhIZIIxvLNNTWYXGb/uA5u31Em
 rIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781065780; x=1781670580;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EciRQ08qHOwo1uINI2FcN/QQ7G9ZIg+h2VpqMuPVrLs=;
 b=dLPfB7g9s+T2d3Goagy3+7eFYlcqECOoxOuVlzHvIMLvuhW7LMX4bem6uH3Vs6ZRzX
 mhpJJ4Zrq5sJXo5etf36l5tjDnvlTy8mN/Sx/WwHvKXsJlnSjZATL3SJfvGNMF13zqpg
 mblZmcprQC2rdJlYWOsemlwfSHvqNHh7sEZeHCtgTt6XQxD1zW3c7d+6znaIr01FJxFu
 7RcMJRy2yu9l2ViPqRL0H4MWtFE6VNPtoJ8oDbm2MW9xzlc1vRr6rm+SR/zervzDJxWO
 UJ6go93J7jIsNrMT6W8pIr2JgMh+FJUOjFmabLRDEpNMyHFDDKr609TDE8OPVn6fPwLR
 y81A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ag6xYEMlHJMYWZVVagKRhr8oRegAJx6s/t6TT+N3q00ZZGjAbzBU7dDjBkbbf+2VEr1T11tHj7fnZ@nongnu.org
X-Gm-Message-State: AOJu0YyokWB0mXeCiNXuvjRo1fIZhINeg00uwfEqKaw087vzmC22QIIX
 btjbBNYhpdMuSUx4NAAsH023QcgfipvFABgdViaqFtsFs2rt5MYuentUMl7edraBRhr4Dj48FCf
 ffzlEdZxPWjJ9a3zB/W3bKA24vOTE2eGFi0Sy6ewSAEXA40YPAWrxgn+SIQ==
X-Gm-Gg: Acq92OGdXHUuGy4LWN3TzMjcEFgmlCgk3BN/FGBnQsCNI4iia/D/4o4GcXwu2Ths892
 uxRp6YYCoRUYRgWG6FmTCdAHUcDiHkV2mh/UIRDjxynbvJKxTHh2K7hfJQeeovtBBRcPKff2woc
 9Uyj3XN6YPOyPY2qz91MEA4mMFCi6jCo55xjnsdjpO6nb5NdNeQrc2ARbxiu1x0V1hLSFe17mP0
 fmd4YCA1Q1jJF7v7WU8kFiTaLj5zTecL3xkAQ9M+9ShA5dftjlUctYhKl++PZTODCKJNhRpp1MN
 CMEnhZZDdwIIBQvwr5V8MQ+fwRYXGt2c1fKZRRKsS6MBBHXpQn47cLieBFNdb2zlNeSflWealcZ
 Il7COJI3i2aqS18XiEug/xtZ/+r6wX++H4T3q4gQeWILDK95YBMcrHfs9ZxGkJzV9QRzrJl2Uvo
 kRe+2tTWh60AscXebREsAjqCjm
X-Received: by 2002:a05:693c:2288:b0:304:8881:b82 with SMTP id
 5a478bee46e88-3077af0de10mr13940230eec.1.1781065780374; 
 Tue, 09 Jun 2026 21:29:40 -0700 (PDT)
X-Received: by 2002:a05:693c:2288:b0:304:8881:b82 with SMTP id
 5a478bee46e88-3077af0de10mr13940198eec.1.1781065779794; 
 Tue, 09 Jun 2026 21:29:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db5610esm24075334eec.4.2026.06.09.21.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 21:29:39 -0700 (PDT)
Message-ID: <35d9eec8-3629-4039-9120-1a5ae3b6c161@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 21:29:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] tests/tcg/aarch64: add user tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-22-pierrick.bouvier@oss.qualcomm.com>
 <3d519b95-595a-4a5e-97cb-6116eb577e09@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3d519b95-595a-4a5e-97cb-6116eb577e09@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a28e835 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=knnLeVzCTpc433lMfA4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: qV0EXnpYD8prm9XXS3iN66vitUTd17uS
X-Proofpoint-ORIG-GUID: qV0EXnpYD8prm9XXS3iN66vitUTd17uS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzOCBTYWx0ZWRfX6uJzRZqHFMtk
 KKtFtfKAi8f1yxTVd9H9p7ABynIL9ulDGfg05YzbBjrbUPQ2eYpqLYG4qCgVHpb/9kkiHCoiKsr
 O4rFMrKzPYTllGBT+GFvm1krLZUUTUXT81pJ8iFO+P0SaMeqDCUn46A9FYf8QUb9Qef2qL8fY0D
 ckLC9IlnrZGjPQX0RdSfvueRCSyWK8D/tBMBvetkkoawuLgo0UpwEfxVSog/tN3XwXqFCKtcSCf
 RdsIIzW3N1OAbivOY1WDXkpgr/juLR0YuhjRc3YSF/K8d5p1lqymSa0LCUfPLP+KqMJhAyk9tgu
 0ZGmx3iFZG+cFAonrX4sMLDJOkzABl49oswfYSL2DZFxcn8z9D8rTCZqV2N0wY2EGKbLd6HZ7Wk
 biWrDUoKQ0agGqjYwaGFQXdbVGBXmtP9+qtRyab+5UhDvOHGbbkP1alxh8QxO2u+U6AK9U7xVHd
 pujwNzdhn1Bp4SFlnyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 6/9/2026 5:18 PM, Richard Henderson wrote:
> On 6/9/26 14:47, Pierrick Bouvier wrote:
>> +++ b/tests/tcg/aarch64/meson.build
>> @@ -0,0 +1,213 @@
>> +cc = find_program('aarch64-linux-gnu-gcc', required : false)
>> +
>> +if not cc.found()
>> +  subdir_done()
>> +endif
> 
> The primary thing we lose here is the ability to use containers for the
> cross-compile.
>

It's definitely on the requirements list, but as listed in the cover
letter, out of the scope for current series.
> We detect cross-compilers in configure.  We currently write them to
> build/tests/tcg/${target}/config-target.mak.  It's not very meson to
> parse a file like that, but I imagine we could use scripts or meson
> variables somehow.
>

We can rewrite this mechanic in meson directly, similar to what we do
for gdb in this series. find_program from a list of known names, else
fallback to our cross containers which have a known and fixed setup.

The "build_container_and_run_compiler" logic will be in an external
script, appearing as a cross compiler itself, so meson role will be
limited to find a given program and test some flags.

> 
> r~


