Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B670FC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9HIq-0002Yy-9j; Wed, 23 Sep 2026 03:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9HIo-0002Yg-Od; Wed, 23 Sep 2026 03:22:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9HIm-00076E-Hu; Wed, 23 Sep 2026 03:22:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N78NWS855415; Wed, 23 Sep 2026 07:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IE6SuS
 2OBTee0ikRG/YGxWtJmPyugSrdf4SO3rCFeK4=; b=RLFHQEOB1geXL2W3fweTFT
 l7rN9cL+g3d+IQOdKt+lgGPGi4wtVyo3pLmd0Gack4SHnnGH1SAardFK1rmfVYyC
 JQGRTSZ0VTplPRJQukO28Vv99IXcPNU3+VsqFGtyqNg2zZJQp4MwCRZjNm41lQDX
 wTy+SFJFwU7io3z4ImvQmiIdjpQSPfDm9UO8by6J5+Bb2XuYnzp6Ad6FEHn6oQln
 LrNLCxjDWeN/f9hgCbkzRsMF4YI6BBSSUi/wTFPB2QGgJhjiiWc+TSENEzLeJuD/
 wB5+sCeiL+l1Bo+UUrIV8FfyZvkjGI4YAaCYAJjOfmiJWyMk/HGrIVnTvNiwRwhA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1st02-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 07:21:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N7HVUL4084100; Wed, 23 Sep 2026 07:21:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gw5wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 07:21:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N7Lr8336831528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 07:21:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B0FB20043;
 Wed, 23 Sep 2026 07:21:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05B420040;
 Wed, 23 Sep 2026 07:21:52 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 07:21:52 +0000 (GMT)
Message-ID: <afdd1d5a-479e-4666-a33d-48f8391cf118@linux.ibm.com>
Date: Wed, 23 Sep 2026 09:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390x: even more hardening fixes
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260922201526.2383047-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZJo87heoUsGqu_0KKiP0wqtFAcvoCIqt
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab37e16 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_1U8H7b8OK_dZt-XgggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyNyBTYWx0ZWRfX9ycTJrCO2C5w
 t3Ell/5jeMrsCohnnzl228SzD+857MSJ3l0wB6t9j/c43hwOLvKDSwhUW+480PkHE3R+aHvLy9a
 mRbDhKXOzcshlH7hXFcvTVlmQZeyCWg=
X-Proofpoint-GUID: ZJo87heoUsGqu_0KKiP0wqtFAcvoCIqt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyNyBTYWx0ZWRfX0r2Hk0VxdmNx
 9YrTNI3p9Oxn5vDsbzw5BEMP1GzttbQpgCcitqNIhLIYlZYjPcoxb3RC26/kMJbqOFGKqyZRqD8
 k2LfOqqaKSe1Nm9LNgMzskKp/5OkP4ouzkrB4knj0WUtYhhJYVOrUKJwXraU9GbooV0rA6+mNxn
 rgmaXoT3RRTz3jVMOAYvXgdpfawjpDmTksoSBST6f/yq6a8pJNEPei26GcTqTxp9UG57agDd/fZ
 BAB/bH1q06wBCP0cCrbQO4TCB5/NCW8AndfVP4uRw99jMde4BAgFA/9+1msz/aHjGvBUvyfmyYO
 5UXkWJEaE03l0qKtR1m+Atk0Z9nAJ0af2zyYAKybMxB5TuHTGvhAK5EXeiExz7oe434/6y+/0rH
 KQ/l9yFz8Hx+K+EIEt/2Jlu+V8cjRckXRsfvDMhprzbPQBxQQfIgmwhHNgbRL+/sF1j1dwgyHzc
 X2RpwyY81cL0M1IdaxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230027
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Am 22.09.26 um 22:15 schrieb Eric Farman:
> A small pile of additional hardening fixes.
> 
> v2->v3:
>   - Collect reviews/acks (Thanks Christian, Matt!)
>   - [CB] Patch 7: Rename realloc variable to new_buf
>   - [CB] Patch 8: Move check of at_byte before check of command chaining flag
> 
> v1->v2: https://lore.kernel.org/qemu-devel/20260921184305.3791311-1-farman@linux.ibm.com/
>   - Collect reviews/acks (Thanks Matt, Christian, Tony!)
>   - [MR] Add fixes/stable tags to patches 1, 2, 8
>   - [CB, MR] Drop fixes/stable tags from patches 5, 6
>   - [CB] Patch 2: Unwind indicators upon re-set, instead of rejecting it
>   - [MR] Patch 7: Use a temporary variable on g_try_realloc() call
>   - [MR] Patch 8: Use CCW datastream to increment no-data count
> 
> v1: https://lore.kernel.org/qemu-devel/20260916203242.2509787-1-farman@linux.ibm.com/
> 
> Eric Farman (9):
>    virtio-ccw: Limit ISC to MAX_ISC
>    virtio-ccw: Do not overwrite existing indicators
>    virtio-ccw: Fix rc check in read configuration path
>    vfio/ap: Clear error object pointer after non-fatal errors
>    vfio/ccw: Clear error object pointer after non-fatal errors
>    hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
>    hw/intc/s390x: Fix check after g_try_realloc
>    s390x/css: Use datastream pointer for checking no-data CCWs
>    s390x/sclp: Reject short headers in PV case
Series looks sane to me.

