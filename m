Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1014C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9P0U-0003Rw-Bc; Wed, 23 Sep 2026 11:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P0P-0003RN-NQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:35:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P0L-0007nq-Or
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:35:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NBbkrX3295824
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XLjb43swtoOWATDZCNbyUc6f4RjjUHm57qX1Y/WEq/w=; b=hBlu+sG2vDnmkLCx
 ik3GA6KCokMTe9cxQEg7tHdTpEm1EuCA5QcF4oarT9vwy9r3knLmIz2keZY9zjkb
 mEGsN72FWZhJvpl4NE8n0xKbjlkgLcSpuLQWGtYpY3XgnzFnh91O2PFNljo7Vp1I
 iPu3rwl+axlzwn2W6I3dST9bqAgR03lLXIMmI5Jh3Uyu6S8T4tQE1FAJxGftUbEd
 HB0HLD4cVsyLAqabn0inSNY2phovcW3lUsd51PIgYX91sxgWHMmRlaZQ/ozPpBXm
 z8yOQSCIfTN6irJOrhHzohSYrUX7HDfFntu1cqqy1+2bpyf6cGxvjMq9SbIy0FGM
 DHI02g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm9kyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:35:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8632fdf67dfso845432b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790177726; x=1790782526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XLjb43swtoOWATDZCNbyUc6f4RjjUHm57qX1Y/WEq/w=;
 b=Zr3Hsb0NCv1KWQVq8Rgw3U2F/25vcG1ojtk+dp8IuNYygM3QuW6prRmLAPM3Sm6wKs
 Nii3SAm2X84XwqhvNNCH/e10xdzsKvkBJIodgKlDcAWvtaoWip06gcUI2P6POqESJGcP
 psIl1tSaRJzZN6NCIBh+z2YPQ2X8Irkes/G4dHn/bjeuygzbZjPfX855C1Tzx9awDVUj
 1rAkg/AQHzNdZMokq0OGcyIWlVDYQe7TI/Au3DVdBfZ1yVSGWhZk9kIt9pDHWar4GQoY
 xsJgIZszXmK9bvIFuZs8BfjvMVrpTBTy+PE8jTqgcjjyhI5gGRTdeYKfQXMSETJHMdcD
 4bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177726; x=1790782526;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XLjb43swtoOWATDZCNbyUc6f4RjjUHm57qX1Y/WEq/w=;
 b=uep/Cy9addVOauG1XeWZD/iOV16Zs4fXXu7zT3XWteL5VpOksI0c0f4ooCpDsDcnYj
 fvd/VspnlxDN3FOhUxgQJm949f8KQrHpCs0peHXnq0BX7YWHs6axarqkITwGS7Jtngz2
 J6lrJqsUpl4dUlsjEJ63A0YH1goO+77fshsGmaHFhq8ikI0AHg8ILTNsIzgH4j8fWxhf
 F3eiCvezkyU7ZLZbgR55oeA7eFaFjoKh7+NdERUUCTTfDKvM/E9lgB7+7rq4w8vj1Kv5
 8OJeU0GrpMikq3/hA0pAFBD3gkso8LmgngFHxYhmosUF1h6SSJHdHUumQSXZrsaYcbj8
 zq2Q==
X-Gm-Message-State: AFuF++keIt9ounDXx+5HM0ss9vVuIQsF58yuPDoCzFYkXfde+biIZZ8t
 3kvWp9WGxRfd2LLVLb7h+y1USX2pDJKmBUUSd0unqEINrlcqpylPr3U0bx5HP81jKndiUSqLSHw
 sbvc0CTfytNL5tHMFBS3du3F3iUPJNS1ZONOo1CGPR+4txfyNcPazjEnMgKze+wyGPw==
X-Gm-Gg: AYBFou0Dg4PXSmY4FaKLdSM+Gjdef2ZFcC4bIp9bSbGMceuBJO/agzCuXXx8SEx7Urm
 2MkdzsZuHJtZq9MIT640zfpJuMih+0s+b13Ca940A7P53fq8QPzLvpISL8UArfvFNEPyrOllW63
 fV/2y0JnD7in5YiDyPfEkYPNLe3n6atUZRZ3rpGR7caqz1AvE4XeRUHBZtfSGQV7/gXaKuhOwO8
 24KPnAUz7t3ivKrZSkt3CjjtfklRr+SD6e250zsaHJC7S5asfO79GEYGbcxUN9T8Jkf9fB356gI
 KVWw/hrWr0/w2cGjfqLbGcjtcmFwk9dt1nbXbZaJyzIIFFAq8Ruvk8ndv2OUHmaxLk1nwK94Q13
 PYpEWGILurgOalib+GpMOzBP2G50cebVzhDXnV4rdbripNzk=
