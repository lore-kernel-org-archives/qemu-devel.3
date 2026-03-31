Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73A010F9304
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 22:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7hCF-000601-D1; Tue, 31 Mar 2026 18:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w7hC4-0005xv-Kn
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 18:04:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w7hC2-000272-MO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 18:04:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VIF6PG718546
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9eTFejE88BgLr4eSQi6yaNLoVr9AG5pyURCDC6O6aMc=; b=JDa2L/vzseFri3j6
 O1Oo6Lp/4xq2GdrieJX+j3gII1IRAx60sVWFAdH80j9yNx+N80Cs0Q4CKk75Ar6J
 vKGedS16PT2seGU56dbnGzW/MYg62qJebg+nVuvh8UMsa9w2Y5dmAXK/WoMIF1OJ
 vB+go1G8Zz4Z8W7A2hLWQBveF2M5iEknXnalmpAde30MKfKfT4dfsnS63TxAFhTx
 EMVRdvh1ksJsfZY47SZ2/sqfSGTomwLhKHITxt2czPOKUelvbV4IGi3vSsLePOAi
 MiPHB4se6IyYLbs+6oZFkiJS68y/7jks3yQa2A308t6q86YZ5UsF6ZFjYtFK/9mV
 vS8/hA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcsry88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:04:10 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d496d080d8so15090439a34.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 15:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994650; cv=none;
 d=google.com; s=arc-20240605;
 b=iHzL2XPdpw6w4y22/gnwesNHigKjgxGANVkMPPdUSL/rQ5cedG6uDKL14FDrAV7osy
 WnjHTqfCgvmHMpUwH80PE1zeL63cAs36D8+3gmJVZrpXHd+wC6E6dO7oPAtdzVn32IT2
 dcG3p4+TYHTxILFpf/wuaSaU+LMTSjN326eHMAm/T4WStMfsoRB//0/Jzq1fRO6NDGmP
 +WACzHPshJMRbS4MnnS18S7eFEUblC0U/5bBW/+5yQ8vOhd0BSn1FM7DCmCwyTR2Rvy+
 viDiyz3vOfXOXRAvgsqas9jgS6oaBKHt295g3A/sSg/SVcOHQOW9ywq3aL0qaJDaLoqW
 Y9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9eTFejE88BgLr4eSQi6yaNLoVr9AG5pyURCDC6O6aMc=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=RL/cP21IZu7t7ZBoUJlj+PVkWAW0Z2lpDkIlthZcf0az0PTljMKmCBwWlig7upyI+l
 YehEq9xkT+yv7b0tO6u5nov9XHwzhpKXsHyssdPO6o7/JoQwFttRyCSJeygh9Oontdb8
 Q3YlQfcqASxW8sxcf+dspyG9uq1hV60pTy/YE3X7QH7RimB6sLzXfmZLSXcEwx05hp9X
 IRgOi8Z6g4EW8wHASmdHsoBpCrYekEQRRy/kR3/0bWE9s0FdXzFODicnXw05DZwwTFOr
 8ZussYGnx3Mvr3CCEvkMOpQEzJtg/MwCMXxRR3NyTE/Joxq3UvFmCwykTve1FtHYlFI9
 owBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774994650; x=1775599450; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eTFejE88BgLr4eSQi6yaNLoVr9AG5pyURCDC6O6aMc=;
 b=JdLr8mfyo1JdMV9jZXElDh72BNdvT2dXhx4UfXHgwPf4Z93k/2zlZ2QM9bUHfR+4GD
 UA6K2y21c2Y09JqbXSN0bCjOOIHwnuaF+MgAhDnTiT6Jm4QNjLg9/6hXCPfWSceW5qW8
 BM6evSglMe0MZiYFy8OpUwKYP2hW2M8vDAq8maR90e/WorPRN41XhYhm3F2teMARlxNh
 L2vsYGx0fZq/+ZGXMJAJhg242BflkHUVsKqZdSbmJ0y3Lusluvza2o/LL1IemTynfXfK
 O2BxIjiLvtLOytrFOi4r71G8//sWeQXABamE2DDGZMUNbLLmmJFiFRDXi6gjgbQQDJ/7
 VCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774994650; x=1775599450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9eTFejE88BgLr4eSQi6yaNLoVr9AG5pyURCDC6O6aMc=;
 b=hv2B5cF6GqagtICbqpMnhOMX+rpYGAGwkCs+9Q1c8/6tUZWvEeANW4ddjO1ZpccN2t
 2tZM2gl0jBOzwqJxva6rIQN2+IWtqx9r/mNNjPKaH9NSDdVidClCaQS839jxJUOzpOFL
 V9TomTCuPTasEtGgpVjAS2P4QVjvl9QYlxpkzJzimHlAZA8acbIWM0OC+Z2IOpi0UbDO
 n7QnZpbC2PFoERP8NtPceSeduj5yDRD07dYmRYkvoI8OjeteCfYzLV8g8afO3KnT8uAk
 AJfQC8PkcHvfZOjkgxyvuxwDI0j9k7h1+Xi1we29rVq8n3t9KCQzvjrA5gjfwCtfmcMr
 GMkw==
