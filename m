Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02990CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH51f-0005OI-0w; Wed, 14 Oct 2026 15:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51c-0005Nm-Kv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51a-0002Uj-Vg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbSFZ3813172
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LcNwResGWkZwwrGUwRAEJ80MzlWx9S4lSrge0O+147c=; b=bdmVmhGD+Ns+OWWZ
 WFiH+jl3K9QNcI5j9BM4DPfBiNh0R+cKkG5zH9wFJZt5/aFQxb/knhyWwZD5bWFm
 zv6taJi6l2hflWPsDpiQCoaSHiAmecxFrn787RVpArL+140gsJzksRmYWu7cZ7OD
 4NEyzkpFlmd/H2ehHANXtP0g27rwLgy9gaKKe4nrYoB676TxHeKBER3LQLNNhZgZ
 VtYue5I7yHEzl0Ib5K77YiXxPDdQv0dzpX6V8Mduz9jabBJSUkZ2PYJD3iPyp7BA
 OStUpq+bRSy6++MRmau24bp1Iiip0nKj4U0R4wmnyKMo8kI8Mq+FRg5i0r1yyBWa
 YCD3PQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u39wk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9616272eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007548; x=1792612348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LcNwResGWkZwwrGUwRAEJ80MzlWx9S4lSrge0O+147c=;
 b=U/ur9QtDlLL0RQg0+JHvj+SYU5r7E2Uq60D80/Gnu545w3JgB9SIOzqhGKkAbQI4N6
 SWdiddEg11F9322enMprMBWFDf20l+K/BS/ZfkkqvINHauh6HjG7GtBiYZyvsVCi6OBo
 YJrDwhRWhaYC5ZMyOXlPTZm3/2TiUW0zzvdvJl9tUK7QyzfCB2veNdipPLhayWDBgrw2
 xqCoiLrwbfB1iho0EL65swjUnVZ2ctVws7NjE2+BLrvDXeFNj9F7F67gcLAML7yndrbP
 cUppf4wZAKWl48hiuZ97q450DVu1pPuu0iyNavP4Eb/2PJKC5xCahNCK1kio/jOiFnCD
 iCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007548; x=1792612348;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LcNwResGWkZwwrGUwRAEJ80MzlWx9S4lSrge0O+147c=;
 b=OeKbhttFSQjw5Z/Hau+vYhe4i54Ok9qcHTfIhRS9mJL8Udk0VgPyvrM08N0ekRdfql
 VOadrGgTupInqOsSvYwbJLcJKH097d/hMqoxfA+hiTidYIj+1cNIdQHos06B9m+jFwtW
 3rBeUbDpoBwCExfiDxz32DglJ8895v8p5+Ww4bCNJQiYeN4u3VdYsusNmRFTrN0ZxHb3
 tgttoPIlte/kDGq9g+L8wo/kkTcxUL9eiHHFPzygAaSYcoROVWtcoh3PburobbozPG0m
 A4J12gjqR9VeY1TAs2Hg+HX3uyAwGyVo/YQxo1GWlsP9I9B8i4Vn5nYGxeboWG+prJ1s
 DIiw==
X-Gm-Message-State: AFq9FYJGHfgmtci1+AVJz+CGDt7xUJ4UKNa4vBuUaIZY2vzAB2R4iQbf
 TF/HWHBv+8YG2Dz7H+ByUxeX5/HonmHiw4xS1Y6wZaD7/F4wGi04jKxdrefIMCCvGXngYcRwKL4
 Q8h6ykOVS5w5bO7nOq4LetW0lukmUMBcJqkyT0WRWNMzKVFtvIXUakBvRh0yiMctHkA==
