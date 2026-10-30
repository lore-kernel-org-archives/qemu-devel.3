Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80322606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=artITc8X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UvJ8Wkap
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumV-0000hO-CB; Fri, 30 Oct 2026 18:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumT-0000gk-7q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:09:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumR-0003qx-E0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:09:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtM5f299760
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XYBE0GBY1vQqA0EKvIESjgtZN4oxA2YVWeJmVKholOk=; b=artITc8X9nKiV7SC
 em4gVuq0iMdgZZFibRC2DGhSPm1uGLQq9WOsm4dL6IiA219DidPgYbhXVWCjyKL1
 MSvsJKAHezQx6OUEjHzMGiJx8I5QxOaUEOHjL2pVh7lyzJ9PeMPF6WTrX/NitfcR
 qmjjShiebfM1g7p54crZYeuMG397pChWenQqVtcLIMIr4k+8aFSP0/0lRQO2UOQ7
 dbAqjCDOHLi3nPHV8R1YM+NLUjfCOhSUdN/M/cDt9TZZy8luEa9NZoq/uGiAtc7F
 Z1s5E/W2U+UH0bPiwdXaUhDLmlAiM8vyv9xew0DscvCRlZBFVIbGhizhbDtMl9eq
 rocfaQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g6nq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so4421022eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398136; x=1794002936; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XYBE0GBY1vQqA0EKvIESjgtZN4oxA2YVWeJmVKholOk=;
 b=UvJ8WkapPNwWOBjWGdc2jYmMR+yW4dEjOHyN3ud/Jc9ytYmiGgRZNLpeZJBO1RszDR
 duSM7V97mqinn2uBtWiH3utEe1xXM0F5I+IwMgQNf667QQ5EC8nQTYB2XUSi2Lnv8C/l
 T3Ljk4HsF8YUAMp3yq9cvtwwk7w+UAXJ+5L90XSOgdguXqI1a8fx541xDb/dUdrEl/Gu
 zSKddi/TJOQmG68HWog/AXzU3qzC8xj66t7T7ZH1iCY93T+PCjbhILa4lykKw3eMM9S9
 ZhZade40/MBwS+9sybeZX3eeA2YwBgAg0QgcmsrKWE8cBiPAvUIHXDG8jSvsuxgfwByy
 uuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398136; x=1794002936;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XYBE0GBY1vQqA0EKvIESjgtZN4oxA2YVWeJmVKholOk=;
 b=2244+3AZr6gqlEU/mmT6k4hpDqtOSDhKYrNxfeReaKjtFpAosW0DfPPQdC78PSpxdF
 p54bizrmnzXM6lxEwgZ0jT+GM6ZMJvR5qCuCKGKpyP3U/jiJiv+Jum0agma2NL73739l
 2cv4tSQYtFRmycqWCGmbEJMtmLVXDPPT4w6DBh1weC7DpJiwxgXnsVO0xp2MM1Hi9U/K
 gPDfce0mQRvehEk/8ylW7bcSnCTI3nF930Ialh5+JQZjsUCHgh+vpSWhiLl3Rr3b5TNw
 Ds//gL80JdZfNuE7HDfk7AOlXUhaK3WpXC7fjczooDqabcztitwyOd8gpKG5UzicDGMu
 BhOg==
X-Gm-Message-State: AFq9FYJglE3Kj0XnDpm9ZX/rfUSNjFwWuor1cwwbjjkan83WoA2cuMzt
 92rbR2/75eN1tKOUA3Xn14004lYeQviEbU0zMZKEZkzhT9b7KIHgKW6NJT4eBlyqLm1I1UgMguI
 Uvnbgie2wWU9Iqs9u9eCPrmbG0k/aUBxjNjARoc3yxf78sgWSUO+6AaHrtuD7EOY5yg==
X-Gm-Gg: AYBFou3jhe2HVgbxC5/hDFifl212xW2xpsQGwlo1Fl0ttUDOQ0xHLlf282vLKSKq6gt
 Ql/XWFi864g2UV1blE7egiB6Z1ILq2zIXfOOMdDF/fXjZz1pXIl58AoZaFldDAVvkLxGVXFaz5g
 7xsIjanWB09B0Bl5/ZyYN5YHjAu8rtHWVA8Y36ezSB9tDjOqJVNJ3FP2dsozx1Oko65drq2tc8I
 bKPa2konF5H5K1MJCC5ROUvDEIJ9AvI3BBhhlZ1Bn/Ut+CG5ikXmkvVpCI0ZAWNE0x3+Madr+Ni
 MI1IXXxJbr2EHx/jzLQH6FGYOeos/EoiXsVa1MmNh/jVZupfEnu0S8Oq/Kr0miEwbBa3yDXXjwo
 qUUuKo3n9cMsOMyxEWkTevPvz6eqYHXZr8dF2UDNkgCP9gWJHu8CgiUGtgpmGlx3XfFvfVq213B
 aKek9shlbzbgINpbw1V4iV
