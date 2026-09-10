Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648EC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4gnO-00030n-28; Thu, 10 Sep 2026 11:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4glM-0002HY-J2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4glK-0005KR-7V
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4MLt1494264
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CM6kLQS5NZndmzOyA3vV+Q
 vlzVb2m8UxwUiddyl7L60=; b=gqFDrz0xfI9deO9k+fECPMAIL3POZjWro5lOiT
 HC+bMwk76JgJb8pAdA3/oYauMq7CQ/MVy9MlYKA3qlTEg6tuZoiQwRxmaqxhoveH
 Zq/twR3wrPV90fE/PrG6l4q0v70TIlYrY5fYlC6NEMt3g07s1uLwOSCzoWogNlGe
 Jh9SJ20jlSKkYoRG95PRLkr+IPXkaFCsXkGzDJVGS2oL9CPZ0seqOON0G08vlijO
 i7coZcldeRNXGUPk8QkIbMFouohysLOyKqjl1itrIx6ZEspZTyOQBu4E19hEk+bn
 2w498diNox2A3j/1m58+EA8NBNEqaAkKxOPUi/QTPJw9+r/A==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9rntd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:27 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b38ea4c6acso4583085b6e.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789054347; x=1789659147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CM6kLQS5NZndmzOyA3vV+QvlzVb2m8UxwUiddyl7L60=;
 b=COWW8ehMjNCBSxCqk8RfvquvZM05ad18wJV1y0/qr1qjEMRmfSlyk6jG+DP+WcQR1J
 0ws2poepBiYv0xQkzpG+rAuAnRn725BSaQaSe9f0akcFMxKJO4akXi8Rwb9rg8J+I4Lu
 iJy/IO3Qfo6kRTd85pMd1nYbtD6rfLAmXnuXsDXZSBAAVswnUqBMd+pYItdwHhDDlYYB
 gOc3MporqcAXtuAesmEDhoGKhEzr8yZemWEyKDBx37s/1zDION7IrbQcvV709Z0xflWd
 CAI07mGldze9ZahSSZT9RywTD6ZQg7IrSr4gyyaSN0KOMVP6pk/hxi20cz35gNDTWQfU
 PcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054347; x=1789659147;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CM6kLQS5NZndmzOyA3vV+QvlzVb2m8UxwUiddyl7L60=;
 b=KmUvknW8sMbGGS6lvEBNRkq6ZUcOKDg+pUDAwv3jsOp0xUJtDv3ZUCmLT1SrVU6F6q
 eecsb+YplC2yTigSq5WVhy8Wt1ruUoL+tDms/pEqnlD7KnUqcZWqD1atCn6AyJSbCzZv
 gTiXAI/KrjiOmn9AMHBaU0Aio02npHWylN5zi797+bIGcmCbxYkgws/nj9agVXEs2zOn
 eK1jxKIPfHefLPtBwCbOlu2zwDbv+yl5/LrqsWCp6u6WcMAUexGnBK9XY2+n5GnKNoaR
 keKgzPZujH4fuwjwvBgK+ScjjJNrdje4X0aFTddD4O+swmARTf0Z/TuVWsq5bpwrD4t6
 II/A==
X-Gm-Message-State: AFuF++laOOAdQ/BjTMGgq8CInSSYxDN3pTjXWvgKG90JcBSpIQFUs/cT
 xxTGRf0hvmkXlU9AWgLn1t13VQTpKygsrwNeke7IrjdEXdisRrtOWIkz5bvTZffZvJFO9YJIYbo
 ufrOaEt2RbyrTW3wgm//hkQ96duHinArpazMxu5ngQa26IbdnCLzA+3Q4VCOzWrgqNg==
X-Gm-Gg: AYBFou0iwYhCZv0KrLUb3nmj6CuzQ47ciP8TCj5tGW3dnYSub8GEQtM6aVd1/e9GZjF
 AupSGy/62bwxkx6FeZ4MOSsR6lfXLB5uYLxR7fRsBwNVg2S2ahcxX03TpIYBxASigX8OrjQH5cB
 r3uDuni8yozjpmn93YriTmePg0HPpeB2gzRo4K/5l10vZc1yci4sHKjKhjUhL1CLNP1B8SSnKG4
 YeDOgjs1IYDbCGmNwBERxfTYVyMTgWl3mltk2z1Kq7K7hGIWGAz6IhKMAtNASxoX0eFztvVdBr0
 PAHD+7oeprlnc5CisF0451GTDTw8NHOxDXAKtiIU68RksKm5VL8iQS7Tr24+uZns4fBpSebUHwn
 tpV7X4M6HCdRhQ9lAf/G34zWWJ9cWrFL7msvCFMWcrviGZ9le
X-Received: by 2002:a05:6870:e6c8:b0:465:fdf:bd44 with SMTP id
 586e51a60fabf-47551908bdfmr24339772fac.14.1789054346986; 
 Thu, 10 Sep 2026 08:32:26 -0700 (PDT)
X-Received: by 2002:a05:6870:e6c8:b0:465:fdf:bd44 with SMTP id
 586e51a60fabf-47551908bdfmr24339734fac.14.1789054346564; 
 Thu, 10 Sep 2026 08:32:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm19563727fac.6.2026.09.10.08.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:32:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/9] hexagon: Add HVX context
