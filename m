Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D58C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcBm-0001kd-JQ; Tue, 14 Jul 2026 08:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcBk-0001jl-1o; Tue, 14 Jul 2026 08:24:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcBi-0004I3-Gz; Tue, 14 Jul 2026 08:24:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfw8g1195038; Tue, 14 Jul 2026 12:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PAn9Td
 5BwZ35p3wpwvjx7zPLmEJRjVV09LdreRzigrs=; b=TM+FxWaZUpPxbwF40bZzob
 vCB+V/v+Z/Nr9x5/KoX2Av6rCX1wiWo8WI+W7U63bHi5s3nlXulDZFFObjkwhlbt
 GPIJMs9dDDUqkN8TJQKtfUwKjO1d7mydjJbc4sWActd9TIF9P6nQ6AFMG9wpGyAl
 lh+fVLc610x5ZyWE257zs6hfkCUjSHV4u0XDQHmNelPhKZdRBeaJFRyvIwq66iQ7
 S9KrjSJwnopOM6D53WrrdPizI3zfI4BNtrrwA8lr1GMvim+/2PDovA/EBTT7BjW2
 DqV/NigC1osyf/bNzf1+/n/2CbKs3WNksb5cahNKrvCKv0Bp7pDLExLkgLFvNxIg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbnm2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:24:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECJiLO011115;
 Tue, 14 Jul 2026 12:24:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgag9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:24:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECOWD762456128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:24:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A5C220043;
 Tue, 14 Jul 2026 12:24:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 624CB20040;
 Tue, 14 Jul 2026 12:24:32 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:24:32 +0000 (GMT)
Message-ID: <f63144de-b3e9-4752-8110-14e1efb14fd7@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/51] exec/breakpoint: Add CPUBreakpoint.id
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a562a83 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=Bs_vCHwtGeDls6627E8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfXwmdN94Dkc9qE
 +Ad/BJB3z0OFB3M7R4LHRydBkcIB7gebmEpO0vFTo/yOtzDjZS8JB8UsgMk5FjjnEbAPR2/guoN
 VKX7kdyZDwyDXpopujxwsjfqGeO02hLUIvkfuUIXJyfBbtxwOocIxXOyYTL+aQKVO/A5eiYSF7Q
 xcRhimNuWruYOOFP0hm0OmoA139TYs/CH5gj36F5uu/lnDzVSuwqxbgOUFyYSs07NDz+9ueKEvc
 eMr+RwNw4EIAH9G94w9nuUxp4z1LJp2c/RLd4Vm0ND0/BZtzxH91P4NwhcvqQWyNI7GQjBP/jmw
 cDBrWQV3YPZcazaNLn/9LeDhuZOQR9vEK/QnGyiLpSnXZGfoPjpMy+kwbxyvOnKEKDnLi8lFtZE
 If+b83WXShGyUQPIhMfcqF8M3LlruRW/QP1iUyX1o6anwFJpAzMDv7tqi/5uz+ShQWOeUDFdCVH
 m5QSVK7921P2A5heyIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfXwyV7C2Tr55S6
 OwAuop5A0p/ezcnsxaBNTca66eIFWMi1TDEkM26YN6Qx4UBA8lSZeJ9cdoAI+K9zKR4bP7CdDMt
 qy+LlV0qEAXHJqmBRyzvx23AX02p+AE=
X-Proofpoint-GUID: UyiUUfxNdLlAoYOZuwdmWmRf-qqPl1iG
X-Proofpoint-ORIG-GUID: 72uItAVi1DbkKGAu7GT962278mcby9eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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



On 7/10/26 22:53, Richard Henderson wrote:
> Add an identifier for use by targets with BP_CPU.  For all targets
> the index of the hardware breakpoint resource is to hand.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           | 3 ++-
>   accel/tcg/tcg-accel-ops.c           | 2 +-
>   cpu-common.c                        | 3 ++-
>   gdbstub/user.c                      | 2 +-
>   linux-user/main.c                   | 2 +-
>   target/arm/tcg/debug.c              | 2 +-
>   target/i386/tcg/system/bpt_helper.c | 2 +-
>   target/ppc/cpu.c                    | 2 +-
>   target/riscv/debug.c                | 5 +++--
>   target/xtensa/dbg_helper.c          | 4 ++--
>   10 files changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

