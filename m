Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527C3CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIni3-0006OW-1p; Mon, 19 Oct 2026 09:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xInhy-0006OG-NG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:47:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xInhv-0002XX-9w
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:47:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OsVB1665658
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YmaBld1ccuYqCH7i4cAlZpu8G9Bp5ftQW/k1Z1a1EkE=; b=J5gvESD7nsXFggCQ
 Nmc77LLvDB3/uokXov/2DdFGTtEpf0iODsdXGru4SioRRfpbApZ0AUxBcHV+cKf2
 lEKFI13zLQq9gBN/y90p0AJu2OIvhXe9eG7p3H56w8O4rm9kpWPcWz6Q8uKFb8Nb
 7Kv1ef5hRDwWGosIOqgI3DsUTBwQ6IIjg+kOgLqqFErJ0UYbhUW2j47r7GOxyo2s
 5rICSRy58PdAXamWMQl8AIoe54kbOSArvpuvLgCwvWd1ptMQfRGnu4fSAI0tB4Ec
 7+IUHYs2sW9GBf3hujJe0SnbZZpGjwAvtKwkcGQK1d+zgn2IMg5CquS2QhJlv3d6
 G0oEZA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n1cnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:47:16 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98a9c848bf0so99573241.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792417635; x=1793022435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YmaBld1ccuYqCH7i4cAlZpu8G9Bp5ftQW/k1Z1a1EkE=;
 b=ePjelysfuE3KkHnEUVhmEcF1BHtRPzbAJ+Sqers/qSua4pR/kxgygCT0VbFfwj5F91
 a/iVGpdeHLaun9LKht8CkYxna28a2jaLukeI1Wrx1ss6I5oOafLaEiJ/JIkZ9ptYKtIp
 8feqV8rQ+/Fe96sZ+6qjggcDsaAJGeD6Y1/9HTP4R55fZ61IEJodNak+2hK47EN42fjp
 zUtMK8325/SIFeVr7iMX99mTgCBVXTGluyJuqi8uXRZJqNV8xc+fDaJsrYoFGOgSS8P9
 dLnS4XJeCcpRhL1++CLAgeqfN2o9tkZezkyeXSLrUV//dVaC/MnGDXKmPsjSbzSu7tPL
 IZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792417635; x=1793022435;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmaBld1ccuYqCH7i4cAlZpu8G9Bp5ftQW/k1Z1a1EkE=;
 b=QkGAvdQAUMVFl9AFL13ngWGSNnW/Mxn5WHqOc6zSomEyEo0CcqQfBoTOcSw8XhqMzr
 2F4KM0M5FLJLHyvbS+fImfytj3/GlZC4tS3wk/QlGsLZ0Ztgf9uqI3sgB4awpo9xVUuw
 Br+EyuOortNZu3uHKMltIEzwe+PosOp26frTSNpwtuL/jPOzvL2MQidASz45ZJXrlDba
 aSmCMbEeXMdvl8dCVMgHujfw50/1BEfY8nPjr1a/rlxe7kDYtN2P+w2HrJV0sw7Ox+jf
 rK4g7p8UPJncwt3Ec6DfxevV1EK2xjo//KRmsaHFOCRSUI9Qoq+tOG0skB5fis8PJ4OC
 Hjdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKyZYtWdDzQO88sjcnhgnA5r5CDSABf0HoPEb7WpnJda0E8rnqqvQ68GCKm+4uU2vNIADLD3X3kzcp@nongnu.org
X-Gm-Message-State: AFq9FYLuw/vK04xPO+8+JrQ6V9NbchMY9zd+Uhm5dH+aWXRyDYlS791b
 REX4DhLagjJ2mXlSME0gJIxL9lEAoqBxzui4XtbuZdncwduNGOAKU+8QqqWs7Z4Ww1OOftSXjUr
 8NT97nrR9TdfMsUssx88sdndto2f0HmyK9R0HEo9o4LV8cM+PkKYsAGL7rg==
