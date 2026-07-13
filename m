Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13475C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOs3-0008C9-RG; Mon, 13 Jul 2026 18:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOs2-0008Bv-9B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:11:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOs0-0006c5-Bl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:11:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9C0t2448671
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HqqUEzvi4j0bx+tscNAKfnTDEgBxwUnjrRW2fnR63+o=; b=h203neOX4fyOxGv+
 DkS6ASJ91c4BwL4zqgKA+PurSuWJQQ4olLuO0snf/x/83ZGfmz8sDgCxCYRFrv5M
 iGRufq0exr5ZdZQolK+R2MN7bRmpi/I7eCDMrMZlyaTtz+AvWL7TIv2yVXkTAZF6
 wZNOXsCG4QY7m6WTpYs4ugc0xRr/bH8GlwNoWtKLc8/Yn5ZacgnAEWpmizLxdZIn
 dnP0TCt6YsPmQR6T3GS2xxw+M6MGe3CR4vui9zOT66yTS1zft+NU1g16QGWQsuFg
 nWeV5IFL2Lz7Xh2cb7VSKbIm/YJ8N881frLgiS67Zo41yooDm+CLPpBMyLkKIelw
 KrVWbg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37x97jq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:11:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so4450176a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783980681; x=1784585481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HqqUEzvi4j0bx+tscNAKfnTDEgBxwUnjrRW2fnR63+o=;
 b=kFdQv+R2QS43lIZwdiFcpqnrzwlW1JdDgr5UJ4PHTNNkS0U7o9+Yzie066Q1kSjkNo
 AyWcnE8PAKFTq6UFnx6iaP2hDQsv9Vk0zs1hDQOdWgifAAgr9gH1mvilJ82CBkTOhgsZ
 8ks+FVBJrXlfSHGcsnd0CZD8Kztk9AFSJH+2NHn1MfyXyvdrZRkbO0P37+U0l62olIQU
 ZGZADmcgdgPpFrg1ytfz8e2Bifxg0hsUDftoZf5PdFfLXXeAX+WeGD4v38x2AD5Ei/mS
 to0pCyTH6IH0aa90gtwb7GaDGy2obG12tszKhsWMfyNfjZZku10RRlwMuJlhz/eb5ulT
 C/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980681; x=1784585481;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HqqUEzvi4j0bx+tscNAKfnTDEgBxwUnjrRW2fnR63+o=;
 b=heYviFUZ+GdhQC1bCyqWMi4zWfnSJ/rcireUxk80BfmQDZQGAyGsfe2VH4fMhCy6Kt
 5C0Xc9FwrrSuhzElMlJBzrw0horj84cNYoD2LT4O8H6rsDvOubs6lAq5KUsYAepkF2zf
 EaP1MQF/mWO7Wzp8L1KKTzuyo8qH2MQZ2gztWb0iVpchOFk1wLYFX+mxlPHy9tHWd7Zu
 blUOe7GmsRQVLIUxZzwsfFwOEesPwiNjWKUQP0xCFYR9e7zlCs8Hh7xy1er8C1MhfASM
 6VEqg2n0dByyBsABS9jWPTFgwu0mlswiPtKiUg9P7VDmzmHrZrgHArgTV8Gi5mvpydxG
 eJ+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RomNVLdNb8wqVsOGs8rJ78Pz/AgrZITGXl3EtBV+HxdRIQoiC/q+BrptP5R1gG5lII5KAuIgLMhMIfF@nongnu.org
X-Gm-Message-State: AOJu0YyH0JXy+BAhvCoL1WKg4f01xh1z+DGBRlePTR3XM6HwqxYzgFJh
 gyhKJjeVB5BSmgnVD+sQMUohWyrH7k3Ok+YtCD50kt1i6PW2u2In25xovXcuKfh8015KBCKF45Y
 osg+jT9E2hB3byJUhXs0PCGKJEurlXnQdfeUmX+oyk1qT47US5XNpujwL+w==
