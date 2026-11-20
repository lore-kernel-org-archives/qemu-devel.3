Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37660A5BC0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNpyn2Lw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WhyyLcxn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSHy-0000wV-Ad; Fri, 20 Nov 2026 12:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSHr-0000w9-9p
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:20:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSHo-0005IG-Hn
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:20:34 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKH0aP51882370
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RD0LvfYVKpgR8cWtr4XmZ6Zl6mhqmdO34EgPt97kAv8=; b=QNpyn2Lwk8bFOdfS
 9agX6QX5r+5KxtEZhDownMlENQz1sQv3/Dso80TQQheAzRncX0InRE2a5csjYhik
 SXRRNTdIjNN9jzCStyu+GaqQRGJJW2colXAbRyHCgrwqowvYjxMfKsNk/yVvlwKS
 BzgTWIKm5xvYR8Ji0IESKieXEZgwRXv944Q28KFwdmSYGoV3lV5wv5gK7q340ljm
 dI/LE+n3rk6+4BelTXNnC8V5SAvRG9kmK5c8XPNXWrutQtwYpB6PzKPvL9fkl5cq
 cAVHrs8O+AUVavLi3LtGD7hsKx1cJ5y8iITB76zMfddKysquAgx+YaORWuM2zsA1
 PF+nGw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2t7vg2t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:20:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55cc3c32e15so13599031cf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795195230; x=1795800030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RD0LvfYVKpgR8cWtr4XmZ6Zl6mhqmdO34EgPt97kAv8=;
 b=WhyyLcxnHqycbJ1SDEXySGyCxXP1m+uZ99tUjI9OE+I4pCJ0yz8x8CS4aZguz6SHbW
 2pYvGvncaqM77bd51cZQwvgEIDEHGylKebJwQBfCTwhaukOcJL67Apv8+x8Aw8Rvu4aT
 HJo736rbeYedk4jYpmF/4bgZZ16eVRC9dVNFvRxYG4BD9s8EZFZXwRQ67YKTrrs10Wxy
 051qKkg04F/B+JWWLAz/PPt5XiB5iiXbXr2DS2N+XocU6pgpbKKkCR9s5469QHTUOrhT
 WX5SnAK8Vzuu54cZKMxhanZC+5waf/8Mu5M2acmkZQsV517zeVRHkfRN7JNZ572CbG/7
 dBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195230; x=1795800030;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RD0LvfYVKpgR8cWtr4XmZ6Zl6mhqmdO34EgPt97kAv8=;
 b=AWDACOR033B9WwbwzLIl6zOCRD6AY1eDlw6EBUGbB9TDg4+9pSd1lG4amJshzKXJdP
 XkW+XUHjT/PCIjxMgoYPdLYewNjtE1EhGJpsMxow1R/vM35se7JjDjpcj/tQV80bGkDz
 jzhctNOgLbS8gJKcJRz/KIvHHN9KMbQ2rL1bpG5vJ9WNAP5K0gb/umwLX+nFXNcyCqFc
 Xi/8dnMz+X7sdCsN5lg2Fuz8c78OWZnuh08u78TVg/3MfsuBfaia/hViRleV9LzP4CkU
 KelAol/x7peteklkVG+ppOf2TvpDjnVRrjYRCYYayg7I1XqQ7/bvLpUJ/Q3d0zdaM7v6
 5iVQ==
X-Gm-Message-State: APuU4Z8ExNSSgGgUcOZwCUuJUdGFxZ5ZkMfS9UjPRBFsWTr4iBSoBiH2
 Y1iBPm0HMDJO2Ik/yJtPRcLHokqxUtccNDulOaCB1dsY8pq4d4qyaM1XxcyebXdqBwDGvdz0yT3
 bA7K01fs77ymzTMB5kHL7VmN/LSv9UY31LhxLMPspV4uHs+KbOTIioLH3rRAIG83WQw==
X-Gm-Gg: AYBFou28vnT84OnWKtbTHx1rt5RJq+24hK30Ju3yi0Z2vAiCff/iqmkQR0zybsaHFLW
 W2V8sFEVuCPGZAUiltBalZb11w3eqCHX1x0FRYxSxe8hX0byZoWak2QTqClT13S7vfJ2RZGM/8v
 vGZoT6gaUfeyvfucDJYWKJX/mfKdGf9zLcnjLTHFTMoLfoWm1AX4/FDY0I+DDxK1OS9srPu5ceu
 Gk8oKZv1nJq7+rLiJFGniDkn7IJRVovFecMTl2HH0x7GtDn3TDTQMvuqnC5SB52M8vxhmWSng8Z
 IvqBT4BhfUpzpO/sB85gQOmM5eqodMjyvnkg37cT1qpStta1+1LyLESGda34K2/zT6SfLK2xH20
 SKVuwpPr1yymIrW6EY+NYZuCW69/2iLUAZMHB0KRp75YSx0YJwqJoT9TxN/GnCDfH7YHIMBt++G
 hF+TMGtgc=
X-Received: by 2002:a05:620a:130d:b0:949:7bb1:ac5b with SMTP id
 af79cd13be357-949bab1d16bmr574910185a.47.1795195229726; 
 Fri, 20 Nov 2026 09:20:29 -0800 (PST)
