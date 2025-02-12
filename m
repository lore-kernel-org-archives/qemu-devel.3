Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD00C021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiE1b-0006it-16; Wed, 12 Feb 2025 09:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiE1Z-0006iW-Ok
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:47:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiE1X-0001ik-R1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:47:37 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CDnH1G002848;
 Wed, 12 Feb 2025 14:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qoihHq
 qn//igUAu4NrEKix3qj6oMuW4acV6vyDc1f10=; b=GZyaeXGYgWetWZPg51jwGb
 i/9KT/Me258moaj4GiLsVFgx1n7a7nJTL71oDnCxEuXx5YvjfdNE5xcNwR1DpiK0
 voCjvK4i9bXUBpWVV8fJMFc9zixFAt2g0x2+tINsu05Ar7/c7SkWtxuPzCBApBLX
 72DcRhj7oVeHvXdukdK+USfYPDyU1FTg5P43F329rIUT/hDQ6/aNkfvpioAwr6vL
 dDa3T5F91fiIZqkTB7DZJMj46p3QSXSr6/jzumZPkoeUZY2P5uV3YXYexSqAbkYp
 dpmKJWhElXBFynOsHYUbm2+iwEruCSeEBSqpy+BWc4TgOHgJtaf2eYTx5XfbuiHg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rnf8av71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 14:47:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CCbqkl028204;
 Wed, 12 Feb 2025 14:47:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyhfwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 14:47:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51CElTT843647308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 14:47:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B3DA58060;
 Wed, 12 Feb 2025 14:47:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 357DB58043;
 Wed, 12 Feb 2025 14:47:30 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Feb 2025 14:47:30 +0000 (GMT)
Message-ID: <307e2a67-e714-4fdd-b022-32a29ed6c6e9@linux.ibm.com>
Date: Wed, 12 Feb 2025 08:47:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
 <CAJaqyWfxaCXUqQG9rXGLjxNbs2zLoRBkW3bJA3huAzqOCDvcBQ@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAJaqyWfxaCXUqQG9rXGLjxNbs2zLoRBkW3bJA3huAzqOCDvcBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iab19jELjXu7nXQ5_6ONfJPYA_uJBgwr
X-Proofpoint-GUID: Iab19jELjXu7nXQ5_6ONfJPYA_uJBgwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=682 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2/12/2025 07:38, Eugenio Perez Martin wrote:
> On Tue, Feb 11, 2025 at 5:20 PM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>
>> Add .set_vnet_le() function that always returns success, assuming that
>> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
>> outputs the message:
>> "backend does not support LE vnet headers; falling back on userspace virtio"
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> 
> I guess this patch should be merged after
> https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg02290.html
> ? Actually, it is better to make it a series of patches, isn't it?

It doesn't matter if it's before or after. The only (coincidental) 
connection between these 2 patches is that both are needed for QEMU to 
enable vDPA on a big-endian machine.

