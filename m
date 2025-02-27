Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C4C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 20:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnk8m-0000dD-Of; Thu, 27 Feb 2025 15:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tnk8j-0000bo-Rk; Thu, 27 Feb 2025 15:05:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tnk8i-00036o-8P; Thu, 27 Feb 2025 15:05:49 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGXfKJ017870;
 Thu, 27 Feb 2025 20:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HI97Ol
 J/tGDkZo7UsWix95w235Q+quB8tl4z9jMRMSY=; b=lUiHjacDvtJnhn+ELNuyFN
 5aam3h9Hz3iJ+G13vxR2eyj6bi+P/tKrvNixIXC09kXb1LBpWY2mKnAsk2GRVcCC
 DmwFDNQQKPl5iGZYlbijUhgRhMvMqoZFifgPnZMMIFgSQDyyWSVqSnxMSkjMAKHe
 5DQR4gkFhcHEIoZkonJ2V2uD9b5qQG+9c0h5xgzPPOunxQjALzjti1OGG6+9XCa0
 vnEF4Qb68n/Er2jzctIS5RFOQswqz6PcrDiJyh0FqEPOtNvBChTpkjpv1dryyxFY
 Hvdf4QvJZnWc5yJd4BQaAGVlF3/1oWFL7k7qf19yH+Eav3KTOYHzzcDsBjnQ5wzw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpbuwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 20:05:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHIZF0002570;
 Thu, 27 Feb 2025 20:05:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k2dym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 20:05:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51RK5f9G19989192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 20:05:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 663E45805D;
 Thu, 27 Feb 2025 20:05:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFDCB58059;
 Thu, 27 Feb 2025 20:05:40 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 20:05:40 +0000 (GMT)
Message-ID: <1f86d715-68c9-428e-9e81-02dc6513e980@linux.ibm.com>
Date: Thu, 27 Feb 2025 14:05:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <f2a0b9d6-490a-41ca-91ec-1b3b7dcf9eac@tls.msk.ru>
 <9cb188a8-2e13-49fe-9104-1e08b1c92964@linux.ibm.com>
 <245054bd-685e-4261-8192-ed2e95c91994@tls.msk.ru>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <245054bd-685e-4261-8192-ed2e95c91994@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o6oFcUWEO1NLD1aRsaOqT5wBee-aaZt9
X-Proofpoint-GUID: o6oFcUWEO1NLD1aRsaOqT5wBee-aaZt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=458 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270148
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

On 2/27/2025 00:33, Michael Tokarev wrote:
> 25.02.2025 15:39, Konstantin Shkolnyy wrote:
>> On 2/25/2025 03:30, Michael Tokarev wrote:
> 
>>> This looks like a qemu-stable material.
>>> Please let me know if it is not.
>>
>> It won't help without my other "[PATCH v2] vdpa: Allow vDPA to work on 
>> big-endian machine". With both patches, VDPA works on a big-endian 
>> machine.
> 
> Aha. And it is not in master yet.  Thank you for letting me know!
> 
> How do you think, is it worth the effort to pick these up for
> older stable releases (7.2, 8.2) too?

Yes. It's legitimate bugfixes. I suspect, more and more people will use 
VDPA as time goes by, so someone might try it on s390 with a stable QEMU.

