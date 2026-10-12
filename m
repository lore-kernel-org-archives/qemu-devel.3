Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E6DCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCOB-00028o-Fe; Mon, 12 Oct 2026 05:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGCO7-00028J-Hk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:32:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGCO6-0006Px-4D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:32:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8KlE21439169
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GyRcXF1ciT9RJ4zdYe+TPv7B62fx7H8HsxB0IuM1B6w=; b=bFFZ3IOZUP2B2CgR
 DyOeHlSBw9/5xxjveJWcvT70xDr/7/0FZiaeKb7veDu8sJRze40VsqzFYfEtvdzx
 i47dOxZC+c1mU9iZVYy7bMcH7mTRXlIBpvAZ/qqGEt4w6AaWxqNE2zlfoFYSZfkz
 IX2CQbFOBI5ctIYNJ1B+SySWr58De9L6j98yUoatctoKinlWYOTX+3OOskhleK6a
 bkqZpHn1hpNO+SGY8O2pgo7+CAmbtcctM1GZnRJvDvCVRrlU1o/JJRqPmUuA0ZBy
 DKG2StnMgDoIbNOd3GwmD1vplQC1aBiD+ChvGuOFCl4DhefiJz7EqMgxPRtGXAGO
 i3HySQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkhb4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:32:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so329661485a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791797524; x=1792402324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GyRcXF1ciT9RJ4zdYe+TPv7B62fx7H8HsxB0IuM1B6w=;
 b=f3ZTtxjZo3eZegjdwsGkUmuhpuWwKT0qtm3sWW6ZXWrARPMFAOO0axiZuzL5aW7SkG
 Q8C8/xhFVNcluOKz3cqE3YxfJrcDEnWfA/jum5zeS6MbMcgXcRep1CkiCjiggCIQbx3p
 ulDhs1pJwnsiHqRQ/+XtBMEV2Hmlh9N4+t5BuzOKAevhu/uer9nOOyVDF5ZRqfLtFKuu
 RA7lF7SmzsWxW6bTre75OV+bpePGkOTTdAZw3RzR6PBD+9EUMUaqK7P0BrbOKncvIsyW
 Tv1qnUEUcerr0Q643Y8io5M40zzMfkExVcvwjpeBuq4d6WtMKeeRo5qlqpD+8s46IxVs
 1uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791797524; x=1792402324;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GyRcXF1ciT9RJ4zdYe+TPv7B62fx7H8HsxB0IuM1B6w=;
 b=uHuxGGG/6kWQvngNCygyM/GWp5EcNFStDKAf8RdipyFSfAJP6zsy9KohFlFErvBCcF
 Iit9VXRuwxsEXo4l+KX8TYtuw5nQYNvdAjlPFYMpWxvVkVN1Z8VwMJdIvkodOezy71t4
 pXKBnQsN3645KbHA+MEwH8wpiplJ63uAsbegBdmD3fv8LUZNS5wXhGINOEaD2ABAHNT3
 fQ441nholRScY8DbBO0ozC8vcBw1qBuE0MY4+wotf7HHUE/+p5NLDttn7IYj0E9MCdRq
 Pn9PJs0duHjamCSepTBkt8dMA4wnioV3mjRPmK5yofL3pRPPyRfw8FLoQccrauUAG8rS
 VW/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByqOWWlmusJb977jdal3pYRDSgq2DkaVWIYFqj0UjsB1cMWhUP4wSlwyWTSof+MT3VysigRKg38KoTK@nongnu.org
X-Gm-Message-State: AFq9FYJfbpCWb6xrFxk76VVw7J6ECXkdnN5koTPhryoL8OMGzIaZSsEr
 qgvxC6btG9mVfh7oIelmwV6A3vqsHcPbTW0rXguCR7ut4qeUwmL3InAhLdMRcw35tJltpHjkw3H
 JmHCzVlUps8IRKHc2YAx4+KM/4sZT7IXLfQLY39DxT3J3BrZpxf+oweOIHv4XLLUVqA==
