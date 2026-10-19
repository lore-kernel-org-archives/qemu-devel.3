Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFF606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T1niKW8u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MnwqMPLH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvdX-00034I-No; Mon, 19 Oct 2026 18:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvdV-000343-Tg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvdT-00021n-V9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZg3k2457962
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gt3EPLpAUxw8RZNRMlRx/RqSWvaPYB8UhDduSw2GEYU=; b=T1niKW8ueVQvSZS0
 HEz6/VHsIPdoFAND9I21pmib7huGqppNjPwu9n5RPXlXEhq+GHVEKModz0fynM5Z
 TR4es/C6ZOso4Kwqvlko9UJSgSPkGZs8LAbTuuOTZvCl5bmW/bufDaGl148iacY0
 3Meg6JVe/moYhWdJXNA/hsAcWToDyraiMCpIXC0A30HQNMpdQx2bKJWrKA9pyN6h
 OQ0Z1Utglvaxhfqsk1n3ffwzmZcHG8dDz5wOpGP4H2jB/t45d+M3GcnPL9TRgPUs
 sBF58MrdxKDXwzXMUruAO6cUg3mtpM3+IJpH/m4j7CYKeP4OnCT8pGqpByXQ5a2l
 VkbeWg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kfsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so10013583c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448113; x=1793052913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gt3EPLpAUxw8RZNRMlRx/RqSWvaPYB8UhDduSw2GEYU=;
 b=MnwqMPLHVaaTbSmKdSAQEUaD+xJFHXT5Ot4Q/8QOkk+RUoWW/hKnbr7huYufrd+DzP
 DeM3J2CmVotMnomy7zG4n7KTThUmncogVLpuYwTBQGxOnWfgmwd1Wg2RIaigrAkL91C0
 +KWytOka7Z7uarPGIVGRoJ+9xJs+Ti9AW8Z++336LzHpuSdnX7D2KeE5Q10Bb/RUJMar
 ksfPCzhXvXcJNn8nSCP/S9AGyFBHfhR3n4eDTmUgHzQKeq1k0nL5bJP0aOAaHK6dImma
 SC2bddIA7Haxzlr9HXFSNOacqKPQEvBXuzwTgboMnB+9g46Q3kgljMvqO7RUU23BJ0DV
 EqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448113; x=1793052913;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gt3EPLpAUxw8RZNRMlRx/RqSWvaPYB8UhDduSw2GEYU=;
 b=ISRFVQL1SZ1c+qTaiatizYWtStNVM0EimjWD+o1H4uPmNoOX+LJqcWg56s3Pu/j/AM
 3LEQs5SqXNaP3jJqoHCfqHJxKhHFnI9dZrRxskKK58qiYSzmXj3tdUYZhhcT0zMLa3u/
 UtQLHp6tbZPX7tmEOT1hnnSGD1+o3F6pHW71uLHjK4RO4sCslSjam4jQsjtxI2x5S8nj
 +77M/STgRpsljtTwQ69ZcOcz3o6xfi1TKVD0f2NRds72m6DpesJcX9xh9t/txFLdJ7J4
 RhewrgDBBnU6tnJoQPWGCKrcYUR07TmMppI85J8cx9nhpfz2ZxbbvLg8zCOL+yxCWaDS
 xHaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBztusG4JGJzirGr3v+LHEkAgG8cqHD77fKdaB+3J+wS6pmkf9JS+I1ql6Smik2Ef48owvzXAzZWCHlA@nongnu.org
X-Gm-Message-State: AFq9FYL6oU+mbFJfFuypiJPTI5805WNjWpQTYGduXodTfOTg3DHq9ghW
 S+KdHUap6Ep14XNywC0+IBr9+o6mR9NhTTrMY5e0/ne5BBQ6nLpPnCreh2Y/c9GYuD0eJnAer3w
 oEWT4+5EriLSzH/RtT2v3FoyGny1IJFQpSkUPM+bzRsFlw4Q8x1B+8AO7mA==
