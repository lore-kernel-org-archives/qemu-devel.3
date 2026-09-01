Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707C4C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SN9-0005aF-9V; Tue, 01 Sep 2026 13:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN3-0005Xv-Ec
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN1-00080n-Oo
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H6QCl2033274
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uRXMpWYP4aEFj13LYG0i9lWd6tmMXkmCiJ+ebFTu87Y=; b=faZk62dN7EsRgyCv
 yclJl25nIWLeWNXQl3ZsYZP5mucF8MgnYvKZVYE26vb8szVPL6ZwVfcoIcPqm0Bq
 /V4MK5YSmGgob50d3KuOb9AQQVjlXwHX6EwqaxOgm+gXroc0pfgqqGjqa65Hmtn2
 /ZiJxRuTt2rBugl5bpJb5NCZbjONMSjBKeQNc9UF+iK4RiWnAv6Sj/O9daG6/Rpf
 6c95RLJ7NQAKQrXN3ld4NXO/okCX37V/kzyTIetT9bdwHRQ8yqi3Y9VfD04F3HhQ
 011IKUqwd+d8CxL43OIMZPE2PhDEOJg5V/nIGr+au3NMSJBQi35wA+rMi1NdbRKN
 5LXZtA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcskd67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so201045a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284042; x=1788888842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uRXMpWYP4aEFj13LYG0i9lWd6tmMXkmCiJ+ebFTu87Y=;
 b=GjLdKyepTohByQJyme7NnS8nI19xf8S9IQcIPjaYGEch68HzJH4k7KTWs/bJRrU6ll
 ojAuwM4amUJxw1y34+/zlnBUElbJk2JvO2KT3UgrmMS2BKGt1cHgche3FZVigO5SYe+6
 5lqE7Pam0dkVqkzYRiQj6y5Ib9iz5dOt+h2X7IyND+15RgIahlQjVJTqxIWIYRW+6/dh
 lNDYJL2wJx6YYG9ScCBfDAouIf0nx2PlflU4geIZYoPG1AL2U1WA66dg81oVlRo/N+o3
 Lgb+6yybO9PtSWvXO4qj7bBYlynf7zSbvXGfiLYU8PKuPK0aZIapgweWRQs3mI4KPgvK
 lwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284042; x=1788888842;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uRXMpWYP4aEFj13LYG0i9lWd6tmMXkmCiJ+ebFTu87Y=;
 b=HDeUvyvZuWMRMCeMPD6k0TC5f5igLwW7eJajXIWExhqAc/rKpz0RxfDj8N309lbasH
 ruovHyDzWfpgXNMnc11U1uxfSld+ZCU+gkH4QAVGrQjj8UbAOMdzn/l5XuX6XgvHfvId
 VDlB1WGpY6EPXm5Pb2Vo1ZHu5P2Dr+bfWb3J/2hfO51u0dOuOAY9GK+98N+IZnMtK+5O
 CcEN/w6hVYMVX8JIIswzo1I5cTenxZoW+RkmeQw9Wk+EDoxuFBwCEaSI9Zu1roRC6xNy
 XuwsobLAcvkhxe2iiblOzOsjJwd9pmKeZCwOpVJ37aMRxYcM5TLpElcOHZojm0DzsKDs
 v1fw==
X-Gm-Message-State: AFuF++nt4dH8QeflWw5YjLLkOnBNDQk4eMYPgENq/x4/CqlmSQI/zHQ6
 f1BJ6tdG4Dafn+jrW9W6Pvv0yR2rl+a2yGHN/a58M57gBdvzjkxbD/8z8/vvv7+X/lM1hdp4jao
 4fOADQU6CxA7uyaiZ61JgOe+ikxc4ckqDLJmVtfSf/HJ+HYe2wyJSq4J4Bb38TbgedQ==
X-Gm-Gg: AYBFou0QGvSLJtUtqJ1lJ8tPa60NRac1shSbzsqixBZLre+p3I0rrEJxPCZ2sK+6q5S
 h3Sx41X7Ifj/qyM+FZm4yWmFsnFqpXvHwEtuc1qJSlp1e2zsyBlLxmP/6WWHYnv9DbngNmwbVDp
 fK7BSYRQgHWY58ZR2hDLemoch66ddekxPlMT9is/MfpixJx5MAjmfQ0zZdTQgdRfRdTkSV6unMd
 RsZwahH+0kDrCNe0RNTDKGXnRwE4J9stqNj+TkX6pGGZEjww27SUzyq0gTj5dSV5JS/bSd37VyF
 fYkwbkQug/hA6kaXgUgoa2DFDwItF4/DaZyel+1+NLDtceU5uDdzpPSZ61Y70mR2GS4lljGz6Kr
 eVuyk3EXlox8y1+jI6OKqCeFGb30AQen4aD9qLSEwROxNnyPD
