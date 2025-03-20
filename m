Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA6C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 16:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJ18-0002nA-3M; Thu, 20 Mar 2025 12:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvJ16-0002lu-56
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:45:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvJ13-0007dS-9L
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:45:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCRs9f030264;
 Thu, 20 Mar 2025 16:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CIjsnZ
 T21re3bV6O2zojO9h0Tja7s11ZCEJt4cul/To=; b=hOQvEOaRAWzzAYGJvWrwz+
 Gv1YphbowXoACrrJHHFkck1Rrn4poZ0o0vqUigVrSuWQ0VMFIpZ1HODzsBggWSoW
 95GIbINH36qRnuYk0FZimyH7Ou29WemCElbaKFSsDI+rp+cu+uCZoyBU41kzLGKL
 OuJfGr0Bf8jUBWUXTfBXvOr89vvgWwJFLwdfjHcLdnhzWBibV3bIRcgJyDnPa2or
 ACknLGo4tLGyG2jOeTge4v2xLNFxs0e7sJQkya+9VyCp6ypDjp1x0KgIfrE9SGi4
 HDNdgrJG2Qn2LBaneNCU9sgnR26+QcQ3ravDplugDaXkNugABiR9YONfA68EKA9Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21sfrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 16:45:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGSk7S005752;
 Thu, 20 Mar 2025 16:45:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2rmfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 16:45:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52KGj35K20054750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 16:45:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 332175805F;
 Thu, 20 Mar 2025 16:45:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF1FF5805D;
 Thu, 20 Mar 2025 16:45:02 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Mar 2025 16:45:02 +0000 (GMT)
Message-ID: <fa821773-225f-4e2b-8642-72d269802d96@linux.ibm.com>
Date: Thu, 20 Mar 2025 11:45:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VDPA MAC address problem
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>,
 eperezma <eperezma@redhat.com>
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qs9aQ0Nvo30VEN2FGgeUevbm6Aj0KUUD
X-Proofpoint-GUID: qs9aQ0Nvo30VEN2FGgeUevbm6Aj0KUUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=800
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200104
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

On 3/19/2025 19:58, Jason Wang wrote:
> On Thu, Mar 20, 2025 at 12:34 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>> Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
>> “deprecated”, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must be the right
>> method, but it’s apparently called too late.
> 
> VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
> necessarily there.

The mlx5 driver doesn't do anything for VHOST_VDPA_SET_CONFIG. Intel's 
driver, however, apparently stores the configuration. So, it appears, 
Intel will avoid the problem... Perhaps mlx5 could do the same so that 
QEMU can set the address before it starts the VM (QEMU doesn't have to 
later let the VM change the config). Conceptually, setting the address 
by QEMU cmdline doesn't look different from setting it by "vdpa dev add".


