Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6475BC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1pAz-00014T-Iv; Wed, 02 Sep 2026 13:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1pAy-00013Q-Gv
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:55:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1pAw-0004js-SA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:55:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Hqr2g1071708
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 17:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GWuNoXDl22brVdwtjDJo4sZjlxceHVSu62z+xiMap+w=; b=WCB5eoSA5Ro0s+Vq
 1Y6x59m67vGuM7akHpA2MWjRB0vSUbOsOtpOBXAw2BvYxW8w+PkrewzFFVGOAD9P
 qRzulSrSWpDF23sH4LTvktta4jqFuhH+iMzjA4A9NWotn54KructrxYoEgPyAxN7
 YwgLrZeT8L/H/KhOJVt4GtlKMtouY70W3qh/A/VRP8Jh0KN+iqvU7F0IvcfsyfNO
 Pv/JBOskkmSlBeMPWpj6B4JLbgyFIfDeC/aDWmGzMsFcpJckW9xcfB5XSrBCv0hN
 5Q8gQRwpvWHdNC1mLXTxpePp7YcEkdGmDntRC6N/Dlk6cCqiGJr+m45diJ504yaZ
 SlrCZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja14wc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 17:55:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93903982af1so367128885a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788371703; x=1788976503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GWuNoXDl22brVdwtjDJo4sZjlxceHVSu62z+xiMap+w=;
 b=Bgn+Czhpx7G+a83b6cChh45kgZm5X//LHJCAiXfGKU8RmHcmCybx5R0XihTjDqdkXq
 JFHAy1rFpIledFR/ElK5amxXbUthz41+hfZ9J1NEYnG7B8cd4/rLFwKgP//xSBkTUJEs
 FsKP925l6EBhyBmrrM2EO/urv4OC/vJBAeNBD5cyE+L85eMjEILpaG1UE30B+Ldhn3vA
 pXe2urTqA3nvu8sLUkpnj1yVUaNOddZJqgPiWk8alR+UDQljMqIz+Mh6xopJrhxSxwLz
 OCLUVcW7sSuXn34uqJEZuyKWmKRr6AjVXUOjtfb8mrR8AQXtBpVY2vWEBx7HNxv7aRyx
 puNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788371703; x=1788976503;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GWuNoXDl22brVdwtjDJo4sZjlxceHVSu62z+xiMap+w=;
 b=Rh5DGU6ao4qLBJXdhktys6ccZvGtlYNIwlGok9ttme1+7127LOHYB8lqqm07CY8GjG
 0bHoIxp7Gn9da8bRbGFLEDgk//Auo6CyCMfPgqzu43p1nukjunK13IIJFQe0GPxrOccK
 /Kf8o/IuL9wgtbl65HbaVVtVAZ6BA12VRJ3aiBndWH0mIDDVuGq/xaIsN+SAD6PNwooA
 J/5rffKgx3jwKGRUC4hR0sWs9Yvsiqe/gEKr3rV7iN/aof4KE9u3nKONj3ehbQRzVZ5N
 kzn58UQj8fF/yUuoj3Ews6SpJeb0c/kfSpluVW2oxdyCg3uAufElVyOeXZPGlY0xWOLW
 bUMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgr55IVt4dTjrAOdW+F0EKAZI9ql4Sz1c7IpB/1HMAXVAjNV+hGob56svb3hO+b24MdLxKRSPtfUBb@nongnu.org
X-Gm-Message-State: AFuF++neSiJB0iuywSbcJua4qfAqyda0YIlgorJ+lwCkfOiPvwLSPnlm
 fn1ogL2jBkcLfntqu4tDigkQyOf7+sRCnu1Z3DmN2BNvC6joJxBrA+yijspzvoDeC3oyCcxrf2U
 vfg2LdO/DWCmvc6MmkOHxrAjlDAN/md7Iv0cXPbMd3Y/mR1S3KVjsxhbRPw==
