Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB079FC035D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFw8l-0003hb-UZ; Thu, 23 Apr 2026 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFw8d-0003eA-Qg; Thu, 23 Apr 2026 11:38:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFw8c-0002VT-9h; Thu, 23 Apr 2026 11:38:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N85u8C3229003; Thu, 23 Apr 2026 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tdZ7cF
 tzGix5RDUyoMKF/Gk+ENS9egF0Pqt+8RGdsQY=; b=fiO7fuvnYIt1gcCIq1a9rp
 QSuNtWffyadK4JWfVws9FOovsBVzJkYasToSB/8PXM2qhCa7kcF/lMQzz1pIp5xW
 fMNi4LxKLj8sO1mugwEiN0zRkzDvRnZA24vP50vyPUUcj3ViGmRNewE0onkGlDSW
 L0MZ8IVkeERxTL1Ux7/8y6VVbawg0G+no6WniXptikyAMg0MRDbOmv/EV0vjWzzG
 PkPBubHfMRVfuaIrE4e8GbW6VZ0qvMnH7LFJEaA9fUTQCt6lUO6OJ2FePb9RkpOx
 t2GlfC1teO9yNidnPWEkxecuz+hlLr3TStOTfHSJaTGvoQAeSNA/9JYlgq5FS4Og
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu29ebt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:38:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NFZRox015204;
 Thu, 23 Apr 2026 15:38:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky7680-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:38:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NFcbjM58851662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:38:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDF892004B;
 Thu, 23 Apr 2026 15:38:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E22E20043;
 Thu, 23 Apr 2026 15:38:37 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:38:37 +0000 (GMT)
Message-ID: <ddb30308-44f2-4118-a188-6e66dce31b7e@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu
 in STFLE opcode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-10-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WrHKxOFTeDEn_nR8o5AEiRFAgKYXoj9-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MyBTYWx0ZWRfXxaICgD2lDIyr
 qu+hyyjuDwuVFevVDse3DPe8RfDXXJehmMktpoyCdckY4+gbnL3lhDZlWv/nG/0sLKd+6SJ3ume
 Hf91GTIV/BpjoeZpav3wPcE+LySdnNAPtKfAisEFnRshGxdW9DY9xlYEdluEkLQxn6fdbWtUCLN
 g4vrOzNFEQSgY9W5at19UAGS9p/MzVRUudE0RagR9s1mJCo118V4G4F6W67rS0wLQEwgoK1V1KM
 oMzZIAt1jMYt1pkyWTRnZEqNpWqkiBeV2VbO/buri/OBjgFvr+vuCMnVBvCJLcVsrz4jpKjKPxf
 DYXl5nGWbtdjgHdmkX1zrMEOHHCcs8nAp+CVnSFFNyFcgVS/w4xURoinHWlhiFXfZZLgXCy9a10
 Mvtgoprhrv4s6Pa/uEAjOxjuG9lVy0LJU5ov5XeBwTCDXUQaFSS0QwPFihGVJoz0Fwvo2s9zxbE
 gtkAI914W0oz3vYB9DQ==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea3d02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=_VyUCC-8DgYtCY3JjGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WrHKxOFTeDEn_nR8o5AEiRFAgKYXoj9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
> In preparation of building misc_helper.c as a common unit, update
> the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one and replace
> "accel/tcg/cpu-ldst.h" by "accel/tcg/cpu-ldst-common.h".
>
> For now we are blocked by the CONFIG_DEVICES use so keep the file
> in s390x_ss[].
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/misc_helper.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

