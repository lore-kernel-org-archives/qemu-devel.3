Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45891606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUArxpA0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TNi6l4Ci
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT47f-0004d5-Pb; Mon, 16 Nov 2026 16:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47c-0004Vp-VX
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:17 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47Z-0003KK-7t
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:15 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfERK3504896
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nVn59gGoN14zgNNXTxHbymc8ZCFYVALKO9nFksu3NoQ=; b=SUArxpA0v44I/8wg
 E+z6aBF0gx1H5zRtGAS4MKKRqCUIvLbSmDYx4G29QdtZL0jYtS9ZdLjLBbrYd4ai
 VMmqLM9umgfKJrkNSrch7x2cLDYClEfQnHGEpfsN/noxaffaLlOm1xNh0Z35fky3
 imqanoaJi7wUZkxdq67gUU4hwKCk3SbrRpPH3Jm9+eEWbzNhN3f6Sl5i5tZs0dsU
 qqdqPvBG4a+dEaYeOnjM0BIsyHy47AietXcmYIk4TZAN2dGfUck0SRE6/KnCfW9l
 OeBWBUWGhVjb1cNuOjhZzMDVuZdJQ9u5aDjLqNQHPJBCRWk4meyz7TghZ32eeqyG
 Qa1FyQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038m9r40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3564167eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864010; x=1795468810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nVn59gGoN14zgNNXTxHbymc8ZCFYVALKO9nFksu3NoQ=;
 b=TNi6l4CiouILdW7V80EAVzLyrae8zz8q3A7G/slJI1FEgz8YpYI/bXhk3huMC/v/EJ
 NsYXJNDAgGdT5Mzyi6aAGBQ//wcQ68ozfnnyK3VnUD/JC9whabFeW76edtjRH6Cb6zKu
 1B61r6pW1krnqIJRu3qwZpMECTZZ6dEVTeqC/BUYAPAWgEHnxKUWYe2CZbvlf7+npLIa
 Yy0nz++Xf1C8IOa8i6uyZuJSwXjhB2nbwKOMcte3Gr0Ag9utihNQ3GW6L/qlTT6xK3kJ
 ViQKJQYzy54XoOAHse65IQqsjxkqvVy2mGwrJNDDeaVEq4ujgzuX4GuuAbjOIfDyBral
 0yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864010; x=1795468810;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVn59gGoN14zgNNXTxHbymc8ZCFYVALKO9nFksu3NoQ=;
 b=R9Sp6rC9272U5gNqwhTkPIE3Pm9mgcnQ8Q3SZxj8JxScUCml8CCZ+J2zOTV6X3aVM8
 bg4PP3kYnhsk2xreHav1+z0HEIb4algSdNXFCtlGp+SqyF0u2SpB11U0dCdxbLlC1PW4
 d1Up/VJzJxZda4i2GVBInSxA1Pc6x3lMxpHBZCRRUQlpb+4irwRVpGt4ShmVbU5KqF6u
 LTUk2F1Ci4MMV6dyS/oxithAay7TbTsHlqhl3cg9fIuvF0zQy7L1q/D3k67N9SpTnO+T
 iBAyslOnvnOcd6GG+MdzVpN9yBJLw5DvQZpXFO7Cj3q++oYlTgbnEwjtFq+YbdHMH/cJ
 HvIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEJkW1Ejv9h4HbpYME1LZbCZsVyuOBjUOmqCZ4DI0uNLNVaIEogWsYRa7E3lrCHkhSvYTsFD2H7K2rZ@nongnu.org
X-Gm-Message-State: APuU4Z/5y1OwtkhTgVvIgNk/pYn9XktBfXU+1eaLltZ6sqn13Okycf9C
 6iM/cQkVgGH19q1pOTAQO1zXYau/3gYSlsZaCYZhnedxd9KaeZ7OGlDBsrOW82VxQ+bHC4H2VBF
 zdlIBaDjd6NH/d+ryUQjzV3FcLm+jPiGdya/BO5e9lYPEjN7OFaBv17Nc5A==
