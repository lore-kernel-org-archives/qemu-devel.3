Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EFDCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUGs-0001jr-TR; Fri, 22 May 2026 14:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUGq-0001jI-TN
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:06:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUGn-0007sR-Uj
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:06:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MC1ueG779268
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +hVL5Ts2z9XkgT74zT6tJs93oOwh8jW6BRg0Q4/31Qo=; b=LMgoI1qe2n5fvZyE
 DspGqq5KUucZfFgSNbY1R2EFW4Sz7fZyN39YBdkWwC8Runls8Humm6ggLXG1alW4
 Oh93QMoymZ30HxqzFsxbx6fPS7klRIS37hel8AgLrHUfZjwxe6dpJ7zhdl2DJhd7
 W7q0fUuDLGeqTcevef7QP8BF/P9XthpN7BFpe9CD3vKfusmuvc/IKowEFrim9Zuh
 udThSFG5pDM9tP26i+P6blynLAPK9Gq7JhneRfkJrlnk0K+o9mqF80kVV3Z6OtuP
 u3ijbR5Picci3muV/YNxNYsi7M8RaVBmeQRCwa68IjwPDumF2vY5PmxQguidUr+M
 ZQymvw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7av2p5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:06:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30457ff05b8so681148eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779473208; x=1780078008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+hVL5Ts2z9XkgT74zT6tJs93oOwh8jW6BRg0Q4/31Qo=;
 b=FQMMMw6dp76PDkQ/IZJch6B6jz9OqIxDz+cwsq+xGzyEyyGHCYsphfKho0mDCRl86c
 A2zZOVC9rMUt5TR6PDJqJZWPNxcFsptr0+HP4Dn1sA+dtd/ump8C8GfpVXDrk1blGlWM
 dBgpsbU51A0aKo7E/5U82ClovzN7Q2hli8xsoOC9c9ZvJaGhuXDtjTYur9KHfYP9+912
 enoy6x9+cVDhBP6rDZrM6qmvr+BHHVTWSfnGmvPi0ToB24nVpBfDJEF9kLc4idA1Q4GZ
 A1i5crPu+9AqotaFlbo5hplUJyESnHOTZcdTGmj8kBWx0uB0+LXsGumt0gd/f9W7SPO8
 za7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779473208; x=1780078008;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hVL5Ts2z9XkgT74zT6tJs93oOwh8jW6BRg0Q4/31Qo=;
 b=O9Z2xbAH7Usx9DpYoboJzXGrE850xUlFcbkZRa8RiZa2BCKbELdKPNB0de2ZZZTCmT
 carPM/nl1PYPCwirtkeO5n9P1xYEYppGFPlN1RyaraKvHBf5CsQ3uwM8HFJL9+/UXHAI
 MkXhAjckdlRwR49CQ6NTplrbj6EN7kg5e7yPcQ1ypzDmvxx5WJKHFQeya7dNxfeJNHhX
 Fb3bL1Qu5e0S1vb1k/yxiriYo03cZ7sAo2RRztv04+ocABtqVOALlYitiDQhwxRuOL5p
 7CFYtMLI107oHuWXLbAiah1zjVeFzmshVpyXnjdFIFwWeSWg/uWSJgDL7lP5TDlON8Ch
 Q94A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7pNepDMFG3LjSrdlVKBwIdorfAJU6RL/C52hmEupk2KpmNo/EFj691bldaVlNxEM5hhkbRG3jwGqG@nongnu.org
X-Gm-Message-State: AOJu0YxpQSMb7O4QnrmXR+W0SCcm3undh/0MQCTSwMF1mpk7h6XCiPN8
 8yj3RnQvdb78kjpCs6AMaf/kAj9rxCUFB8S4IugsTjcQw63BZl3fdIkULj52Qf7t93n6ZXnoMaN
 MuItEZHg/U3ESNWbtvisu2mhXVW8JYt8FL2s3uDsXLsVD7Xxsz21L3iCx0Q==
