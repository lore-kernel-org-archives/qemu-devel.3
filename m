Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3117CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWubI-0006A4-Db; Tue, 09 Jun 2026 07:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWubB-000692-8r
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:26:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWub8-0002cT-E1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:26:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6599xPDM2209165
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 11:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d2+epJ88M7YZdGpUg11r+j8URVv3TGq9sR/aOPcLgJ4=; b=lMWnIZIfHadLmneg
 Su6/6snDFAclXtlxe+KhlP4h2h07j6/EbfC/7ElRSyPky7kmRUMWb+WrwfCP2OsD
 bBmquXsd3aGsg7X35fDkcfh7gR2YpkCyaGXb7YLdjXABKrYhvjyoFmpfkTvLR2pR
 PNuMUvb7lB6JpDgaMm2HkkE2wtMagkXfkcsh/pcgrfQLVs/M/RHoeoMST7uuD6Am
 59r/z6kJwcdBT867bGYJZNchcZ0ljavXc2/SmC4CcobgPZz1nJVqSaLqQQHgWHae
 eq0SychyfoEy1q0ahfdewRDpfjymXlsWwl0zg79hG5Ug89XKjPJQPwW7LrgFDg6K
 Wtd5ZQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4gxej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:26:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so107002531cf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781004380; x=1781609180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d2+epJ88M7YZdGpUg11r+j8URVv3TGq9sR/aOPcLgJ4=;
 b=jXnfVwHkrX5LQI5k8wqLTcpPbLuxW8DIlsZjVvz1wumDa1d4GexI85chWNhkzM97JF
 q3d7UoPNEQCGqYVKKTQi/KAxhtRwoDvemdNff/jMV4m6JoYf/aHMbqDHk1KU6iLuymB2
 ffgM4W3Cs8baboHTRdbOc4AOdJhADu3+CkOZt6BgmsUA9J8YX+BLnDcsLPFfVKHvC79O
 AWgSDcUL4RW2mGjJWVPtu1C0AA/8qTjWX6/Z08sbPHpuOIJ5PAI/xX0gtntIIjVZMGKL
 XepkpIDD1y9qgCgylqX1FVgsfx+ro/kQc1VF3ZEJDYgEcqG3w6B80+kiE2zMZ1NJGsKu
 bPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781004380; x=1781609180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2+epJ88M7YZdGpUg11r+j8URVv3TGq9sR/aOPcLgJ4=;
 b=GkEFD7jFSA0ay1tKaI3cgeZ06MiZXDl/RYy8zlVBb5eNuo8IzDturcvAPPmaxvnEnA
 Kqn7YHVNqTLXOH9m/myVyX3Tvqg0EGfmD65Jrs4wVVb4ySu9+lNQX7kzU9P+YgS3ukU5
 UfFIGSqRnn9e2kcTlN+HOkfOOHXmlblV6j9oeGroE3Rzg3FrQLpfNL/YMjwAnLfp3Yz1
 0bZiMFU2xr0hNLV+oAixkL7bURpMMadBqXvEbdXvsNjd4N9Nxe1cYJvcf5FV0wLrwzbE
 UNj5NEoZWWnd6dUY6OeI0Sx30E6v1iHxqRRDae59leMGzrSuKCLIbtRWuJTk6JKCsKkN
 iUEw==
X-Gm-Message-State: AOJu0YxIH1bcnt36WuPgSSLvCN6V6MCC8aVrLMead9s1y70I+N7ziTRf
 GDe4mL2inCNnUUmPxzvY6n8cIc3xBaG6gAcjOFswYuOauPBdUEIWWVYN9hq0eS2+AAUfl0H3CFc
 Kcitw9YKUxq1sAoscguM7PGmkViY7nObcizPpqgHEcqYKSMJ1cLkNFAK8IOZS9yn6rFEdZT8=
X-Gm-Gg: Acq92OFm3aA8+YtJIX6Ken08dPDV9Br+plFFtsAqcP32yh0JhX672UQgrsBqrmbxGa0
 slohiIfPx8bRT7QntYXRWAetTRSt0yz6OZs6j12VU0ppLTf2JjigPTcg56AIF75yPxI7BWNBGeS
 tWB0HnsbGoc9RO68VCmSa/RhmStvqI6AdN+C9DBigLSYjFEiznTrvDh2W55JJPveVI8IYOQy+lz
 2jaTeX2uioThLBk4Tu8J6PhPCL9LR8polymflOTPF8CJ8s+UO0SJSyZV1cPuAr79W0jxs1wfnCW
 x+5ffxE7pQLmyLx/VmUSnGQ/sUhEE2jn7A7eCN5Vc+GB3bIX9DIzrrsAoSBIBU98QZYPH4CyUEM
 VnxL629nIApfwhftLDxdl4w63sOCUea+lWQykTsTViuMgjcfZxeJ/z0r1FSNmZF2t3N0=
