Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F08C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKxJ-0008Vl-O9; Fri, 07 Aug 2026 09:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsKxI-0008VY-S6
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:49:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsKxH-0004CU-4A
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:49:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677Dda2e849877
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 13:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ptG+R5WOI7mZhPG8VO1W13KcTCcjMb5jfhFBj425/F8=; b=jzihxCOtW6fXYTSZ
 F5iu0QtVzIrKxD8jGPwrRXkS9f4GeE4AMFiW+q0ZGgxIKtoATwbWgggh2U02ERbe
 R54olq162qpdBs+FjyT1qlDtuZrOcFPaYR3YoucTK/MmYnf/VAQ1rNCGsaXLcc/2
 AhqqmKaRttSfof7nVvG0c2WNgEmwJW11ErVBrkK9ipRcrnM9Em6nAdHMKc/fDlr+
 Qb15Ay0x7NFLUPwEb86AEibFDTVb6jdJ5m1q3FrH+hR22pyzrZV9nAPy9vTNKgXo
 TUIA/T4Xc2Al/AWa8/k7uc5UYIzMWwoBBlAP8p+W+v44+KdKl35ljLyHH0woBgaU
 ye0x/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgem816x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 13:49:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494527488so545682785a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786110584; x=1786715384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ptG+R5WOI7mZhPG8VO1W13KcTCcjMb5jfhFBj425/F8=;
 b=ZjmcxBqy4RKaxlQyugQ3gkLXOQdnM3cvYDA4xI/W2T54iq13jV/nXpGNrw1fUwQZb0
 KNzYZ1yTKjWP29f7UbfMDipWwh7zCf2INXPZPEjhHpWTaOAc5jxiQTI48J5wX71mw0c4
 FJkbOBzthKB/qp7pF8BWRv+85Q8voD2EH6eF1hFxjqGctaOLB5uRH5w390ttABpbyvad
 l5q8C4tKXixYc4JmCvNL04xe7OrCSnexUNPOQ4U4JYqdU0kfHojuCeNlbhOinykljUG/
 MBu2F4QeDpAynbo9HALZwN4IrQB9DMzxkFqkSqgyaseMdM77Ko1BoFOfqt2zbpH7qAfp
 VkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786110584; x=1786715384;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ptG+R5WOI7mZhPG8VO1W13KcTCcjMb5jfhFBj425/F8=;
 b=jJdc5vfoMST2nHFu2EFdUljQWr1lS9wVbjLF83E/GaX3DxYmZ67mmUk0zcIQgzzH+L
 VEZgTrXRi32WEvPvDNiTC7GGJxMQwVOa0xYxxbqV58gVqldrhTGJym37uJ4RFo5ElCbu
 4VPbA//Pfpjw2VyZxfgRD1OhfwYynNbY0D+TxZ9J3fHsMk1tccLaDzttJQbMNZENJ+xw
 6CXMQkCbI6KjAWu9NBr54rf/59bLO5xVSXCeVMkMrHpAQkhrQ+hyBfuyVHbMMAqEAhAM
 /NaRh0ngCS1RWKWFH1c180BgLCs3VbfxjR+amgmg8yYjamuB41Z7PJQiSnp0vAlnIhda
 GZYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKSweHyTurfHPhryBAuWwKwo3habkVNBFwoVNgjDWctmFmeopyA7EZQQfuwVbyoUgvGrerJs9tA4iO@nongnu.org
X-Gm-Message-State: AOJu0Yx1r1r7uy3n1IJMpnGbYJ9eYKKX7xHchBp1TFGQ38QtwkjvR06M
 hZlJw1RKKV0M9oYXEyKMC/Ze2lT5J38xWz8ubW1ePbsQvqBRSc2vTWm0wGSH1gxFwvtrOZgAILn
 T5fEJjSR3mSBmK5yWiX5sWt4obkC8qUIojoJcRv8SE8/bYy9PMWo+Y667lA==
