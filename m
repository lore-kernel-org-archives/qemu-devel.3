Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E521C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9LV-0002nf-TD; Tue, 07 Jul 2026 13:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wh9LU-0002mw-M7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:12:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wh9LQ-0003ai-KT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:12:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667GuuBO230679
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 17:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tljcj8O4aY6UOdgpgGah/gGtX4hDRmjcYt6w81CXh90=; b=Dv06DnN7dcr3DZNu
 M/f3BGMLZ+Lv2c1V7a2WwB1Es7Y/ZtqSxwW/hGWt3B/BW5Ph8yny5KfQ1dfWdaqS
 VLm89hjyW3JqxLgVWFyZb6evgkrtSLrS1k3lNrZGtKsqEzN64pDYz5oRBEguoLMA
 PghwyRioBY5AGQhZCZMG12EeM4CvLbo325gGy+M47vMspITmelxIxbkaI+d6z5Kg
 tCC5ASn+TGlzT0mhujUWCAL5LLl6XKmYxfXvXNgeUqhGZDK35vY1CHex5ZXtBdNt
 MRaXwaIBY5Et4xYGJ//f3/FK998Dd+rRste/0CQhH8gNX4qDAQ6WhdB3e8IutKcL
 If4hHQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5r2fv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 17:12:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5939so457429285a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783444346; x=1784049146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tljcj8O4aY6UOdgpgGah/gGtX4hDRmjcYt6w81CXh90=;
 b=Ow3BsTlLvVMH5Du40S0mjHB92MazAnHGtBXrKLupckG9YpikWIa01FkzCnYuM4v0NQ
 WbpLMzq8jDexgPH1Xmn/cTw+8fFGPRyIHKEBs16xNVnFeO7RdYZA/WEPMRtJN41FAi8v
 PtIJa6czHIOYy+lx+gCZ95jqwhkvDz+hyGZOZH4Oz2n7MVCH8zxF9qTvHw7Pu9fUjSKY
 duI3cVXf+VQlBuNbMt5VNpzJ5pTIURnbApGqcQNL2bJZ16G9sccSRUCiv4/II62EJruS
 XmdZ6KyASwlpZvUbMcWanBjL2v9TFXkkXZ5196PY9SYPLMy7DJ08ME+YFhrGIxNTxvfJ
 qgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783444346; x=1784049146;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tljcj8O4aY6UOdgpgGah/gGtX4hDRmjcYt6w81CXh90=;
 b=fH2brSY7XStGg7OT5jkg1zLEZKYMQz1KyJilPEqG12OjdFfEgn+leMOC/vc86YBKUD
 R+qfmVOQv4VqZghj9DyrUUVwpvIvPppM9KkoW2Q+D/YgNARi+XD+XTM7F+Qr4gxt3BmW
 HwumbRUv+oBTYiYHmCDZ1144a9AoO//dWWAptW0eNGMiwcZOQx9vX9LuL515L7lq5jjd
 GdgW+vDz+7zyLyw5ytXDhvut2Dl4mnPl891i5LF5cvnFpN7FWc4jsGrtUv2Mx4jE/qS3
 RgB8L+Aq0sgtMrRiavnoLpO25GCFYTrZqWY0754f+QCgVFmGTLQxi69A3cOcnDiQNwew
 gaQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrT0aH/GE+XoFjXIWl6Tm56P6h8wGCd9vAsdOPSZ40H2EchM5rtBO4k88u8PQsoF7D2OOoAaqW1J2l+@nongnu.org
X-Gm-Message-State: AOJu0YxmFAkjr5vqou8Q+KwtxiZIjVi2RpFlNeDXH+jzyqO1qdy91LFZ
 f624EO9PT67RvSeJhw6IMYj0UeEcAyCdEmn3ZNzKbVR+4x7tSiveKy3yNJVGn3aQ3c3FXTt/10U
 tMD2/GQ3Ma2iz+Jtj0+22JT5wsLcIsXbUhHBcLO4FKbpSqjSMjWAlI9BjAw==
