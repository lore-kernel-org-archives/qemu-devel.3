Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF00606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TdycNRME;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BuSig1ga
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQJj-0004NN-0K; Wed, 21 Oct 2026 03:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQJh-0004N9-FQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:00:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQJf-0007Ey-CO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:00:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jOMS3573327
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tMKxmb2B3E5EgbZqD9sWWb/L+Er2ohElhiPA67GBClY=; b=TdycNRMEJlJJiVmx
 35RUXRDj7Kqfcy9heBS/nm+INtB4KyLUv/hyhEyqZrsB9mC8rDu8WhRQly3rtPs7
 ZbQ2/mQEcvc6/4XJnQAUjd3U4dt8A20AzNfW/orRzJlwtrVBrBzEpnkYQYjkFMaK
 tBIRw5wpnydq/lodrwxjueKMguAAYhPd+kcAaK7Vjxn0yM6K1Fv8GF4ZZKhcFM+X
 +owinnPwE+xPnU6X8sYPbdcdFOyGWpW5/fnLe4XHKH7AWzMLRlUT0S526O1gIJ7q
 b7RG5CFIKAk6I7YzxrvuG1q0PL1Gn2UBgY8v88oA7Tx2oxM2NnSYdG9qwc1HD59z
 KQ8e9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9htf40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:00:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2c0e6653so88359585a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792566048; x=1793170848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tMKxmb2B3E5EgbZqD9sWWb/L+Er2ohElhiPA67GBClY=;
 b=BuSig1gavCu/BBCLi3BAwv1qV1GeL5ZF9QI6ITzt/11srO3Ga5QhlHgcwoAIpTJlvQ
 p9Bc3zq16GmM4gdp8egA10iurLQaMnDw2jA7S6Aoj9iTOL1y0KeGVTksRZC5qkYq6ADD
 HOMjkVysnhM9oJm7OxhF7fhCCqokjO9PgPV1iXJ3Rgw8agqBIqBEBeapgoZ9Hp/0yDWm
 hvJnKQIX48qw3Ou44AvHzTFfm68XN+2CdKnn9ekqWCXqAFr5QbHPBQHCILBZAVs2HW5Y
 IvfG+M27823T7ytkLZifLjpCwfEbKQZMxNRyC7erelRlHeVwfDU22mPhGS4J78hTtVQl
 vYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792566048; x=1793170848;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tMKxmb2B3E5EgbZqD9sWWb/L+Er2ohElhiPA67GBClY=;
 b=dYW0LKF3bGwfS5lxqH63/IDgxPhOVSk8Xgve92+Ob8+bHy3sqLrhJQjjzZzglcnPyq
 tWsURl6UOOM06jCtKc4vILhuWzwcDZKUguQy94FZKFzTIJFsx0tbMwvHbUB3igjSCs1/
 nPNAl7ni4mi4OIuCVdefsLLTW4iPECl4gn/mfV71Rg+deWVzFJK06CN40KnIeClUDVd/
 W/GFxgSlbGrLvU0gEJW/0il8hRTMYpspmjHaA+fNmkh2njakO6SdgBi+uEPNAi2oeyTY
 ZjmIZyQWQoRpjsBP6Z0MsbcrFtXQz6LYb0kasDldvt89UMkK3cGDGdTu6ion6nld0zdR
 5OTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxh1HIhIi6+6w5f8ZDJ3lFpfoJdUOUlcwT1oEl7yd/1KPFfMf9bQ+K7TTNuWDVT0sXW1MGqJzoFGJ2@nongnu.org
X-Gm-Message-State: AFq9FYKazLq4DxvdLIADvrfFNj2dOD1FITg8agZqBnILhGUC03ff+p1A
 odxYdPgaYVYHchZILHHJl6wnYuKv96qqCN69YK+vWjUAR0CIUG3GVos6iQ+MlJJhGtPmOC5xDJy
 0Y2qP/Lr4cE1voUtZG58GHtMcltrwTMKQk/7+VnfW7v/Q3yhBqUMoyDtRNA==
