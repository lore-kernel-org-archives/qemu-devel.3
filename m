Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28442EE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZym-0003s9-OX; Thu, 12 Feb 2026 11:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vqZyX-0003o0-8d; Thu, 12 Feb 2026 11:55:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vqZyT-0006Ok-IJ; Thu, 12 Feb 2026 11:55:32 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CD80xc3201530; Thu, 12 Feb 2026 16:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vP8Vln
 IacHMJ8jLXLEgyFsFe4f2VM8yqs7q4FyjBCnY=; b=A/Jow8z5cXwHb6s6Ar9FqI
 USPuURX1JMBVTWEFeQPVzBJYbw/5j/I7pVTh0cELNWhgQZ+5VLNTIx3Gw7uuHxi0
 i/1qARDc3ni1UPtZQ3spsw7UYjijyqUWyQsB6W0YXN+z0VbPTtuQzNi12IOy8tzv
 G9Gw04lTcb3gWhRt1ZuES1DE05bMzFbHi67TUzvpBO1i+AkKj8fmz0JCuOLEiitF
 9CDIhTpao6x9ujxHVp/g2WemuYBFdQQWiCPgWzXqI22mxZTItedHObomX2PZ4hSr
 fEztDjE8FAbRV1VwyMxj/STzzHb3ahimXfzIVXqachqRKmgbeGmPz9JsMJx3R4qw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wf6tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 16:55:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CGV2vl008378;
 Thu, 12 Feb 2026 16:55:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ykdsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 16:55:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CGtGxG33096268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 16:55:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AE8258060;
 Thu, 12 Feb 2026 16:55:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D813358051;
 Thu, 12 Feb 2026 16:55:15 +0000 (GMT)
Received: from [9.61.181.57] (unknown [9.61.181.57])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 16:55:15 +0000 (GMT)
Message-ID: <5fa0684d-5127-4db5-937c-d9be9fc4508d@linux.ibm.com>
Date: Thu, 12 Feb 2026 11:55:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/pci: prevent null pointer dereference during
 zpci hot unplug
To: Halil Pasic <pasic@linux.ibm.com>, Aby Sam Ross <abysamross@ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, farman@linux.ibm.com,
 alifm@linux.ibm.com
References: <192dc45c-5bc2-4bfa-8e6f-8a140e23d88a@linux.ibm.com>
 <8e983aa64ebeaad9897496199ca80cfb7e0bf003.1770877629.git.abysamross@ibm.com>
 <20260212165029.206ae722.pasic@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260212165029.206ae722.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698e05fd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=PdpmnP0pnpmF-q0Z6kgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2_OgYhG6JQLdrdaCPQ6EJamrRS4XheIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyOSBTYWx0ZWRfXwl7ZxZwJhVzi
 qpZUVUVYw9SuHldqgS2OdnGaeIEyf8MPYYgcP0hdoJgeX81dnK8DxWz8S0FCnuILdDewnYhqJwY
 XYDGF8/IQXSX7mmqI3fbDbFAQILh/sYDQwP3bS6Zz49jYfOAZxdGcypYjbrpGatS71nEZAhGRcR
 OzwoRp9JYR8aF01rnsNHXGRndWfcDrxgvUFXDuE7el+4Fe0pIbdmvGE55AAGYB7hBWJHaveupl5
 +y9eun5Vg5sJ4Mgr8NYPndaN6NOpLFHqGoYRJBnFDOytN699h/VtDecPbbtCJXA5gmRg1Xy/GRK
 VOqSkLyb/r4fA61Sx6ZFpOvR5xtZlE27kiUR+S/cHgu3GF277S7Wg7uZ2sGQt1hrGBbByAsOZtm
 r778c0YVze0p1f25YbVnTIdRCRFIzqcssIr/x/EHIIu+NGI7v16ckT0YHMBQCWYTMJIzjcj0Wlr
 /eO6eqGxT66KkrIZwSQ==
X-Proofpoint-ORIG-GUID: 2_OgYhG6JQLdrdaCPQ6EJamrRS4XheIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120129
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/12/26 10:50 AM, Halil Pasic wrote:
> On Thu, 12 Feb 2026 06:47:36 -0500
> Aby Sam Ross <abysamross@ibm.com> wrote:
> 
>> vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize()`)
>> if the vfio group file in `/dev/vfio/` lacks appropriate permissions and the
>> hostdev[/properties] addition doesn't reach the point where it could be
>> associated with previously added zpci device (in `s390_pcihost_plug()`).
>> As a result, zpci iommu pointer remains null. The zpci hot unplug following the
>> failed hostdev addition assumes zpci iommu pointer was assigned and tries to
>> make use of it to end the dma count resulting in a null pointer dereference.
>> In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not called
>> after hostdev addition failure and this issue is not encountered.
> 
> 
> Maybe add a word or two why the other dereferences of pbdev->iommu
> not guarded by a null check are safe.
> 
> I think we have:
> * s390_pci_sclp_deconfigure
> * s390_pci_msix_init
> * s390_pcihost_reset
> * s390_pci_device_reset
> * mpcifc_service_call
> * stpcifc_service_call
> * s390_pci_read_base
> 
> and more. My guess is that the device never gets into a state where
> these operations are permissible, and the code makes sure
> those functions won't be called on a device that has
> pbdev->iommu == NULL. But that is just my guess.
> 
> DISCLAIMER: I didn't look at this properly, just asking based
> on a quick look. Some of these may contain explicit or implicit
> checking...

I mentioned in response to v1 as part of my review that I did look through all references of pbdev->iommu, as I was also concerned about whether we needed additional NULL checks.  But so far I'm not seeing it - it is largely implicit, but we don't drive the routines until the device is plugged, not in reserved|standby and iommu is associated.

This particular case is because we reach unplug (which also has to happen after plug of course) but the swizzle is we are reaching unplug exactly because we are giving up without actually having -successfully- plugged both the zpci and pci device.

But anyway, yes, I do think it would be good to add a small blurb to the commit message.  



