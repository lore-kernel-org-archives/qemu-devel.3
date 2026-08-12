Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6606EC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu33H-0005fz-UW; Wed, 12 Aug 2026 03:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wu33F-0005dV-TH; Wed, 12 Aug 2026 03:07:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wu33E-0001pl-1K; Wed, 12 Aug 2026 03:07:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62XJS2631722; Wed, 12 Aug 2026 07:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tcav6i
 EvZ4F3TJCbBrJKJM+PlTsK6EmTSrreucCxehc=; b=ordG4y5DQO7UhJhLzqp4g2
 j7gnmPogjPx8X7TlBonm8DH3qyTYuT+LX/evq2C4m12yeWziJlosx2TvJPu6oy6t
 zv+w+JBJoCTDTA6O4zU/x9RszE3Lt0aG29gtUOp/Lbazrdf2u4qRfzbYQR1zjWGg
 WALVSOLhA0y6yISJ3FYUneadL1p/rW+e0t/LSvLwaOfcL/JS3wXHUQsMQFahUNh+
 z+1+9Ig77eYqjcx2Dt4sNjtZr8SPFoFmLwp1eD6N525ZnC4Yhx7g0g+iGWd7/fjl
 QKOeu0se0wCSxdQZOo39Gzz/LY96D6wKBcJqI1NbtBgAiIXuCSpQsKn4O9f/cE6g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9h7jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 07:06:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C6uQOj031194;
 Wed, 12 Aug 2026 07:06:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy4qxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 07:06:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67C76caQ12124806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 07:06:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5880658045;
 Wed, 12 Aug 2026 07:06:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF93958052;
 Wed, 12 Aug 2026 07:06:32 +0000 (GMT)
Received: from [9.39.26.160] (unknown [9.39.26.160])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 07:06:32 +0000 (GMT)
Message-ID: <b0ff3cca-7acc-419e-8507-4b3ae13a715e@linux.ibm.com>
Date: Wed, 12 Aug 2026 12:36:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, balaton@eik.bme.hu
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, th.huth@posteo.eu,
 nnmlinux@linux.ibm.com, sbhat@linux.ibm.com, harshpb@linux.ibm.com,
 qemu-ppc@nongnu.org
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <99254c26-0b41-4efc-b1cd-ad1e19576f32@linux.ibm.com>
 <akuViylBcKiXMbjH@zatzit>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <akuViylBcKiXMbjH@zatzit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ow3ugeWSSQy_PmGD2wcXur_HAJk9Bez6
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c1b80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=EGYj-OwPAAAA:8 a=9zzaJ8bySdf-iAMkGnEA:9 a=QEXdDO2ut3YA:10
 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX/Ba0Tx4HmVfi
 3jyCzRciRi6IH+Vd6alct4RsBtw8cANffaP4bxXqegUh5oGLM6CGIZ/LHvZFdl+63Pve7VpkykX
 3napcNxoBCQ+AlB1LivSqI0gMn+KXV8SSqiiklkShvq/06ToaYie45qiWtKvk5LYCKEBsC+2EYz
 xjb5i5GCXRTkgrge3rFOOuKsQGw42pcPc8FqVdKN8apZ3FEMUobez/xsmJLNCKr5r95BKswJ8P4
 WPnPRHZJgI4kf5GyIvdcbNj5sNN8Nx8Fs9qJEVNcoHTvRsGbJ+JiVjN4ipUpvyp9an8IuMnb9hj
 mrDNyDJlw4HHMqUUw1cDHTcTlCXibpjOKnozlhIolw2mWxyNPvO+NaI01jCzH6bezIQMVWQNQOA
 hK3Y1W7NMSoMvELVTHRdQwakz0bGkS3ycf9lw0iV/1bBJxM2mqaxXZm4idUd+6dqOY3JwoqOEZM
 sRUqySq0baKBcqAISGg==
X-Proofpoint-ORIG-GUID: Ow3ugeWSSQy_PmGD2wcXur_HAJk9Bez6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXzh2IaXrfWvkG
 8vWWOG25STdKOz8m2W5iE/Ge5asTZ35jy3nXluUxz5bM8QpPB7zgG+wTouQJuvTIRIXAloqm3i1
 vQ+2OsqnW6u/3S4gfSglzuyUM11lDlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

+ Balaton, qemu-ppc

Hi David,

On 7/6/26 5:16 PM, David Gibson wrote:
> On Mon, Jul 06, 2026 at 02:37:48PM +0530, Utkarsh Verma wrote:
>> +Thomas, Narayana, Shiva, Harsh - FYI
>>
>> Hi Alexey, David and Paolo,
>> Reviving this thread as would like to add the disk boot support by loading
>> GRUB.
> 
> Good luck, but I'm afraid I no longer have any interest in, or time to
> commit to looking at ppc qemu stuff.
> 

Thanks for responding to the query.

Let me share what we have been working on to add the qcow2 disk boot 
support with VOF to get inputs from others who might have an opinion.

With below changes, we have been able to boot a qcow2 image using the 
-hda option. The implementation covers:

- Partition table scanning (MBR and GPT) to locate the PReP boot partition.
- A new load_elf_ram_sym_buf() API in hw/core/loader.c that loads an ELF 
image from a caller-supplied memory buffer, reusing the existing 
load_elf32/load_elf64 paths internally via memfd and also added an 
optional per-segment callback so callers can act on each PT_LOAD 
segment, used here to update /memory@0/available via vof_claim()
- read, seek, and vscsi-report-luns OF services for block I/O needed by 
GRUB.
- VTY read/write routing for GRUB console I/O.

With all of the above, we are able to boot a disk over the sPAPR vSCSI 
bus. I plan to post a RFC patch series soon. Quite a few things are 
referenced from the Alexey's older patch series for implementing the VOF 
(https://lore.kernel.org/qemu-devel/20200203032943.121178-1-aik@ozlabs.ru/#t).

Alexey, Balaton and others,
Let us know if this approach looks good.

Regards,
Utkarsh


