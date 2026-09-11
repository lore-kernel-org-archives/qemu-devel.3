Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A5EC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x523u-0005kE-S9; Fri, 11 Sep 2026 10:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1x523t-0005j5-Eh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:17:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1x523r-0003j6-4R
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:17:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BD1hF51868195; Fri, 11 Sep 2026 14:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=E18zqo+W5rsf0yaVJZ3EbRg8nu2X6UaeThcKnf7eaSs=; b=l1rQzevOk18s
 93BuUf91XxLlSmv6CnS3FNuriEsTgp8cS2El2Ti4H8paOjA7gGbIyDsCyU0/QC7+
 /tPusGY9JbWXe2EPVzOQrPTB8qEj1hA3tmgshu9T4Z5ELstbL9Jw99143RLCdmMS
 WeVi8WkjSMpaa4En0NyeiGCLzDU7IXr8hhd7gzOLO7B55+QPYfZE985XKCJXzKOb
 ekGla0Gxd+CpH0e9GmPMXsetpCjW3rR/PEV96KjxuVtJ4ttYt/F8iJn5DgWeV7ZR
 npBXSdJHmGaAUxbGt4Q60cyMlJ+IkkAABYjPJ0tc9YMPl+UdyQVkI9s7gm6x1f8R
 tGPi++AhoA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8quyua-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 14:17:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCo3HL1676470; Fri, 11 Sep 2026 14:16:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvmhpsnj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 14:16:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BEGxUA20841186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 14:16:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F27AC58067;
 Fri, 11 Sep 2026 14:16:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77D0D58052;
 Fri, 11 Sep 2026 14:16:58 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 14:16:58 +0000 (GMT)
Message-ID: <f0f1a0f8535e063e346e0cad5a695ad9215fa8ce.camel@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/7] qmp: add pmemload command
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org, David Alan
 Gilbert <dgilbert@redhat.com>, Peter Crosthwaite
 <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Caleb
 Schlossin <calebs@linux.ibm.com>
Date: Fri, 11 Sep 2026 09:16:58 -0500
In-Reply-To: <87se3g9op0.fsf@pond.sub.org>
References: <cover.1542290622.git.simon@ruderich.org>
 <7f4620558ac861573fc83d6569189432de77493b.camel@linux.ibm.com>
 <87se3g9op0.fsf@pond.sub.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa40d5c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=DXkDPrdx4qVqMnRpvwgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hpkH3YdkKh-JkPHJHYVQgrZHufGhGj4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE5NiBTYWx0ZWRfXyzEFxoP4WxyC
 CLm7G5hwdNCwBy5jjpw/Uk8B+vAsO/Wrkr4Mfc/q2SiPL2cwuguw0ra//oNJ/ZaLkh2SOu+Dwy2
 trwGN3HW29GEZOSxdOLugYGO0OcJlH7V3sYIsnGPQlZAHUkoVmHNZUHGYSKzsZsbMjHJJOP91wj
 SpJdG5WcT55R2PAGFiYdXhCokp8tcwcpLzeT4ukTk3jufxm6SGWC04BtjkmFg1KCcL+rjMGEFCp
 hNWwWx7jwOBERPvmrdPrf8qFUwxB5Y7ZIXCZhYiXT3Pt5Q/Joq2Ifo2NdIqR70E8nKdG87F68Hh
 0N8ZhBj0O1Aa/BPHL1h2u9usOIz1CeKVyCRDsRJes0FA+lSWIC5GmZuIK0iear69zCmh8a7tReB
 E6CEBHHIzk6VmX+tTz7e/V55a7UNAWqUG7Z+AUjykizpaFG8nztCAOJUHLh6TsOLFdusmVxsdch
 BTZLK632/ysv29YyE6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE5NiBTYWx0ZWRfX+K2nIFG4CnRE
 VbMb8uMU5IgQ8DVa8DRV/vfiW/eOEoeqphKTlwZdMw+m3Vwxwy3v3ucMwaq2n2Vk9ajVi7tOLOS
 OaAORLxxHvmQY/7m2tRK0ocJi7A/IoY=
X-Proofpoint-GUID: 3LDGZV0-9IoRI-M15wcws4FugWb9xuvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110196
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2026-09-11 at 10:28 +0200, Markus Armbruster wrote:
> Miles Glenn <milesg@linux.ibm.com> writes:
> 
> > Hello,
> > 
> > It seems that this patch set stalled several years ago for no apparent
> > reason.  Does anybody know why?
> 
> Review pointed out issues, but the submitter never responded.  Possibly
> because review exhausted submitter's patience.
> > I find myself needing the functionality of a command like `pmemload`. 
> > Our user needs to be able to load a binary file into a physical address
> > of their VM and it would need to be done every time they start the VM
> > (not just for debug or experimentation). It also needs to be done at
> > some point after the VM has already started.  I understand that the gdb
> > stub could possibly be used, but we don't want to prevent the user from
> > being able to use GDB themselves.  The pmemload command uses QMP, so it
> > seems that it would be the perfect solution for us.
> 
> You could post a v9 addressing the review, or you could start over.
> 

Since it sounds like there was no technical reason for dropping it, I
think I will do that.

Thanks,

Glenn


