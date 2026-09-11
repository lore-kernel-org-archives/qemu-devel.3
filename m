Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60745C88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5865-00076V-Uq; Fri, 11 Sep 2026 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5864-00076I-Vr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:43:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5862-000744-W8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:43:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BHWKKW810035
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 20:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=k6ovsSGU5mBdAYEsF3C9of
 VYNVfr86Khk9C7gvzFFHo=; b=B5lzKtSGBKLufzOhEQwvMfayKQgxf2bx8gPK65
 fVD9slQJwqKhGMKRr2ej6JGXp6Esht1toSv4/jnm2bSTuF6RrpaSXF2LHMiYBmoR
 5t92FfM3SOPljpHGC3P0zCeS/PCmkrAMj+l7eJ5S5J4GKSif4lTXgQN0/8YGpSk7
 oN+4A3Z5egwlWOHIFR6tV7EwzduLFwlh2WrUncLB9cjlaX0TTI0S2/OJRa4NAuD0
 fjtFH02Ijpv1YiF40szHFVCLnF5O3KUbR2nWdP9rkBSVBke3Ln83whZ4bqEqS28U
 IEroz1QGFbSm5gdBwqD42AlD04rEBbxijtNxSty0ymYwY1fA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmnv20qu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 20:43:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db8c152622so12860625ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789159419; x=1789764219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k6ovsSGU5mBdAYEsF3C9ofVYNVfr86Khk9C7gvzFFHo=;
 b=fMNZfIG+/b2nKsMtcfcv9zp+HUKq2QaGt2i60UzAYeWdR4nyvmkizp6F5vZGomRRhR
 0pFsInJluRwoBxT5cpaLNDXkgbyi+eYpiz9pupyFy+8+/96QTUXMgmJIRfB2olrJBPKU
 anp0mCfENYXgQMPmIevZvJB+CQG6RLnUBFoXd37UXMD4+qSIrVnxx19plP1uBw7G+RAe
 vhLdX4vObNPU2GC25cZXKCUvKHPaJudBcoudv6rph0ovMgGejbhwrpNYRjUZC0OePIhe
 2A+dhzFbcBaiYIyaksqAtaeoDuQN+rmatAKwGq09w807h4ESrCTnHp3szq5cCXYEUvjn
 QNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789159419; x=1789764219;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k6ovsSGU5mBdAYEsF3C9ofVYNVfr86Khk9C7gvzFFHo=;
 b=PkWubUWgVUFriQZznhcjyPg0qkQYJ7FPGrBP2W71vQgPHc515r0usG3tzXcVW9pNkv
 SRPzt3fVJU5/7ZrozWKgldmlaLRHP5mr0ROV7GYHEwkcKCbHeIJJxiZBYaJCt/4LF8LD
 iw7+5sSq59YpNSkkU/haA+aRN6tUWnt5xR87z3AWm9J6iBo3NcxOKqiBQU8lB/Ecq2tt
 yL85OwMO1SubIZW46gclBumHzsCZwz24TvwhvvncKpeJPdzF2n0E63bPyQ1CpQ36jxb9
 eFmsOHRUObgSM6qA/kmmukVvvtP+P47YArsOQ7P0Uif24Tmme4fkNQnTvSC5QjrEq1SI
 QVtg==
X-Gm-Message-State: AFuF++nOshhKRt6GCUzAcjSIOrPRy8qL9mLq5ZAtzxXoM7gJGjXYQVRm
 Eyv7H4RE4q46tehas0hoog9zzJk797VJhzfh79V2xmTo6/ImvKvVCiw5iVOfBlZcdx8FJU9e1r4
 9d6iP0zmWxuVtO9EbAy7ysK9gM3mRkMiNAjAWl9VveV4tL+Vsjd93CJNPYo7IjS94bQ==
X-Gm-Gg: AYBFou1PPjEpVtVgzfNyPNUas+jxmfiV4P6lzeJMFIf//MaP+pY0AFjrfLt9FgTBaM5
 SIRbzLKpUJnRuWIyWATUPFcsmFh2a3UtfKVc27VqQVqbUK7hrSenzdS1n9NG/o6H/l0vpRJQEE7
 TVc64W4iDr0R8FKjgW8xqlnd3UlDAnEIbeyDlZmPs/acCScowtN4Yo8jNB30Ic8cfzLIznPf2xV
 ooVv5ci1E1a1KFKWU2GgfaqioBFIFhZ79JM0tFMgbDwu07EKe9WmKfKvs0HzPgsaBZ3Vo060L1u
 B0NZCXDqLTOpWfmcwUGFnuDdIcQkCSMjT1is8jHZNTHKgF5LuDOcgyPavj/D04MKm3PnLT2Gw8a
 lgm9nl+oOrmhU3Cd8dWetTPl1dcF7Y4IkSvPDiTozNTBCt6k6
