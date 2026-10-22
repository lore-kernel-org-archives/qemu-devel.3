Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAE606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jifKDh4c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AMF6xBz4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2aP-0000bq-Iu; Thu, 22 Oct 2026 19:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2aM-0000aM-Im
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:52:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2aL-00011b-5Y
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:52:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF9iG609739
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 20HmaEhS46IFtG4GHipJYix/Y8jJVTlsXJq2XhX6A4c=; b=jifKDh4cVfdxXmIg
 59S4mqPVWb5RNeAHYqc17LeWhOYM2Tdco3p9bfP9hXSG6LPiIaSvk9kZvvxqj5Cx
 DlUawiGcwGycxgazsXKLYY+++Vs+AOuWzrj7fZYuFOR5irmB02R1qwslhhdy8vwg
 JXybUwRpzjQdcVjyMRdsIzaalKEYV6KxfhvQdtyPkP9DbLYq5p9Iz4VzO/TMhiaw
 Lts82Qe95mWuV/poznrfaDftlFxzUJHC/Pp1CEm6Mog8YOI4VcKFVFY080vTa4d+
 Mg/stNHXi4Xnb249+TYWoe6q5ebppOGyiQ8oSShBzmIwPTLWYmrmvx8mzN26bsUb
 Tsy3dg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahsfrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:52:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3acd21ba24eso227271a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792713154; x=1793317954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=20HmaEhS46IFtG4GHipJYix/Y8jJVTlsXJq2XhX6A4c=;
 b=AMF6xBz4aK3aGn56OgDXhBysJRdmqXtHyOd3glhoPh/FpCPlcUt7oRcoNG1cZGlVh5
 /ho1EfXp35ggZP++CQYQQy49Q2IjOXEPbkn5G2yaslwRrGP2Cb89XL9ivXNeuHMwxQpD
 hG24XzacNJwDcPIG5k62t8HvsTaQjRuAsZMUha5vswpNZoI4gOYCEwdf5HRZWZ3phueF
 QUIrRhvXvQVClw4WOGPVbT0wffth/26mkNlfmSG3oAzurRw1tnUJpxRQlDHX7KJdCHB2
 5i4P36juUnpbt+z0vAOo5eBf8K5clfo6+XT4Bn6w4+BShcNlwc4+MLC4RdKUmdCxVO5m
 vLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713154; x=1793317954;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20HmaEhS46IFtG4GHipJYix/Y8jJVTlsXJq2XhX6A4c=;
 b=l+LsSgPgV65jhjvLUTYl7jneFRnpERA590hjYjOnXK460X/4nqtFkkSOUhiC00cCRH
 PnXfPZRh+T02NPU3FaBQV2I9cnY6u1Q1mgWLRz58149Wre14bFEkNX1lXnzIFWy2c3Xy
 ULXBQnlrGFosOjgYxkFEfa9z/3dztQivv3BU5eBhIH7egYpKFsXlJ2QmQQzJiqBAbpCg
 S2H+8aAP0fpZXpuuGDZSjGHKc6o/V7vAGlfUEZYw16bu2ddDBlcjJm9ZmhltFWDevt+C
 IHiffKoaMhB/XxwyYX1eqIfcbF6sCMeivlf6LafhIrJ3q3x38NY4QPbo1QFN7dvSRbQk
 eI6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0hMaqFc68BEkuSic93UXdnrf/7tnpo39M7vq2wZWVA33yBab1chBkwhPGQRaEg8Sy1W9xFIf4dDUP@nongnu.org
X-Gm-Message-State: AFq9FYLV7iU3RJDio9a2SDnEJa0Tiu4i5Azrwa0BQVzrLU7RrmOhnYut
 jnxK9PmrPVSDu44KjZGqXIyXX/UVBVv27uAbELq+grwiTVUqVrVHzBBgbI94kRLcBEVybgZzVxU
 Odbio9+8ObdOK2PaVJQGOGAiCNxobQv9K7NCeVCCrwuvtbIrT063nmt0ZYw==
