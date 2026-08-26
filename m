Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F9C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHHF-0007X8-O0; Wed, 26 Aug 2026 13:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHHE-0007Wo-Tv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:19:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHHD-0000IV-Eg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:19:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuj2w343353
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TiMaw2Dvi4pIcnqx6g+loHEZry4n51sB2EsiQhvI+o=; b=MFE99XxUMuYxnnAE
 ZuXy4U5Syy/2HIjIB00kyAETsDegy0Z6pWdDZtZQc0652uJItOI9MGhX68UvUNTV
 4nKAOXRsjSLgQuWyEnC2tQ2/3YlAKYCTjvV3oNk7LP1eiWfKeWGf/ZuVEwOjHZ+H
 MHBLDTwSwaqU5N5vxa7g1ilUEIh6/NLF/9zWwfYYwyc5ITKdkVZzS8zPdjxamcGd
 4MO7VEwd72/4vK5rqi3zwOnDnQg4hO1+fdbnV5wKn+BAdDkvQQ+D0nZqUJ4ojHQA
 l8DMq+xDfBSlI6VCBD1KJR5L7sv1qCqiPo3bbsq8jrFI60uY9h2IxFdxlTqhRQ49
 E9PlVA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9utht918-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:19:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso21616001cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787764673; x=1788369473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1TiMaw2Dvi4pIcnqx6g+loHEZry4n51sB2EsiQhvI+o=;
 b=fE92fORmLYtCwjSJzBgCZ7b6pMo3CeSjwmv0lgK6BNUVEHKQIYRzv0rjbsliCGQYtU
 z4lMpdBszI/5GI/lRp2lm8uZgakH+5jR3kcJtf0/24HdOdUAeLRPws7uI5m7aycVQ+cT
 41kaXXfgZ/OZo4sDEUjEtFHN9N0NyzSSaX3FMeeuPJ8XcDcRDQhY75E3kOMMFLs2KT68
 Q5VTcmnaQJZqejFKjMFT8C4Z5Z1A52t/YiaK4y+u3DmY6hgRBAi38P+x4bvWdrInuo+v
 0+RMIz7pfz31GviHg4oQSLbcryr+T510hkKOSQ2MN3OWdWFOa03kMx4AcjLPxTeU6bET
 h4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764673; x=1788369473;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1TiMaw2Dvi4pIcnqx6g+loHEZry4n51sB2EsiQhvI+o=;
 b=d/CQEbjvus2GzBJsW9Rung+8o3+YIIVRUifTCbUdSpcqXwvGE9XyYXHNGYEx/oK0yx
 4gj9ZB1gXOsEBPqwhtzXOFQQz6l30rPoQU6ndz/qyX5kWhJDx4DscoXCl00yGac4cOcs
 cVjFTi4kq17ZmwwvpR7MDj4m8Z6+JXhxHrFiXxWo/aVn0uPZoMviYJm4FfgzCpPrGrIi
 JuJFtqsjnKjm4pGcYvOpVZ/hTcHESQGYo2bhmc/A9dXKWmH1V+Xg8OXYlj0ExaNZM6PL
 Z1PemoJbJRudJuJu5L3tUVIz01WZ3IycU254RElViVQ3Xyi7Rx1Buo0FvO4JeJDsBUNB
 5kxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpv1MPsgjHdCo1ZGSKUb/7hYvG2vveL53N8Op9dM0NnblJ8s4rWeePh3XITN34mUShHyOMuyhuIybRf@nongnu.org
X-Gm-Message-State: AFuF++lXS3ETrcUJx+qB2aL+advyjXGFmmU5yHxjoxkzcA5Z95YZFjV8
 lbpk5tef77kXJH88X86XXGR7mrErbDdo9VQ3qXQStNzM7hWnl3NhRQhoZIwBXp79LMmh0UEVK1l
 FlrmtG0401lpeskiNBZc2eZS7YOJAmPQqP38HyMiJhb9SD9aSLRhzEoOhpA==
