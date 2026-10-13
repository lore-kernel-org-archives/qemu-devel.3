Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F7ACC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaKC-0002RM-AR; Tue, 13 Oct 2026 07:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGaK5-0002JE-Si
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:05:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGaK0-0000TB-To
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:05:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8OkCv989880
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EYJj/eqr8QHHHAq6NLSO8h7WjDyQuYjBHyH/Hpwg2fY=; b=j3ZhGojFWQL9153c
 DFct0X7ruB/FVFIjmPC0qc+9ZuO6RCzHbPN3iLgkoMhEH5P5MP5hV2sUrYgn8UO/
 mh9XJgNYQ2+ad34y43GKZbmN5FzZRm9DYb7VGJevOCVZtke+2oKO6LW0q1Pl4VFj
 NYdlM/f9f61bhPyXoVyxGFcrvbCYT843VgIlfE/3zzSJ33jlbCquGhGRSMqPL5MG
 FF3gBMy6iyOBWAdx9decp8Shk6fVqAZCXiTReygnUvPCwOq8Tn8ro1Iv5xcVd0k2
 rnRTSpQvkCdCj+gxk598L+MJFxH0X3XF06mwhNuwvL544o+K9YDHVcjtMvvxOFQ1
 IMnMHA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hcajxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:05:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939c30aa9a0so263755185a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889524; x=1792494324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EYJj/eqr8QHHHAq6NLSO8h7WjDyQuYjBHyH/Hpwg2fY=;
 b=eRNAFoHE4/tl+4HepeksP1OK3rlMDOoVF880gnCBfslGTYLeyK0if+M0YRAIpn2ts0
 QTFJI6CDFsy0uaucwEOVM6CeOxG3+xWTjLw0iFQZXqXfehMEWiuTro1rTzC2ux1GXbwb
 is0tBt2DLLmFeitoMq1PfiqHgiK4pMO0V5ko0ZICMpICcPk04xUXcVu8J27/u0lPnd3X
 A/g8FoVF4YZDKKGEFTx31I+fngRaf8v64L7jrVJTSg2Tgjj3AJWO2bk57qXuP3DDUUJV
 25eG4Sj+QWgGhVnl+jnDud13zpRkG1+VqtpRW1EYcJgFbpT41/g7zVjyC3e80Aocy6kk
 0oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889524; x=1792494324;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EYJj/eqr8QHHHAq6NLSO8h7WjDyQuYjBHyH/Hpwg2fY=;
 b=suXjOE9CEaxAJLIHWEfrCEPpOGJ3uqECYHKF99rMI0Lj+EV221SKk24XozrFIwVa2L
 /doX4S/SOyez4qdbPL4jPJE+qvOfs4jDwliUibRTdwiLNonxwPC1qglAUJyhfip+O3EU
 6pmQaCgnplO4pvBMJ4W+sfJlHga+R4etLY2AAr4OYYcRBTNDb6YAFzej+LG78n17nZKT
 hfI8Ji1lJHRo1Xk4lzXJHyVQ6n7ExyTFaPJvYNN9KmGcXzZZ4b1P3wL9Jlu5FTTs/rCP
 bCD674djQW9QX8rQ9C1lx6ddcR7LpayTg9tDI/lpPZrzlPeyKPIVDzrPP0DLQvjt41xQ
 00Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaPK1fcfldnsqA0xXczVkpWJJE5fpYyZ0DzDT5F3glLV7fqWv6qFYdDIQroQUEYRbu0R2BV1GAa+BN@nongnu.org
X-Gm-Message-State: AFq9FYI0pVHN8lLkrymI156vNlIKzACH6MxYKorGbDSzFbGF2Mp0v0Zb
 SKGpmrCpadhNw9E8lCY4F8+OmJU6kF+8L9XIuoG0mCOCxvLSVC3TItJNXkPSxABtPctdAOgh5Q4
 xGNYQExg9GjpNWtRBZ38hYnM4lDj9GNpowNJlzvavn6W+ERDcJkdWYogrIb6nJBOZngU9
