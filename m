Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D7FC55173
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 19:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpVyk-0000Mm-9w; Thu, 30 Jul 2026 14:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wpVyi-0000Lx-2c; Thu, 30 Jul 2026 14:59:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wpVyg-0006WK-3a; Thu, 30 Jul 2026 14:59:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UGlX7v1691625; Thu, 30 Jul 2026 18:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Fy5QBO
 MpCtsQP3EevTN0XoXJuPxnVmYtUp3GGbXPc3I=; b=PxUeikZOnbItUyanOusNKB
 z4oW58uiga58ipNg9N1+iLu+v1cLVN/7ZfRjE7mDmiMMSyTeEAvJZ5Ay5XzRSkpB
 JJkVQy33XfJ6WfFKltuNoHQPopu5yNOc1tTeSDK46vevRt+zLQvdZZprsMyZoN23
 o055CQVNvA/wcgAWya/zPxec03txufg5f7HsW6qaz0+NeFlTmwl7zrceQIyRVElJ
 Z6ik6qhctzNWcjVoQvPaO/uoy7CkI295BzR11wg9MoHu+PCN8H5ywPgtMYaX7ecq
 +q7ejS5Ifr/ODmtKLrD/bqLsKvIyoDZ8JYeSF1/egRAkJwtnZSAVrRpg0sIHpZGw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycsbcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 18:59:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UIuGGk028824;
 Thu, 30 Jul 2026 18:59:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ycdyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 18:59:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UIxKVc29688350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 18:59:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2E9B58056;
 Thu, 30 Jul 2026 18:59:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1936A5805A;
 Thu, 30 Jul 2026 18:59:20 +0000 (GMT)
Received: from [9.61.159.90] (unknown [9.61.159.90])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 18:59:20 +0000 (GMT)
Message-ID: <43521ee6-6fa1-48ae-a72f-94e304bfe3fb@linux.ibm.com>
Date: Thu, 30 Jul 2026 14:59:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/s390x: Allow 2G hugepages guest backing
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, mhartmay@linux.ibm.com,
 david@kernel.org, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, cohuck@redhat.com
References: <20260729163043.843517-1-imbrenda@linux.ibm.com>
 <20260729163043.843517-2-imbrenda@linux.ibm.com>
 <d186d6e1-a820-490e-b616-2ac521d3a20e@linux.ibm.com>
 <20260730142001.760e057c@p-imbrenda>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260730142001.760e057c@p-imbrenda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 23GS-o-Dn68Lmtp3Ah64wFc2b0e-x9fA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzOCBTYWx0ZWRfX6hlqyjwX1GB1
 Lcs4mMGfCAfmBfACjLNxxTaa0TfB8eqZvWPOs85iyDf1GfESFns1uBKqYVB/+i3z1DT5UFGj9tl
 hd8JyGbC2Pv7I7VieCG7iaDkPd9E9iHw1biyrq6ynQEyvF/7R/kf47Eu2GOfn8dQKyOrA7CAaDO
 6/0GsakkovldnGnhkTXgL5LUzuccycSEpsXHsLDyBSsfUCjFMu+wNBYs+jteF+eQpqTy8Drjqe7
 uOIlLyo4SUra5v5djGK0EpUYGr0TtudsDqEj6JxgHgnXE9Sla2vBw/e+blGxZpj3Dv4/S6PDt4J
 CgBtK/ZFwbOwRlCB2tAbmkPI4NnsiPvPo8W918hyh2lbKNS6U8mwd93V7XFNLWVGXY9c5sfQKpt
 4zRvcsopxZBPD5gUuTkyJn7w2/wTujaN4+tjJUWdWv6qlJrCTi2EC2jXeZ8HL3fUm7hJH+uoLDR
 8kOWVbi/hHgVXReudWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzOCBTYWx0ZWRfX8kIcNgLZGowo
 y3eoE3qCQPnpbG+vfYEiAog2aBMVi0aC4Ofn1XL+ce7Ahcot/YoGQgBhrMNml0abHVwWF0BNWu7
 Njk8MfYsMVua3ZdbLNK9S8OQx9FgypE=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b9f0a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6okmgAcxrwbUnMCulR8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 23GS-o-Dn68Lmtp3Ah64wFc2b0e-x9fA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300138
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


>>
>> Do you have planned future patches that you are confident will soon make
>> use of these get_hpage_1m() and get_hpage_2g() helpers?
> 
> yes, which is why I put them there :)
>
OK, I won't ask for a respin if you're planning to use them soon.

Thanks!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

