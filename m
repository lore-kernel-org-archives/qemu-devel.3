Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B0C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Aq4-0002kw-OF; Tue, 22 Sep 2026 20:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9Aq2-0002kT-KX; Tue, 22 Sep 2026 20:27:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9Aq1-0005Wj-08; Tue, 22 Sep 2026 20:27:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI801M3448390; Wed, 23 Sep 2026 00:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cFXL5W
 E0jQkF9JyKDULo0gyJEme5swu6YOxI2HAn8Kg=; b=UqBzyjD0BQO3HyJ+LdLXQq
 c3oyMRLcqrMKJM+3lpUHgy/ikeapNwGVBCpCcITf6oSNxJvDyw5nJOEfXVG56ah7
 w8f6jr8AqXApQc0mEMAvvwr93wDNIAQaFIr7s3WCddpaaB3UgQt6CzlPBDpfCfL8
 jipd7zO8l37Hkn7t53Y6yG63nzS5blTqnLQb0Y3XhD40fe8jYqqAAL7cZXYjFux1
 guJlhxunPCulh3l3xYJ0i/FPqVQYgZyrSzj9VXNEZfjHH2G8vPprgV5b6z6UQnk/
 UyW1Rh0pod2swFfg5dTaZN1P1DnNcj0sBVUDvibS1OMJFTUJMu/rE7JbV7pngFVA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1rhee-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 00:27:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MN5p7P4187986; Wed, 23 Sep 2026 00:27:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dybtx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 00:27:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N0RmqK9830950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 00:27:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95C775836E;
 Wed, 23 Sep 2026 00:27:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC9B15836A;
 Wed, 23 Sep 2026 00:27:47 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 00:27:47 +0000 (GMT)
Message-ID: <11a10218-1893-41b8-a1ba-8acec6c20d17@linux.ibm.com>
Date: Tue, 22 Sep 2026 20:27:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260914193438.526407-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PBCWEy5qm_Hx7xj_JAzLep3qu-LUy7n7
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab31d06 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hNTO0ZySSFXKkZstvnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwMCBTYWx0ZWRfX/OWdyqXoU+ty
 9q/SI4lgvHGmD96e8dD3cVBSSsHcEup05mKp2jMAFCvyHvSQc4374K3mXbj2U9kT+K30NildmUX
 foVbKX5HPoKU0DUAmWk+6PfTdLprpvw=
X-Proofpoint-GUID: PBCWEy5qm_Hx7xj_JAzLep3qu-LUy7n7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwMCBTYWx0ZWRfX4wVOQu7cZd6I
 pKqvCwoZAGbN0RReNMWhD/Auw41ewp+iHokENs1klgVutAsiV/RbJrNw1WWnp8bOpioMf75D4gl
 komqfh3duqCL0n67xA+OB68Isb+hOrZVrqDY/oG4W1gkcyZs3Lb6GLRODzKiDucCquB4Bp+ibYz
 prucaMVuhdmPJUH0ovJGSqfjRs2C06FKakoeV3VGNeDqZYLGmSbnMBBucZVoG4ADlF+z9rrg0pZ
 A5ArkX1hSkPONkijv6imNLMuRRxKKSClSP0TVaCp/zLi1ht4xR4hZvNeIou8XVWKTm/yJ1Hzp4O
 t0cMfJNGnK981LsvZBO7N6y1RHZ4Vp+X1HAQR6P3nnYd9i8LZdWlWjXEbateT1ZtV8/tE/Y/DqF
 8FFZuenZe26Tzrhgtl1F0J9c3FYL1E2Dk0I59DLqeog/faLBI043cGnGo3ETRY5c+uO59y03s6A
 9CqekK+cQlgcO8xk+Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230000
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/14/26 3:34 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> including it in the PXE test suite. The test verifies that PXE
> network booting works correctly with virtio-net-pci devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  tests/qtest/pxe-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index 8b6015b6cd..c29386ed4b 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -129,9 +129,16 @@ static bool s390_bios_has_net_ccw(void)
>      return s390_bios_has_string("Network boot starting...");
>  }
>  
> +static bool s390_bios_has_net_pci(void)
> +{
> +    return s390_bios_has_string("Setup failed for virtio-net-pci");
> +}

See comment on patch 6, tests run as expected with/without the
virtio-net-pci support but the output is confusing.

> +
>  static testdef_t s390x_tests[] = {
>      { "s390-ccw-virtio", "virtio-net-ccw",
>        .boot_dev_support = s390_bios_has_net_ccw },
> +    { "s390-ccw-virtio", "virtio-net-pci",
> +      .boot_dev_support = s390_bios_has_net_pci },
>      { NULL },
>  };
>  