X-Gm-Gg: AYBFou2IKexgAVikUGkJLVLHcWrBgsWB+GN3lFWd6QlpcJzwdhDRINbSOPEWA4uqt8j
 XSbgB3vSsoIbp8zm7aWxaLY42IrAHMhSuezxotEzvouwgrVeovC03yUJto9G3jtrUiPZiSapsCl
 tAfZi/y2Tg3+JML82E7irC3SrLWwem1e0hKUJge7AH8xMIcOxSdQWg8/phtfhnHWNUslR7YAsdl
 q+rfIzi6xyYuWjXdUrYrrAe6uBKnw3b0A4emhm6/7G5uw1zVV11KbNIKSdXA3FCY6k99GWVP4Qd
 wHdGa1XyWjzSZ0SkNVVkooxutjn6sLtp89W3mS+Ng4YvyD3APbbahtUVh2waz2ExYiQJz8tAd+h
 H0HZmlm/d+qkosRSU/n20TwnXYixr7Cd6iQ==
X-Received: by 2002:a05:620a:44cb:b0:93f:3795:e8ca with SMTP id
 af79cd13be357-93f57f05644mr260956685a.21.1792566047653; 
 Wed, 21 Oct 2026 00:00:47 -0700 (PDT)
X-Received: by 2002:a05:620a:44cb:b0:93f:3795:e8ca with SMTP id
 af79cd13be357-93f57f05644mr260949185a.21.1792566047174; 
 Wed, 21 Oct 2026 00:00:47 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25833b9asm3449823f8f.33.2026.10.21.00.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:00:46 -0700 (PDT)
Message-ID: <6fb8c318-cdee-45d1-9e49-9b1d20ceadd6@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:00:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target/sparc: Return CFR when crypto feature is
 enabled
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-3-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021064640.3591682-3-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad86320 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LgwaAhoOfbendOB-fnsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX7KzrDFmhLufD
 TznlhuHNm3hlN3zGG6Kezv2+zSjFuXZJ35B1GKD61aFJn4rjJ6uRKLT7Nx8XETxMJUlGt0ik6Gt
 KOkdQ+Lm/TbffKftqt9X01FWssB3OKk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNyBTYWx0ZWRfX37PrWL+ErjkN
 OAR8WdGuKm+BpNBbx/eqdlNDcysOX1xhQEIGhO0kGDbagaMVKlr5PKT8Zwo1+cQPUgopyMxqUXF
 7ELTuJUVbkNWG/ZoJsnZeiBO+N1EWVgAC5iNAUEXcuIhO66B1+YSzZvYlDMe7Ca+DsKraRTAwYa
 l7Tn+Lj71OTO0CfVC2s8JBLBJzrjDLM953+7AMN62/sZ3XhZ7ehIOH5UcxwbhnN7WavB4SJ/Tak
 nV9aG2fih9U7LZbpNPIN+oBLECDH5EHI9MMVcuDOTyKBmNV6zdyh5vxVPGoO5ozBhAX2eCp2ZIG
 19Sm1AkLQbMz65Cezem7IlvUsRngAnYYg6dRRMaTutrqNYMrGOugSJ0pYl+AlgtBR5s/wAfUUEZ
 hK4YHXPmE71k3w0pAn4CowkQmlOPgj4K1V+aQ+vOhu6SQiC07N9wdxo3pf1LDSDXMYJbyNYAlx+
 j1RwSWjxnSMW5L9akzg==
X-Proofpoint-GUID: _Llp1TnzM_5jdp01QLK77AVqLMW_nFOQ
X-Proofpoint-ORIG-GUID: _Llp1TnzM_5jdp01QLK77AVqLMW_nFOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210027
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
> ASR 26 returns a Compatibility Feature Register (CFR) when the
> crypto feature is on.  Without the crypto feature, a read keeps
> strand status as before.
> 
> Return an empty CFR. Each instruction patch sets its bit.
> Guests can read the CFR before using each crypto instruction.
> 
> Based on OSA (Oracle SPARC Architecture) 2011:
> - 5.5 (Ancillary State Registers), table 5-8
> - 5.5.11 Compatibility Feature Register (CFR), table 5-15
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/insns.decode |  5 ++++-
>   target/sparc/translate.c  | 14 ++++++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