X-Gm-Gg: AYBFou1lbeZ9tKdikWxLvE+oQs2GmIYRbgrUWHf292BavgvSf4BuDyByyXGU8VSNoTO
 nAzbNJnsUVHHN95yxmER8ZSCZCFfEvcUOWsqjjSyyeyt3n4eRLWLqgFQmN+ZmAqlkujty4ALw/A
 wTLs05+fJzivWkhRsftpXsUuGSbNhQyzTr226/hRF+T2T1FwtSy1c3adVvpxElrzBs/Rd1V8XZG
 OuuGn57YP+VWQ/NZHbIz33edkndJXtel5NbCWxAriDLE2DjHUuxrhKpln3g8ct2RsQ4pkxaVVFg
 1196oueb9AfI3yGOWII8oo3HX9rdr+CEWaweXD+iFM+ayYFWxR1e9zkngDak3gw8Ltrs9d6aR9j
 HAgLuMnJbANu/+bZeqxGIYBoQar9O+dVACA==
X-Received: by 2002:a05:620a:4f7:b0:930:f35d:41ba with SMTP id
 af79cd13be357-93960f88f99mr656799585a.36.1788371698274; 
 Wed, 02 Sep 2026 10:54:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4f7:b0:930:f35d:41ba with SMTP id
 af79cd13be357-93960f88f99mr656795785a.36.1788371697830; 
 Wed, 02 Sep 2026 10:54:57 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dead1sm7656315e9.11.2026.09.02.10.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 10:54:57 -0700 (PDT)
Message-ID: <8a68284e-7947-4766-a42a-6dca3e1a4e01@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 19:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] target-info: remove machine_typename
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TdyvyK7kH5rS1Yu_AOefIl5rdOLbv610
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a9862f8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=0b_n5psab5kbv1ipghAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1NyBTYWx0ZWRfXxoUMnqJHxcNV
 0c0vdDBVWiMaYwsxOfnGrrvaYHyPuAQ3oUeQX15AM+lkwQToToXH+bAxUZ3dCdXkAWADDEq40lQ
 2eF+Ne6CIXhIcQOxxaQVisJjNTEMpvo=
X-Proofpoint-ORIG-GUID: TdyvyK7kH5rS1Yu_AOefIl5rdOLbv610
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1NyBTYWx0ZWRfX5tt2OwJCm5ew
 9MyAp4GOEbX1jrPWCyCMXSLp2usUZlUjUfiQ8mqVdySPRr4dpm2KGL3BdnCVFUpzCcpAcfk+DQw
 U0Lm0rT97hu5fP1Z+fcJexovIz4eDIQojmGpiQmXP/IvIVRyEE/5Bcy9+0MgE9a8yWZcEob0z8u
 v3IiR1Xqe+klholUxfJ6nzymPHabIjHITvHLSC9Eyy0KUo6QdGUhfCtKfkWHuQjmshr0FR3ClUO
 HQhtCUk0nKOPjvH7/XpOqpa5A5GwjIF+SoWRSc305dl5yRHci3/CV9yICNKQscCpzIAFYodSz7X
 fDByer6ufgoBDocT0mkjwRo72X24Bg8KqdaPTAMo0OFVwwONS5WCtuSTiFQMy8BF8IE5Yd8trJ7
 Eixv04YLQ6Ghm0TfIM2pWD9aF2lamVW9xFQ0Hw0OQDUCAOHt0naGpbiVkVmN0ZR5yw1Zd3XoVUm
 KKVeUlM64mM/9k7Bs5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020157
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> This series cleans up the existing filtering interface we implemented
> previously. It's cumbersome and incomplete, and we can have a much simpler
> callback added in TypeInfo, to achieve the same result.


> Pierrick Bouvier (14):
>    qom/object: add is_available callback to TypeInfo
>    hw/arm: filter minimal set of machines
>    system: query machines using TYPE_MACHINE
>    target-info: remove machine_typename

>    hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
>    hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
>    hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
>    hw/arm: remove machines-qom.h
>    hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
>    hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
>    hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
>    hw/riscv: remove machines-qom.h

Series queued except #5 and #6, thanks!

