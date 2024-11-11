Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E315FD2E9E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 12:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tATYm-0007jX-Rn; Mon, 11 Nov 2024 07:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fiuczy@linux.ibm.com>)
 id 1tATYk-0007iu-V0; Mon, 11 Nov 2024 07:30:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fiuczy@linux.ibm.com>)
 id 1tATYj-0002bT-18; Mon, 11 Nov 2024 07:30:22 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCA6mj023349;
 Mon, 11 Nov 2024 12:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QiEOvl
 7HlTHCFeBNH03dX+1w9otq2+GJXrxsMGAfS24=; b=MVwAlS2jFoVyaI6DhvMfX+
 aYKSACDufXZmYy58uLo0St3JMb9OdeHdihdg4L3mMZtO3SjO8Jtzz25xIsbqk7iH
 mHCkFdKzhn/ChixX9LonY9Z6LlkpYbC8ZH/uypH1K87tUvhBLyWuMeSoYJgsSpvD
 G6VvhcROEEJaDUxX/HncCGCdoOsVsd0nloshR8ba+HxfHfJYIbESTis4/6Nl4I9W
 qkC2i29lfKk9yNfFvPkSFKKdfxZ3j6+SS1+xF5rPGe2ftjBxUAJQY1+TpEspYZwu
 fS6ndDvGqskLkPbXVouyOZYM+hJ+7NCTvFskCG8NAh/ydLtT+xf7tP3+4tscud8g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42uhpg828f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 12:30:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9lLpS017144;
 Mon, 11 Nov 2024 12:30:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9ja528-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 12:30:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ABCUFp617367508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2024 12:30:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 500E42004E;
 Mon, 11 Nov 2024 12:30:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 069372004D;
 Mon, 11 Nov 2024 12:30:15 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.171.133.47])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Nov 2024 12:30:14 +0000 (GMT)
Message-ID: <a0fba8e1-fe2d-49e2-b3be-e2fb5c7a8f2e@linux.ibm.com>
Date: Mon, 11 Nov 2024 13:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/bootindex: Make it clear that s390x can also
 boot from virtio-net
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>
References: <20241111105506.264640-1-thuth@redhat.com>
Content-Language: en-US
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
In-Reply-To: <20241111105506.264640-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hcojq7KQ6mXgsyAtXQxL1PR1y_GgBoae
X-Proofpoint-GUID: Hcojq7KQ6mXgsyAtXQxL1PR1y_GgBoae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fiuczy@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/11/24 11:55, Thomas Huth wrote:
> Let's make it clear that s390x can also boot from virtio-net, to avoid
> that people think that s390x can only boot from disk devices.
> 
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/system/bootindex.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
> index 988f7b3beb..5e1b33ee22 100644
> --- a/docs/system/bootindex.rst
> +++ b/docs/system/bootindex.rst
> @@ -53,7 +53,7 @@ booting.  For instance, the x86 PC BIOS boot specification allows only one
>   disk to be bootable.  If boot from disk fails for some reason, the x86 BIOS
>   won't retry booting from other disk.  It can still try to boot from
>   floppy or net, though. In the case of s390x BIOS, the BIOS will try up to
> -8 total devices, any number of which may be disks.
> +8 total devices, any number of which may be disks or virtio-net devices.
>   
>   Sometimes, firmware cannot map the device path QEMU wants firmware to
>   boot from to a boot method.  It doesn't happen for devices the firmware

LGTM
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>

-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

