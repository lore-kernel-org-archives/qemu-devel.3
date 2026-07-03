Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEACFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhTK-000554-Pg; Fri, 03 Jul 2026 13:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhTJ-00054O-2D; Fri, 03 Jul 2026 13:14:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhTH-00015T-ES; Fri, 03 Jul 2026 13:14:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIxTk3246496; Fri, 3 Jul 2026 17:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7geKnB
 aK4d3tGjto7U7G/URbCf1iGpnLJ+VZ+bfKjTc=; b=fGz+r0aboxtHquHhenToZd
 eFPEwiYu1DlctQlGmpUYe8gyQSvq9bXKCCA4ZpEnS49FuCeFcizESytYmtJ7UvA5
 tt4eQ/LZOz3Slb8+R9QEPE8qBWu6mA+3bYG7LdEFPAGqxuLcMkTzRdNaXN8I06Iz
 nq3Xrk7y5jaKAVSTlmQ6fmUv26QittB2gZhA5GozJGq6zq3Nirq4PAsPJwACs1Gp
 DEQJnLExViokLu7QSY9Af0r6mvfsqiBERO4S6toi/RoMh8zjahQBzNuDRpAqEgD+
 CgZUBbdUnWxFeWgNwbzRNKVyUjxz11cPsfc3mYxGst1M0whQE2jnvQ5vGffHDu5Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qafu7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:14:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663H4dvM004691;
 Fri, 3 Jul 2026 17:14:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqt13g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:14:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663HETWo30474752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:14:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E6B55804E;
 Fri,  3 Jul 2026 17:14:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 743345803F;
 Fri,  3 Jul 2026 17:14:27 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:14:27 +0000 (GMT)
Message-ID: <22717672-1ea4-415a-8176-442ba4191ed2@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:14:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 25/33] s390x: Guest support for Secure-IPL Code
 Loading Attributes Facility (SCLAF)
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-26-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260703170032.1893204-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX4r9+qAO2QVUR
 Wy7bUQ6jBxC/yf/2mFI8pZcYp6LoifJWgzcH3QZI47RPTXC+46+kvmA/sOQEn5eqFF6mMYSSffh
 NvonMqxMAECBLOmbjmbNbsJhpqXGoE2RF7zNw+mzQpYcg+niJdgTvLo9ruoNK9lfo56+lQfWdAH
 JPpHpasc8Kx6p5yUYT6NBOeGim+6zRjiqPpekMhg1+GLBrB7YemGDpnkPE3xNeNmO6hqYzmjMTb
 /nqe+lUiCs7XI90IvnXJyuBmIAN98EEqMnixtrAjJe7hWp19rdJ5e0Rfh8GyuwhMJAL8sVxvDDl
 9dkykarwayDmlI3MPk38eFGepA+a+qnGyUBXTlkxe6dmV+nXFzPhexSAAC8B2DOZ/8BMhRrlVTU
 v24qtwsUlIhMlYkPJu9fAZNItlNJdXD01VtTyuX6rAC7b7xR2h5Wa3A1nzLM9HZm76w26TkLTsw
 ufW6BZ3GM/qMlf1J/ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX6JxZsmo2gF9Y
 vG2R1MAFGY9wqN9Nmjq76qbCDfvReLqwHzGWtgA0wf4iftoPFSV0bpkL2da/CPiQmc/CNZkcSmX
 /q9QoMkwSL5hRm3vr0u6P1MLTMOJAGg=
X-Proofpoint-GUID: NGuZ7a7kxe45xXA-7cLGIAH_6LmigwS0
X-Proofpoint-ORIG-GUID: NGuZ7a7kxe45xXA-7cLGIAH_6LmigwS0
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47edf7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_qA_cWUWTuH2iE62fMgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030167
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

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> The secure-IPL-code-loading-attributes facility (z)
> provides additional security during secure IPL.
> 
> Availability of SCLAF is determined by byte 136 bit 3 of the
> SCLP Read Info block.

SCLP Read SCP Info

> 
> This feature is available starting with the gen16 CPU model.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




