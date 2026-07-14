Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17023C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfQ2-0000yd-3x; Tue, 14 Jul 2026 11:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfQ0-0000y6-IQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfPz-00014E-16
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcP9V893288
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ar6lVTR4o40Y8mAt9MPiR+MLeALHdR24ouRtrSRI3B4=; b=W0prmCqFYdgN7hvf
 Ngz5QIM5o4mQx4ZP3figoClumhz+mnEvhOHDpRfl6m8PHgGsWDKyT3S9Fi7ELOR6
 OAuiV7PdYj2AWf4sBkG1KHxVqFd09LiKCtRQ0Cb9B5v4svwoDZNUGgKSnB0Upc25
 k1aGgmM1mYLDFNrJ+q+F6zTQlRxwgOdeLAKkjtugq1p7USb3RzE5tJ9h75Z2JEq4
 eEhELl5ug+tCoztFOVJzHzWXcQ3JnMEBYVuJ51eVf6RoMqrDZ36NxqRc5s2R4kzH
 5wCeuldXgcq8u6kytAdzgHyBw0xw5AEZyyItM0RHsM30IL4rrjPxWOctR3oxX9Wn
 yj6wnQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqrr5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso10349565a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784044293; x=1784649093; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ar6lVTR4o40Y8mAt9MPiR+MLeALHdR24ouRtrSRI3B4=;
 b=csGYI9fQfLoWMcfFdl+m9fJfpti6sTq0GwdsNyDKG/tdPMvaXjTtQmpFJYtv/s/wzR
 EiwdSRq3fOCL0DvtN/cm2hG91xQeE9mapWe5AFEQMxmtFC7dwOmRLczLC6IkZeYZNgIx
 NJ3wt8GW3Ojk0LmyXnTrCX8vOn5ha+oZzJHzlJubKnhZD0Nqrg7Qxe8NqEam+4QRQx/N
 i4DyB5hfeR+qoOTX5Y9CqgRctoOZRe6BCyFq4DqDEGqaPqOdpZaVCdAnKjvy7OPLeDii
 fqYkCXNEyKchijq2K18U0EeP5TrA6hfYbsXNK1LXKrMk94lq4AicoMRlJgr31Cx1U4i0
 FRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044293; x=1784649093;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ar6lVTR4o40Y8mAt9MPiR+MLeALHdR24ouRtrSRI3B4=;
 b=SlNsSw3ECEHs/LDQZhk6S1yxbfzQvQQ9IX7X9G/QbfqP4haUhDggqySjZPAMnaPpNM
 LH05URgM+0ZPOgXehFz/a9Nmno47e+U08pAlDF64KqJrvenO78yvWHgyuKBb2ui2+eqP
 Xnoz1QgIYEbbPUXalwaFESbMopKOw57ODSSFVerw5sRapHQkkzD+0r7ENlIcLjOiu9d/
 iIuTpIinoJUMuqDFGrV8xm5ImsZYpGuywr2OTsyY4E1qct3leZ1UdyHMZ9ty5tj52RTU
 nZGsKDBlf+eNgCLDgv7I2fcqZj8QByaQQXamSZfwHFuUXQ3ZmwYerBs0zJmUfebFcvxj
 7ZoA==
X-Gm-Message-State: AOJu0YyTFq3DBc1ZSflPyM9wLMMtau9U13LWZMdmNFEn5sjm+sKZ3i8o
 JzAWVtQuiUTRSM/uyNDVNb/PNK19dcEwrXFw8zg3PgGIEUAW/ngjMprmpK4Nt7sPJq8bXVdBljH
 aUUMpeSVl44FOU3iHohhlzeEDxXG4PEwN/eNK97rbitlqU2a+snxKIVNEkSAJlnQLfQ==
X-Gm-Gg: AfdE7cke59KGtCOgkqJ+NJZYqhyDt+le1OyPrL9NHC/M3WL2Y9x+/hSr0LU4jrXN4jA
 Pdt5PdKKiQaXpyiteqPLzLWi75EsWyo1sHaVgPIFYRmueQIq7I8GEPvptRP3RKuJx9CUMi/ExrA
 1vKH+FUn7URsvFrNVJMT+5Jvt2PmPoMkOF6QnqmEI8tOt29SV5bV77t1Y3ctq0F0owJS3cwFjX/
 6xs7w72uLTwuPBY8nfphMdMPbv1Bg7epUhCNcC/umAbqArGYRmjuxqV2ocGJ3LzlM40lYisbylu
 QFBLzccYbXz9by7vA1/XYyZfJJbRg0thJwMr3nggM23H8qXabP6+S4vQCt6ff6d8GWj5Y1wMWrZ
 rxh5qwPntHchQGN2Z8NKwgx79okIzFgHCnWZQrZGMavQEgqSJISz3nlR6gTU=
