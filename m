Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197E2C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ehS-0004pq-Q4; Mon, 21 Sep 2026 10:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ehL-0004pK-8n
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:08:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ehG-0006Mm-V5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:08:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LDolu9647550
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ymNGaMTCHRG+Mjq55gspAHPt44XEzt4YpY5Ozb8jc3A=; b=HTI9ojCl8+2qP/vK
 pJZfOmsQk6Q+FW8UhDf2rhOkJzS40ACDQUWl/kncwRwsHkopg/1ulOZpOU7iAkjC
 bNwkvjUQkU34G+x/8oecdT4i1XQdvU4mnWjmc8cuYq/YWvUB2b+DThmuiXFIWv5a
 pDy+qTivWbqO/L8ioWfAGpWH9yNbdxi6bLHRMSDLnpvYvdWGUEWtfm5xbCVkNYIk
 FEbE88X2mLKZ9DWgGj18S/W5qrvsVWmvnswFjADeuD49/77zjQEv2T64neCwtGdv
 BeaAZBwNilvkw4LmWkL7Ja3rzX3yFRhn/mOEsALbyW1eMvrwvtPpSybY40bZwvnA
 Ak18zQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gs9v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:08:40 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c83124d530so4040001e0c.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789999719; x=1790604519; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ymNGaMTCHRG+Mjq55gspAHPt44XEzt4YpY5Ozb8jc3A=;
 b=ONoj8c19w8ROvukQ6l7dmoF9HF91DDK4Ndt5Wm5wFRR4QlbYlCDS39H6QtW2FsUKE3
 30aQ2zQzfv2/deIOdIiZvXa7pdRb2Ic0pmOqUYoB1nT8BQLJiD5YUxGkrr4/38yasY3E
 gwfaWYj+EMq0f+ipnPavAHS+yF9lo0uqFIWeAmyWyPJM2E0l1HHKPY3XUPmZeNOa4Dgy
 Wa50lLRBeAR3S9bZtxNsTRsg8opoHH1O6rBrYCEMWmZkR8m9dxtFwcwYLJSQL0We79ru
 qI8hvWUGcCP2FwwzRPLdVaKS22Ap6rsP5pZ8rWUxxnVLNCmpo9Ags1tZi6guZ6/kZXRx
 f+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789999719; x=1790604519;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ymNGaMTCHRG+Mjq55gspAHPt44XEzt4YpY5Ozb8jc3A=;
 b=lK6NfsZL9yY5/CjzIrD5Vya7DVJ/S0SYD+qUIbIuVo+Hxd487hoECWHflaKrhhF0vo
 KV28elu1gZ86/WljMQ8H9eQa4VwUoU+b3lNK5d4ySM3iMMoBb0WPQzUZxe9LvKZ2x0dR
 CZqsya04mR03WZbh5UtDXDdFkTodauPqiddH2ZKEPNkIperCciCXsWBVUKa98Nwp6SWF
 eGjvj5ktorGIacfC/qmxY40lhhcpE7jdD12WmLVj5HSoxJyl99YJAnDSg70xDJ0Ymxcn
 ij52G1ecJNBPTe3GMjY6byf7SevlPjW0PK9VE70bzfcAyeGUJZ/Y8NinY1ZJwSrAbBBv
 Zn7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/PJ1vH0NpzlEqLa2Pp/vwblXR9hv/Kbn4U6EZjltwtzxL3sW+x63evr7FQ+nJVyf5nf5amuxlWKeh@nongnu.org
X-Gm-Message-State: AFuF++nv202kVsXLRIqYTSXBqZaIaGjePt/+P1eunjjaQmRh7OPGrQOe
 mb9ETyv+XHnNSEQM7WyjnzwKK3ZS+nvcIJR+q1gEmYBksLcCMcBeWZ+3zPKg4SyhhuKb9elT12/
 tk+0AtCuWx31ylNjc9FKW8pyB4dp6OcY4xdaLF/FZNB17AInpJoNuVBip/Q==
