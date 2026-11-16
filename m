Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF5606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ooe+H5m6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZhlstHiG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4AW-0007zA-Jd; Mon, 16 Nov 2026 16:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4AU-0007yU-MP
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:23:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4AT-00064l-5T
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:23:14 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfamw2590429
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rdryBD1ki6izf1sYt5+c/0/g+15gQDX2coAYsXaCG2w=; b=Ooe+H5m6Ysi+Wnqy
 h4cGwPo8Pj4Lqop1b8fkBAX/neX9QJ9AuuG1CUg31VUGggxdlGsJgXMqzA6PcnMX
 ihSDjT9A1QFB4VQxDN9VIf0ClJ9fFaQAk5ALDGjFq022xQriV1D14AxGOgO7FY34
 g0zp7JZTjvMFNwXoE0z3qGL0nhA1p1oWR6UAVjNp2SYxTiiqa5Dz5TF1zsggycGh
 tbt3IPpwKODOhtDxjNE+u65dlHdd0hrSb7TZyeKjfQpL7Nz55h4ithaQ1VmhPFzd
 b3H/ZIcqVhAm1P09+kjw6sIW0kPj1iqrE2ABPeW1t59gLTLaNzmCnR+pXsQGf5ha
 nqKLWQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2jvh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:23:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so6040395eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864191; x=1795468991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rdryBD1ki6izf1sYt5+c/0/g+15gQDX2coAYsXaCG2w=;
 b=ZhlstHiG3Ea0ow1rpSd9yjXE1kdu4AosklRIDVD78DMiMiRkm5XhKZRwW2a1uIwzI3
 a4luqE/gRvxtGMR6LKjIQPjKDvY6TY8bGbBTEX8lVDJ60HH71v1fr3VdsH3GD5P+N41Q
 pDn3OZILxVisOOSalC67hJpJMecq9mvUWBeXyDkvWd0sl36FAZxRgxqEDKDAabhF129p
 zC0iYJPGifXQ0V31PxQ0KCnfNh/H51bdbtREujPKwWN3aMblo5MeE5DPf03AYI8wKzfD
 miS52SQbGGXzCrpKyNUjDznLVh/ZoIytg/hfO2xwRsbh9VKj0dz3S5I4tFWlIyqyU+KY
 jfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864191; x=1795468991;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdryBD1ki6izf1sYt5+c/0/g+15gQDX2coAYsXaCG2w=;
 b=oZP/eu2nctqbXL6lb1e+OLJDhawSLGBu03sWIyJcNkrPqkMSuc2NPTt6yrB8E6ce8v
 MflLDhQSa85wqkfHl0JIK+L9jfQXoyeIhbC8XkSKdiOYuCF09txpxf7JrSsDfur6z+rC
 4uOupIqibY9HteONOS9mrV7BFefSbCayTKUt1AngZUqdnmRwVSsPi20UCMuwTHPg1DgI
 ryPI05wpSDAm9ed7838NGdarsW//x5xEfglH4oQrVvbQbz3llwWCSQKOU8VRx4c0vNME
 b+dL07AEV5d1CLfD0Pwi2YihZiMjUUhIPun81uHHwG5bQpNYWWUUR0e2Q0sLdyvtoa/+
 BqAw==
X-Forwarded-Encrypted: i=1;
 AL+hErGOV13b4df4m8xMX6850nTxElhCO0giAQl2LLau58ww8AdYzxZRGHJqHYe+d4yR+UebA0w2LXy893F6@nongnu.org
X-Gm-Message-State: APuU4Z8q3z+xuNQFc1MMWtPiTT6TnCWJEVoqueJYE1F3FAaQ7hmUvz2G
 +5lj+mhN1GFWrA1VxoggIVny4V7+xv+VeUdxoInAW/GAkCFp+XNRNGg2tLSXOyHIUtiHqL9cXQ1
 Uus9OP4BObRPjSarrhZsY5GYcpQ1yiHVS3WuzyqA+w/MEQf7jkHMIOtYLJQ==
