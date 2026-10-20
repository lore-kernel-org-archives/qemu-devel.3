Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8089606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hNJxSKS2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jk+cKyuf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzc5-0005J3-Mz; Mon, 19 Oct 2026 22:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzc4-0005I3-Ed
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:30:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzc2-0005dv-2E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:30:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tGAV1254986
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d6YWos0L/Y4NwRTvC9g9TavF4CLiPqmOWZ7v5K5heGQ=; b=hNJxSKS2W7ti6t+R
 EA1HAPCxgTAOOReRGgt1/yHeI9JcIJl8PO+wLzasjmCFUU4aUMJ6Vr58TbBTxTnu
 u8W8hnuZIEFYJdAReQ7YtjHt6oNwZh4t6nzmNyQcUq5/AoPYD9t1c8jVp952MUic
 BzHl6f/GHEV/Wbi4Fta1pry6hwT4DPp6U0IlTmldug3tDOneGVUXiIt6opOmAthT
 GIkrPYPyFh0fl7cXFFPmq/XMRQtdtIKwdjJ3XCmc2ria95d+1fnFV0URyUIaVsTX
 BY/duraoE7ZwzLNRkslb8EMiyGbXoaMEVM9koXrPcY4X87b02nRf0kc5BsONJYVN
 UMrkBQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n8f5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:30:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so4864569eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463400; x=1793068200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d6YWos0L/Y4NwRTvC9g9TavF4CLiPqmOWZ7v5K5heGQ=;
 b=jk+cKyuf8Kdm6XHLK9+Y9WyYhpmmdMdT/c4G/GUH/cDlAT42q23wPpA2fJy9Y0Ln9Z
 IrUjgzO9k4sgR0xG5S520mU7bTOXU60wT50NOGawRb8e45UuX9zhglbng36UCmkXLi5o
 BYytVAMlAo47vFngPtPzSPN3vOc1PkhhqfQbdvkjdjE1qINMYQHiqjL7IBASfQOGlbLA
 unS52sRfeC/ruh8hOfhmf1oI1IK7nqr0aN7NSbo5Gbrs88DFlstaTfB8voF5bBW5fAN7
 DuhHdte9A4ZJx8Jb/U1DbKWTD85y5PHeXySdZ+LdRNd+PP/1zCbEsmQVSlSx2zooDJJW
 aeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463400; x=1793068200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d6YWos0L/Y4NwRTvC9g9TavF4CLiPqmOWZ7v5K5heGQ=;
 b=PGHp7scH1pXl8Ym6K8YSgh27sLN028FqhuB6OnzBpKFymS5rUeWlAsOgr7RhUVT5lZ
 b1z5goBOb0R/kloL1/vaS1h+Iy6b0obOLIX+MWuk3qVFLrNwbENOxvrFfZS7idn1ctKh
 ZE5Jy72iMfC9Y3R4YC1gfTDNlueDmBrO3yvvYhOrued+e95bCaAAeEStPYLPIbLfInu7
 vbEIouhO2sDfHB7hdufh2D3lb2worOjBLQG1RrBmQFjBEj7cU05Skd5DfUHzEMW+b4I+
 hDPh3nbGbrT8Ntv+uiyxKHQnoTNWpoObMyTX3AT/9zZDzDoQ1YgiU688S0WFhHkDuoMN
 tsLQ==
X-Gm-Message-State: AFq9FYLg7YKDfKN9WwkSCUfFqxj/bWuavj/Hg8VW+2iO4BqYnjcFOTT0
 nz213yekpAVo8qe2AqGgYq4mThrFt0sA60k6Drw/zZzpjvND+OHkq+x9WA0+7IPaG8g9k33qW2k
 kPihukp01NbRnHaperi/u2daAWyY5VuolomlDS+54D42YmnEvJEREK8ti0xumCUpinQ==
X-Gm-Gg: AYBFou3oadS5wij2WaIh9J5vA2rW604ChU7q/OOZyW1RUXhKAOrqPv7AV9d2sbuJXd8
 phJifLCkOgQvmZQwl3upi2wknAh1R5be+3jNjcfQKh35/Rc3fssO9w64/aAqrPtFXIRDsDgtiEy
 NycdqF0IsU/+QHVpNpwzvvZJHUlNiEjgFowhElgIv1+SUgh94ylv5wJ0IPyeZucIo3BsNPgLH3x
 ESmNEprAaVPUxmAdETO7WnNQv6eCSnxG0DXXXTuPeO46arEIt6cN9ZB+uy87T/QpRgWCbFYyyof
 QSg/cr1awLKJqjR3Ct1T8bWkrAcYvuHpSI1qjA54wyDdwzGXMy1mqZKG04Imv2j8YN63QiK7f8u
 LDv4x3nQpMJE6nVK5ClBVrGiuOwxQ0nHozdliDh4O4JSMRPg=
X-Received: by 2002:a05:7023:a84:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1880e51e89bmr11925041c88.2.1792463399930; 
 Mon, 19 Oct 2026 19:29:59 -0700 (PDT)
