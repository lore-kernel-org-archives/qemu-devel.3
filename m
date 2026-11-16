Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FC606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ic4IxNg/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qa5VdVRw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4BN-0000B9-DU; Mon, 16 Nov 2026 16:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4BM-0000Az-8F
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:24:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4BL-00069T-0I
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:24:08 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJftpK4147398
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rdryBD1ki6izf1sYt5+c/0/g+15gQDX2coAYsXaCG2w=; b=ic4IxNg/RQLTYdwT
 9XXBwAz54TqVZ8A+eApcE6piksqcMJYX4FcqbwKaszPV+nkGJPHIiqocypoQTj5q
 jOZsKSKIgBqozvoiuJklXSzyG7rpRWh66ovvHlfcEhBV3EfQx0dsjgl1NXF+0Me5
 3OM4AAF7Via+gt7esFkrloo3ETMPstAEiWa50NYaorUSCaQrTkLjXOC9SqXIx3Pf
 kxFcKcoWBSE/2YAuJUKSE7tRAlH2WzstbVK01X1rGtkMtP0exoF4qlKOiBBxOJX4
 K1ZliJuzGRt42gqrfAay+GqfeO+CRx6r6NbqMfyDgWEogm6ncA0koIf3E+Ebo3bb
 qQXk/Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f824s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:24:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37628596fc9so10396257eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864244; x=1795469044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rdryBD1ki6izf1sYt5+c/0/g+15gQDX2coAYsXaCG2w=;
 b=Qa5VdVRwoTeizS+KkXOpj5QqPuttMcddUQbvYhjmXh2I4l0eMB+eKlRkOMsUNc8juC
 7216Wf0/bFe7BWhCV5IR32hLp62LuCzLyLna1EhHkOb/8WVKaTTRIFAjlDwvlv4zVfxF
 ZMWmMh1YZHr+w8Jy846vrNXNC0yRbM95iO5+P/wd0KhUPIrDWyLgC1hc9iKzVU/oM6Ie
 qHZAdVOZP/G7QKVaJ03vvad8bkfX9IYTDW2O3WGq2qOId0Jp8dDFtUl5zTPh4N6o3bXk
 pCxUdtA2XVPEte5r4Bi1hw4bUf5bgQ1usp4ss5GzNqrUe1YuZX1jmtFhv9dyhNr90aeT
 jVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864244; x=1795469044;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdryBD1ki6izf1sYt5+c/0/g+15gQDX2coAYsXaCG2w=;
 b=cQOYjWaUKvobXMl23QtJy2cybwYbriTDKYBU+3SH08qQU/d5yhgDs55+pteeKjqN35
 akeXXi6N1Skp/r6joGl4KRn8wWLMquHX8fLm40wD8XhMF8i9GxRJr7myp7g2k3HxkaVA
 X0FNef2nGPOCWszqSLigXkNd0N8hiOcDcSJqkvr/WH/PKZ+gS46QEoMOL8+ZT87I2Iye
 QcwJ71SMIbYZisBSsuL7YROMKNM1pq5epD84g74MW4UYRia1794oP0zZocyenBeDrImZ
 zHVu2kPPMXg5dV1qZ/xCvLxncunutg9VTCnkgeu2Utx8K3zQshybSCO9P5DarioUwNKN
 kdSg==
X-Forwarded-Encrypted: i=1;
 AL+hErHPaf0FDeb9mKssOF2j5n7Nxukav1O6Lg5EzL7LwkI9uNodpQV6Tmbti6xMsoVIqiq/olpaA8rtLqzX@nongnu.org
X-Gm-Message-State: APuU4Z8ukMu0wvCfTBuZEcbt2eEaWqI7JzaZK1koJTEo/KsbFg290Tnm
 LK/DXLvkcNXPzjpHi6a/ZTulYAnPsUzbShsB/6uEeQbLO0zT2qU9dzAwu1mzNP/dogf4/iF7ejy
 achxUn+azjj+y66+Mge0SMAjl0J4jv9erl6Lqz8JTjtIpIimVTrKiWCazTw==
X-Gm-Gg: AZFdTZeDGz7q4egEeaz+DgGdAPcCQV4IjjMXCyej/jVvrgMuAd7doWGcViTy7PfPHbB
 OT5GIyM5CFcZW2YWr2wNLs5ZjyGr5NKq6In785D3DH1Xb/uuiAy04wC7R5DJ9LrpYaUEvGTjYCu
 ziwbKJYK0mSqZP6s/wCxnR93bGAjDglpgkvUzZn+Mu3M9V1/CikcscUX6cE10MhNwq9sVHjUcpc
 tBkHdRAb5ORiYuMZ0LHDJbKdLifE5gtru4kFMRuzCCbz4THHY/sLut4VWwZ41HXFGPO5m99N0s6
 8k0y3fU4tJldVDQzJ/YG3VT4awFrbP3DDF4/LaTA6KgD0ju5EffcIHvzo3MxfNE6LEo6NrlAbbB
 G3rVUf7HzOwLubNAtHBOcCdh1NGyVStmXbciA19M8oanIRK7T2ZyrrvdH1BTZ9qGOro+ferH1gp
 2vU5JGI2vS0IBh39rWTXLLRwV89sgO5uoeiO/p9VgtChE=
X-Received: by 2002:a05:7300:3b04:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-37965daabf3mr16986222eec.13.1794864244445; 
 Mon, 16 Nov 2026 13:24:04 -0800 (PST)
X-Received: by 2002:a05:7300:3b04:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-37965daabf3mr16986199eec.13.1794864243942; 
 Mon, 16 Nov 2026 13:24:03 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795533170csm37478335eec.7.2026.11.16.13.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:24:03 -0800 (PST)
Message-ID: <f48fc71d-a41f-4274-ad78-9a0349d84b1f@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:24:02 -0800
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX/vyV0qBuqf9o
 yya9y1mzH36Ct+9h9X2DNaxYvDnzSc8NlFIdrUUKqI68aDQ3Wvy9hLkwIoQNYJFl6f2ZZhnTvEN
 J76LMv52hpmd9Xb8BbVuSD6VJNjO9c2JqlQAwg7lRwo3s3TJA62biX0BSSCu8Bt2P0Ug9Zpvv/I
 ali995Im3PFeXXMoCZY53YmheXDl9ZwNNgPyBVUq8iDOsFbeG7HzhY57yTc6Q6vmL9i93gvK9V4
 2yLMI4nuNHqoJfRZ7pM51p6a/CSlqFjRg5WhAYfExRQXn3Ww/VNxWqE9fqdMaHo8/Q+PlkQm4dO
 dlsErb+AgmTl2wlo0YEidyW+e0hatfkYm4eqX5TNk+61lyjSZVV5rgLWlioQ2Qc9vALEedWAg5N
 206Z1jdcIpRqgcYsLKZ9ej5HakoM9hYkmg/EGe0DzPalyRl2z3tdIQPptvMz0tvJqqBBEH0g5wZ
 yZkOiSRuNreHH/dq59g==
X-Proofpoint-GUID: J_l0iMGlLFhQTprtoRpSnNR1JFrj-6y_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX9i75k9Vz8/0w
 VFcE7gaO0rpdgkp4TEfAQiQeptAi4ddEBTgLoDSQg6Y37SacqVzSBHce9FLlA6Neg0f7+3Moalt
 WaQEPg/O8O3CBGkpskrSJW6WmaUKbqk=
X-Proofpoint-ORIG-GUID: J_l0iMGlLFhQTprtoRpSnNR1JFrj-6y_
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb7475 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=52lslPdOHPLJQv8vouYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
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