X-Received: by 2002:a17:90a:e7cb:b0:398:bbe9:73af with SMTP id
 98e67ed59e1d1-398bbe97548mr28316351a91.7.1788284041666; 
 Tue, 01 Sep 2026 10:34:01 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cb:b0:398:bbe9:73af with SMTP id
 98e67ed59e1d1-398bbe97548mr28316276a91.7.1788284041164; 
 Tue, 01 Sep 2026 10:34:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:33:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 04/11] target/hexagon: guard writes to unimplemented guest
 registers
Date: Tue,  1 Sep 2026 10:33:46 -0700
Message-Id: <20260901173353.200474-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXxn5IwD1Utgqz
 5N6fQDbYtwneFbP7xeP8p8Hcp4DDXR/OczIT5Sq/G1aCAx8RqvEjDMtLR7SKx6388ATtynQaK9p
 yaiCqTH2hMqPEGtDbIFK/SLV3t3x62U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX8yKeaE1UGPWy
 hrK+NLkbjwB9PZhkweP0jEIZKKXO7wuPz5vXFqg1N6iHlgpO5fjwPU/JCxiDVFtMSyEVaWArMhZ
 Aqx2eXOWs5j7WebZUVmLQ5TDd3NuvQsGa1gDaO6e10RS/+siwYwSOW7SUiqY17DhuLCc1fDRWFd
 2Cm2tpshJUErdYqP7zRlsrM/zZNJfeLs0K8UUHc4v8GAsrLrUuEuNOmBzl9EuYLsU9qlh9ElzmK
 eil3nAm4RfRZtxoquYrH/F1iUgIXuQ6GsZZp+R3jb4gco+NMH0oUscFLAOgppLymXS4sTt/0hF0
 faU00fPUtGfGfm0zXmE94lNzox/yCgn4UQ8eIINZpTYDWg+LVl8QP1Knm9rjDE9iIlNOAas5crq
 lQyTzgg9dw/5yIV+67YuP/+t2YUQlIginw3xDHx9Ld8GN3Ap7N7UX1t3+FPI1SZPuWb3XfD6lkU
 eGZ347ouLKjDuA367oQ==
X-Proofpoint-GUID: R6Vqbmxb7hsxJdqlFvIdINc0jim3heSx
X-Proofpoint-ORIG-GUID: R6Vqbmxb7hsxJdqlFvIdINc0jim3heSx
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a970c8a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=q6_NcmobPIDMa4dJqmQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010155
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

