Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876ACC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQp6-0008Rb-Pj; Thu, 16 Jan 2025 09:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQou-0008QF-9o; Thu, 16 Jan 2025 09:26:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQor-0007Hu-VW; Thu, 16 Jan 2025 09:26:04 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEN7Mu004842;
 Thu, 16 Jan 2025 14:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YY2aor
 NcgJgP9jQXxSIlQb+ChmNTcW0/7E7F9IwaAMg=; b=myqD55CHxMmT0/yfDUaGnU
 2Pnl47vZCvUwhBA76Q0ZkCH/c1xaiZzJF6hmVc7cMAcwPywx0EtbOM0k1lxsNZQa
 IdSURE1J5QTMDs4rBAegsVubaRChM/lTFeyHO4rojPXZYFuB5OuTKJV6xJgiodKZ
 N5gGbqA19AlqHMAj1I2iBPDSbdICLPL4jgkIT5bwPaqD0ODLSOaZxkgK5uIuXiC/
 Aj0IkUcLyUgzF9xdPkQyDJuvlHSs+vVeB9Wz/Mdm65eZ7H3A5j2jRCH6FTbrv+5e
 DV6HI2P2vjhGf3t83IQzp8JalD4J+ZBH6PYwsIhkBHgSXJMcsfY/teeW/K6pmPeQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhav4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:26:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDPIPJ017366;
 Thu, 16 Jan 2025 14:25:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fke47p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:25:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GEPvhn54395156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 14:25:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9879B5805E;
 Thu, 16 Jan 2025 14:25:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E34E58052;
 Thu, 16 Jan 2025 14:25:57 +0000 (GMT)
Received: from [9.61.78.171] (unknown [9.61.78.171])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 14:25:57 +0000 (GMT)
Message-ID: <a5d9301e-a926-4c98-a9e8-ffd955b71256@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:25:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pc-bios/s390-ccw/netmain: Fix error messages with
 regards to the TFTP server
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>
References: <20250116115826.192047-1-thuth@redhat.com>
 <20250116115826.192047-4-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250116115826.192047-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MY0dA3qd_LVLhvIJ8rxNrxxO5Mqsy_ki
X-Proofpoint-ORIG-GUID: MY0dA3qd_LVLhvIJ8rxNrxxO5Mqsy_ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=981 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

On 1/16/25 6:58 AM, Thomas Huth wrote:
> The code in net_init_ip() currently bails out early if "rc" is less
> than 0, so the if-statements that check for negative "rc" codes to
> print out some specific error messages with regards to the TFTP server
> are never reached. Move them earlier to bring that dead code back to
> life.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/netmain.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 335ea9b63e..719a547ada 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -168,6 +168,14 @@ static int net_init_ip(filename_ip_t *fn_ip)
>           if (fn_ip->ip_version == 4) {
>               set_ipv4_address(fn_ip->own_ip);
>           }
> +    } else if (rc == -2) {
> +        printf("ARP request to TFTP server (%d.%d.%d.%d) failed\n",
> +               (fn_ip->server_ip >> 24) & 0xFF, (fn_ip->server_ip >> 16) & 0xFF,
> +               (fn_ip->server_ip >>  8) & 0xFF, fn_ip->server_ip & 0xFF);
> +        return -102;
> +    } else if (rc == -4 || rc == -3) {
> +        puts("Can't obtain TFTP server IP address");
> +        return -107;
>       } else {
>           puts("Could not get IP address");
>           return -101;
> @@ -183,17 +191,6 @@ static int net_init_ip(filename_ip_t *fn_ip)
>           printf("  Using IPv6 address: %s\n", ip6_str);
>       }
>   
> -    if (rc == -2) {
> -        printf("ARP request to TFTP server (%d.%d.%d.%d) failed\n",
> -               (fn_ip->server_ip >> 24) & 0xFF, (fn_ip->server_ip >> 16) & 0xFF,
> -               (fn_ip->server_ip >>  8) & 0xFF, fn_ip->server_ip & 0xFF);
> -        return -102;
> -    }
> -    if (rc == -4 || rc == -3) {
> -        puts("Can't obtain TFTP server IP address");
> -        return -107;
> -    }
> -
>       printf("  Using TFTP server: ");
>       if (fn_ip->ip_version == 4) {
>           printf("%d.%d.%d.%d\n",