X-Gm-Gg: AYBFou1cYSqJQiuBAstOIqSwLd+hodo8foL6I/Pn+sY4Zcw067H528hAlZ4n92m+RhV
 KtuimaYIX3P0D4Ml9crB/HtDiJ68z6oCK6RbOR1C+57i6+cxidYP9mSEOzfuqbzWLaipXtU7szm
 iPtj7dp7qo3ZIFy8MQkMCcjgJWo//Bk/fL/VFhzqF60+7QR7rmjtYgxQHBENCmG07RmWfbeda39
 JAon0C45P4pNpJSyfFsoNpKJB11w0xSEMNGrmTFEbmAxXTH3BEiXTDd4dqmghCIpETouCBOO2qv
 L1My7o341JO/YOeILxCdHTFy0DKSJAYu8eqfinmIRkokwFof0mWJu9PLpFVuuAH0bAx5rIAwYcE
 YKT4aZK2oNKagVG2mWFS4nzkzUwsghUpgtTOmHRy8zzRewww=
X-Received: by 2002:a05:7301:1929:b0:355:81bc:567f with SMTP id
 5a478bee46e88-35581bc5872mr21467272eec.25.1792007548234; 
 Wed, 14 Oct 2026 12:52:28 -0700 (PDT)
X-Received: by 2002:a05:7301:1929:b0:355:81bc:567f with SMTP id
 5a478bee46e88-35581bc5872mr21467238eec.25.1792007547627; 
 Wed, 14 Oct 2026 12:52:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm547069eec.7.2026.10.14.12.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:52:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 02/12] Hexagon: add v85 CPU model
Date: Wed, 14 Oct 2026 12:52:13 -0700
Message-Id: <20261014195223.3233623-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfXz6t7t+KFYN/L
 y75H4Hsx9X/fLCOh/o5i7xKuS27hJsiD2yFeMXGvqK5yRo1eIBVmYwP/lmQAn6Wp2cjQdOc0KqI
 CZsyZTbxWo3Tz35nkU0/YertPjNhLnI=
X-Proofpoint-GUID: 201ceAtw6wtx4uRUg57fwyImXa1r_vLC
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfdd7d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX/Bd3Ey1lRfo6
 ZGRghKH6uJpV4qMcOj2jnqmTGW1evyP+D/nUQ9hj6kiMuAtNoG20errK5x06YDne/qtjgJV9GTW
 qJuBhk9iA+bJBZmh1bPntHS1d6He1ScwJU3n2+3z7ydhjTPCsLpJ1nxxKcYyjWB+sswmvfA2Aw+
 JxztO2G45a+NoxG3ye2+bn4HMbWFvT/Agb0In7o0fEi9TxFdHOR4zhFYI/7E+csL+73zIs7vlHl
 2LPTQunGCk4Bi+ZfdRMILlTyMUJjqPK6C2XqkViqVqPt3g0xM1g+vSCAsBh7Pfd79DIS2PVWIfq
 198jt6tQbt0s4iOb4ZlKTQ9WXFKqGF1gN1obsa+reWnwMQFWL+Obt4EPC/KaNbV9HjKuaDUXqXo
 HxqQcoeR8xV7huGitMIxuh6qN3SdiZixRnbsyu1+7Pb38MYHhp5CZLAKewjoNRJEyYVYqoT4bcg
 v5KdWXXIUQNaGAyslfQ==
