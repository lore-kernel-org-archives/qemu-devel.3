Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Myuuy31Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j0rjvnRw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZ4r-0000Ia-Vb; Wed, 21 Oct 2026 12:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ4X-0000AH-Hy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:21:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ4T-000598-Fh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:21:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFoAZV524161
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kuGH4Mj1zCNoqyNlDPCsqdaJjEA6kVdxAiEvquw7MxM=; b=Myuuy31Q8gyQtoiV
 uoN9afzxVTUCErOybEOPkUhXjUq9Vnj7nM7RbeQy87MJCDjb5ty2xG2A4XVY9ZBk
 8w/aVMmbNf8dr2D85SQnGry8TU51lcW1XeK07W/8n/GQeFA+PrROQ2jsEdZg6WO7
 fmT38eePavNaW5Imvty2Dzkq46sVtg1KALpkxD6o0fFad9PRFhA0wU4HsLYaThKm
 peYlGJjkYYqRZenQEcKAk1yB5ezwYW6/UAhj+iXMaa7nLobfnC57pbv44pEX3POK
 HUHLuYembhbxjk8Q/aBu7Ahq9hrbB6nITEe0Pi1aYsmxFdPcfWkm41HwpBtCYYE2
 Mh1VdQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv04md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:21:43 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1954379c88.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599703; x=1793204503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuGH4Mj1zCNoqyNlDPCsqdaJjEA6kVdxAiEvquw7MxM=;
 b=j0rjvnRwBk6/FUBon6h/Wsab0tJQzXgFQGkQAtT+g+zyoD6rt+MxvLP4tEm92ElFg3
 d/fF9gkj6Zavtn7drC5rrDOPktzAHQGlduwebd7IgKwqdgT3EPUR6hI3f3LZAQPBneg9
 gqHhiLTn2yaVqcR8wtUhJiPS5HQOA6jsMd0bNgc9UPb0LX0CtjhALC+TzUpEimp2lsfF
 jXxH8Odr6y3U6AwrDpRjQ98dJ85/R2T1HoRoeQ5J17GYv+1+ixzDYp88Wc7awF0x2mZJ
 MF+3CZQer9j11l53ES+4+JUoqEaCXckfvPdLNsiRG3jCqQ3RehJpVEOXfwozHX11Ahgj
 rUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599703; x=1793204503;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kuGH4Mj1zCNoqyNlDPCsqdaJjEA6kVdxAiEvquw7MxM=;
 b=bIzCCgiMCTAw1Es883/0uRolUrGkZ2ROq7Mzgtfq0IBAhpyH6lSfLPS1sxOE7f7/eE
 Li1w7Zga0lo4v6A+oiaoRdjaBExuDEzD9P4UVeVIny4jKi+w1tu+nKdx/IWsmXZG9Ik8
 tdKVWhdmAFYB48F9QzR6lwDQijo6NVWW4s4QONq9FaxjhHAphgpTyF2ui8AqOPnhzc1y
 bOH9jgNr7CbkFn3ZKr74ysnV54Op2pSVKIpP10MMotzwJouH4siQEopvThQQ7q+I9DXI
 fRAxmQIgy9RQiW8ROgjJjrt1Ds86qTNcnFYn8IDvoT7puG/y3mtDkbJUFR+lk0LreRAQ
 5T9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByez08qVYMVrbm95hXQQdeQUvCkhlgIPRKbucmjEQPG4VcQrsIgneUHB4DjlLgL7SSi53B6CbzZKNOk@nongnu.org
X-Gm-Message-State: AFq9FYKHZiVkQxms9wtZ/fyAdxeyoYuMxXs99WfDovPIRSpWhntX1ZS2
 3XiflrnZXuzPji4kUxtYrHW1mbFuG6jXGz9CCQkpWhVO8JBEl/iZaI9y8468VrbgPoE9cbf6Ki6
 XRCjbvkVprz8pc6Z8K50eQhvrpMbPJGUT5af2rL9QVbxIEZN8+gUlGGA/bQ==
