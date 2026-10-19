Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C795606A334
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bAgwA5Yx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EK+1rEFw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIveK-0003Sp-1u; Mon, 19 Oct 2026 18:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIve7-0003Jr-9c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIve5-00023U-MQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZaMQ282676
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IqFZDxNq9rZ2Pudh2s5/tQLCK4XsmdXWCp0ohNog2ic=; b=bAgwA5Yxbu699eh2
 OER/iU1Bjm/9p+Rbp8GKvmATvA4jgcB40chv3c6EC3tboXGOGt/70lzxaia8iVUb
 ORES8OU5Lcr3/6r5fmlEtWCYJgh9HCMgLZBG9FgDzRwZRNOotBV3UzRoRcFqKrtY
 hK11fLlQBTAtxoKzjdZeQB0gDEMIInjx17ixVUQHjI8weNLmo7Cpn+8c34E7zZD4
 keqU8bJGwXYQszLV7iAVoCFD3EJriUNGwSzX+nNvnKJ5rBSm5Sq/K8wJfwPRuzbe
 Sr8IlQKHFhr03IQmcKMfDp3gz8UXA1gXgDFjPoqQSVvWVQtUMOioDbhLuRYUNMh0
 KKkV5Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48ke22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso4054148eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448151; x=1793052951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IqFZDxNq9rZ2Pudh2s5/tQLCK4XsmdXWCp0ohNog2ic=;
 b=EK+1rEFwfgibbitB5aNLtbHROF8/cwj19+4TX1yIZkzG7yEchKx4LU8nYXf2YOzDDf
 jZR3SDMwJYGJCCGvCo3omlgb+m6X+Nbna17pSO37sRut2L1zwhrwxgSqzFvG3p+zEBle
 wB+VoH09jviorHpw67rscgTnbeIZI7MhOdhfGQ0k9gEouzUV9StfupBwFr8K2e1KOCbU
 qHq6zUhOMpJpMieOhavDoI8xnzEwCoOOsWhwsTTJNCu7SDSlPxZE79GGnj5TqxJqvm2y
 ioXFrcLM4WqIfxJpI+h2mTzAMB8zjVjRdiE96D1q8vCC3FzBNG5t14Q3BLQLi9NhXM40
 bJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448151; x=1793052951;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqFZDxNq9rZ2Pudh2s5/tQLCK4XsmdXWCp0ohNog2ic=;
 b=aV9zB5SVXlTZJ725WqBXPDqKIW3cUn9v2e98A1lSFx1pHAHayqLlTLXUJ5hYLiMGHp
 GkQidlsTIdb245FTlNd90z65E0T24bqpCYslSfegkxcsvNkfc+7wBaN3Aqfd9/nXX5wH
 xPg1ojmhCX8YNrcxDj88IhF8PsxbsqGdcVVw2LbceMZq0DscGwRp7+94G5ZsRLCFKYqs
 tmnt0OeBj03cobSjRBlfpB32kKrsoNWsfb70B6sDbUzWtmdUvYAjVZTvV2UaU0ywEy2m
 xtMvV18uxt4i/CFMwAIMqpPtfE4u5XD0x0MGf+D+EHIPKAmKDBBQ0QoXScwWbovHafQI
 qvug==
X-Forwarded-Encrypted: i=1;
 AKwUvByMluOEUOVQrm5GSLN6DBk7Mc8JA+BKrXCNaQp8Ooa27t3z1uZfcH7cnWRdiCVieP4r9DOf5ZDc1SIL@nongnu.org
X-Gm-Message-State: AFq9FYJLu8krnW9PC+KmZjOKGJPfRpE0fbrLZnVpOEYgigXE5u9xERXE
 nWBOAouai3O1jyzlRaRjMui/WrkOvj7V26fucejGyWabwN8S7Gwouk4BIItMzFLVBFYjxF1JS0d
 QH38h8SHv3FB7YVLXj7LUM/6fMr1wqkG3URzA3vhwLSZbWna0DyuOigYIng==