X-Gm-Gg: AYBFou3tvPg2KKrX0rAvhQtKvr5AIxnrnxzA/0fuSzbTtbyCauTbZDr0eJSqPZH3lDu
 ZiBaJcLn8iLd1VZz2iSrBxw7viM7TtEbeq0c91Z/jOfyUGa/dQENQ7mu3MXZEqtzKtiFyMzzDjG
 kSvB4TF+IXyOqjValxq9n3YMkyBT/UIv3KX2+5nChs18+/FwnymlRi2EsubgzrOIZKClCgNl3wc
 YBMwNKIanqla12kdFqxkuVSTQJv7XedQ3UJ/uBG2rDtuZi9hYnYmRw7X2s8IO6DDf8YBS6meGj0
 FcAvgVKcmr/M/JpQ2QFBwbKYk9xuQcb2maHlMscEtcbZS1oJgCCstTNW9slwK+RlCCEv6TAycFS
 ZosjS2EVvBvmzRIVcQ7t23G4b0XUXl6XCb+qvmV/DPpMOMTR4c66EGYP9BXUDSQIZZ1f7yQ==
X-Received: by 2002:a05:7022:158a:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-185136cabbfmr20810776c88.27.1792448112880; 
 Mon, 19 Oct 2026 15:15:12 -0700 (PDT)
X-Received: by 2002:a05:7022:158a:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-185136cabbfmr20810713c88.27.1792448112189; 
 Mon, 19 Oct 2026 15:15:12 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6e33sm36689394eec.7.2026.10.19.15.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:15:11 -0700 (PDT)
Message-ID: <3a306748-03bc-42f8-a9b2-4a163f77c91a@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:15:10 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] hw/hexagon: add the QCS6490 CDSP machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX63v7/KHa+hVG
 3ObkN/iB+bTeIe1pl2uls5pbxfz3jMMyBy8sRDaFQQKyrAMf4E9Sra8z8EJLrH7fFkALVtoUa2a
 TRmPn0qtFTiU+zY/1rB4bv1Hf/NS5Ww=
X-Proofpoint-ORIG-GUID: N7qjVQcbAsFajov0B181fppmy8MzP0sV
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad69671 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=IGqZghy57PC9R_9TggIA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX46ZKNZn8y8O7
 wrKyTW79T5Rv8nvqvZJVTmfclIwHt71IhEGuiHBtwnRmbIvgMfTXURn07idmmTEiS6bolpbVM28
 LbinO/6pkZySFHIJtkl+4NFzMx+7ye7JtEh43d0pcylkiDWrbMaM+SdX4sSFOND/La6oKCNshzd
 RZEb7rrfBXDZ5oh55hbc45aL/gkBzl5fifb1Wnpj4tVZ7x4bUE8PDQuxbamWkskRMAHxMmnFnbH
 8rR+w2QR9XA3BySkJZPUITYOrekVt2HSQf8nGUDVZIwc7n5AlAdkvMOeLL2yWDetQOAqTIjh3e5
 8dewLJn/Nkg7k4XEB4BHiZt+B8yN14ZV/CnuX8sFW5SYqWdpXZzM1p/+8w8gxhL6fRdui0oADU7
 JvWX0P8XabQtp9/RUcB3GH58CJMVGQ4Rpj/PVx6iozRatJd23u4fddR2x38uqB9z2cHCTMbMX9O
 5Jdvj7jB15xIcuaJcfw==
X-Proofpoint-GUID: N7qjVQcbAsFajov0B181fppmy8MzP0sV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                               |   1 +
>  include/hw/hexagon/hexagon.h              |   1 +
>  include/hw/hexagon/qcom_dsp.h             |  81 +++++
>  hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc |  65 ++++
>  hw/hexagon/qcom_dsp.c                     | 399 ++++++++++++++++++++++
>  hw/hexagon/qcs6490_cdsp.c                 |  64 ++++
>  tests/qtest/l2vic-test.c                  |   2 +
>  tests/qtest/qcom-dsp-test.c               |  93 +++++
>  tests/qtest/qct-qtimer-test.c             |   2 +
>  hw/hexagon/Kconfig                        |  15 +
>  hw/hexagon/meson.build                    |   2 +
>  tests/qtest/meson.build                   |   3 +-
>  12 files changed, 727 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/hexagon/qcom_dsp.h
>  create mode 100644 hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc
>  create mode 100644 hw/hexagon/qcom_dsp.c
>  create mode 100644 hw/hexagon/qcs6490_cdsp.c
>  create mode 100644 tests/qtest/qcom-dsp-test.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

