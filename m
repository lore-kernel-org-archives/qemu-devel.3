Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C1oNL6Se;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fx5f/0ti
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJf37-00010x-8V; Wed, 21 Oct 2026 18:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf2z-0000zL-3t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf2v-0002YE-M7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe21o2779373
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=C1oNL6Sepmkazs2L
 iTUZo2U8s5nrNGC/ZTogcUaR1/JD7rmBI83/VrIyU3pIlVnQHPlLnekXSMCbqhQ9
 ypJdAcPEwLJsSpdUm5DHfZWXgXqTE5PYYIGziLZ9eR/3Sf5N8Ezrz0bINGBgsdEB
 CdT6lCtmIZak9IG3yejh7BaTbTN66ZU3FN9kvQnceCBv4aiO49E8oZQGtt5gPA9Q
 YXDOy6A2gHzv9MJXyYtBvbaL7vMyyheg45xxW0r6nR+KyosiV22yIqv0nJh3O4qD
 YLKWeOCUnwjL2FcW9c331p+cPKlwoH1UniZCflFcIgDRl/yg2naXPNYjMikdfkDj
 KuZeUQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhujuvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so2081992eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792622672; x=1793227472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=fx5f/0tifYU1cpi+OCaJAaq+UaKmkn/55/pKEpjSsrsnk9XrdUExo9qqvO4X45Tjc/
 hS8viiRfZHTxfTybSJ9mcn889qmWc5NUI7VOFC11aLy87fDVO501SnVuNo0G4O7CJL7i
 k1KqhVld9Rl7W+e7ssozDhC5GTv1Q/Id8VRlvxr06XPhiubxSF2obVx6AzjWI7A/IbgM
 jj3438CoFeU6w0S8iOmQhB/ItghaBN67VsJQ6P9JTz5+cEgVXoCoSRu7FCcEvTHozS2e
 QpleiZ/VLU2mpeL5nTxIsl+6w2ds3swOB4ufmb2Euh9U39zh3xRYnjshjBnVhI8X0JCc
 D+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792622672; x=1793227472;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=o9+waodYQ8KVuqtrIbDJmGJPzmenn/8VbWURJlS0bg10s63qdG0w/TXI+Z6MqwAdv/
 rbZHfxw4WzYr1sYK6gBPSwk7p7aZu9ZHp/fNtqs3y43X2w42WK3BPCbMtJs9C7KsL/YA
 21w4qFKovBtTAP/CeTiRFuzu3a0Kzk8RsoA8fmiZ62m4D6dmynuHOIHYmMJ0zUnZw4gh
 3UHn+xtBqblDf5lZX0VOGPkCpcMdMdku8UxQBMJsvAgGZA9TERa0HaztkPBAua0qVjpd
 3irnq1MRoXmzX6zwSUt7fdkyGRUGfQVZrY1y/R5LuDELPXFXjNGt737rWq/4nhrDEzeu
 lInQ==
X-Gm-Message-State: AFq9FYKH7GtP/JtGV0Su7wRgyAX5f4kE+S2CleLMEfnlzjkidZzphxfr
 lkSfnCqeMzkk+vfbzVx9NXhphWaiHcKJKQAV3SetP0f/yWXTnHxgDq0V3nR2wei+4w3MXOELLX6
 QiffBwVJgFkuJuA9OaW5Rh2BRuer7+EYAmuI2NLU7dVKK/9f/mgEGfEmgODHYreA8zA==
X-Gm-Gg: AYBFou3OYmxlYw4FOiIY8MoJWARjGELUWUh++5lLu2DsaDaF9TLtVf1+O+xHYfn4JTY
 NqGaYs7oSQeQl+Te5iOPUxZm3Wob5kTAI/hl8ZV5X4inRClkSwfOcejyIax9oJGlfWL4vv6aa8P
 tPRGbDMeqJPnEmQhVfz2tYfGZ191Nw7biCVMkKujmeV7cl9m2FDYxB4rIIQ94hAwQx6gkQQYKt0
 Ac6+W5IxaZ8MPX1mg4mMmh209sqVbYsNFao7WiBbIHDX0JpszkpLmKEyhV5Jqk2zbrk1Ak8nyEY
 rMLANzm5XmnQvghhrhglcgzW7XGazJU1s//py9d9AggX2YBpBVuVsXM4wzjJQAeYR1eqZOwGez1
 9Q4xAUFHcH+FAuHzSV3UsxBoJqnZVZK3AfocIy9xrL9oYYhHh
X-Received: by 2002:a05:7301:dd98:b0:35b:b3fa:40f7 with SMTP id
 5a478bee46e88-3674f70fe87mr4415741eec.38.1792622671453; 
 Wed, 21 Oct 2026 15:44:31 -0700 (PDT)
X-Received: by 2002:a05:7301:dd98:b0:35b:b3fa:40f7 with SMTP id
 5a478bee46e88-3674f70fe87mr4415701eec.38.1792622670541; 
 Wed, 21 Oct 2026 15:44:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5eesm9462858eec.8.2026.10.21.15.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:44:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 04/11] linux-user/hexagon: report ISA HWCAP through v85
Date: Wed, 21 Oct 2026 15:44:14 -0700
Message-Id: <20261021224421.3786109-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad94050 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfXxw0/xZyp1D00
 VXreRTvE58eYU6kOPIyPcJ25aQxwNXv1uVsdEabTRvkoy2ioDIo/sAvoLE6G9MdrHbI54uvFc6C
 PiBH2JJpkj9H0kPUVGklRE9H+BIIa+E=
X-Proofpoint-GUID: -aR3MI3Q2yw8uuddl7sS15a1gT1X0xdM
X-Proofpoint-ORIG-GUID: -aR3MI3Q2yw8uuddl7sS15a1gT1X0xdM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX7mdcODhO8L41
 665QgNKP4G8pToVarqKC2RcOQOtBTqkIC8XIAxSz28aIzAXaftbEQ1tMKc7R5jKrCW+chig/x6v
 0PrSMgyx+7r0OzUtYRe2JnKT5A5Z3CpOdG/+bY/kSnkNgGuZ5nXxHjDMJeYsKD0GWI1TUW2UMKU
 UE1SwTW/8KYfCutccDZhLrkKezXf4rwtE23fmNjGG5H3Ueiod0Ay+VXh8FaxV6zwJOirT6adzfl
 tYTbEVbBOou9/HXGqv9c111aI+9kXPNb91GuEbeS0Ski/+okj8B52228aeIQrGn86dIa1v+2pgj
 OyGC0TrpTdcHs2g6rXmTauljDAVIuuf/05uFhRlrklv7LOBRnngdhbi4vK9x3jJY/pJk18JOh4u
 UKsRSghCvKvlISpqRRb+mcw0eZQ5nfeIOc2SZ+6jsD4Lf1yCfCA0F5qfdpMqOCxIYotVrnkDkc3
 Ch8ZbLLqmywzxpLPe0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210090
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

