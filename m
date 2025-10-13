Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EA0CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ORQ-00075T-Qt; Mon, 13 Oct 2025 15:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jae.yoo@oss.qualcomm.com>)
 id 1v8NMu-0003nj-FS
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:34:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jae.yoo@oss.qualcomm.com>)
 id 1v8NMs-0004uv-8W
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:34:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD9GI002513
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 18:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eriIZRj0aLw32fFI3rvHJA8aUgtHNZuPJUOPpKVLn1Q=; b=AwG1Plko5FV338g/
 56CbTWwlakUuE+24q7K/o8Ox1weEJWMVV0XV8w+sMXo/10SaiIvQgwNyFcdBHM3v
 16+sCdwv8WBDtyg6qyAV/Bwj4J8HQ6iaPITIsdm1ZPcUDHQDlGKUfY33ZsjiHcYr
 D/LVe2ZYrMhtpjt/To5jcdHQM7GL4dDU/Wwbk55Jvw+9A/AdePLoB7rIqJCuZCrH
 NsV5hWR/T9uHAVoP9+JF7PDIFSVVXttnAfaXGIbkd3xIo2DSDYmPjVCCznwlqjLL
 cr620M91Ivugkp+OmNJtujLfltuXY8QdHfa+lCjNyhZ5JYxOh5p5lhHn8bm4J+9+
 iyOpkw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhwqad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 18:33:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2697c4e7354so88183085ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 11:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760380433; x=1760985233;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eriIZRj0aLw32fFI3rvHJA8aUgtHNZuPJUOPpKVLn1Q=;
 b=qTF5fAw0L6R9rblXhyJ43kAZPie41vAk+KkVbkaS4PKTzICJ6ljTvDni/Tcjv4ct6V
 VAFkhYhLImo6nWVJGza4ja72ASnqpuHlwiZmcBuVnJnsOaTqcZtwy5+1yhOT4ivXcsUU
 H/asZ4RltSYa0zKfsYh4uxjdTen+OwIqVIepZvuQIbVqs6a+VUcB6ZoPJmr0PCLdk+5U
 cozN+gSTLQz9FBIuTnNJx/Gp4ybjlbvI/00EBYDI88J7H7d96hZAryzn0aIGOK31Qq2k
 FdV7Ma5crH5p4p1EX/gfNs+YZtr+qHnwPpncQL4M8Jk9JuTk70MVJ4waEHcoLJUHg9Fs
 6cLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU1bSQGIu/Y2YT2/rIHUnebaeqoLA4QVgc6wfy+LC478ayNlDdTFYvq6wzj7LcRuQ887qTmcmCYSGl@nongnu.org
X-Gm-Message-State: AOJu0YylD1nVsstub6JsYVMouaIKrLuLoN3jAdXRRdyvkmHpdKSrw+Om
 4gqQfnJsDt6GBbdsQkUDvGFWKxHtPsr9OTHPltVTcsNzVzdV+QQtVjHoP6pTZ73TVzNxPqZtLLk
 McGQGNMccr7kRGLH2sEQOqjsWIDQs2yiqbcZL2NmeHyPWpQjHgzhJu0qAQDvNTcGNhUVm
X-Gm-Gg: ASbGncvknCcDHQ9GnsBlyMDvY1F5d6icTn+Gkvgj9w43r6ZG+C5/t0rrytpvxbvaHTd
 vi+aEeEtqRV7Lzw1OkqVWjqe1naFPUeS1gVR9I/uKpxKKS99cY8cjKFKHz3myrFY0pf6H9MeqU7
 8F7tmVPlmMVvtXYdbo6Xdm3R82at/wX3cRa1rLm3V95nVRbbm7guHQv8fzq/n16Kg0wRiPQcmlM
 5X1BIe8lILPyZPocIchS4yBLkFp6Jqsf4D0/Sir+Tjy7w8f9R6IDdSbwC/Qrqhl/P44lrGNEz2U
 4OixRjiW5bDLjcy3vOzc9l15N1IzVqrKZ8shc0Vdcw/1mtClWYcuxBXWaMxNNt1tEhWQucDl7rc
 88hcA0Ry5Gush
X-Received: by 2002:a17:903:1b2e:b0:272:a847:cabb with SMTP id
 d9443c01a7336-28ec9cd69d2mr333636345ad.28.1760380433230; 
 Mon, 13 Oct 2025 11:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcThxp2S5IOcp2KEvK6UNMqOcMLZ9ipWFXsPxpzuLuh+bESomOoHSiKnTri2l2la3E63ywQ==
X-Received: by 2002:a17:903:1b2e:b0:272:a847:cabb with SMTP id
 d9443c01a7336-28ec9cd69d2mr333636135ad.28.1760380432696; 
 Mon, 13 Oct 2025 11:33:52 -0700 (PDT)
