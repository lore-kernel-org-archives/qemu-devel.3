Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C41CE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIJL-0004B8-GJ; Tue, 03 Feb 2026 10:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vnIJH-00048u-3X
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:27:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vnIJC-0003xI-M6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:27:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6139NGL4022220;
 Tue, 3 Feb 2026 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6T8YQY
 84hqG/Gd69rJU3JzaxcGU1ueEfxHPjO0EdN8g=; b=Psk82ScJyCftnVs9qBDl9/
 g4l7xK7ts6Dgks/AQtZ4jvoPD1sBmOuVHEsUeHQCuFq9a9zRqdLBNHIW9O848+Fx
 JitC1Kag35jVdAvfIobobIP9dZhj7FxOPzBEcmDfBah1ohee4tVCvpANGLIN4tnF
 uIT8gyknNmRyX+NMMePohXj5xGGveN2Qv92cbS2TuptCU53Rd2XJH6qu8Qr8dBLx
 ujl5aD02aNU13C+fG8dzD6utzswZmUkLdN+DJzsIpFolk91soZsznMVY6GBsFMV6
 LeQm6SveD3N3E1hvlJtx1FV/smAXVa8T1bFCZEcfiYmEpiLH25o+X3swTTaziZhg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt60b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:27:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613EBwam029421;
 Tue, 3 Feb 2026 15:27:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2s9rty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:27:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 613FQtiG21496526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Feb 2026 15:26:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DCE858058;
 Tue,  3 Feb 2026 15:27:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84B6F5805C;
 Tue,  3 Feb 2026 15:27:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Feb 2026 15:27:14 +0000 (GMT)
Message-ID: <d91deac0-c8dd-4832-a641-833d3064d02e@linux.ibm.com>
Date: Tue, 3 Feb 2026 10:27:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] follow-up for tpm_emulator errp story
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20260201172746.404481-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260201172746.404481-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMyBTYWx0ZWRfX3Y3/8Dz/hsVu
 rGEeYz8TXnCkiu5dFo3wP+7dEwDzHVOrLUD0d3T3ZDlgJTOru2/Fh+Qt/8L6GRj47DtS6Z8W/o8
 NTK4XJAIN6w/31p1u3EcABN4v79N2ciiCuHqKY6rEsLXeCNyWYEQtLvO26AezJfwchWKIQVL7wZ
 J8zw22Eaal1AyvbSSO7E9Qw1uf72yrAkdkf6OmGxj5nmn3afMAkrCzoGny/vLy0mfEqmNgcUhvd
 lExOBbVdzTLg5ktAZp+C03I3UQ9u2zNw2vaM9v9S8KX0Xls3zziqoZyg0BIutDUpaKwZ9v1wNGe
 sWUziHY5IljLfbb27PyDuXsh3AfQUJEhrUrdrE6FmrPMCgWnOkBoZY6Fs6O8U/WfmrOp3fsbuvr
 /+onTcnSyg7SdgDf5NSB6rxoE/o88zzFGCDmHTlw2ut3yYAW7H5gVgU8+LvGxc/0Oc2a+3Pl6ZM
 rM8Ab+mp0pn90gSuxMQ==
X-Proofpoint-GUID: Bl2ORzP79GvRxqXUl1CtzneRTjQSfX6H
X-Proofpoint-ORIG-GUID: Bl2ORzP79GvRxqXUl1CtzneRTjQSfX6H
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=698213d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hcWZWQIIgmldZBCGSpYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602030123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 2/1/26 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here are fix and small enhancements, following comments on
> already merged "tmp_emulator: improve and fix use of errp"
> by Markus.

Thanks for rebasing.
> 
> v2:
> - add r-bs
> - rebase on master
> 
> Vladimir Sementsov-Ogievskiy (3):
>    tpm_emulator: print error on error-ignore path
>    tpm_emulator: drop direct use of errno variable
>    tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return
> 
>   backends/tpm/tpm_emulator.c | 58 +++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 34 deletions(-)
> 


