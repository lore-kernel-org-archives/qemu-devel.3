Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC1CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGE3-0007Lx-9k; Fri, 09 Oct 2026 15:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGE0-0007LJ-A2
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGDy-0007cE-Kc
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:25:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZd9U2967899
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DY93txGs/9EAP8+0vosjtY9tFRWnog9owtguusM6Ogo=; b=mzF9pl1U3fheyL5g
 fLWlCbOeXbp7v4CSf0lw3WgP2HaZi/3GTnT40xG81HCdX+LjnARYxdYGza5+98HM
 OlNxOT0wrXNl4gEHezNWBDPkiq69Vhuq6QzOX2pRX1z+OJhhHgNGCNadhu1TkVu4
 7Bc34+dlyyeKb2o2MPlpkn+drjV/CEOds3rzv3XwtGTDMc5p1Usr7YXh0StdOmzs
 wLWGKo2J6CdpiNJTsjTA4t4qhUdsJKjy41+tLnypbrDc5lwuiN/e2vgSx96TTIMW
 VEOPXFStz5ZAjt4dQ5hvmiBp1J+DqzE5ksqbwVXFAaq3EjlMt71M/M3GTe5qEWhq
 5ydBAA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8gegh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:45 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-155a75f91e1so5585542c88.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573944; x=1792178744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DY93txGs/9EAP8+0vosjtY9tFRWnog9owtguusM6Ogo=;
 b=dbBQahZZXnHgx3y+l2fK0qJrBlqiZNLM+RskAPDImc/M30d0z8oU1NyC9pVLKEilrY
 7S48/Ifz3SksAQhlMbp4R3WkQICQzEVg+AFKBQwVEwvxI8McFnurouvH9x7Xah7VsCxo
 BSNQIBxVTOiTF8WVTA+QWkb3nzFta1ena2PFDLNd7MgD/hl80bkBiAF9j2/RCKAWInHg
 dYpgg63+/VCYAlf7ok/DgY/S+TlxW+CgBEBCtaDrEpDfxEs3qPY7xA0G/Rp5n9dUWk/7
 eUxohMjYe5HQOWIW4o0D5T58yVrr6iODM2SLmcV7r8QkcUWQvXJAFSxWQj+NkTLDmeJn
 dBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573944; x=1792178744;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DY93txGs/9EAP8+0vosjtY9tFRWnog9owtguusM6Ogo=;
 b=gIsxVQ1NEQIUqb5JA7530+zL760ZqUqjy44rVuPmsBbF4qjqk/CyAXJMLFdsQDrJtA
 YkN3PtQ8rQwgB7fN/I42kIaEklsi4kVQWa589fVcaJ6ZEuBBITYnESGSXkL8jlgWKz27
 I3SfMfda9BeqKo/Uew/rQdPMmlgp/XmNuV27qDQ2feWm+rM3A5zFIV5sb9nfi0UDdVNm
 sU2uE97yT7quGTc+OChgqoXNSY0VAAWC/f7Dpwn1rEu6OkXwyk76Zv/vq3lWE7mrSGNc
 5QJquNi4b2QELjibJi+7TFq13rhLOmB0LmXg0/egf7YTDQQr9ef46fjRuaKF+i38IcIx
 vUgg==
X-Gm-Message-State: AFuF++kdR4c0JN6DRwPGyWXQNnrciS2FUdQZPyabmBckdakZung4KA9x
 8MPHbT5rOdw/8Wjuva2jby5bxbywZCDItLLSAEpubN0w/OJynP0esL0ojsoB7YXBgRbRssHkDur
 tfIyKl43RcNeZGxA0hfRs4f3+9BP2t01hwGDrF+FUKJWVpoNLHs39ibCq2CyeAgNeTg==
X-Gm-Gg: AYBFou0mStwqOoTspO0qgO1J7JE2K26z26//0768mBTeSyYypYJMQUHlC47ay+dAbz8
 i+0JJUiJVPZgPbrBCKyLvUVWQLzJ4aQHS5N5UIZRhwVlcXeVjhNqxSdz6I/ymdXF+NCQCm5LzLK
 g+ILSGS/JJAGV7x2m1PZZCG8FhqBH87eo5NJGDJ8Tp0Z3Dk1qPqEQYELAl9AnoNtc8Df3ifRPL6
 QvHhBm43CyfNMZH8Sf3o9DzvAzpfVEXVzYzuopqPPyG0XQvhFTqWRl7GnALpe6UFJJrs+AvO97o
 2Blg+7B4fBouJ59bJoClRzSHxbYezd9ETc1I0YIYdyvS1WOqKKTX9d1oSwePjAXiHxLhV8lB3uo
 +XiGwTa0z+r95kEiW1x02+m1bXmHS3mJVRbiaNASDhWIXKKE=
X-Received: by 2002:a05:7022:1711:b0:148:bce6:429b with SMTP id
 a92af1059eb24-16a10f29724mr3545309c88.8.1791573944114; 
 Fri, 09 Oct 2026 12:25:44 -0700 (PDT)