Received: from [192.168.0.9] (71-34-64-202.ptld.qwest.net. [71.34.64.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f362efsm140833025ad.89.2025.10.13.11.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 11:33:52 -0700 (PDT)
Message-ID: <261a0676-c6bf-4cb2-9859-b0ef63db5a08@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 11:33:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/29] aspeed: Deprecate the qcom-dc-scm-v1-bmc and
 qcom-firework-bmc machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
 <20251013124421.71977-11-clg@redhat.com>
 <SA2PR02MB78514EE956DEF4BED254BA758DEAA@SA2PR02MB7851.namprd02.prod.outlook.com>
Content-Language: en-US
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Jae Hyun Yoo (QUIC)" <quic_jaehyoo@quicinc.com>
From: Jae Hyun Yoo <jae.yoo@oss.qualcomm.com>
In-Reply-To: <SA2PR02MB78514EE956DEF4BED254BA758DEAA@SA2PR02MB7851.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8+SU1aGTZTo/
 nUFrH3UhI4sD8mDDNdVbQPhpe96oQ4aOucxdfHCeRcKxZXxdqgfWTubElvsnhGPTj+yzABWnPvY
 UdfU2X8rOpYd1g1O52hbLh1EtTDHaVBdsO+0cG3IZ9/z6w8G8x/OH0tdjd8lP9sCxWsbMYP4jKD
 wslcQfcYpgq7JvRT58fwcfArB9dpoKqZihRGDv1kqxQo1xW+MRVO/jHnGiRbBKksgmDdA5YcfHT
 acfNkQtvt9KbWKLjxAQwvDmDrQRlxcQNWbtDj0fhxjLlASGFS+4D3oyz0FJY486O1TS+8Z81fDI
 ujwPquppvHk0dw2HxW2m2787U15gbfodvfuBwYxZ2sDSrqARzlCIdkWupybm3wLmc1AqLcdvQI2
 LAOpuuVJuaIao99auWXa1YM28m0f/Q==
X-Proofpoint-ORIG-GUID: gNhPYdt4LFD6hVllSR_WgaaksignzTZj
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ed4612 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=eIIDeNP1OUjBW9wmmAUtdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=aW39nIJ4cvaJ_DaTxZUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gNhPYdt4LFD6hVllSR_WgaaksignzTZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jae.yoo@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Oct 2025 15:42:42 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

Reviewed-by: Jae Hyun Yoo <jae.yoo@oss.qualcomm.com>

Thanks,
Jae

On 10/13/2025 05:44 AM, Cédric Le Goater wrote:
> There are no functional tests for the 'qcom-dc-scm-v1-bmc' and
> 'qcom-firework-bmc' machines which makes harder to determine when
> something becomes deprecated or unused.
> 
> Since the machines do not rely on any specific device models, they can
> be replaced by the 'ast2600-evb' machine using the 'fmc-model' option
> to specify the flash type. The I2C devices connected to the board can
> be defined via the QEMU command line.
> 
> Cc: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Link: https://lore.kernel.org/qemu-devel/20251007141604.761686-3-clg@redhat.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/about/deprecated.rst | 10 ++++++++++
>   hw/arm/aspeed.c           |  2 ++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ce8fe9ac1be7..f6410037ead2 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -294,6 +294,16 @@ models, it can be replaced by the ``ast2500-evb`` machine using the
>   ``fmc-model`` option to specify the flash type. The I2C devices
>   connected to the board can be defined via the QEMU command line.
> 
> +Arm ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` machine (since 10.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``qcom-dc-scm-v1-bmc`` and ``qcom-firework-bmc`` represent lab
> +servers that never entered production. Since they do not rely on any
> +specific device models, they can be replaced by the ``ast2600-evb``
> +machine using the ``fmc-model`` option to specify the flash type. The
> +I2C devices connected to the board can be defined via the QEMU command
> +line.
> +
>   RISC-V default machine option (since 10.0)
>   ''''''''''''''''''''''''''''''''''''''''''
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index d3a0c81f454f..0707a760fda6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1926,6 +1926,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>       AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> 
>       mc->desc       = "Qualcomm DC-SCM V1 BMC (Cortex A7)";
> +    mc->deprecation_reason = "use 'ast2600-evb' instead";
>       amc->soc_name  = "ast2600-a3";
>       amc->hw_strap1 = QCOM_DC_SCM_V1_BMC_HW_STRAP1;
>       amc->hw_strap2 = QCOM_DC_SCM_V1_BMC_HW_STRAP2;
> @@ -1945,6 +1946,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
>       AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> 
>       mc->desc       = "Qualcomm DC-SCM V1/Firework BMC (Cortex A7)";
> +    mc->deprecation_reason = "use 'ast2600-evb' instead";
>       amc->soc_name  = "ast2600-a3";
>       amc->hw_strap1 = QCOM_DC_SCM_V1_BMC_HW_STRAP1;
>       amc->hw_strap2 = QCOM_DC_SCM_V1_BMC_HW_STRAP2;
> --
> 2.51.0
> 


