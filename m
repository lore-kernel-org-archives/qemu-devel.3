Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FC7CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB82K-0007Ia-0k; Mon, 28 Sep 2026 05:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB82I-0007IR-1M
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:52:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB82G-00086I-Dc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:52:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M8t02057267
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HvNP/BAI0o9lknC2+cucXpbe5AwnBLZsgbDgZa7YMos=; b=iwM5okfe/b1Zlcq4
 DSfmGwP8ym8JRgRllu3v30daDAZxnxQ/XDUfeUH/8SRwOlB5wcJXK0myrzwpbyzJ
 FcnaY6qxSUcFbOEoaQL6ctutgnVArtu42Mo3ldyvVeiZkVM0XZ2qvqiom5Rr6GIV
 /XrKxvwbxPgM/wckFkgygsyBaAdagpf/DbOeCGO0YBKYyCQJhnkFpbpL7c2OdKbY
 TygX6qv7+qxq8XauSBwuMD2BrHzI6El4OS58rGwO/8Y4OKm+FI0fiMBXd1cV0yvj
 qpcb7+S8e5AAB2Qn1s3mTkV2hvkcIPZSi5CcgUd4fR1UDLsFcd9sTu5twmtDTp0d
 DdIamw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubh08q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:52:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91578e96164so16523156d6.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589153; x=1791193953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HvNP/BAI0o9lknC2+cucXpbe5AwnBLZsgbDgZa7YMos=;
 b=BVkyvdIsAEkF59+63y5OunYDU9u1JMIhrcOk3OcSm4aCNTsVTbjuuYow41wVoZQA24
 hQKi9U8N6gYHLyEJG3XH2s8Ovi85XYptq9cfEHNnNuU4l5l51G7riKkz/ntdtyy9LC4I
 KULT5cyeqWtvlRcizNJY9fyFAQSrY/hrGChnXHqrEi3VpISJ6v/QXtQmySpEwmOGvvrE
 4K2M2d1jvbhHl53ZKv5QxC+45bixmdptaYvzZnEEroGH0VSV8rN36u6Y7e35ewbu1mTb
 4R4mV/Er0UdMbMk1mgJylg9nQhtYEHytPjxE1aGF9V0zemhHlV1ZY7TWx2i/VFG51J7n
 0pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589153; x=1791193953;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HvNP/BAI0o9lknC2+cucXpbe5AwnBLZsgbDgZa7YMos=;
 b=OyDumSKytPXknPCVWpziapcmGWoQuIzNdHV9aIyR5s3r2z/EJh8Qxv/yADmLMdAwBo
 hikE6VADLIhzd/YTftVT9TIxzSX49BVobE6kN/Nz2Z3zFOO2ns+kmBg/LLnVzQrSNLSn
 LeTec3x92jqMnMdfgLeVJ4Dh/w7Dnwn0z5z+yxdGXHyUYTT7z1wox1ohO/IYvEsSJ1q1
 8gQhLCurB0kDmMR5jXWAILmykp7YffKdthXeCtPgX/9JiEPy8g0YrfQMeoCCfDyLoO7S
 kbr5z6peLda1O5DCxcSj1saXHKuJjQDL7yW9iOL0yUqpmUjSODbkwj41REf5/3MTcj+R
 UEFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpb1s8e0JVsLxUCIG5rfLbZ7QzZHnuOJ6SfT0DaStyj3DYWaDDhS1gkBz4RNwdj+d8WhFKnpHrPS/p@nongnu.org
X-Gm-Message-State: AFuF++mjTMsqOWKf+nbfEu+Dh4C5gnSRMfHzCHg4rIpdeV25iMXrhli7
 kmer8Yp6jTySVxld5wGsGSFlE01Hl8s6zc6V85WDHKxZ/43XGBCqIlzg3RG0LOibu9B77z3JWVs
 A4QdP878vMevHrvwkKFHBecSZIsSETVlesCxpphwI1pt5Vf6agTF1VN3wqw==
X-Gm-Gg: AYBFou1T8asZByGXqmb+vH9JkNdktQwd1OEr3mm3AbovkC27dYlKmp9a38BX9jvqVPU
 NbAXIBxhqnSLQnF4xo+U5wCw8LvlImTr65e4a65BkfdIHwjFw0vF6MSEkl+PyslQS6XlZXyAdvy
 dAoXjni3CXWYQKpgOOpKwul42PiR1CjG7zJEIpmaDWlTIEHBbhdA86M6dRDc6BJISWoMXxKymak
 eE5YIVKNugMyA5HA5RWv7m+fuxIMp31/UdyagpCuYPNDBEGM95GvyfO8yq4t7wW9XHnj3j/Hq3Y
 nkceyxxz5syEDR/Eu0XEIDxetW/2LeRBc0xe/W47L43nxve29Ce7kht4KKPPct/+g9dNnAk9n9i
 O+KwqzgBwxQnYG9KrhZcZnImRzMj+Xw1RNg==
X-Received: by 2002:a05:620a:6409:b0:93c:6450:9cec with SMTP id
 af79cd13be357-93c6450c36bmr951320385a.5.1790589153481; 
 Mon, 28 Sep 2026 02:52:33 -0700 (PDT)
X-Received: by 2002:a05:620a:6409:b0:93c:6450:9cec with SMTP id
 af79cd13be357-93c6450c36bmr951317985a.5.1790589153008; 
 Mon, 28 Sep 2026 02:52:33 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a007fd1a01sm25918105e9.0.2026.09.28.02.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:52:32 -0700 (PDT)
Message-ID: <9732ca6f-d103-4993-a8b9-5eb820d79134@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 042/101] tcg: Generic expansion of tcg_gen_orc_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-43-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WxVzGpPsLvxCu4urgq-Iya7Q146kaZLD
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba38e2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WxVzGpPsLvxCu4urgq-Iya7Q146kaZLD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXxjmuYkaAsEgC
 1QGQqIF4sCXo9pN+m2OQ2voJtxgRV7/P0s+UJLjfEztGGcTBvDyl65utaQhiGAII9FedqHH/SbI
 d99Sl1iZo70B+mysiDJ4m7I20MuJfznl3UV0sn90KyfJjdHMWeoCWiai98uj6GtEQZlk4wjPRMs
 jKlJtQCQmGvCgb1ittFlIRnCQn3mplVc4Ed+5NuRJXl2gYcDUtTerypb7rbLYFyw3UwF5KSsQwc
 FzHS2Am0EmAzjPx0RIgtkV78GncJ00KCpDIbpENZD8KtoijgNTfDQ9W+32FPmWLG1XMK9cKRe8i
 CDM6eKsbSdnpzhY+BRvownf+jp/5J2ncGdmdkUtSu0uAmwlqx2+CZ1U2Q3148Q6w+V7y3NcW3Hs
 zgbiQ8E9RT5JMRA4TnvEVJn8U2UwVIxZ7zrDMPL8IR3JDB4jy61pNgzpqUOR23c/px/Jdu2q58b
 Y81WItQLZ5s8n9NNCig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX1IFSI1huEj7f
 bnlclTs5QBUgjFYhgyc7yVfixfQqm079v6UtAN5f4GTX1x2hE6DiMz3dQ6oSZOYKZeIramsGZHF
 3pI1jO1JhJRsEBnxcweHwGo1qvrxzPc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 36 ++++++++++++------------------------
>   3 files changed, 13 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

