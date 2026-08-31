Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D6C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0tus-0001J2-VL; Mon, 31 Aug 2026 00:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tus-0001IS-11
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:46:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tuq-0005NB-JK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:46:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bW6O3239035
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2JWs7eXXB+S0qBXh+Csr6Kw/aA5hB9YEopjzIkkMzAA=; b=nrDmnOZI7HkFsp7D
 eYFX+iEZWANF5eHXjNLeK/fmeF06686iQDRw3+GenA0rrnkiinoiVKCTvz0gywfi
 gdLMyVm7tT6OxY5oPMiOM4l8oD2lavLauy5pEziR0Q4MyJIHEZzFLOWtk2ZKht7/
 eooYGxPfDpnsS7G8t5ML7VSKHmdalNdWLKhUxwDukztwCQ9zglm9ER4AXhg4cyNe
 fnYpy/3m+z/skKZliau9t8qqpGt7qV3jvfUyda1syG5r0uhGSRrNeqMGIE2PEjVF
 ceDGwZzhFQp/grgFGbUy9TOcu42GoIbBUUK+RFa0oXk2n8mQureFmT6S3vuwvMMc
 cFomBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h0uup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:46:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so519691985a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788151598; x=1788756398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2JWs7eXXB+S0qBXh+Csr6Kw/aA5hB9YEopjzIkkMzAA=;
 b=ZzmJibLl+1K01AooGE5y+GEPu/JSXX7Tq+sf3PRygQCh5Qbta9uFal3ww9ltD4Kz0G
 BO71mvpvVWAIXA9+XJlkeoCIuKoVNdHXVOankRV5AJlqAWPBqRLzVvRcAgf9mptzqMiV
 Lw/ppF1mmM1uBa/M7FLC5wWkVRHlUCZPNWYbpyvepQYu6+fF8lw3YZ4Xf1SeMoqr3Fv4
 6dwiKElnlmASjJVzlkzy83Gz3/j9cASr6mtFUVJDdmEw65HrI5ui1jy6De3geB6d8QKK
 6sykmTRuKs3yAuwsEh698OVWU77oDzcXQdusOtMxj9XoI4uhTzPAiCyl4cRLueI43vgr
 SvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151598; x=1788756398;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2JWs7eXXB+S0qBXh+Csr6Kw/aA5hB9YEopjzIkkMzAA=;
 b=UjtB8dLjon9acGwNDqNmekEr7U3FTvf/s9Chl5Pn1sK4WmSmKxX7eQ2K0iXJzTL1Sq
 aSLWKuXju6Dwf9A3qvlPEQt4KUtEhEyvCccTaXzr0RxFDL+vqDpNPwwgEtDACnWuo2Dq
 OzJeL/lP2YQ5hJMtpfMuFQxSSJzQldXqL4fKQzv2hfqB+Op6N9HPL4fMHNSlgZrLmEkC
 x3WobekdauW4AcSLHord06mAPo/+Gdvh6ZSyTryzwgBl6rYOEt+obhXB6aftYKB+ENQJ
 tOA5XG95aWJAySTOlFSYeYb67C8uBL3bBRlFfsjWrKxywVfp2xReUwCuDCVYUaOxsnww
 ddWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWDkChiXmBBgE7HRZ4oIQJ8i0lOcTHaiMr3/eD1Sr4B+4ss95YRLzv27q6K8ngg5bPvGEnEVvxgkNg@nongnu.org
X-Gm-Message-State: AFuF++kaoQQ0E80TpoyCQNyt7AF0cVZma+m+F579EAZDlf1iMGgasW30
 uABIryMyy2emaGthNBsCHQsz9fX+05xAmoXxe5QH+jFbmepkID9di+H4mij3ccxk+v3jdFlLOgJ
 tgRpUbMUXhy5xlrJEFBu9uLKCpVLI1uXpezugOEJIHCOrbdNAeBk7t1pK1A==
X-Gm-Gg: AR+sD10axLsNhoOeqgLumxZ/RggEWVvCVG+p2XyXu1joqVcfE6AocA2C8Kb9X5FJP7f
 u3y2UqW/41w9aGvyg+7PrU+3MJaXa7IMrA0//yjO8cCo+TrtoPWTEoXsNh72hnKXZg8/3iAuKhg
 g1ERF+JRDVAWBF6dOACJ2lJBEcPGhQx4oikQsXYGnF6ciUL+BJAy7ySVuK2UeXgmtYTHCVzNfvY
 KyhQfND++AE2nD67ZpEbL06I3PxPTW5RQ/5EIpCYg+07LGnX+JoK1LUIHrznlrdFAssF9TXeDtl
 EU37ecv2bEVzuR9jC7XrQ9dV5xnuQYBmd1IGCF/vQE0ndwft6e6creQHTaX/lOBT5VmB0Kat7wy
 nVDgjilSZVNgBKC0F5iHrxPJt4R5hnjgi/A==
X-Received: by 2002:a05:620a:1b9a:b0:939:cb6:997c with SMTP id
 af79cd13be357-93936cbe951mr635441385a.13.1788151598158; 
 Sun, 30 Aug 2026 21:46:38 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9a:b0:939:cb6:997c with SMTP id
 af79cd13be357-93936cbe951mr635439085a.13.1788151597709; 
 Sun, 30 Aug 2026 21:46:37 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c9cf95sm197929145e9.1.2026.08.30.21.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:46:36 -0700 (PDT)
Message-ID: <52e8fa32-37e6-4ca2-a899-401692c540ec@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] target/arm: Drop U from most PSTATE bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828222639.1432046-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a95072f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nFFuDmGFbkSusJ7HeisA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAzOSBTYWx0ZWRfX/5Kwo5hp2+IO
 EMXCKzcnlrcwJW1pz84a6FefnST6eow2KTvmZzUDVUasuZ86qmbiu2hgCj4TJ/Ur7TfNb6U1FU/
 irLt0NUBPO5BTCl5EKiHZdbke34mAyP5XKqzOqEWBYoxhKwEtMCVFaSCnHH+bhi0j43bElz+9Re
 Z3e6VtKZVj1TIpabFTEQQQR5yxHIdXucVdG2mzOzxvTU8f09tzMqPOdJd87319b4LfwUj4UsH4G
 o9bqjgbB84ME5asWRB07IstzxGbUBduCj8LzdQbQ/joWlOahqM8cXrLZy8i98pl6lnlhCvZgVjc
 ulLB/4empMylWiG5dvLuLpj0S00NPnPyAJxtfPTIdrHIMerU+3AHs5ou2qLDwB88mWO2gUS/rE4
 a52v5FksKBKCyqMt+8eiJFMR+DOrmwqNBpNSZH3W8fKrzOXNhpz/5EAYpuI9UFd4zCD3VULuRv8
 ZRNIMp4QBMT0Moqrz5g==
X-Proofpoint-ORIG-GUID: V0W_dUWBK0XkL2XfNU0l6foahJmvfyTz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAzOSBTYWx0ZWRfX40f+T/0waPwQ
 ZDSru7bfEEHMIk+cprFurLamzmu54NXS6GtDQQfDLSfirXp3vhllbNs/iJH0CwzhKQDlJufOBhF
 gEtVifKJ725BsaQdfPzcXypnz0nfLHc=
X-Proofpoint-GUID: V0W_dUWBK0XkL2XfNU0l6foahJmvfyTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/8/26 00:26, Richard Henderson wrote:
> PSTATE is already 64-bit, but many bits are defined
> such that ~PSTATE_FOO accidentally clears the high bits.
> 
> Except for PSTATE_N, we can just drop the qualifier.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