R3Vlc3QgcmVnaXN0ZXIgRzQgYW5kIGFib3ZlIGhhdmUgUE1VLWlzaCBmZWF0dXJlcyB0aGF0IGFy
ZSB5ZXQKdG8gYmUgaW1wbGVtZW50ZWQuICBXZSdsbCBza2lwIHRoZXNlIHdoZW4gd2UgZW5jb3Vu
dGVyIHRoaXMgY29kZQpyYXRoZXIgdGhhbiBmYXVsdCBvbiBhbiBhc3NlcnRpb24uCgpOb3RlIHRo
YXQgdGhlIGdlbmVyYXRlZCBjYWxsIHRvIGdyZWdfd3JpdGFibGUoKSBoYXMgdGhlIHNpZGUtZWZm
ZWN0Cm9mIGRvaW5nIGEgTE9HX1VOSU1QIGZvciB0aGVzZSByZWdpc3RlciBhY2Nlc3Nlcy4KClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgIHwgIDQgKysrLQogdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weSB8IDE4ICsrKysrKysrKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggMDBkZTJi
MGQyZWMuLmQ4NjI4MzgzZjFkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
aAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtOTcsNyArOTcsOSBAQCBib29s
IGlzX2dhdGhlcl9zdG9yZV9pbnNuKERpc2FzQ29udGV4dCAqY3R4KTsKICNpZm5kZWYgQ09ORklH
X1VTRVJfT05MWQogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNhc0Nv
bnRleHQgKmN0eCwgaW50IHJudW0pCiB7Ci0gICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdfRzMp
OworICAgIGlmIChybnVtID4gSEVYX0dSRUdfRzMpIHsKKyAgICAgICAgcmV0dXJuOworICAgIH0K
ICAgICBjdHgtPmdyZWdfbG9nW2N0eC0+Z3JlZ19sb2dfaWR4XSA9IHJudW07CiAgICAgY3R4LT5n
cmVnX2xvZ19pZHgrKzsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24u
cHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CmluZGV4IGUzM2Q0M2UzY2UwLi5jMTgw
YzE5YjA5MiAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90
YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0xMDk3LDExICsxMDk3LDI0IEBAIGRlZiBh
bmFseXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIpKQogCiBjbGFz
cyBHdWVzdFJlZ2lzdGVyKFJlZ2lzdGVyKToKLSAgICBwYXNzCisgICAgZGVmIGdlbl9jaGVja19p
bXBsKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgaWYgc2VsZi5pc193cml0dGVuKCk6CisgICAg
ICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAgICAgICAgaWYgKCFncmVn
X3dyaXRhYmxlKGluc24tPnJlZ25vW3tyZWdub31dLAorICAgICAgICAgICAgICAgICAgICB7c3Ry
KHNlbGYuaXNfcGFpcigpKS5sb3dlcigpfSkpIHt7CisgICAgICAgICAgICAgICAgICAgIHJldHVy
bjsKKyAgICAgICAgICAgICAgICB9fQorICAgICAgICAgICAgIiIiKSkKKyAgICAgICAgZWxzZToK
KyAgICAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAgICAgICAgICAgICAgICBjaGVj
a19ncmVnX2ltcGwoaW5zbi0+cmVnbm9be3JlZ25vfV0sCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHtzdHIoc2VsZi5pc19wYWlyKCkpLmxvd2VyKCl9KTsKKyAgICAgICAgICAgICIi
IikpCiAKIGNsYXNzIEd1ZXN0RGVzdChHdWVzdFJlZ2lzdGVyLCBTaW5nbGUsIERlc3QpOgogICAg
IGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgc2VsZi5kZWNsX3Jl
Z19udW0oZiwgcmVnbm8pCisgICAgICAgIHNlbGYuZ2VuX2NoZWNrX2ltcGwoZiwgcmVnbm8pCiAg
ICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKICAgICAgICAgICAgIFRDR3ZfaTMyIHtzZWxm
LnJlZ190Y2coKX0gPSB0Y2dfdGVtcF9uZXdfaTMyKCk7CiAgICAgICAgICIiIikpCkBAIC0xMTIx
LDYgKzExMzQsNyBAQCBkZWYgZGVjbF9yZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKICAgICAgICAg
IiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNl
bGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQorICAgICAgICBzZWxmLmdlbl9jaGVja19pbXBsKGYs
IHJlZ25vKQogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAgICAgICBUQ0d2
X2kzMiB7c2VsZi5yZWdfdGNnKCl9ID0gdGNnX3RlbXBfbmV3X2kzMigpOwogICAgICAgICAgICAg
Z2VuX3JlYWRfZ3JlZyh7c2VsZi5yZWdfdGNnKCl9LCB7c2VsZi5yZWdfbnVtfSk7CkBAIC0xMTMx
LDYgKzExNDUsNyBAQCBkZWYgYW5hbHl6ZV9yZWFkKHNlbGYsIGYsIHJlZ25vKToKIGNsYXNzIEd1
ZXN0UGFpckRlc3QoR3Vlc3RSZWdpc3RlciwgUGFpciwgRGVzdCk6CiAgICAgZGVmIGRlY2xfdGNn
KHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdu
bykKKyAgICAgICAgc2VsZi5nZW5fY2hlY2tfaW1wbChmLCByZWdubykKICAgICAgICAgZi53cml0
ZShjb2RlX2ZtdChmIiIiXAogICAgICAgICAgICAgVENHdl9pNjQge3NlbGYucmVnX3RjZygpfSA9
IHRjZ190ZW1wX25ld19pNjQoKTsKICAgICAgICAgIiIiKSkKQEAgLTExNTAsNiArMTE2NSw3IEBA
IGRlZiBkZWNsX3JlZ19udW0oc2VsZiwgZiwgcmVnbm8pOgogICAgICAgICAiIiIpKQogICAgIGRl
ZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgc2VsZi5kZWNsX3JlZ19u
dW0oZiwgcmVnbm8pCisgICAgICAgIHNlbGYuZ2VuX2NoZWNrX2ltcGwoZiwgcmVnbm8pCiAgICAg
ICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKICAgICAgICAgICAgIFRDR3ZfaTY0IHtzZWxmLnJl
Z190Y2coKX0gPSB0Y2dfdGVtcF9uZXdfaTY0KCk7CiAgICAgICAgICAgICBnZW5fcmVhZF9ncmVn
X3BhaXIoe3NlbGYucmVnX3RjZygpfSwge3NlbGYucmVnX251bX0pOwotLSAKMi4zNC4xCgo=

