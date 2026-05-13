Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DA1CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNCGL-0006e5-9K; Wed, 13 May 2026 12:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNCFz-0006b1-I8
 for qemu-devel@nongnu.org; Wed, 13 May 2026 12:16:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNCFw-0004OA-Vj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 12:16:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DBgxOO2965206
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 16:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WFoMnAzGzWCwisQKu139wnNmd7LsBaf21U6gTocY+CU=; b=CqlPy++itiuGLtva
 E2b18htOoAtZk1bti7szmVMS/lkvFTFXQfPSDHk/mer+GjNPHA1A5RYQjb0zDSU0
 TbnQcqduB4o+vVV3wOkN11yQ+Iwt3OFQYg6M+c1y2BghdjvvToD+/IZ00lcwRFCX
 UQGMkROdZIxcPEXDp5+51zWo1vgLmfy3ECAHvKCNh3Ez5LN8Li5FM3qM6e3T57/h
 ZxNt1m9YFwyGjsf/lsvvmg7tGA91Pwp8LYuIVpryVBEObprgaAQl7g92KEjGhCXj
 9Xp46ZRHsfWKAsU8aAQbIoAJyNjVHoX+0SAT3kMzoWAsTLtKhVOXmgIDVqU68w8d
 bCN7bg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma5a97q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 16:16:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so897469eec.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778688978; x=1779293778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WFoMnAzGzWCwisQKu139wnNmd7LsBaf21U6gTocY+CU=;
 b=Rhy3xirHxcjcM8pvsS23BSUXWs8HSdYIqexXEOdnRnO/LKupoMpLPfR06SEge7uyhD
 gvrYC7icOA3MBr8e8zD/1tly41oLqIpgnYW5iHRFAEqlBGkOp4+BO7dD3VNpyHrGnDij
 Y7NIBrVgTFhZKldMdZH1qliPMfuI/d7s+oXUgEbKKxUyC7QeVtbPX1SNsCxNqWMFhR+u
 aUVyCK8Vj4HlZeEN71NJJumh7kjcFGEpPfmYG1SRm9/kMYVjA9fArrVmKqW7MkhqwO7F
 xtwL3Kx4jy+iWQzwq6lKXmpJEhB1B9HEToHWhvMNItEtHXRMn1p4sz/+1LFZhzMXHvkh
 oyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778688978; x=1779293778;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFoMnAzGzWCwisQKu139wnNmd7LsBaf21U6gTocY+CU=;
 b=UydE/IGgJ3dOmBmNH43LEAcsxWUtC8rSrBi+rpB/QJcXLri0JOH/0sChCvQBnvkqqc
 aSOxTp/A7j7O3zMMOln+1+o09grvEhdQyl9EfyovdbpGKqJ4Qa4gVkZQu551ov1L75c9
 jGn+UP8RqSTzh7zJ91AmmT5vMvpWj2JkEx8rBm0bqOr38d0KY6T6e1Ve6kzVR0Oj4Yfu
 1SZNEKmCWZHDTxiypXoZniNL9xS+HCYAARdVEN6ROifC9vC5d5joLwWSSPtZxCz9CArt
 5b4p09qzdxJZG33TIcgo1Npzn6jrpZZrT8ADfe+3fqfHi5jMZ4Wm2rxjX+eZ7dTiRvcH
 puwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dL5zb66FxrBlSJMqOniQs9r+CKeX7YXlnes0gNjjXY8bT3QKR2DcVirZUm0VkmTOJQFIkC1Zyo4oq@nongnu.org
X-Gm-Message-State: AOJu0Yyi4fESaT9yEqUReI8Q+6i88xxD7ZHrRX6p80yanft4wbt08RYQ
 yD7pmiG5V9a/bkcog9gW/8zeT/rcdX0xLDyXXwgIVHyNaQ9YrknERktEhn+ntKBltQKDjJCaseX
 rgrHuQYtz9cQMlgNpANy2vLwD/wZpZm73oojmiMGNkvprCRof1/Hxt2l8Ag==
X-Gm-Gg: Acq92OHX8MPyoVDUu7xpoQx7pqFqxRrC+0dDs2Qt+R6WYaXK8WaXqybDN69Yx7NBLdj
 HVZrg9tKs3NmSdYavR4+LCcQcl5/CVgWS5ZSR2Q0itSIrSHUvW1w+av44LsFAA25yH/aTxA5LJJ
 aD9H2a0hHbaCeuo7cPXgJc+sUbYwaxcbJBqwOpPwXWSz6wtkaXCyQgYkC5JGXrA2BI8RtZWMrQV
 UtVjEu1KNVon8QnS357o2WvHnzyWWjqmCs1CAlytRP0bO/e2L4L9omwv1XIXinqD1s1p7MBsl54
 6NPVhkmYafzq9smdPpsPHI6FXVK3JXQ1xX1FMAPbXsG2b9umT7itjTUbBk7/niBkvRsxrozC9+y
 ikASVnh5WY2/Mm6WJsTZG162RFxwbLpON7UqVHnnbQp7UQ+Ocl6Gx3HZdKYbolMzvTq90LCIL37
 XY8nsScKGOEGx70Q==
