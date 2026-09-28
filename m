Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DF3CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBInB-0008Hg-Gj; Mon, 28 Sep 2026 17:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBIn9-0008HS-VB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 17:21:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBIn8-0006ib-7k
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 17:21:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI62nh1643425; Mon, 28 Sep 2026 21:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TLsduw
 YSwcs67NZ/NwuS7S8ZhfNA789E0y6szRnlI1w=; b=h1FI+c7EggPCltgeqx4q6E
 Jtwml7A4b7XM9gdcKxlrVpOTTaEqkssX5YbgBX0ReKOJZ/nFNKXu68OLNbhaWYUr
 FpvcmBWcpIzE5LkKzoO52CxYVcBWaUZoTu+AusXkGVJTa0Uy3xRtPWabSycE6cs7
 s5prClXYit4xFo2P4zOeg9hGSD/ZsPAYq1ihr98y6vT/Dv5IdEwOom2x+8MpW0R8
 /0bJAE2Hl9Q9ih+mGKp/zedQgzqzz89QOQQY0X0iDrWvgmD0VoqnLJwupbjmVKEx
 68gmDcPQbzlaTMlEEi5HP/aGgAhv0SVvHTjGs2uwAKsARPxyo875ZJGxVLKlLc3Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk3neh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 21:21:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2Zgm513490; Mon, 28 Sep 2026 21:21:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y6syr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 21:21:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SLLRHp29688476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 21:21:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C60F58056;
 Mon, 28 Sep 2026 21:21:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E382B58055;
 Mon, 28 Sep 2026 21:21:25 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 21:21:25 +0000 (GMT)
Message-ID: <7ac1826c-3891-4750-b5b9-c5f2a4217396@linux.ibm.com>
Date: Mon, 28 Sep 2026 17:21:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] virtio-console: notify about the terminal size
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Filip Hejsek <filip.hejsek@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Szymon Lukasz <noh4hss@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
 <20260928054918-mutt-send-email-mst@kernel.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260928054918-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OIlQUX3QKxnd_RLDye3SXdHBtRCKJ3xL
X-Proofpoint-GUID: DhQd3E3L3Xqvs6if4KMCeJEi5A3KZqno
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4NCBTYWx0ZWRfX+7+YyDAAayxs
 eftDpJBqSoUEfciONpOcFa8FX84bIsw9PndRG6fV1VJzClvjddyds03m/I2WeaiiUdO5M/yRMNv
 ltkCqwDON7tKoDx1neGvys69aLrEwwQ=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abada5a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=g453Uz4eaEUhJpFP08EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NCBTYWx0ZWRfX4EObzEbJ1FWR
 doo1hpqcnKJ44r1RCQihxPUpdfQHQMmWSndve+BN/IZGfujRkTjpM3Mh/x+IccaLiBEECsDxNrf
 7PImErBYt0cz19vKIC3KzbGQ0raIC+8ap5yYv6QdjR2NXzyPr8HFgu8fJg1GGPg+PTSH1am1Oqe
 PKdFJ269zMKrDWvXTknHjxmSK3DK0cIrESsww4QiT1sLCRvKF/EsVccGO+Yd30jnNyHPvS8O3+v
 lHmp7JjGvd5rj7LfW2IW/HQXduEwlXsjUlkyzf1/xw3XgxEOJSB50Xr+vr5deKfTmMkZHFKQPFj
 +YqDaVS1Kz/eVN3wpEAa3xRVa1xxQo8BMLt+NyOVKOAvITDfe3OBoa+LM8Oz45kIgw1cR+vzwD7
 FI7PVc8eyEpdFse9VQsftpNmVsaHLMjaDgHqg3vuO+tieBHLhB/bQRoMUd/VreNvL+DnZYrlczB
 ET6Q19RC4Xj0CgCPKzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280084
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/28/26 5:50 AM, Michael S. Tsirkin wrote:
> On Mon, Sep 28, 2026 at 11:30:03AM +0200, Maximilian Immanuel Brandtner wrote:
>> I would really appreciate it, if this patch-set could be merged. I know
>> that things can get really busy, but it seems to me that there aren't
>> any blockers that should prevent this patch-set from being merged
>> (apart from some minor refactors), even as is.
> 
> Why not address the minor comments you got?
>

Just to clarify, Max did not write the subject series; he is expressing
interest in it because he wrote a patch that builds upon it for s390x
[1]. 

Now, I'm not asking anyone to take code that isn't ready; but I would
like to understand if this series is abandoned or if the developer is
planning to send a v8 so we (s390x maintainers) know what to do about
Max's patch.

@Filip, do you plan to respin and address the comments you received? 
There isn't much, but it looks like there was at least one real bug
identified.

Thanks,
Matt

[1] https://lore.kernel.org/qemu-devel/20260928090846.2315532-1-maxbr@linux.ibm.com/


