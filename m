Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811F2C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGRg-0003VE-OD; Thu, 20 Mar 2025 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvGRO-0003PF-1e
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:00:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvGRI-0000l8-LC
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:00:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCpVOk029935;
 Thu, 20 Mar 2025 14:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xa4bc+
 B2X9z1c31Doz+el8E0PlRM4PLGhHeNTMAW2xs=; b=OqvMh0ee9FKa0Na2pfWRlG
 /z86aFFbifnbhFxYskaGFaN+DRHU4OBpZDsh2O9pbOXGEsJK4lgsYqVjyUDFW52m
 5J3Ak5ApvCE+OoQWatrlGE/wI77U6oRcdUcP7p99APtaiULGoUoUeJHlySCf6I6G
 2v0uSHwOpFz4u6NaR7bWgcmgsarevQwH5oxqFjIxuhOHl7xltWDDcdB/7r8HPcYb
 HHdPypuLLAA8NcE96pOEhuBYjxtAxSreCddO1/+iQ2jxo8BVA+Y5s6ja2ROsqB12
 yXH7t6IJY1Uf5R7Gggb5NCkBxcsd78WMsOqDZFSvLOWoAB5v/kBEI4G84LjsUptQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gbd9jvu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 14:00:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KBBFYp012347;
 Thu, 20 Mar 2025 14:00:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp8a4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 14:00:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52KDxxgB30802602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 13:59:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93E3F58043;
 Thu, 20 Mar 2025 13:59:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74F6D58055;
 Thu, 20 Mar 2025 13:59:59 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Mar 2025 13:59:59 +0000 (GMT)
Message-ID: <8939a177-376a-45e1-8585-bcbaa07f084c@linux.ibm.com>
Date: Thu, 20 Mar 2025 08:59:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VDPA MAC address problem
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
 <CAJaqyWd2DspK5ALoPLxAZ-rK-7=ok7ZNkYo=xOubDLuXiq-Vbg@mail.gmail.com>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAJaqyWd2DspK5ALoPLxAZ-rK-7=ok7ZNkYo=xOubDLuXiq-Vbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QDwwPXYOeltqcGqttOM8IC6VZNYDKoab
X-Proofpoint-GUID: QDwwPXYOeltqcGqttOM8IC6VZNYDKoab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503200087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/20/2025 01:54, Eugenio Perez Martin wrote:
> On Thu, Mar 20, 2025 at 1:59 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> Adding Cindy and Eugenio
>>
>> On Thu, Mar 20, 2025 at 12:34 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>>
>>> I’m observing a problem while testing VDPA with Nvidia ConnectX-6 (mlx5)
>>> on s390.
>>>
>>> Upon start, virtio_net_device_realize() tries to set a new MAC address
>>> by VHOST_VDPA_SET_CONFIG which doesn’t do anything.
>>>
>>> Later, the VM gets started and learns about the old address from
>>> virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG
>>> returns, unless it's "6 zero bytes", in which case it instead returns
>>> the desired new address (and the problem is avoided).
>>>
>>> Then QEMU again tries to set the new address from vhost_net_start(), now
>>> by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC,
>>> VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is
>>> successfully programmed into the NIC, but the VM doesn't know about it.
>>
>> Have you enabled shadow virtqueue? If yes, does it work if you don't do that?
>>
> 
> Either you're using SVQ or not, is cmdline nic mac address the same as
> the provided with the vdpa command?

The problem happens when the cmdline address (new) is different from the 
current one in the VDPA device (old), whether the old one has been set 
by "vdpa dev add" or by an earlier VM run.

In other words, it's generally not possible to run a VM with an 
arbitrary address - it'll have to inherit whatever the VDPA device 
already has. (Except for the very first run and _only_ if "vdpa dev add" 
didn't specify the address (leaving it "6 zero bytes"), or specified the 
same one as the cmdline.)

Therefore, it's not possible to omit the address in the libvirt XML and 
let libvirt generate it.