X-Received: by 2002:ac8:5ccb:0:b0:517:6350:ed50 with SMTP id
 d75a77b69052e-517ca5fb14emr32225551cf.45.1781004379971; 
 Tue, 09 Jun 2026 04:26:19 -0700 (PDT)
X-Received: by 2002:ac8:5ccb:0:b0:517:6350:ed50 with SMTP id
 d75a77b69052e-517ca5fb14emr32218901cf.45.1781004373653; 
 Tue, 09 Jun 2026 04:26:13 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517712a7sm1022599166b.4.2026.06.09.04.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 04:26:12 -0700 (PDT)
Message-ID: <d041c89f-8484-4405-b208-f2e8830a92a1@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powernv: boot OpenBSD on POWER9
Content-Language: en-US
To: qemu-devel@nongnu.org, "Kirill A. Korinsky" <kirill@korins.ky>
References: <20260609021945.73632-1-kirill@korins.ky>
 <8733ywtpgv.wl-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <8733ywtpgv.wl-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27f85c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=3tcz3bTJAAAA:8 a=jRLB2SoPAAAA:8 a=Mda-oLRLTsUtlWQnhBgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=4EbjBm0RLgFgoQzmu6QD:22 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-GUID: 0pe1cBnaNdRm-LYkKwDUeAYqpl1GujM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwNyBTYWx0ZWRfXxkfLiSQHFSIz
 0Q8BLhkvVI6PuootP7SR8i0+kihF7z1jtghU/VPOe2VeaQebOWgRDKK0ehkjZWe5FNrPC5/u+KE
 xyW8PHwbXoBkM259tY9POPE4X2SzOTE+PmRqfdjMOqym+wjt3D4RlkOXmaLneVR6eTLCO1BlP+j
 nTUJp68CJfj5p71CrxHIz0hYjQBbetU3IN/5b7xjmknr86SvymgONE8++HpDy1oGpnLPJ6o1UaZ
 7wYI4vDWF0M1zDsptUcX9IlVfTnqmmjB0cQM9uLa9Jpbwj0MrYss79KoOVQAE2zwyVbZtICkMU7
 rHrPvhtq0b9pobeLS7q3L7rDqt71v/RK4+FKeW4jkCI856rb9UrujjLLJCsmp3kbO8MJwQZ+oxh
 iV/3J8FKX5OwSfDpqnlgk/z5nNLQuWrFEjmQhmaIsS4/uojbSCUvPXlpUTCn7smSUWzxk/FuvYI
 2q1rIL14l2pG2v8YaBg==
X-Proofpoint-ORIG-GUID: 0pe1cBnaNdRm-LYkKwDUeAYqpl1GujM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090107
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

Hi Kirill,

On 9/6/26 04:30, Kirill A. Korinsky wrote:
> On Tue, 09 Jun 2026 04:19:45 +0200,
> "Kirill A. Korinsky" <kirill@korins.ky> wrote:
>>
>> OpenBSD/powernv programs PTCR for LPID 0 with a partition
>> table size exponent one smaller than QEMU's existing ISA v3.0
>> interpretation. Try QEMU's existing PATS interpretation first,
>> then fall back to the OpenBSD LPID 0 form; nonzero LPIDs keep
>> the old behaviour.
>>
>> The PSI model now exposes POWER9 IRQ level and pending status
>> registers, and keeps both updated while delivering through the
>> existing XIVE LSI source. This lets guests that select the
>> POWER9 PSI LSI IRQ method continue to receive LPC interrupts.
>>
>> The blast radius is probably minimal: the partition table
>> fallback is limited to bare metal LPID 0 after the original
>> lookup fails, while the PSI change only touches POWER9 PSI
>> state and reuses the existing delivery path.
>>
>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> 
> 
> It was tested as:
> 
> qemu-system-ppc64 \
>      -M powernv9 \
>      -cpu power9 \
>      -m 2G \
>      -nographic \
>      -kernel pnor.BOOTKERNEL \
>      -device ich9-ahci,id=sata0,bus=pcie.0,addr=0x0 \
>      -drive file=miniroot79.img,format=raw,if=none,id=bootdisk,snapshot=on \
>      -device ide-hd,bus=sata0.0,unit=0,drive=bootdisk,bootindex=1

Cool. Could you add as a functional test in tests/functional/ppc64/? See
examples around this directory.

> 
> Where:
> 
> 1. miniroot79.img from https://cdn.openbsd.org/pub/OpenBSD/snapshots/powerpc64/
> 
> 2. pnor.BOOTKERNEL was extracted from talos-ii-v2.10.pnor which I get from
> https://wiki.raptorcs.com/wiki/File:Talos-ii-pnor-v2.10-bundle.tar by
> extract-pnor-bootkernel.pl which I attached.
> 


