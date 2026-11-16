Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D3606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UGhSt58p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TA1oCMAk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Bu-0000tX-6L; Mon, 16 Nov 2026 16:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Bt-0000tN-LD
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:24:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Bs-000759-3B
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:24:41 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCH4g2710674
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pn8ZauuxneugD97112aHzL8KYzpcRb3KThkh77SOImk=; b=UGhSt58pRAZ3fZ2t
 u35wAV3AfyHH9TYc98VDpSjERY9BdxsRQuhh7ljthAxlvbbvB5lvJuWpSyErPq7x
 118h56AMpS6OOEzzVyY5isOpj1GrmWVASZnTXC31R7KWTQcacWd0OhTRBH3kMXHu
 NLa7synzzDHSnTnEJBz/qZDTnGMBjew/G3Yi7+F+Qo9e08QJxHkD4RL6jiNNJOkk
 ppV/MIAwHUA4U/vt+i3iexsxZDvCqENzuDLeTmMj10r7g1AdOLe5KoiF7lZM7vc/
 JBbcmuuoXBFOeKfJ0JG5m4RR3MYc6kASGvL+lBJQ4PN7zM0nucpL5ZrWe58kPC0t
 22/BIw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htg18a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:24:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5636324eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864278; x=1795469078; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pn8ZauuxneugD97112aHzL8KYzpcRb3KThkh77SOImk=;
 b=TA1oCMAkPfjSTuf8bMBVXiRUs34XforYxty6seNOndjhHHubvNHYV3s4Fv9hAdl13O
 +Jo8Ht3KB3nWvEssqAY3IuOOjkMuje5Gj6/9fZ9C7YzORjKDJgU2xL0FGTNn0vaokE5g
 AN+mfKdpaqkxZWcEGiLC1d1Jlrh2SSJ+GT4CQ4UCn9nNT3fij/oFXfpjs69iZ4k+TK/B
 kFXnWqlgOXuQcdq/vivz6pe5UXJd1KZTK34JRGZAQIbrTTb0Psy3VdfALeiotAW3C5yg
 8nUzC7UcQfUsLZom4U/gSRSAPDksfyTqEMWxVeiRM0ljmKIla8acnwcLLJSSCJ918Slw
 aR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864278; x=1795469078;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pn8ZauuxneugD97112aHzL8KYzpcRb3KThkh77SOImk=;
 b=dy03Qec54NZxNxXW2/zHA1PJGOIwnotoMkrzi+i16gq3ZH8+3OWXELEkM4jFLBH9ZZ
 N+8Pjz+ORfVU+eHYmrc7KvddgSmAOyxp+WeThnl/4PxMOujn1r/KpTDGFCk35B4+hPJG
 zmoo8olVEAdJ45B7ioaAvOyXQDvZkAVkU/4G7ZzOradO+2Rjxt2T5eQZNTjpvqOvHYbR
 7jhZoPCVc65kG0Mgih9YB6ssC2p2XiaJTD8gizaO/z6m71uDg42/uyTRsyXQPgiIWt2q
 MbPkZdibPQxm5OK3KRtNEqlw6yysHeKJnfazgkyodfyWpgvljkYURuoXADPLV4cvZ2cD
 T2iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGH4GCzPWbWQwK2F4kpQ+5mTMWzx++7sW9PxCLVD5lULfTLeQzY9gs/eC4Xs0HgbDeGr32rbsxYYso9@nongnu.org
X-Gm-Message-State: APuU4Z+WqCX8a5bUHtYwCyV+K/8m+4iJVNpZRjTcyVyghsrM5DNF5Bpj
 5y0VCnPKSTNPuAbIkS4YH82quQMV4lkplGatbA9my2DPnzipYvM4VQsaO25hyd0J7mUXveKMrPD
 P2CWLvW7Omzzk33lzj/IenQ6QBIzT7/9DaQ/uOb3cD8SY4XLH0IX903xyCw==