X-Gm-Gg: AYBFou1k8cgw9iMhtGl0QW5RS5NdiNwN2BdzHKzfFt8NTS2K9nQYNNhB2vxuMifgnyP
 UGiCmFuuvvHd3l1zHTgPweCWueD/LS03fXK8hJv1M1L2Aeg39Ggj6NAj0WhHQNl5pgRtN+rUqkT
 5vWEqzRp0XznFvPhH8JMSmvU2ka6D+94O/E0ecb/keRSg2MVqc2w9+HGE2T0F3I6GKpzaZBbYBG
 n0P2AolN0XyYHIFsAXpJP29tsu4nEOKPjJ3Z/cMnJf3tvfvaQEBLVmM4v8++f8RvU1cq+otUvfs
 i6dqLhnyIU+x+vAy+F2HBBoYKqvK3wdt2Ul5vSQiBl63SQ983WSvr/0BxBpYpe+VrG5Deh9yM91
 7tGZsvKX7YAiYG6frsHQPORYttD1kZoJKig==
X-Received: by 2002:a05:620a:2b8a:b0:93d:78e0:30b2 with SMTP id
 af79cd13be357-93ebd210a33mr1912990985a.29.1791889523744; 
 Tue, 13 Oct 2026 04:05:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8a:b0:93d:78e0:30b2 with SMTP id
 af79cd13be357-93ebd210a33mr1912984285a.29.1791889523136; 
 Tue, 13 Oct 2026 04:05:23 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac52d3sm4419126f8f.43.2026.10.13.04.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 04:05:13 -0700 (PDT)
Message-ID: <58c816ff-3678-479a-b8b0-df1f22a78486@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/86] hw/intc: Move GICv5 register and data definitions
 into a header
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-50-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-50-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX3GPP13++iHE7
 So4hzw+n24OWmz2u17IePdfN4g9ADEfRuOLxkKF6GSFJa98Hd8357xDSj8HRcyw37QSc7SX1TNa
 xJHsvKO2cKTmkdVTMjhD5SkKpBUfTywFBZ+vpxTPXuBgEtVrKxSzPhexYW5O1cvKJ8lXmqv7ivY
 a1fuSd7/MppXoKFQB8ukQrBykmc4AS46NaZfQFKk87imqw6WoEqJJVLS6uQIHZqzPU4BzvcXl0D
 qYXIVdZGhid5h/wWLBk+21Y6ofcFhfOBqenJejJ471Cpy4aWJ2dMwL/wXxDnOFJoit5ie698vEx
 N9Y7hepAnHM3ZS3ND/nNh5+M3qu4pZTYqUDa9lCkSUNxro4ExStxWhc8vm84iVVvXNXA08Oiunp
 l8tP4sOoYuqwSFl+AiLHz+g4E1Ve9KStya1JY5dQUOcyQLJrp5Mmz0ry/XIesgIE/LMl9u/i3CE
 IX1ng5GTKzny9mgXmIg==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6ace1074 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=D2GPF_12Wmj2I9D7mq0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FrR-gfrGzQTg1T72bS4ADHGeSSxrjWNm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NCBTYWx0ZWRfX3liK+5uep1vv
 NR8yxPrxqttgwnefjcan+/wfHDulgA9p0bn7OCeGhi0lJCyoYbX3HxDuxjGYFafWTm7UDLoFBrA
 jUh/DV40C6YLWVZE7seunKz8Fh0oMFk=
X-Proofpoint-GUID: FrR-gfrGzQTg1T72bS4ADHGeSSxrjWNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130044
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

On 13/10/26 10:38, Peter Maydell wrote:
> We put the definitions of GICv5 IRS registers and guest-memory data
> structures directly into arm_gicv5.c.  It turns out that there are a
> few cases where we would like them outside that file (for instance
> register reset is handled in arm_gicv5_common.c).
> 
> Move the definitions to their own header file.

There are pre-existing typo worth fixing before moving IMO.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c              | 270 +----------------------------
>   include/hw/intc/arm_gicv5_regs.h | 286 +++++++++++++++++++++++++++++++
>   2 files changed, 287 insertions(+), 269 deletions(-)
>   create mode 100644 include/hw/intc/arm_gicv5_regs.h


> -REG64(IRS_VPE_SELR, 0x240)
> -    FIELD(IRS_VPE_SELR, VM_ID, 0, 16)
> -    FIELD(IRS_VPE_SELR, VPE_ID, 32, 16)
> -    FIELD(IRS_VPE_SELR, S, 63, 1)
> -
> -REG64(IRS_VPE_DBR, 0x248)
> -    FIELD(IRS_VPE_DBR, INTID, 0, 24)
> -    FIELD(IRS_VPE_DBR, DBPM, 32, 5)
> -    FIELD(IRS_VPE_DBR, REQ_DB, 62, 1)
> -    FIELD(IRS_VPE_DBR, DBV, 63, 1)
> -
> -REG32(IRS_VPE_HPPIR, 0x250)

