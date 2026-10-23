Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01264606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVzfjusG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGV9-0004P3-V6; Fri, 23 Oct 2026 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xKGV8-0004On-Cv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:44:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xKGV6-000118-Ko
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:44:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE67Tv1955066; Fri, 23 Oct 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9yzFlSYTZbtUZDQ9rChAa2zoHMmc3pd23X1lwfj8Uqo=; b=UVzfjusG7kXaYm0L
 wl13BPwZfCKf6WhsmJyLWHMQexA6Lzrl8nADPNPssT3KLY778gMmlLM6ZdQ9i4rR
 T+lwNM9UMoukWIwW3J8i0qpZa/B4r9RrdmhQxVmLoW/LjpTIrjgrcCwKXMjKSLbq
 g/NqQnSaLMkCg9PY9RXTwKc7NPr72kiaPR44uquaiGwhmRKNq4UqM23WPJfRWF+z
 KmVnN2IG3/TV6aT7b3P679DYcxHxwjHZZuWL267ZDYQ7e0iVuG8PWfYcDmsZLUoB
 uYE0SPupXLeZawXZtRAsR6M/koBX/ZxB9rhixeAUp53M7YVDBO/+hGZqrQ4VWKC+
 y3S2Hw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbm68g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 14:44:05 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEi4VR2083107; Fri, 23 Oct 2026 14:44:04 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69NEi4uI2083088
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 14:44:04 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 1E7D224F47; Fri, 23 Oct 2026 07:44:04 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: philmd@oss.qualcomm.com
Cc: anjo@rev.ng, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, qemu-devel@nongnu.org,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: Re: [PATCH] target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
 again
Date: Fri, 23 Oct 2026 07:43:45 -0700
Message-ID: <20261023144347.2612020-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023135336.49641-1-philmd@oss.qualcomm.com>
References: <20261023135336.49641-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX6+/Mdwui/9Jg
 O8Zg6GHjR1HE0ODyLcpcGcAgWvaXbZ7gmNZtfyz3eBDwScPu1DscxWfM0Q1xsk99QZ3/zy9cF+M
 ZZj8cJknjys1KIw7ktwB3EqGqna4FqU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX0584srkz6A/O
 e9NR/dQsZGe4Zp6KHdbcxRiBaefvllxViKIcwsd903TQZncczwVoBOOjY68q3zSOdv6Y5VGV0jN
 y5fBrBNTm07RGAEmhjR2AQ3REDqkeDEKr8gCIsFEL3auFDOVWrFmUn4YhODq4wEdvpfdzZU+/C3
 nTs3uD4QWZ/Hx4db4SRwyrciDi6VaQrJk85a1/06SVisoaNQek2sh/mar01fGp/Y33nFLRRy12S
 D1lSs4XEdvWvCxMlphBdWgonYeD01h/liK9JSKih362UjU3Jii+E99ukG1UasY6CadG59jgLYQW
 cvUrQRBPYXFh+6XRTOq2zPiJYmJpOqmIqgEU5jpR+EgGGPMXSOMELx1M8aTi1xHg4oDqHJT8nFQ
 tI+JUe8h2IhMvcEuBI38pb3MCQ24QCSPDG7sCvby57SgBwwzXC6HfUUnICuq9w3LgbxmikYG84y
 ws1Or6ogvzwUBEL+53Q==
X-Proofpoint-ORIG-GUID: QfhUE6zmG07A6Qa4lyFBPZ-KKe5l__E9
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb72b5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xJuQ3fhy1iH7nEeUtH8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QfhUE6zmG07A6Qa4lyFBPZ-KKe5l__E9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 8:53 AM, Philippe Mathieu-Daudé wrote:
> Commit 780fbbef2a2 ("target/hexagon: gdbstub - Add sys reg
> support") re-introduced calls to gdb_get_regl(). Since
> Hexagon target is only built as 32-bit, replace them again
> by gdb_get_reg32(), similarly to commit previous 7831e5f48d2
> ("target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/hexagon/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

