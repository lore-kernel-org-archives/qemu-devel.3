Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0F3CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQvd-0000bY-OD; Wed, 24 Jun 2026 12:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQvc-0000b8-KY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:58:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQvb-0004pX-1r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:58:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfV7g701890
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w0xD49YV+/0wSgMinp5XbnFE51BLY7t0wI26YKUX3Z8=; b=fnCw/0oiywBODcWW
 9TYoX2UmBGVI5cnKM95kpHHxrX5Bmg2/yMcKF39l4OMBTXZqEWeK0I+IDxlTmK0l
 rECfGz9MfZImUJAVQ7qfKWZruLLSU+WqS+qy17zArrgDeq4CK4w0CFnMSaGl/0yv
 sUqltpAg0+iX1TqXgfZ83FUFWjStO0P+1W5wS7dQgHG6JpKNJQo228Bjd3sKSlHy
 0CmNvn8ktizzhFZbE0OfN7SvZtrFO9tHTCWeWfF64ufovPtEsunCJxRnMeHPG45o
 k+Fb3kC8yPc3FXQnqF0Byn4JCS4Iks6HXAjKHIDfgk3JPy8hg9tQJnoJgGLUqS7n
 ln1bKw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0aqpaadd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:58:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so1235666eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782320296; x=1782925096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w0xD49YV+/0wSgMinp5XbnFE51BLY7t0wI26YKUX3Z8=;
 b=Tg7VDccjO92N+rNUck5DxW/3sZKF/6aEbpGmfg3x1U4GyifGKMSvownNckgxF1R7mK
 UACNMCKzE2rKsJDL2Z3RIIGwla/Wn7t/RgbgFFAWTMR01MhI1zjd3FSTDT2wnOyvd3H/
 Bn00CsZyNbQPKRArI9kYzJSMG8y7iYDFPNsGzlRkx9rWFUbnUbR/s9bmSRs5TTVlCFND
 hlFaRpVPyzYnf0uY/hAgR+TSuSOOLmeKfutaioUGrlG16p4A0pqr9K+8KGGvDxENJAso
 dfgDulVg9S81nxDkkThPhUvioCTldHnhKttjZFGEiKcEp8Pnjat878Ao2GPRIIxUslKA
 wNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320296; x=1782925096;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0xD49YV+/0wSgMinp5XbnFE51BLY7t0wI26YKUX3Z8=;
 b=i5l/A8/rQbaSZw25PCKaoNy6KX+e7yowQXIVCASiEyHQzFt5SeY0blz5JckDYqx37U
 j+nNyerYzOYNXJ1cHCeZEvDkYaZtwzfxr0YuNXot/W6ch26HXn9bzpIskduFZGSNfXni
 95pMQIclqPpAut8L8JhVj5wMncz8Bf4SkyZTnqsp5IXIxFxwbKkgBADFA8X7HShc1p1B
 frGyvsT0SBZjghTa3++ch9Q9TVMY9NXonK+HWCWv2RWwfy0kvoGcoe2oz8pUC2xVZqHk
 jD3EnCM/KetAuC6xZSKHALEtypwZ+pJlcGYUX2Np7X28p+nxcw6WMwFprCCZH5mGEvEH
 +JtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNqVBt1/y7L5/pUgzlPy/tu8a83KNg2W3ckDH5VpbuIgYgInEbY6+K0KggwixghEBK6Dx9z/JfX/KA@nongnu.org
X-Gm-Message-State: AOJu0YweYwrtnUSz/6UsvL7BF5Y5LvQfMmSeiZfgqMbV/CMlQlVN2vzo
 YIIWcpdetEHRUPXvy18ONQPRfzH16/ScrVPv3vuVY2Y4rZ2dMCmS1m3TA7yz+DSbVlawQyjHVCZ
 ab6Y+/qvHOQuBFi4CmOtfJ9KfCLKbJU4h4TOE9prae8svXyFiGFLGlNsZWg==
