Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278D7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbFF-0001Dq-Io; Wed, 08 Jul 2026 18:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbFD-0001DV-W7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:59:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbFC-0001E3-K4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:59:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668KtLUn3771567
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 22:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 clU9kC8b8erhmj+alIKj9MA0iQnWxmEXLf8F/F5FAuM=; b=eDYeD0b1YLeV8phI
 Tpku/2Dri/YfT40NPZwLGNK90XQtQXcp3Kdn5c4o0204YS/TX9tl9cMklliTAb1W
 mzZj5UiZH56WAt7ybKtIgAjx/xnvzeeYLC02NuDwioyoCBthGFXplo9aMMPXa2JW
 p3yKocRgpZsH1EXy0X3CvlNNc5sXu1xaHHVGv2LeVW5t8IHs0VgUvI72Q//48zye
 JhcirgtXQ0Z7jWi1z2SmP+4RhLK/rPaZiCa7la1vwxPF6n+BhxMtiB92bi/5fQ0C
 vsUxJQ/pJ+KMZjney9paunpzonXKPVzQPx1tzLXbcm051u5hM852jXoy74TaK8Vt
 GI0G9w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfrbf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:59:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so13569311cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783551593; x=1784156393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=clU9kC8b8erhmj+alIKj9MA0iQnWxmEXLf8F/F5FAuM=;
 b=kcBM7sPasBtEIZdoQQ9pVRreI4PSnStJHBPg1swW21vKsfs8OPRixWhxzJnVrYWvkS
 dlaQhxTkSxGbfH46gk8k+3iKkCtP5mYkOenmLydj5U9iRrL8QGJsPU0Wzdz4rj/Gtt/l
 G8XnLeffJdYOeQEbBIBfoIazAdMiC/lMBVtMviVtYF1xSonm/sw2v81ABwavm7iPfidj
 I8562nPwStm/ibTrJo1AyqqD/GGxOfeQs4ZmvMVB7o3Pc2B16EIWAMmme4Ov0EJ1VX1A
 kz4yRlLl6BbVIyzrQC8QYSDFqJp5ydlMKqyXji69J0Ha7O2StyJDkZ+dTJB4FSfGgv28
 7dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783551593; x=1784156393;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=clU9kC8b8erhmj+alIKj9MA0iQnWxmEXLf8F/F5FAuM=;
 b=TUyb+U30f+H8+iVx3uCmxc4RcgDmOXalspTfOhZz/WI9vdDPhvT7TGfmJ5JE3XIElE
 y+4OMp8JFGVG7XlcBxo7fCTc5QsGj27W3F1RUS/LFU/7UWNJu411f07sE6de2QVAdc/x
 MD0WzliRV5812EME6wrlbBhTJz6XNB5WUeYB5MJ9D+6fKSqSJxaKzr/awRtbATfC8vXd
 fJIcTucFIZu66puNvjjn6yrTlWx/oGlrXklROoPggSqI0AIxsHaN3g2by5ubgcIdj0u8
 zosl2KPa7BpoD7k34zvQtvFKvIemNgAKWVvHdz9JRaQT/AQSz7fr+B8BVK/Ud4ahm3Gd
 zTpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjOOgj7zbGNrSwEeNEzspPI5+aJ/to1y7CY/jzxnB0q7GOjr5OhrJpWR7u8xKQziMlkhh2C0Xb86o2@nongnu.org
X-Gm-Message-State: AOJu0Yyx4GwWTV3E6wsXhF13iAWFS5RHbjQxqE2xj5+hKkgj8EbUI83X
 8wwm4Mr+VWTRy3hxQKzMiOiN8nwXdOpSPw/61/28h8l5wslGzsXJgDExKrU3cMXoXQ6x/xNVbVD
 q6kk5W0vZ95PMNeg8isr2ggEztF/oaQkOwZxqOFuYX7CeGe7PqVBf3F1GAQ==
