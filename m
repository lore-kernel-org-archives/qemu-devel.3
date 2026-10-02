Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5623CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVCn-00024h-3C; Fri, 02 Oct 2026 00:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCVCl-00024C-L0
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:49:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCVCk-0004Uj-4w
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:49:07 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922K2PU488225
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 04:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jMSopf2bySxnzO9OV/tchpE/zgMb11zcHIFL4eg50gE=; b=MaoHa36GNQ1Ijt2Z
 LjYflX52Z7fqlkl7GCyO059XjQrGZSVazgfsgW49LzbQv984Y6V5/VAHErxyltNX
 gjA/GsWJaanpC0F15wXDgzlwEwAAd7TPppTUUrjJhdDpEdVBmRz6MHeS7C3R+5x/
 pyQI89D5S7zL5SPVdPRKbaNI4qFN48DF75EajlBTgfLiybL3uK2pZhMMPrHRWODx
 MIVxeDiTU4kaBT8DaEAClHe1rUeETz8Ho7ntL+XoaJL33ykvTUy1bWW240bzWetw
 lwoMjp2TLgGN9b2ASnsp+OpP5L1NgEU84u0n+sw4CrUlpkXjN5xAMm1XbMMbNF/K
 e6dOmg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh0vap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:49:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9175cbd3beaso100638016d6.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790916544; x=1791521344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jMSopf2bySxnzO9OV/tchpE/zgMb11zcHIFL4eg50gE=;
 b=B3THFQd9qDZeVte7spakaXUIYGB+zwkerKhdopkyJJ+TZqxzr4OZUWwifyuqSIFoRq
 yHkzNEHLBJGJ0dbOW7OQv0QR21IiiEifv51+I0asxiQ4EEDBw+vIxJUneY8rGHU5gnHo
 KfWjgwiu964IIwSzCZPtTdd2uaLJKt7/84mb4bpWDbN2OtybuuQqDLG84tHrApjK3HxU
 FYoLRxybDMaNpIs3BtsExdNO5gxjussgoKZkHZ5o8Onf4spLzqD7n4yjSaL/hBoilidA
 r4nGX5EkhCQ30+G3z9PSCKeFe9TBEuR1gWWIuoSBXt7ivfxH+K1oxgns4pYcRb+2Q9l3
 XwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790916544; x=1791521344;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jMSopf2bySxnzO9OV/tchpE/zgMb11zcHIFL4eg50gE=;
 b=clBAmE3hhHMcuEMb9gGoVaMK8tFLFgb+JiW7poPAm9d+MzaAfZXx5XnaIC969Dj58b
 Mfd7clFigvQwBUysqIdIEalTHEOy4V5NFQ4AeHwRWqL4mPJIpzldoyJ4Dqh9+Kt2ckjM
 uBbPw9abut6HCt+QNvNbD65GkQ/7dE1sedU/78DKQfiU3h1bZflGWhuLnfD6CKKj0qL1
 w9inViuvjqTRB/d30rNSuHppBnlrbG//yceD0hR4vDHQJdf94op+JfVJP5VYs1XQO/oh
 /SbS6qCsdc4Rn2DiIf91ivUVisQsqYSDF/ToofB3nAm1eAWxiwRR3pSuCZ0YI6HCEHTz
 CBpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqGdBQ+jKKurGQqNxMZQtCRBdcFlozpbXtH1L++Swh4A4rl81YVGg6yW4swmKlh11+mZUvluzR3NYr@nongnu.org
X-Gm-Message-State: AFuF++kHpkvN/hGU8KZR8p+Pqe0r9IJAlef0B2XoS7UTn/tLF1BApmeS
 CPh5r/KtQxlGR5z0O5xhkLFzBAQuQb5hr3hiDcs4ZVhgg5CqYfxCQxVVmw5DI8vCPb61c5YPxZE
 opMAPR90+U6dtjT3YOAUqP+uM6kBqJf7zvuOcJ7rOv3jEuWzhM14BIO8H2w==