X-Gm-Gg: AYBFou1RZN47Ykk3on308dQ67CjVcG3hfwumHz+WKn9ULKrBA3DDgCHnx0h6Rfa2HTY
 0SS/PUBL/tq+2lVofxj8sSClDDBuXKsaMqrrYVRp2ZkuyMJyjwGIh+bbTAmElPwHbBtX6L6/sU/
 +U1Tnsc5FM6asqK94agfEzXhpBVNA/KOQVZNtBfe9zpJNdLvsv5GPneOahAmm+winw4WEN4lJt7
 euNM/3+BxCbqKPMmm2rXE+0hfJy/idndOURqsfaCaFPfQDshyuXReUdZHEbZgKo2GED1olsH7lK
 WL1Yb6Q/L6zPsyOBMeISMRea/rK1ITpThHbYOaKut6f+G8M25EDiXl+ssPVmXRaUaZ26ZJ+yXms
 UqVvJ/IRwdP3SZS5mwi1xe3x6kbmgQaKdMtQITHyNrbLhvwDy8U29jb7jWg2fDt7hccZ08w==
X-Received: by 2002:a17:90b:2e0d:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3adcdfbb88emr416018a91.13.1792713154464; 
 Thu, 22 Oct 2026 16:52:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0d:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3adcdfbb88emr416004a91.13.1792713154000; 
 Thu, 22 Oct 2026 16:52:34 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4890c56sm6441200a91.2.2026.10.22.16.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 16:52:33 -0700 (PDT)
Message-ID: <f5453685-17a4-477b-9a4f-05e78661c74c@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:52:32 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/16] hw/hexagon: let a machine place its DDR
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
 <20261022230048.2160400-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022230048.2160400-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfXyHuRJyG+G8tl
 +9JuQiV7Ye5cw35yIUnanmz3F0Et2BSil5Sjx9wnZVdQp5HPnkIOAgK1SvEReXLtbBAV1ylmEGF
 VZ7FexTi0Sc7avhr2ts6ZI1ein3LwQg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX6ClITqIdiJFK
 EdJDq63W8PyEL/3tatN289jxj+sskccPwH1yVNJglGhOQnROploiy4ijm1+mjVNy4RcJ9PvO4dU
 29VR2Kdw58asgrZO47VIlIKPWzUTO/KalfLzsr5E1lKaw95i+oFp9kZ1ekKk5bb+fmmQE1PqmvW
 lsa6JFryP2SGXKg7jpoYE38z98Ylf0UzxJdcI6Vv6jwnbpPi90luKkpNxBdLVA3i2NTE0HCpvca
 RLRwMW8xKi4G1ZbtVwjVrbnlDf65eN2nPQUDgnj6XspQE/rECQUJjSs3JVLSQvD2cVxsnAqZrJb
 vNfsMuna+1xwMElrzfs3M2vbnVmEjlye7b8pZQQLKuFmmuv2o7aF3EZngUDtfsJSYdPQI5rtOre
 TVL455MsEfuuBqheKAMMc/GCO6khQZLRv8vWtDruH4PVAlTmVr96N1j+BOXMb089rw+87sNie11
 hP+GbALeGZjXFH7cQUw==
X-Proofpoint-GUID: Xc_8BlUVZPatr2Ijvq3ExTk6UmyWGJh7
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adaa1c3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=N6munM_sqa6qoa9lUOcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Xc_8BlUVZPatr2Ijvq3ExTk6UmyWGJh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220095
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/22/2026 4:00 PM, Brian Cain wrote:
> hex_subsys_create() always maps the main DDR at address 0.  This is appropriate
> for hexagon-sim-style machines, but real SoCs map it elsewhere.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h | 2 ++
>  hw/hexagon/hex-subsys.c      | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