X-Gm-Gg: AR+sD12NqUNpKctO44fvnNQHYMfOAdfF1Gcfjr+KqUe09CBWydHqiwdpDvFo0TBJCcD
 YQ+csw+Ri33IU5rnmXLoiDVkKdNjV13EbLxaDcbTGi+lDt1+4QregEjh529KIftgX6GUEHmIAqy
 uyf6XLKwyX8PhEscm5Zlng83r4MeDzHhlaTZnC6hKVuVc2wupqbvj1oZImdGTz9A0DanXVT6tUF
 +s2VnK2t+RkCnNx9hvEB6DJOVawanQuAhR7zEh6t1GpOcHT+21xy2xzlgaAwSQi0ECSxMzfF9p4
 dgTldjqfeMIr734YTVIADHJOrcZxmFIxt2MB3ByfRKGZ4ywtLqlamIK8QnC7/mMNBYQtrVS6DhQ
 LWOa93t7HNzDQFhjjgf2kKLiYXA1BGV+nmx9O
X-Received: by 2002:a05:620a:29c9:b0:936:5771:2b42 with SMTP id
 af79cd13be357-93666401242mr1022207685a.10.1786110584688; 
 Fri, 07 Aug 2026 06:49:44 -0700 (PDT)
X-Received: by 2002:a05:620a:29c9:b0:936:5771:2b42 with SMTP id
 af79cd13be357-93666401242mr1022198385a.10.1786110584040; 
 Fri, 07 Aug 2026 06:49:44 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e28097bsm149753685a.39.2026.08.07.06.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 06:49:43 -0700 (PDT)
Message-ID: <a26fb578-54bd-40c4-ab4f-59ee61f3c843@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 10:49:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] target/riscv: Add Zicclsm CPU option
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
References: <20260805164345.698208-1-frank.chang@sifive.com>
 <20260805164345.698208-2-frank.chang@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805164345.698208-2-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IUDZRWfYahJGxo2rd1Wsjw3gQUkyRcGw
X-Proofpoint-GUID: IUDZRWfYahJGxo2rd1Wsjw3gQUkyRcGw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwOCBTYWx0ZWRfXwy+kqjmIO1m3
 MoysModdzYaJwfxWphdXOvhCQrsvT04fPOefEcBPbljn/E4uYi7eGNs67K3P6L7KPRANxtgm6/p
 J7829Co4f+brEVKC0G5Zuu6b/R5dFls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwOCBTYWx0ZWRfX1p8BpLfklU//
 clgfMhieYGTA2UGd0WZkpwzgr4T3BO0UbHmkc8wx9DW6cIi9wT0QXqLXbGsdifzjd2Q1km3xwIs
 OnbicMs9v9TKtbia+6raB2hX/C2hWqRjNaMDAQCH5h754gRU1uk0vkcxQ3kSdgVb24P5ixTW90E
 6RynOhXAscYUq7SL5G3YdDMkvH8mc7Ct89DvWthDq7liS9sTkB+VgsE/6CA0Rokf4vZdTwrBp3/
 B4Elj+uwBqWwJ8VMffelgh0NHiWraJCrZNJWBp+gMcNjnsQUAAKoVG3IGOYfCjknPoCl+VtmPMv
 DG1z+5NXtDoZCaAudYTsy5Y96oDjMOWiNGQSDNyfSvy1Z42ibeqvNuBZI6WZnalB1KRxAIcb8Zk
 H7Db03FJpoMumnGBTQd869yJky8FBsvPZxGYOyXMlsezkDtKSLOFptoHnq2P3/AC2AsBDpsBi5p
 c6xMXgoPm57c2ldR9cA==
X-Authority-Analysis: v=2.4 cv=X9Ni7mTe c=1 sm=1 tr=0 ts=6a75e279 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pFyQfRViAAAA:8 a=JF9118EUAAAA:8 a=KYMhUjEZWClA7Ab8mSAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=oJz5jJLG1JtSoe7EL652:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Frank!

On 8/5/2026 1:43 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add Zicclsm CPU option so that user can turn on/off misaligned loads
> and stores support.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu_cfg_fields.h.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 9eb47af0a76..f8c27a574f8 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
>   /* Always enabled for TCG if has_priv_1_11 */
>   BOOL_FIELD(ext_ziccrse)
>   
> +BOOL_FIELD(ext_zicclsm)
> +

This is a needed step but, as is, it's not adding a new CPU option for users as
the commit msg says.  This is being done in patch 7.

I think this change should be squashed into patch 2, where ext_zicclsm is being
added in eligible CPUs.


Thanks,
Daniel

>   /* Vendor-specific custom extensions */
>   BOOL_FIELD(ext_xtheadba)
>   BOOL_FIELD(ext_xtheadbb)