X-Gm-Gg: AfdE7cmkVtlFF+cGk0UncWqxxAOTE6CJ8KQiVZbkkQrmnmTpHxx+MBmOciAxRyngiRm
 lS4yNxChwvLPaHy+hKIIoZF4xAiwp1aYzGQH9uC47GRdqATSBtkQBR82gJ+P2LzbmKCziNUEQB5
 lV68/FnY0OuDUQjoYZ3OFIO/8ttlKcbH4T10Iz5NUrV718bI/CKwi7N0NDYyHyX0QJ26OzmVcoI
 hyxGuVR+gKqZcQLsaKTAsk5VE3g8juA7eHvCYYkIGlP661DW/xQZmkPJAHap4AgwdZ7YMsRu6m4
 mqT5vK8y0cq9Dw7+4Le6b0ZDs3Opnh6dEuPAnp4EzI5JI2DRC5iGlW+Dusj6udXfZTI8m5LRCNn
 eD5v68DQBPTQYhfdmFSdcihkoJGUNWP5rBUNcgUNniwN6LwAPI6xb0BcbJKrbhA==
X-Received: by 2002:ac8:7e8d:0:b0:517:5e32:af1e with SMTP id
 d75a77b69052e-51c8b2d54bdmr57548541cf.8.1783551592900; 
 Wed, 08 Jul 2026 15:59:52 -0700 (PDT)
X-Received: by 2002:ac8:7e8d:0:b0:517:5e32:af1e with SMTP id
 d75a77b69052e-51c8b2d54bdmr57548201cf.8.1783551592493; 
 Wed, 08 Jul 2026 15:59:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm15699375e9.14.2026.07.08.15.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 15:59:51 -0700 (PDT)
Message-ID: <c7963a97-8e5a-4c01-ba31-45ce48091270@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 00:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Refactor AST2700 SCU preparation for coprocessors
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfXy55TiP81yYEF
 LSL9mpIm6b7kYAGSao2C/BCoGxh5K2iMJCW0O6h6u4aW/nt6DyzHSC0JYFTnnm4E+7c8THdbepO
 Z2LKuufWLaPE2k/YjbNqqVm/7Uqt61AFwSJ5Ab/FA/88eE6qGTMqy3QaUQmxF1+Vkktgvl5H4dz
 9Zruhfs4LJx0CGNlg8vxXUNSZ3YqqPN+U694FcwPksrTXBOKszFrK4lb9GVnHqIUBIZhgMh95Rp
 li2jKEdrYqmdiJFktVAaXvfAaeIVE3DVKVdrGEQ9G9OWohdZnEBzFrd2wx3uRFQ9lMOvykO520j
 +UGZ4WF2LOnwFS7yTCWiU/Wq4LK5QA6ix+4KEI3ZvjDGi+8sk1Mx+axdumgN0VUWwW8TekwMsjo
 4B7P0Mmqx6EFV5hTONOEDs9aHO2iGJFFUCOpQby65c41J4Tkifi4aUfQgsKN1CDnlz6ISlkAzC5
 s3/dkPs2WbhCfyyYGrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX7HpxuRNgxrO/
 MgBNbm2TSp4YWz4lvnes8BSLkmF2yhy+WrW0wGfe/eqee9lMQZ+oHZXUW0Rj//nsCgYpWQ+E1D4
 +g34HbzLPyCuv61GtiqbC5giBrTogwM=
X-Proofpoint-ORIG-GUID: KnkIycekHQzMwQebLL2SviDBNzfSBWYi
X-Proofpoint-GUID: KnkIycekHQzMwQebLL2SviDBNzfSBWYi
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4ed669 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080226
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 7/7/26 08:09, Jamin Lin wrote:
> The original AST2700 FC support series [1] is fairly large, making it
> difficult to review all changes together.


> Jamin Lin (8):
>    hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
>    hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
>    hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors
>    hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>    hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization
>    hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
>    hw/arm/ast27x0: Share FMC controller with SSP and TSP
>    hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for
>      AST2700

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

