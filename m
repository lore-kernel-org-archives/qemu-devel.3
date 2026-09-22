Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE0C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x987g-0006FV-LV; Tue, 22 Sep 2026 17:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x987Q-00062i-5I; Tue, 22 Sep 2026 17:33:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x987M-0007HP-Pd; Tue, 22 Sep 2026 17:33:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI6wfe1128975; Tue, 22 Sep 2026 21:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9wCMBL
 Ag99MbEvUj2D+/Aabz2ob48NgWiY8fdYYtmp4=; b=H1vJDdqc4AbmY04zUQjq1A
 3b25ymgFtidqF8GcM1mE/LpYvbrVkPB/u2T0IAsv9AJXaJvR8ymMs8ukPnn85+iN
 8yhymtrvl/nRF7IfdJjgX32mkuAoUDEFwEU8trINbFr2iP26lOMQdjZaFG7Q3csG
 w3TDeqQXMF9rjqzFDShPPrkNzewKbsWWIgXM6dIBtac0+ru0Uc5vR+8v/R3jMmgM
 LYwgphiSRN0WKm108xokFXieDnwIE2u2EuvC45sYDImQcdRIg6rJIa7is8BzMOXQ
 kNq4bzMpZMImjCtStkQHnYpnL8M9Q2bleIFV4fnNNHk8fx07GOSy7V+AS7hFYDAg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2g3j8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:33:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHVxn4187949; Tue, 22 Sep 2026 21:33:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dybbvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:33:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MLXPuf11862774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 21:33:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3593F58043;
 Tue, 22 Sep 2026 21:33:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D1E358059;
 Tue, 22 Sep 2026 21:33:24 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 21:33:24 +0000 (GMT)
Message-ID: <0ec1ff23-83f4-4572-974a-076d7fc6673c@linux.ibm.com>
Date: Tue, 22 Sep 2026 17:33:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] s390x: Add support for virtio-net-pci boot device
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260914193438.526407-1-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5XUkPU-WM3SMCGD81L5XQnNA1vzM5sfK
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2f426 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=3_Y_IZP_7ghLNEfHf6oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NyBTYWx0ZWRfX/BUrmiYsqeLf
 xVduMwKxXXFEeBCGydsVHix3G9xr/jgXRzHGkiy8kpoZcOI9njB6S/scwq8gRUV/yCjuHbBR9t7
 EsfJnhweUBEEqcPnaP09ZsiN2tFHc799oCyxynfGXM2e7cPrnoldLT93UPN0oqSUpNkZu2+uwTN
 f6F5GU25Is0FbA5KbGM4oaLtPQXR52e5ZULasxqRJ/XEzbnNclQnXuN76eTXE8qiXRUcMuB+uNq
 HbhZmiN2ti1WByl3c3smeU4q1b1ZVhPyUkKPIv0SZOQDu40tax3YTS3jfpDzjlsgf+yE36eHv9A
 cNyFgKxLkG4XRDhizZ1jnSXUD97ZLCa3aYWW+aoIuotYZa33qqY+q8KJ+UBNXq6AuNWki0Lv9t/
 k3XHZCMEaY4Mtpf7GPTJ9EIcr7tx743MBDwv6wFy004XeKwi3gQ3Vtt/1jBhkkHQD2mNw8TKhTU
 drjgPJJ02TSRBcARwBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NyBTYWx0ZWRfXy/vOmho8dOvF
 TQpix/cVo827VIacHtI2LQh3f2wSn5jNbEhuMvbR37Au8t4tvKJycaUM9Pk4G+2k4EkmSgeLUq6
 eaGnj98bAwtFcGRPWx1tXYF+ZAeQHDI=
X-Proofpoint-GUID: 5XUkPU-WM3SMCGD81L5XQnNA1vzM5sfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220297
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

On 9/14/26 3:34 PM, Zhuoying Cai wrote:
> changelog v2->v3

FYI, this will need a respin to handle merge conflicts I'm getting
against master.  I didn't investigate, but I assume it's due to Jared's
virtio-scsi-pci series merging.


