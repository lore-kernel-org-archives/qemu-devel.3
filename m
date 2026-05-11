Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE8CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVSR-0003NQ-DP; Mon, 11 May 2026 14:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMVS9-0003Gf-MO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:34:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMVS7-0005lT-7A
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:34:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4Mcn108113
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4XBDbk/s6cR8LFn9i7C5JqHHsVL//v/aWZMUuourihc=; b=XBym6EmUyuoihy1B
 RIRbzhEz/YPmfCAo4MWqyXRb4bqnFdA0S2wdN5tE1L0Y+Bilg7yPjX1iAY1svGLY
 6oRdQXDEVzZkAtDEo47W2sQVQXW4irFKnQKqo2XpY5j8A7E7a+1L9EHBGE8O2JWb
 GY6rgJBfO7dACFqKs36x8+FKctQQEwFOyDeIRzDnaHDh6+Pd9uy6dfm+/WnPzwdy
 Y6a4y2YKCPW0FGsChor9ydBllqr6JIhtIpdnQwun/1LWnAYQkY+TjMwt65pSUqI0
 7u2M27xXkTjf/j19ntjjdCEgkq41ayfAcYcoR/8MDctNdKjK5VQqCk+ly3coYShs
 U6WIsg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esysppe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 18:34:00 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dba1e866dso4367418c88.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778524440; x=1779129240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4XBDbk/s6cR8LFn9i7C5JqHHsVL//v/aWZMUuourihc=;
 b=IOrFiV1IP2s6TrgYGg1a+pgkLMCi4p/O5oNzKf7LaFh2pOK5aRktRk4lozyx1pL8XS
 hPg/MONZGgtGe8JXOjyH0YdT2mXSunLahlY++u8frlL2JEWguSXSLqOGY05a5n4pQGQZ
 AfkGk+WRapFzA6tvWAffGQs94INv6V9fqw/Mv0k+gY/g4HpsT0RHsPEMIul698uEu0ML
 K5yVs7jiKKVHNKCynARXUU4J8n921y9BHHCdpUEcMriRzh6MgBMWbCkTQ96gskaEcixL
 Qh/haSCmxfHGNqL22si8TLrnt/yTTTDKHZNHkPtUZZYuzi2gg6EiIRjsGTUNzjzxvq4O
 f6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524440; x=1779129240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XBDbk/s6cR8LFn9i7C5JqHHsVL//v/aWZMUuourihc=;
 b=VJTW1LQHYi7IGe8qYHowGN2zvfvsT6LGob/A2OK2wpkMRagH/uf1n8k8sXuOA/qJPT
 /YceRwLs8FC7Lou/RQzBGGQcXGQkzkLtSa3D0VWsG8ppZH+wBHZ2X4trFGnTewK8AYkp
 Pa9INpaYKRJw6OLJM1fVxXvuC4e4zUWw6tz/TU9XWIZ34qtwBfapTfrq9C4j8M0+OpdF
 LVpcC+yBkhg0ktacWSD3YXFhWcQU6a5GZM4/LcdXuD/7afbCShZ9UAC3plVYsuRa9O7A
 LNsf6Q0aeLb1jUJ2QYjDrBJDIR6Sh7XEf1JPsNGEbjpxykMTKkfeFZTV94JSe/BJLP3n
 vCjg==
X-Gm-Message-State: AOJu0Yzz7M4mLAJm6kYu+Mn8SnkZ49uXnzzIZXmcDtWJO7ccHN7zxVnG
 k0W1UElIVNHCW3B9XYdjyaX8r4LCvyThesJNFzAtIHOHBKZ5FQuxIZi5fDjlUtkm9zJ0QioN8lz
 nuSqBnXVBrEQnmpHfT5Gr9q5P+hlrOyPhAxZ81XKiCXw0Z5zsU7BC58PaYQ==
