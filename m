Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E672C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp870-0002tM-SJ; Wed, 29 Jul 2026 13:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wp86p-0002sJ-Gm
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:30:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wp86n-00043O-NX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:30:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF2TNq1699319
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 17:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H5casXszahOkdiJ6ouqGyxiqSIyoWUab5LhsteLrUAM=; b=bTYr39r/TQkrgzWv
 AdUGyAspDnMHvWoSWkZscyVuo0e4uKQ0zyLqu2ZEOMk/sRBHxoGwPoMwWmaetxGl
 g5ZCkqSPFUllDnMMrdQN3JLDrKSKDxLpxT4+IT4zUpDDo4cnSccoc6G78QeA/ZR/
 LnJmEUTHDzCi4o+unWKCZsrfeEwK6MBU96D6JovEhcUe1fw92xG3GJniKUS4kEHI
 CMv/wNBk7qAju+vPAdKJOsH64NZ9IZ24xdk6Bk1+aiR6lLrvfADlVGoG19l6WXLj
 bBrakPI5k54NdbBmOAVlhoDf9ppf88DIyx3jn+EJ7gG6pN09+pqap2vbG5WXW78J
 9ntmKA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj1tdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 17:30:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso1528863a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785346218; x=1785951018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H5casXszahOkdiJ6ouqGyxiqSIyoWUab5LhsteLrUAM=;
 b=G9f8jTlcwLFw7JldTxjFZzFaGfsyy8IBO2InO++dz4PvSL+izPuv8u+7JYxk96gkmD
 0e29XvmWV7nsoDl2JbcDAuCZ1YDOBR43FTY5UdcTtt0kRoIBjn02tLtQ0U6D/VA40AVk
 luvx+HMd44UW1okiQiOmtLqKSDPs5coI/yTJe1ZfcK8ynudJ5XDRZ/csyW0ZO99Hi/p+
 Y5B65QT2HLxbvyWiobIHjH8kajz+fAwuOTkb8nvN03/7mVPTIw3dFpe1JXFh/Qgu9eIr
 tOXfed0QyBIRIjx8oYz+s8EdZBfwl+Wcg0fZzt3p9iaOpZ5hx0fEMVCeOsB47PTcPLHs
 Xddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785346218; x=1785951018;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H5casXszahOkdiJ6ouqGyxiqSIyoWUab5LhsteLrUAM=;
 b=HB981Hbv+cizLLZ9TqXdEqnsGoQ3MUgPN26zN8GAoUsDMfga9UAvFaWDPD1pAxk/+Q
 +ZSszTYkrV7B+gR9vmMZbEUbF3+jGxx5GHUQTvfAmuPI0VvVAq3ghjE558LKvFHqwXme
 XlkAE9f6rFZwVyni2eTh6ivGmWcReTzNuF76wcI3xSEugITHbvt3bau58Zidv3aiAw3O
 zAVa1AsX51ymRLv0SFxF0i+OmnSLsGH09plzy+fVeOxacZ7zz63EtikrIQY7E2CpAl/E
 lM55SwtYwBK06jnYIW277QNNjz8+7FDLRNaiStug4y9o6qImAunLSoSUT8Eal17GQOcL
 ydnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Romz5bjIkgp9B8Enqa5StcVlse3vmo/csnFCXYhCdrUuvx9+Qv+cQ504cTWMFjTM75mp+x677RVBYW1@nongnu.org
X-Gm-Message-State: AOJu0YyEAi9flvaBl9lTdQF7rdK8rjJnM2xAnwGTh7QL4ICwu6LiKPYY
 snC3worps4HV1vj+kk/3kfoAx/cyH9vJrPFk9hdbOii7kfzCPbRdABe5ZC6BEhuHJbJPMmUiMyO
 +TJA9F0BPFjPz0kGlm1E6YVQIMUzEfPSnI2LrJUuSf48uBbxY92btI6sbLQ==
