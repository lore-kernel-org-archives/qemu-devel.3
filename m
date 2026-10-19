Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFE2CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgYo-0004fb-Ls; Mon, 19 Oct 2026 02:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYn-0004fR-MT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYl-0002kH-NJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j2ig2768563
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vtKKQrX5B25I3FY3U2q6VZJzSoUs2jju69TqJA1QZss=; b=HLT3/MPdiVRRc8dD
 K+eQB9KhRXXMh/dYMGhUZ5yygZZBabBm5R1Vx9OpF7CS/TRPS94k3FfCP+MWdEiR
 0Cq/GT++yGwXuORv9fQ0/pml+WXrY+UjE8vyRqleLeFKZvjjbttuhvSb4hk4ohoy
 Fc2b6aK2pmNxLuwvOBV42FpYHSDxxMsXBJE8RXmadlgBMpCALVuCuDqg3uJLcBw5
 DkcZ8QDRGt/yGZeVbdEcPxNWEHUzMxo5WVqqXiI24YaRGI8APiAXqBgShYz/SF+z
 U6dbc66dIqUwRpLtMLbl8AS74gBDah+vHxxUY1Ls0EpojsDZAL/TiiTtnULPV0am
 KNLjTw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys58q5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so5650150eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792390162; x=1792994962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vtKKQrX5B25I3FY3U2q6VZJzSoUs2jju69TqJA1QZss=;
 b=cZ6OFmIl2Pg0xQjg/dePmGbYw3PuSM+pgetxmiSALc13vHMmCLLoIu1J2sb7YSqado
 p3aBfR3guCN2efY/B53Ia97JucZ4oFAdjzq6XCDJ/JMvgnat1NFP7Qun90aGhsIoK8HO
 +dI0Qlt2y+Wod0z56fwJ2jpTWcY7DCtbU6PzWWWAT9woMx2sKsoAoSRRGZxXe4bfyx3w
 Q6YG0NMGigHvYux3h8Sk4CRiv4zdYdmKPmQ2MaxHAPUG/Invfp94Gr1hE+7IiVSGOOU1
 p1dCwQxTx3/kMz/Yin36Z8tMn/JFGG7qWhUr3TtDII+vGnLIZi+7+TgkytDxTVZPwiE8
 s3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792390162; x=1792994962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vtKKQrX5B25I3FY3U2q6VZJzSoUs2jju69TqJA1QZss=;
 b=eCO8OGIupnxae9pgx03/aeJsOUr9N7aSUEz/srNmzRl2bUAlUHpGDUKIzn/ekMERQn
 MTU5eKR3dMJMwRQR9a0+gjht1peZ0HBMADA5571eU2AgCS8I61CY6wXIIjDnDva7vlmE
 Gc6AuDApsMx8rcMdC/Cz4LKmcD8TIxUYYZQaHKhuzUWZvng9fl8Cwh/AimeNYYeskPr7
 aIhP4aVECQHqFSV/iYeSbYuSMU/nEhujxweqqKpRt+sJJHlDjnIQJTY6iYRrK2xP19ZA
 o83i98qRaVFQvVw4aIfu0QEA71Bb6RWQo5fSNTBb4m29JTL7kIo+kXFSQY2GciXDyOYs
 tKNQ==
X-Gm-Message-State: AFq9FYIvyrnKgyAcfl65dbT9z4CqSw2Ntd9BGz8b2+464BNA1v3FKVwj
 Dzku7ERFhRwY4PxPWKc6qYv1/CAXLR0BOa8zZ+ShztRHO57p8ogtZziSZcRDnM/muwB0lHnUfHy
 3V13eHbzsXCobPuLVlaz/G72KrB9QiPbnSGGVVz17kHwVA3USU3qy9wd+nm9IKdm+rw==
