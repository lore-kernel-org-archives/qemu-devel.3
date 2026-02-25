Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D02F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9Ey-0000bj-JB; Wed, 25 Feb 2026 02:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vv9Ew-0000bH-67
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:23:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vv9Eu-0003WO-Kg
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:23:21 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OIER9x2713432; Wed, 25 Feb 2026 07:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HmXNtM
 BamyJUVROuQL9GAPYX8wVIsbw71UxQicEdbmg=; b=iodH+EWovB9fReC/OTE1t2
 nCEWmX5JEbTWPA3YFwnE2/WdouCXp7KechP8rTlZBEX2CJgyQnQF71WEuPmb+u0Q
 61JKntWufetan5Rp24g27UDI623/CfTTblpHiK7BeyUC4Gc6Xx7ihE8uDqjO6+dR
 Vs3+8mrDRNzdWP7q0Qj7gYejZ2yBh32Un/qmiclKmOKtT/StoSpHZJv3lgVBLaun
 jD9WNp8Ml5lhjBmOOJRfhngKt+40bvQrM/YDnWneGWmLRe8P1caWkOmWurrLHMcv
 VQjDYWw00T4Jn9czU40vTkKhRaioJnDUbEHEOYlktxHud5HXEowkMW3lKxcG6CUA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c6f68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 07:23:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P4DYNc027887;
 Wed, 25 Feb 2026 07:23:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1v1t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 07:23:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61P7NDku30015888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 07:23:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 349BF2004B;
 Wed, 25 Feb 2026 07:23:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFBCA20040;
 Wed, 25 Feb 2026 07:23:10 +0000 (GMT)
Received: from [9.124.222.235] (unknown [9.124.222.235])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 07:23:10 +0000 (GMT)
Message-ID: <a42777cc-6c4c-4746-a505-e98c6fec3791@linux.ibm.com>
Date: Wed, 25 Feb 2026 12:53:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional/ppc64: Remove custom migration
 routine
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, peterx@redhat.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-5-farosas@suse.de>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260204172332.21367-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA2OSBTYWx0ZWRfXxpe0A/jCAHUk
 kX0ryo/WBhtxudxxMYA7HzocsBCxM0vzoy07/YHPjhLBmJ93shfcPVXe9h2ITkHLUl8Bd53pjs5
 siLnOPj+m0OqNm7WCdBMW3Ta2rPcakWWC/6kU+N0ERBqaNwhGVHb0gNg1odWQgkwXh5LDi+wTzQ
 nrieQR0aUY0raaJWJlL1AMVJFhAtZqK/D2MdBCKNXVD3ZxSbHzMLzdR2lWfdB4UpOoz5YTGW7Kb
 jPBRAHILAqH5zutvpiJkbzunzdwyMf1571JW5fSQ1xzR2i+yM0cxho+TM3i0a8vkjhYvUmkf94J
 Z7qJFkS25s1+f5MRVWCyrYhiS7J3sWCTYNEZu6arOBnk0ohE5ao9B4hAMB5QzSonK+oHZFdz9QV
 w1yBWuiXio4ZzZ2d2SYi4hM6Z18pV1iPXeJV+xahJuqtowPynqhO/J9spUnrrYpIMxYwitZwS9V
 OkoKZVTrJMOvNqsaIOw==
X-Proofpoint-ORIG-GUID: gYMrDGwxA9N72aNR0LV-LHBOdZ7VQMjw
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699ea366 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=j8CySKXDZJbOIHZBDnEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fnQStQ-_os0aOwLvLvOU6SuYxjWlKsQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250069
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello all,

Just a ping, the issue still exists with functional tests for ppc64 
failing when run in parallel.

Can we get this merged ?


Thanks,

- Aditya G