X-Gm-Message-State: AOJu0Yw7V2vJgmD/zZD8/a95rcp5tbKUV/UsG1ls3NFJRTmRBGoMvj1X
 mQ5qxzbtR2MB4txlXhJzptxkCa1AKXEBtScJYf/omhTZHTvwqfRYdkV38RpduJdws9n4mk9XhYn
 8PkEVwWNdCB7gjvSPfBEL1DDIQBY4Tj+q3kp50nqmPzlVzr4ABAlffsigWz5/dsSVYAT/Ovrr8J
 /630ujkrg9QZHoe2iCtqQXVG9WcmRPy29X
X-Gm-Gg: ATEYQzx37apmIW7NisI9+JXCKIfqAssql9NrSegPkt6KlwBnaZAeAS3lfBXrGu0iGnd
 hWExNm9q/OWqIEk3BIVPtnrYUg4DNV+gQmoAVZFhLIcwq/bUiNib01wjVUTwWyTF/5XCDjxnhwr
 36YOzwiGrg9U/LkMV5j/cIJNroM3Fpj2ET+GlERJe2B2nZBtALgO0Yr3iHFiSf/CBVjA6nbCcyG
 DBlkN4=
X-Received: by 2002:a05:6830:83bb:b0:7d7:ccf4:8dd4 with SMTP id
 46e09a7af769-7db993bf922mr809532a34.27.1774994650052; 
 Tue, 31 Mar 2026 15:04:10 -0700 (PDT)
X-Received: by 2002:a05:6830:83bb:b0:7d7:ccf4:8dd4 with SMTP id
 46e09a7af769-7db993bf922mr809507a34.27.1774994649610; Tue, 31 Mar 2026
 15:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <003328f47c0b5e286ef06ba55cc9734e7bba4af8.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NqVcXGf+ND8KAhR_e78YD8nRJy1_ZL9y-0QBkkQ5rweVw@mail.gmail.com>
In-Reply-To: <CAATN3NqVcXGf+ND8KAhR_e78YD8nRJy1_ZL9y-0QBkkQ5rweVw@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 19:03:58 -0300
X-Gm-Features: AQROBzCt7onyhj2wu7VO3D-uwaLn8oZ9XAcaJMGNLh0tTCDOoidht-FENpSt7-0
Message-ID: <CABrGZ+GQK7Z+vXWR_zKFHYGpmNvPNPvPc-jesKkD5YDXUEe3kw@mail.gmail.com>
Subject: Re: [PATCH 09/13] target/hexagon: add v73 HVX IEEE bfloat16 insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDIxNCBTYWx0ZWRfX7w8q19kH6O91
 83W/Y04XLau4YuWRg9qLGKQp0XMuY2ZBLHMaFlFPaZB1UqM8T3Wf/GE0yuPSgME7xTYknPYn4DZ
 SqZxlm+togSOxdMXIzp1xeF3L/WFTEJJswZTQTyDMK3V2Eoiq80oKFV0t1HLpkoRF8tlXZlhQRh
 sqOF5Ldszju6LMoySmvmqR2RJHRx79+DRa5ZGfPe6vmdquABnCmt4cX9WsvZsHcs/rPmMKThQXV
 uyEhZ29uHVJiptt7k9RBRj63a9XViNuWrxBuCv6mt6eHkceBfaAVrbowfQ+zieDYa2krEgwNw/g
 29J5U5ykWQidSfLHOXO5bA4Rs0WtHFeXv9TUWymNuIFOZv3Z6zKa9fxjHQFAXUjvZw2IdaXPyNj
 4M2+ZZZRSOHsbUaLibArNy3HauYI9J0CBO8s9vmEzXLJqT1JMpscJM5vkJM8MVVtMd5ib6FTMkI
 qciE4GIRn5n240CrZjw==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69cc44da cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=FMVOZK9DQ2HKKJpTbhsA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: riYTeFN4H_YEL3f_ERHgqWyzYT8IM26z
X-Proofpoint-GUID: riYTeFN4H_YEL3f_ERHgqWyzYT8IM26z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_05,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 23, 2026 at 7:03=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros=
.h
>> index c342507d1a..b70996578e 100644
>> --- a/target/hexagon/mmvec/macros.h
>> +++ b/target/hexagon/mmvec/macros.h
>> @@ -25,6 +25,9 @@
>>  #include "accel/tcg/probe.h"
>>  #include "mmvec/kvx_ieee.h"
>>
>> +#define fBFLOAT()
>> +#define fCVI_VX_NO_TMP_LD()
>> +
>>  #ifndef QEMU_GENERATE
>>  #define VdV      (*(MMVector *restrict)(VdV_void))
>>  #define VsV      (*(MMVector *restrict)(VsV_void))
>> @@ -366,4 +369,6 @@
>>      (int16_t)(A) > (int16_t)(B) : \
>>      float16_compare((A), (B), &env->fp_status) =3D=3D float_relation_gr=
eater)
>>
>> +#define fCMPGT_BF(A, B) fCMPGT_SF(((int)A) << 16, ((int)B) << 16)
>
>
> bfloat16_to_flloat32

I've been experimenting with this, but it looks like softfloat's
bfloat16_to_flloat32 conversion will handle NaNs in a way that is
incompatible with Hexagon. I think we will have to stick with the
16-bits shift