X-Received: by 2002:a05:620a:130d:b0:949:7bb1:ac5b with SMTP id
 af79cd13be357-949bab1d16bmr574903785a.47.1795195228978; 
 Fri, 20 Nov 2026 09:20:28 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab9cf005f2sm5006847f8f.45.2026.11.20.09.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 09:20:28 -0800 (PST)
Message-ID: <dfbbba97-a182-4f5e-acd1-c962285ff463@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 18:20:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-11.2 v4 00/14] nc53c710 rewrite
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng
 <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9wAqE3zkc9Jwjkt9-jhI7h22GqU6Inlp
X-Authority-Analysis: v=2.4 cv=BZZNQbt2 c=1 sm=1 tr=0 ts=6b00815e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=kFZ_5tOQdVLDG4LKQcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 9wAqE3zkc9Jwjkt9-jhI7h22GqU6Inlp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXylA0bjPAg2E8
 4nBz4ezl56H9FYV8VYPy646G/IFv1zJhOGjj68SwTLJhG9OSIjcv3OfEn90zq02ka8P4JLo47XZ
 /AQCayB9JGvKYY7jHi4Mh+wSnDpq3CU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX+4iK43ceJYUz
 Ij+jcAbrhdv9B8BUtYV3zfzCRaXeKu9evrR0r1RyOVuqcHFft8UspS87g6AZRONymCda25BHFED
 Z1NYcV4yZLSsGXFCLSBF38P9JVaOFKfYNX0S1oXWsRFMF/04eqUfHAtKj3HxIdMmkTzraVWkLS5
 UdaSb0Ic8LZwNLn7sALBbh+3ui8fw/sadEdKWD2uI/3mCnVbN+9fkoM3Xc2q2yVJ7cOgJP2RYdG
 VLoNuI+pGnyP9KHaLBgZB8KXVqOTNFIve4D0jOk+eeow/+ttrgVOsQwZbCfti0XKE674Ou193Ot
 EgTWYUXdfrc+T397E/9kFKRCVKpHWUlAFIL9m6McunClzZHzgeOVdA58sEBNcwgD63N3Wo9BMNU
 xjETUBnZC4NN6W2M8OW1BKey0J0dKyK6cRIDrZM2Mp4r6kmFtNle9qAgEKtIZTzUMLgYcas6jDq
 yo4MfXlqJhyNOg9vGNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/26 18:12, Philippe Mathieu-DaudÃ© wrote:
> Fourth attempt to replace the existing 53c710 driver by
> a new driver based on the code of the lsi53c895a.c :)
> 
> Used LLM to decompose v3 as logical / atomic changes when
> possible (didn't work well with the rewrite patch).
> 
> Fixes extracted first so could be merged for v11.2 (patches
> 1 to 5). The rest is the rewrite, so up to the maintainers
> (Helge, Mark) and is probably OK as hobbyist-only code.
> 
> Since v3:
> - header split, Suggested-by tag (Zoltan)
> - I couldn't figure the "hw/misc/lasi.c" change so dropped
>    the comment about it.
> - Dropped "move to COMMAND on CLEAR ACK after MESSAGE REJECT"
> - Split rewrite patch as separated commits:
>     - base engine
>     - asynchronous completions
>     - synchronous drain
>     - HP-UX MESSAGE REJECT quirk
>     - reentrancy guard and reset-time request cancel
> 
> hw/scsi/ncr53c710.c is derived from hw/scsi/lsi53c895a.c which
> is LGPL, the rewrite is now declared GPL-2.0-or-later.
> hw/scsi/lsi_scsi.h, which is moved verbatim from lsi53c895a.c,
> keeps the original terms: its header says "This code is licensed
> under the LGPL." with SPDX-License-Identifier: LGPL-2.1-or-later.
> 
> Series reviewed against the NCR 53C710 data manual but totally
> untested (I don't have guest code to run), thus compile-checked
> only. I haven't tested whether the series is bisectable.

This is only a split experiment if Helge/Keith/Mark/Zoltan want
to pursue, I'm not going to respin.

> Keith Monahan (9):
>    hw/scsi/scsi-disk: Add quirk_mode_page_no_flexible_disk, use it on the
>      715
>    hw/scsi: Move shared LSI/NCR definitions to lsi_scsi.h
>    hw/scsi/ncr53c710: Rewrite the 53C710 SCRIPTS engine
>    hw/scsi/ncr53c710: Deliver completions from bottom halves
>    hw/scsi/ncr53c710: Drain asynchronous transfers in the register write
>    hw/scsi/ncr53c710: Append SAVE DATA POINTERS after MESSAGE REJECT for
>      HP-UX
>    hw/scsi/ncr53c710: Guard SCRIPTS reentrancy and cancel requests on
>      soft reset
>    hw/scsi/lasi_ncr710: Map the full LASI SCSI module page
>    hw/scsi/ncr53c710: Bump the migration version
> 
> Philippe Mathieu-Daudé (5):

Oops here author should be Keith Monahan?

>    hw/scsi/ncr53c710: Cancel the in-flight request on soft reset
>    hw/scsi/ncr53c710: Do not load SBCL from DBC after a SCRIPTS phase
>      move
>    hw/scsi/lasi_ncr710: Limit max_target and max_lun to 7
>    hw/scsi/ncr53c710: Keep DCNTL.EA and DMODE.FC1 across an ISTAT.RST
>      reset
>    hw/scsi/ncr53c710: Document the SIGP latch deviation


