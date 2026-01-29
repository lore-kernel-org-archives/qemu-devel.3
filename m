Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872F9D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZt6-0007sp-MH; Thu, 29 Jan 2026 16:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vlZt4-0007rG-E7; Thu, 29 Jan 2026 16:49:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vlZt2-0003N9-VG; Thu, 29 Jan 2026 16:49:14 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TFRkFq022773;
 Thu, 29 Jan 2026 21:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ijKpxR
 hT0xCRpKPFjyu/8PtzpXes3/A5N3bK2VtyGgA=; b=IswNlrg5olcCNZKmetT4xl
 6M7U0mm9/u8oEymqFGY7rkal7poe5HMcwo7Opx87+DnK5VwcvukcZF/TFttm5zyK
 SR+f8qtXHTDk0qvzEYSq+pjemPv5Zc20rjHg0CrEQMj0RPhWkafwdPd6OK4Se6H0
 9tfHn0lF3jBA1uFCjNQIu6/VZgoUTOeAiMzJ3/uKC/vHCeMsa0NwSHzkrvM3UuxZ
 9w9lLBlwKFawPouYjtN6OB1P8KSVmKG/SRaDNh2syeikeCZtdFRAziSiT3Q4a+oc
 GKF+CC+HW5Ejl9bs/Cu+3S3IUfOwEiIJ0ArqI6PL9+sOUQJkkIeyE/K9MvHxPekw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgn0g5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:49:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TK4TuY019666;
 Thu, 29 Jan 2026 21:49:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dnbtba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:49:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TLn9bO24904446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:49:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24D985805C;
 Thu, 29 Jan 2026 21:49:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BB205805A;
 Thu, 29 Jan 2026 21:49:08 +0000 (GMT)
Received: from [9.61.177.101] (unknown [9.61.177.101])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 21:49:08 +0000 (GMT)
Message-ID: <c4e341e1-3856-4e7e-a71f-f11bfa6f56a0@linux.ibm.com>
Date: Thu, 29 Jan 2026 16:49:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] include/hw/s390x: Move CLP definitions for
 easier BIOS access
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-7-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260127161547.459443-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697bd5d7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=hySySAaMZ-YiW0hiCi0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lbggaPdm6wDKTO5H0EaDEtkKLmF1IwGt
X-Proofpoint-ORIG-GUID: lbggaPdm6wDKTO5H0EaDEtkKLmF1IwGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1OSBTYWx0ZWRfX3vB4SmhDJI0+
 eYhD1fU0wJWiv0YVNKTGegTvZKvVj3APotzTqFo0If9atO6uxOb5XP5RDBWIQacKJXqv16lTvfn
 li1y3f1584fRqWSrq8o1jOvwBgPAwhQzhr+acLLxgfhu6F20AJGGpTc9vpFQW/a02V6hgNVIwmM
 N+h3kJdexwen85yL/ttjubb/BTEEJEiqH8QhGPTPTyniQJYFj1fzwq9+HXGM9pZ1o5yd/QVhI1u
 O89wFQ4N/butWPd752JUwBmJaSLQsAxk/sPhotA5QeF096IU45kMDRB/i4uZs4v/OvS+8JaouYD
 SHjwyQgs2THWXqWC4XWckiCX8pDFKKEi4CgEEjtA15Oe9yk1b3mAijLqmCpJtAKf2dutctNl1My
 r8Qr6OoNSC1qecxROsZ77KYv6Qp1Trl2gvNnPELYO1Cta19FSKL5aH/3qJnZhLOdwNhF6jWMZqO
 FX1Xpt4ksXCrX8EjnnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290159
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 1/27/26 11:15 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
> to the s390-bios.  This allows the bios to reuse the architected definitions and
> prevents code duplication.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