X-Received: by 2002:a05:7023:a84:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1880e51e89bmr11925011c88.2.1792463399371; 
 Mon, 19 Oct 2026 19:29:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1830f213ba7sm37895921c88.0.2026.10.19.19.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:29:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/3] target/hexagon: only flush the softtlb when SSR.ASID
 changes
Date: Mon, 19 Oct 2026 19:29:54 -0700
Message-Id: <20261020022955.3662627-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
References: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: UZiu2U5Lb6zalwZHrwgTNQwnveHM80z2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwOSBTYWx0ZWRfX5rGcXZyEU6Mk
 rtu8JuDMWMJRa8L+hILnGYKN9HGXRMxkIiaeppeGAIxYjkxK/nynmEACHmL++Z13Ej2xgpkBlDO
 OXTBOUBOZcTZXs8FvnJUfCCKSSztwhpZiOVkRhtEztc916kZGzpKWjoPaEGnhJA1f3kudzYGmZq
 u8UKGNI+FsLQvwhbWAuJvbHeRDCydNoUKUyLrFgM4C0ORbIRMWIGc2t5bSm1pPZanYQ/ktJHSe8
 Pwm3zMIwPgVkx4z2yq+1kJH16Ij5s0o5EKXE/nRg2U9ra3GajliWCLBG8ucJnHDuW4SyeT1kjTc
 GzK6L6EDT9CAdJ6AavYQQf19SHAIb2q+3xCWbFhiBvEx6Zbbt9V4ASbLtxNQeo7uahW4PFlatH/
 QeNJxlQ43uv1A4PAmJ3RINtiuZKbIImTpXZam31YlR9RTX0oKyg1/efxZB82VWy5puewIPKiAWw
 /NAsRRgKzHzo79HpG5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwOSBTYWx0ZWRfXylZOaASRzJNA
 F5tdRJ+JgFB8r4xIYJJr3Gvb9dJbHOgJAp9l8EOW5/PkQbHk5KMcYPefPM2iJ4sA98Na7RIco2q
 w7nxsnaDJ5CG8TFZ7zmNDaeGh6kPmv4=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad6d228 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=03mWCbMf3N1Ipu_5KecA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: UZiu2U5Lb6zalwZHrwgTNQwnveHM80z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200009
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

