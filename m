Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB33CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOMS-0001w6-T1; Wed, 07 Oct 2026 05:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOIX-0004Kp-DM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:50:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOIV-0001iz-Pw
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:50:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977k3Gs2711704
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rp58SBmy80oL4QNbGv79hPeNfZz5V52jw8QNYp6IUt0=; b=nR+6VcL4xYAQx+Sy
 aTdOoQVkKX0ygR3rt4dOnQBXLhSRuwaT9v1rKinP9yueBBi35N+KZ+iN4E1wtbQd
 EHoL9aalknUHZsJnXjaNQMYQuIT6Cx+eJrr0+bT9yNz64e997+BJOo8D0dCZsxwZ
 bXntl9x1MAqJorXMBVlXMNmjJURrnOVbvGNz6j1rDHeFK/eyzfNeh23JHnEeh0RI
 lf2rkWl3v3uB5gw1ZXdoIpfxUZ6/qELyVXOsqbESk4sUVeOyHVD7ZDTF6oe5vF1j
 NcDgvRpMdIcllAkEM+Xqfmm/rku98egMbYhXcoMpY40iXUCm02txU+ydLfxwPJTq
 mzr94A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s1jnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:50:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbf2fd504so727401485a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366648; x=1791971448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rp58SBmy80oL4QNbGv79hPeNfZz5V52jw8QNYp6IUt0=;
 b=aqEBi2cfzWBgZ2E1lW9bQA8fW7t9p8mzkQOQbcXYIbZNToG4TS14o5sXUA4vupQyxQ
 g7cqi37D45So4JxvUYm2C5UDNOy8G8RP6ajIOFpktyxg4VoobEHdgyGnk5x/oRx/AK9c
 CxODl7kas2BfN/rOugY/2vQb2Xj8hWo1XCeUjaR7NtouyuG6bAbPW2957ONLxSs1cGzf
 RzjYfF4V491jW2q6WMK6uMqbux/MKqsmXJNgCiSLHz7y8N+UF3ZPod418O3XmvrszNlJ
 X9GM9KYy1pofAZcW4Gw8GcYBSthraYeZjyXelfDtBXKGGmicfOWyufgrSCdoCS/HSZBE
 W/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366648; x=1791971448;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rp58SBmy80oL4QNbGv79hPeNfZz5V52jw8QNYp6IUt0=;
 b=sOBxKHGX3Vjx99JFnlcTddF+GEDp6kCiYMGOKVI36zZcO4jSurGvAMaKOgIbiXO7t6
 aXj/MUrCtmfOZkbHAyIL4YAsg9+94RUVf3M4+o1O7Q7saIrD5+7gn4Ppgc+Y9X6vFO6/
 aaT/2LR02lMmgA9cMMIrdTW3GHD52CLwXam5YJQvThSQ8xMnQOhoQh+mup3Lf1Yi/18r
 /TAA+5Wqb1LNBxmRATcMvtQ5dIlMPlE/UWgBXYiemvNqOta6TDH8keddMI7jf5p+VCci
 8VUzmQOHVxdPJebbTMb6/XxFgLBx+ID0F7C1ZY29K0aljgviJDGNtkhaEZsk0t6p+PFL
 2gRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykPqckrDMMuAZ3ZZrAScBT9nyyus4Ns65iQ9hhEtgslw2mq8D64OdJnF869jlRw+/ZYwO7LIlsQOqI@nongnu.org
X-Gm-Message-State: AFuF++mFbrjtL4A5i94OJfGjwGMPIqppgR5+UOFWM8R3RHgf4J0Uv5LD
 tbK8jcDEXYRBou5+f0ElQ6UubLaCD81l0Qo7yvykcqdhSWu7NDco8kfKt4taI98USUDJ6LTLKza
 XjzseL5Nh1rbQ8EAN/4A3kX8Lvp7Tm/l8G2BQB/sKfPHlrkTLfrM9WymhsQ==
