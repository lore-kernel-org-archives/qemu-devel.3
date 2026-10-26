Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6STM/gL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4964yfF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLQl1-0003xH-Oc; Mon, 26 Oct 2026 15:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLQl0-0003x2-Md
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 15:53:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLQky-0005in-RV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 15:53:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoF1Q2591422
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 19:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ch6k+PDJoONDeIHFDuknhRgIt4PE/KybTWvFeK0LFQ4=; b=p6STM/gLvT88ybfW
 yQh+OJ2NxrU/Lp0y1yMyb2Jckp1X2wHoCerFAby0friUQQfwF8JOBKo4QrmxP5Re
 B0ohXj78cL2rLztu/dR50Zh6RyjzBMLudXSmMigbvRV9zMaQqs78NQLbuYQXv9BC
 Fwr4vZov2Xje6IbZCQ7LvIWomyo8vktzdE7nLBaalEo9wdfaAzdT3yv8nQd70Luu
 VjJ8CY1C3mASH1mx57YbZ59qPrp4E3HRw+9U80ucOG7MdBLCGrupAsL3eYxMAxrs
 fhm1AKqaCzp1OMVb4N03/IUSCa8W6fQA3Hr7MIdaz6HYKh9V8mxLW93MWFDya1HY
 phk09Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54gjqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 19:53:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso716811085a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793044397; x=1793649197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ch6k+PDJoONDeIHFDuknhRgIt4PE/KybTWvFeK0LFQ4=;
 b=Q4964yfFWBvf5CQhiE64B07muS+XRMF5uFVaaWITFNR87EGmOln6TDuBIJHAC61uSf
 KJ+RWHc4aEXIbLK+k/6muc0zh5xVkMrJLYXU09/x5f0xOswMdqPu+W7JUumw9YBnWYtf
 iZeSHyv8vPK6AidpVf5lKUey1Epek6lO4B4k/AcKMATe2BokOD1zuiysqB3RJw7L7tm/
 Ko/3ecWlqIXoONu2aLYFsniAQVVX0lGmIGY3sQgI6sKZ6pWfxqq0rGXzi3gTd+OI06s9
 vZcfXHHIxJfu/G8OIFCNjEA9FBs/QL6xdX45IETQyy8grHv3MO06g73snNPSzsMbjHeS
 aolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793044397; x=1793649197;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ch6k+PDJoONDeIHFDuknhRgIt4PE/KybTWvFeK0LFQ4=;
 b=UZO9gQ2D2NKuJLRsf/w0NVC89F3cyX7u8j0nEM8icpqfMXrKElfXVdldYZeJ8jAc9z
 uU/5Prvbo9b1zi7DK1TRJzqGCVU6KACovBgvEMrPSt8aAKnyr/Y7R+NXJBbd8C5Ddz9j
 euMJM3L6AslWebzU/w/+/v9waRUnDVN56t5ByOzgla+itwQUYuSz8cznksTODVbvZ/jI
 I1OGDJL9ftGFoEcAn+2TYSs3ciUWbSGeLZE8WtsYc9lGi9A2qQNc7HIU/B6Vo/TUQVLe
 nW7l3iX/9rCJ9h4EMXEwyfVcmmiMo+j66LJ9KKtCIqA4d9RlSXyA7cG+8cMSI+tKAZtp
 nIKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB3lKfsrcq+wkUaKz8RCV11Qpe1ZM7yIfzt8IttAwlrju2eSBLP6q5wUSJEjTz+w7jdwYPSMWOc14Q@nongnu.org
X-Gm-Message-State: AFq9FYLTHlrHc2IR80D6DU2/reInEJgAiq6VLBCmt6iTdXnSc+DKMMjP
 RRU1I8fUnxS+/1PfFLIrDFljTqe2I+5aSPSkaTArvdza1WGM4vHIW9F/vM5f0DAvEYYcrtfKo1+
 m1VJRj20LGhJVCuIXNqravt4qJEStFtAprXBh3V2cWXq7dU0UdM7+13myvA==
