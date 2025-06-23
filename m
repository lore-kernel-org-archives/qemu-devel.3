Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37F9C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 18:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTlUq-0007Mo-Im; Mon, 23 Jun 2025 14:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1uTlUi-0007Lj-1d; Mon, 23 Jun 2025 14:02:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1uTlUf-0002xC-GT; Mon, 23 Jun 2025 14:02:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NH4Q0j031109;
 Mon, 23 Jun 2025 18:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=71SPC0
 t2u5TWDIV4XZGMn6hq7KZSDZ1p+ZD5uXfIA04=; b=ZqC6TH+fHJWtxREtkWYhsA
 L3ZpGUv+2nJnNeNmAOW7CJ4nb19KFEqx/oVNx0pVdG2MlaJ/TfjooShSQdn8S5MV
 ergCFuANKZiiDLUSQqI6XWXjuT7sq/adtoENhPSLLmDq/XiSN5RcyGaJwpySuEIP
 7bjQXSTSmsgej94ERcUM3ACrDo+Sgdt3BrzfrN+sTACsRDbtw1CKd20SZnXl5h5Z
 5aUX8/X2aOR567pDWJbFNqQIjGWWzwK51drVTKmnHj0BISgfm8bWay2l6pZC5MRL
 sxov6/IVqtpooJXkNYzctzQy6sebuGeUQ6HgQP3iqoogM8VEDgguYRWV4tKZdM8g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j3u9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 18:02:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NEvP7Z004643;
 Mon, 23 Jun 2025 18:02:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kfu8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 18:02:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NI23cF5112386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 18:02:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67D2F58068;
 Mon, 23 Jun 2025 18:02:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C844658052;
 Mon, 23 Jun 2025 18:01:37 +0000 (GMT)
Received: from [9.67.130.131] (unknown [9.67.130.131])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 18:01:36 +0000 (GMT)
Message-ID: <4f5aee63-dd4e-4c17-8a51-d55aaf4603ad@linux.ibm.com>
Date: Mon, 23 Jun 2025 14:01:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewers for some s390 areas
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, alifm@linux.ibm.com, walling@linux.ibm.com,
 jrossi@linux.ibm.com, qemu-devel@nongnu.org, zycai@linux.ibm.com
References: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDExMCBTYWx0ZWRfXwzpFj4AZXbni
 NryI2TssondQxZnj7mNOg83FEErXzkXyy9mgYG1lNKj8zNIH6C/59Kw2MkE45JP1aiQauqm5Sok
 lnzwzobLP6XKC6wyCX+RBBwunFK6GlmXFc3VaE+b+qHKnmAScXfv/9Hwl57nAz63E4OpCtIBv45
 JL8UzehjhRIkM5tkCZfdg+AzkuMft39vpg9vbc2VV4nxr1f+neCNiqfCgG4iW76Fo7roA0rsVYO
 gXXI6nLZKqdsISeJJI9s+d5uaUNcTvkjx3UNsHii78VKkrIBNHSgt1JMbdcxHIQld2d+6fwq69S
 uv8c9AkM+//CXXLcNWJDhLcAxQuFek9CHicMWMjKLeQ4tyyTWgUIUs20KwaPeyjv1VMNRpKYhIN
 rLQJnJy+NCthb+sARsYnY005okAL5sj1eqVsimTq0VGEYiALD0Gg30rK+zotG31x1+4B4yEE
X-Proofpoint-GUID: JdrEarnnqK6dejXfZpvo3-7_UE8OdMO3
X-Proofpoint-ORIG-GUID: JdrEarnnqK6dejXfZpvo3-7_UE8OdMO3
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=6859969e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=P6P1AYF0Jep5QJ96Kr0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=942 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/23/25 12:00 PM, Matthew Rosato wrote:
> To improve review coverage, assign additional people as reviewers for
> multiple s390 sections.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Acked-by: Jason J. Herne <jjherne@linux.ibm.com>