X-Gm-Gg: AYBFou05DHu97Ocl3NXyOAkyWYQr0lrt5+BL/GIgqoz6bTSFvdbV6dkbmZCRC4opzH5
 nGcl4PDL4pJ0Vwl/si2Ymq9jJUaeFJ4abMPshbUhlCiadia2g8LBBpkYGCBkaLq1BbyhK9pvwk4
 tp5p5+x7YFDbFFleGNLJSu1ySCNfpQWOyibzdwSTKM5knQ6Q1VpAWuo4gTeRi2q50OUyXNrRJ++
 0TSygN9JDMF9M8mYKcY4YQNSEeYl+zye41FGhgVdalBBzMoa7vd7wR5ecAVjBUoJlrClp+a7NJr
 dc7RmK/LBQGHk+QDaAQm3w3SbtuhxJnQorPD0UEQdvngX6LKoBhAvPnPpyHyB45+XbB/BzXidsx
 nYUF8X5kaFAbc54IAo2EkXaQ7MlNqhRIIX7gKCwx6l/7M2w98BgVwnXKb87DMvnwgQb4C1A==
X-Received: by 2002:a05:7022:ea8c:b0:18d:ac5a:89ef with SMTP id
 a92af1059eb24-19140a1df01mr2133469c88.31.1792599702950; 
 Wed, 21 Oct 2026 09:21:42 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8c:b0:18d:ac5a:89ef with SMTP id
 a92af1059eb24-19140a1df01mr2133110c88.31.1792599694879; 
 Wed, 21 Oct 2026 09:21:34 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bd6b7ccsm6747992c88.13.2026.10.21.09.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:21:33 -0700 (PDT)
Message-ID: <b19a1fe8-a7a1-4089-9b25-9e4874d2a89e@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:21:32 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] target/sh4: Use a static table in
 sh4_exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
 <20261021031407.24862-30-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031407.24862-30-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8e697 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wQEKYDyfpQnk0JwDFccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: PkxlgZlD_u1XrcpzuZqbTeGII-pxN7bs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX+MX/fXrQP0sG
 1ehZQdZq/FoyfB5zlZOFoj6992hqklX8GD84/mrCOui1HhIb6gVAqxDf8uWrtVHrs2syfbe3KN/
 W9r6Efo9eTmDAT/7w+A06W5aod6Zra8=
X-Proofpoint-GUID: PkxlgZlD_u1XrcpzuZqbTeGII-pxN7bs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX0nPMrfxA7+3o
 A7e8axpecL2Nd34KrMo/rw0DH2aln22bzIcgjgvH0bFcVt7CHT4EufkG2w8xSLxc1cHWBdsv+tf
 CwSefqE/rMsoDuqiB+ST+zPwkPnnjQJkYyAGd4SUHLfWUz2Fl6D10yug6lxpGGmk/VONRHRfqVh
 D0mmbfIHMsw/I1w3kGRevfR2udeEFqmsXNxEFkBkosYyPGsC9Ql/VwHxctxoYcdGCpVodXfdB7M
 u1BaWRbweKI6hXeZNRaRt9fQrHOK1uhQOYzoPZWE0dRoKLiPUL+ALYrAQHabCcW7/myIe/sHZi6
 HvTk1hk6fn4ugzfcl8MAZcQ7P+XYclwgx2ddmGMxN5nbo7XeGKZKJWck09dHatTs6O/t0f2bIcX
 eP5ncQUu9SVk8TcG30ld6UZ2xSrD+BdwrZ9FlcyMvUZnseV9734kRAvvgJ3ylTufIMbkG8Ofvpw
 /X5BAJDu1CnJwgaK1uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:14 PM, Philippe Mathieu-Daudé wrote:
> Replace the switch statement with a static lookup table.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/sh4/helper.c | 65 +++++++++++++--------------------------------
>  1 file changed, 19 insertions(+), 46 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

