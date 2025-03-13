Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96746C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskFu-0004WU-7C; Thu, 13 Mar 2025 11:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tskFs-0004WL-TA
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:13:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tskFq-00085d-NN
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:13:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAA6fW026962;
 Thu, 13 Mar 2025 15:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jrY+PO
 JXRZgZv6EiSCd6AyhyCOMxWluhVlPHob6t3pg=; b=iDOZmH0x2yKHqlYUoJ+g2P
 IGHiKG5U8ifg0VMro9sdZHEYV0IFFDUCIKJ/I3DCpuvg4xk8rQ2zOG1fu5qUV7Xh
 30TJYk+SzjOnMRou/p+cGct/ewYZw3sbSN19oCTDFyqR8JlwCmp7Uxc/2R9cHz4M
 uvNTSR+UHzZJID9jcAuOUdSJjmhQFnNgHW88hAiLPTAAsto4HMVkZNhHhqDZU11R
 64Jsn4K+isOTKqR+UIABP5jQuq91RQfj3vrM9BKfNJRawAbxYisc8hsKm0Uu8IXU
 Goha8Pd2nejgko+oiery687qQLXQSJiRWplz8Vos+PYByGrCqfL+vJfTZsYYvqlw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepmja1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 15:13:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52DCW4Tp007627;
 Thu, 13 Mar 2025 15:13:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrac82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 15:13:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52DFDk2W25821826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 15:13:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B16EC58055;
 Thu, 13 Mar 2025 15:13:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 806075805F;
 Thu, 13 Mar 2025 15:13:46 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 15:13:46 +0000 (GMT)
Message-ID: <0ea107ce-82f1-4333-b766-fda8e0cef454@linux.ibm.com>
Date: Thu, 13 Mar 2025 10:13:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Allow vDPA to work on big-endian machine
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
 mjrosato@linux.ibm.com, qemu-devel@nongnu.org
References: <20250221190733.490308-1-kshk@linux.ibm.com>
 <CACGkMEtm5gapBTmM_cA=jxAEg4GMkyMf4Wa47kvkFvN05uJ__w@mail.gmail.com>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CACGkMEtm5gapBTmM_cA=jxAEg4GMkyMf4Wa47kvkFvN05uJ__w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rH811j8lhZkv3Rz9_0Yy2F_mD-DenkY5
X-Proofpoint-ORIG-GUID: rH811j8lhZkv3Rz9_0Yy2F_mD-DenkY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=719
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 2/23/2025 19:57, Jason Wang wrote:
> On Sat, Feb 22, 2025 at 3:08 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>
>> Add .set_vnet_le() function that always returns success, assuming that
>> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
>> outputs the message:
>> "backend does not support LE vnet headers; falling back on userspace virtio"
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>> Changes in V2: Add code comment.
>>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Is this patch all set to be eventually integrated, or more review is needed?