X-Gm-Gg: AfdE7cnBsK5B2lszpHzMzjjY7YIYXwE54HRXCvEQjcfyWLub/2MurWi5Sa8TbfHgFFC
 kwo2GItPR+/QambSdT+mgBi7SMhj6b3Jqh28ZenRCkEhFNtdZlZvtbVaUeK+EO3nBq08oXvGQro
 dC3IDfCH7YuDAlfyelT2TLNeyKDxzekCIliYyJm0VEJPJoIYf6zn1+R/9QNgqowWBQQWTihMuV/
 16StQbGmRvcoaGKHjibKrulVvmiK8p0v96NdJLfaM0t5YsL+HEcrwrK0br/iyG8BY9rfq21U3K9
 Ma8ac8R45yAyNF3yQwH2Mf+3V13oRa1yhr2hgaM2XC2ZpxMkEgA3/SXlarNMAFqj9Na83J59vBb
 oIF/ugXqI6QvEzOUJsoDrd+y5H6bTRsYAceR+7MdWP5NT9K8Ee3jZXDvneAIpYO4fdKFkIX+guq
 0lrS4=
X-Received: by 2002:a05:6a20:d808:b0:3c0:f772:8128 with SMTP id
 adf61e73a8af0-3c1109eda51mr11539077637.54.1783980680825; 
 Mon, 13 Jul 2026 15:11:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:d808:b0:3c0:f772:8128 with SMTP id
 adf61e73a8af0-3c1109eda51mr11539040637.54.1783980680392; 
 Mon, 13 Jul 2026 15:11:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm78251251eec.27.2026.07.13.15.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:11:19 -0700 (PDT)
Message-ID: <4d2aef3f-31c4-4b3b-8810-fe6a491da70a@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:11:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/hexagon: add semihosting support
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <e01b8e57d6b35eef078c0a9e2d663d3c36755b94.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e01b8e57d6b35eef078c0a9e2d663d3c36755b94.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyOCBTYWx0ZWRfX3rAvbrVphi/n
 LODpAW/nKRMXtNIbAa4lyE38WqHEhbiM1MzJRIBqk9jcOKmTIZYKIdbuRuFuwbdwp8NLy1KMLZc
 zv+JcYBYR5TaQHDfxQVs1Q+a9M46bOV107TV9/uItW+m17xMZo5TURCFGKfsGmrFDtYNGy8vUC+
 D1l9uEcdr9BsQcTGged10PBMznp7PMBI0PV4ZD9mOdlWyKzmKNbI8JZ6l/CXCVmBgW1S3sXf/Iv
 oC1FB8PXLT4vXc9dMIaXa/JdtD0f8jp980sTEOtIPF1Ct/Ub9hGHWxkwZOiz9bX/4Llibal677I
 Ufx97ej9t0OFdEgEZMrg3FG0OIL6gFNJ//4E6SWtMbpm3rDdtKZIusjgKtcvt8Gq1H5wfxZzrqB
 HZYSyF/xMqpl43BfIV3CaVfExOR5nGpksvgsNM2JO0IfK80hiuCunk87Vqb2Dh+i6u2zqrGQiAu
 1LLStiUFxysBEb+JvIg==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a556289 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WQaagTwQToQzrPRC9icA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wokKa4pgF4uxyn7iKf_oK0d-pvWrWhTk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyOCBTYWx0ZWRfX/vu3WFrsXTnu
 m8fptEu5mjXfk967FAcR70vU4XSh6S4oBDigfXX3r/tk03WjMM1O4QasInntQZZACTgvsy+Vl49
 E5mYkVkr0c3mF8ehkewnKAIOFY5fc9w=
X-Proofpoint-GUID: wokKa4pgF4uxyn7iKf_oK0d-pvWrWhTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130228
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> Baremetal Hexagon programs use trap0 #0 to invoke
> semihosting calls for I/O and process control.  Wire up the
> arm-compatible semihosting framework for softmmu by enabling
> CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
> semihosting handler.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/targets/hexagon-softmmu.mak |   2 +
>  hw/hexagon/hexagon_dsp.c            |   2 +
>  target/hexagon/common-semi-target.c |  51 +++++++++
>  target/hexagon/hexswi.c             | 164 +++++++++++++++++++++++++++-
>  hw/hexagon/Kconfig                  |   1 +
>  qemu-options.hx                     |   8 +-
>  target/hexagon/meson.build          |   3 +
>  7 files changed, 224 insertions(+), 7 deletions(-)
>  create mode 100644 target/hexagon/common-semi-target.c
> 

...

> +static void sim_handle_trap0(CPUHexagonState *env)
> +{
> +    target_ulong what_swi, swi_info;
> +    G_GNUC_UNUSED uintptr_t retaddr = 0;

leftover?

For the rest:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

