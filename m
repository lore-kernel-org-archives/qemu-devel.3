Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85368C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhje-00039T-Fl; Fri, 03 Jul 2026 13:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhj2-00032H-9c; Fri, 03 Jul 2026 13:30:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhiv-0002L0-Oy; Fri, 03 Jul 2026 13:30:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIoJl3497809; Fri, 3 Jul 2026 17:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N+/BqU
 B+x3mXtQiRU/65ONyL7CzVvP9t4uCqn2u1V/8=; b=qSgOdjRLrKBAxj/imQpgQ9
 FTo8bPK0UrgWeCF9x43DvNpBTZiONcGxfDrTh/fr9fqCgjOnUkJeubnlTrSKy+IL
 R3eHgEzK57baJqtPixb+MGlb2Gl7hnoHM667BHJS+539RT73q6sk/8xOmwcu85Cg
 /JVNtzoJhYnN02Ob5hQcDJrBeCeJtFMu6p7tVOnMy6lO60W5R9mPeDB6HP5ODmfM
 CFO0teZ6WA1F35YqVeiFm1NeFLj/6ZtgdtPTNOS79T3JpsDZ3uDb/aDUUeWzz7fl
 gBPMdtsgRkqY/NcQ2/16mFtx8qa45ocxazUPGvAAI49YRYAn7XW9xFpMCe+qWBfQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgga1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:30:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663HJc0s020051;
 Fri, 3 Jul 2026 17:30:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqt2sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:30:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663HUbm917236480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:30:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE2D58056;
 Fri,  3 Jul 2026 17:30:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 719AD5804E;
 Fri,  3 Jul 2026 17:30:35 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:30:35 +0000 (GMT)
Message-ID: <a1597761-a7bc-4d8f-9f73-20c9b3c5738f@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:30:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/33] hw/s390x/ipl: Handle secure boot with multiple
 boot devices
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-31-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703170032.1893204-31-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a47f1bf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=CesNmBxBNBZouwvHC2QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX3uXUU7OWBiy5
 ydGYfxgJBDBJ2utx74JAIpmP0K89bG7UkqrPG2jjJoePYYX8pumagQx/RC1TNeCqtql2gET3psj
 DKhlO+4ELT4iLI9mW7uEDu7TxMu5/OI=
X-Proofpoint-GUID: gMf1w_St133CmEQxW20klaXAncjB4u4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX1AfWAQIf92mX
 swPc8r8VDKvRWxuaaqpJlBHVI9f56O5cAi/bsAL3J8LZzJGX266aQu/44UfTk38fVo6fNYR9kyM
 u2Wqry2mVYtV4oqcOV8RDvNuN1grNj799jqYe4HLRuMIsBdYBGysRypU0xhTrvCvurXd/oJwgMm
 0GTtbEN7s/2lRmrTzFrO48ONfG+z4V5oL4674FxUJV0QI480TVEPmiIM9CF2GBgueUgapy096pO
 SpPu4yEStCLrW4POmPbPl8calmwfwNxVuix/CpNWXbEAQZbO1BUfemgOX20mD7FgLtR+Z3CUiHK
 4oAY4gsU6Xjpq6Tpg07w4bq++09wcKJkzpvxWXCWNjyZYwy3FRl9okXOA3OOIKYmlOtul/a15dp
 O4jppVSvmxjOXr/8ik8bxA1tRMb5qc3579DCVzW9g6dDXLaUak5DyzovXolqmiD4K4FhSYcngum
 GmPrqU1ovz/FjPF76MQ==
X-Proofpoint-ORIG-GUID: gMf1w_St133CmEQxW20klaXAncjB4u4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
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

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> The current approach to enable secure boot relies on providing
> secure-boot and boot-certs parameters of s390-ccw-virtio machine
> type option, which apply to all boot devices.
> 
> With the possibility of multiple boot devices, secure boot expects all
> provided devices to be supported and eligible (e.g.,
> virtio-blk/virtio-scsi using the SCSI scheme).
> 
> If multiple boot devices are provided and include an unsupported (e.g.,
> ECKD, VFIO) or a non-eligible (e.g., Net) device, the boot process will
> terminate with an error logged to the console.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