X-Received: by 2002:a05:6a20:c6c9:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3c35707e50dmr3251909637.33.1784044292825; 
 Tue, 14 Jul 2026 08:51:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:c6c9:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3c35707e50dmr3251861637.33.1784044292239; 
 Tue, 14 Jul 2026 08:51:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm41343581c88.0.2026.07.14.08.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:51:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 3/7] bitops.h: Add find_first_bit32()
Date: Tue, 14 Jul 2026 08:51:22 -0700
Message-Id: <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX1Th+tlUXJZoR
 f2rhtgc2BomT9nz7VWdi5xbyJG0dlCqJhOuARrnkb4NtTbGpFJwfuJSvQrF1MmOhIKib4KzSoWs
 BwIKhFwsu8Cbgb3HGWZ879dYxCZOue3zHLRKtFfPZm7BnmAT4T0/92fUhOYwxBiPOT6/B4TvYxG
 sZLiufBjWy43maARIEl18YfqAFwM4rgJ1Udl6OCBIBi6v3fDHbDg7uKs2kTO1rmURGcaqqIMgFX
 E8ZrE1qQRUPnQLyKX+1exeyCQEClZYuL+z1/bVieMzfGNe9Fnpmrho2cjfJm2ZnyGkX1lwz4uX0
 Kfd+NvYeTQgCxwKAXtxi0tK9bZ9hdN9zXQOLTWBjOqn3Y5f2L5jXHb0WNd0DTtQe7Jf/BMkraJi
 Gd/8BwArxseKP1iLxUftS+CkNh4FfHAikzdaLXvsEta44xRZZ9mYxlih8xCG9pMslRcdjrAxrCu
 Z2d+5quOPJmm3c+MeMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX7LoTa7mMWgzL
 dHw7QuekeStm42S+vY22+/kCEobE0L8Ya/fvfF/3IRi4vPfJl91RFMaVeT2bbxLvLaMiHIWEOZ0
 6py9IcwYDRpfTj9hLgjkj5pZYNyKjK8=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a565b05 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -fxkjmO-py6ghDaIx1IQ5-DEZc6LE4dy
X-Proofpoint-ORIG-GUID: -fxkjmO-py6ghDaIx1IQ5-DEZc6LE4dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140164
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

