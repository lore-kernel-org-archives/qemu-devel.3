Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4473CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 09:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM047-00075f-IC; Sun, 10 May 2026 05:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wM046-00075N-8f; Sun, 10 May 2026 05:03:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wM044-0001Mg-MU; Sun, 10 May 2026 05:03:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64A1TQNa1281610; Sun, 10 May 2026 09:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QF1HGe
 2Q8Q7u4ZXhc4GBGPf4HGu4EScvnEsv/4kbxG8=; b=gHGPIP45WQJ8pbnDGexzxc
 aVYVGlD1KyeTCCKdagdlGE3XDFHQfo4mwBbF/92BgFer1M2swze9pnoBm4PObr4I
 Hk8VnhAsuAzHdW3piaQFXs7BpHH/t4kN/aUWdhe66Vp70Nh7LFMlomho2YTIextI
 jDgF0HUO0DWkbLVvEvvVsGOwwBkevlYL2XV6aDeAPt6HaYmU5tZNvxrSkBp2Wmk8
 Qlfx1wsSljmXk6d3nGfMstbx8emzCmdBSg73mXt9sj1QeZ0E8FoXddTPldMgTFtO
 RicXQlsoRYDhSshZjT156Qbeo0zuui917PMAJttbccBSAKpabay+xezddV2LpikQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqm6qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 May 2026 09:03:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64A8svMa030348;
 Sun, 10 May 2026 09:03:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jryd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 May 2026 09:03:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64A930Jq53215712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 10 May 2026 09:03:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD57320049;
 Sun, 10 May 2026 09:03:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 386E820040;
 Sun, 10 May 2026 09:02:58 +0000 (GMT)
Received: from [9.39.25.188] (unknown [9.39.25.188])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 10 May 2026 09:02:57 +0000 (GMT)
Message-ID: <e37c2541-3187-4bb2-8f43-8765fbf692f7@linux.ibm.com>
Date: Sun, 10 May 2026 14:32:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/41] hw/ppc/pnv: drop extra ref on PHB after adding as
 child
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-37-c413f3605311@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260427-qom-tests-v1-37-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDA4NyBTYWx0ZWRfX3hi5FUIyowLL
 Cml57f+2g8nAantTWRjR3I+FsTlVHhhgvj1cmEsCaPW7BCDQgXCwAX7IhHaGfRBRwRzHXutwZk3
 sd9vi3SrM3Ec44oQazZ88tju4b3Nahy5fHYZpdGF30LKA7HIhjCv3ZmZnP2HToVairUvsXXVHXH
 U4nSO/nJfq+ebvoVJxLAaHcEQbtQB0tZxyPUqTte9QXZu6yVr4sNhMxqgBpr4EmvbPSYlROa4uv
 fqgGlIBA873YD30DMZRfefMqtjLUYvh+UyB3U/39QItMmjTDNCAsSPxoegd4qwSF1gt/Z9DO9se
 WwhrUZJrPzL6s3CJY6+sK2EdsbNEX5BK4Z4zKj7EQzKFjXq8mNP1ruJSYl1HFyQprnvvKQpn7B3
 f2lWavWrNdnBpkR4ivd4h0XRb8IcAW0hfjx2SN6CLDWSojzYx5wqqzUYgprNFWG0rh39KzDrYWq
 spxgvjJzbbzPJw/4uDQ==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a0049ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Bvqb9KhA1MXhumrvET4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1bJ4qK8SeGvm4Q_-W9ofUzQTMOkIUXht
X-Proofpoint-GUID: q12AAa8LC-8UQV6Y3Q-UJRN9V86Jwv1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605100087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/04/26 01:12, Marc-André Lureau wrote:

> object_new() returns an object with refcount 1, and
> object_property_add_child() adds another reference. The initial
> reference must be dropped so the parent becomes the sole owner,
> otherwise the PHB objects leak when the chip is destroyed.
>
> Fixes: 0d512c7120a2 ("ppc/pnv: turn chip8->phbs[] into a PnvPHB* array")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/ppc/pnv.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 524563dcfc2..476255b722f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1590,6 +1590,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
>                */
>               object_property_add_child(obj, "phb[*]", phb);
>               chip8->phbs[i] = PNV_PHB(phb);
> +            object_unref(phb);
>           }
>       }
>   

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G


