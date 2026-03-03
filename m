Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA6EDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxYMV-0004uI-IL; Tue, 03 Mar 2026 17:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxYMT-0004tc-8v; Tue, 03 Mar 2026 17:37:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxYMR-0001FZ-9D; Tue, 03 Mar 2026 17:37:05 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623FcHH41457437; Tue, 3 Mar 2026 22:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YXmkUx
 1ydd0NPTQ1asEASVTe16ONvghkifweSICXkwc=; b=LDsr7R8HDZwoAsrjfQi6RR
 NhH9Rc8y+/KQffCVr2FtAJCNjHzA7D+RUtbngCjZNPAb7h4naeeRQr3hQSx1yzvp
 FafEPfVNWCMDpzcsg59cjSByBg+otDhpFAW2ooQZivOlBSJ55pdfOgCLbxUtSNxE
 1oGpljyjLV0beEQZhvnBEhnDzqrg68lEo8QECQrzqtz8zmHTozj27YEbIC0M7UiH
 BeJcpbpCOaEQ1guQp6qCOuc/1f3jsTJiekEtwcJXTWmhBDeE8A0zu2FYzfGv+z93
 XjCXO2hpwNlnEe9Ciymedx/bCPrwb8Ik4qgV2IcUfhvHZgf7y4AEuFjTeQOHFpdg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj54vp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 22:36:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623JfmAA008816;
 Tue, 3 Mar 2026 22:36:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1c0hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 22:36:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623MatSY57606438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 22:36:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF7EC58062;
 Tue,  3 Mar 2026 22:36:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B383E58052;
 Tue,  3 Mar 2026 22:36:54 +0000 (GMT)
Received: from [9.61.108.121] (unknown [9.61.108.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 22:36:54 +0000 (GMT)
Message-ID: <5689c615-b93d-4a6b-8bc2-09b5f427a5d8@linux.ibm.com>
Date: Tue, 3 Mar 2026 17:36:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Farhan Ali <alifm@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-21-zycai@linux.ibm.com>
 <e1817c77-6b4e-4c3a-8b9a-d721063a78e3@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <e1817c77-6b4e-4c3a-8b9a-d721063a78e3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a7628a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=JaDBcSuPLdAo1Cb4C_wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE4MiBTYWx0ZWRfX9Emylhom7KYp
 4HjK+TvqWWMs6nnNqAyGwRuGR/bW8vhIPAm3YJ1vIG89hkn6gdvk630V/mdh9ZiSPF6v8+zgTRx
 6jsXLBohD8iEM/TEWMMtgKZL7sLHMPkzOndZobR9gl1tj7f9yXLCoNmK6K1nYTA5dZi97eHzLnK
 xh7NjEwKgn1vO747ZxzSX1CCIavNrxLTNiIwN8dG35/jxLmYhiWzLTKBRQmVlEhrfSt6s/vvYik
 ja/MJErc9jPTAu03OzsctICIw16NnVnHO8rjljyxFa5BkJnifqnc/oR4UoIw7LyuztCVR5KM/lg
 +4V44NNBOYP1z57lWrkQlZ6yN4CcUh6j/Do2WxWDVzHtGcDQr0GGwvHMhXjKfL3qX3NeatsJBnM
 yH4B44OxSzQWJ1T6enbn3JOtzXY7SKR4Sj0M9bhYvai3gJJ9p0JNAq1UZ7kTCu6hXkRaRkBb9bq
 75XocU9JUIWv/b1fcxQ==
X-Proofpoint-GUID: n6lTTazvMY7XUll2xZVwhDJu2lKNn0nJ
X-Proofpoint-ORIG-GUID: n6lTTazvMY7XUll2xZVwhDJu2lKNn0nJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030182
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/3/26 5:07 PM, Farhan Ali wrote:
> 
> On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
>> +static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range,
>> +                            int addr_range_index,
>> +                            uint64_t start_addr, uint64_t end_addr)
>> +{
>> +    /* neither a signed nor an unsigned component can overlap with a signed component */
>> +    for (int i = 0; i < addr_range_index; i++) {
>> +        if ((comp_addr_range[i].start_addr < end_addr &&
>> +            start_addr < comp_addr_range[i].end_addr) &&
>> +            comp_addr_range[i].is_signed) {
>> +            return true;
>> +       }
>> +    }
>> +
>> +    return false;
>> +}
>> +
> 
> Shouldn't we use <= and >= checks? For example if 
> comp_addr_range[i].start_addr == end_addr, wouldn't that be an overlap? 
> and similar for start_addr?
>
> Thanks
> 
> Farhan
> 
>

Please correct me if I’m wrong. My understanding is that the component
address ranges are defined as half-open intervals [start_addr,
end_addr), where end_addr is exclusive. If that is the case, then the <
comparisons are correct — for example, [1, 3) and [3, 5) are adjacent
but not overlapping.






