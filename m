Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8457810F2871
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 22:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6FO6-0001h1-Tq; Fri, 27 Mar 2026 18:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w6FO4-0001gl-TW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 18:10:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w6FO2-0005qr-VQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 18:10:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RIUWee618716; Fri, 27 Mar 2026 22:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/wJPbV
 BDEUYAnXdKee4qWfNXaWTpfPRboDZyMRnzCC8=; b=Bv4WQF0Y77IuBet261kZfJ
 VIdEG8KhKL9qON02IAl4QAT86cFbLotsW1rRpxJdTqhE0gd/x2Zb4qH//csFkDyD
 rg1PgR9NUNoiQghcae7UtGhnra5Ii8pxabgsfVb2v/FMweKp6dtL7EXpBSOzdjkK
 vMWNMt0hlJCdHqhmaXPflwiB4P88+f3KBHIlae6wS0EdMAo7RLV6tJUzVVEp/yHB
 BN1CustBmyWL1To9fNf/uRzDAJUGcryAyrtCmpJ49b8Gr2nim/tspRynAv+ocVz+
 qi0EaxUw3DIPkY4S+urlCtd3Dr8LID1dYG/4MZRF8TkHdjDLibsW1sO8y5WaYcgA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktyc8u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 22:10:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RKLJEh026771;
 Fri, 27 Mar 2026 22:10:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m99b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 22:10:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RMAQPF17760800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 22:10:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FDCB58055;
 Fri, 27 Mar 2026 22:10:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB2A65804B;
 Fri, 27 Mar 2026 22:10:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 22:10:24 +0000 (GMT)
Message-ID: <eea8ab21-3a18-4e42-975a-1f10cd87dd26@linux.ibm.com>
Date: Fri, 27 Mar 2026 18:10:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 5/7] test/qtest: Add test for tpm crb chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-6-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260319135316.37412-6-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c70055 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=T7SggTvxNyVUhjXzc_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE1MyBTYWx0ZWRfXw8Bfo0bhV46+
 63+w7nz7MMYFbkx0wTEUWnHRsmpqf+MTq1HoU/pUnJ+A0ryz8DDUGPmgnYhX2QXMVVi8dMpp776
 kJo2kVvbcXHGRhlLX48ILw4jFXCOcbbr4NCYc7hiLgaPLRXDKjm7i+wMJ+4ZP1U2dbgNcyubtpG
 U2bDckdJ6JHjs82K616L4vbh/2pS3nhI0P/B8+y0m3xyCTobBEuadYcr+Yzj15Ttmcu7+aLTAAW
 JNEG4sWspaxc2eKBwepr5yrX0lWZopsOWZqqUqbziwXoUe+3FvWjaYX9Q1jlMul3BsSru9gwJLz
 FT3apEQ4q+6p3pTrrHuAsuZcC93tSWKVTzO3qAijjEYXIzmlcF/N9Hllbatp//RW/eTyG+0zz4F
 sJE88vTPYLp0aCJ5nlbsD5rAoubhYYYj0o2k76vXmFqZNKYlo75IMFLtnaAvuzKmJSpT9CQVRAT
 GWrZMYQZgzIhiNFDxOQ==
X-Proofpoint-GUID: EsMNgozjWNkA4_wgA3vXmJMsVAdb6HAk
X-Proofpoint-ORIG-GUID: CQyg8TtkBmc-n9WzTIyUU-SZsmXaUbje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 3/19/26 9:53 AM, Arun Menon wrote:
> - New test case added to the swtpm test. Data is written and read from
>    the buffer in chunks.
> - The chunk size is dynamically calculated by reading the
>    CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
> - Add a helper function tpm_wait_till_bit_clear()
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>

FYI: Based on this test here I have now created two more patches that:
- allow starting swtpm with a profile
- extends your test case to check whether default-v2 profile (with 
ML-DSA support) is available
- creates an ML-DSA-87 key
- WIP: the test case will have to do a signing operation with the key to 
receive the >4k signature; I don't have a tool yet to create the 
necessary command byte stream(s), so this is work-in-progress

https://github.com/stefanberger/qemu-tpm/commits/crb-chunking/