X-Received: by 2002:a05:7300:b586:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-30117085411mr2613496eec.4.1778688977599; 
 Wed, 13 May 2026 09:16:17 -0700 (PDT)
X-Received: by 2002:a05:7300:b586:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-30117085411mr2613456eec.4.1778688977002; 
 Wed, 13 May 2026 09:16:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d43b4sm22332633eec.11.2026.05.13.09.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 09:16:16 -0700 (PDT)
Message-ID: <368f7343-f0a8-40c8-bbab-663831962660@oss.qualcomm.com>
Date: Wed, 13 May 2026 09:16:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/ppc: Rename spapr_pci_vfio.c to
 spapr_pci_vfio_eeh.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
 <20260512071112.9675-6-nnmlinux@linux.ibm.com>
 <ebc9e323-6acb-4224-84a7-1fdcc0841205@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ebc9e323-6acb-4224-84a7-1fdcc0841205@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2NSBTYWx0ZWRfXxb8AUvNm+hcI
 hd7k0DCqOiTOGcEx7uxvlK1SfeEcDBelsxOXRJFzrBCbDz8gvXeqqgoGVQJUvpusEDVPo8oAAyM
 PDawApA8AIJTAaW5gqVWpYjqb3h9MonSyhDZzVqNTtlYDuI8r4cqI9E/dXx4UMhR/Ea1ROuHU+7
 koLGNyxzafRj9tA/g6y7eWeJIfWT96hgsPIfhZWQi5sLqiFPBcsGGzxl5D8hQgRQDYRf2HYN6V7
 gqbemyMRgH+BRQOQiPu7Kkk+PPmeu9SwW1Jl7syjiQQyd0/xbYdQoj7bqDzI/o2bFF44qdGJYwp
 ekBoambaXxYC0OpI/7JJPH37mbnBklicbwl9xtcZAxF9pYvqZmCeo+m6nmcFPecjX7wvgI9vA2m
 hZGnrEQvoSW1Y1ArlQ0iHRHZDeBXwAjwH1TQPlY16KoJXqsgqJqbp46FCRW/CkBhVwa4ic6TkEG
 F3dLZ5P7SDPLp2O3vdA==
X-Proofpoint-ORIG-GUID: bHOppNjNVjxy8_DvCVUav8j-EOKh-67N
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a04a3d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VnNF1IyMAAAA:8 a=fIU2VSnNEEcB7yV1-LAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: bHOppNjNVjxy8_DvCVUav8j-EOKh-67N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130165
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/12/2026 12:54 AM, Cédric Le Goater wrote:
> + Pierrick, Philippe
> 
> On 5/12/26 09:11, Narayana Murty N wrote:
>> The file spapr_pci_vfio.c contains exclusively EEH (Enhanced Error
>> Handling) related functions for VFIO devices on sPAPR platforms.
>> To better reflect its specific purpose and improve code organization,
>> this commit:
>>
>> 1. Renames spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
>> 2. Moves spapr_phb_vfio_eeh_reenable() from spapr_pci_vfio_eeh.c to
>>     spapr_pci.c, as it's a general PHB operation not specific to
>>     VFIO EEH error injection/recovery
>>
>> After this change, spapr_pci_vfio_eeh.c contains only the core VFIO
>> EEH error handling functions, making the file's purpose more focused
>> and clear.
>>
>> This is a refactoring change with no functional impact.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   hw/ppc/Kconfig                                    |  2 +-
>>   hw/ppc/meson.build                                |  2 +-
>>   hw/ppc/spapr_pci.c                                | 14 ++++++++++++++
>>   hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} | 12 +-----------
> 
> 
> There is a CONFIG_VFIO_PCI in this file that could be replaced
> with stub definitions.
>

Indeed, we didn't touch this yet because it hw/ppc, and it's not in the
list of target where we are focused.

Indeed, the #include CONFIG_DEVICES and #ifdef CONFIG_VFIO_PCI can be
removed, and stubs for spapr_phb_* functions be added in a new
spapr_pci_vfio-stubs.c file, and added to stub_ss.

Regards,
Pierrick

