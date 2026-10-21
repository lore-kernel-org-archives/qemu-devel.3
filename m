Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA56606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YOc+RU/R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kjraiS9t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLMe-00084K-5r; Tue, 20 Oct 2026 21:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLMc-00083v-A3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:43:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLMa-0003hr-BF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:43:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtr7x2442066
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +vszFqrR8kVeH5LmmmgcVHBEtEWECsW1KnE5M0a12N4=; b=YOc+RU/RfYaZPFa+
 SxtxSICVtpayEYVxhwPmIdW4eiOr3jAl+7PHfudjtjMZZie8VCKqP3n5EF+1bXQo
 urFLxiNYI/ztutus96rCZh7CMWSBtIRjY1ByRhVopcsMBc/cKNuilirVw4xM4/cL
 KQeLt3RCcANo9HKKxwNo8ZxcRrZIgYqG1S0HiQ7yzS7nM+nrRMnqvrslaxv/O4vF
 eYpMxtNJreSfCXWraZtcLiKS6vg9VimT66crSYXs7iHCQCzNaySVOwScGaunTRwr
 KsoAYB628/5BmlytextEFaUmPBsk5lmZyohveEJ5YYk4XDlZhOmwI2TDUfKN9OBn
 +t/vHA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hscu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:43:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c0f73807eso4698626d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792547010; x=1793151810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+vszFqrR8kVeH5LmmmgcVHBEtEWECsW1KnE5M0a12N4=;
 b=kjraiS9tzOPgDw8jWTSnVwbTkb+0/0+WDtB8tmLlVV5/+/QND54KoJNl+Bkx7dSEcd
 NiSXOyyS9Q4xL20YCysb1PklJN7uWExc6mBQnpbylwSwlgukqCrdkggRmYPmryDj1z5a
 W4CPKvClSJWKeh7o5P9eRlv4kA4OcyiDgBvkI/Ura35JGyXhojQiImyBN4mQQchANe6S
 MCCEo2fOVI7uzTUEQ8+Zd81VFZuSrIyot55eCwzbc/Ew8N37oygRHmDdULJ9imOk7JaP
 8QNJAPs7J5n7LE8AfEIdRGY9iM2KTiIwM1OXFa8Fxk4fkKV8k3DG0qXX6I2FpZ/uwxGj
 Lv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792547010; x=1793151810;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vszFqrR8kVeH5LmmmgcVHBEtEWECsW1KnE5M0a12N4=;
 b=mgd3zU+/gEOF4aQ7n87qhYL5Og3js40mYvU8zAM2cQPV5xmryXhUaBNke7eFTd5DNW
 4e9e1iFPMm2YLXVhENH9DiCgkONB5yBPBQHTvn07l/2wrFSLSflvdah9Od+4P59I97Ye
 Rw/7K58LNp1uAwEt9hCA2KB2Kx5W+Gt5hm7UdDqxeKtBRhTBX6Q+kxrF0HgUd5G7qjyL
 u9K7SC1HExNSa8u4j0EUkErNp9GospZKTInhN6Z2fTpuJ5M3PpG4/7d/77HJq2QyhB55
 BcJ+GfQbovhHdVqDPKZ3awcXUzQf1nFKnNeEXzsSLiOIl7nI7tj9uZk6ElT/bZmFbr6+
 mL3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIn1OUPbGEC/NUHgcm/kVP3W6F59rHYu/k23I7xiiYGuW4AXdMUnbo2OQVZ9DrdWIOGEv8+VdRTWV0@nongnu.org
X-Gm-Message-State: AFq9FYId3zrGlTrIcylxPEvHb4NJTISVK1Jv9JrbpuX1+HPuPUDdfJx9
 nyHn58JlwrwCbLBuMZggKbAEXmHnYqBeJ6Ewfo9JvSsPvGQWSjKgFzoA7EDoC/0wEaNEi5vjp72
 MQQ9nYW9seck+L8b2uqeV/romzhfQ+dVw6qw4WkxzmvgiK0BlH2OHTsbFJA==
