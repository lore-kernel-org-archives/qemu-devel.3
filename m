Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EE0CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoTv-00061r-Rx; Wed, 30 Sep 2026 03:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoTt-00060J-FN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:11:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoTr-0008Qq-O6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:11:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6oOlf2321814
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jUfoMij0Ve0+BjG9g0v2EZCe4bHCX1HSWu5oDawFr98=; b=dLPUMT1hUT16jb8J
 SujT3ce+dQFf69xJHEA4Yo0zDL1DOk3kdQKve8culsahaQQ4mq7xhpJkk5KxsYs4
 Xkw1TB2QlOE6ust2jPbmCDV0SKr3li4dqxUXTFTIUZnRZc+v3D3HxV0KyD9DGcAt
 avVtLWEt0T96RWuSuBnT9HWXONFi7FmlkeJ38tgSJfOZq1UtUmW1ZMygKC8+u8n/
 kWJLb0YPjp6o8Rdzwv5ZXL9IuSj3cYA43+Ov8zCI2xSvVJm7gRrVCFvRmoiTL0Zx
 PX8bBI0+sGlXjQD/QUk0c3vT9NBHWscTSsAITHwjBdKpTCYAJjb4dDwVETG8/RGD
 buKhxw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0tyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:11:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so995305385a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752313; x=1791357113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jUfoMij0Ve0+BjG9g0v2EZCe4bHCX1HSWu5oDawFr98=;
 b=RB7KNx/ZMSuRExICqRUknUsbEoa1UNes370FyAZK1uabs+/3rn02yhLB1WNFAAXEdZ
 hTlBsgkOiU8K1QD3XFYY7hYi6ZqQpTgiDHel9VLfQc/PaZaK15LB5Er7gjigBmqxaAKD
 zAv5YH42eOS/AtmQyDDd1GTsCx59aBDLPmg4eKRIzdj3m4p2XnpREZYc0Gsh1sm/OODh
 MAAC2/wfS8sONavFWXyflJyXv6sQf5p6paTulw7DZEFhbfUR86yKwsoXcTI4MkihHB8v
 K6oTIKr6BsLfUmIYfOAQx7x28fplJhSaIY8MDlHdtiOZKBviibvRfoyOEl46HVdBolG+
 RjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752313; x=1791357113;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jUfoMij0Ve0+BjG9g0v2EZCe4bHCX1HSWu5oDawFr98=;
 b=X8cFHWotH69ujNL4jKNHY5EXvOCBo/sjqp+7OP92EZEkHqZe0UWcBebEgWvoNrhYjO
 k2OsuswLVa43twFbxclUEk2LyklEm2pF7FQiqtYmglQk0pgRDUM0QPt+8s2q1/lhppWL
 v5sKMiMjN2KvUoBSQNTJgEoVsB0rzptS0HGpl9uFvQhudlLCgntK3ztak+HhIw7gbVTY
 /UfktwU8ydSul2yn1Ba3TRZjimQKdc7q83354VVVZgzUNYUVp3tGy7vS8hw/NXf5XKsN
 sOnOWsZBeNfrqXdCX3KKb49naBCEInZOCP8v+8a2JA2gpU7VJHptRJSt7Nr/vfK2peMU
 Sypw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLY6KjJJRiS+Q+ifgm1xw3VZtw4PowGvdiWw5LzkHlu35PTVex1onPoVefh6qLKjV45JQdyoiaoGdi@nongnu.org
X-Gm-Message-State: AFuF++nU/8uMjGxSjrolW101MjwQTDJhBsobYTfQv8Q5ZhBiPp3t/aDo
 nE1fcKtGLPriHxChz13U9NEI7khleiwIQMFCQ0MLc5uBLAlkD2QnOb4m0q1BeOmXgiRBlzezfWC
 JHKmH9Qn6S1y16oSbEp+ox8k12wZjU7NU5gOQrlZDWkFlUVjKEO5cOO5VOQ==