X-Received: by 2002:a05:7301:4298:b0:36a:eea:df88 with SMTP id
 5a478bee46e88-36a42395078mr5237701eec.19.1793398135536; 
 Fri, 30 Oct 2026 15:08:55 -0700 (PDT)
X-Received: by 2002:a05:7301:4298:b0:36a:eea:df88 with SMTP id
 5a478bee46e88-36a42395078mr5237677eec.19.1793398134940; 
 Fri, 30 Oct 2026 15:08:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 7/8] hw/hexagon: migrate the HMX state
Date: Fri, 30 Oct 2026 15:08:39 -0700
Message-Id: <20261030220840.4142885-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 58QrLzO3Ndbrtau6kGQ0o8ouWqmpfXzb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfXybzfdTQ8sBL/
 9h3Czfy30UaRC7UqvjRviGPDR9qgQhz6GPV+WkBcg6Ewz+IXTaBeeJpp/5bXMeUTUswPZwKDtqx
 U4k9x6lK0VQJKXY5SSVhm42U8Mhsq6A=
X-Authority-Analysis: v=2.4 cv=IpyL47/g c=1 sm=1 tr=0 ts=6ae51578 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xdyA_gckl7Q-J04J5HIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 58QrLzO3Ndbrtau6kGQ0o8ouWqmpfXzb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfXy7akscwIBs7t
 94l3Cgv0XlT60sVHlUQ9oVtlpDz8LT7diqW05JcFVJkXKuKLCKuffwU4IRQhJccIoy0H8Fgsk/y
 rY0WK28S6Y6U5MfQ4jHzJLSiQreAVqDjRBax43rg2G8upSKSAjO/LEXfwo23BQdb8cNyYfMJxyL
 CUbfe/DHeB964UHwEL/B3wrLnkbvD/dvwVzXNuL++uZjAjptf/o8Az3hk6SB8pkknlTfXqQYE79
 H0V+VzT8jA2AfRnimKa1mNriNxsT2HtLoUqrUvP6CKNH6Wru47yrk0DmNiAkCSOJ18NLyJU5iMa
 KlayFzzk9ZnsViJgJELmWBzHIPpzZBKzgmd6kWPjVr0ANJtkFmd4/NvpKMHbCnJqn+TbTh4zjHo
 ZhQJkvLu8niRSRV5xebz46Sx+H/MR6R4M0GwkSGwTazClDso3nAyDoGZI1H3N7zedQlHGCK5Bkk
 mLHg4tzHzoE8wJYX2jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYyB8IDExNyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYyBiL2h3L2hleGFnb24v
