Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92368606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P/cUjo77;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hxYqMp/L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4SU-0004Ee-G1; Thu, 22 Oct 2026 21:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rg-00024k-BX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Re-0006Ot-MA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FSMR428565
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=; b=P/cUjo77DkiZHlg2
 1kjpBkAm1Hq26TgUxWi1o1ZgL5yw/e3SfVssZHpgp28AlUQEjoySs3sw9Pdsie5D
 kwnFwEdEi9qfvF2HqoLyQWcYuwbIl3/Zb+iAOBVifeNyIDrNuIab2Cl+IGtwJbaS
 UXpsukvSQZtYuf9P7kBQkMzcnLijEiAZBdIBcIaGQqcnf9Iasy198u1Ibza19cw8
 WqhyO/SM1DQ4CEJj/WwA0uoth8DcC/oG0LOdNjSHZRxiVWb4888KZIAfGzjSvVDH
 o9riJc7LhSut6nDgrbwixODmJbwls9yJfJuriLn0Lv69uICYToyDqk8S2O6cIEg9
 zoVbDA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms1b8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3698bd5392cso305093eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720295; x=1793325095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=hxYqMp/LZH1Zc6jPg+tU8COcX4tPsGuxrxCD7LZfB6nLke8iMTQTZS8cfncXOCRg+X
 iWpYA67cOv4BGXyzmeihzgV0YZdOwUa5IlIoO50+xnBGI9wWmMfR6K+Z9rmLdXo7lDMk
 S9CEtBt79ARAsrdyBm184IEPQlEhAxPSZTlZ4JPvX+9ZgdlWNAZjBnC6w9Sn8/I90T0E
 K7ZBXtL5c0uUZLGWit1xP0cKxyX1zM1EG1n/tRPC6AXfk+vB9N2m5PFo1x/x4l364IgX
 eJazxnbpLzep74+vZHTrJ1+ceav6rBrZvYX7GxCuUV6GpGqapXhj9eu3EKRpBlvBgn/h
 eiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720295; x=1793325095;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=hHnIbhWI/+0vfuaEylUI00k7SAHYfx2TNwukD4GxwKFb8V43xiJbPrdQBGZvwBDNNk
 hKM/ATjUb2fDmO6c8bZCx8nwfJaXTiEhjGcoCkolv+8A7K/AJGnRq0RAjFNstdrfq82L
 kf0d00kl3L/0AWcbN4W/KAQHEo6LbXN+5PSndxZkFpAwPvJh/+Z90yqiBQr3ck3XRopI
 SGEO4jKWCkKt8tfBYBFC6hkclJqiFLgOFfKdoZmEtzKArMFSe5EfljV6Aa+/TgUemwFf
 GxG6QnHau6+Fic9SoGLbMZwe3wyQw31n/YJ4Jfk9wMR5RbnSqd3ESDZilBjlhFx78GmQ
 4p/g==
X-Gm-Message-State: AFq9FYK7wHptUjvlQYodkfK018qd0JysFAFjoUON6NVjWk4mjc8zDCii
 ixv/ATdFRxR4UrXYp/AeNZ8RQOBLKcU2q59cp5uykfVlcOYbD8EYVRJkZxt8K6KBVuoof0t4ngI
 wnNTVzDp5ImAbcCDlXdGjTWBoWSWKskwOh4FCNEp+lQTQAywP/vhpYoS1I7v6B44FFw==
X-Gm-Gg: AYBFou3M9qiuYyAuJBk8qEPym8YbBsnEYd2FAwn89px4P8uu6iCltG0l8yR+EqgT1TA
 anCvKHKBawmYq5XSffQ/by0HDF/DRD02M09f6exKXkRjEp/1ucbaaAG9vN6AyjxOjb0RIWHG7n8
 CSfgFGQqeQAVsH/GwQ65eNHPiJDuVxxbYDK1X0pelI4TdP/HT4rtS2K9T6UcTsHgrTVGgXCfYVF
 uo5nOnZyjOafm69ln4gkr4dJlq8XhrDJHYnmwrjuc9LaB5Nk47B7GOof1oaoQRXu2+5hBGYNWp9
 7/VeUP79vLHob2HJ4AEMnd00pZ7DUhCYPjp+zcJuTFR9BlLENyHB0TB+2919aDp+1cZNY74/vPt
 bR3u/CH+3uMcOZfw9ngQ/JGNT8Z0gE9aN88oYbOW1bJjzsqmq