X-Gm-Gg: AfdE7cl/5OeIsNBoHLD2/e4MxsY7nu3iuPy8WJ1ZcKpiue3j7dMN//hykivuC0nifVh
 Si9s7XcflTCmKSO6iQ1v7maZlwBtJ1Wlqdxd4+MYYfrLvhw2CJFrVjCVUa/S8h1iuAfktFhXaUg
 wJnPqXGMVGAGFNnB/LFMqx5YzBLYLnp9Pu1d/oQZbtuQwcOGHgWgBmaVwoUrrm6fWKKWwjv/yZO
 GQ+J3KGi3CYUu6rgA/yVYAQEi5CVk5ezY0j08ES2eNQqgq/9GmBVgBOH++kM8pxd7HPKLvhPPWG
 g5oP+3a3Ei9PqnteFm207YC4KsXEwSAkw6w7KXgaZoc5vZYtY3YbkKn/c+3M2caRto/cUoK9Qic
 oOCgLyqX0sUVMqXG3cVOqhWCX6WzdMYCYkZWpEb/stx1A
X-Received: by 2002:a05:620a:44c7:b0:92b:67e6:8ab4 with SMTP id
 af79cd13be357-92ebb5a3e07mr670879385a.62.1783444346434; 
 Tue, 07 Jul 2026 10:12:26 -0700 (PDT)
X-Received: by 2002:a05:620a:44c7:b0:92b:67e6:8ab4 with SMTP id
 af79cd13be357-92ebb5a3e07mr670873285a.62.1783444345824; 
 Tue, 07 Jul 2026 10:12:25 -0700 (PDT)
Received: from [192.168.68.105] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471813d49sm162248616d6.27.2026.07.07.10.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:12:25 -0700 (PDT)
Message-ID: <f142d6f5-e01d-4ac7-970e-fbcd7b37cffc@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:12:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/gitdm: Update Qualcomm entries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <quic_mliebel@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260707153003.58914-1-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260707153003.58914-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: suzcsmclfLoU2omkcSJ7JHuhZAlxFlS2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2OCBTYWx0ZWRfX64kU+V2pk/bn
 jL25nItuMNmXV3pwVYzknpQ2B6LTfY0GER2F9eZQ/BjyE+zXP4uQ1stUmW5EDWhJbLj2Bvb4QmF
 KNHKqAxmdKBUUxJYHXX4Is1ooMncYiU=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4d337b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j8RhgVXbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=Qm8iP6mkAAAA:8 a=20KFwNOVAAAA:8 a=h0uksLzaAAAA:8
 a=SsDAoxTRZLbaqr_YZkQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22 a=3SzYsRL22XtqO3ZTpi69:22
 a=kDhhxE42lZnxL3pOKqYK:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: suzcsmclfLoU2omkcSJ7JHuhZAlxFlS2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2OCBTYWx0ZWRfXzz72H5B62cz6
 6Y6G2o+7qXlHwIFhHPfmoUe093UddfydMWUBhRjvblQRDFtBNEw4YvsiH6EjfJRG6yDT5CWMM9g
 R2Lwp6I9T3Tnjxw9nr9X9bbIQWm+85eRkx2Xx8PvXLRvc1tlWgkGbiwMQM8wdtZ5PqQPP/U4RGv
 rnIk4NSKb8MyXEoNwsbWb1IxqKQzRJ8j8TKBfvlFzJ+JY8Cf9JVxwBQNkp5UGfQMKMqMyrDJtUM
 STkubeglSSqV8J7MEw2vPyuZoIkjKcwpiNP83ofcovrYEShw1oWmiRONie5o4ZCHnWJscxZozYO
 injjxLlvQydofoo3hFvVmIT4agTqNu989ft+iaKi15GUy0CwEv6Hd05dIzdNR3aVZ0LvKAXaENz
 y+VTwoFwhwPD3wDXhGjORjAbxC5WyjDoVGJXxl8rdlK9LO2O01Cl1PkR3Ml1+E2pHasGcEQ/aqr
 f3Evd3nvKRzAoQMoiog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070168
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/7/2026 12:30 PM, Philippe Mathieu-Daudé wrote:
> Add an entry for Qualcomm Technologies, Inc.,
> include previous quicinc.com contributions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Cc: Marco Liebel <quic_mliebel@quicinc.com>
> Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Cc: Sid Manning <sidneym@quicinc.com>
> Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
> Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Cc: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   contrib/gitdm/domain-map | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index c07dffc51bd..aef20c4949c 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -40,7 +40,8 @@ nuviainc.com    NUVIA
>   nvidia.com      NVIDIA
>   oracle.com      Oracle
>   proxmox.com     Proxmox
> -quicinc.com     Qualcomm Innovation Center
> +oss.qualcomm.com Qualcomm Technologies, Inc.
> +quicinc.com     Qualcomm Technologies, Inc.
>   redhat.com      Red Hat
>   rev.ng          rev.ng Labs
>   rivosinc.com    Rivos Inc