X-Gm-Gg: AfdE7cl0M8i2GKuA1oZZxSKjYgYi3GbhWK/zV14KaB/GZiuxye/EUB96d5dq4H3VQfA
 T53yBEumOW5c6rjtWYXLbwJmCQL5hxGQFr1NNlU0g8MQG05Jav834EILHVV8Qfd3MLcurHjayB6
 s1pJ0Ls6sLdTxm+e7RvcAOKeMgiGdEhDf++W8zZ4dLLihT1+W/1LL/d8cXHWZeETkD5tdab0HIQ
 lRIdnl3wAGT8dItbdPobabfZCku/FiQQK82nhJKM+cYrQGfusDELy/AjL8JJF0mfRw8Vh5NGy1V
 MaQgkRnVhJDQdGVPKfEeK1M0ejXz34c+xYgU+FdvdKjSzqbmsC/VUBeUebIcfQ6antKobN2HVDw
 C+54ymXirnj9GmkSNFJD+mV4QcntO0XUqAXozBLJ1LMvP1IdYqb3uqqmcIUlv4pjZs36XX4tnri
 8pJSc=
X-Received: by 2002:a05:7301:5792:b0:30c:25fb:d28f with SMTP id
 5a478bee46e88-30c68de9282mr3194218eec.25.1782320295736; 
 Wed, 24 Jun 2026 09:58:15 -0700 (PDT)
X-Received: by 2002:a05:7301:5792:b0:30c:25fb:d28f with SMTP id
 5a478bee46e88-30c68de9282mr3194203eec.25.1782320295203; 
 Wed, 24 Jun 2026 09:58:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afc91sm425771eec.14.2026.06.24.09.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:58:14 -0700 (PDT)
Message-ID: <a1216f5b-d750-4d8f-8be7-1a48f21e6746@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] gitlab: pull before_script logic into
 .base_meson_job_template
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-6-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xKbBwMuakUMyZ09aVgB260RstHA3zZI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX2gmF5k1mm5cr
 9UmMe6gYzh7tBflCqcqDDI4hfkNSHROcptcYd7yMmCFlxy/t++pkWt7kUPefMTuTvYNAtyki7+S
 QDApxtRa4kIAozUULOeD+nbDiWXlVQxF7PYJ7BQwAiAc+9C/AuwrEUNraIFMFGnwbx72tKPSQh6
 IshFJmT1EpRW26OlUeo4eEajuaxFu9CReC/lLPhEDeHbKKOrImE74MY8UvQymgxbkdiVvOLRzI9
 SuMpuGX8E9OjzQpnWaqd6OnycB2TcafGG8oZ4DvdZprxbhTAWCJxsrkPCAbtFftH5rLURTjNia3
 I+RER9f7KlzBu/vAtxp1si40UVt85cs1HAv52RPRu5j1nLHEthoBK4kdmwOZO7pzJemTDjMwgwB
 gp/uGINg+GsoI3wPfJC/zVXkQ6QxEg==
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=6a3c0ca8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Amd4CTV02AHH9HCiJCkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX2KkjYnpgU/ra
 dFbU+z6Jru2vstbTUCgZuo06jVYvkrjcTQ//o4tfsTGuQHFOsDXUvVz+vU81JhJv3j6HvBR5Jas
 IY5JgYSVWrjO8qCQ0wWNvWdUKE9y4KU=
X-Proofpoint-GUID: xKbBwMuakUMyZ09aVgB260RstHA3zZI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/24/2026 5:46 AM, Daniel P. Berrangé wrote:
> This ensures that all jobs have the $JOBS env set and capture the
> packages.txt content (where available) in their logs, and all use
> the job section headers.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml                |  9 +++++++++
>  .gitlab-ci.d/buildtest-template.yml  | 24 ++----------------------
>  .gitlab-ci.d/crossbuild-template.yml | 12 ------------
>  3 files changed, 11 insertions(+), 34 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