X-Received: by 2002:a05:7022:1711:b0:148:bce6:429b with SMTP id
 a92af1059eb24-16a10f29724mr3545286c88.8.1791573943480; 
 Fri, 09 Oct 2026 12:25:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/6] target/hexagon: check privilege mode for system
 instructions
Date: Fri,  9 Oct 2026 12:25:35 -0700
Message-Id: <20261009192541.4163758-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX1QP61/p62cn7
 fzPFwZCyBNMel+FSXE3xCh9lftEs6WZHm02dfzsb0m7gpmG6YCaJdjSf3twS4o3/XNdMfRQ/ROp
 RszGgONU+Nh6sobVEshtd8fCH9JOD/k=
X-Proofpoint-GUID: j3q6bAODaljmC7thrMcX2zMLwNsWRJA_
X-Proofpoint-ORIG-GUID: j3q6bAODaljmC7thrMcX2zMLwNsWRJA_
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac93fb9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=BTrIe76cHL4Dmed7cV0A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX8PThyLI8ziLz
 psEArA7/RHcVZYufMSAGs8tAHqcQvBEqZ9WSwTDW7DW/qm8w/sDvowRQP6VpqaxCqjEiCMTopX+
 Nrjhi8/UQHLk9PRkGEssV19m3zhQ9YISGljXQS/9Ll93QG1LGboZpzPr3yDyR4QuAy7de5HxXdf
 JsaaZk44FQ2SFOKxoJqFdShOFEEy1Ly+dkk/4wDkTPHDcKW/hKwOnhCf4bmgchyQazb3S7uWe+z
 a8VlZFX4sBVhGxZWEyPKsgM3dnsigS+ZoEPPQSl1nsL1XRPR0iAwHvLrsy9gxBJv2j0LV+1BxlX
 nB4UfL7YdKn1uorf1ei54EeYuN1yZiXHYIid/3G95IhjN7fHRruVf73mpMNvNmAeiX1PUj2tWEV
 x1PLJqjNrZzl14yn7bqAJoGaQXQtSvaWqZOFiFlhF+mWSE2tmztPYYNUpZrVmtHv9niY44vP+zk
 5LHdB+4mBiC7E+ha7+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090077
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

