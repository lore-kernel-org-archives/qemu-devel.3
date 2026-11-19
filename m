Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B715606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0txDMLY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KmkHrQ5Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yb-0002rV-DE; Thu, 19 Nov 2026 15:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YI-0002lT-Mw
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YE-0000pe-UI
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:13 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Ugu1936332
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GEye2/vWy+ZQlm0XutfGIM
 1rKHHL20RxjEMdTjaC+bk=; b=l0txDMLY0ttxiXFrfPgOiLlN0C2QoKTwqoUwvm
 s9lcdxghOQF7ZJPIeDQxnplHqIWXkKznS1PhC23810emgNffrcyfamw5b82+YGwm
 CpGbaSmDrEM2/1d2+ySMZDqyN1el3i3PbU+PjjSu2DCbrY6tZCU6MbvyCuw00Kq0
 qo2vrJUAEEQd6NnXY5T2Ud3rnyb1RGlluTHEHIW+4eo6sMnNEA8sJ+xFO5L3gXn7
 v6SOzD0aFpesO1eMNe0tOZCrI2eQ+QwFvm+8XhBMg1mkaJO9YBdsB1uswNZRRIg7
 f8G66KMsQ/N+hapFDsLJwBoXPPM0mIkW0G2wGtVB6plmdPRg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugssrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-383f2d05c73so333173eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119366; x=1795724166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GEye2/vWy+ZQlm0XutfGIM1rKHHL20RxjEMdTjaC+bk=;
 b=KmkHrQ5QCzH2mjB903TtaQD8aQ/Fp05t0Zd6QeiFkUHSBE09LknVU6dGnnCnDcEpBv
 NT2zXKlT6lauwGpo/AG6TmWmjarkoQsZJ48OmNWS0v4D+vcfWs/wpZX0hvJ+sKNHr5n1
 8Vm4SU9XP2DSYUDbLWrWUIbpE+E5inCNig+MMTn6N5P8iALD4beaPFyPmwQrf/Ohtanz
 wjW3JRvU3ka8TrxD5yPpQCbqgBw5u0/MWH3kL8Xx35ug/zgiaWxm2MS5N1INtuQsq/dX
 0HAgJUrOausVLi95iaSnTf1FVxIlAMaDZueOA2kOwaiP0rU8CEr1wn6V6OJT0VmZTiKO
 6h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119366; x=1795724166;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GEye2/vWy+ZQlm0XutfGIM1rKHHL20RxjEMdTjaC+bk=;
 b=ZWSEjRU/yiVkWpGkR87bcns1QPTid/jZX4kih3x8HYqwcw0+rXdY6QSNTQXb0F6UqH
 rWPhoxwiSmnb4eSN1TGYXzyCGzRZsQkHIMQTFEJZgA6qPDCGRvR5yRDzqP/NS2ixOhOX
 a/r0+oR0m+8f6Mmo/97BGhXiEg5BagiUPd5GnC7hWWtPIERfEJoy0cLBKX4ONmGyWpis
 KfTnBmD/Z82qTWQM8Lj/oq6PHAYJ7fXiKbqlBcaxsDgD0yt4VsKavfAGgtm4zYEJun6U
 8fp7K0y+poczfsMRdgbQq5DveQke09A0X2CzV898gtjza05iHkzToxZ3JWo0U96CxBr/
 x+Nw==
X-Gm-Message-State: APuU4Z98kisc1prNWPDwW1GdBq9Lgv1Ym1hqvqRHyudiJhMS2tqzL7JI
 wzC06No5DYOqK9BsruQ9SbdJIlimR+I0GiScCzqgRqen4U6BcoaaSHh9L4hudQQLqBE0OTBBCuH
 sR869T84UXsoM2ur/sOPfQQ7Jz70zQdL7xvgOEDKoe87SCqoWYSv+Qbz1aHLXhgvjPQ==