X-Gm-Gg: AYBFou1Qm7clzD7ETADS6JnrT1+ZVqD78TkeHjLT9AKjPNQczt+wwIQD0oKYoZFys0z
 +hoFa6Sky0BiY1x3i9ML77ozLAtPbGKrdrqfAD90uew2D1QcpZJruRpoGNeLtbEi4iCq59PH5+q
 kxnsBM1cRDj+7oNfdQsA40p25hdFodKZGEXuys6CjFMp5URMGkumT4T/BsCgj0Yk//zYKrGCACe
 7aVJvL4YlP14eEdS0ms7vw7tDy7dQowwomuR4V2/I8BwXxRkn8H59LAMjwfKk1Zoo9grNnkNjkl
 JqXhWl1Nla1aS728yFqwG+hXt+HuDynsx+3JtTjawR7V9lLJxSfSNU2oyNKJ2X4HZj7hVdrZHDM
 yCwrPLuhGEBlM+KyUiyI=
X-Received: by 2002:a05:6122:338c:b0:5c9:a60b:e5b0 with SMTP id
 71dfb90a1353d-5c9b593424cmr5754967e0c.9.1789999719633; 
 Mon, 21 Sep 2026 07:08:39 -0700 (PDT)
X-Received: by 2002:a05:6122:338c:b0:5c9:a60b:e5b0 with SMTP id
 71dfb90a1353d-5c9b593424cmr5754893e0c.9.1789999719220; 
 Mon, 21 Sep 2026 07:08:39 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724589c02sm22539670f8f.24.2026.09.21.07.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:08:38 -0700 (PDT)
Message-ID: <3c8a82f3-6f48-416a-94d7-64f4f65d12b5@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] target/riscv: Replace TYPE_RISCV_CPU_BASE
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-1-f98c5a244636@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-1-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MSK-gwxyJDr6ngkgbAVmavGVRlrsgsiL
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab13a68 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=2B1V6qbIr79x5vUCd9sA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX748wHMj3knAn
 QD4elMS6CYUpA5TVidwkYE7L+mpWsZw0lbQu7IqXzSTxUltp23XDtn0UiWlYGboe3rmUnz5d/St
 j26UFfBLrr2XPFunl5Lf+gBOFRvbfPt1pgV85i2vYmoRHRofZ3VztyfkVW6Do0WZisxh7J1Xipo
 hzwyCOk/7gR+VzzJCXBbqUSwnW2XslL1b12KbaYoo+ixlolhyEJUkqLyObNroE5nouhON/gjVCr
 kA6cUtVPyczuYkv0ZPDbMG4Ot36nkqQELkUkrdIjx8s/l9HMb/WkdwVw20v4AUd2ouoQpNJ7ZsU
 RxapUT3oDnQk3IO1LG2sBUClAuwXJnss3lE8q1DLiFR5FXxWlLU3aupFSMNuH+hNJt03UA0x8Ui
 uewuTAzsZYnlwAFTED1NqitTNMrlUeXPyRgdc3y0xRkIZT8mZZPgsEw5W1cs0+eqZN/YL1iTSEO
 8gGzOmRtSHanyDxqp8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX2NbSSSi9VV5P
 lh9OajXgyxo1VTpH74NsJdVcXGdXDcQOJYgyQWOHfXBvn0XHHZMCj5CwazjedG7E2qpOrGl2u1m
 6fDhqTD140y4NUxGRqi0h1S2R8WPEl8=
X-Proofpoint-ORIG-GUID: MSK-gwxyJDr6ngkgbAVmavGVRlrsgsiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2026-09-18 0:04, Anton Johansson wrote:
> TYPE_RISCV_CPU_BASE is used only to initialize the correct default
> machine for 2 machines. Replace it with a runtime check.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> --
> Note, this patch is to be replaced by: 20260526095731.63525-1-philmd@linaro.org

I don't remember, do we need the whole series or only
https://lore.kernel.org/qemu-devel/20260526095731.63525-5-philmd@linaro.org/ 
?> ---
>   target/riscv/cpu.h              | 6 ------
>   hw/riscv/microblaze-v-generic.c | 4 +++-
>   hw/riscv/virt.c                 | 4 +++-
>   3 files changed, 6 insertions(+), 8 deletions(-)