Rml4ZXM6IDk4MzFkM2NhYjE2OCAoInRhcmdldC9oZXhhZ29uOiBBZGQgcHJpdmlsZWdlIGNoZWNr
LCB1c2UgdGFnX2lnbm9yZSgpIikKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAg
fCAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgIHwgIDEgKwogdGFyZ2V0L2hl
eGFnb24vY3B1LmMgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyAgICAgIHwgMTUgKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNz
LnB5IHwgMTYgKysrKysrKysrKy0tLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZGY0YzAxODIyNDcuLjJhNTUxNGQ1MTJhIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApA
QCAtMjI5LDYgKzIyOSw3IEBAIEZJRUxEKFRCX0ZMQUdTLCBJU19USUdIVF9MT09QLCAwLCAxKQog
RklFTEQoVEJfRkxBR1MsIE1NVV9JTkRFWCwgMSwgMykKIEZJRUxEKFRCX0ZMQUdTLCBQQ1lDTEVf
RU5BQkxFRCwgNCwgMSkKIEZJRUxEKFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VOQUJMRUQsIDUsIDEp
CitGSUVMRChUQl9GTEFHUywgQ1BVX01PREUsIDYsIDIpCiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhh
Z29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmgKaW5kZXggZTE3MjYxNzYxYjIuLmFhZDI5NjQ4NWQwIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApA
QCAtNDUsNiArNDUsNyBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIERFQ0xB
UkVfQklUTUFQKGdwcl91bmNvbmQsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYm9vbCBp
bXBsaWNpdF91c3Jfd3JpdGU7CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICB1aW50MzJf
dCBjcHVfbW9kZTsKICAgICBpbnQgZ3JlZ19sb2dbR1JFR19XUklURVNfTUFYXTsKICAgICBpbnQg
Z3JlZ19sb2dfaWR4OwogICAgIERFQ0xBUkVfQklUTUFQKGdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVH
Uyk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCmluZGV4IDFmN2Q4YThkZjcwLi44OWIxNmEwZDcxMyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTM1Myw2ICszNTMsOCBA
QCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dldF90Yl9jcHVfc3RhdGUoQ1BVU3RhdGUg
KmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZY
X0NPUFJPQ19FTkFCTEVELAogICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1LT5odnhfY3R4
WzBdICYmCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwg
ZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOworICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIo
aGV4X2ZsYWdzLCBUQl9GTEFHUywgQ1BVX01PREUsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnZXRfY3B1X21vZGUoZW52KSk7CiAjZWxzZQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIo
aGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLCBNTVVfVVNFUl9JRFgpOwogI2VuZGlmCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jCmluZGV4IDgyNzg1OWUwNTJjLi4zNWYxZTQ3YjdhNyAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMK
QEAgLTEyODAsNiArMTI4MCwyMCBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfYW5kX3RyYW5zbGF0ZV9w
YWNrZXQoQ1BVSGV4YWdvblN0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIRVhfQ0FVU0VfUkVHX1dSSVRFX0NPTkZMSUNU
KTsKICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgfQorI2lmbmRlZiBDT05GSUdfVVNFUl9P
TkxZCisgICAgICAgIGlmIChjaGVja19mb3JfYXR0cmliKCZjdHgtPnBrdCwgQV9QUklWKSAmJgor
ICAgICAgICAgICAgY3R4LT5jcHVfbW9kZSAhPSBIRVhfQ1BVX01PREVfTU9OSVRPUikgeworICAg
ICAgICAgICAgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0NBVVNFX1BSSVZfVVNF
Ul9OT19TSU5TTik7CisgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCArPSBjdHgtPnBrdC5l
bmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKKyAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQor
ICAgICAgICBpZiAoY2hlY2tfZm9yX2F0dHJpYigmY3R4LT5wa3QsIEFfR1VFU1QpICYmCisgICAg
ICAgICAgICBjdHgtPmNwdV9tb2RlID09IEhFWF9DUFVfTU9ERV9VU0VSKSB7CisgICAgICAgICAg
ICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX0dJ
TlNOKTsKKyAgICAgICAgICAgIGN0eC0+YmFzZS5wY19uZXh0ICs9IGN0eC0+cGt0LmVuY29kX3Br
dF9zaXplX2luX2J5dGVzOworICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisjZW5kaWYK
ICAgICAgICAgZ2VuX3N0YXJ0X3BhY2tldChjdHgpOwogICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
Y3R4LT5wa3QubnVtX2luc25zOyBpKyspIHsKICAgICAgICAgICAgIGN0eC0+aW5zbiA9ICZjdHgt
PnBrdC5pbnNuW2ldOwpAQCAtMTMxNCw2ICsxMzI4LDcgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl90
cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgIGN0eC0+
aHZ4X2NvcHJvY19lbmFibGVkID0KICAgICAgICAgRklFTERfRVgzMihoZXhfZmxhZ3MsIFRCX0ZM
QUdTLCBIVlhfQ09QUk9DX0VOQUJMRUQpOwogICAgIGN0eC0+aHZ4X2NoZWNrX2VtaXR0ZWQgPSBm
YWxzZTsKKyAgICBjdHgtPmNwdV9tb2RlID0gRklFTERfRVgzMihoZXhfZmxhZ3MsIFRCX0ZMQUdT
LCBDUFVfTU9ERSk7CiAjZW5kaWYKIH0KIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkKaW5kZXggMjU5
MmFjZjIxZWIuLmY3OTNjZWI5ZGM5IDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNn
X2Z1bmNzLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkKQEAgLTU4LDE2
ICs1OCwyMCBAQCBkZWYgZ2VuX3RjZ19mdW5jKGYsIHRhZywgcmVncywgaW1tcyk6CiAKICAgICBm
LndyaXRlKCIgICAgSW5zbiAqaW5zbiBHX0dOVUNfVU5VU0VEID0gY3R4LT5pbnNuO1xuIikKIAot
ICAgIGlmICJBX1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgorICAgIGlmICgK
KyAgICAgICAgIkFfUFJJViIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ10KKyAgICAgICAg
b3IgIkFfR1VFU1QiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddCisgICAgKToKICAgICAg
ICAgZi53cml0ZShkZWRlbnQoIiIiXAogI2lmZGVmIENPTkZJR19VU0VSX09OTFkKLSAgICBoZXhf
Z2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOKTsK
LSNlbHNlCiAiIiIpKQotICAgIGlmICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3Rb
dGFnXToKKyAgICAgICAgaWYgIkFfUFJJViIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106
CisgICAgICAgICAgICBmLndyaXRlKCIgICAgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwg
IgorICAgICAgICAgICAgICAgICAgICAiSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19TSU5TTik7XG4i
KQorICAgICAgICBlbHNlOgorICAgICAgICAgICAgZi53cml0ZSgiICAgIGhleF9nZW5fZXhjZXB0
aW9uX2VuZF90YihjdHgsICIKKyAgICAgICAgICAgICAgICAgICAgIkhFWF9DQVVTRV9QUklWX1VT
RVJfTk9fR0lOU04pO1xuIikKICAgICAgICAgZi53cml0ZShkZWRlbnQoIiIiXAotI2lmZGVmIENP
TkZJR19VU0VSX09OTFkKLSAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FV
U0VfUFJJVl9VU0VSX05PX0dJTlNOKTsKICNlbHNlCiAiIiIpKQogICAgIGlmIGhleF9jb21tb24u
bmVlZF9lYSh0YWcpOgotLSAKMi4zNC4xCgo=

