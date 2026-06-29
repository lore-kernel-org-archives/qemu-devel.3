Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F051C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEHQ-0007Lo-Na; Mon, 29 Jun 2026 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEHP-0007LU-3Z
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:52:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEHL-0000P1-NO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:52:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEmm2579138
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j29m2UrJ04Etvd7Ajv2/N7V451fUX+g4dCXg2H2PPTU=; b=kzfXSQ49XfYMY5Bb
 8BMhhCVAWXx2gg3rGWHMcjBszlZyhms1nSO3Y2h8Hxaq29ulpxvLaXt7C2Vujvwk
 qmhR01cu5eDaabm2VE9E11CvSwzLZCkp2lvScqsJgkDNMgbyBG7wogI6RtzmvmHR
 ORSnmHr4pXMTKdMNMBr5kAO33RFHAFV8/RdFjTXpyX0btOMX4H2y+7EQPXQzZWF7
 SK1y5sejqfdmSe/Umkglxz8qxHQKVOmWyhPSsL7sXYUauHi+Y3FSLxGr971YhYuO
 CW0jxd7ap5EYNUUu6KqYQj3cYZA+FH0BsbeS2XfwgZfmqOIuZOnL6+KoNHuVFt75
 xOfL7g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7j7r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:52:07 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso5716190c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782748327; x=1783353127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j29m2UrJ04Etvd7Ajv2/N7V451fUX+g4dCXg2H2PPTU=;
 b=QyQkWHYg6LYw2c/MjxPfyAryvlPtP3KXi1YewYV3+xweKVx1vY3u5foOaNThBs+79M
 OEym/mPnLFXTQz/tdSgZt/BcA+HHx1ovMDsoRt1rQb1FL08bQLcAUyK/euwgwsXxl/sM
 L3TWxi3GCkBY4aM6m73nyhYGLysFf1q9KpqOTUwi29cmIgGTA3hALyBi53NmJpHCnVqm
 xWKxUk/5MQnoak5PsGg/c2u7nHrwKothh7WBxkZ24iFuxH/8S/AmQVqsgN/SGkGjYyQu
 6lUzu7GXhpKAUN1yYXoYD37oSGWdGmpK8dH1VGSqJorC84/HhdU/znc8rHqHH9S47yEo
 bGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748327; x=1783353127;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j29m2UrJ04Etvd7Ajv2/N7V451fUX+g4dCXg2H2PPTU=;
 b=ekIjz9T0GbPepLGBglG4c4erYOgzcYviiGgH1QPxX6SxzzXgOEJdvV0BsMBODtEihK
 SYg4Dfm5/NvqTTz1uLLSnRnOYgbtS3VFW/hVhQhc8HP0w3scOv2vasMqqGoqgAGjBSXu
 nLF6/GgteVf+RCDRmjG8/Bh4SK1NObP2n/wFNnF8TgKKLva3ADip6Ty8xtMKieLYBmx/
 5SWJBNCK2/bkrnYl2MEyTgdMdzKnXG+wILAz6WFLB5BsTXEq9c+w+N3z82J+iYKq1TXI
 LkhtAHYarJf1KmZSxPEocPm0LMizK9T9PN59fqgtYl4hGi6m43GOhEZW8gFZ2zKl9Nnz
 bKsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kKMFBT7MHQ6dBIRPAQbVsO5tHMQBwPXjZcVOeZMMoSLGl0SL4fQ5j2SaqZDkZ55XGj+U1PejHgL9r@nongnu.org
X-Gm-Message-State: AOJu0YymZkj6PHy4G2P2XR9wTy1wUjhg+Jfuls5WPUq5bWIDjer2vtxu
 SY38+/XCeXIxP+m8Q9Gq2HjOI3P/DKlGBaURaypTgz6v1fghV33GAFdB6C7qZeDrvGQLdxH0cpQ
 WQbGaZ2c7r7Jy9bSJ3HxFdRVhsz5alfxIrLviTXg7zW/BzSfqR+rcPFOPmg==