X-Gm-Gg: AYBFou2USMv2r4cjIzRFyHVntWPrP2ej5WZVAJrRcJuOFgEJxauOPfQG7a+qrvqVsz4
 25GYV84dNUeVl8IDF9LicXlVMaDXt9AR38qr5alkMJ7GIqxzUu2o9KEc5ozFgSNTU2DsabipvL3
 yMHaWf4gjocXo8wnMc7Y14vCILLg4d59SE0fhj7bTinu7EGDIKSYhjiwChFedaXR5VAJgF0tCA5
 wCD8pXbroRTXE06GgfW5eOMaMQELYacwxJKp4IFXcKGaJhlhgn/z6FHWvomEkws8T3pdB61Pabi
 OUNZKHQA6kRzuS4NDtSmMpqyCgKbB99asQRi1FEmlIGvKA8CKCLlvvUEUiDxjAaU6uSdz0aIBkB
 uwUiwR2bxZeC54ZO/itKvp7ngXDMxlAvLBXFEbyugF5huARw=
X-Received: by 2002:a05:7300:dd49:b0:361:92b6:6755 with SMTP id
 5a478bee46e88-361a2c34a09mr10487531eec.36.1792390161531; 
 Sun, 18 Oct 2026 23:09:21 -0700 (PDT)
X-Received: by 2002:a05:7300:dd49:b0:361:92b6:6755 with SMTP id
 5a478bee46e88-361a2c34a09mr10487493eec.36.1792390160950; 
 Sun, 18 Oct 2026 23:09:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm31770053eec.17.2026.10.18.23.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:09:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 4/5] hw/intc: ciad should forward its mask to l2vic
Date: Sun, 18 Oct 2026 23:09:10 -0700
Message-Id: <20261019060911.1479329-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfXzeYslZ7Ei99W
 0XrU9JPOTKzrUAa3J5WO8JkvzZHdZpMF17CZLsGDayxKVwzhsEB1n19jWisMZmITC/bjbf/p4my
 i4G8gzeSMD1B2zK2XyTHnYOifP2swLyF0bAasJmJu9087mIb8tesgI51vDIL+S2CTlkg1t7ZX2j
 ebyvoWcsikDlbvdDMAkQ43wmqfQ+/riCJmlJ1ItiE4DWjke+wsx9zAcOjTKmXhilNsChK22A6My
 S6Kx9WHBNwk/NwGyrWKjNNRpn27wYlbo8MtrbKO0S69YtXvL6/AtPuovMveoMArhBWe4vdYyKJ9
 p3xxXo0UznDQJ7p5nWWb2Md9juz1PuTVXGIEhhULN72WqstPOwZBwcI3ZDDCxxJww6rMAW8QF3a
 tyqCI78wKVDOiQ0ad3F76Ew7s/kO6ABjcOjC3SEWwnfn/fk9ABEMmIRkeM9VHW/XCOtRbrheoKe
 17wsxkn+BdJzGqynzdg==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad5b412 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=zi4VUfZ7aQnuQJZsh1MA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: iHG0RAn_-VUxysezmWUACJLgj4DBqdCW
X-Proofpoint-GUID: iHG0RAn_-VUxysezmWUACJLgj4DBqdCW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX0OWpWK6nH2cf
 9E2Mgv5ClfPoSj1/QEEEOQ95yintV9FCtLEmBCVxESFxYB/n1jRHkyGbduf1qp9o+4ArfveDaVp
 9Vqw9fjY08TE7gOcFpfAm3fsPz+CZ58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190024
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

