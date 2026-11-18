Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J+R7OzBJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTauM-0001F8-Fm; Wed, 18 Nov 2026 03:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTauK-0001Ej-OU; Wed, 18 Nov 2026 03:20:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTauJ-0007O0-14; Wed, 18 Nov 2026 03:20:44 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2SFo94044999; Wed, 18 Nov 2026 08:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f1lOn4
 Tzl1/vDxAHI09g7JVRYaE/NPDA1HXTcvam3iM=; b=J+R7OzBJKBAp4LHMgIeY3G
 cBfftsX3O14czcZdiNVSBuy+qVGB0mvazzSVZxOdgSj15TckgRFNmodPWGQ3Ks6d
 MeuVNDlSrhOtAchrs4l8+tO1wBeDHPKr5levtlUrOnkVAAKXl3kkdajHK8r3uS3O
 WtBNOs5u9Wa5F1/BqZeAQThch+PpbSeSpiHdaNal1/eO+s6dk9xjYId3i52xIAY7
 KA/VfOxK78G/sz1ckMEQ121yoZOaBjl/Phkoccb3oZFzRoJ6SaDVyt9fw3q/H7pw
 bhPsXbcfsbiAWmwrajbMDiAc5TptStsDXXGnIIa6KOyvfhjQzrwWMiDp9kdKhznw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wsfpd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 08:20:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI789571660697; Wed, 18 Nov 2026 08:20:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r65u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 08:20:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AI8KXW834472336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 08:20:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE3F458067;
 Wed, 18 Nov 2026 08:20:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8E9458056;
 Wed, 18 Nov 2026 08:20:30 +0000 (GMT)
Received: from [9.111.1.121] (unknown [9.111.1.121])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Nov 2026 08:20:30 +0000 (GMT)
Message-ID: <08e2c460-a9b2-4b7e-950b-cad9c77e416f@linux.ibm.com>
Date: Wed, 18 Nov 2026 13:50:29 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, fam@euphon.net, pbonzini@redhat.com,
 amachhiw@linux.ibm.com, qemu-stable@nongnu.org
References: <20260819095855.115823-1-rathc@linux.ibm.com>
 <CAFEAcA_BGS73EcunV7=kedi4t6p93bcmNSABRFLsJA5fORqTYw@mail.gmail.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <CAFEAcA_BGS73EcunV7=kedi4t6p93bcmNSABRFLsJA5fORqTYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: p74SEzc61J5pOvB3QHq-0PoSWmdCt6Lh
X-Proofpoint-GUID: TxKRwRssaXBPumx56sFnSpfjqrNwh6ou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzMSBTYWx0ZWRfX5esW3BnT+zfU
 bX7VPu+Za2sl6cwxH5wh8rCp2filAY9bMhYlcsmaB0DJJIC6LK+0jgCJFUUxzqJG/+RRgSqf3S+
 JiQwBYhjbA+QtflvD/rtAUweA+007WfQ64PHnT8P3F+QW8HoT7i/kx0BYPsBAiOK8G4N2/SbuSC
 NasGqamjDTkMZ2ZQeN4ruY27qdbqw8WF9GIEDVLQMA4VjBzU+VWxmjtOJ6ros6NJmps19ntxwoJ
 pfJEV5TV0VfJqzEiqDQx54k8bUyziH0bvWzq2YEKBDkw4B8/L0QrSJ9bqdws9HcP9/jtIoRh2Xa
 5fawMGnRpv+jf2r4Q3C8Y9VfkdHODqeeo5vmOuIykMsH7gdIAeqQ5mRvf+MlW/z4TN8wDDK3K6Y
 75yQ9sokb2zMXOMKP9u4YpkKhvNqZKkUe6iLOIJ2RuuEAMjTIMCD/e/XUuCJP1qZ/XVW3JDuIwa
 eILUo/nvV0Lr3fh8uXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzMSBTYWx0ZWRfX+Y0OQx5+iSIi
 qsUXTNPk9lVREt3X8UEy3GO3aG8vGjewwTdaCJbWOxZ7Iuia3pOjNiIK5E2pgBd+6J54aq9nqkL
 vWyeaM/cRbKtaO3WW0DaWu9LyNQ9dhc=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd5fd4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=uOy0yLtoxDpWe9ThBvcA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180031
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+CC : qemu-stable

Hi Peter,

On 11/5/26 20:59, Peter Maydell wrote:
> On Wed, 19 Aug 2026 at 11:00, Chinmay Rath <rathc@linux.ibm.com> wrote:
>> cdb_offset and local_desc values are dependent on the guest. If the value
>> is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().
>>
>> Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
>> bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.
>>
>> Make all callers of vscsi_preprocess_desc() check its return value and
>> handle failure accordingly.
>>
>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> Shouldn't this be Cc: qemu-stable@nongnu.org ?
This got missed. I have cced now. Will take care further on.
>
> Did we deliberately decide this wasn't CVE-worthy, or did that
> step in the process get skipped?
This got skipped as well. I have added the "CVE-required" tag in the 
Gitlab issue now.
Will take care in future.
>
> Ideally bug fix commits, especially ones we might want to backport,
> should include a "Fixes:" tag giving the commit hash and subject
> of the commit that introduced the bug they're fixing.

I shall post a v2 with fixes tag for the CVE that gets assigned and the 
commit hash which introduced the bug.

Thanks,
Chinmay

>
> thanks
> -- PMM
>