X-Received: by 2002:a17:903:acd:b0:2da:e967:7953 with SMTP id
 d9443c01a7336-2dd2a336839mr106702065ad.12.1789159419364; 
 Fri, 11 Sep 2026 13:43:39 -0700 (PDT)
X-Received: by 2002:a17:903:acd:b0:2da:e967:7953 with SMTP id
 d9443c01a7336-2dd2a336839mr106701785ad.12.1789159418927; 
 Fri, 11 Sep 2026 13:43:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm9735743eec.28.2026.09.11.13.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:43:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH v2 0/6] hexagon: Add HVX context
Date: Fri, 11 Sep 2026 13:43:28 -0700
Message-Id: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI5MiBTYWx0ZWRfX2zfnwFsXn7OM
 oudfZBBuMXLT6kfCJKA3Rb3KlglPu5qaWB8KjQtUgyhsEaJRutuiC3apyxNTe30ZOSS71CVL6Q8
 H+AhhJge/hx/7yDFwRR8KPgiLePvz9c=
X-Proofpoint-GUID: cJuBvCuAtW0uonfByyEqOdsAuR4Kj87w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI5MiBTYWx0ZWRfX74Qk6AfUiaNz
 d80ivSa5e9jYqOGW5zvh0bi44H1phkdQQtqqZ9ZguRHVKYLJurDGKMJbKc/YCgJPsmbft2KS93E
 AThXE3JGFX47h27DPW1FQunp1bLkJFe7uKSXbo2wKHL7STF2CJdIFGqqSI0oFT5RXQjC7VOLHq0
 x60ugRKiN7Qt8u2NizkEkhk4lyqh62/Om8tOZFQutFXq+/Ux0BSmgTaDcJ5E03nRpxrmj0MnpTD
 VfdJuCu0MCHVFaZnYyEVzIMsZygrhgi/eNZHsRNCJxgR3lOKQX0viRgAncr9C4AjRH/zY1kAnuV
 84/SUZqKtO9nif8Jzq7d9Cj2EO86A5dkmRqMZlzYHgJjThorZBqXEtFPLpXcqcoyHWRO10zXZUm
 QxTPCdiP1zyLhf0CxfxZ9Ej0vtHgWxvNp/klfiX5xAP7vs4HB48yqpQSQ48LmVEuh3+iFo0bW2f
 3aE26VJ1x/Ruh1arViA==
