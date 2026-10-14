Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8187FCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6H5-0000WY-Gg; Wed, 14 Oct 2026 17:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6H3-0000WI-9N
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:12:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6H1-0001HM-6g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:12:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJ3P3642817
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IuYRZyVzjSNM01rec+dL+iexqyE7MU10L1fGlngITdA=; b=OP7RBr7iKK3LX5ov
 gsc+3zmQoHXcC2N5QXIqTVb6Q7CQsLgU9t02Xg3PcNnsSTh2wFcGF+PZHbqymPZX
 uDLZc46BaI59Edj7hiTdL/VWfct7Hx3m5qR2m7S1D/oFS2LKE3GazZOn/K/5PFSS
 tVODDgMcqe/r5wG8O8IqYT/3fNxzn7qHgiE20B4ym6U6vg6Rsow4bA63wnjP8qWq
 5lMa1WAfs6ypnF2ZYY9B+WkdsFvbZ/T7PFLpya6gxHQhVjnY4gm+TLXEvrLQD6/k
 Ua3azu3vB3esZlXYEhW57wVfRm+KV5e8bF5Zr6OVT/nY6K+JflR8cGBVjmwMOf6u
 qPyymw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470bgxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:12:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso2610745c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792012348; x=1792617148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IuYRZyVzjSNM01rec+dL+iexqyE7MU10L1fGlngITdA=;
 b=DQQcbmAawMZayLLTiTwMoH73zmQbQfnmx1Z70VcHL/2u4akw3wJfutQ9NmPpp1ncn/
 Tw2lKh3bhmkI0Om2geJm+u8jtbB1FJ69KA2HWKjQXTmPFEX64EP6F10upytSLw0FOYRe
 LntPJw/8KyRUX6WrhkZ4wjnsY6fTr3dByjfWAI9Mwdr4pX1vKI24BSNSQSgPiMMoQ1Zk
 T/qj03w2DunbDd22dvfDbTzE8i9FoUEGESTVmE0jN8DydsV4KYaFIDqakADE5MdLgCz/
 c8+jwh/sphC4S3L8CsvpEs66Ejbj5yOxj1nOWN43B7UM6T0AN7GyNfHO8jPBj/x15oL8
 rh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792012348; x=1792617148;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IuYRZyVzjSNM01rec+dL+iexqyE7MU10L1fGlngITdA=;
 b=hRa3IhSKYKUPhggW4EwPVSXL5FAg8imo7qpiVO7J515nRnQzgvolXkc/GCj0CX6/AU
 hxWlNKrpk4vuN8Roz0xgxTWaQmlI+k6LHLNvPlxnKwoWI6lTEbziYb9h1nVlTMpSj/BJ
 VyfqViPvYp5SCs2SmRXaBdb3KM3C1/rp6XMCO8dhWpZX21nKsNVdRtlCSAEKoogXfp6U
 nccFr+LK8/uQ2+C49uLv4+bkgCtLHEhQFOgfbjf62ePXUsctSvk0MucXgeyA/sUdePJp
 rLMe/kO/mtX2QP+7nxjSeYPnrTkrEStOPkVolNK8Fue2hovqpppEO/7edHKYfijQH0Gu
 cxnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8A1D1oqlKN82IF757hm0forFPYEotfT9fQKnC07gykdaD+kkVPwb9m+feYTmrKYPKfYJJWbz/9xUc@nongnu.org
X-Gm-Message-State: AFq9FYIteQtj9s723dnYv8FS4oQzdXQh+/yzdcQkqCU9FZTfg6dUiIyF
 mEOzuNnvu9NUsIfI7vrX0hCpVJF/uxwe1yfyURKV1lVWLpcG3LAXWqxd2/oUJv4Sj0FBoeTs+8B
 JaqLx4prDtdkDWtYbm72kwQ/bjTMeTmYMnrQNICZxTuOQY9jpeLNpOcF6RA==
X-Gm-Gg: AYBFou26wMII49AOI7XLDaHKuIygB8e3Q7rZpcrXavSBdBUNwukvu7c8ZmY1duJiNYl
 KqD+spMYWjnK/ay1C/addWD36fFnxwAG3f1uMfec0iVW+IvpKcsySzkEtu3OPeL8gZWpKtxydJq
 1G0+oGQC/x2nuF0E3FTYhxSKvTKZXAZaxTSnUof+dxDlpm6TTlLVZ/5apt4woJQNPIV+RFvU0zt
 UotxiA9wYECr8bHWxZQaG47Y90WUkteZQ9s+g+2Wl2nhshSvxQJFJH6NDgQGv5zuXMmqXxqCP3t
 zVCf+CMXD97LVgs3ptQcKqXBVpNYhu+LdzPprFL42MzPXZc257WYUI+8jD09TCZYumtvDWpnG56
 5r8joFMP84EoSvSxLHFODxePUP/Wv02Z3i9YoF5je0Q0Wy+q67aS8gvNDYqcddqYXsrPH7A==
