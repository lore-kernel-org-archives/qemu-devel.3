Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA2CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsGX-0008U9-7q; Tue, 09 Jun 2026 04:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wWsGU-0008T9-DD; Tue, 09 Jun 2026 04:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wWsGS-0005QY-NY; Tue, 09 Jun 2026 04:56:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658JdcUp1477263; Tue, 9 Jun 2026 08:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pvioF3
 B4gf9ox43aB4nnxCRNsuhYE1cTA6H8Vp/i7Y4=; b=HpaJhumbzruDxPAhNvcWwt
 9ZS2DdQjW+MytbUWIC+cRZ36rTaw1DnfW88NyRDVAfW/Mpe2DqXmIgmZozII7Qkh
 7c2K8XIzY9u80TLBNqtvZ1oJ4EgmeJEN/r5C5eMa3ZM5kwQ9ECXlBJkOE44bjOrh
 ZX3YG9QKaFN9XSMKx6J75AoNBXPKp6pFRdgJir57NDErzXb5MbCDewhbLkuaouES
 qfhls2Kj8Ymii0WBpoVutMDc3v9fztiqIookgSE2CjOpKOSfEdRv5hptLuk0WjGo
 /mcoAfwar+JWhS6Z6q1qaYrEuCwLqXjaq5uF0lAlaRTtn/m7GvjOJncHfYIhOBAQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qk9ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:56:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6598naja011699;
 Tue, 9 Jun 2026 08:56:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq1cuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:56:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6598uj2s62456154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 08:56:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F405620049;
 Tue,  9 Jun 2026 08:56:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66B5520040;
 Tue,  9 Jun 2026 08:56:43 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 08:56:43 +0000 (GMT)
Message-ID: <6314a0a7-e61f-4d9a-b71b-424359d9bd9f@linux.ibm.com>
Date: Tue, 9 Jun 2026 14:26:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci-host: Split PowerNV PHB5 code from PHB4 files
To: Jishnu Warrier <jishnuvw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20260608093430.2729688-1-jishnuvw@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260608093430.2729688-1-jishnuvw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a27d551 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=S5H2CU4XRNQMYsy40HgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: askha7xyIwxFJXu9K3a1qqurmPfwTGiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OSBTYWx0ZWRfXw6r62HgqMNp+
 gmE3AzuwhhsLUwsxA/qr4ImTwo5ZOoHDRemxL8TIc4air7gaD2gE7FAMbfML5X5MrscPbjh6Qep
 Vj/XkLwGgULMT7v4y5cyrglqfJY4G9NWEIIRUgxStnM4KfYpQLGkdG2DbJPoCoLlqDIMU8d513+
 HLv/ARJZA4Mmjg1OeBuUs6DSSqk1We3KdgT62KvwgZyxRqcN8EcyH2Jp8dF8xrEYt9cTXCDtNSI
 vcPDEe1GV8f55UikTr9Yrp1G/Vj+WVY4slnu8/eykhrLf30X1BaZC4pHycZEue4AIeXpIovQ+us
 jAq+kTyWVV9eak9gGOtl+e3Ur7SFOqLWttJ+NuR965t4rV0XmW+fOkPlwH/GgCSZkwhB/FxEhG2
 gnHa8Z4m2RSSMEFcldinMpVfyLc71xn79QOi5b/XRLaCyHLQFFid8dFAkn6r/f5/gDhkFShYnMT
 O51xNd/XL7fJcJaWzLA==
X-Proofpoint-ORIG-GUID: yK1XGVvomJYp18EQCPvRLtCCFmUzxTW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090079
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

On 08/06/26 15:04, Jishnu Warrier wrote:

> Separate Power10/11 PHB5 implementation from Power9 PHB4 code for
> better maintainability and clarity. This is a pure code movement
> with no functional changes.
>
> Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


