Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9216C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DGG-0004mq-ML; Thu, 03 Sep 2026 15:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DGF-0004ju-SI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:38:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DGE-0004ZW-92
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:38:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2t0X1698750
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S3hRKUxPEpEVE2SXPHPao6yblaIE7uT6qmUdgyWCUiM=; b=VqcgYS31TX5cHU6M
 FHotpeleaIyyR0FkUfu/DjN2jh4EK39UMNQLvTpNYfhLBcqLx03+1uzY6DKdgsOI
 d5RIX+C0Air8+0bM6bFVwu6pl0GBRk9cOwqjirR1/3747nWnTOzucZ9KlGsN4nTm
 XaAnBkHWjcw/phc9kkfsqUAKlI0sHb7qnCT0wHTK/P70tQl/HFRhruSI08CrnHiK
 wHyrKV/YMYptrvMiDy6cqYeGpvNdbh9y/Ala6jNLJbGT1xLOyFe7BTuIg0iL91oW
 LfxezQnKoXlYu7e7eXV6/O1uqJGiF/B0R9/qAchW8iOBJyGoicprGN/3dLpKbckE
 ZtG/pw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfbyvh4aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:38:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6c166bafcso2628095ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464288; x=1789069088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S3hRKUxPEpEVE2SXPHPao6yblaIE7uT6qmUdgyWCUiM=;
 b=jOii6moYE3bLGoMOW6VkgQlOeSyvg2afxA/43T7oZxnxZD77iUFosXFFhZ7EegAWLO
 Zx5QCX25wOHJTD2CyYZFggK39HKThpbIiXfdW+MOYrVgitwAriY7+MpChXviBFu3rbWK
 bhvA9jgzCKdkXtXjlqezry9xqwtVsYsO4bu3nl8xI9K9ijN1zYkMN7ijxDOS5Y5/OgPP
 N5P8ldScsIE0S1xF18PxO44jtEXJUk8K7ou1gU+HDADh5OC2fqQBz8kWP2fl8aslysfR
 4kAgIIZ/Wp4nRU7hJ3Lmj4hCLaZZiy+z/270FQ/TgX8I16Ta6fHvXB/HKuKV2jZv7Jjn
 7OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464288; x=1789069088;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S3hRKUxPEpEVE2SXPHPao6yblaIE7uT6qmUdgyWCUiM=;
 b=N5jf/BnmHZ9jQbXeZFk0O8tvT9AP+tMDC8kX9cu4fhxjV0OM3gqqfnApYv8HddA3Yf
 QepDfwmdPcM0UojQrg2z54YOadc6dQJqvYqSzU3GWHD64YXCDEvU2LG/awGzS/D9wMGW
 dyyhFLbHWw4HMwtR1Is/sUVXxH8NF+DQCGB71Tn0lgO2lxJlh7lwblHS261uCv2wDhsG
 x3mreHCn0xhy5Zlr0xQeP9/Hix8HuzRYoZzEgvU79pE7nxKc74kDFspj/tnY9Z+qdu8r
 1TPwFLf+wyTO0chVbUxD6lK8d1xIUvfqdD5TUTfdhM1vsnkJbKma7v38zvfyWJskPhHP
 TnNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8VcFotFN6xDkikYEFNsv/x+OUFxna/5DInvsc8ZgKUUdlZOoLD80pBxzHmie4mEUKp1M2TZBORslo@nongnu.org
X-Gm-Message-State: AFuF++k69AzQwCz9PP1/vr70FS1603ySv9D5bi3LJU25QkGzRw+HQeXf
 Mgwga2dNgOYEZTXZ016pVJsvac7bwEfTwG0rhQ8jNjUNbVuHX581YFBwS52ZExZCENFq0IVNF++
 HTZSszRwXG9Rq/9dNiYhHb/RFlV6KfPuIxt0M/bfx/t6/hEAE/bc9bYcaDmQbXfj80w==
X-Gm-Gg: AYBFou2Vh0DWPhT3L3YAe+7SHLD9VgOU6ejE0ZGyeSPAk1JRC0nd2xjrhJxe57dCO3P
 lWoAJlWXLwnA8k/gsixms/4clNaLDdA86hRTwUOQsCRophsBw9D37wOp+Jj7pPylEg0QCxH1HTO
 cOBUpmNjg2HhSDiz9gVGduxOAogqhrv4LH51bcbXJxDsJ2PTl3aDugdD64cWhKDTzasQZp7kWgF
 qov5KsLqg3n+plQP8q4V0dZaSC6GIeD8/4imNoe36RGI+b6P+c/wC63zyGqAv0VeerGE0x89VrM
 YnJhc8HlwkiGB4mz66T8LYcQPRjCJXYP0+xxYOu+K5GFHghog4jvHvccveQ+lnUBAYPxqr2lRM9
 7Gn9B9e9AYI9beeQ+xNOIsYA9LI5bPpI19pAk6UAWqQv/KsQSZnUS6rsLBu+MkpF087iu
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39b26277b88mr1184712a91.24.1788464288199; 
 Thu, 03 Sep 2026 12:38:08 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39b26277b88mr1184612a91.24.1788464287538; 
 Thu, 03 Sep 2026 12:38:07 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm1467811eec.15.2026.09.03.12.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:38:07 -0700 (PDT)
Message-ID: <44a65a94-bf84-401a-bd52-227918e4df71@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] tests/functional/hexagon: add tests, update to v0.2.14
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kAIYK2KV43bYR-xTDK7-RxONhqcdnsD7
X-Proofpoint-GUID: kAIYK2KV43bYR-xTDK7-RxONhqcdnsD7
X-Authority-Analysis: v=2.4 cv=C8vZDwP+ c=1 sm=1 tr=0 ts=6a99cca0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pVJQ7gXkpIIi7CwasY0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXxu65mlUuHXOL
 o7rL9jPMglKWWaUR+wz0V/ahxOo5Q5ht64c1LvmbSl9OSzTZIG6/Wt/B5BwHd8S+Ft0djz294Cx
 DPGt9LAIS00vYPi1Lb0I6ZkfCdrHNipuhn3CxjWUVho4PyEzTrlQhgFkI5189wkLECiu6LU7uO0
 1bzdO6CTzH3lcVGU18lc/TKxb2Fk5hRu5bMpHkNZF6OWTfLHHTm2aTBoKtcHQbWpQ1pzZ4fOsPg
 OwpBL+D11AuLXP9NyBn2iwXLdOqK71qDlP70Y43d/nL4lfvenJeQw5UBBEQRdLU0wybkJv1CHY/
 LoI/rpS2am15prav4kBXru7ipqDkAJ70VSDlbmIqN8nz9msMvubDbUka2ZUQ2dM/PMRmwDR2lxz
 Au6ZXOsLFgZy+Z5Ccyq8ex6fPrW8nJxQ/YoY4dYRfE7LHn+s0X6A0ITH/itHqncWyu9kW1KfgVg
 zWzA/5WNK1/CeG8qZZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXy8mTX7yE098B
 ctUtCt07SyW0XHF07eEof2hXYQ2jTxqDkZORdJo0ly2e5E5V2hRxygS69eM7e/c8pkwtwmaGz7j
 DRp9NNkpEbCi0ij4YpodRnKSMr7/9KE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030170
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> Add tests for direct-to-guest interrupts, multi-TLB match case, {u,}timer
> registers.
> 
> Update to the v0.2.14 tests and switch to the new 'sim' machine name.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_systests.py | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