X-Gm-Gg: AYBFou383SSvLit1ZoojMeqO8HuiFNC2fmOT0CGevSq6OHkdeOwbE0NGTV6ac/DyQFp
 MpmZCuptN+coLxrMAYMOQLLPu09DhGTNIdeSoI5lbgm9qQ5Lj7TH+J36DT4gAs7UVREVuYtnwOD
 /lwa3Sp7AEWBjxA7jCpwLiR8ijHqgLWPxM+9sfa7/40vdmJs1hlEGfibdSRFrfTFZ1IZYr7hzpp
 VOPJIitqEhX/h8mmT9jlrbgFzLYvKHk6CWqZ2+/oiNGsQZp/MyVVb4X9JGS8gBt5LO/HjJ3ftPA
 5gkTtijesQgd4YqIbBQ+3auJWOyY/fSdJ2+Ow2JaUsTDX3wkzAESDeTSbQLlCSBasJIr816hnxb
 V7isaUHXG4QwjUC3YsUfg3MtlWGCvxHMEtI5wDgbM67HRutPaXB5OkpsrI3TMAMLt+QbXQw==
X-Received: by 2002:a05:693c:638d:20b0:35c:2261:8119 with SMTP id
 5a478bee46e88-361a1668c04mr12468587eec.6.1792448151435; 
 Mon, 19 Oct 2026 15:15:51 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:20b0:35c:2261:8119 with SMTP id
 5a478bee46e88-361a1668c04mr12468560eec.6.1792448150922; 
 Mon, 19 Oct 2026 15:15:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm58453842eec.28.2026.10.19.15.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:15:49 -0700 (PDT)
Message-ID: <59b568c6-7a55-4aef-ab4c-760863f226ad@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:15:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] hw/hexagon: add the SA8797P NSP0 machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-10-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX0cbBRfQVYiVi
 yR5ys484H5P1tuK7OQgTTyXDSEeeo6fXOqJ88G/AGj3DtPcuvQs/OKadvEG4b4H4SKSnOgSTGkg
 UCbeBHHGmG39+sZ8bzNYDGxANxEiitgiFPcq5af2NGh9Q+l4WD8oxBC+GtE9JC+x4ptsEu7oZ+D
 3o/ayZvZdht010i8VIvDzncnypkGOrjulD9h46Bl/Wttw7xsiPEkovRSRxvftsmIY9+BvwWMp2o
 twb5bKtX9+dP5XJxx3Ds85TWqJUBSzwcp3Xe3FImXh6RNo1WWJcQTHNf5py/mQC0vUt+IJoL1+j
 FWZ1dAFh87D79ZpMIunj1WynjIO5ATbcsRhOdSm5oZc2q2/Ik8c5yVTq+SShAB9GVKLswWDJBep
 440mbfLjHIPDHyhNEBbP4s44AWCBj9nkaiUnour54qBQG4cTqe+Mhp90wsX64FZ73eiB70MCbPs
 ip+KpXzMcpBQ1mB/Hkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX34nBEpeW/24j
 joKq2DPFCPzRIN6404ChFpbOhSrGbxLHUcooP5Ppfy3sAaueiji3QzgPAndoFrALYW2Od2jM9bh
 +TbxcDR+cq2Xlzm+KyIH86s362fi/ac=
X-Proofpoint-ORIG-GUID: KTAED12889CkZgbCRNFgsRVVe6QH7SyC
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad69698 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aRA2NF8V9sjL0fxTIJoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: KTAED12889CkZgbCRNFgsRVVe6QH7SyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190088
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/machine_cfg_sa8797p_nsp0.h.inc | 56 +++++++++++++++++++
>  hw/hexagon/sa8797p_nsp0.c                 | 68 +++++++++++++++++++++++
>  tests/qtest/l2vic-test.c                  |  2 +
>  tests/qtest/qcom-dsp-test.c               |  1 +
>  tests/qtest/qct-qtimer-test.c             |  2 +
>  hw/hexagon/Kconfig                        |  6 ++
>  hw/hexagon/meson.build                    |  1 +
>  7 files changed, 136 insertions(+)
>  create mode 100644 hw/hexagon/machine_cfg_sa8797p_nsp0.h.inc
>  create mode 100644 hw/hexagon/sa8797p_nsp0.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

