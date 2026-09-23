Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E524EC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ApQ-0002h9-Lw; Tue, 22 Sep 2026 20:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9ApO-0002ge-O8; Tue, 22 Sep 2026 20:27:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9ApN-0005Vw-7D; Tue, 22 Sep 2026 20:27:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7ki81158365; Wed, 23 Sep 2026 00:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=O3UXBT
 QI+lOwPlekkiIvI9rQmYdYv1WtE4zIVSjAYko=; b=R28QjNdut8X3MKTJ5HKgpP
 NQgH0iV5Fp+ANzufqngBtr6VsAqI57wCQ4eD7nCAzrXbXr52f7SZHc9ZZ+JgybYy
 cKo95XVaKrRontWsJk1eMm2Qko+idEB7RQGbNlqZVT614jn1fRDKOFAupP/bMpxJ
 mX2KEBGEz1fBygj9TGrhJ3Jvya4Ci0gOGcrQx7eg/x3oOuZj9lETEGMw88tFcz9j
 9F2M3crASCdz/67EHAU9QjdRsJIQ8qNTrYVlgcMwDaDW+gzCOmWxgEU97dpuA1Nc
 sATccVrzhxpmY3Pb4BYtiGBkRPznWo165Yugm1M2CCDZPrj7QIOwVkznllNnqoVA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv866b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 00:27:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MN5uJs1972736; Wed, 23 Sep 2026 00:27:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkem2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 00:27:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N0R9JC15401532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 00:27:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55B055836F;
 Wed, 23 Sep 2026 00:27:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FD205836A;
 Wed, 23 Sep 2026 00:27:08 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 00:27:08 +0000 (GMT)
Message-ID: <a3e92869-91a4-4ab3-8192-546979abdc12@linux.ibm.com>
Date: Tue, 22 Sep 2026 20:27:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260914193438.526407-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C0bBCVM7DyYSvHJCqr_Ztr6xOeuj6ndY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwMCBTYWx0ZWRfXwpisav1vd5ki
 VkaefDxUcKPBA0EegYJNZK0C9v1lhio89Xouw0vBVw+hRXuOV4jJ8bR6SWdUuxEAdV4xhfez4yu
 pl6PQI+TjtExUlrrbYvVtHLB02tHLSI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab31cdf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=MR_Ax72oLTKHnJ2zudwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: C0bBCVM7DyYSvHJCqr_Ztr6xOeuj6ndY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwMCBTYWx0ZWRfX+gf8cCofRM4U
 ja7o8dtJzFALgFv2knZbyC9rSKakBp2OppbBeAaeHapA5Hw8Bv2dBD/RHZ1QaiOyFLh6B6k2Rsy
 EaRFCVotY6AbsL80zu+7OGZoKTW8FyYJwHeFhcdp5tr1plfe9VmOG4PSXCoCjt8iEmPcXo9fsrn
 rqMl0s8vVoIJEiZCbP7n9sKOqBtw97lAQuZjXYBiw3sq8j8lH/t5Tq+FdEeiOkldh4K8h9GOsej
 ZWPIWrl34VxP3yVzF/WbXhD65Ex8mIQGSyr4I+9rXfaW2HzfA5wmG3hpe8iL+cgWxHt6tPc6gXh
 qBXTl36AftAvWgUoBbwAeYJpx/J9zMTEeAGPdVvB0Wv9a4G6OALNWkRDiru+Ic/YUlmpSH2abn5
 4Fzl6HPUSsG7lV3A7hIUciJYSnGkQjkU7Ew0+wO9iMm9TAhsYRjn6QwdfH8IvFvdhAPfbEPezGU
 B8JLfPzQkoLrRRYTwCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230000
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


> +static bool s390_bios_has_string(const char *needle)
> +{
> +    const char *contents;
> +    gsize len;
> +    bool found;
> +
> +    contents = s390_bios_load(&len);
> +    found = memmem(contents, len, needle, strlen(needle)) != NULL;
> +
> +    g_test_message("%s %s", needle, found ? "found" : "not found");
> +    return found;

Please see Josh's comment about this

# Setup failed for virtio-net-pci found
leading to a successful test run really confused me.

Basically: re-word it so that it works better with the next patch.


> +}
> +
> +static bool s390_bios_has_net_ccw(void)
> +{
> +    /*
> +     * virtio-net-ccw has always been supported;
> +     * probe for the string it always emits
> +     */

...  Except for the point in time before 3e4415a751 where the support
was added :D

Yes, we expect it's just always there now, but...  If there's nothing
else we can test to verify its presence (preferred) can we at least drop
the comment and just say we are assuming it is present?