X-Gm-Gg: AR+sD13I92ZSXEJ1xdjDY9b/t59sOQyVkLXIBsNq/Entte5a1XOeN/NHzJoDYUp8DWy
 M7pfw8/wQeFibI2BL31bJ4ELmTk6H+HEBE94itX/21gM0qB/D3v+9SB+kC4RGlSZc6q77XPmxEy
 tlNT3jzWHqdNYStQLChZlH59vEtIxd0Xv6wLnp5QxwuLk2JcoLJ9lMV3BGPfc3rNHe4/DV5jcW+
 HoHcp/XyeqcDRzJ6juU7PS/2f6hM4TNRA5GANgNY8bq9PYb7IC5wWa+ndgp6VoMftH9Lxnuy4lX
 Xu5E+V1HnaJMCe+HqlLewJLX8Ne/Knn+paCNaf9czzHxgO4kzyoV6jZseriAU5QqJ2rh0rILyOe
 Kq/KEhcKEGhfhPONCc8IBO3ljxlhhpF939x5DCu/rh1b6D8z1SvU7o5ne5Mmx84obnF3v
X-Received: by 2002:a17:90b:4a86:b0:387:e0cb:c8da with SMTP id
 98e67ed59e1d1-38f6a45dd52mr6504911a91.35.1785346217864; 
 Wed, 29 Jul 2026 10:30:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4a86:b0:387:e0cb:c8da with SMTP id
 98e67ed59e1d1-38f6a45dd52mr6504897a91.35.1785346217393; 
 Wed, 29 Jul 2026 10:30:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d37368sm21859092eec.22.2026.07.29.10.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 10:30:16 -0700 (PDT)
Message-ID: <f48912af-15f2-4732-afe9-cb180279e2d5@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 10:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: do not emit modules with no enabled sources
To: Rohitashv Kumar <rohit.kuma1313@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Rohitashv Kumar <roohiit@amazon.de>
References: <20260729150420.632747-2-rohit.kuma1313@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729150420.632747-2-rohit.kuma1313@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a38aa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yX9pvZ6cGgldRaZeu0QA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: CJJfq0Nsg9d89kfti1p1zxFkLS_MACdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNSBTYWx0ZWRfX40yzU/I7sM3n
 SuB6RQTLcKIZXJ/tvcvFa70+07E/KkGgqP+e/yxMNnRCpxE0AFx6gI+VlDtXB6u74y/j5pUFLRn
 GfE+CHZejtN3WW0nXrClXVIpjbNWvKSvmUA1bwynHRdQgzfnyT0LseeET3Sy6/d3uu9/gHh8e3C
 GgB8avEqJmvgZj4pvL0ctFjX6zSDQNJ3oKZvYBfmnjISr+ArVdT+e/9VZxXipAE9Hf7EVWRyTRn
 5Wc9rsMsaasSufqGkN8M/vsvtGjo8w0gyewYrwiAALXXwRboEgpMgS6wGhb8QVD34o8c2ItJDIK
 P034xadvyLw95n8r+ahbsqMJ+Fcoa7Z9zqfwO8UFCvwyAiQwwZDvGNAU/Di7pBayXrieF3g+KGZ
 GGZOFOLWeSwIBfZkO3x6LjYig24yMOw308PQQMviNSpYX4mjY+eLFCls8ZtTPTsIyNj7xqZ0t/A
 cyr/gf44Ge5Yg5SWU/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNSBTYWx0ZWRfX8svgPe2is9At
 PPh5TKT9hWZiaEfx7Fg9/bC3dtKI82GfJEXsInDyOibI0sgwOI4HCmThThlRTx4ViFNe4jKMZ1F
 RLqLJOmm83js0gdimRE/OXgDBMwnhpc=
X-Proofpoint-GUID: CJJfq0Nsg9d89kfti1p1zxFkLS_MACdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290135
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

On 7/29/2026 8:04 AM, Rohitashv Kumar wrote:
> From: Rohitashv Kumar <roohiit@amazon.de>
> 
> With modular builds, the system/block module loop adds the common
> boilerplate (modulecommon) to every registered module and emits a
> shared_module unconditionally.  A module whose device sources are all
> disabled by the configuration then still produces a shared object
> containing nothing but the boilerplate: an empty stub that provides no
> devices and only complicates packaging.
> 
> This happens when a module is registered under a broader condition than
> the one gating its sources, e.g. hw-display-virtio-gpu-pci (registered on
> CONFIG_VIRTIO_PCI, sources need CONFIG_VIRTIO_GPU) in a build without
> virtio-gpu, or hw-s390x-virtio-gpu-ccw (registered unconditionally,
> source needs CONFIG_VIRTIO_CCW) in a build without an s390x target.
> 
> The target_modules loop already skips modules whose applied source set is
> empty; make the system/block loop consistent and do the same.
> 
> Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
> ---
>  meson.build | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