X-Received: by 2002:a05:6a00:288b:b0:878:3705:5720 with SMTP id
 d2e1a72fcca58-87c857f2d1dmr3151558b3a.44.1790177724758; 
 Wed, 23 Sep 2026 08:35:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:288b:b0:878:3705:5720 with SMTP id
 d2e1a72fcca58-87c857f2d1dmr3151546b3a.44.1790177724323; 
 Wed, 23 Sep 2026 08:35:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1e601b5dsm1516072b3a.61.2026.09.23.08.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:35:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v3 3/4] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Wed, 23 Sep 2026 08:35:15 -0700
Message-Id: <20260923153516.3615007-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
References: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfX/iSkJMq8xO1l
 ktd+4vMlho4CjktLO0RBzxZJWSLKsc2FWd5vR/bEapg5Ud92zMK4LDOSyCI6YnN36EDy9TGfc6g
 A3deHX2uHLjq9tV1uIecXiefzz732so=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3f1bf cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PPoDI1HoFPolapXB6VfYBeebHGDcKGC7
X-Proofpoint-ORIG-GUID: PPoDI1HoFPolapXB6VfYBeebHGDcKGC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfXwDBLMsRQilrA
 4lYaW+Fy+3Di7nbpbhcD8vsEuI0PHiR6juJvSajRHjvxE9noTmWmzGhWmAVIeThaCqNION71yG7
 G9v+bdQFWf5gPIKIZP7QucDvM1xm2GnXys83GrQA6mxtJ8FMKRCo9IfKN5s56PB5+UgCQf4Ue6d
 QIMBiFHoH4LQ1Z/9RTtfX2joD0VOoUXSFdisEYvsgE+MPCj9clMwfFKIEfL3TjJEKq0a5w+3PBv
 El2W0n4WMpXItxGJPVCJ0WBb4PjlHluQ82B2q5PJqQgwGB6c8A6LAjkI4mA196p3F911kpsa3S+
 ohNM/kf6CnwWpGTBTRr47Xy89I1gh3Lx38Tt5KI7lkUFxvutmQhMvipzYjnFts9fpGAOgkioJc2
 B2cJ6VWDkkcxEDVgSlSYfCWpmsmQ9lfyGdcf9Zc8XwatQBkdfrD25ytI6TM/sBfeYxFQIH6znGJ
 BULwf+V47VOHRpP9ihw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230062
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuCnRoZSBndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzCndyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5j
IHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3
aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggOWU4ODUzNDRhNzMuLmExOGU2NzVh
ZWM5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYwpAQCAtNjI2LDI2ICs2MjYsMjQgQEAgc3RhdGljIHZvaWQgc2ltX2hhbmRs
ZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKIAogICAgIGNhc2UgSEVYX1NZU19BQ0NFU1M6
CiAgICAgewotICAgICAgICBjaGFyIGZpbGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZp
bGVuYW1lOwogICAgICAgICB1aW50MzJfdCBGaWxlTmFtZUFkZHI7CiAgICAgICAgIHVpbnQzMl90
IEJ1ZmZlck1vZGU7Ci0gICAgICAgIGludCByYzsKLQotICAgICAgICBpbnQgaSA9IDA7CisgICAg
ICAgIGludCByYywgZXJyOwogCiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIoRmlsZU5hbWVBZGRy
LCBzd2lfaW5mbykgfHwKICAgICAgICAgICAgIGdldF91c2VyX3UzMihCdWZmZXJNb2RlLCBzd2lf
aW5mbyArIDQpKSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9Ci0gICAg
ICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtpXSwgRmlsZU5h
bWVBZGRyICsgaSkpIHsKLSAgICAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwotICAgICAgICAg
ICAgfQotICAgICAgICAgICAgaSsrOwotICAgICAgICB9IHdoaWxlICgoaSA8IEJVRlNJWikgJiYg
KGZpbGVuYW1lW2kgLSAxXSkpOwotICAgICAgICBmaWxlbmFtZVtpXSA9IDA7CisgICAgICAgIGZp
bGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhGaWxlTmFtZUFkZHIpOworICAgICAgICBpZiAoIWZp
bGVuYW1lKSB7CisgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUZBVUxUKTsKKyAgICAgICAg
ICAgIGJyZWFrOworICAgICAgICB9CiAgICAgICAgIHJjID0gYWNjZXNzKGZpbGVuYW1lLCBCdWZm
ZXJNb2RlKTsKLSAgICAgICAgc2VtaV9jYihjcywgcmMsICByYyA9PSAwID8gMCA6IGVycm5vKTsK
KyAgICAgICAgZXJyID0gZXJybm87CisgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBGaWxl
TmFtZUFkZHIsIDApOworICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDogZXJy
KTsKICAgICB9CiAgICAgYnJlYWs7CiAKLS0gCjIuMzQuMQoK