X-Gm-Gg: AZFdTZcAnNhairibF96CyMk1T0AlhSIpgnogD6GLJZl8c0+cFCp0KQuL4lpejuv2H1c
 sUuLfzWWB2MSMV1Epm50IoHs4xXZwhr21FFtLmjhGUIcIuCxW+eGnyp4gJT++avlKhSQFX5T7QP
 oWn6Ks2V+Jxf3MpFU4P+3mSwWpYPuDN4S0pbChI+6mmmNZm3ERLoRMbUHPa/2B7wwV85UfqHFJm
 1RdAGQeAHZ+ubILeiLVYmxaDWcHNixKOt3E5wn4zQmJysSkNi2xMvDdzHKbmggQW4Vu5+tWsPX0
 d+couqYd35oPtGlnT5NE8/qDCLIbQNMpFV62sWiCNNpBPhsa83WEfK5xBaBNzObEGJUjFQENDnD
 bWY+VHy3X5avjU23kHhW2/qIEuqD7to66PqMI5urgcOI/iIfIkbazoWQ+jDwgTJRX0Tk1WFjVti
 R5NwCoUxY/UvuyN4Mh87lpJQ==
X-Received: by 2002:a05:7300:8a9f:b0:36b:d3dd:2e9d with SMTP id
 5a478bee46e88-38570354704mr390049eec.19.1795119365957; 
 Thu, 19 Nov 2026 12:16:05 -0800 (PST)
X-Received: by 2002:a05:7300:8a9f:b0:36b:d3dd:2e9d with SMTP id
 5a478bee46e88-38570354704mr390025eec.19.1795119365422; 
 Thu, 19 Nov 2026 12:16:05 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:04 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 00/14] Hexagon: fix systests + migration
Date: Thu, 19 Nov 2026 12:15:49 -0800
Message-Id: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: xFOnIkwk6z985u__zrX3r4bP-IOIarRB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfXxUvgSuBBtOtj
 opk9ov6cTRS7OKz2hlsTBrM0o9DJEAmeEjaVI+LTgbmPiOFpkIixSFnYU7qsLFzC8IdWd6nO7vG
 mFq173TVMefM4Iaq49SPt9xavl9jtnQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX9oJaOWqacYFf
 VyaOSmlzhLDL1wI4Vfjb8Kb3ZBp4f6pNZSREFctBSN4G0H6nAMhjMO6c1qxm+kYPjvU4zG3kmgt
 hKhWelYmgbJKTf2PdD9izxkb/mpkFpdUEauoDZ+kaasJd82Fkk10rB/pbV7Onoz2TyDrRXucHaj
 sHE/c7IofZpAdsMvNN9Y7UT3h/8u5q9UOC/WmFioFfYAz9j1oIINPAM3NCXFCG1dC81Q/4JnSoI
 YTHNWcXZ8KDKXIiiewavKDj9iuXHvzUzVF3Cr16TGorRI50feBOHzk8tUaZiDTskWj+MqV5WFDf
 dhTD4djosNzssrtSK2TxlqYOs/t7Gu621hAnNvOOiom4GyeO3ohmoevTpBozrlL4ee0/hrHwhQz
 O49VC3wlfPbYgcQXgF0l4pp11fLPlj4xkdCkoflyUKY/QYPsP5lmtBC1hbVt0pqexBSSxAj5kl9
 ii7sIvb4K/5fEo2/yyw==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6aff5906 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=54gRSgWYPHZCgm90rTwA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: xFOnIkwk6z985u__zrX3r4bP-IOIarRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIHN5c3Rlc3RzL2FyY2ggdGFyYmFsbHMgd2VyZSBjcmFmdGVkIHdoaWxlIHRlc3RpbmcgYSBk
