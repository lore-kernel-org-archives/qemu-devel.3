Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB11C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lZW-00049I-0Z; Wed, 23 Apr 2025 21:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1u7lZP-000479-4m; Wed, 23 Apr 2025 21:40:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1u7lZK-000160-Gm; Wed, 23 Apr 2025 21:40:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGsASv024462;
 Thu, 24 Apr 2025 01:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=j4JsxA
 ffBu0RszYAfx0kwyslAKZQnkt6QG2eR/FNy64=; b=aRHXvj1kQIe3dTDnaPfplH
 TfPExO6G9lOrlJRIW8Ha+BeQkfF2PWRFUThPGx/+vPFy9MFZkaOXWwY+gbE/FlqO
 1QJzdi4fF5fOwyRs1edFNvI86fEna3XLOv7NU6aBJQCrJ9/NkFlkqqc4QPljwPOT
 9PJ4mwICeTXo+TVXm3b9HRdh5/Y7gSoVANMghA/MNQiatrMxYbHKocU3jCac/lPq
 Lupn1uV8oT45HON1yACYYzZnmSrtm4b/bgCpU6naZ62R0EkcoJOfTyWD0SGpc2J0
 GVrd0DreemiWwO+AGq1n3UAVu9bXUI8IDfCol7DPoPW9Y3R1l9FE6Pug5Bopn85g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4jv15h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 01:39:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NMRUv2008601;
 Thu, 24 Apr 2025 01:39:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxp09s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 01:39:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53O1dum825690612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 01:39:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AA9258058;
 Thu, 24 Apr 2025 01:39:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26D4058057;
 Thu, 24 Apr 2025 01:39:55 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.182.41]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Apr 2025 01:39:55 +0000 (GMT)
Message-ID: <3c215d78c44fb3b0572b2e8c67e3826aef8d8b0b.camel@linux.ibm.com>
Subject: Re: [PATCH v6 6/7] linux-header: update-linux-header script changes
From: Eric Farman <farman@linux.ibm.com>
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
In-Reply-To: <20250423214506.72728-7-rreyes@linux.ibm.com>
References: <20250423214506.72728-1-rreyes@linux.ibm.com>
 <20250423214506.72728-7-rreyes@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 21:04:07 -0400
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=6809966e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=V2FlQnaG_eUonHtXfN4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZXOySPnjGwz2zPKKa_Yh1NQq66nEKGV3
X-Proofpoint-ORIG-GUID: ZXOySPnjGwz2zPKKa_Yh1NQq66nEKGV3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwOCBTYWx0ZWRfX4K2EcU0SqBRN
 sq9mrOCxK8XnXNJ3D7f7Jf/ok6515d+xpdWVodYkJ9Dckd/T62FocNsRpviCudX4SVwAI/6qHo9
 pGnA65Tz4xRi0of5cjWGG2B9OP/85OQqYoYJTHGW15dfaFLPIwjGib/BewKnQ4ay7a7hd/tFBZE
 h3mYibFbOJdsIhzF2VUvErxanq9ovQewocgMOpHKLhcP01vr8WMFp+xw8J9rWTrzxD4s4s6fp62
 nbIr8gkJsS4Dc2yeBa+slsFeur78or8U41KPl8toqAjALPczlqN5IS5ILwKjhSaLMlHiR1Ak5HZ
 2bu1kS0ZYWiIZIeNuxzm/BExZtkzswYFohcV7vzgLqFR4xRqyPfRFIRLAP077PDB7Bo9XeFLExA
 jWUyHXO0c+IL+tPl4W/zupqgbZCRQdIBqoNpo8kU1m5/gNSeUUZ+TEV4ovLQp6CGr410a8VP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=975 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240008
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2025-04-23 at 17:45 -0400, Rorie Reyes wrote:
> Kernel commit 8a14 changed from using ASSEMBLY to ASSEMBLER

Kernel commit 8a141be3233a ("x86/headers: Replace __ASSEMBLY__ with __ASSEM=
BLER__ in UAPI headers")

> Updated the update-linux-header script to match
>=20
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
> index 8913e4fb99..b43b8ef75a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -177,7 +177,7 @@ EOF
> =20
>          # Remove everything except the macros from bootparam.h avoiding =
the
>          # unnecessary import of several video/ist/etc headers
> -        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
> +        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
>                 "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
>          cp_portable "$hdrdir/bootparam.h" \
>                      "$output/include/standard-headers/asm-$arch"