X-Gm-Gg: AYBFou24z0vsupAJTMa1mygusn4Qbmi2O7LicAGakbFqWiD0mlW8nsl4saf63o0LalW
 EdvtVOy+6RznMMMeSzsx5/jYKqiRbvE23YpmtfwSbegZDkrCuFlKKmGFhNv+9/p35nTUPDD0dMY
 Gc6jSj9qbl062sZsBdzWlMIIwfO+1HwEMYke6sm+IcNTMJ53I4oC2Rn3F+gGvP4SqfyID02zIiQ
 gPaGzxgajvSBg+jACYgsOypPklPa2iPfACarA5BmAkZmdvJ+SY7Om5hwvtCAgwXmQnx2kqTnYOq
 3qpI7Rba8NLedQ530yfFoQjT39PmZjQg8ckaEHJP7inXIozCZPtsdjv+dcEPqZ59uxELCyenGHM
 xREgRHexdUoskKvU9Z+qOsUgyoK7lG5Olew==
X-Received: by 2002:a05:620a:272a:b0:939:5c62:fddd with SMTP id
 af79cd13be357-93ca966bccfmr65734285a.19.1790752312634; 
 Wed, 30 Sep 2026 00:11:52 -0700 (PDT)
X-Received: by 2002:a05:620a:272a:b0:939:5c62:fddd with SMTP id
 af79cd13be357-93ca966bccfmr65730485a.19.1790752312106; 
 Wed, 30 Sep 2026 00:11:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01b1e7a46sm10332795e9.0.2026.09.30.00.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:11:51 -0700 (PDT)
Message-ID: <231373d3-7623-48e0-9316-cb0bb170ae29@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] tests/tcg/mips/user/ase/msa: remove
 compilation/run scripts
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929212439.110454-25-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929212439.110454-25-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcb639 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Xw_Eee2GLLaVjfw4gn9XhNugmRmKVnnv
X-Proofpoint-GUID: Xw_Eee2GLLaVjfw4gn9XhNugmRmKVnnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX6nU6b6FLS1Hh
 NvgDNCrGTcMZr5tG+LISa1CDE5bm86Z4PM+TUpUxm/EnxAuxHYuVFbL3amDq8HYMkVMX6yGihJ5
 Y+aA8jLYgrCFyk7MbGQVtisAwh4TmzYWm256fJY5NAQUYkICJ0AaCNPpJhGczejvOWvS+lhroeq
 CRA+XOoa5Dfap7vDYsavPovN+zRK14R7MCyRlqBZZoqf/IG/f30e0jdKU1hdLaZ5xThiLg9oQqZ
 Z253jx9AGdE/G4+cdJNqbiJsP++YOghk9CtKLaKZ9x7sjQf1j+91fSMNdgd3ghf4KvJYE9O/NXO
 W31j6CpD966/PSpFMF6Si1SGAlA1CF+xhr8F7yVbR2TkeSEFP0y+a7pUY34XREFHB2X7oqvuUd1
 d//aYkzd2Zg3FYcqf3tdnc6z4J5RVDzwdhdItJqeG3b5M6lxDRk1dliLFHf6htnIFXEkM+/V9t7
 kv0tn4blISKN0GjJ79A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX1b6K7DSuPiZU
 QE0eBE0jd2cGYh/l42XKOy0jzQK5hApOenxQJbkjeY0LwSgh7p30nwftKwWnmdpxJ40gUJfnMYF
 TajEeXfIvmj9JFiUi6b+u736YQe9p/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

On 29/9/26 23:24, Pierrick Bouvier wrote:
> Now those tests are integrated in meson, we don't need those files
> anymore.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mips/user/ase/msa/README            |  20 -
>   .../user/ase/msa/test_msa_compile_32r5eb.sh   | 917 ------------------
>   .../user/ase/msa/test_msa_compile_32r5el.sh   | 917 ------------------
>   .../user/ase/msa/test_msa_compile_64r6eb.sh   | 643 ------------
>   .../user/ase/msa/test_msa_compile_64r6el.sh   | 643 ------------
>   .../mips/user/ase/msa/test_msa_run_32r5eb.sh  | 371 -------
>   .../mips/user/ase/msa/test_msa_run_32r5el.sh  | 371 -------
>   .../mips/user/ase/msa/test_msa_run_64r6eb.sh  | 371 -------
>   .../mips/user/ase/msa/test_msa_run_64r6el.sh  | 371 -------
>   9 files changed, 4624 deletions(-)
>   delete mode 100644 tests/tcg/mips/user/ase/msa/README
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
>   delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

