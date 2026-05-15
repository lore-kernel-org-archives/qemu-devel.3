Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024C9CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvxh-0007VJ-VX; Fri, 15 May 2026 13:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvxe-0007Q5-Ns
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:04:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvxc-0007UO-Qn
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:04:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FB9QS93671116
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JzPzKh7Pvjqi8CKz1Dmi99nqloKUl3igNNl0TR/AYOM=; b=lvE+zR/dkz0cX3/J
 kNpjucsGPK8PmhF8n/dKIRsXM//JbmFLD/Zum7SBuv6yyg9VJDwpKYRCjgFrw69m
 TMo9E6EEXZgQbP/FeT5MmLKuUZ2r28VpXgvKxJbm1Y5IFSWVj25ajrfxD/M0efGh
 UDx4zumYZKHPKtETNjjc51DrcTaoshdBVmRxZcMCro0qYxGnxis96Vw2jGlsb7K3
 i7bgoFYiZh5XUjrKcP8ogPtzejiOnmaZpWzjGHEY/lVI1HZ7/6Ej1DL4DjByz419
 dqHqHK7sKBKe8PDv9PCCvEDNsygvAZFSed+0kxnJimCmFCz1/l7os7agPfjFFFZR
 PiQ0Fg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s46eh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:04:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c16233ee11so48870eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864666; x=1779469466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JzPzKh7Pvjqi8CKz1Dmi99nqloKUl3igNNl0TR/AYOM=;
 b=YS3YqwqHGKOYcJMEI7vs+fZzXsrGFzCjVONc73Axho0DvhTZWqmaBM9xeX/ARTUeNf
 j69Ns/6qJapuBcPH1k25vTiueSyNnxDJScEP+QzH8fKr+RpNPYsHNrCBm8znhJ98JWdC
 7zgN0akzcfM4JWIMUMh8jeY0/g/7lViZTSnd6KktJBH6hShJnkDMkawtiexcHU/M45bL
 za1cBtIVcvUfSw3FRDYaLppcNhEh9pyg1lD0FqQdmn92kVoI4CZWBYkQP5tfMgL6LxwH
 0OFN79aIaIQYB7SGvdcj9EiOfJTqvZvkSDUs4/b4Xu4dCoT6y7ZVsyM0lws7xWRP8QZk
 90HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864666; x=1779469466;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JzPzKh7Pvjqi8CKz1Dmi99nqloKUl3igNNl0TR/AYOM=;
 b=HXJflSl1op5OpkcUzDqE5NbRCqwLawSOGUu+3tYySQG1A6YR4bPHxS97F44JkD/0NM
 S2YxzzpW+/ujNrvLeHlaoW4+uHDrDGjW/ARa00Inn1AIwLUMjAepEC1ou5MHdaCXCTb1
 9GZRA2ZM70oUuTKCzHOblBb3B/AVoCqVDzZz0gNzIz0v6EAvmG0ODNXTVYy6VpHkagnW
 g9LVOcqYj7bSmKGDV9sxM2vOj2Vl5LWgnUcOEMhRT6GrpP+Emno/q7jaUtGmopNFDPEK
 q67VoMAyDHCm9WgPG7Zq2zuWTzrReSWTym+zjvKsCJZs9UbFvZmZmstmhRCpx0wC1tgw
 XpdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9syN9R6QJIIArGZiwM06sBfXGoR1qf6zSPLDsEGUr20vJ6z6W6ij9WYpgovPXiyrEg4yIG4z9rIcDk@nongnu.org
X-Gm-Message-State: AOJu0YztdHJMIYHYO+4w76SFEDtVYcpzctT7SCp9oZ10GKxuRVr8nJwn
 sEbD9udZ9LAe+iCStrpLWZt0Ina1fb3TtIaAEteUsvKLr94HMuzMLB9aY6X045fviVDNPsHxZB2
 hs9UWwPOuB1M37Gyqg8jiApidEU+GBI18lpi9WGqE4qInrirWEQDg4KjD+w==
X-Gm-Gg: Acq92OGNX37sh6VkEozQVy7cbALpOC/LoRdtBf8tq7hhrI0xCE5ELm2u/G2eRfgMpIK
 bqvlNwX2Ht96SMEGXunpNM93mPcJY5v9AVh3sevpp6POo7eVJAH0ZHJrk83/Z6YuVofKhQ91RJK
 eNUdRzjSc/8AFaCO4Rzel16OoAbdFxh0TduV5yW81y1556JBmPVHC3HkVbXk1K2AMD6rQm0EIBK
 GtXtq0uhs7+9k0m9fx3tEuE1SDXIjYd28e40dAXjwRrRV+chm7qWBn1XjInoBTIudPL7NxUDueb
 usBMbDbr6XHvyGH1saI43s9cHLsAo5cHPyPI7QVbnP32X/Uo35hpJRrJ945/khjzh9ATDl7RbrW
 /VjweafLdR4H3jbmibtKlqWwQXAGUiMwY1cV2dA3Yz6tDO/6iWoXv4rmuAGuy0U5XCeQyps4Qq7
 EyMiZzBWBF9OU8ww==
X-Received: by 2002:a05:7022:68a5:b0:134:fc38:6bea with SMTP id
 a92af1059eb24-1350563cc92mr2324637c88.31.1778864666019; 
 Fri, 15 May 2026 10:04:26 -0700 (PDT)
X-Received: by 2002:a05:7022:68a5:b0:134:fc38:6bea with SMTP id
 a92af1059eb24-1350563cc92mr2324603c88.31.1778864665368; 
 Fri, 15 May 2026 10:04:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbed2232sm11226486c88.7.2026.05.15.10.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:04:24 -0700 (PDT)
Message-ID: <2ee2bdc6-dd70-48f2-8409-2bbb2530c559@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:04:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/20] target/arm: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NCBTYWx0ZWRfX/XgFAJEmJyHp
 gfiRFIZ3tiWPf0YHQEqUvA48ylTK+K+IWjZYrB63ZUuRkXkowjl+x/DxgyorTmvIhjwRbD3YSZ1
 Jre/2A4g59NJ13Tj7MG13t7lYPXNGLy4CV4/PCngQ34hPJHG8IXTLkOd8fM35lKUgALc7HGo2lB
 4A0R9byGO1B0f4MspaLfLjcGVMBgIOgVECsXvWQCPaen05p309wU/51bVV3rGkN4tq08SH2vO2l
 Ba3ZQ14AzGtqPendBTY1PmTwU3LMSJ+KV+S/yNgAXikKU01eS8jFbTYeA6+cf+14VzeEwwVZyIt
 f3tfIuI0dZlmyLDZ+Y9bM4pcpZDBRRKmxp3MmWyONI3hPOwoo9gEjXwlQw4QLgZ8+2imsZhBqjP
 mOW+3YsGAT0d/IdXqzULWFQt1NnQ8scSdPfNK722HA/YQTVPlBkQfnPxUX8skvUcU694PplQuog
 N94PhB3SQ9bnHWjJo0g==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a07521a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EA1ayohM-yA4xSnK4CEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _-T_CA8FJCYFxaRPPkVXwuj4UDnNM379
X-Proofpoint-ORIG-GUID: _-T_CA8FJCYFxaRPPkVXwuj4UDnNM379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150174
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Introduce a source set common to system / user.
> No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/meson.build     | 21 +++++++++--------
>  target/arm/tcg/meson.build | 48 ++++++++++++--------------------------
>  2 files changed, 26 insertions(+), 43 deletions(-)
> 

It crossed my mind, and finally I kept duplication, without any real reason.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