X-Gm-Gg: Acq92OGld8tFmUQltjo+aftaAYj9qcvqx6knE5aHmM/g/5Q2S6aPEM4uXZn1WTwBJKR
 MX6ezgZo4Cz2Hujt3Z4U2AtXNjlclwftHFFo/nZ+tQS4QChmXeltz3B0a3pm0ifHqBTOjCrGzvA
 JbIsOL7C+gJPktzBN85s0u6wdiJw+JT3U2rr1UTVdofAQbVkqlZx/X/+c+Y0uB4jnOdYAK/Bu+F
 Hnb6yVlfFb2A66R9w3GiyI/Ju28HSOOEWeCpRT1vffzg02NcOOVAPxdzPdzJcOXI2/LVw1RdzoB
 gW/kuGPuVGUli4Q9RNHB1s+jx2pZo8L4O5rOgJacnqX6d6VcEnjHcgoI3A9G4oace1Z/53d4zm8
 XCO8e2J3aPertI0R5NLzf/oak34qu1jHAhiLQltiyXtTJf4ZX+uz6IakDTOBA5SnjJHr5Rds/lP
 21uKu6NLkZ7j5J6g==
X-Received: by 2002:a05:7301:1e84:b0:304:286a:9e40 with SMTP id
 5a478bee46e88-304490f48bdmr2610128eec.34.1779473207999; 
 Fri, 22 May 2026 11:06:47 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:304:286a:9e40 with SMTP id
 5a478bee46e88-304490f48bdmr2610103eec.34.1779473207495; 
 Fri, 22 May 2026 11:06:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm2017425eec.13.2026.05.22.11.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:06:46 -0700 (PDT)
Message-ID: <dc1087b4-e512-4097-88bb-b72237480026@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:06:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Fix typo (s/exist paths/exit paths/)
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260520-exist-v1-1-535f929a87ae@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-exist-v1-1-535f929a87ae@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qJVF0udwUDYff1kOvvJdipRaeLNCplAu
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a109b38 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=l5FfgNZCFBOjzt5DbZIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-GUID: qJVF0udwUDYff1kOvvJdipRaeLNCplAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX2Uypn4RrHj01
 EirschbRfA+H+wyaYHq+nwecvPtF+3a99RKR8MZLNnB5zOBxqI81npXjr1PpdGBOCaDz2lX4/xc
 BKNrorE7lkYSmpR/5Li5XykPdSAZVas67BHSnjBXdefx9x5azSQ+ZuCMWYRFmjYGvh/LTNqxkoM
 QK4UAsUvQLeWkLUwF5c9rCs2GZnAziKvDe9uxeB6K+uLf659A/fFd5jPaopNLnJfzF8cjdrA+nR
 Y11mIDTfiqMFSwh9eq3MyStqWSWG6vTRcPm/d0KK36MpNlgGAD9DDbBSe4/msDd3rZ2icfhNnAG
 aFMlYFMKcbUYzrxUYy7aUZMdZMueexZW6vBclbJuwTgh+ewACSXKSQ5PF29ExCMJRLS9aI8i68j
 oomWR90J3kRcP0FHZSsXo2qCFZr76nkItTVD7FOaOZT8sww9CnqnkCIelY/GVsrfn5LDYImfKIF
 Eb82fhqUTRKznljgBSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220180
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/19/2026 11:44 PM, J. Neuschäfer wrote:
> In the discussion of control flow through a function, "exit paths" were meant.
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/style.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index b8edcf9316f059fe15415543098118b28fcaf99c..f4da16a0e83ca6fed205e2516fff4ac2cc941d04 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -469,7 +469,7 @@ for a time/space trade-off like ``tlb_mmu_resize_locked`` in the
>  SoftMMU TLB code.
>  
>  If the lifetime of the allocation is within the function and there are
> -multiple exist paths you can also improve the readability of the code
> +multiple exit paths you can also improve the readability of the code
>  by using ``g_autofree`` and related annotations. See :ref:`autofree-ref`
>  for more details.
>  
> 
> ---
> base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
> change-id: 20260520-exist-b23e143e9bfe
> 
> Best regards,

Thanks,
I'll pull this through docs subsystem.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