X-Gm-Gg: AYBFou3bey9XHtpRl9blO7KHebozeaPMp5gz84EXRjXX+CzHx/7gMv1aeHyMhET3Asy
 8Behh/ohKNKBfd3CO38vsOTgBlTCkYdUJZ5BkL9YeEdpLUf5JHeFHvbTIZLJhA2VpgPahEIkGJZ
 Vmo5qX08MLzbnazpcKh/PgLE0Unec/SwzdRyPTKmMm2PIqBy5LjV1+LHO7ckz03rmPoHtf3713V
 MnGn5dlpxAOu6+SGcyNRNKfp1fhqgIqw7fWUaxQ8lWORFp6W+/0GMm5veCPhxNyWRLBnLCifYng
 zHQZ4suv5A/sxEV0zTT4xrIKapy50t5wrMJ2u1L3AtStX9FTWCWsZiSU1+izphZ1ikR478VDknV
 gBxRziEbe7QcBTHeMRZ7EqFwU7JnviiuveQ==
X-Received: by 2002:a05:620a:19a1:b0:939:ff11:5338 with SMTP id
 af79cd13be357-93cf19d92demr250221285a.40.1790916544079; 
 Thu, 01 Oct 2026 21:49:04 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:939:ff11:5338 with SMTP id
 af79cd13be357-93cf19d92demr250219285a.40.1790916543574; 
 Thu, 01 Oct 2026 21:49:03 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380faaeesm2655460f8f.18.2026.10.01.21.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 21:49:02 -0700 (PDT)
Message-ID: <5622c432-c2f2-4f1d-a8dd-c5c12ce91890@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 06:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] mac99: Boot OpenBSD/macppc
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
References: <20261001230058.11465-1-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261001230058.11465-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxOSBTYWx0ZWRfXylRI5iSBu96v
 uFYmCT1HRG3Hf68+5+BTp5OKe267PAA9iZrADkthWDgnQ+x2D4mgX3zakkAfs2QUsLnNz5WkAdT
 PPxkkj+NeJh8AWHRwyuD7dr9mjRIO0c=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abf37c0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=xI8mmIURqZhCa0dEe2AA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxOSBTYWx0ZWRfX1i+biVj/nGXd
 Tanm5kjGJYswP2sQ8SIHKFsP7DeFewA6DzpZTsA+KEVMk923dtsFG05F3S7XC8qQu3UIS3WvbDg
 /ecAK+UJrakcd3X/Pu4teH3AbdM3lYEr6wF8cxo8+DGCEits4HiQjCXkMSB6bjBgp/R/p5wXEs3
 FU4auvWZDjHZ9TjlOiFiBmmpMRkRaZybLxz++3rjk8la/KsEgsWnkBqE1q2oRyyr+qsxS7LyGjD
 ssdF8FHkXUK8fXixUh/0AKjNXfpmo8zVJGmSLb7RoPqupLdbuMJGDE3UdqnbolXKkEIT3a1UYwB
 jVWM3KUGsVSifIIinvbQCek7RobyO7Gv0MUZWrC0ZHCyRq0gER2A5I2M4YwOyd56Iidv4gEv/nh
 KW7F2orHvzRfpcugfhsbfzghdQ6skrWo4vbdweo9A6vg+fhd2/eDtNtp3vcfCD8kRClhQ8+bb6X
 qSLPeSzTDcqweY44wQQ==
X-Proofpoint-GUID: Z6tOE-Hs_9teKtIZabd9GN2b4gqZMB16
X-Proofpoint-ORIG-GUID: Z6tOE-Hs_9teKtIZabd9GN2b4gqZMB16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020019
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

Hi Kirill,

On 2/10/26 00:58, Kirill A. Korinsky wrote:
> Greetings,
> 
> This is the third version of patch series to boot OpenBSD/macppc.
> 
> OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
> reassert an interrupt still masked by CTPR; the edge triggered
> decrementer does not raise on zero; successful CUDA ADB replies omit the
> original command; and the fixed CUDA shift register delay can stretch
> packet delivery past the guest timeout on hosts with coarse timers.
> 
> This series corrects these four behaviours and adds a functional test
> which boots the official OpenBSD 7.9 macppc CD to the installer prompt.

Can you add your testing as a functional test? As a follow-up
patch, not blocking this series. (See examples in tests/functional/ppc/).

IIUC this series will be merged via the ppc tree, is that right?

Regards,

Phil.