c2V0X2JpdDMyKCkvdGVzdF9iaXQzMigpL2V0YyBhbHJlYWR5IGxldCBkZXZpY2VzIG9wZXJhdGUg
b24KZ3Vlc3QtdmlzaWJsZSB1aW50MzJfdCByZWdpc3RlciBhcnJheXMgd2l0aG91dCBkZXBlbmRp
bmcgb24gdGhlCmhvc3QncyAndW5zaWduZWQgbG9uZycgc2l6ZS4gZmluZF9maXJzdF9iaXQoKSBo
YXMgbm8gc3VjaAplcXVpdmFsZW50LCB3aGljaCBwdXNoZXMgY2FsbGVycyB0b3dhcmRzIGNhc3Rp
bmcgYSB1aW50MzJfdCBhcnJheQp0byAndW5zaWduZWQgbG9uZyAqJy4KCkFkZCBmaW5kX2ZpcnN0
X2JpdDMyKCksIGltcGxlbWVudGVkIHRoZSBzYW1lIHdheSBhcyBmaW5kX2ZpcnN0X2JpdCgpLgoK
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGluY2x1ZGUvcWVtdS9iaXRvcHMuaCB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2JpdG9wcy5oIGIvaW5jbHVkZS9xZW11L2JpdG9wcy5o
CmluZGV4IGM3YjgzOGE2MjgzLi5mNzM2M2E1NDc5ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9xZW11
L2JpdG9wcy5oCisrKyBiL2luY2x1ZGUvcWVtdS9iaXRvcHMuaApAQCAtNDMsMTAgKzQzLDkgQEAK
ICAqIGJlIHNvbWUgZ3Vlc3QtdmlzaWJsZSByZWdpc3RlciB2aWV3IG9mIHRoZSBiaXQgYXJyYXku
CiAgKgogICogV2UgZG8gbm90IGN1cnJlbnRseSBpbXBsZW1lbnQgdWludDMyX3QgdmVyc2lvbnMg
b2YgZmluZF9sYXN0X2JpdCgpLAotICogZmluZF9uZXh0X2JpdCgpLCBmaW5kX25leHRfemVyb19i
aXQoKSwgZmluZF9maXJzdF9iaXQoKSBvcgotICogZmluZF9maXJzdF96ZXJvX2JpdCgpLCBiZWNh
dXNlIHdlIGhhdmVuJ3QgeWV0IG5lZWRlZCB0aGVtLiBJZiB5b3UKLSAqIG5lZWQgdGhlbSB5b3Ug
c2hvdWxkIGltcGxlbWVudCB0aGVtIHNpbWlsYXJseSB0byB0aGUgJ3Vuc2lnbmVkIGxvbmcnCi0g
KiB2ZXJzaW9ucy4KKyAqIGZpbmRfbmV4dF9iaXQoKSwgZmluZF9uZXh0X3plcm9fYml0KCkgb3Ig
ZmluZF9maXJzdF96ZXJvX2JpdCgpLAorICogYmVjYXVzZSB3ZSBoYXZlbid0IHlldCBuZWVkZWQg
dGhlbS4gSWYgeW91IG5lZWQgdGhlbSB5b3Ugc2hvdWxkCisgKiBpbXBsZW1lbnQgdGhlbSBzaW1p
bGFybHkgdG8gdGhlICd1bnNpZ25lZCBsb25nJyB2ZXJzaW9ucy4KICAqCiAgKiBZb3UgY2FuIGRl
Y2xhcmUgYSBiaXRtYXAgdG8gYmUgdXNlZCB3aXRoIHRoZXNlIGZ1bmN0aW9ucyB2aWEgdGhlCiAg
KiBERUNMQVJFX0JJVE1BUCBhbmQgREVDTEFSRV9CSVRNQVAzMiBtYWNyb3MgaW4gYml0bWFwLmgu
CkBAIC0zODIsNiArMzgxLDI5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYml0MzIobG9uZyBu
ciwgY29uc3QgdWludDMyX3QgKmFkZHIpCiAgICAgcmV0dXJuIDFVICYgKGFkZHJbQklUMzJfV09S
RChucildID4+IChuciAmIDMxKSk7CiB9CiAKKy8qKgorICogZmluZF9maXJzdF9iaXQzMiAtIGZp
bmQgdGhlIGZpcnN0IHNldCBiaXQgaW4gYSBtZW1vcnkgcmVnaW9uCisgKiBAYWRkcjogVGhlIGFk
ZHJlc3MgdG8gc3RhcnQgdGhlIHNlYXJjaCBhdAorICogQHNpemU6IFRoZSBtYXhpbXVtIHNpemUg
dG8gc2VhcmNoCisgKgorICogUmV0dXJucyB0aGUgYml0IG51bWJlciBvZiB0aGUgZmlyc3Qgc2V0
IGJpdCwKKyAqIG9yIEBzaXplIGlmIHRoZXJlIGlzIG5vIHNldCBiaXQgaW4gdGhlIGJpdG1hcC4K
KyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmaW5kX2ZpcnN0X2JpdDMyKGNvbnN0IHVpbnQz
Ml90ICphZGRyLCB1aW50MzJfdCBzaXplKQoreworICAgIHVpbnQzMl90IHJlc3VsdDsKKworICAg
IGZvciAocmVzdWx0ID0gMDsgcmVzdWx0IDwgc2l6ZTsgcmVzdWx0ICs9IDMyKSB7CisgICAgICAg
IHVpbnQzMl90IHRtcCA9ICphZGRyKys7CisgICAgICAgIGlmICh0bXApIHsKKyAgICAgICAgICAg
IHJlc3VsdCArPSBjdHozMih0bXApOworICAgICAgICAgICAgcmV0dXJuIHJlc3VsdCA8IHNpemUg
PyByZXN1bHQgOiBzaXplOworICAgICAgICB9CisgICAgfQorICAgIC8qIE5vdCBmb3VuZCAqLwor
ICAgIHJldHVybiBzaXplOworfQorCiAvKioKICAqIERPQzogTWlzY2VsbGFuZW91cyBiaXQgb3Bl
cmF0aW9ucyBvbiBzaW5nbGUgdmFsdWVzCiAgKgotLSAKMi4zNC4xCgo=

