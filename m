Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C75C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYUs-0000We-EZ; Tue, 29 Sep 2026 10:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBYUq-0000WF-18; Tue, 29 Sep 2026 10:07:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBYUo-0007qc-JT; Tue, 29 Sep 2026 10:07:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5LqO2187746; Tue, 29 Sep 2026 14:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vWntv4
 +5ztEynBalfYBniHhbhchU3XOV6K3+RN/afLE=; b=fm5PeQW9pCwi4K71XTQDzK
 NYn35mL754dH88UFg+P53h2A7pPg8kNLq5vbT1e8JzscHSy0Ftw5tW0G7tDNTH48
 Yj8OjxQc7IpI+Ea5qYPT7IGQZehRVa/xmbd3adp1ry08E1rK/jOwHB+WWqNdwYgr
 +bXPLacsh9ulgVnHhSWy0cSzJrRT0RY6Km8bihF8ynFZ9FPFtAIdy0u+R2q3hsIn
 YwiLdAW3ExdjsvfwysnpLdlEFQfjstEDX48RdUtVFCnzLsBPB+2KcQQiPfyteo+l
 X68nfG0vpXLb/zIoPKXZnVJvVR0kb3ya7Bqhb3sF5snfM6U261L0XF8s6h/nTMUg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr7cxx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 14:07:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAlXjf1667688; Tue, 29 Sep 2026 14:07:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhhy91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 14:07:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TE7hsd066144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 14:07:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86C1858054;
 Tue, 29 Sep 2026 14:07:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DE258055;
 Tue, 29 Sep 2026 14:07:42 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 14:07:42 +0000 (GMT)
Message-ID: <a595bf66-f2ca-40da-86e7-54142470fdab@linux.ibm.com>
Date: Tue, 29 Sep 2026 10:07:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390x/pci: Fix frame stepping in rpcit_service_call()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
 <20260928202325.309353-2-mjrosato@linux.ibm.com>
 <b41d9ec2-916d-4952-b63b-05e3edf80e8b@oss.qualcomm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <b41d9ec2-916d-4952-b63b-05e3edf80e8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NiBTYWx0ZWRfXx4Pc7fGktuU8
 H+iA6/QFC3oXdRRgHb/OQIAp9gOSCgj+hKcEdpKK6agN8J+0BsGE+0lBpDHT5250OckH4lFxXha
 jI7fUsIfUkrYh7jrD54GgZ1C6T3d6DSsKqftWQxl9hHKtYMKZPGsNPidxCkz1ITxw7LZlgHcoWs
 eEZzA/tHsbRM0CerB0hdSJ95uCxn/Ow3YbqYu+m207uSCTrGgcJFw3M9RGLP5s7jraa9fV0cxTY
 oRp21CLDNpi8T6jN+zrSxmhZxZ83j+eXt+pmP8YatOyjTVt6/uJzKeLjkXwi7HGOWG4IX2PSxn0
 J3UYIwh24MZeI9vb5zLYsguxpSDhtchKVaoiKdA7z9sw8ipYzPogxds09DUCnYAkATiu0p6JQJG
 Zanz0nAJg7Lnz9jhWVzx1YUHkwT+Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NiBTYWx0ZWRfX721GM1IG2MmA
 41kr/BWH5m2OzLSdOQ2I3HwRm4NQqKO6KWAb/UI2g/CzwdZAONb/jFAqeDHh7JjAWlIFiFmf8uc
 xxh0fpJ6ItNnmzqwmKiK66l7TrBDdkQ=
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbc631 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=q1wUsFvxxSqXCTaXegcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Jb3Roua9HTohNEyKMDCBPeT2_YkCz9y0
X-Proofpoint-GUID: Jb3Roua9HTohNEyKMDCBPeT2_YkCz9y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290056
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


>> +        /* Advance to next frame boundary if start was not frame-
>> aligned */
>> +        start = (start & ~(entry.len - 1)) + entry.len;
> 
> Could that be QEMU_ALIGN_UP()?

Oh, good idea.  I think

start = QEMU_ALIGN_UP(start + 1, entry.len);

would work to ensure we always move up.

I'll test it out.

Thanks,
Matt



