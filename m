Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718F8F8FA94
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDfo-0008Qa-5j; Tue, 21 Apr 2026 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFDf4-0008It-Rc; Tue, 21 Apr 2026 12:09:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFDez-0007NF-1a; Tue, 21 Apr 2026 12:09:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LD6UcJ1536364; Tue, 21 Apr 2026 16:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ESacX6
 yflW6c4pMIefr+Ys/Nu9plGgVta10gtDCFf8w=; b=YEqtPNM4keQhzt6veEMrFe
 SwVlfQfFwSUry3ORs80kVuuLNzb5OkeJEdXeXZ8dLFOhO2bAs6sIxQjU/fC+dr7U
 Cn3he7bEqcSj5r/U6LbDidoUbH8NO3l+w+eQpiBNI04fq7kVGZfpzUEzrogxd6tl
 piuSEMs3Bci/l/gHd7OxdJgL4tNl9fxbyvlEJ6cy2cdBiAA3GQuwYKiaZp4gZwgQ
 DzADfcQW3eGtJc9c7tSYQGK46mNSlAGTbKLTLTxuzegeTWh6melBQxyMG1/C7U0x
 XectJmsJMy7GWPPCnEewEqzZZLPRI5/GnkZsWuxrojDkyNLuib5rNgqSG1Wci8lg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6me3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 16:09:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LG5MS9003242;
 Tue, 21 Apr 2026 16:09:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q1hp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 16:09:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LG92fR8258226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 16:09:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C8D358062;
 Tue, 21 Apr 2026 16:09:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A944B58052;
 Tue, 21 Apr 2026 16:09:01 +0000 (GMT)
Received: from [9.61.174.150] (unknown [9.61.174.150])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 16:09:01 +0000 (GMT)
Message-ID: <01548ef2-864a-4121-afd6-cf7add6fa3d8@linux.ibm.com>
Date: Tue, 21 Apr 2026 12:09:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
 <20260411022618.2136588-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260411022618.2136588-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e7a120 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=x-B4hQBy79GTlnKUhDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1NyBTYWx0ZWRfX/5D+p0Kk/MtZ
 0veki3IppYg3NQ2hN2ac5De1HHDT0wflvhTMfGXBBDE+rRHkXksH+yfcKQFjXAhBzC43waJCxln
 bqHkuFaGcKnnju+X3qBWGmrxvmZCoSbu+UFno0QScjOS0Vm+EQ6Q4XWVseiZklr5oFAw65KGv+0
 mw+IVep1nmCCYPCw5IsKPKbH+ZgTHyuTBDPeP/TrwNHZ0qYV4SAfj9+CStGKHu8srQBk9LQU9Qd
 Yh8EROUWiScq3YXtox2iYTVHZXfHJWahzBSLQ2IhLfuN4G1RTJmNKExr+sBW3Xf1w2IdSW/olQk
 4e+umBBxFlHXVmL6A8AEn8SDuThuq3Q8RLvNkXe52uD5lUe7SMvpbjb6Xo8xlynOZpAhjRzZkcW
 ud3qTm9lbDdsdaIvkoEHeMfOUVl4tnvgwEDEuXzmHzIJ0RTusgM+7KhecIkbI7L8FsmL8jum7p1
 2IYK2JG9sPKuy/IKN4Q==
X-Proofpoint-GUID: 5ecpk8mwcHEqdAUfAJMPUEYOwTcsdCzf
X-Proofpoint-ORIG-GUID: 5ecpk8mwcHEqdAUfAJMPUEYOwTcsdCzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210157
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 4/10/26 10:26 PM, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.

Commit message should reference that this will enable emulated PCI
migration starting with s390-ccw-virtio-11.1

> 
> Passthrough devices will continue to block migration.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

[...]

> +static void s390_clear_emul_dev_migration_blocker(S390pciState *s)
> +{
> +    if (s->migr_blocker) {
> +        migrate_del_blocker(&s->migr_blocker);
> +        error_free(s->migr_blocker);
> +        s->migr_blocker = NULL;

It looks like migrate_del_blocker() already called error_free() and set
the value to NULL so you don't need these 2 lines.