X-Gm-Gg: AZFdTZew7mNmu35VCXNidrP8aXCXseTQxS1DwyJu7/B4m94j8vZIxSeTa+pcy8rbDsM
 SacxdvjzLlYrL2vAbIXYdvGPVj7CchB19CEyNqe/kR+ftfKNO25dwbdGA2z0G4iZwUoyHu15XG+
 Bt7IUyjPMc2bvoIOjC1cUZpr7bXqHdvwR+H6jtshS8mbO5SrW+LPAyv8FfJNkHdHEJ87k5soyrz
 pJ0whI9bQ24S9K3NiDzrl/SIP9XMQAr+qQ6UGfw7Ykp6xeP3Ax7kAZ/Ne+H2ABwfRri+WjyPJ5m
 yDIntVBGX8lnmTHruId/cVI/FF4qdA47h49826YQMjtIpnCN438PWpRP/qgU5qLgC70GxMVtCNK
 ISy+ZVxxEzxhb72s+7je9K9t1GTVU8u2038knYiuNtaz7/RKm24rRFM7g63GaUul5gw/PIZrWMp
 LYtjHQEqtvtwoPla33g4y6o9KeBHh83UMztPp0ZEGGdmc=
X-Received: by 2002:a05:7301:fc0c:b0:372:32a1:b384 with SMTP id
 5a478bee46e88-379686a7dcfmr11036685eec.33.1794864009724; 
 Mon, 16 Nov 2026 13:20:09 -0800 (PST)
X-Received: by 2002:a05:7301:fc0c:b0:372:32a1:b384 with SMTP id
 5a478bee46e88-379686a7dcfmr11036671eec.33.1794864009052; 
 Mon, 16 Nov 2026 13:20:09 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm35450830eec.22.2026.11.16.13.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:08 -0800 (PST)
Message-ID: <08861cf5-89af-4e3e-be21-86cbf62f1832@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:20:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/48] hw/riscv: rename the 'virt' machines to 'riscv-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-24-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-24-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX+CUquNg2vv+a
 GQTr84cUr8VxFmFe199iji3Bjlbo6UqbIM7kNZ2syNSFqdb36gHPSP91sN8C4pEEx5XAPeyUkIX
 PdvtbJxzmLzs49Ysg/HK7l+gDTVvrix+EbYMW4KM/dlb75f4dwIPjccXHOuqb7gKc1tOSruvitJ
 j/z+gbUXtotBi4V5RC8mnTIdmI4Jk6My7DqqLUojjYgHcwTaDCvWiLa/qj71ryouofIgpHO/nIH
 eMZHejWTimeOekRVaaApMcZbjcCU1k+CWeNlzdU/0cgZJhEwUlTdgRq+hIELaLiJpvs6U3GcmVk
 ebe87Lq7Kxbr1f4eRbAmrrU/JOKcZJJxJD+w3EWsnXRoSCmoXp/qH5jdzp9m8kn9y8UPhn12+B7
 SsKnfttpOEN1GmGaG/661hJUKk80fVrb6VuFDPh2agR0vHCcfXQ195wExLROmRN+OyJLliLf2dz
 VGO7IMuDie/cR84Tqwg==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb738a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vX_OHtA2jq_LGBKDobQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: uFea5hIYhoOrrmIgTJrLTGeF3f2eAwCL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX5sNSvl+ZxKmF
 mmRVgDaaZRaOkGuZtcubXXVGwK0AHFvxFr2JgvljD6jXk24sVfDH9bHQcT72ovySKtGg1NDUZ8v
 CloVcT2ftdwHIGPzUC7TyMiovWRIAxc=
X-Proofpoint-GUID: uFea5hIYhoOrrmIgTJrLTGeF3f2eAwCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160084
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This introduces a globally unique QOM typename 'riscv-virt' for
> the virt machine type.
> 
> An alias is added to resolve existing convenience name 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/riscv/virt.c         | 9 ++++++++-
>  include/hw/riscv/virt.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