X-Gm-Gg: AYBFou2zBNxQkuw3baavw5HDuxs9+HOvEiK2/DpRSzkumGw3OkycG1b8Pn1fMd5jhGi
 sGzf+HRZ1FHQ3RlAyFtuKRyKW//gAxO6vh6AueVBjyaremfX0mQdKDwPOd4+1Uq7QGNr5ZJN8ug
 FL9Cc6Nho5WJHb6MOhgVZ34H+PwNi3CMdqvlfMHNlm0N1pFdum2BV+jnj09qOw5E+uM0omjkjG2
 m0loujzJS4xibYB1AFhsjPZ9OG1nzIvkjg2VcHrcP5ZjH3wOGveY1b0Js+2XGqlCS4cpxW88WtO
 EZX9l4qmwYyJXuViTcSVmnBd7eBLkKmuVrV7SQBgXpUO/MJ6yM/kc83tGrSYNa6Rr8f6AT7BafJ
 Phmwjh5bUYtZRzjBUKEpDH7XdrWzxaiIJJQ==
X-Received: by 2002:a05:620a:410e:b0:93b:d7a3:45d7 with SMTP id
 af79cd13be357-93e9b85e552mr325443185a.64.1791366648428; 
 Wed, 07 Oct 2026 02:50:48 -0700 (PDT)
X-Received: by 2002:a05:620a:410e:b0:93b:d7a3:45d7 with SMTP id
 af79cd13be357-93e9b85e552mr325441785a.64.1791366648056; 
 Wed, 07 Oct 2026 02:50:48 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1787e7792sm131836085e9.0.2026.10.07.02.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 02:50:47 -0700 (PDT)
Message-ID: <b4ebebdc-d2ce-4fe9-9902-61cd88cbe221@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 11:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] contrib/plugins/bbv.c: Reject invalid intervals
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20261007-bbv-v1-1-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-bbv-v1-1-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -VX2DnhT_3unHhGtIMQbflxj_f_0DFX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOSBTYWx0ZWRfX9xq9vBAaekny
 mgYLsYMoTOScdyoxn82fhAnL2UQDTMLyXJUYiGzR92x3/9hovduamP7z36/NMBNw7ScT6JDoAcO
 EJjMKNaWdEAz7zdVZ/WYLvNJyiaHlBV2k+v0MCFpPVz9+i6QfEtkk2HvcBNdl3s1jGuZSB6FU74
 6IsS5eXASYkHn7W6u38hQ99ByYu2LFAmZkuxgBs+hnN85SE7J4LXzhhP4GbtzF/sl6xix3UzQoM
 eBoh/mxr4lSXfycZDVUSuTuYhvZ0VWG+bpvNwno7MkOgg3Q/HheW4jMGCAqFxo9bJx6FKVFC1np
 sWaT7ifVVeCrzco+CUaKYd5Fwv2HJNkpI+RI0Iyqqv93Rhymm9gamEUXwFT1cBXWdMQhsEM+QUa
 wbzr5Aaq2qc9kkiuTylpdXDOudZjPl0pTIkDHaaaoKkgZU+ELyOJwApMnfzsGfojKavpWsKdfo2
 2FQ3fdCN//ydyjoGlIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOSBTYWx0ZWRfX2IoLrL3XMG68
 YuON5JGBsBf/w+K9nHhnxNR8q+ydGbu4UZ2LBTYLcMI/kgAOGYjExXuu+kLWz1s/Ii9o1pqzpAB
 TR8n1wn3DIfG5/jJGEgv0ptzSphQ91M=
X-Proofpoint-GUID: -VX2DnhT_3unHhGtIMQbflxj_f_0DFX8
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac615f9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BkNdUZzG4x0-ESoKqIQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/10/26 08:01, Akihiko Odaki wrote:
> g_ascii_strtoull() accepts a leading minus sign, and returns the
> negation of the parsed number. It also accepts zero. Reject those
> non-positive values since their semantics is unclear.
> 
> Also reject interval values with trailing non-digit characters, such as
> interval=8a.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   contrib/plugins/bbv.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