X-Gm-Gg: AfdE7cnkzVxEs6SHnvUJQUPlCJdSPW294cM4/nLJkhf9e1da3qzDARCPYgJ2/CX1/Bs
 XKUh/hNyS07gxDI9gV1nGaSoEdA/TQyxX3+El0Yv1zi1Vx9XTJ7/d3fq3gvr/JQR0bPz9rWqygh
 rDO8GGqRbQZkWkNF4/IyS3V2zSpqdxkiXVj/IHOT1Do8YX1MMB9s4ROO0CEtzASr+sH0sTgvJFH
 yd6qlNyZ78ZpCXIVPzSQ2JWGbnNISLZMr+XiIzcN4RJ9VB8xX68GwH1G8dmov44JnKNzeM/VLXf
 XucYVZ3x20i9NvXR1zMmAjVlsET9yBGx9P3huNwjS029eRNq/3K2F5ViO9BmToziApT2J6MR/7U
 ztmgwUi//n6jgZddvWs+LKze/IsJTXPZiLd4SCVFMV1+iKK9HApG8lSxBmXlQq9aJluBQTzeM2J
 Z7xKE=
X-Received: by 2002:a05:7022:e0d:b0:138:1130:5fd3 with SMTP id
 a92af1059eb24-13b2a13e5a9mr17885c88.10.1782748327045; 
 Mon, 29 Jun 2026 08:52:07 -0700 (PDT)
X-Received: by 2002:a05:7022:e0d:b0:138:1130:5fd3 with SMTP id
 a92af1059eb24-13b2a13e5a9mr17843c88.10.1782748326332; 
 Mon, 29 Jun 2026 08:52:06 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46512792c88.7.2026.06.29.08.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:52:05 -0700 (PDT)
Message-ID: <882ff78f-f927-4ff0-8c40-7b9f00c063a6@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 08:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/system: add general note about architecture and
 machine differences
To: Linisha <linisha232@gmail.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, philmd@mailo.com, berrange@redhat.com
References: <20260625192121.1887-1-linisha232@gmail.com>
 <20260626181118.1136-1-linisha232@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626181118.1136-1-linisha232@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX4h/ZjIqzjRTH
 PUPnT+ez3IG6dWYNzEl5wCmBcJ/TAiWvNgqB6VSEcEhuQirRtCT0gbQ6Mnc4mXAgWF5nqiu2mKb
 QD8EgHmqOZL/BjKEHBzm7B96Yq7zRy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfXx2eZa7h2z9Ny
 vw+mP5aiHafu+ckjQPT79/kxsCXieGZ3xSouvCy5psx6HO/GJ90JPxrck6R2TRIoEM0/PCnrHFM
 IwV86CtZnBgAE6nZZofhqlalnEvGwdNUHLtOXaC0k7FyYAaCvqHhK4+Gw4sktbcs+oL1FI5yuN7
 TPaDdUCEG3Sj9qwJUDhGLssmjFhkENE7A6iNgZJnDJOgJkKSKofoLsaaiJdsnY6b1hRNCgjZS4F
 E7MN1GUgLW9CHvpFM0R4r8o52Um++unLbsOVzLyPjMjo2vkaS7Y1ZyXulTJMdjHO2cxAW5eGXQG
 lVexWnxLVkED3b0QQjCgiW8dIxjsyaY5so81nyO53ttY/S7CNwk8uTeY+wVyS24/9CUeoY3cok8
 vvSe+EF8PPLaSpWuVzRT8ZJ0HOYjYXuaY0X23I2JeOkHG1M04hABIOdl3yYQpsRvs684Ws26brj
 +KgRP8U86A4ifiW8Q/Q==
X-Proofpoint-ORIG-GUID: CNJ7nxBQ0myfkxtvdtKYuWiAwjJF-vQh
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4294a7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=eUfwmhwwi5oaL508dmgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CNJ7nxBQ0myfkxtvdtKYuWiAwjJF-vQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290132
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

On 6/26/2026 11:11 AM, Linisha wrote:
> Add a note near the start of the introduction explaining that QEMU
> options, properties, and command lines may differ between target
> architectures and machine types. This helps prevent confusion when
> examples shown for one architecture do not work for another, such as
> the pflash0/pflash1 options visible in -machine help on some machines
> but not others.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> Signed-off-by: Linisha <linisha232@gmail.com>
> ---
> 
> v3:
> - Wrap commit message body at 76 characters (Daniel P. Berrangé)
> - Add Reviewed-by: Daniel P. Berrangé
> 
> v2: Take a different approach based on review feedback from Daniel
>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>     machines too), add a general note near the start of the introduction
>     about how options, properties, and command lines may differ between
>     target architectures and machine types.
> 
>  docs/system/introduction.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

This was merged into master (20553466cc47af6a8c95f665b601fce3c852e503).
Thank you for your contribution!

Regards,
Pierrick