X-Received: by 2002:a05:7301:4244:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-369d9833f72mr974428eec.11.1792720294705; 
 Thu, 22 Oct 2026 18:51:34 -0700 (PDT)
X-Received: by 2002:a05:7301:4244:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-369d9833f72mr974404eec.11.1792720294130; 
 Thu, 22 Oct 2026 18:51:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 31/43] target/hexagon: acquire BQL before reading interrupt
 state
Date: Thu, 22 Oct 2026 18:50:28 -0700
Message-Id: <20261023015040.2473105-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX64MaK6a8nONu
 WkeS+gS4h72iDsRicypiqcu5b6X7G6+rw7AhC3b/JuaL1jEvJdLow+kPfMLijgButB3uK/Q3+jA
 odo4g6G7f4SsW9BaE9Yp+VCwXUzahwZgS06tpQtfLXsJ8JEWhFmY39ExxVKGR+lvzIRB46J2hLp
 Ghmc6LWZWNvEUP7Urp/Whi3dQ3+Fb+VVJndEh6nR8hIDN/bEdrkFz9AZsZzmAQo1aACAGkig0//
 y3/ZFL1Ci/Ane5lroUxYWy5eclrwpt7CTxI4oapJuXnB3d9B1q0Pvw6l7SKGjWyj1oJXUwhJ2vZ
 nxhoV1c+xIEF0LQqWlnsGLiKvFzF6dz4cN+HrUC3pIOFBtCP0t9apaAkLNr5XpwrE3zIlita1Bg
 VAWn7ZJLTupDF8BDqxgPQCz4/D6IhyTbNgEek3NIYVIeeJzTM2wuLkieAFwoDfp75fFFxVcNJ1x
 /GJ0Ypczg6V0ejkzJbA==
X-Proofpoint-GUID: GRmIdHBU2nXZR06LXOO4cMZhM38GR-Se
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX0rr1f3vnxjLn
 gP8omHCaa+72mn90WFMpkVmtJKRtBIpqsXEKlnQIvImzb2/Q46cfztO4oxGLjM/63kLDjyoD+HP
 Cw72h793SIw0EZ4bk/xO2qG04DRU5fs=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adabda7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=52E-7OzoYlKJP0MoAcQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: GRmIdHBU2nXZR06LXOO4cMZhM38GR-Se
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TW92ZSBCUUxfTE9DS19HVUFSRCgpIHRvIHRoZSB0b3Agb2YgaGV4X2NoZWNrX2ludGVycnVwdHMu
CgpUaGVyZSB3YXMgYSByYWNlIHdpdGggaGV4X2ludGVycnVwdF91cGRhdGUgb24gb3RoZXIgdkNQ
VSB0aHJlYWRzIHdoZW4KZW5hYmxpbmcgTVRUQ0cuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaGV4X2ludGVycnVwdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X2ludGVycnVwdHMuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKaW5kZXggODFl
N2QwMTZjM2QuLmI1YTg3MmRiOTg5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50
ZXJydXB0cy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKQEAgLTM4OSwx
NyArMzg5LDE5IEBAIGJvb2wgaGV4X2NoZWNrX2ludGVycnVwdHMoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgIGJvb2wgaW50X2hh
bmRsZWQgPSBmYWxzZTsKLSAgICBib29sIHNzcl9leCA9IGdldF9zc3JfZXgoZW52KTsKKyAgICBi
b29sIHNzcl9leDsKICAgICBpbnQgbWF4X2ludHMgPSAzMjsKICAgICBib29sIHNjaGVkY2ZnZW47
CiAKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgc3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYp
OworCiAgICAgLyogRWFybHkgZXhpdCBpZiBub3RoaW5nIHBlbmRpbmcgKi8KICAgICBpZiAoZ2V0
X2lwZW5kKGVudikgPT0gMCkgewogICAgICAgICByZXN0b3JlX3N0YXRlKGVudiwgZmFsc2UpOwog
ICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQotCi0gICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAg
ICAvKiBPbmx5IGNoZWNrIHByaW9yaXRpZXMgd2hlbiBzY2hlZGNmZ2VuIGlzIHNldCAqLwogICAg
IHNjaGVkY2ZnZW4gPSBnZXRfc2NoZWRjZmdlbihlbnYpOwogICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgbWF4X2ludHM7IGkrKykgewotLSAKMi4zNC4xCgo=