X-Gm-Gg: AYBFou33wLPhNW+AJsajreNx/97UZXnTuRK9QJtK/KmzNkgC5lWeZAXsSO6roUPCfD/
 tbZuulkn4NSFuMFtHWUqDKQIvVa5eTz95Xyh4qxEoSJCLrKMo4X3guim5uBOq/wcCd74EPDzrK/
 iFhaSbSY78wU3zZUdXkYAy7OaaFjaVUb8saQO779bHBiLupKc2AJesCMskCnKcrnCnrpoDAF6DJ
 YRDYW6OoURUaylnx/0F0VHVr3cLyA9OPyt4GQOHK0HRQx/IIWvd1OX53Bgtqs8xHEiZQvNHPYIW
 Ar8vf0sF5mRi+tryWFTL7M7873m5vG1sj8ZlG+pvDhOvZRErRCpd5p1vR7DTPU+HUSM4tg7OWDa
 O9p0RDaVuI/QGbuex9teWGKikJF5pfdPEI3xI3+6q0mOyDwc2idintS+mA5O4ZKz0fPI2hkr+9Y
 RjPT/fC5nIjV2aohELJOveJ/wcjf/qUpkl3PwtmlHyFms=
X-Received: by 2002:a05:701a:cccc:10b0:1b5:3616:599d with SMTP id
 a92af1059eb24-1b536165bffmr1727060c88.35.1794864188710; 
 Mon, 16 Nov 2026 13:23:08 -0800 (PST)
X-Received: by 2002:a05:701a:cccc:10b0:1b5:3616:599d with SMTP id
 a92af1059eb24-1b536165bffmr1727040c88.35.1794864188137; 
 Mon, 16 Nov 2026 13:23:08 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b53a34a28asm1268218c88.3.2026.11.16.13.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:23:07 -0800 (PST)
Message-ID: <a1999620-16ee-4504-8ce0-c369855a4302@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:23:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/48] system: filter machine type list if a target is
 selected
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-32-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-32-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb743f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=52lslPdOHPLJQv8vouYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX//N0ld4EVRYu
 53mT3fqUO8T1wwo+fPT5I1RkWpxc+Oakw7STk/h04TUhr5xkecrtD1Cfh5iLcWkJqzgHCTdEQKO
 GaJZApAEHJ7w7Px/seWymloicHSvxfE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX5Ydm2d46VuPw
 co6TzSXBULSdVHU6pQ2EpNmX2EKASYCQE7Jtc7/meyMNN6b4qzfcXaMw9sZUrlqT4HsnLjFESpt
 ma6HQnGJOr3JhJrk5IxKCdVmt849CMs+T0+09eTnWnxleU6Nr+4/80Rtq0QxBPP2c8u/97NPdQn
 WiUCP59zCUDPcj5x71kAbQv3IZz3TCqCVaZyESWy7RKDnPzVPWzmyT/Fy6nPBhrW6QYCe3EC159
 EDAzWh9aE2tqvAMXQEo2h4kHNn1VXEb/n9mwqAZ3D3hXwzf1N4E78JN8FDKy3tXI8AetdeEcKGz
 5D3ODdzDUd/B9KrhGb2qI+R7+/8gwf06TYSW3nTiO6krLadmNewC+Kj8owNBgxnZvGK+LKRIVsT
 itH/oBc1DDnD9TyKv1GfVRe27i2iE/4xRZ9rO9TGUGlkEsHAkbUuWWGZTBaQhswRnub1T9Cjboc
 1P4nJV7K3nRUpwre0Pg==
X-Proofpoint-GUID: PmhT_y_-H5VHZLXv5Cb39y4kah-pye-6
X-Proofpoint-ORIG-GUID: PmhT_y_-H5VHZLXv5Cb39y4kah-pye-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> If a specific target is selected then filter the machine type
> list, otherwise report all registered types and aliases.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