Y2lhZCBjbGVhcmVkIHRoZSBsYXN0IGludGVycnVwdCB0aGUgTDJWSUMgZGVsaXZlcmVkIHJlZ2Fy
ZGxlc3Mgb2YgaXRzCm1hc2suICBTbyBhIGNpYWQgZm9yIGFueSBvdGhlciBpbnRlcnJ1cHQgd291
bGQgZ2V0IGFwcGxpZWQgaW5jb3JyZWN0bHkuCgpPbmx5IGNsZWFyIHRoZSBhY3RpdmUgaW50ZXJy
dXB0IHdoZW4gdGhlIGNpYWQgYWNrbm93bGVkZ2VzIHRoZSBDUFUKaW50ZXJydXB0IHRoYXQgaXRz
IFZJRCBncm91cCBpcyBkZWxpdmVyZWQgb24sIGFuZCBvbmx5IGlmIHRoYXQgaW50ZXJydXB0Cndh
cyB0YWtlbiBvciBzZXQgd2l0aCBzaWFkLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2aWMu
aCB8IDE0ICsrKysrKysrKystLS0tCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAgICAgfCAxMCAr
KysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxNCArKysrKysrKystLS0t
LQogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmggYi9pbmNsdWRlL2h3L2ludGMv
aGV4LWwydmljLmgKaW5kZXggZWRjMjc4MjY2Y2IuLmFlMDY3ZmU5NWViIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKKysrIGIvaW5jbHVkZS9ody9pbnRjL2hleC1sMnZp
Yy5oCkBAIC0zMSw4ICszMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZpY0ludGVyZmFjZUNs
YXNzIHsKICAgICB2b2lkICgqdXBkYXRlX3ZpZCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmljLCB1
aW50MzJfdCBncm91cCwKICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZhbHVlKTsK
IAotICAgIC8qIENsZWFyIGludGVycnVwdCB1c2luZyBDSUFEIGluc3RydWN0aW9uICovCi0gICAg
dm9pZCAoKmNsZWFyX2ludGVycnVwdCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmljKTsKKyAgICAv
KgorICAgICAqIENsZWFyIGludGVycnVwdHMgdXNpbmcgdGhlIENJQUQgaW5zdHJ1Y3Rpb24uCisg
ICAgICogQG1hc2sgdGhlIENQVSBpbnRlcnJ1cHRzIHRoYXQgdGhlIENJQUQgYWNrbm93bGVkZ2Vk
LiAgVGhlIGludGVycnVwdCBpcworICAgICAqIG9ubHkgY2xlYXJlZCBpZiBAbWFzayBoYXMgdGhl
IENQVSBpbnRlcnJ1cHQgdGhhdCBpdHMgVklEIGdyb3VwIGlzCisgICAgICogZGVsaXZlcmVkIG9u
LgorICAgICAqLworICAgIHZvaWQgKCpjbGVhcl9pbnRlcnJ1cHQpKEhleEwyVmljSW50ZXJmYWNl
ICpsMnZpYywgdWludDMyX3QgbWFzayk7CiB9IEhleEwyVmljSW50ZXJmYWNlQ2xhc3M7CiAKIERF
Q0xBUkVfT0JKX0NIRUNLRVJTKEhleEwyVmljSW50ZXJmYWNlLCBIZXhMMlZpY0ludGVyZmFjZUNs
YXNzLApAQCAtNTIsMTAgKzU3LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMnZpY191cGRhdGVf
dmlkKEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgZ3JvdXAsCiAgICAgay0+dXBk
YXRlX3ZpZChsMnZpYywgZ3JvdXAsIHZhbHVlKTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIGwy
dmljX2NsZWFyX2ludGVycnVwdChIZXhMMlZpY0ludGVyZmFjZSAqbDJ2aWMpCitzdGF0aWMgaW5s
aW5lIHZvaWQgbDJ2aWNfY2xlYXJfaW50ZXJydXB0KEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgbWFzaykK
IHsKICAgICBIZXhMMlZpY0ludGVyZmFjZUNsYXNzICprID0gSEVYX0wyVklDX0lOVEVSRkFDRV9H
RVRfQ0xBU1MobDJ2aWMpOwotICAgIGstPmNsZWFyX2ludGVycnVwdChsMnZpYyk7CisgICAgay0+
Y2xlYXJfaW50ZXJydXB0KGwydmljLCBtYXNrKTsKIH0KIAogI2VuZGlmIC8qIEhXX0lOVENfSEVY
X0wyVklDX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hl
eC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi5iNzNlY2I4MjFlNCAxMDA2NDQKLS0tIGEvaHcv
aW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC00NDgsMTIgKzQ0
OCwxNiBAQCBzdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfdXBkYXRlX3ZpZF9pbXBsKEhleEwy
VmljSW50ZXJmYWNlICppZmFjZSwKICAgICBsMnZpY191cGRhdGVfYWxsKHMpOwogfQogCi1zdGF0
aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfY2xlYXJfaW50ZXJydXB0X2ltcGwoSGV4TDJWaWNJbnRl
cmZhY2UgKmlmYWNlKQorc3RhdGljIHZvaWQgbDJ2aWNfaW50ZXJmYWNlX2NsZWFyX2ludGVycnVw
dF9pbXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtYXNrKQogewogICAgIEhleEwyVklD
U3RhdGUgKnMgPSBIRVhfTDJWSUMoaWZhY2UpOworICAgIGNvbnN0IHVpbnQzMl90IHNpemUgPSBM
MlZJQ19JTlRFUlJVUFRfTUFYOworICAgIGNvbnN0IHVpbnQzMl90IGFjdGl2ZV9pcnEgPSBmaW5k
X2ZpcnN0X2JpdDMyKHMtPmludF9zdGF0dXMsIHNpemUpOwogCi0gICAgaWYgKHMtPnZpZCA8IEwy
VklDX0lOVEVSUlVQVF9NQVgpIHsKLSAgICAgICAgY2xlYXJfYml0MzIocy0+dmlkLCBzLT5pbnRf
c3RhdHVzKTsKKyAgICAvKiBWSUQgZ3JvdXAgbiBpcyBkZWxpdmVyZWQgb24gQ1BVIGludGVycnVw
dCBuICsgMiAqLworICAgIGlmIChhY3RpdmVfaXJxICE9IHNpemUgJiYgKG1hc2sgJiBCSVQoZ2V0
X3ZpZChzLCBhY3RpdmVfaXJxKSArIDIpKSkgeworICAgICAgICBjbGVhcl9iaXQzMihhY3RpdmVf
aXJxLCBzLT5pbnRfc3RhdHVzKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlX2FsbChzKTsKIH0K
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKaW5kZXggOTg1MGRjMDcyODkuLjJiODQxNGY1ZjUzIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YwpAQCAtMTYxMywyNiArMTYxMywzMCBAQCB2b2lkIEhFTFBFUihyYWlzZV9zdGFja19vdmVyZmxv
dykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsCiB2b2lkIEhFTFBFUihjaWFk
KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKICAgICB1aW50MzJfdCBp
YWQ7CisgICAgdWludDMyX3Qgd2FzX3NldDsKICAgICBIZXhhZ29uQ1BVICpjcHU7CiAKICAgICBC
UUxfTE9DS19HVUFSRCgpOwogICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAgICAgaWYgKGNw
dS0+Y2ZnLmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgxKSB7CiAgICAgICAgIGlh
ZCA9IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19JQUQs
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgJiB+
bWFzazsKLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5nbG9iYWxyZWdzLCBI
RVhfU1JFR19JQUQsIGlhZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
bnYtPnRocmVhZElkKTsKKyAgICAgICAgd2FzX3NldCA9IGlhZCAmIG1hc2s7CisgICAgICAgIGhl
eGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfSUFELCBpYWQg
JiB+bWFzaywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7
CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaXBlbmRhZCA9CiAgICAgICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CiAKLSAg
ICAgICAgZlNFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwKLSAgICAgICAgICAgICAgICAg
ICBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKSAmIH5tYXNrKTsKKyAgICAgICAgaWFk
ID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgICAgIHdhc19zZXQgPSBp
YWQgJiBtYXNrOworICAgICAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFELCBpYWQg
JiB+bWFzayk7CiAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVn
cywgSEVYX1NSRUdfSVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXBl
bmRhZCwgZW52LT50aHJlYWRJZCk7CiAgICAgfQotICAgIGwydmljX2NsZWFyX2ludGVycnVwdChj
cHUtPmwydmljKTsKKyAgICAvKiBPbmx5IGFuIGludGVycnVwdCB0aGF0IHdhcyB0YWtlbiwgb3Ig
c2V0IHdpdGggc2lhZCwgY2FuIGJlIGNsZWFyZWQgKi8KKyAgICBsMnZpY19jbGVhcl9pbnRlcnJ1
cHQoY3B1LT5sMnZpYywgd2FzX3NldCk7CiAgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZW52KTsK
IH0KIAotLSAKMi4zNC4xCgo=