Pre-existing (or maybe that changed since previous releases)
this register is 64-bit.

> -    FIELD(IRS_VPE_HPPIR, ID, 0, 24)
> -    FIELD(IRS_VPE_HPPIR, TYPE, 29, 3)
> -    FIELD(IRS_VPE_HPPIR, HPPIV, 32, 1)

(thus the expanded HPPIV definitions might be wrong).

> -REG32(IRS_VPE_CR0, 0x258)
> -    FIELD(IRS_VPE_CR0, DPS, 0, 1)
> -
> -REG32(IRS_VPE_STATUSR, 0x25c)
> -    FIELD(IRS_VPE_STATUSR, IDLE, 0, 1)
> -    FIELD(IRS_VPE_STATUSR, V, 1, 1)

[...]

> -REG32(IRS_MEC_IDR, 0x340)
> -    FIELD(IRS_MEC_IDR, MECIDSIZE, 0, 4)
> -
> -REG32(IRS_MEC_MECID_R, 0x344)
> -    FIELD(IRS_MEC_MICID_R, MECID, 0, 16)

Pre-existing s/IRS_MEC_MECID_R/IRS_MEC_MICID_R/ typo?

> -
> -REG32(IRS_MPAM_IDR, 0x380)
> -    FIELD(IRS_MPAM_IDR, PARTID_MAX, 0, 16)
> -    FIELD(IRS_MPAM_IDR, PMG_MAX, 16, 8)
> -    FIELD(IRS_MPAM_IDR, HAS_MPAM_SP, 24, 1)
> -
> -REG32(IRS_MPAM_PARTID_R, 0x384)
> -    FIELD(IRS_MPAM_IDR, PARTID, 0, 16)
> -    FIELD(IRS_MPAM_IDR, PMG, 16, 8)
> -    FIELD(IRS_MPAM_IDR, MPAM_SP, 24, 2)
> -    FIELD(IRS_MPAM_IDR, IDLE, 31, 1)

s/IRS_MPAM_IDR/IRS_MPAM_PARTID_R/ typo!

> -
> -REG64(IRS_SWERR_STATUSR, 0x3c0)
> -    FIELD(IRS_SWERR_STATUSR, V, 0, 1)
> -    FIELD(IRS_SWERR_STATUSR, S0V, 1, 1)
> -    FIELD(IRS_SWERR_STATUSR, S1V, 2, 1)
> -    FIELD(IRS_SWERR_STATUSR, OF, 3, 1)
> -    FIELD(IRS_SWERR_STATUSR, EC, 16, 8)
> -    FIELD(IRS_SWERR_STATUSR, IMP_EC, 24, 8)
> -
> -REG64(IRS_SWERR_SYNDROMER0, 0x3c8)
> -    FIELD(IRS_SWERR_SYNDROMER0, VM_ID, 0, 16)
> -    FIELD(IRS_SWERR_SYNDROMER0, ID, 32, 24)
> -    FIELD(IRS_SWERR_SYNDROMER0, TYPE, 60, 3)
> -    FIELD(IRS_SWERR_SYNDROMER0, VIRTUAL, 63, 1)
> -
> -REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
> -    FIELD(IRS_SWERR_SYNDROMER2, ADDR, 3, 53)

s/IRS_SWERR_SYNDROMER1/IRS_SWERR_SYNDROMER2/ typo?

> -
> -REG32(IRS_IDREGS, 0xffd0)
> -REG32(IRS_DEVARCH, 0xffbc)
> -
> -FIELD(L1_ISTE, VALID, 0, 1)
> -FIELD(L1_ISTE, L2_ADDR, 12, 44)
> -
> -FIELD(L2_ISTE, PENDING, 0, 1)
> -FIELD(L2_ISTE, ACTIVE, 1, 1)
> -FIELD(L2_ISTE, HM, 2, 1)
> -FIELD(L2_ISTE, ENABLE, 3, 1)
> -FIELD(L2_ISTE, IRM, 4, 1)
> -FIELD(L2_ISTE, HWU, 9, 2)
> -FIELD(L2_ISTE, PRIORITY, 11, 5)
> -FIELD(L2_ISTE, IAFFID, 16, 16)


