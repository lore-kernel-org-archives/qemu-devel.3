Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D3CC98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAOfc-0003UR-2e; Sat, 26 Sep 2026 05:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOfT-0003U6-P7
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:26:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOfS-0006mH-9H
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:26:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6P3NH3268392
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sJt6Dj1PIungqxW58xguF1M9y2Je/26aZYSggpkLQ3w=; b=dfmtvFA9foaEJKnk
 leKhgnmmQl4ngPyRAR3FOgX8/TI6qVbMrTOweux2RQKBJvwQGshje0Nz9ednrh4A
 k3MwLqhqQLKllAikGG3rZINwi/3i6I5MB2/9oj2jTzuAGm5SL486xIFhd5scVoWm
 2BoTxRre8jVkX8ckilnWhBGhLvH0/PQFZJVYKZ8UnL5gpjQ29qLHVzqM1bvCjNfS
 nJ5CazeUN5ZEnhxBlKgyq4oGr/R3xnYgVK4SB1bl/G0S7mZH1e5HfpQyLSQTtA43
 xaUt2pM2Uth83IHly4gGB1aV/2uDU0XYNVIH4mcMyenaf24BNC2U8jzpFtoRM1r4
 MADxzQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp0w9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:26:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so389187585a.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790414760; x=1791019560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sJt6Dj1PIungqxW58xguF1M9y2Je/26aZYSggpkLQ3w=;
 b=VrqwoXvSaxuvD5X3ZxSE5ADBcLvyNPk5Is42Phk9rVV4V6gCipbuRbk1vIkMJudjdi
 5s2z1+f0dIWjARo95MrcbmB29Pw/+aeyLjfNx1tc6cNLzX3XSqJTg328oMUrhAlEPBDW
 ohwEdKyBO7aCeMJXTe2O/xx9fvOwlXLmPfyDcdvPtwslliyU13sRSTm/3YAfCWpMEUvK
 Pz6IYXWFuuBmxepN4iLAshhXH0EvGnJaobbP/5JJ2ZREN+zq/C9YpzYZxUvztnlkHT53
 i8Z7jvLs9t5ybkoqr8Ko33ZFTY2ByUEcbPI3exrWOQ3XCq1peatH+wLgBZ4FlfbLhjij
 j1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790414760; x=1791019560;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJt6Dj1PIungqxW58xguF1M9y2Je/26aZYSggpkLQ3w=;
 b=rCjGmoDZXJQdMHPcycUxhj/9l9jOHPGHSS5f0apwuPGsq/S9RkT592Sgg4wG6teIrW
 sPJMMtRSx85YRPuR7pRzGsdmVA2ZCGGNISOK8CpHfrlCPzlDzgyWkG6xofSC69EXCpy5
 wiXv1J5UE02anifJ65/n1Xm3m5tLjz5iWjfhRYNtVct9cwKGqZuLtk7CdpYdKqNIygOR
 lfxdE6yhjd81Z0xNsLKbfSFr61hwkdTFirfpZi+3G6+X+fGU+lsJCNci5sNNEbn9C6WB
 XJ/a55P0w+5LNLL9M9r0onndW+7Zm/yhPLyU8hV0DIz2nRTq4FCdAQ47QMsjfG8wlSaS
 B+nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByt/67R3OgQSUGbK28mahU4/mAeCfXBxanQ6MiNYmTUBZHyFNRlQsyyAT0doquHqRIVIplRELRgqssu@nongnu.org
X-Gm-Message-State: AFuF++lFny86JTyKQQ0M/l4aQEw7cbv2rj8CxF5MCXi7eO4AlFxGumPZ
 lyhtXSW1wGaE4uBDMG3elGjVqiSc+8YZYWsu1hFvIvhK6KAbqYdViXW9dgFKgupbnCH6UW6W9Sm
 iZ4pwgL9VN21bDcPEJmXuwLoeGNqwrtbPnOJCGaa56yqcVpbsHmPNPE4RXA==
X-Gm-Gg: AYBFou0625z9gvPcutK2H4dVGzPNCcgW2YZEFr3NLm1dG75gFijv8Hjy4qQAFToDZ6u
 EgwGBVF99+ReDOhzOgvhcgOlVtOObRtusYSnqFrH67a6B6qY1t3SgmUqQjGe/f4og/7a9tpir8c
 cT3+Nj8ci8eaWvomoIkIRvyTrd2nZxWzclTUU2nZQeMC2dIdRu/HeCzmalbxaAJdjcjsDFqie55
 ctn9edVU49PF2dhTYP3GvOevwJGFXTWhLV9wICOsa1TACHbM8gAbFr1c6HMOSFugakNaoAO3Z9B
 JFzyAytOo3w8i0bPs/j8wfC40tYHUDv9Jpdm/RxkTrHETPyZQlV6olYqsG8ZGwBk0LQBMA6aqLP
 lmkLaBTuuDhcHq+ZXqoM6SpOe98+uafzRNg==
X-Received: by 2002:a05:620a:26a5:b0:939:ff85:8067 with SMTP id
 af79cd13be357-93c43d7bbf9mr961647685a.30.1790414760189; 
 Sat, 26 Sep 2026 02:26:00 -0700 (PDT)
X-Received: by 2002:a05:620a:26a5:b0:939:ff85:8067 with SMTP id
 af79cd13be357-93c43d7bbf9mr961645585a.30.1790414759674; 
 Sat, 26 Sep 2026 02:25:59 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a746c57sm12057693f8f.35.2026.09.26.02.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 02:25:59 -0700 (PDT)
Message-ID: <ab8b99e4-dc00-418f-9b94-7d77df75e5d6@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/tcg/mipsel: add multiarch tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
 <20260926010053.2840-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926010053.2840-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzNyBTYWx0ZWRfX8aMNk/8+Szgd
 o9Y383H0PvjHZ1PYvk/x8BP0jYAwwYKpRiqDyJTCFfiw4wfAq1C/56WN0eUQNRQ/vLeuQ4rzZIu
 V+TWZQ5SqxI9R6C/6UUZO8jvhJIHr4yy+HSu399rVzi4adt7o8P234NYZ8CH5oeIf7Dza2a4dwr
 7TtNdCrshN9bXM3lDXpVgPovDQdy+CrBU9bjBBcUcf5X2br78Y9rM3xNbF5WWOD31QT1nb/yjSz
 2wiuTFaY89M614/tU2mi8lDdChGax1iDLxh7JSL8176cMUs18TenX2ZczGoucTVgbc35djkKyfV
 tTJ8PWTc7PY6kznofGZYyEFNQm8bfxwzyuCRavYWnnnsu41Wj6CdnKu4/Zs++ZBSN6696FINQ3E
 FYK29dJ40cH91IWTR6qKmv4NXuw7OLIKxH9gSw+1D62AvVt5EzkUs4aG0j8yHUdhVcpqoTnNKg4
 PwECavwXU9KprqbRycg==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab78fa8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: LsTisnWwPHQf5wqTiQZeut4rQfLPfp4k
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzNyBTYWx0ZWRfXxqQWUbY9UN1Y
 Oy9esOHgdwMeVihFvemL4sQVZS0gYFERRP4ADYRotqFFRfDFd9jXF5N6JUecUS4NRM9j++XCOMW
 GCqCUNTGnalRKrP1wIRbCcMufeVMgT4=
X-Proofpoint-ORIG-GUID: LsTisnWwPHQf5wqTiQZeut4rQfLPfp4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260037
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/9/26 03:00, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mipsel/meson.build | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