X-Proofpoint-ORIG-GUID: cJuBvCuAtW0uonfByyEqOdsAuR4Kj87w
X-Authority-Analysis: v=2.4 cv=XvdvqlF9 c=1 sm=1 tr=0 ts=6aa467fc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0WyL-R9DJl2wsrhYlPIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110292
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIEhWWCBjb250ZXh0cyB0byBIZXhhZ29uIHRyYW5zbGF0aW9uLCBuZWNlc3NhcnkgZm9yIHN5
c3RlbSBlbXVsYXRpb24uCkNoYW5nZSB0aGUgSFZYIGluc3RydWN0aW9uIHRyYW5zbGF0aW9uIHRv
IGFjY2VzcyB0aGUgY29udGV4dCB2aWEgYSBiYXNlCnBvaW50ZXIuCgpNb2RlbGluZyB0aGUgSFZY
IGNvbnRleHQgbWFwcGluZyB3aGlsZSBhdm9pZGluZyB0aGUgbmVlZCB0byBjb3B5IHRoZQpjb250
ZXh0IHdoZW4gdGhlIE9TIHNjaGVkdWxlciBkZWNpZGVzIHRvIHJlbWFwIHRoZW0gcmVxdWlyZWQg
c29tZSBnZW5lcmFsClRDRyBndmVjIGNoYW5nZXMgdG8gZW5hYmxlIHNvbWUgbW9yZSBfdmFyIGZv
cm1zLgoKSW4gdjI6Ci0gUmVtb3ZlZCB1bnVzZWQgZGVmYXVsdCBodnggY29udGV4dCBmcm9tIHRh
cmdldC9oZXhhZ29uL2NwdS5bY2hdLCBhZGQgYQpoZXhhZ29uX2h2eF9zZWxlY3RfY29udGV4dCgp
IHRvIHRoZSByZXNldCBpbnN0ZWFkLgotIGNvbWJpbmVkIHRoZSBIVlggcG9pbnRlciwgUU9NIGNv
bnRleHQsIGFuZCBTU1I6WEEgc2VsZWN0aW9uIHdvcmsgY29tbWl0cwppbnRvIGBzaGFyZSBIVlgg
Y29udGV4dHMgYW1vbmcgQ1BVc2AuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI2MDkxMDE1MzIyMS4xNjc0Mjg1LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
LwoKQnJpYW4gQ2FpbiAoNik6CiAgdGNnOiBzcGxpdCBvdXQgX3ZhciBmb3JtcyBvZiBndmVjIGxv
Z2ljYWwsIGFicyBhbmQgbWluL21heCBvcHMKICB0Y2c6IGFkZCBiYXNlIGFyZ3VtZW50cyB0byB0
aGUgZ3ZlYyAycywgZHVwX2kzMiBhbmQgY21wIGV4cGFuZGVycwogIHRjZzogc3BsaXQgb3V0IF92
YXIgZm9ybXMgb2YgZ3ZlYyBzYXR1cmF0aW5nL211bC9zaGlmdC1pbW1lZGlhdGUgb3BzCiAgdGFy
Z2V0L2hleGFnb246IHJhaXNlIGFuIGV4Y2VwdGlvbiBmb3IgSFZYIHdpdGggU1NSOlhFIGNsZWFy
CiAgdGFyZ2V0L2hleGFnb246IHNoYXJlIEhWWCBjb250ZXh0cyBhbW9uZyBDUFVzCiAgdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uOiBhZGQgdGVzdF9odnhfY29udGV4dCBhcmNoIHRlc3QKCiBpbmNs
dWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgICAgICAgIHwgICAxICsKIGluY2x1ZGUv
aHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmggICAgfCAgMjcgKwogaW5jbHVkZS90Y2cv
dGNnLW9wLWd2ZWMtY29tbW9uLmggICAgICAgICAgICB8ICA5NyArKysKIHRhcmdldC9oZXhhZ29u
L2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTcgKy0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19odnguaCAgICAgICAgICAgICAgICB8IDYwOCArKysrKysrKysrLS0tLS0tLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5wdHIuaCAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsKIHRhcmdldC9oZXhh
Z29uL21tdmVjL21hY3Jvcy5oICAgICAgICAgICAgICAgfCAgMTQgKy0KIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oICAgICAgICAgICAgICAgICAgfCAgIDcgKy0KIGh3L2hleGFnb24vaGV4LXN1
YnN5cy5jICAgICAgICAgICAgICAgICAgICAgfCAgMzYgKysKIGh3L2hleGFnb24vaGV4YWdvbl9o
dnhfY29udGV4dC5jICAgICAgICAgICAgfCAgODMgKysrCiBsaW51eC11c2VyL2hleGFnb24vY3B1
X2xvb3AuYyAgICAgICAgICAgICAgIHwgICAyICsKIGxpbnV4LXVzZXIvbWFpbi5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDMgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICAg
ICAgICAgICAgICB8ICA3MiArKysKIHRhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyAgICAgICAgICAg
ICAgICAgICAgfCAgMTYgKy0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAg
ICAgICAgfCAxMDIgKystLQogdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jICAgICAgICAgICAgICAg
ICAgICB8ICAxMiArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAg
IHwgIDM3ICstCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwg
IDczICsrLQogdGNnL3RjZy1vcC1ndmVjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDYx
NyArKysrKysrKysrKysrKy0tLS0tLQogaHcvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAg
ICAgICAgIHwgMTgwICsrKy0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weSB8ICAgNyArCiAyNCBmaWxlcyBjaGFuZ2VkLCAxNDMxIGluc2VydGlvbnMoKyksIDYy
MiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vaGV4
YWdvbl9odnhfY29udGV4dC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXhhZ29u
X2h2eF9jb250ZXh0LmMKCi0tIAoyLjM0LjEKCg==