X-Gm-Gg: AYBFou2gVHLOkTKx0YDloQQRrFWYoDHcN0vPl+Go4iYIz5jDNbb2lM3yzEIMT/zKbxf
 gPxuxjsgt/PivDFl46lgZdBM0qpEyvPv0EhHdUxzAkS59KKf5iedjjy3TG/ugyjJWbKxgwTsru2
 0yyPQyxXBFwy0GY2oUhWRj9M/5TXyOxPrPDeFqunp5AAyNfqUjvXyHPiZYn/21aVD4J6fmarfbI
 SEhcYh7+kY3gC4jbmw3MEZJxZC5l6oVes/Y5rpj+JCmbCJuccNYe8kFGgI2vAdtgiLza7KD6HeA
 8FhsbHrGNzNBBcoRQeQ3ub1Jf8SzUQcvf8s6qsllufgLs1vrPeRFVGYJ4dSYU1vbND9sD18Mnde
 QNCB6/FEnquEA1/2R7E55pMG5+YplAVxQ1g==
X-Received: by 2002:a05:620a:d94:b0:93f:38c7:64e1 with SMTP id
 af79cd13be357-940ef914dcbmr1383067285a.25.1793044397478; 
 Mon, 26 Oct 2026 12:53:17 -0700 (PDT)
X-Received: by 2002:a05:620a:d94:b0:93f:38c7:64e1 with SMTP id
 af79cd13be357-940ef914dcbmr1383063185a.25.1793044396978; 
 Mon, 26 Oct 2026 12:53:16 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f59750sm146084755e9.0.2026.10.26.12.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:53:16 -0700 (PDT)
Message-ID: <e82fa1ad-8224-472d-8abe-c816218ba7f0@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 20:53:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/pci: Change reset method from legacy to
 resettable exit
Content-Language: en-US
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 oelghoul@linux.ibm.com, qemu-stable@nongnu.org
References: <20261026171325.876-1-alifm@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261026171325.876-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3OSBTYWx0ZWRfXwVdnmF1Sz3oE
 pmdnGkHPbpCXAvF3hr4Dn4bJlTsCUnk/4FczKeYQxrhoJvmyvieyPeCN+vxS0ZTqQgRK8N1SdQf
 MmiFzFm35SE/xKeQf9/WYu3oUhMvI0I=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfafae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=d7NhgW2asHvCUJmJubMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 91bIFqg3FunXfEYUl-3lOn8H4EeCILsi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3OSBTYWx0ZWRfX/JVgTUNJ+L50
 PW/xRdSRr8Ew7wFPL7/EwZoliWlchs5wUyh4yHK6ihB3kwVdyQSN4/VMu2rvE7QK8feqq/00wx3
 ZGk4TnbyVSyE9I/5qTQH9LWE5DR6NdpxPRakuYUEbc/+HN7b3GrcoT68LQnQL8Xrbb6iOXvtjXA
 Sq/m/pz+s9NXV+rngbfPdx2ynaMLpY3ZkghFs0xY6aMb5bTn4/zYmqVXrdYH9JSruPxtkryFfq5
 RedUWn5QAk0ycuv8gNk42ELRm3BLJjydR77j6aEzVbqN2C0bOtu3oRD3GkUjJPsOgCdICxirPl1
 Fxqc3MOwcE2pzMPCtSMZJod64UrRCrdt9DZoNIWYQbbhEIyvW+3Xnqd2mokLeSEwt/0wrZu65DW
 zOaY3X+NLRdl4LIyDVOI8YV2XyWyVKlxFCkZBfepaUDMXopAYQNYiP/ee4V7G/MiQZq3VIIl7Ne
 hIpMWDvI6MsPTpx+PoQ==
X-Proofpoint-GUID: 91bIFqg3FunXfEYUl-3lOn8H4EeCILsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/26 18:13, Farhan Ali wrote:
> On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
> child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
> devices are reset first via the legacy reset hook, IOMMU mappings are torn
> down before the PCI device itself is reset. For a PCI passthrough device
> this opens a window where the device may issue DMA to addresses that no
> longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.
> 
> The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
> should perform teardown in the resettable 'exit' phase, after all devices
> have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
> from the legacy reset hook to the resettable exit phase to close this
> window.
> 
> Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
> v1: https://lore.kernel.org/all/20261022185829.11835-1-alifm@linux.ibm.com/
> v1 -> v2
>    - Change to s390_pci_device_reset() to resettable exit function.
> 
>   hw/s390x/s390-pci-bus.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