X-Proofpoint-ORIG-GUID: 201ceAtw6wtx4uRUg57fwyImXa1r_vLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140079
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCB8IDIgKy0KIHRhcmdldC9oZXhh
Z29uL2NwdS1xb20uaCAgICAgICAgICB8IDQgKysrKwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxv
YWQuYyAgICAgIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgfCAy
ICsrCiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgYi9kb2NzL3N5c3Rl
bS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKaW5kZXggMTIzODUzMTFhYTQuLmZiNTdjNzdhZTkwIDEw
MDY0NAotLS0gYS9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKKysrIGIvZG9jcy9z
eXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CkBAIC02LDcgKzYsNyBAQCBIZXhhZ29uIENQVSBh
cmNoaXRlY3R1cmUgc3VwcG9ydAogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIAog
UUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2NjYsIHY2Nywg
djY4LCB2NjksIHY3MSwgdjczLAotdjc1LCB2NzcsIHY3OSwgdjgxLgordjc1LCB2NzcsIHY3OSwg
djgxLCB2ODMsIHY4NS4KIEl0IGFsc28gaGFzIHN1cHBvcnQgZm9yIHRoZSBmb2xsb3dpbmcgYXJj
aGl0ZWN0dXJlIGV4dGVuc2lvbnM6CiAKIC0gSFZYIChIZXhhZ29uIFZlY3RvciBlWHRlbnNpb25z
KQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LXFvbS5oCmluZGV4IDJiZmE0ZDVkMGZjLi5kNGM4NDEzZGVkMyAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vY3B1LXFvbS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaApAQCAt
MjgsNiArMjgsOCBAQCB0eXBlZGVmIGVudW0gewogICAgIEhFWF9WRVJfVjc1ID0gMHg3NSwKICAg
ICBIRVhfVkVSX1Y3OSA9IDB4NzksCiAgICAgSEVYX1ZFUl9WODEgPSAweDgxLAorICAgIEhFWF9W
RVJfVjgzID0gMHg4MywKKyAgICBIRVhfVkVSX1Y4NSA9IDB4ODUsCiAgICAgSEVYX1ZFUl9BTlkg
PSAweGZmLAogfSBIZXhhZ29uVmVyc2lvbjsKIApAQCAtNTUsNiArNTcsOCBAQCB0eXBlZGVmIHN0
cnVjdCB7CiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc1IEhFWEFHT05fQ1BVX1RZUEVfTkFN
RSgidjc1IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WNzkgSEVYQUdPTl9DUFVfVFlQRV9O
QU1FKCJ2NzkiKQogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MSBIRVhBR09OX0NQVV9UWVBF
X05BTUUoInY4MSIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjgzIEhFWEFHT05fQ1BVX1RZ
UEVfTkFNRSgidjgzIikKKyNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODUgSEVYQUdPTl9DUFVf
VFlQRV9OQU1FKCJ2ODUiKQogCiBPQkpFQ1RfREVDTEFSRV9DUFVfVFlQRShIZXhhZ29uQ1BVLCBI
ZXhhZ29uQ1BVQ2xhc3MsIEhFWEFHT05fQ1BVKQogCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCAzYTZi
YTRlMTMwNC4uOWY5OGFkOGZiODYgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZs
b2FkLmMKKysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtMTEzLDYgKzExMywx
MCBAQCBjb25zdCBjaGFyICpnZXRfZWxmX2NwdV9tb2RlbCh1aW50MzJfdCBlZmxhZ3MpCiAgICAg
ICAgIHJldHVybiAidjc5IjsKICAgICBjYXNlIDB4ODE6CiAgICAgICAgIHJldHVybiAidjgxIjsK
KyAgICBjYXNlIDB4ODM6CisgICAgICAgIHJldHVybiAidjgzIjsKKyAgICBjYXNlIDB4ODU6Cisg
ICAgICAgIHJldHVybiAidjg1IjsKICAgICB9CiAKICAgICBlcnIgPSBzbnByaW50ZihidWYsIHNp
emVvZihidWYpLCAidW5rbm93biAoMHgleCkiLCBlZmxhZ3MpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA2NTUwZTdmYTgwMC4u
ZjczMDNjMDdhYmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCkBAIC05MjYsNiArOTI2LDggQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZv
IGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdP
Tl9DUFVfVjc1LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzUpLAogICAgIERFRklORV9DUFUoVFlQ
RV9IRVhBR09OX0NQVV9WNzksICAgICAgICAgICAgICBIRVhfVkVSX1Y3OSksCiAgICAgREVGSU5F
X0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MSwgICAgICAgICAgICAgIEhFWF9WRVJfVjgxKSwKKyAg
ICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjgzLCAgICAgICAgICAgICAgSEVYX1ZFUl9W
ODMpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODUsICAgICAgICAgICAgICBI
RVhfVkVSX1Y4NSksCiB9OwogCiBERUZJTkVfVFlQRVMoaGV4YWdvbl9jcHVfdHlwZV9pbmZvcykK
LS0gCjIuMzQuMQoK