X-Gm-Gg: AYBFou2aIICwChpeDc0oLHAt6qCBdVjCUL1/KwXTaflhljV86P7BB1Y0T3oB745Su58
 w49o20tpMwtvVpq8zw2mSThykj+NySQyIdA8o22sgxeaUK6C1vUS7CM66WLeapMeZx0pYsgtiDD
 4ovtVgqvRqIfKXXAI4vSw6byA6s3tDydeKUV4lgRohlNmO9C7DD4DM8vQTjkzP49icmCQblgHhO
 IZv7rxuwNBOBkYLK20cmV7xfALJ8FmJ7rlCVYtDp3t9MjR3j+ayBVfTg7HF0hdmkGU9s7GzG6B9
 fV5suUcSjdoTbLjvwsMhAxR5tfYQMrwoATMk4xUUNEKw0AX9BRQH60igotD7+0BFLWzQedgwc/D
 hdxUouVdp6yhpaY5WeMuaNGUt5VLdBT9cmZk=
X-Received: by 2002:a05:620a:4891:b0:93b:c458:8254 with SMTP id
 af79cd13be357-93ebd274041mr1627688385a.46.1791797524392; 
 Mon, 12 Oct 2026 02:32:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4891:b0:93b:c458:8254 with SMTP id
 af79cd13be357-93ebd274041mr1627684985a.46.1791797523987; 
 Mon, 12 Oct 2026 02:32:03 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb984888esm825978785a.16.2026.10.12.02.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:32:03 -0700 (PDT)
Message-ID: <a60dc61d-1c0f-4f27-926d-fe9e3b607be3@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 06:31:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Update Sunil's email id
To: Sunil V L <sunilvl@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Drew Fustini <fustini@kernel.org>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
 <20261011182552.1071742-5-sunilvl@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261011182552.1071742-5-sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNyBTYWx0ZWRfX7XUIXHsIIFq4
 T1QC0/VtCq1BwHoeUr404iE/2hyBjaNC/bpHhFE16Gy3ITLDu7tmgbFHrPkok7zsmmGirc4coVk
 ZHQiNxhxEvc/uIM392Ir4Jhk7eQvaJqB+mrFkSgQVzeQ3SgDMow1kOZmkifnWL32FOm222+PL04
 fQWXwfVu/ZtuqSU4pNee4oCsj3/3ZwHn6zj57ZtMrNwCmetVBtikzNmR8ojv6MZeHCzmWptuta8
 Aych+tHtYkr2XadXgDSZBQOqUtfOXvneadvHmxbb9MyUuPbpCdoXXsNiDm20sfPbrHYg56dq7W+
 ed50uDH4RL1XLcG/AONt5dqHOpN+bvpQif+Mpjj1+Xb0FTat2uVplN6X4uwHelXiz1IaT2C3bmD
 KtSDMXj9U8tDyL7W+bBkglZD7cLV4sB34+AQzvHnFzzmp06aJ4tT6qGXvZ8MdtLWTPbyekoSFg1
 Yr3FH6mhYYi7/ghu45A==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acca915 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bDdBU3oEAAAA:8 a=69wJf7TsAAAA:8 a=gNWp-g1RRsTVTnLNSnoA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=DN7SgORnOiO7RqxRx1GC:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNyBTYWx0ZWRfX0mh/itDrJcVY
 I2MV+xCcO0O5Ed9UQs+EXcVqfcwk/G75Y+iRGry6QaNQeTtMrK6Ge+U90RMJ6r98YjvWUDMPcOw
 O2jJq7XtblUgo+w2QKkx9ESBrqWvLNQ=
X-Proofpoint-ORIG-GUID: wRIZ3Tp1lGYfuBR839HYXRLLn9WYnrLO
X-Proofpoint-GUID: wRIZ3Tp1lGYfuBR839HYXRLLn9WYnrLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120037
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



On 10/11/2026 3:25 PM, Sunil V L wrote:
> From: Sunil V L <sunilvl@oss.qualcomm.com>
> 
> Update my email ID to qualcomm.
> 
> Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cc426451c2f..5c2282088610 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2335,7 +2335,7 @@ S: Orphan
>   F: hw/arm/virt-acpi-build.c
>   
>   RISC-V ACPI Subsystem
> -M: Sunil V L <sunilvl@ventanamicro.com>
> +M: Sunil V L <sunilvl@oss.qualcomm.com>
>   L: qemu-riscv@nongnu.org
>   S: Maintained
>   F: hw/riscv/virt-acpi-build.c


