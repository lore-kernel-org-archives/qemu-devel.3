Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8D5CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTed-0002Gr-Jb; Mon, 11 May 2026 12:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMTeb-0002D3-F2; Mon, 11 May 2026 12:38:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMTeZ-0007OI-TS; Mon, 11 May 2026 12:38:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9S2CZ2762269; Mon, 11 May 2026 16:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WLLmSO
 gOzJpLSIxAUeE45epgsX9dm4YlBfLjSgPnIgo=; b=bWbEL7BTjFrjnSvY54nm7y
 ap1yuOFVTHXMGjyQlIQwEAcbtWApbVhUoAT9egbWqiVEegvBFJ3VwxZOWKPqE6Br
 2fj3NumsaHh69S45kyGUUCWi9W1TWr5grSuDCq40Y1XNLSyoiyIWAYIenZPctcNQ
 7CStJN9hsoCnHew60lXQiwbMX6JGQx3ApFBlSvtlqRhYs2tI1c/qX6kTVqzCCW6x
 K3bV0xqqQyp297ukB0VESY7WKjzYOiQrCOAqRGFmeTswVJNykINVEV4G7d/Xj2Ms
 Bzrga6OL8ewwyjJqUJZmmt8mLD+iG0LyuYILeuqMui8vH7GNtHgscmDCfe1y++FQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqs893-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 16:38:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BGOf73003657;
 Mon, 11 May 2026 16:38:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5xtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 16:38:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BGcgJQ18285266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 16:38:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A3CA5805E;
 Mon, 11 May 2026 16:38:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F7D75805A;
 Mon, 11 May 2026 16:38:41 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 16:38:41 +0000 (GMT)
Message-ID: <483e53a094086ef25c9a7532e3477e0cd4000524.camel@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: add gen-features.h dependency to
 s390x_system_ss
From: Eric Farman <farman@linux.ibm.com>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Date: Mon, 11 May 2026 12:38:41 -0400
In-Reply-To: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
References: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3OCBTYWx0ZWRfX94vVtObgn9sQ
 anbR6CFduRBB56FhAM9vRkc3Y06YlbUh+WN5WzgVHGZLl1otZcTnmM5y3v6jFh/wuy5ODbNdWJO
 aykBbSUnJMSaT2vJrdo4YjV632R4mMdkTRW6qWm7JPqI2bDOmtp/BWWNIFnWUsVz4OAwxfrXd9X
 PpRZwhvjzvtvFyljJh/ETczkXlPqx76ZpnbUv6fQbYfCkj5amW81BweXdpZ2ldM/GQCYHmYH5ie
 o9D/hXTAG3jiLWf4O3u2Skg/RsXqpKJgYm/pTOzISUfUmFgOe0mSAhbYSR22tkLzfCmSVXbQxTl
 xR+jR3O5bv6iOvgyI8f4PND5ABulGUJ6RHA0/C+IfgcOoa2ihjsLiicLuIT2/GlN1uYTMs/a+RS
 4est+aNAFCy448ui6zPjp3UI2zz/N6hXS6vEzNi7k6rhfxmjFicR06OKEiM4tGEqB1tRHsENJ8c
 tOImPah3kSluPQEi0mQ==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a020613 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=VgQHmgxU-P_RjVidJewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fXDiH3eFxCZPINEsPWdVrTa9GrQqNDVv
X-Proofpoint-GUID: fXDiH3eFxCZPINEsPWdVrTa9GrQqNDVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Mon, 2026-05-11 at 00:46 +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Commit 0b83acf2f05 moved gen_features_h from s390x_ss to
> s390x_common_ss. However s390x_system_ss (containing ioinst.c) was left
> without the dependency, causing a build race: it can be compiled before
> gen-features.h is generated (via cpu.h -> cpu_models.h -> cpu_features.h
> -> gen-features.h)
>=20
> Add gen_features_h to s390x_system_ss to correct the build ordering.
>=20
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson sou=
rce set")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  target/s390x/meson.build | 1 +
>  1 file changed, 1 insertion(+)

Hardly an expert on meson, but seems correct to my brain. Thank you!

Acked-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> index 44f58ac2919..bc4459e8ed7 100644
> --- a/target/s390x/meson.build
> +++ b/target/s390x/meson.build
> @@ -26,6 +26,7 @@ s390x_common_ss.add(files(
>    'gdbstub.c',
>  ))
> =20
> +s390x_system_ss.add(gen_features_h)
>  s390x_system_ss.add(files(
>    'ioinst.c',
>  ))