aGV4YWdvbl9obXhfY29udGV4dC5jCmluZGV4IGUzZWE3YjcxNDc0Li4zNjgzYmQ5ZDQxNiAxMDA2
NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMKKysrIGIvaHcvaGV4YWdv
bi9oZXhhZ29uX2hteF9jb250ZXh0LmMKQEAgLTcsNiArNyw3IEBACiAKICNpbmNsdWRlICJxZW11
L29zZGVwLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmgiCisj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIKIAogc3RhdGljIHZvaWQgaGV4YWdvbl9obXhf
Y29udGV4dF9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKQEAgLTE1
LDYgKzE2LDEyMSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0X3Jlc2V0X2hvbGQo
T2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIG1lbXNldCgmcy0+cmVncywgMCwgc2l6
ZW9mKHMtPnJlZ3MpKTsKIH0KIAorc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hteF9hY2NfZnhwID0geworICAgIC5uYW1lID0gImhleGFnb25faG14X2FjY19meHAiLAor
ICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAu
ZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7CisgICAgICAgIFZNU1RBVEVfMkRBUlJB
WShkYXRhLCBIbXhBY2NGeHAsIEhNWF9TUEFUSUFMX0RJTV9GWFAsCisgICAgICAgICAgICAgICAg
ICAgICAgICBITVhfT1VUUFVUX0NIQU5ORUxTLCAwLCB2bXN0YXRlX2luZm9faW50MzIsIGludDMy
X3QpLAorICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAorfTsKKworc3RhdGlj
IGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hteF9hY2NfZnAgPSB7CisgICAgLm5h
bWUgPSAiaGV4YWdvbl9obXhfYWNjX2ZwIiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1p
bmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRb
XSkgeworICAgICAgICBWTVNUQVRFX1VJTlQ2NF8yREFSUkFZKGRhdGEsIEhteEFjY0ZwLCBITVhf
U1BBVElBTF9ESU1fRlAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSE1YX09VVFBV
VF9DSEFOTkVMUyksCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9Owor
CitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaG14X2FjY19zZXQgPSB7
CisgICAgLm5hbWUgPSAiaGV4YWdvbl9obXhfYWNjX3NldCIsCisgICAgLnZlcnNpb25faWQgPSAx
LAorICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSAxLAorICAgIC5maWVsZHMgPSAoY29uc3QgVk1T
dGF0ZUZpZWxkW10pIHsKKyAgICAgICAgVk1TVEFURV9TVFJVQ1QoZnhwX3ByaW1hcnksIEhteEFj
Y1NldCwgMCwgdm1zdGF0ZV9obXhfYWNjX2Z4cCwKKyAgICAgICAgICAgICAgICAgICAgICAgSG14
QWNjRnhwKSwKKyAgICAgICAgVk1TVEFURV9TVFJVQ1QoZnBfcHJpbWFyeSwgSG14QWNjU2V0LCAw
LCB2bXN0YXRlX2hteF9hY2NfZnAsCisgICAgICAgICAgICAgICAgICAgICAgIEhteEFjY0ZwKSwK
KyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpCisgICAgfSwKK307CisKK3N0YXRpYyBjb25z
dCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9obXhfY3Z0X2Z4cCA9IHsKKyAgICAubmFtZSA9
ICJoZXhhZ29uX2hteF9jdnRfZnhwIiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1pbmlt
dW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRbXSkg
eworICAgICAgICBWTVNUQVRFX1VJTlQxNl8yREFSUkFZKGRhdGEsIEhteEN2dFN0YXRlRnhwLCBI
TVhfU1BBVElBTF9ESU1fRlhQLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhNWF9P
VVRQVVRfQ0hBTk5FTFMpLAorICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAor
fTsKKworc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hteF9jdnRfZnAg
PSB7CisgICAgLm5hbWUgPSAiaGV4YWdvbl9obXhfY3Z0X2ZwIiwKKyAgICAudmVyc2lvbl9pZCA9
IDEsCisgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBW
TVN0YXRlRmllbGRbXSkgeworICAgICAgICBWTVNUQVRFX1VJTlQxNl8yREFSUkFZKGRhdGEsIEht
eEN2dFN0YXRlRnAsIEhNWF9TUEFUSUFMX0RJTV9GUCwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBITVhfT1VUUFVUX0NIQU5ORUxTKSwKKyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElT
VCgpCisgICAgfSwKK307CisKK3N0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0
ZV9obXhfcmVncyA9IHsKKyAgICAubmFtZSA9ICJoZXhhZ29uX2hteF9yZWdzIiwKKyAgICAudmVy
c2lvbl9pZCA9IDEsCisgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9
IChjb25zdCBWTVN0YXRlRmllbGRbXSkgeworICAgICAgICBWTVNUQVRFX1NUUlVDVF9BUlJBWShh
Y2MsIEhteFN0YXRlLCBITVhfTlVNX0FDQ19TRVRTLCAwLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2bXN0YXRlX2hteF9hY2Nfc2V0LCBIbXhBY2NTZXQpLAorICAgICAgICBWTVNUQVRF
X1NUUlVDVF9BUlJBWShjdnRfZnhwLCBIbXhTdGF0ZSwgSE1YX05VTV9DVlRfQUdFUywgMCwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdm1zdGF0ZV9obXhfY3Z0X2Z4cCwgSG14Q3Z0U3Rh
dGVGeHApLAorICAgICAgICBWTVNUQVRFX1NUUlVDVF9BUlJBWShjdnRfZnAsIEhteFN0YXRlLCBI
TVhfTlVNX0NWVF9BR0VTLCAwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2bXN0YXRl
X2hteF9jdnRfZnAsIEhteEN2dFN0YXRlRnApLAorICAgICAgICBWTVNUQVRFX1NUUlVDVChjdnRf
ZnV0dXJlX2Z4cCwgSG14U3RhdGUsIDAsIHZtc3RhdGVfaG14X2N2dF9meHAsCisgICAgICAgICAg
ICAgICAgICAgICAgIEhteEN2dFN0YXRlRnhwKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjRfMkRB
UlJBWShiaWFzX3JhdywgSG14U3RhdGUsIEhNWF9OVU1fQklBU19TRVRTLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEhNWF9PVVRQVVRfQ0hBTk5FTFMpLAorICAgICAgICBWTVNUQVRF
X1VJTlQzMihjdXJyZW50X2FjY19zZXQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9CVUZG
RVIoYWN0X2J1ZmZlciwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihhY3RfcnMs
IEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoYWN0X3R5cGUsIEhteFN0YXRlKSwK
KyAgICAgICAgVk1TVEFURV9VSU5UOChpc19mOF9vZGQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1T
VEFURV9VSU5UOChmcDhfb2RkX3NlbCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Mihmb3JtYXRfb2Zmc2V0LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRpbGVf
eF9tYXNrLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRpbGVfeV9tYXNrLCBI
bXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRpbGVfeF9pbmMsIEhteFN0YXRlKSwK
KyAgICAgICAgVk1TVEFURV9VSU5UMzIodGlsZV95X2luYywgSG14U3RhdGUpLAorICAgICAgICBW
TVNUQVRFX1VJTlQzMihmeCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihmeSwg
SG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX0lOVDMyKGNoX3N0YXJ0LCBIbXhTdGF0ZSksCisg
ICAgICAgIFZNU1RBVEVfSU5UMzIoY2hfc3RvcCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRF
X1VJTlQzMih5X3N0YXJ0LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHlfc3Rv
cCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMih5X2RpbGF0ZSwgSG14U3RhdGUp
LAorICAgICAgICBWTVNUQVRFX1VJTlQzMihibG9ja3MsIEhteFN0YXRlKSwKKyAgICAgICAgVk1T
VEFURV9JTlQzMihkWSwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihncm91cF9j
b252LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGdyb3VwX3NpemUsIEhteFN0
YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZ3JvdXBfY291bnQsIEhteFN0YXRlKSwKKyAg
ICAgICAgVk1TVEFURV9JTlQzMihtYWNfY3ljbGVfbGltaXQsIEhteFN0YXRlKSwKKyAgICAgICAg
Vk1TVEFURV9VSU5UMzIoY3Z0X2Z4cF9wZW5kaW5nLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RB
VEVfVUlOVDMyKGN2dF9meHBfcGVuZGluZ19hZ2UsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoY3Z0X2FjY19jbGVhcl9wZW5kaW5nLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RB
VEVfVUlOVDMyKGN2dF9hY2NfY2xlYXJfc2V0LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVf
RU5EX09GX0xJU1QoKQorICAgIH0sCit9OworCitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0
aW9uIHZtc3RhdGVfaGV4YWdvbl9obXhfY29udGV4dCA9IHsKKyAgICAubmFtZSA9ICJoZXhhZ29u
X2hteF9jb250ZXh0IiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1pbmltdW1fdmVyc2lv
bl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRbXSkgeworICAgICAg
ICBWTVNUQVRFX1NUUlVDVChyZWdzLCBIZXhhZ29uSE1YQ29udGV4dFN0YXRlLCAxLCB2bXN0YXRl
X2hteF9yZWdzLAorICAgICAgICAgICAgICAgICAgICAgICBIbXhTdGF0ZSksCisgICAgICAgIFZN
U1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9OworCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2ht
eF9jb250ZXh0X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKmRhdGEpCiB7CkBAIC0yMiw2
ICsxMzgsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0X2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKmtsYXNzLAogICAgIFJlc2V0dGFibGVDbGFzcyAqcmMgPSBSRVNFVFRBQkxFX0NM
QVNTKGtsYXNzKTsKIAogICAgIHJjLT5waGFzZXMuaG9sZCA9IGhleGFnb25faG14X2NvbnRleHRf
cmVzZXRfaG9sZDsKKyAgICBkYy0+dm1zZCA9ICZ2bXN0YXRlX2hleGFnb25faG14X2NvbnRleHQ7
CiAgICAgZGMtPnVzZXJfY3JlYXRhYmxlID0gZmFsc2U7CiB9CiAKLS0gCjIuMzQuMQoK