X-Received: by 2002:a05:701b:2412:b0:137:fa50:a242 with SMTP id
 a92af1059eb24-16a586a3183mr21685039c88.1.1792012348287; 
 Wed, 14 Oct 2026 14:12:28 -0700 (PDT)
X-Received: by 2002:a05:701b:2412:b0:137:fa50:a242 with SMTP id
 a92af1059eb24-16a586a3183mr21685001c88.1.1792012347491; 
 Wed, 14 Oct 2026 14:12:27 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm49163309c88.22.2026.10.14.14.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 14:12:26 -0700 (PDT)
Message-ID: <1941647c-b010-45ea-9a0a-c39d8386f317@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:12:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target/hexagon: implement control flow integrity
 (CFI)
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-11-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX5C2xy6XInBWC
 w2Ohq2z1aFjXqhzhM3MrUScTPLRzW0StyxT7xqXk72g75pJwLj2A7nSBoqKM0873IByFUYSdAKT
 6bmjqKaOZlz6pAoWPCwRzUs0T+pBFX4K5ToqSq3hAJgY6EIFN+ouGtgsE5w+c2RjdbD8P42J1dm
 ej8igTqW5+tPFDfe9qp9xX3wXLpOELxo38/w/ncpt9R5Xo0ava703VACyOHPu0p3DVh+m7R3vcO
 bJtjLFO3dZdPLoO44FlUnDa7v/my/PCl4OAuFyB/vrEAdn0RPFWcP3tPtBykcJDkPlil8agkJgt
 8H6JOiMVwIhvHL0cTUWUYNXCxB/22N1gp3688wpEr5mdl5tBm6HyrSBU+0UFQC2PANdkr2oi4w3
 CeUcDUAC7yr7FzYk7GEKFytMzfsl49XdCJEZuMA7eCZahMrIqw/jqew/Q+6dQmlFxt9sclNrfXF
 /DKmK0XgnpGlf9ceo1A==
X-Proofpoint-GUID: _GZJDD_2rdFUJBQMyWJB0XHi8GjqSlky
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acff03d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=bhEnQWORFkTRnflejR4A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: _GZJDD_2rdFUJBQMyWJB0XHi8GjqSlky
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX24vzlHFzeK3/
 WlMNJU6/dZWROUClWDDifhVvA210GB6SaYIef4VDAIjFyVM4/0cGd6DJw5vLFMJzyLLxb3ZMS3Q
 Bb7YZLU56HbyXZAtbHMjRQV2idatkrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140084
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Implement v83 restricted indirect-control-flow instructions and validate
> their targets.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h                       |  3 ++
>  target/hexagon/cpu_bits.h                  |  1 +
>  target/hexagon/gen_tcg.h                   | 56 +++++++++++++++++++++-
>  target/hexagon/gen_tcg_sys.h               |  6 +++
>  target/hexagon/macros.h                    | 12 +++++
>  target/hexagon/translate.h                 |  3 ++
>  target/hexagon/attribs_def.h.inc           |  1 +
>  target/hexagon/reg_fields_def.h.inc        |  1 +
>  linux-user/hexagon/cpu_loop.c              |  6 +++
>  target/hexagon/cpu.c                       |  6 +++
>  target/hexagon/genptr.c                    | 36 ++++++++++++++
>  target/hexagon/hex_interrupts.c            |  3 ++
>  target/hexagon/hexswi.c                    | 11 +++++
>  target/hexagon/machine.c                   |  3 +-
>  target/hexagon/translate.c                 | 51 ++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc          | 20 ++++++++
>  target/hexagon/imported/alu.idef           |  3 ++
>  target/hexagon/imported/branch.idef        | 38 +++++++++++++++
>  target/hexagon/imported/encode_pp.def      | 18 ++++++-
>  target/hexagon/imported/encode_subinsn.def |  1 +
>  target/hexagon/imported/subinsns.idef      |  2 +
>  target/hexagon/imported/system.idef        |  2 +-
>  22 files changed, 279 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