b3duc3RyZWFtIGZvcmsuCgpFbmFibGluZyB0aGUgb21pdHRlZCB0ZXN0cyByZXZlYWxlZCBhIGZl
dyByZW1haW5pbmcgYnVncyBpbiAxMS4yLiAgQWRkCnRob3NlIHRlc3RzIGFuZCB0aGUgYXNzb2Np
YXRlZCBmaXhlcywgcGx1cyBhIGNvdXBsZSBvZiBmaXhlcyBmcm9tIE1hcmNvJ3MKcmVjZW50IHNl
cmllcy4KCkJyaWFuIENhaW4gKDEyKToKICB0YXJnZXQvaGV4YWdvbjogZml4IGdldF9leGVfbW9k
ZSBhc3NlcnRpb24gaW4gaGV4YWdvbl9zdG9wX3RocmVhZAogIHRhcmdldC9oZXhhZ29uOiBkZWxp
dmVyIGZsb2F0aW5nIHBvaW50IGV4Y2VwdGlvbnMgYWZ0ZXIgdGhlIHBhY2tldAogIHRhcmdldC9o
ZXhhZ29uOiByZXBvcnQgdGhlIGZhdWx0aW5nIHBhY2tldCBmb3Igc3RhY2sgbGltaXQgZXhjZXB0
aW9ucwogIHRhcmdldC9oZXhhZ29uOiB0YWtlIGV4Y2VwdGlvbnMgZm9yIGNhY2hlIG9wZXJhdGlv
bnMKICB0YXJnZXQvaGV4YWdvbjogcmFpc2UgZGVjb2RlIGZhaWx1cmVzIGF0IHRoZSBmYXVsdGlu
ZyBwYWNrZXQKICBody9oZXhhZ29uOiB1cGRhdGUgdGhlIGdsb2ItcmVnIHZtc3RhdGUgdmVyCiAg
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uOiBydW4gdGhlIHJlc3Qgb2YgdGhlIHRlc3RzCiAgdGVz
dHMvdGNnL2hleGFnb246IHBhY2tldCBhbmQgQ09GIGNvcm5lciBjYXNlcwogIGh3L2hleGFnb246
IGhvbm9yIGNvbmZpZ3VyZWQgUkFNIGJhY2tlbmRzCiAgaHcvaGV4YWdvbjogdmVyc2lvbiB0aGUg
dmlydCBtYWNoaW5lIHR5cGUKICB0ZXN0cy9xdGVzdC9taWdyYXRpb246IGFkZCBIZXhhZ29uIHRv
IHRoZSBtaWdyYXRpb24gZnJhbWV3b3JrCiAgdGVzdHMvcXRlc3Q6IGFkZCBhIEhleGFnb24gbWln
cmF0aW9uIHN0YXRlIHRlc3QKCk1hcmNvIExpZWJlbCAoMik6CiAgdGFyZ2V0L2hleGFnb246IHJl
YWQgdGhlIG9sZCBwcmVkaWNhdGUgdmFsdWUgdGhyb3VnaCBDNAogIHRhcmdldC9oZXhhZ29uOiBi
b3VuZCBwYWNrZXQgbG9va2FoZWFkIHRvIHRoZSBjdXJyZW50IHBhZ2UKCiBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGRvY3Mvc3lzdGVtL2hleGFn
b24vbWFjaGluZXMucnN0ICAgICAgICAgICAgfCAgIDMgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Zy5oICAgICAgICAgICAgICAgICAgICB8ICAxOCArLQogdGFyZ2V0L2hleGFnb24vaGVscGVyLmgg
ICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgg
ICAgICAgICAgICAgICAgICB8ICAgNiArLQogdGVzdHMvcXRlc3QvbWlncmF0aW9uL2Jvb3RmaWxl
LmggICAgICAgICAgICB8ICAgNiArCiB0ZXN0cy9xdGVzdC9taWdyYXRpb24vaGV4YWdvbi9hLWIt
a2VybmVsLmggIHwgIDIxICsrCiB0ZXN0cy9xdGVzdC9taWdyYXRpb24vaGV4YWdvbi9ndWVzdC5o
ICAgICAgIHwgIDQ3ICsrKwogdGVzdHMvcXRlc3QvbWlncmF0aW9uL2hleGFnb24vc3RhdGUuaCAg
ICAgICB8ICAyOSArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAg
ICB8ICAxMCArLQogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgICAgICB8
ICAgNCArLQogaHcvaGV4YWdvbi92aXJ0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAz
NyArKysKIHRhcmdldC9oZXhhZ29uL2FyY2guYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkg
Ky0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAgICAgICAgfCAgIDEgKwog
dGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQogdGFy
Z2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDQ2ICsrLQogdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICB8ICAyOCArLQogdGVzdHMvcXRlc3Qv
aGV4YWdvbi1jb25maWctdGVzdC5jICAgICAgICAgICB8ICAyNiArKwogdGVzdHMvcXRlc3QvaGV4
YWdvbi1taWdyYXRpb24tdGVzdC5jICAgICAgICB8IDMxMiArKysrKysrKysrKysrKysrKysrKwog
dGVzdHMvcXRlc3QvbWlncmF0aW9uL2Jvb3RmaWxlLmMgICAgICAgICAgICB8ICAgNCArCiB0ZXN0
cy9xdGVzdC9taWdyYXRpb24vZnJhbWV3b3JrLmMgICAgICAgICAgIHwgICA4ICsKIHRlc3RzL3Rj
Zy9oZXhhZ29uL2JyZXYuYyAgICAgICAgICAgICAgICAgICAgfCAgMjUgKysKIHRlc3RzL3RjZy9o
ZXhhZ29uL2NpcmMuYyAgICAgICAgICAgICAgICAgICAgfCAgNDIgKysrCiB0ZXN0cy90Y2cvaGV4
YWdvbi9kdWFsX3N0b3Jlcy5jICAgICAgICAgICAgIHwgIDM0ICsrKwogdGVzdHMvdGNnL2hleGFn
b24vbWVtX25vc2h1Zi5jICAgICAgICAgICAgICB8ICA1OCArKystCiB0ZXN0cy90Y2cvaGV4YWdv
bi9wYWNrZXRfdXNlci5jICAgICAgICAgICAgIHwgIDM4ICsrKwogdGVzdHMvdGNnL2hleGFnb24v
cHJlZ19hbGlhcy5jICAgICAgICAgICAgICB8ICA1OCArKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi90
ZXN0X2NvbmRfYnJhbmNoLmMgICAgICAgIHwgIDk1ICsrKysrKwogdGVzdHMvdGNnL2hleGFnb24v
dXNyLmMgICAgICAgICAgICAgICAgICAgICB8ICAzMyArKysKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi9tZXNvbi5idWlsZCAgICAgICAgfCAgIDIgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3RfYXJjaF90ZXN0cy5weSB8IDExNCArKysrKystCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFn
b24vdGVzdF9saW51eC5weSAgICAgIHwgIDYyICsrKysKIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5ICAgfCAyNTkgKysrKysrKysrKysrKysrLQogdGVzdHMvcXRlc3Qv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQogdGVzdHMvcXRlc3QvbWln
cmF0aW9uL01ha2VmaWxlICAgICAgICAgICAgICB8ICAgMiArLQogdGVzdHMvcXRlc3QvbWlncmF0
aW9uL2hleGFnb24vTWFrZWZpbGUgICAgICB8ICA0OCArKysKIHRlc3RzL3F0ZXN0L21pZ3JhdGlv
bi9oZXhhZ29uL2EtYi1rZXJuZWwuUyAgfCAgMzcgKysrCiB0ZXN0cy9xdGVzdC9taWdyYXRpb24v
aGV4YWdvbi9ndWVzdC5TICAgICAgIHwgMTI0ICsrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3Rf
ZG90bmV3LlMgICAgICAgICAgICAgfCAgMzQgKystCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X3Bh
Y2tldC5TICAgICAgICAgICAgIHwgIDQ2ICsrLQogNDIgZmlsZXMgY2hhbmdlZCwgMTcwMCBpbnNl
cnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVz
dC9taWdyYXRpb24vaGV4YWdvbi9hLWIta2VybmVsLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9xdGVzdC9taWdyYXRpb24vaGV4YWdvbi9ndWVzdC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvcXRlc3QvbWlncmF0aW9uL2hleGFnb24vc3RhdGUuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3F0ZXN0L2hleGFnb24tbWlncmF0aW9uLXRlc3QuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3RjZy9oZXhhZ29uL3BhY2tldF91c2VyLmMKIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9saW51eC5weQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3F0ZXN0L21pZ3JhdGlvbi9oZXhhZ29uL01ha2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvcXRlc3QvbWlncmF0aW9uL2hleGFnb24vYS1iLWtlcm5lbC5TCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvcXRlc3QvbWlncmF0aW9uL2hleGFnb24vZ3Vlc3QuUwoKLS0gCjIuMzQuMQoK