Date: Thu, 10 Sep 2026 08:32:12 -0700
Message-Id: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfXw8mibTLujXab
 Fdx4+v1s17hbprC3m17viQAiaqxANT7dny3jwjSD6rxZkN7Wb8FnMvMdoPNvCibo3F+nZrKvdX6
 joJ+SKT7J7ktiv79HbdpF03CruL7ZH2S8wwq2Us/+geYzIfWSe3K9hNdRNJtNdxCvTnyzUPQO1+
 NimWyj9p0xp+GHUjm7j1r9VasNGphY56KmnPk6yiIbFyGp8Ws+4OiGeaCSVcLDPzqx7dhvkaSs3
 Gly8sqTj+Kk7FwpyzZMX1oBffZSIvxY/JZp/0cK1Rej7X0Zww6KtzA6qmygQRHMW3XAlAD8BEKN
 GIs6Yx2Nhrsw4WYMixR7/t8Eo17x8SNZd+17j/t39doBe+ASH+We2pbH3oJltpRoAu5ylIQ+ene
 fk48j9MSI8J+tSQcXvbKZb5FcPcAHsikgqB5GBkMwkrv5Gn9R+TfL+fBMcejTsSwUg/pccgX66p
 QrNk15b2b9orFzU5XmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfX63fH29ikDG5+
 DQJpOGJf/65J0mnd4alGs7i3AJWqC56eXDaggkFM8+SUynk10N0mOLpTYjqm3KKGuZ7FQ0V6fL+
 q+1rFBbfv2Ku2sJoACPzBqcPyMIqOo0=
X-Proofpoint-GUID: NTcHsmlFsunXvnXozj3fvDWuLWXN3Gvi
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa2cd8b cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=0WyL-R9DJl2wsrhYlPIA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: NTcHsmlFsunXvnXozj3fvDWuLWXN3Gvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100187
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
cm1zLgoKQnJpYW4gQ2FpbiAoOSk6CiAgdGNnOiBzcGxpdCBvdXQgX3ZhciBmb3JtcyBvZiBndmVj
IGxvZ2ljYWwsIGFicyBhbmQgbWluL21heCBvcHMKICB0Y2c6IGFkZCBiYXNlIGFyZ3VtZW50cyB0
byB0aGUgZ3ZlYyAycywgZHVwX2kzMiBhbmQgY21wIGV4cGFuZGVycwogIHRjZzogc3BsaXQgb3V0
IF92YXIgZm9ybXMgb2YgZ3ZlYyBzYXR1cmF0aW5nL211bC9zaGlmdC1pbW1lZGlhdGUgb3BzCiAg
dGFyZ2V0L2hleGFnb246IHJhaXNlIGFuIGV4Y2VwdGlvbiBmb3IgSFZYIHdpdGggU1NSOlhFIGNs
ZWFyCiAgdGFyZ2V0L2hleGFnb246IHJlYWNoIHRoZSBIVlggcmVnaXN0ZXIgZmlsZSB0aHJvdWdo
IGEgcG9pbnRlcgogIHRhcmdldC9oZXhhZ29uOiBjYXJyeSBhIGJhc2UgcHRyIHcvSFZYIHJlZyBv
ZmZzZXRzCiAgdGFyZ2V0L2hleGFnb246IG1vdmUgdGhlIEhWWCByZWdpc3RlciBmaWxlIGludG8g
YSBRT00gb2JqZWN0CiAgdGFyZ2V0L2hleGFnb246IHNlbGVjdCB0aGUgSFZYIHJlZ2lzdGVyIGZp
bGUgd2l0aCBTU1I6WEEKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCB0ZXN0X2h2eF9j
b250ZXh0IGFyY2ggdGVzdAoKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAg
ICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQuaCAg
ICB8ICAyNyArCiBpbmNsdWRlL3RjZy90Y2ctb3AtZ3ZlYy1jb21tb24uaCAgICAgICAgICAgIHwg
IDk3ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAx
OCArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAgICAgICAgICB8ICAgMSAr
CiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oICAgICAgICAgICAgICAgIHwgNjA4ICsrKysr
KysrKystLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5oICAgICAgICAgICAgICAgICAg
ICAgfCAgIDggKwogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgICAgICB8
ICAxNCArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgICB8ICAg
NyArLQogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAgICB8ICAzNiAr
KwogaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmMgICAgICAgICAgICB8ICA4MyArKysK
IGxpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jICAgICAgICAgICAgICAgfCAgIDIgKwogbGlu
dXgtdXNlci9tYWluLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiB0YXJnZXQv
aGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM5ICstCiB0YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMgICAgICAgICAgICAgICAgIHwgIDcyICsrKwogdGFyZ2V0L2hleGFn
b24vZ2Ric3R1Yi5jICAgICAgICAgICAgICAgICAgICB8ICAxNiArLQogdGFyZ2V0L2hleGFnb24v
Z2VucHRyLmMgICAgICAgICAgICAgICAgICAgICB8IDEwMiArKy0tCiB0YXJnZXQvaGV4YWdvbi9t
YWNoaW5lLmMgICAgICAgICAgICAgICAgICAgIHwgIDEyICsKIHRhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jICAgICAgICAgICAgICAgICAgfCAgMzcgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jICAgICAgICAgICAgICAgICAgfCAgNzMgKystCiB0Y2cvdGNnLW9wLWd2ZWMuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgNjE3ICsrKysrKysrKysrKysrLS0tLS0tCiBody9oZXhhZ29u
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRhcmdldC9oZXhhZ29u
L2hleF9jb21tb24ucHkgICAgICAgICAgICAgICAgfCAxODAgKysrLS0tCiB0ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgICA3ICsKIDI0IGZpbGVzIGNoYW5nZWQs
IDE0MzcgaW5zZXJ0aW9ucygrKSwgNjI0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2h2eF9jb250ZXh0LmgKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9oZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQuYwoKLS0gCjIuMzQuMQoK

