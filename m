Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0DFC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4jx-0000ks-UN; Wed, 15 Jul 2026 14:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wk4jr-0000kH-7W; Wed, 15 Jul 2026 14:53:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wk4jp-0005Pd-PM; Wed, 15 Jul 2026 14:53:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHCrIp779242; Wed, 15 Jul 2026 18:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rvQ3C0
 /IN0BfdPykbOi836XJXD4mAh6xqm1hS8V8p64=; b=IQcv26G/KtXPHPhAlI0aDm
 +Ioc9i2w65u/8WuAR9V0pyhGJHep4CZH1AlWGhKFRV81kydvUVIO7vrCAanccM7m
 9CJtnGTYv4vjXhw/cWdVeXDwA4L6o5GwkSH+Ps9xTVf3D6NjKYXsBgCSpgvzopyp
 cogga08l6gEpVwt0IS9gtjirLOXAH5ApwPO8Ly8UPf1jYtUlWjOKRePSN/Q0MevQ
 N5JHJsyoFkwRWW1fjnH9eJd3wZD/ItFdheObOAsZ0sGtIz9jimdfUgx64K4vQpb0
 ejyAAwzFbJx5/CypiDbLeDEkSBJ2MkEwqSmziuT5GtLl0JSEkYcG2EJWR5wYLnPw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbvk5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 18:53:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FInaoF032033;
 Wed, 15 Jul 2026 18:53:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhhdne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 18:53:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FIrcq928181058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 18:53:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 529C35805C;
 Wed, 15 Jul 2026 18:53:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8E165805D;
 Wed, 15 Jul 2026 18:53:36 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jul 2026 18:53:36 +0000 (GMT)
Message-ID: <4ad2f92a-d3b1-44b4-ba8f-fa993695bf59@linux.ibm.com>
Date: Wed, 15 Jul 2026 14:53:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/33] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707231132.2492104-10-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260707231132.2492104-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a57d734 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=IrZvC-waEUVJwRxjAe8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4NiBTYWx0ZWRfX2a7NFsqzLRUG
 TgyLAsMF5i+ZLsyYLNASOWFo0OBGJ8AdrL1fp9IdKO9IHBLkRVzbI6UHIT1e7AM/MYcSgBloCr+
 wjSVVjDClPUWYE5x3P4zfGi3fLfZDrhHoibC4diqpd5aRkxOCQ0gQebLRQsdX5ECfqst1BNLWmI
 LpoD6MsQ1d56uO8z5j7oubSuCJMjWvpkc1wc0kfGnha5N/tFqTv7qy65r+pm6zbt9n+6mRVyCQI
 FKs5GPJJ659jpKYFQS02NkNrqRwhuEAC1aB6RfRD5MCrnOhrxSiMSkpnqdt2e65JjTjzhq05mcy
 1YyrBq6+nTrYYdgnIIiBC0XJfk1wXtPijtzm5UVd6jNo/fGSp0wJ+6sq/VS5nVZKedtliRlKegc
 mpUr54y5fiH/xyZqSUw1gXPSljixHidtkoR24kPmQ2htsYI5Zf3qbkrtQ9te5lGdHe+KOkb97ni
 ekvDOxdZE6kxih9aE4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4NiBTYWx0ZWRfXwDMrZfymPM9R
 A1glH1XHlVVe5iV0o2DIyGQG89wIVHom0rHjBmu6BWy8/PbEa/F1Bv4i/U9HH/n2ztVpQ6tHhwl
 NBtH1XtCIdL4SpDEJzTukgmyNi4igzk=
X-Proofpoint-GUID: nR71vYj85LO1cLTL1gDvoC2idLSZXtA8
X-Proofpoint-ORIG-GUID: nR71vYj85LO1cLTL1gDvoC2idLSZXtA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150186
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