X-Gm-Gg: AR+sD12kbG/gvK7+kg1AuiL8eBlO7gpNn6XbUXeHT5YN5YhDe4cF8NB/ohcML+pK9eY
 KplIooRzt6oppOjvOTULvSW5zjrHdgnPCDid9TFHlXVjomSus5V69oYmH0f812+Xpay7L9BeGwu
 JXC/V9Tek8pieqHEKGhy4O2qBWnosQaN1v0su3tYYKB68ywlbjjxg328rUdqGP32EvEeRZWTmqt
 UTglO/FfDv3PA3tEjrA2qFqJjg5mge5JGBKXbFl8bet1JOHbctKPZzUE3jGpGzwAexiatFDci1h
 QKdiCYUKycTsjjRGY9u4u38ErAagEzIERL356BuELQfsysLp1/1q5qFzQclebhbtHtcGaes7Y8f
 BjFosE/uqy4dMNS0io4K1iZ+X+VVgKCYaCa5Rq0OwyeBY
X-Received: by 2002:a05:622a:408c:b0:52e:3a51:6fd2 with SMTP id
 d75a77b69052e-52e424270c9mr99768381cf.31.1787764673418; 
 Wed, 26 Aug 2026 10:17:53 -0700 (PDT)
X-Received: by 2002:a05:622a:408c:b0:52e:3a51:6fd2 with SMTP id
 d75a77b69052e-52e424270c9mr99767651cf.31.1787764672989; 
 Wed, 26 Aug 2026 10:17:52 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d62dfsm568566666b.4.2026.08.26.10.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:17:52 -0700 (PDT)
Message-ID: <0c976f3f-69e8-49e4-9e35-8f83700d5e17@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] hw/riscv: trivial code dup work
 (riscv-server-ref prep)
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f2006 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Ua8AA0hPmmq0itHzqabZBxcYdxDA5_Wk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfXwJitFHGWQJaD
 /msMBsGeXwS82mm1e7W2uzvJ1ZIjpe4+PzpnGntiSgvzjFXBVoPs2mwNjyrRHyQNfQ4aTOV/PLs
 BNXndoTSIInshLfb5MWegTP2IlnA5tTyAQLlnGIJ0D4fdq+IR6BVg61EOBDT/foKgdV0xW5HFis
 FXkRDCpfRBAulFmiuMgB0Lq0EMpaL3SMx0DWzWTGAzhUtcBTkVjlo0ERQg6aDuwLam239J/at0k
 F5SQD1sbPcjt88N3K3ZN37sGaloaDDiAr9jYK9QTk28lYm9H2PDhJiJSxKmHRdUECUl8oSJvP6B
 FCbc8jBywZsVZf7Inz3lWlHJpaBTuD8sQVq5ku+a4j5JNBJk/HpFvyP5cz+G8rmRjomLVsqBJ0H
 VgwKI2GHN9gGBYxbdzIu3D1t/m8HDC5hmkOBRE3kz1xCx/+ojO753CJw5+WAZKYYKukIbqLuwT4
 sRW+/sq7rTlftaemyjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX1oX3sbMBjicL
 aD5jy8uf8D7ekba/gINcCjOXo+hkxJ86H3TeMcJSBPKupB92Vkdn2vqOYbQSxKcUi1SnbJeJ8lx
 LuIpTysLyfb0NpAwCoSThWZx/+aiWPs=
X-Proofpoint-GUID: Ua8AA0hPmmq0itHzqabZBxcYdxDA5_Wk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 26/8/26 18:48, Daniel Henrique Barboza wrote:

> Daniel Henrique Barboza (13):
>    hw/riscv/fdt-common, virt.c: add create_fdt_flash()
>    hw/riscv/fdt-common, virt.c: add create_fdt_syscon()
>    hw/riscv/fdt-common, virt.c: add create_fdt_riscv_iommu_sys()
>    hw/riscv/fdt_common, virt.c: add create_fdt_pcie()
>    hw/riscv/fdt_common, virt.c: add create_fdt_imsic()
>    hw/riscv/fdt_common, virt.c: add create_fdt_socket_aplic()
>    hw/riscv/fdt-common, virt.c: add create_fdt_socket_aclint()
>    hw/riscv/fdt-common, virt.c, tt_atlantis.c: add create_fdt_uart()
>    hw/riscv/fdt-common, virt.c: add create_fdt_rtc()
>    hw/riscv/device-common, virt.c: add create_platform_bus()
>    hw/riscv/device-common, virt.c: add flash helpers
>    hw/riscv/device-common, virt.c: add gpex_pcie_init()
>    hw/riscv/riscv-iommu-sys.c, virt.c: add create_riscv_iommu_sys()

Modulo few style comments, series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


