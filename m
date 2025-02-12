Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A9AC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEnw-0002K2-8y; Wed, 12 Feb 2025 10:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiEnu-0002EL-Fn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:37:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tiEnn-0005qc-Df
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:37:29 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CALTQM012271;
 Wed, 12 Feb 2025 15:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rC3pIL
 tizeeDQ+B2tZP+lK0iemOAhC8ALLGfa3K+C+E=; b=jnM+j5XLypQ6+Vqucnfoh4
 vl4qoIntLlQdb6kbliMIQskIessBypI7u6jOuIlUTThWC0G+07JMqGtY6Ca+0NNM
 Fe4FodtucFmGWQhNpl5eajQCaOCVdpGowbTNEbhIP2kxr5/CYXPhwHf9t7gRnGqq
 Wo7rBe5MCRQylfQa9XPvqg5MgnKbKXssBSQICYrT8kru+H9rE9iE+hVIsMugqCBy
 lSU3OHXXWDS8L+ZTgEI5ZyrBeuVh1d+3BO6TseBjdR2yxMeaYX0gnjtrkOT1s2zr
 wyapDb6gTmgVZyM9jbs2WVjBJDubWJZVn9fFCFL/vWuywf5rFNQGvkTZxglCA6YQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa4etc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 15:37:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFKuJM021894;
 Wed, 12 Feb 2025 15:37:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksspwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2025 15:37:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51CFbN6823658786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 15:37:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D49E5805C;
 Wed, 12 Feb 2025 15:37:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 490AF58058;
 Wed, 12 Feb 2025 15:37:23 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Feb 2025 15:37:23 +0000 (GMT)
Message-ID: <8a5e0e25-4fda-45d9-9315-9649e8560f38@linux.ibm.com>
Date: Wed, 12 Feb 2025 09:37:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Fix endian bugs in shadow virtqueue
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250211162010.1478402-1-kshk@linux.ibm.com>
 <CAJaqyWd60RFTugxxu8NNYxHKTX3vEGZ-Za2Z=BLwVPYde8EgwA@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAJaqyWd60RFTugxxu8NNYxHKTX3vEGZ-Za2Z=BLwVPYde8EgwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ny6HP4ZMR1cmXR6CfvKvxaE9E58iu9Ca
X-Proofpoint-ORIG-GUID: ny6HP4ZMR1cmXR6CfvKvxaE9E58iu9Ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=614 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120117
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

On 2/12/2025 09:06, Eugenio Perez Martin wrote:
>> -        i = cpu_to_le16(svq->desc_next[i]);
>> +        i = le16_to_cpu(svq->desc_next[i]);
> 
> Both svq->desc_next and "i" are in QEMU. We can skip the conversion
> and assign directly.

Are you saying that desc_next[] should be in "CPU" and not LE format?

The original code contained statements (below) that led me to think that 
desc_next[] was designed to be LE...

vhost_svq_last_desc_of_chain()
         i = le16_to_cpu(svq->desc_next[i]);

vhost_svq_start()
         svq->desc_next[i] = cpu_to_le16(i + 1);