X-Gm-Gg: AYBFou3uyiVxQylQEn4F3eAnR3razYgOTs/19MmBvoEazd9rQbGR19v/7G1QUwo9M7S
 +WqwTt8xJBBmQh01Lb3Qa/UQC+T3XR55rBAfpCdaUUqNFbtCRldiffgMydJxcNUBUcA7Icym+Zl
 G8ciJUiRgOQ9uS/MtlPNLqdNKXAykf9V6fVD5Iu4XSGfoggqgbW9ufuZz468b08DVhU0rEdxjyg
 gLnDfLY4/c+PcQm0X7LgDLHsVW0PfqBIT0AsFLgDJENHbEogdIy7N9I0tF6KcSGT6l6x9VKgWd0
 MkdQ3fYN3wuPEp1yXCBn4BnCKkruyeMVGNCtkOEJlNxDP2mht99C9voJeMEa9dnnpg85PCTX3W6
 NZ3YX8HfVYCBge4uLDS+Y03P7bWjSYkc2eg==
X-Received: by 2002:a05:6102:3c92:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7cc36728d87mr1654913137.4.1792417634976; 
 Mon, 19 Oct 2026 06:47:14 -0700 (PDT)
X-Received: by 2002:a05:6102:3c92:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7cc36728d87mr1654899137.4.1792417634394; 
 Mon, 19 Oct 2026 06:47:14 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4edea3sm24204105f8f.28.2026.10.19.06.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 06:47:13 -0700 (PDT)
Message-ID: <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NCBTYWx0ZWRfX9G+rgv+IqPGB
 6N9T8V2x4mcqs0kbM/3pLdou/V1RWzdWTBZGG+vhitIQa7zmzmb+QfzYdvbL/ssDaga0nDLwSpD
 4LI64IO1Dd9Ek483z+a1R0AQZByebRU=
X-Proofpoint-ORIG-GUID: SU5VrRokkklv55EusbHSNdNOhgFWj3Pd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NCBTYWx0ZWRfX6gtUkCfZY5hF
 9eaOygp5O/TqtTZltTnVfVI6sEYdQQqneW4MSCb1zVPjldRL9vfxm375lstRvxGn3WP4vRN/83D
 uncu9GnSC2pZJhIdl5xECz48BusJLxnS75cxMiL21JZe9yb4JTuPNKtETLoV6W+ovwOP2Feg6+Q
 dGLibzg84ilz6+Poz89lY42wteeWJWTDkBeKTY3rfDoDVrLM3Fge24PjbHqF3NkYhAgbrJcw17k
 bQKLKguvLq5BWcSzfrnmjWXVsLjuPOajHh8emNVm3MX4GDGWKDrp/jXCQUpvtjyHe2xOX73NHWx
 l06F/ewJN7HM/8FYwlhMLP6W/lfqvpYQkb/j1fppmaIEge3Tjcde+23cCPHQlFBUytLp+2OBwEj
 YdByOgFf+wX3aNuw83BPjuID284AFjFqpVYvJFAKZtkhTPQL/h8JqMg81fGVHtGoBXbvB+XGZO2
 SYdD8c0kJsxcwRrwQPA==
X-Proofpoint-GUID: SU5VrRokkklv55EusbHSNdNOhgFWj3Pd
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad61f64 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=soY62GVlfO_uI8seiK0A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190054
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

On 19/10/26 07:52, Brian Cain wrote:
> Download the firmware and run it on the corresponding DSP machine.
> 
> The images are third-party binaries, so the tests run only when untrusted
> code is allowed.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/functional/hexagon/meson.build          |  2 +
>   .../hexagon/test_qcom_dsp_firmware.py         | 89 +++++++++++++++++++
>   2 files changed, 91 insertions(+)
>   create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py


> diff --git a/tests/functional/hexagon/test_qcom_dsp_firmware.py b/tests/functional/hexagon/test_qcom_dsp_firmware.py
> new file mode 100755
> index 00000000000..86a0628d9f3
> --- /dev/null
> +++ b/tests/functional/hexagon/test_qcom_dsp_firmware.py
> @@ -0,0 +1,89 @@
> +#!/usr/bin/env python3
> +#
> +# Boot the production DSP firmware on the Qualcomm DSP machines
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset, skipUntrustedTest
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class QcomDspFirmwareTest(QemuSystemTest):
> +    """Base class: the firmware is the ELF that -kernel starts running."""
> +
> +    REPO = 'https://gitlab.com/kernel-firmware/linux-firmware/-/raw/' \
> +           'd947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom'

404: Page not found

