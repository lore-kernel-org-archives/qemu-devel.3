Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rc1Y30G3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fgjz/ocX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdcX-0007Kd-TS; Thu, 29 Oct 2026 23:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMdcW-0007KK-4E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 23:49:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMdcU-00038O-32
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 23:49:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2JsGx1947565
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rgz4WPrbzU2yvtPcp+HbGx
 Hc9sGEpfP/o+XfXQa69jk=; b=Rc1Y30G3LEVyazppPlUb5BYcT0hptOARNb1Owc
 Tdvmuv31ZmsesKCSE5dsUOoppbGA7O0VxpsLwh1Lhe6K94uXK6/AmHvYP2PcYFK1
 w/ZP9OGCJ5mqGlsXqSfrXLvk+7qALvTfgFyhAabuzv+aoi9NDJHkzgk3LMJgKZcK
 OyCmZkVytJ4RViiYbsl4veAlsBHxSMQ1VlSD6/Nf66hg4QG/ll5GTMmVdqu66z/n
 No0MJGPP98tAdTxAWE5ipxAsZEv5d3OtiR3twiii5c76ES5ilXH1E68LKyYLDosu
 bp3ldDa/79OViuZpKEAcUDdUjEYwpt5eOicynN/zP10N3g3Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qh21r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:49:31 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14373747468so294483c88.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 20:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793332171; x=1793936971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rgz4WPrbzU2yvtPcp+HbGxHc9sGEpfP/o+XfXQa69jk=;
 b=Fgjz/ocXca6mAP3Rv4S7ufe2OsFkmSW2asmx9bpmoNKBg6nwtXK559ca/pHE1bcXl0
 Yhi4CVK/S4gHvwtDh9BKK+4RxxSBkI0nv4UgQUPdc5rdA7chSyT+1WeSbRRJcvSuIIIg
 GCQNinq4gpeh71JOe1jJigNOH21dhLbARxglw/XRZxZ1yQsyE+I6rftt8gFZGb8pT3ar
 GkCqWb4uRVAnF7R/NqB49N2AzBI07byrxRuc6s8/ZEjjOIaiGXtAg0JjrdtLej0jbEvk
 Y6FHgxLj7F4sAlS1ZBLNOQmVZBgZDUGz6Gb5ik6A/Wkb7y4jJI7cRNg/Jsgxi9SdIcFg
 ArZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793332171; x=1793936971;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rgz4WPrbzU2yvtPcp+HbGxHc9sGEpfP/o+XfXQa69jk=;
 b=ihybV0oZWWYWRxUjgnPLAdeRL7pMPfI/Y/OXcWuJw88AIHB6nr1DHSyZIO23hBf5Vf
 sYmjxv8/U845djL7wVzUhcevsJxLDzUbcp78RP9m5kfsWPvySG4T7FSEaWOzELh2dKeL
 c+u9tZ8XwxjXjwO0my1QV0mvFyjPo/S5p5fkfn6jecWUbKG/MvT3HIdxn3VQ81MSF/Al
 3F8ZKEWxHsx8W6b2qC06bbPAiYq/BhWkBjXcP6bMT6UpHnIZMVmaGCKXnmLu8gipRh3e
 Dt/bm7UpYavVnK53Q2kUFuvGWOe3ccQkxkeb4N7/kHE4kng9LJuhZeLRQgQ/vKKu3OIW
 yWzQ==
X-Gm-Message-State: AFq9FYJXh9AchuDbBwdd+qUlShVhRNuocN1jCD4C7vOJtrBfqzp440qI
 8HBG7PHk2VoviIEtXZsrI/she9/RoV1gt9bka02AT+HQZaKclafKkQjzyx9lifEci3TXERaEC51
 e2U4amWPIQzXmAKvUiWzq0PhW8lfV7hrmP3UfEk0vGQPceG/rXD7+N3ihGurR+Xe2NQ==
X-Gm-Gg: AYBFou3fPlTpn2TS1CS2r2FUdBy3TLwHr4NFc7n0/FKjItDHpd1q1Dj51EB2YHvb3QE
 /txcB6Ooh+ChyBXqGuisqnbZ6dVXIoQlkZYi+/uhezT2u9Nqaj2kiCeyhEWOyUkguA1qQmmWxDK
 ktyfi3fUQU8fFlupLLb+dZcvKD6+uflDUx+mFn3x5lo2942RbKn+Ug1QuFaqWKlBVs896hLzDvZ
 xdk/kTHY1ZA5FYzYXh/HZaAqqyhnJlcsZ8w+cFnEIQqTCelWblAlZkCV5P4tevLx5++k0deCpQJ
 Uwg25io621otgQJn4kZelIM2RuU/ljMhbbzPTT2kXvR2WGnt1kmMW4aopRrgSgYFbyLMjuJ5qYv
 QR3hulAzodSfMLL2+KbAc1ie+iYUzhxy3OR+Z0Dl/yvxBRre0IkD6x79AEuhmhSHnwt5LONuA4P
 wcKOnxTBYctz/1cn6YDySn
X-Received: by 2002:a05:7022:b048:10b0:19e:f233:4f87 with SMTP id
 a92af1059eb24-1ac5a2a1483mr1560720c88.15.1793332170619; 
 Thu, 29 Oct 2026 20:49:30 -0700 (PDT)
