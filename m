Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB3DFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDva-000423-Ns; Wed, 29 Apr 2026 19:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDvY-00041l-Sa
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:02:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDvW-0000Fq-Ga
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:02:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbMJ92855860
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K9t153Ynx7CUNF8nf2d7rYPsK3ITwLsI8PSuwuSmRqs=; b=DVqH5x41svUwFz+o
 eUQjBp0CCblnXW6SqMSgnppJ9mKHP9i92o6C5yxatmnfYROQANyXdkzag0TiqzvP
 7mNYUBSNxZgJX/9qMFg7KVikaj0LnmP2jYAhFED0dchEqluvxOa46BAVZW23Fcks
 kM2NBQuV3RccoqesnTAyV522EUkx8ZgdoS4t8vUM93mQRc5ZFkPPIb8p1Gez868r
 VX7y9WEw537vUQw84A0+vBa74QIYxxZeovc+ga3KaxjBZNXAyUoE1xZw1LvtgOYt
 MJ/zZoL0t+rgDHLq/Z/fEWWrmQA4gX2AVNY9a+y7nWqQ3XR8znuFndNz55UAN/Sz
 W9JUOQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dukrp1u1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:02:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so1638903eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503760; x=1778108560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K9t153Ynx7CUNF8nf2d7rYPsK3ITwLsI8PSuwuSmRqs=;
 b=TmjvnGccn3Z8zJgw/5+EETyGP0hlryhH5eaoO8HFZKkW1lKK39igQWyW+L8XPlYOkh
 1BJcUf/atdpROynHj9TUyngZMNCub/PEjojrwwUTNKrgp6m3GlM8yU46jRVosrUmOfvw
 qjNXLvsDK5YGdJOjJt8jlw9c4BSSBBrymOWLpeGdwqyXb5NpI6eOtGZ4JVKUPuSHtHxO
 Zm7LHq/WR3v4QiMhaJWtcfqVyF6aL66ZXmKFIk2DPIRFnWag3xf3wZtNwGdlWORMRFSc
 4tDr27J1b2IphLLeZAdwvZQYK+CyNGr8KkrFzECLNuadFju0TpGuXRz6LEiG/UsaCwkG
 S/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503760; x=1778108560;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9t153Ynx7CUNF8nf2d7rYPsK3ITwLsI8PSuwuSmRqs=;
 b=E1SRTq2HdGhJHKHnLfV9auALt3HqT+aGl4qDQlko5EQ5wPkYx/yAeKTyIA3pdXVIoD
 B7OPVXkDmsOjNC4Pkj53h9tP6uT8uzFQuEUuZQHBCKti5enmgNFONcw+MhbluRfTSLgg
 ivhGf36wTdwP6lQG9aRTC+66jx2VuRCsLItVbgXKOLjKZH3QYUSKDBi2Fa0UWZd1xU4G
 T/5ZTfqBWWKHph9Z3ACY0Z2p0LKqxp8vDSgVkkfWfW7C8DGQfUJ3+s+mLBPUvsx6QpFV
 jtaZvqH//uz9NkAyvfCzwNGNxEw7lRwN/piQJXuEv0SlRB3N7fBbB+TJJCw8cSunpIt4
 eJlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nyGc/LqfVBJotQVYroXUozU5lNsn1+Omin7DB8zKEfixDdlaTxugy8pbe97DaJs3Rm9o8lW4ySx26@nongnu.org
X-Gm-Message-State: AOJu0YwA293bFqshhk5AbhKR203ZNiF1RuQntnQ/WFpu4JiEJabFqZyh
 bAvyoIEvD6gtKMraNK7b/VRaC62Qcz8SjmAk8dlPKa+KLa8gsp1kFV4wUL0/X55L3ExZnl2jy0p
 MKoYRihtcyCJ/W5gmc1G9YuOWsqhDw/X770FcaZ11h3KF3GFJgcbqYrCZMJVbtmrTubPH
X-Gm-Gg: AeBDievxLpbDIc1N4zYv+riqv944ad1RCIq5MY4Y/Ncac7fB++ao9y6eVJ502Am7kFM
 c9IUncGMHUm0FDwKYyveJibDEbhV6mgmYZ3rvvn6YE6b/jdqf1K3b4IcSg8V4doyJyH4YJ6fzQH
 4zTAetf6NorTIiH+sDdbZ5Bzz3DoEoZ3pGRlKdV6f7HaJa3XdhBr/PCX/YXqN4AkQZSYpUtNzfi
 +VQYwg+K+7ziYuRLSawJCuSkj4FNawGfRhrYg9NW5hAhhiZ2zMpS2nKryda+vF37RatAHNB8pYb
 t0U+IJlXSzX8X8MReVUb4tezY1im3YJNsrMdHJBPDYMmiBf1ccqoxme//7CzqtKQwyqddr62qoB
 CZPpHYVDdKwwxQTQWegK1Jqzg7wfwF6mw2wgFyslVGmVtQJBVouunz5FT0477iQYAdL6CkCXz6l
 /pSM5Or3pQCpEo9C8wSoxo2SeK
X-Received: by 2002:a05:7300:a498:b0:2ed:e17:d50f with SMTP id
 5a478bee46e88-2ed3ec61738mr126468eec.34.1777503759966; 
 Wed, 29 Apr 2026 16:02:39 -0700 (PDT)
X-Received: by 2002:a05:7300:a498:b0:2ed:e17:d50f with SMTP id
 5a478bee46e88-2ed3ec61738mr126449eec.34.1777503759474; 
 Wed, 29 Apr 2026 16:02:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ad3asm4221500eec.21.2026.04.29.16.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:02:38 -0700 (PDT)
Message-ID: <cdc642aa-c9f4-4aee-8567-28379148e7e3@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:02:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] bsd-user: Add target_to_host_sockaddr_in6
 function
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-14-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-14-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _OOCLwPjjIjziJzfQgqChWMEkdw5Aj3v
X-Proofpoint-GUID: _OOCLwPjjIjziJzfQgqChWMEkdw5Aj3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX/VEGNJxFkRRD
 tBemqJP2IlMybvNFjTzwTaCUirXgYH12UFUfKcLMzaS2Ykr+0yedcTN3zFH9pcU/h29xvcRquNF
 oN5M5CORqmDerwlfi3l12ltNY6r7AA3RI+/LxCeF/xy6kDGSKKq/6pLDIje5AqTUCo49E8O1iyk
 vRrzJ+LHE0+0IziOh7Tc/hnYuYHaEv/ukmre2HAP2Kbp6IJK24jSE8eGPjZZJRXRV5htZgTRS21
 vL0H+NgXYvLBIJpktQGucfZr3nHq9QrOWtzTxu4KqKNlhxTMYi0SL8R4RN4b5bO5pIu5aNM9I2G
 Ot/dd0ja1oW/ALHFbY0DwZ6gGArILSDtjjWvqndZ8dZR8aDSuQhhorGftbOYwfA1WNUoC+YszXe
 pDsGtbHUkya16ZtGg3Nle/xnfHHaZf2pBVaN0eLEqr6KCp4jumKlbppTWPfnqqnF0QIvI50KomU
 9Riyh9ospec99aWJ8fw==
X-Authority-Analysis: v=2.4 cv=WoQb99fv c=1 sm=1 tr=0 ts=69f28e11 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=hWEu4GADUzLoLhF57KUA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/29/2026 7:45 AM, Warner Losh wrote:
> Add helper function to convert target IPv6 socket address structure
> to host format, handling all sockaddr_in6 fields including address,
> port, flow info, and scope ID.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

