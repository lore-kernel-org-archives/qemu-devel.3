Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A862CC5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 05:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy16b-0005Ir-Vd; Sun, 23 Aug 2026 01:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy16Z-0005IR-Mz; Sun, 23 Aug 2026 01:50:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy16Y-00006V-9e; Sun, 23 Aug 2026 01:50:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N4X5U02102961; Sun, 23 Aug 2026 05:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nXT+M7
 1q+UxkChEyj+8khXJAkl5TU5lAT0bX2dP8GWw=; b=jkW0CZrMtySnAPDZT82MZe
 +CNAJTjnUaDTIF+lD+1PP9voVBJm6o85y6W4mQACxsB3ghTIXO5bsgMEetsSkN++
 R1PUsXpdZwlCVWqXXz2I1kBo8SIOr4TdNMHBe2JEIIXzJhQbBYsjp/0wZBW+TB21
 yzbxcw+qaLdHn8bcD4hzIQk/dI0kE4w5JA90QmKT1toZUQfx6yCnaVswQANZxF4+
 YOHKb1CVqxorJYVB+uhaHHUpk2XurA1/Cn41rNP4OfbK+Ua2cHJaLIZtD5rJgjcw
 C1S6fpq4V/alavCUgwskrTzHtO3eMDeDhcaWXqun4oFbTLfVqo+M0zSjNe9OJfbw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hc4d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 05:50:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N5fbTq030470;
 Sun, 23 Aug 2026 05:50:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag0cp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 05:50:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N5odCR16843506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 05:50:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49D9558055;
 Sun, 23 Aug 2026 05:50:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D81F458059;
 Sun, 23 Aug 2026 05:50:35 +0000 (GMT)
Received: from [9.39.19.238] (unknown [9.39.19.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 05:50:35 +0000 (GMT)
Message-ID: <33b6bf60-45cb-4127-8a3a-8b2de3b8efa8@linux.ibm.com>
Date: Sun, 23 Aug 2026 11:20:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728150627.b0e3b230-14-amachhiw@linux.ibm.com>
 <54a09c6f-0ed4-49f8-abec-afd916faefcf@oss.qualcomm.com>
 <20260729101217.db953dfc-ee-amachhiw@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260729101217.db953dfc-ee-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA0OCBTYWx0ZWRfX/wX0A58AzbOE
 VCtP0mAboVepbOmwGEuM2BurfU2qs1zjWi/g5XBjGWl1K3hEPv+cUoH8VL/gtS5nilckAdQfc6H
 +IwSK6p2r2iSOh4ZUjgiX/WVPso7XBA=
X-Proofpoint-GUID: 0gnIUiqQHrFnwt_mFu_TwL7hLLJrJBkp
X-Proofpoint-ORIG-GUID: l6fSsEb9G2BjPedk1IiAGUrLIIoNhslh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA0OCBTYWx0ZWRfX5lqrTeQwULau
 KnI7TiDNEopwvPQSOpUHZzx5DQ4+5g+/d1WXAh3ZdSJx3jHywmTDEnvdXUdBWltit4cCoR0kCAv
 dY20XYFl9Z3ocBsX3H66eTkq9kbyGQ6CtGAy/EoZdSsmoGh8OwdJ+LE2+YoLYs6IiAssJAZjVFt
 I5mjXh9n4ReKIBlM7QT/JVKNwAaIMH+UUcTyMzn6hqbZ3LO/wYglY/BNmZ4yWUvOJNKN4STvnQN
 9zJhvP9dCKyPafzfx9NyADOOtI+mg47IPTH+JoK2iZezzvPRt8YdqCfqxw163MF+/W9I4Ma5UoX
 mLZ+ziOhSTg/yBmUt03sZNblgcGeh6MnHz5D5J5ko1AhWBzFr6V03kqpXBiBY2gHqMV6LJ5zfbx
 FrSiX6/XdFZYW4kBw1Fq3AydUForXYnPQzY58hHeG1lHHdi41Nn+jePmCrUDB8+LLMmcMODy1PT
 dh5GNxkO0qrmOXhemCg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8a8a37 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=6solyz-zEC3svBl0zTQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 29/07/26 10:14 am, Amit Machhiwal wrote:
>> Do you need a v2 with a change, or feel like fixing the typo when
>> pulling this patch?
> I think its a minor one and a v2 is not required just for this.
> 
> @Harsh, could you please fix this while pulling it?

Fixed typo and queued for 11.2, thanks.

> 
> Thanks,
> Amit