X-Gm-Gg: Acq92OFD1UKiRAy4bS9FGfwIOQ9Lm9pyCCh/d/FTdklCI1apNwXnjBbtSGG/uFM8cNd
 5tWZ6NIidwSxvvTZH7J3rM94Iu5MKNMfh3uElO3ujAYLmO9m2OFgw9WUmamci54W54EfFGOlNuX
 qdaGgatWkvqrwaWDg+IUeHsXDF+d9FtCpOWDJxyCxBYLv3SChqbt1g/UH8f8FSkwERMMX9GuhDj
 g0MCbcejMeszFx6MLr9NMRmm6KE6EceukF54u8Mgb4HMF6weS99la33hroOlVzN5xsHyS19AqGp
 mLEdGrYrylka79/pEcYJmTaj85dVlMC1S1dkKkzemEY8mQDagpFMXTBGcyAq6pqtrMBzmUU2T08
 LpKJaof/UJAii+miySv73QWQnj7oCG5Mjl02jnT57w9VFYhzPvvrdClCO/bXDDsKu2yr9yiIGvi
 6WXQSx1ccwoAPJdQ==
X-Received: by 2002:a05:7022:260b:b0:12c:9037:5115 with SMTP id
 a92af1059eb24-1333b2c2ab7mr422926c88.13.1778524440169; 
 Mon, 11 May 2026 11:34:00 -0700 (PDT)
X-Received: by 2002:a05:7022:260b:b0:12c:9037:5115 with SMTP id
 a92af1059eb24-1333b2c2ab7mr422892c88.13.1778524439641; 
 Mon, 11 May 2026 11:33:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13278210ff2sm15835890c88.6.2026.05.11.11.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:33:59 -0700 (PDT)
Message-ID: <5638c12b-d52f-40ab-a175-ab7ccd8f11de@oss.qualcomm.com>
Date: Mon, 11 May 2026 11:33:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: restore cpu_models for system builds
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260511163541.192533-1-farman@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5NiBTYWx0ZWRfX0K2E0djuemky
 ZoUtbxVgdni0dzMb1GR16wXYLa2yDwT0159eCxAHyZ+JWqARTl/UOhPtFlOo3rv4Tv2ZN7Tiglf
 cON4QgB3IImJUW9UkMqawyLCHmJniHkBlZnAJghgENPEWzZXnR6WyWHblKmV3dRS5UaEF74eNVl
 zkTArszNN6/ZIKlCBdemwJVkPC6WilqpH9ZRO0u4xfLZ+7Sqn9sltxF4/CUEdigtY+edEX/ePtp
 gz+7bxtprgaFw0Tx8gtjntYViAKScj61oQv6BHptaRN8r2PTx6qePm4rzoLQOQAoSNPp2IH8zcV
 hTP52XaILrKX6KY+EyLGgDVmYI8lNw1MdhoplnZYbn0SLdIj7pddmLEZliqQlrvDSkHUvLnloUs
 RzAnrKW+yfHfQDDwIMvy5txUfyx32vLlJWYbtOKq7xv2Mv3j0T1H9FJRQ8W/pD0cFLlXQqW9J8V
 x4iosh/FEtlWT5tHbhw==
X-Authority-Analysis: v=2.4 cv=AI/DAN7A c=1 sm=1 tr=0 ts=6a022119 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=eEtdiOoKtpHFEzr8xv4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: j6D-IMVDLOamXW4Vw6eP-ngBxm6jcnac
X-Proofpoint-ORIG-GUID: j6D-IMVDLOamXW4Vw6eP-ngBxm6jcnac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110196
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/11/2026 9:35 AM, Eric Farman wrote:
> Commit 0b83acf2f05 stated:
> 
>     Introduce a source set common to system / user. Start it
>     with the files built in both sets: 'cpu_models_user.c'
>     and 'gdbstub.c' No logical change intended.
> 
> Except that's not true:
> 
>     git show 0b83acf2f0 | grep cpu_models
>         with the files built in both sets: 'cpu_models_user.c'
>     +  'cpu_models_user.c',
>     -  'cpu_models_system.c',
>     -  'cpu_models_user.c',
> 
> Restore the s390x_user_ss section, move "cpu_models_user.c" back
> into it, and re-add "cpu_models_system.c" to the common_system
> section.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  target/s390x/meson.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

I ended up rewriting the same patch to answer of Pull Request thread
directly :)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