aGV4YWdvbl9tb2RpZnlfc3NyKCkgZmx1c2hlZCB0aGUgc29mdHRsYiBvbiBhbnkgY2hhbmdlIHRv
IFNTUi5FWCwgVU0sIEdNLApvciBBU0lELCBidXQgb25seSBBU0lEIGFmZmVjdHMgdHJhbnNsYXRp
b24uICBFWC9VTS9HTSBqdXN0IHBpY2sgdGhlIG1vZGUsCndoaWNoIGlzIGFscmVhZHkgY2FwdHVy
ZWQgaW4gbW11X2lkeC4KCkVYIHRvZ2dsZXMgb24gZXZlcnkgZXhjZXB0aW9uIGVudHJ5L3J0ZSwg
c28gdGhlIGZsdXNoIGNyZWF0ZWQgYSBmZWVkYmFjawpsb29wIHdoZXJlIGEgVExCIG1pc3Mgd2lw
ZWQgdGhlIHNvZnR0bGIgYW5kIGd1YXJhbnRlZWQgdGhlIG5leHQgYWNjZXNzZXMKbWlzc2VkIHRv
by4KClJlbmFtZSBoZXhfbW11X21vZGVfY2hhbmdlKCkgdG8gaGV4X21tdV9hc2lkX2NoYW5nZSgp
IHRvIG1hdGNoIHdoYXQgbm93CnRyaWdnZXJzIGl0LCBhbmQgbmFycm93IGl0IHRvIHRoaXMgdGhy
ZWFkJ3MgbW11IGluZGljZXM6IHRoZSBBU0lEIGxpdmVzIGluCnRoZSB0aHJlYWQncyBwcml2YXRl
IFNTUiwgc28gb3RoZXIgQ1BVcyBhcmUgdW5hZmZlY3RlZC4KClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfbW11LmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgMTcgKysr
LS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICB8ICA3ICsrKystLS0K
IDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmggYi90YXJnZXQvaGV4YWdvbi9oZXhfbW11
LmgKaW5kZXggMGM0OTQwNDQ0OGMuLjliNmVhNWI5NjdiIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9oZXhfbW11LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oCkBAIC0xNyw3ICsx
Nyw3IEBAIGV4dGVybiB2b2lkIGhleF90bGJfaW52YWxpZGF0ZV9hc2lkKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBhc2lkKTsKIGV4dGVybiB1aW50MzJfdCBoZXhfdGxiX2xvb2t1cChD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3NyLCB1aW50MzJfdCBWQSk7CiBleHRlcm4g
dm9pZCBoZXhfbW11X29uKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIGV4dGVybiB2b2lkIGhleF9t
bXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KTsKLWV4dGVybiB2b2lkIGhleF9tbXVfbW9kZV9j
aGFuZ2UoQ1BVSGV4YWdvblN0YXRlICplbnYpOworZXh0ZXJuIHZvaWQgaGV4X21tdV9hc2lkX2No
YW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiBleHRlcm4gYm9vbCBoZXhfdGxiX2ZpbmRfbWF0
Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGh3YWRkciAqUEEsIGludCAq
cHJvdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqc2l6ZSwgaW50
MzJfdCAqZXhjcCwgaW50IG1tdV9pZHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDZkYzA2NDAxYWQ1
Li42NGQ4YTJjYWQ3OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMjMxLDI3ICsyMzEsMTcgQEAgdW5z
aWduZWQgaGV4YWdvbl9odnhfc2VsZWN0X2NvbnRleHQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IHNzcikKIAogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewotICAgIGJvb2wgb2xkX0VYLCBvbGRf
VU0sIG9sZF9HTSwgb2xkX0lFOwotICAgIGJvb2wgbmV3X0VYLCBuZXdfVU0sIG5ld19HTSwgbmV3
X0lFOworICAgIGJvb2wgb2xkX0VYLCBvbGRfSUU7CisgICAgYm9vbCBuZXdfRVgsIG5ld19JRTsK
ICAgICB1aW50OF90IG9sZF9hc2lkLCBuZXdfYXNpZDsKIAogICAgIGdfYXNzZXJ0KGJxbF9sb2Nr
ZWQoKSk7CiAKICAgICBvbGRfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgb2xkKTsKLSAgICBv
bGRfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgb2xkKTsKLSAgICBvbGRfR00gPSBHRVRfU1NS
X0ZJRUxEKFNTUl9HTSwgb2xkKTsKICAgICBvbGRfSUUgPSBHRVRfU1NSX0ZJRUxEKFNTUl9JRSwg
b2xkKTsKICAgICBuZXdfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgbmV3KTsKLSAgICBuZXdf
VU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgbmV3KTsKLSAgICBuZXdfR00gPSBHRVRfU1NSX0ZJ
RUxEKFNTUl9HTSwgbmV3KTsKICAgICBuZXdfSUUgPSBHRVRfU1NSX0ZJRUxEKFNTUl9JRSwgbmV3
KTsKIAotICAgIGlmICgob2xkX0VYICE9IG5ld19FWCkgfHwKLSAgICAgICAgKG9sZF9VTSAhPSBu
ZXdfVU0pIHx8Ci0gICAgICAgIChvbGRfR00gIT0gbmV3X0dNKSkgewotICAgICAgICBoZXhfbW11
X21vZGVfY2hhbmdlKGVudik7Ci0gICAgfQotCiAgICAgYm9vbCB4YV9jaGFuZ2VkID0gR0VUX1NT
Ul9GSUVMRChTU1JfWEEsIG5ldykgIT0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG9sZCk7CiAgICAg
Ym9vbCB4ZV9jaGFuZ2VkID0gR0VUX1NTUl9GSUVMRChTU1JfWEUsIG5ldykgIT0gR0VUX1NTUl9G
SUVMRChTU1JfWEUsIG9sZCk7CiAKQEAgLTI2Nyw4ICsyNTcsNyBAQCB2b2lkIGhleGFnb25fbW9k
aWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQp
CiAgICAgb2xkX2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBvbGQpOwogICAgIG5ld19h
c2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgbmV3KTsKICAgICBpZiAobmV3X2FzaWQgIT0g
b2xkX2FzaWQpIHsKLSAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwotICAgICAg
ICB0bGJfZmx1c2goY3MpOworICAgICAgICBoZXhfbW11X2FzaWRfY2hhbmdlKGVudik7CiAgICAg
fQogCiAgICAgLyogU2VlIGlmIHRoZSBpbnRlcnJ1cHRzIGhhdmUgYmVlbiBlbmFibGVkIG9yIHdl
IGhhdmUgZXhpdGVkIEVYIG1vZGUgKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9t
bXUuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCAyZTBlNGFiNzA1Yi4uOWEwZTI5
YWUyMTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysgYi90YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmMKQEAgLTczLDExICs3MywxMiBAQCB2b2lkIGhleF9tbXVfb2ZmKENQ
VUhleGFnb25TdGF0ZSAqZW52KQogICAgIHRsYl9mbHVzaChjcyk7CiB9CiAKLXZvaWQgaGV4X21t
dV9tb2RlX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3ZvaWQgaGV4X21tdV9hc2lkX2No
YW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBxZW11X2xvZ19tYXNrKENQVV9MT0df
TU1VLCAiSGV4YWdvbiBtb2RlIGNoYW5nZSFcbiIpOwogICAgIENQVVN0YXRlICpjcyA9IGVudl9j
cHUoZW52KTsKLSAgICB0bGJfZmx1c2goY3MpOworCisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9H
X01NVSwgIkhleGFnb24gQVNJRCBjaGFuZ2UhXG4iKTsKKyAgICB0bGJfZmx1c2hfYnlfbW11aWR4
KGNzLCBNTVVfSURYX0FMTCk7CiB9CiAKIGJvb2wgaGV4X3RsYl9maW5kX21hdGNoKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwKLS0gCjIuMzQuMQoK

