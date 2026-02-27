Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F6DFEFB72
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 18:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw2IE-00074T-49; Fri, 27 Feb 2026 13:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1vw2IC-000749-Es
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 13:10:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1vw2IB-000433-0R
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 13:10:24 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RGPVYf2962734; Fri, 27 Feb 2026 18:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aQDnoE
 BgdqNpi5XimOSLpaVYJ5IyvvzmOgRkDCAu0AU=; b=cKL0RbblnA6xTUud304RAM
 PJqH40I5CDgZ34S3ZfQvWtlyYRt7hzvCTorfaedCqi+Z+m7LufvLhVkxEpmhMhBH
 kbwkkYncjPsIY8x4CPEplBLecgpkoWC6vip5zQR18OdVDLweMGC0xBF9E6Tbwj+d
 Efz225L332ypsL+rJMR4KpMr4lPpovZBmAMmKRe4IATDFfdJWOSz+OH+9afEnDYj
 PY4yyMljSLNB+nudN/FBG+berPnvYKBcqVlS28VYEDJXtD/gTVvevJck9VVddpvP
 uWGKrZBbDER80JShpN/QBFdZRNLBo3P8d+fKvkYVJw0Fx0+KTzu09Cl0x81ifXqw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gw6xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 18:10:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RI5BIc030342;
 Fri, 27 Feb 2026 18:10:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkudyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 18:10:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61RIAITZ46137734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Feb 2026 18:10:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E16D58059;
 Fri, 27 Feb 2026 18:10:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B48E58058;
 Fri, 27 Feb 2026 18:10:18 +0000 (GMT)
Received: from [9.61.252.45] (unknown [9.61.252.45])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Feb 2026 18:10:18 +0000 (GMT)
Message-ID: <c133bb17-ac2c-4568-92ed-f24188a1f3ca@linux.ibm.com>
Date: Fri, 27 Feb 2026 12:10:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Allow VDPA to work on big-endian machine
Content-Language: en-US
To: jasowang@redhat.com, yin31149@gmail.com,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20250616133647.1662767-1-kshk@linux.ibm.com>
 <22de010f-8fa3-4630-bc6c-e3ce8704ec04@rsg.ci.i.u-tokyo.ac.jp>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <22de010f-8fa3-4630-bc6c-e3ce8704ec04@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a1de0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=jWRtH5E-zo02ZlT3h_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kIB27aBrf92vgu_REdIWHjdqCU2ceBaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2MSBTYWx0ZWRfX0N94Z3LlX7qM
 LyKXdpJJlyv7V9+GB9QOFqz16oaNh+SabpcuFcRezRBa9VsMfBFOGvzeqo8ZGkm0OF5rJ4bZi+d
 pP7mBv6zVJYintNjOw9CowFchRqj1JNQrJbpPNfD7WsOoajhzJWHQkXXmaZwWat4Hocg5bAVwek
 ODjgy8KenYaD/IaDSM6c50vYjnWA3t8h3zk6Lw1IHXjdC7EnQly0g+V0D2SmCg1ADFQ7ch6UULk
 aQHYNF0Wqn8XuFHK9Rp0MPR0AnUNpjXKIMvLBzGD/z+Fvl3AH5oC4+TGAwSVJp+WaKxhbKSwyCZ
 mEbfBIwsYItwhvn+5JqqeJbpTexNee0UeUFIIslc6c1fEXabQfhN7h67UhY4MnPUBpnP5wNj3Gb
 JtPklDlH3xcRlvlVMZfM5yT3gJeJ55WwIVXRJEQ6UaHuXelPzYOQya9l659ARKm/tcGL3jPqu9U
 qkY6ENWPx0gr8r8ucCg==
X-Proofpoint-ORIG-GUID: P4Cxyq2N9z7SGWK2chhdrKBE44vkcWA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

On 21-Jun-25 00:52, Akihiko Odaki wrote:
> On 2025/06/16 22:36, Konstantin Shkolnyy wrote:
>> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
>> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
>> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
>> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
>> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
>> "unable to start vhost net: 5: falling back on userspace virtio", and
>> VDPA became disabled.
>>
>> Convert the VLAN ID to LE before putting it into virtio queue.
>>
>> Fixes: 8f7e9967484d ("vdpa: Restore vlan filtering state")
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Was this patch missed or there was another reason it wasn't applied?