X-Gm-Gg: AYBFou0vQYyXLgIFowfU5GhM41QEPZtpgGl3Olc8rO1Fm4C9Y1PxGN3QAyaoqXT/Aaw
 nQ2JUcjLQ8uT1Mnu+WJquusZntAouJ+sDQz4FnCI0ihFNWxKCdyIH6QT/tj+jUHwmooFUxA6DqI
 6nWOQA0bLK87dYpkINiyJ4Rr/IYqLMfyMCIxpktzRaUpM+E9toXPTMUj0araeT7NfHM9xhqk12r
 nNA/9axqUVFLmkwzxPHlqeSa+GTl0OqcKxvVKpXDidzJ+7ok/KW7HGsPZxSnsgS4Zd7pneZD7xW
 E8ZhRrY3TmNype6vUdws4pjbAbdPdqakjqCELDO6VyxFGUBDuETeMJf6jW/6HlnZGd3iOhFETgi
 qDc9WqI7Qk2qiq3lPMk8LE+EQqD77Dbuf3+pBW8RWRHerl4s1vqhUOHt2DkBfRDoTApqBUyJZa8
 UvhmT3zNFwyzRqnJbHWp0z9hmts1Y+fhUMG11uDiB0pNw=
X-Received: by 2002:a05:693c:8816:20b0:36f:350b:3838 with SMTP id
 5a478bee46e88-379671247e7mr11426104eec.31.1794864272864; 
 Mon, 16 Nov 2026 13:24:32 -0800 (PST)
X-Received: by 2002:a05:693c:8816:20b0:36f:350b:3838 with SMTP id
 5a478bee46e88-379671247e7mr11426090eec.31.1794864272346; 
 Mon, 16 Nov 2026 13:24:32 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm37709137eec.1.2026.11.16.13.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:24:31 -0800 (PST)
Message-ID: <be322ed6-f039-421d-8c3f-b81a230d0f3a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:24:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/48] system: filter machines based on target during
 creation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-34-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-34-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX1As8aBHHdujT
 dexQc7j9s3lEaI+8hcEZ5EAewNWR5suqwNlLMtiNnAcbRsI2IBtB8ONiiGylfnecCzfUWeLe4mI
 /BDmiaK1nAb3opS+YwEZGloS5GEgsEE=
X-Proofpoint-ORIG-GUID: JQ_YHvg0iyt6CBllcRPsqGXQ-6CokCvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX9I5tC6aT7rjG
 JoJWMXs2TKpYOROs8SQyNgSTVctrQLaOATXTEE5LPww6Kh0WZxO3yHcd1j2hPiAx+ZbMx32oeMz
 vWTID8uTxmZbEGM872tCaAIal1E+Jn3mGBV1YQjbJM91bVNBx9jZdrdi4GYyx/ldKJ2ARx+9orD
 h5Fe/AUVwnb+UMvtGfAC6T8+v5pquU7dGSaOgaTJn4lCL7AhEm26oEVinfyAxAQLymeEJ5/oz9K
 BMojvOCCsRJo12cAHNpC/Vxm9Vnee8OVstN1aCuXV8rY1UF5CCTRg8MV5NhGekycz8T5c2URvjk
 6KYvuwAPm71yECEIZr2ktLQT5QcyqC+G4Ah8k8DOp+0sxY8PFLm/yFtZkVoCQwnuNC6PBYPXTFN
 BAg9ylI5uYDWjxQ44TybOXgOQa5AfW/R+o9JF4nUARFHfaGsZhmQ+8A1l787MgSKy9oq0KOcl/D
 /1z2OHcfgXDgUgdezFA==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb7496 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=hLhM-RRBbqfcn9oER4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: JQ_YHvg0iyt6CBllcRPsqGXQ-6CokCvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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
> When creating a machine instance, validate that it is creatable
> on the current selected target.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


