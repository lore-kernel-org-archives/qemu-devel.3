Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAF1CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkNh-0000wX-Oq; Thu, 08 Oct 2026 05:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xEkNf-0000vu-Re; Thu, 08 Oct 2026 05:25:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xEkNe-0003BO-85; Thu, 08 Oct 2026 05:25:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987a0tc589874; Thu, 8 Oct 2026 09:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ES1O42
 3bWm7fcxqKEgjNK7bSHKgZ6oNiBlgo5a+KCF0=; b=f39YzsbnHyA556LY1Xp2uf
 9C3P/jTth36OCuvTh/OaFrYj43Rq+njx2g6zGLQJS2LzC7/5/pYDhvtN6Gsq3RHX
 uXOZXP/GgSoU/xqTVxzEzfa/lVhiTYG8Fdj7jR28voZ1gRfQiOvxSnaxfmrc7zE1
 4c93L2BBdFtsd5FJ44OvjrPn0U+yIRNplpn02j3LloR5oMzEdIdNDmm8DAya3PAC
 o6LZPeKajXcL0w/YyG8ZKyWOTVvfAxbVsoarBIxFBU5L6nmwfFVhRbc9JG1cls/Q
 JPIO0xuklXeeVFcnV0CTfNu+U+OlH2K5KVM+7N/6shOyFQ6ZMb6y4YbG33/Q26Eg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw2eng-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 09:25:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987IZEH1873317; Thu, 8 Oct 2026 09:25:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3twgs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 09:25:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6989PNkl7799500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 09:25:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDA2658066;
 Thu,  8 Oct 2026 09:25:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06A415805F;
 Thu,  8 Oct 2026 09:25:17 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 09:25:16 +0000 (GMT)
Message-ID: <e189ed9f-e2af-4e3e-8baa-7b1f1c9311ac@linux.ibm.com>
Date: Thu, 8 Oct 2026 14:55:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/8] ppc/spapr: implement vscsi-report-luns
 call-method for PAPR vSCSI
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com, pbonzini@redhat.com,
 th.huth@posteo.eu, sbhat@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, rathc@linux.ibm.com, philmd@linaro.org,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 alex.bennee@linaro.org, richard.henderson@linaro.org
References: <20261002052605.605858-1-uverma@linux.ibm.com>
 <20261002052605.605858-9-uverma@linux.ibm.com>
 <242e1462-9256-b115-e68c-f20aeb25dda4@eik.bme.hu>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <242e1462-9256-b115-e68c-f20aeb25dda4@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfXwYNYtNqOYGIL
 FrxRNpAYRuN+iPQzoJE1rW5WcSwNiUucxXGsnVz6s3deHrP9EVdJm3KLyuGNLjEKaTv4/Cqryq1
 K3NnRUalHFpJ2iBVyRn9lg4eiyBcxew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfXx1e7H4+McQRw
 55SBFWQEAKfYDXvgRY2vdgEf2en2F+afnFOIAxdYhNm/OCbfzut1Wk9/FVd2FgDZxdmWry3PD1a
 ii/om737+/7oV7SFBXju8Uwsj9ZFOOiZ+E3waqiH1KU+S5h6yDaY7hw0aG7yqqVJ00soWSBfgNd
 AWQO56f8BIe72jmP2py7Izw0jv5BiyzdMW2XZNAx/3l3/VZG7OAfD42mw9033NPJfEuprXA+t+p
 NkiAWUtYMweW/ljagDXVb+IpXXal53orGM5h9B6UmlbeFiMvEQEHeKWkE+ATspR8Jynt5k/pT3J
 u0QgsWWs2JYT1ofP+elZ9KJZ6dzaoRVbUWjpNLK5/nHGZ5kJs567A+WHhECtPlQHjEMnMTVe0eI
 ev3/q2pHNvwZ2MSj4xfA/awizS3XZ1adBNl6eHy6oINPKT+B0TGpcY2etSYs5ANG+iQpil+Vg7n
 oqq8B7NfTB/Zia7mp/w==
X-Proofpoint-GUID: tjob6OficFRjOQ1YvuRWgwScodPRbrOR
X-Proofpoint-ORIG-GUID: fAoWLfM_xN6KXjOabPPFxVEdYU_kmJ5U
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac76185 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=zJ53bHn-92egte3Qg2oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 10/8/26 12:01 AM, BALATON Zoltan wrote:
> On Fri, 2 Oct 2026, uverma@linux.ibm.com wrote:
>> From: Utkarsh Verma <uverma@linux.ibm.com>
>>
>> GRUB (grub-core/disk/ieee1275/ofdisk.c) calls "vscsi-report-luns" on
>> any PAPR virtual SCSI controller ihandle to enumerate attached LUNs
>> before attempting to boot from disk. Without this method VOF returns
>> PROM_ERROR and GRUB cannot find vSCSI disks.
>>
>> Add vof_vscsi_report_luns() to build the LUN response table in guest
>> memory and wire it into vof_call_method().
> 
> These should go to spapr_vof.c too as they are spapr specific.
> 
> Regards,
> BALATON Zoltan
> 
Sure, will move all this implementation to spapr_vof.c and just add a 
vscsi_report_luns kind of callback function in VofMachineIfClass and 
just call that hook from here.

Regards,
Utkarsh


