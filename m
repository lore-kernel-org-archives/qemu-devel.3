Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBD9C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CoM-00061f-AY; Thu, 03 Sep 2026 15:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoI-0005yw-Fb; Thu, 03 Sep 2026 15:09:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoG-0004ya-CK; Thu, 03 Sep 2026 15:09:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2e003425453; Thu, 3 Sep 2026 19:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uND6UK
 yeVniaPs6uhFFYw9v/gSsVGVYxv4t0T26QILI=; b=hyMyn9RzxwWuojGXE9J5ip
 j0HQ1vJUeiq1JjXRM6boGF4iyvRzVLQES/PH3egG3JCYyFXeTixXAhOBbcqCR3Te
 Ob1D0k210OdZ22/2egB4q8Fsz/CNxzHOrV8Ma1n1WKZL0YyNfzUNjeapyyiGTq97
 qYFjl29vhiJDhOCS9ATj2kev1GcZBODYwLtVB2Geng6PqIwWlgnmS4GJojhNT6Ea
 D7cYZMPya6mAmtTF6Pak+uyorGfviUjPjzPoTaUN9hMxJrKDoU9aL6Q7SSGByoYZ
 1xeKLYy2Px1H+xdechKxQisDk4LyF2FdI2MtG3WGVAb4bcN61F5+FDhPfhDuV4wA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5xmfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IuKwi002295;
 Thu, 3 Sep 2026 19:09:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqs9ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683J98Wh13894234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 19:09:08 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55CB15805A;
 Thu,  3 Sep 2026 19:09:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D52E05805C;
 Thu,  3 Sep 2026 19:09:07 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 19:09:07 +0000 (GMT)
Message-ID: <90fd97cd-e085-425d-9b1a-5fd6fe469458@linux.ibm.com>
Date: Thu, 3 Sep 2026 08:44:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] pc-bios/s390-ccw: Check if a PCI function is
 already enabled before trying to enable it
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-2-jrossi@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99c5d7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=rOHUGBc37_MNbdIC:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=ZU7MScr7iirDZb_9vssA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: P-lZgrf1VvGXy3MLuj8H0inRNnl7fb_P
X-Proofpoint-ORIG-GUID: P-lZgrf1VvGXy3MLuj8H0inRNnl7fb_P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX9w6F+9Bm89iv
 pe0D/NWwMDtJjEGRbAT516NCVdhV8EGpExe7cIE8SO/tHk4JyPdwPaHO4Jk0GOkRHdK0EyXXQP9
 IXLYbc6QXjIi6MfWX7bc0WIswhPHHZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX2SKhn+uvuwsf
 vGd7Uo3aZsCF1vXiTU53OsO523NdMcPFdqoXk1oGZZ0a9o+soqQ5ymAgReo4PjX8sDw5S3Iy/q0
 EKnFBQeNXTT5dkzembg9gZX1wP7FUC7ccfUvJ+VKGqoggOpVjXhPilDYcbk2F+SNNlPKUBNEcwq
 wG7mae+OQxM+fhAmYePuXK3DJ6jkMdKntV3cFXXPdKLpKEV4+GOds+WjAFOmy51zFc3otDMe1IH
 9ciRmVobhRZNdVNduuv8eVAO/ql3M4TNkcBF1kT+UrTSsVNgrnHalybuh1NAJ15gTjc22GQGKeb
 lIA5fPqGe98ytd8ojiTEsTk/kATqQa+lmjyspqEZHp/sxKU61/TMNnX4MgvvBANqSDp3519naEw
 pfJ7nDp+zmzfCGeU4cebF9zCYaX3ZG0hGOFiNNYIZYxiCDwuq0uTQxV1Arxv+f3BDUj8HfM5DpV
 hXuiFjIW391ZIO7+R7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/31/26 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Enabling a PCI function that is already configured will result in an error.
> Simply check if the device has already been enabled, and if so, return
> without doing anything further; otherwise, enable it as usual.
> 
> Also, because enable_pci_function() prints its own message, let's remove
> the duplicate message emitted during the virtio PCI setup steps.
> 
> Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/clp.c        | 4 ++++
>   pc-bios/s390-ccw/virtio-pci.c | 1 -
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
> index ca9565d8de..7917f13345 100644
> --- a/pc-bios/s390-ccw/clp.c
> +++ b/pc-bios/s390-ccw/clp.c
> @@ -82,6 +82,10 @@ int enable_pci_function(uint32_t *fhandle)
>   {
>       ClpReqRspSetPci rrb;
>   
> +    if (*fhandle & CLP_FHLIST_MASK_CONFIG) {
> +        return 0;   /* already enabled */
> +    }
> +
>       rrb.request.hdr.len = sizeof(ClpReqSetPci);
>       rrb.request.hdr.cmd = 0x05;
>       rrb.request.fh = *fhandle;
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index f501252c81..231ab6e04d 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -452,7 +452,6 @@ int virtio_pci_setup_device(void)
>       VDev *vdev = virtio_get_device();
>   
>       if (enable_pci_function(&vdev->pci_fh)) {
> -        puts("Failed to enable PCI function");
>           return -ENODEV;
>       }
>   

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