X-Gm-Gg: AYBFou3AUUjcdKh/DAH6V0m35cmsm+3eX1bGwKZyrt9+hqSQ4A5W1fh7tiZcaHDuLL8
 TyUPa4L4j6w/VduDUOl7hEB/yNHx4gK+qywG5nqLjbYdvh4LT3K9zCV0sxWyxYCD3fWOSNA/K4W
 xj9AIIpmSlFicMqIlXh8tn98nKKomXl5NPBYStXsk92ErqJopywUcr7jG5leGQFoQ6MngHAbPZM
 9CfAuNvuCo+oak9KDpIN8OGu3aFT2vYjwJDezOxLRoH93US+WJ9F3IiFmeWY8gwzjW5LbWGSOfL
 ywyq4j0OzbR7J15FRKKJh7UwmqIJEbHgj4nu4bJiAniRQMDhmKcGpBPvx0Z1tQ4V23o8DzTI+sQ
 0tjHE3tT2HrWIHQgVDu5FFClgIzOq3PnFhA==
X-Received: by 2002:a05:620a:4621:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-93f57fd3b6amr175950785a.82.1792547009719; 
 Tue, 20 Oct 2026 18:43:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-93f57fd3b6amr175949085a.82.1792547009234; 
 Tue, 20 Oct 2026 18:43:29 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25833b9asm2025059f8f.33.2026.10.20.18.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:43:27 -0700 (PDT)
Message-ID: <18a22eb3-9e56-441e-9d1b-e1ecc9eb98a0@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 03:43:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] hw/core/sysemu-cpu-ops: add get_dump_info
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad818c2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=cXGpp2lGlwQQuBBFnDsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX/c0lDI7+CmCR
 aCXye77bldBiL6f9i1AXfVWUmQn+01CQ0d4baAk+MCJjLtbp6sGpwPpafKNVaAyAcoor0j/9xLj
 btbltGqTYkHKvSnptdDGX6KcOexiFuw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX88R67YhbRYaR
 kAz8jCE8ab1sto5BqCBwY39iCu8hGBm0UUDhLqq0cZmSwYBEc83tCVx0W8hI1GO3hBwkoa1tujU
 LLuyHzMfhgARgXbHVaaOYtgdZDz4ozCrhal6sZJCSbY0wSrs+O6q+nJUAwvize+d7OGIeHZvgSH
 UoHuckx2HeqCCDHf/XNP9TwRs3QMDEUfD6x026PYZZWYgX6OtLTo/3vDmiJAhwrS83FGammdTRY
 ysEJRa9r1IeC97KJxO8pvRYO4O3aOvphJ5pejdtcPNQ60udZVl2xy/7uUuOpMWrFHbelgHJuRk/
 cU6I56hpzQjmvdcZr315VfD4LMthneUawSJtu6mQBi3EXIxes6t6rfqSOEpYDpc932DpBQavIba
 PnVIQSgo3DPT2KalVS6CJw32F89b+B9qLgdAhEnJUWVijG2oKeRv+45PkYNXOIBEaSUTKzzroKg
 isWPNRnLSvHNILcFAcw==
X-Proofpoint-GUID: HOdoXYGiSsCaCDP-JT4Vdv-BBt3hKWp9
X-Proofpoint-ORIG-GUID: HOdoXYGiSsCaCDP-JT4Vdv-BBt3hKWp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210006
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

On 19/10/26 23:26, Pierrick Bouvier wrote:
> This allows a specific cpu to declare its implementation of
> get_dump_info, needed by dump.
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index d125540262d..2c7d0b94767 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -94,6 +94,12 @@ typedef struct SysemuCPUOps {
>        */
>       int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
>                                   DumpState *s);
> +    /**
> +     * @get_dump_info: fills @info with the endianness, class and architecture.
> +     * Returns 0 on success, or -1 if the guest memory can't be dumped.

QEMU style is to return int when errno is propagated, otherwise
a boolean is preferred (bonus if error propagated in Error *errp).

Getting the prototype right is simpler at its addition than later refactors.
> +     */
> +    int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
> +                         const GuestPhysBlockList *guest_phys_blocks);
>       /**
>        * @internal_is_big_endian: Callback to return %true if a CPU which supports
>        * runtime configurable endianness is currently big-endian.