X-Received: by 2002:a05:7022:b048:10b0:19e:f233:4f87 with SMTP id
 a92af1059eb24-1ac5a2a1483mr1560690c88.15.1793332170026; 
 Thu, 29 Oct 2026 20:49:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1b38ac58sm3002739c88.23.2026.10.29.20.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 20:49:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Hexagon: Add v79, v81 HVX fp/vcvt instructions
Date: Thu, 29 Oct 2026 20:49:25 -0700
Message-Id: <20261030034928.2135408-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: k6YEloUiSLv_I-IrpG4EtGTdI0Uc4KJ1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxNCBTYWx0ZWRfX879AfbhuITM5
 73/KRLAhwbbI7jP2ESH/zNRAg9HpFkMfoHYLBomQvoulcYIkeNO9CTqGasc1NEIusz5+mX/kZNH
 v8SyvL+v5brwt1pn82YBKKHN6ihKXa8=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae413cb cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K_6NuHQ8uZhdLCT6fJ4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: k6YEloUiSLv_I-IrpG4EtGTdI0Uc4KJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxNCBTYWx0ZWRfX9pCW9XSg+YFX
 owFgb3Mo/KepgFgFLlzye8Z+rLD+nWOz6eZ3cxDq6VTiSv39KTTb+/R2OpTWcoBQW41AjJBIiAX
 QIKqJvAQjeDvQG4kLny1GKwt013zw5frjOzYepAunQmfh7X+T+sIQoNfNKUtu4C73iMZwuODotl
 qha05mJ4r0isMwpJTU3pATv/ZEERo/hU8osm6ixW8koexHBbC0HmNKF7kq3Ci0SoCo0URFw318D
 Hm7PbxE9nSvyqMQ977XhthSNQEZPyRz8WGewDRs2mRlzJRR3qgHREPAH9Ztj/GtRk0l8wxnE0uF
 zQ+BTEpcRiNm+3W/sLAewajfKrWe9R5Hjbi84LP8Ij2dJtdYCEVeE25VpKxFl6DlzmWpkeXPvI2
 W44v5+rnU+x0TVglkHfwjEBqclbVUlanuv/BjAWHRcXTNRT/qW1bvY2UBUeIJnHJu8JtBibikyi
 GDsbsRDB6ByjyLAJ28A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300014
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIHN1cHBvcnQgZm9yIHNvbWUgbWlzc2luZyBIVlggSUVFRSBmcCBpbnN0cnVjdGlvbnMuCgpJ
biB2MzoKLSBSZWJhc2VkLCByZXdvcmRlZCBzb21lIGNvbW1lbnRzIGZyb20gZmVlZGJhY2suCgpJ
biB2MjoKLSBtb3ZlZCB0ZXN0cyBpbnRvIGNvcnJlc3BvbmRpbmcgZmVhdHVyZSBjb21taXRzCgp2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyNDE4MDgxNy4yMDM3
MTY5LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwp2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyMzIyNTgyMC4zMzA5MDUtMS1icmlhbi5jYWluQG9zcy5x
dWFsY29tbS5jb20vCgpCcmlhbiBDYWluICgzKToKICB0YXJnZXQvaGV4YWdvbjogYWRkIHY3OSBI
VlggdmN2dDIgaW5zdHJ1Y3Rpb25zCiAgdGFyZ2V0L2hleGFnb246IGFkZCB2NzkgSFZYIEZQOCBp
bnN0cnVjdGlvbnMKICB0YXJnZXQvaGV4YWdvbjogYWRkIHY4MSBIVlggRlA4IGFuZCBxZjE2IGNv
bnZlcnNpb25zCgogdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X2llZWVfZnAuaCAgICAgICAgICAg
fCAgMzUgKysKIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oICAgICAgICAgICAgICAgIHwg
IDIwICsKIHRhcmdldC9oZXhhZ29uL21tdmVjL21tdmVjLmggICAgICAgICAgICAgICAgIHwgICAx
ICsKIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jICAgICAgICAgICAgIHwgICAxICsK
IHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jICAgICAgICAgIHwgICAxICsKIHRh
cmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICstCiB0YXJn
ZXQvaGV4YWdvbi9tbXZlYy9odnhfaWVlZV9mcC5jICAgICAgICAgICB8IDE0NiArKysrKy0KIHRl
c3RzL3RjZy9oZXhhZ29uL2NoZWNrX3Jldl9nYXRpbmcuYyAgICAgICAgIHwgIDMwICsrCiB0ZXN0
cy90Y2cvaGV4YWdvbi9mcF9odnhfdjc5LmMgICAgICAgICAgICAgICB8IDQ0MyArKysrKysrKysr
KysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9xZmxvYXRfdjgxLmMgICAgICAgICAgICAgICB8
IDExMSArKysrKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jICAgICAgICAgICAg
fCAgMTggKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgfCAg
MTggKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZXh0LmlkZWYgICAgICAgfCAxMTcg
KysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgIHwgICAy
ICsKIDE0IGZpbGVzIGNoYW5nZWQsIDk0NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2ZwX2h2eF92NzkuYwoKLS0gCjIu
MzQuMQoK

