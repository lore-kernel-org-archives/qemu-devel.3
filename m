Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A16606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VyjawCcd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KETPPNvh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW15-0003W3-Np; Mon, 09 Nov 2026 15:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0b-0003Nr-Kl
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0Z-0007I1-3j
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:29 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH71i879249
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 42bq2TLvBR91FB9721+WCAnGkGl91+gPvA1PHP1ZjlU=; b=VyjawCcdmWLbdHgD
 oXnQTuv46N71OGxuoMmKPq43U5NIFpvD/blSQKsgmRO0iD4IrlMcxl1LpgtA8s5x
 FDFnfEtxHOY6q7qEn/pNMHYxlLJQHKii+P8hHhjuF24s8Z9vMiyHmYFk57jUxxYb
 tg8JYzCsoTOxE2kLOTX4f3w+1/KFssjdqFaraY9Zi677WE4rOy9oZrH/okvdmCew
 KUqvEqyPAk6DxAk24MehTZ9nulqbpg75qXakCVNjBMIrj64c/C3O1rmTpdi3AUdg
 msST1lMS+2hHODN0HTF+vznGsBTXa9rDjPCP/hxySm3PhoNSebB801oC5zEVqLkp
 Xp0mUA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5t24a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:30:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so2229375eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256225; x=1794861025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=42bq2TLvBR91FB9721+WCAnGkGl91+gPvA1PHP1ZjlU=;
 b=KETPPNvh8++C4tcTmQWapkDJ6FGUwsahkSn3gsnE2Ophsmk3JN5H9RtmOepOS0iH6j
 AMBO98Y5VvvPAxakFEw7SXpRTnfagglRrDbJf1qcTyJx85ctU3kA6OrR4M0vdRtzkC3D
 kxXfjUpZqEUDPAo5PI3h+/0P2dFijtufZvKNB1+fM9vm6yrkCKgOdJYcG3PagTM4qpAJ
 qEpQplgEKg8EM2TaUaIQzwT0Ca+OPTXWEYqoAXOHmqlQ0E+oYzubF59fKJ6u9JnvcE06
 Xyf+KLWl1Ir0F2z/z3eSU+UaWFvwUXgGLf3ZDh7ET3G1g2H+df8JwethjpZyQY7uFeIU
 dRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256225; x=1794861025;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=42bq2TLvBR91FB9721+WCAnGkGl91+gPvA1PHP1ZjlU=;
 b=MljT4gsUo9Aa9XBOd0axq0+vOm//eULj48mM9iRZafZORLdgr/tGls7iXQEogIXRRv
 d3//Lk0fzJISLvKu3WaiGeG/9rFdeft/foYX7jBXbmg+vBzkW8Lhdj7a+9lqJDlH31zq
 HwNEV705LuUwQwqopjszsBKlpqAZGojsQ+K+9oE9vMYrrGyvC2sGvcBA8XrQmms9Xqsk
 Bc1iGBHcX4cmAVDbP6tsIHrK9oAhZvT/fjCBfgQ9CsBAKlom2pWjeaZpJId8aEPPxSFo
 m0jJjjJ1RW5HN3pkwXJW1GgOYVWyxWi28ewgO2kNyTHxp1xN/KIHCKblX7xUdDeaICji
 g/rg==
X-Gm-Message-State: APuU4Z/ULSMQ4XTa95Dk38kjgRqsALf1KSTWfdvoESalG0YdRyzO12wp
 3qdp5QhdLLxofIVodET65CFwLjqT6tAPz+Kzb8SJoGORLzS1Ub2ElKL2BJPhWx7wwe0D/Lg9uMt
 lSZ/lLti/ZqkOc/ZUEHEp+c8/oQ1eKjXw30lXk66lf8YVx9AKwsnN6/tndf/9bncOxw==
X-Gm-Gg: AYBFou3M3+Wb0fyO341uVpLf4JvfQ7grI61aMs1JZS+lpkl872MgiyAm63uWgUfcOTH
 xFhrnpoTk3R9yNc5mxFfkUgbgG//4FKi9A1EB8O27omVU3j1i/iWHCYrFMzaZm64Gk/Ujd6PEsG
 vPaxWUMYAJXpvJmvHOiQjRd9FIyc+imjaPhzbJskwBUVII/j0mmxsLnySCPiV6nYs1McC/Z3k5v
 H9e4qCx2Sz30R/xm4I/KT5VaM9MOQOyUCnf820BHNhVcZimEs3tqtXbMnLY+bLyILkpyU4ZdYX4
 QGC+MoKtbPAQGXvJLTIQGBTBNLuMmh6wHce/QvnnE1XkrnUn9j187fO962RKqHP69idAyXKBHei
 QUh4P7JZgXM7XXTravn5rvyGmRvMR7ogQu+DKTcE3u46/3iYfmG8sgbRRLVUrrgWxBpXLTn3CfK
 GmHNcW0hMgwxM+R2GUP1Pc
X-Received: by 2002:a05:693c:65d6:b0:375:388:a6d5 with SMTP id
 5a478bee46e88-375211f1c97mr459094eec.32.1794256223089; 
 Mon, 09 Nov 2026 12:30:23 -0800 (PST)
X-Received: by 2002:a05:693c:65d6:b0:375:388:a6d5 with SMTP id
 5a478bee46e88-375211f1c97mr459025eec.32.1794256222055; 
 Mon, 09 Nov 2026 12:30:22 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm823737eec.14.2026.11.09.12.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:30:21 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 3/5] docs/system/hexagon: document boot interfaces
Date: Mon,  9 Nov 2026 12:30:15 -0800
Message-Id: <20261109203017.262225-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
References: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfXwsmTh8bcLywj
 jkwaakj6LZYwCPK7YZHFXK4PEoYlQw8V+Z1QHhWzLFPYSQX+QBMIeJxrDdR19w3C2iZpgDEEz7u
 F0e/SiH8EtMMFvVxls0vMod9+2wExKw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX9WF9yO6ZRomo
 ZedmVfRctQMoQTF++/tM3Knk0JUDGHwhEnbkzDmEDI3+zdX5MBXpLzWuAS1uT/DY5q0eb9KGr/x
 haYqEJlt1toNKbLTbvBimU/lUlGL5xu60IH2rQtezOg1c0g1VDJg//3zAg3YLT6/fYP1VIqU50f
 3uCJ0jImda6IkPEdNOUecNPPvzkMAxgDTOFMaU26ZHf/aa3LLu06XkH6Tb+qNu1gkYGuCJmyNSw
 QxonrUisBtCw25nqD28Ks/cb1uTqHwDh/e1y6XJUhTvMnYfcpyYYZeXHOJnDFaSzfm8Ye3ES2N6
 gmu90rTpa/GpV5+gdStT9lOpAlYzifDKors3V1XJ6AbdeOYKudHk97NowMOf996eUNwl/FjoW1L
 BPbu17Qn7Lt5YCOFm73CG7n9ZzzBnAA8gbDr/y3xSzCBQ3N+bjzYU/KZC/IVJs/mrqJl5jZFUUy
 pxf9eHkAb1Ep1NaJscQ==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af22d61 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=P_3Ky2eAZP25M8n5cw8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: RCXQNVAFHxkAsCzVCmCVXPN-S8PGE3jy
X-Proofpoint-GUID: RCXQNVAFHxkAsCzVCmCVXPN-S8PGE3jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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

RGVzY3JpYmUgRUxGIGFuZCByYXctaW1hZ2UgbG9hZGluZywgcmVzZXQgc3RhdGUsIHRoZSBEVEIg
aGFuZG9mZiB0byBWTQpob3N0IGZpcm13YXJlLCBhbmQgaW5pdGlhbCB0aHJlYWQgc3RhdGUuIEV4
cGxhaW4gVUFSVCBhbmQgc2VtaWhvc3RpbmcKY29uc29sZSByb3V0aW5nLgoKUmV2aWV3ZWQtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IGRvY3Mvc3lzdGVtL2hleGFnb24vYm9vdC5yc3QgICB8IDEwMCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdCB8ICAgMSArCiAy
IGZpbGVzIGNoYW5nZWQsIDEwMSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9j
cy9zeXN0ZW0vaGV4YWdvbi9ib290LnJzdAoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFn
b24vYm9vdC5yc3QgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2Jvb3QucnN0Cm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4zNmM2MDNjNjllMAotLS0gL2Rldi9udWxsCisrKyBi
L2RvY3Mvc3lzdGVtL2hleGFnb24vYm9vdC5yc3QKQEAgLTAsMCArMSwxMDAgQEAKKy4uIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisKK0hleGFnb24gYm9vdCBpbnRl
cmZhY2UKKz09PT09PT09PT09PT09PT09PT09PT0KKworYGBxZW11LXN5c3RlbS1oZXhhZ29uYGAg
bG9hZHMgdGhlIGluaXRpYWwgaW1hZ2UuIEd1ZXN0IHN0YXJ0dXAgY29kZQoraW5pdGlhbGl6ZXMg
dGhlIHN0YWNrLCBleGNlcHRpb24gaGFuZGxpbmcsIGFuZCBydW50aW1lIHN0YXRlLiBXaGVuIGEK
K0hleGFnb24gVk0gaG9zdCBpcyBsb2FkZWQsIGl0IGVzdGFibGlzaGVzIHRoZSBndWVzdCBPUydz
IGJvb3QgZW52aXJvbm1lbnQuCisKK0luaXRpYWwgaGFyZHdhcmUgc3RhdGUKKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KKworT25seSBoYXJkd2FyZSB0aHJlYWQgemVybyBzdGFydHMgZXhlY3V0aW5n
LiBPdGhlciB0aHJlYWRzIHN0YXJ0IHBvd2VyZWQKK29mZi4KKworRXhlY3V0aW9uIHVzZXMgdW50
cmFuc2xhdGVkIHBoeXNpY2FsIGFkZHJlc3NlcyBpbiBtb25pdG9yIG1vZGUuIEd1ZXN0IHNvZnR3
YXJlCittdXN0IHBvcHVsYXRlIFRMQiBlbnRyaWVzIGJlZm9yZSBlbmFibGluZyB0aGUgTU1VLCBh
bmQgc2V0IHVwIGV4Y2VwdGlvbiB2ZWN0b3JzCithbmQgaW50ZXJydXB0IG1hc2tzIGJlZm9yZSBl
bmFibGluZyBpbnRlcnJ1cHRzLiBTZWUKKzpkb2M6YC4uLy4uL2RldmVsL2hleGFnb24tc3lzYCBm
b3IgdGhlIHN5c3RlbSBhcmNoaXRlY3R1cmUuCisKK1FFTVUgc2V0cyB0aHJlYWQgemVybydzIFBD
IHRvIHRoZSBzZWxlY3RlZCBpbWFnZSBlbnRyeSBhZGRyZXNzLiBgYEVWQmBgCitpbml0aWFsbHkg
Y29udGFpbnMgemVybzsgRUxGIHN0YXJ0dXAgY29kZSBpbnN0YWxscyBpdHMgb3duIGFsaWduZWQg
ZXZlbnQKK3ZlY3RvciBiYXNlLgorCitTaW11bGF0b3ItY29tcGF0aWJsZSBtYWNoaW5lcworLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KKworYGAta2VybmVsIGZpbGVgYCBsb2FkcyBhIGxp
dHRsZS1lbmRpYW4gSGV4YWdvbiBFTEYsIHBsYWNlcyBpdHMgbG9hZGFibGUKK3NlZ21lbnRzIGFj
Y29yZGluZyB0byB0aGVpciBwaHlzaWNhbCBhZGRyZXNzZXMsIHplcm8tZmlsbHMgdGhlIHNlZ21l
bnRzJworcmVtYWluaW5nIG1lbW9yeSwgYW5kIHN0YXJ0cyB0aHJlYWQgemVybyBhdCB0aGUgRUxG
IGVudHJ5IHBvaW50LiBMaW5rCitzdGFydHVwIGNvZGUgZm9yIHVudHJhbnNsYXRlZCBleGVjdXRp
b24sIHdpdGggdGhlIGVudHJ5IHBvaW50IGFjY2Vzc2libGUKK2F0IGl0cyBsaW5rZWQgYWRkcmVz
cy4KKworVGhlIHZpcnQgbWFjaGluZQorLS0tLS0tLS0tLS0tLS0tLQorCitgYC1rZXJuZWwgZmls
ZWBgIGFsb25lIGxvYWRzIGEgSGV4YWdvbiBFTEYgaW50byBERFIsIHdoaWNoIHN0YXJ0cyBhdAor
YGAweDgwMDAwMDAwYGAsIGFuZCBzdGFydHMgYXQgaXRzIEVMRiBlbnRyeSBwb2ludC4KKworYGAt
YmlvcyBmaWxlYGAgYWxvbmUgbG9hZHMgYSByYXcgZmlybXdhcmUgaW1hZ2UgYXQgdGhlIHN0YXJ0
IG9mIEREUiBhbmQKK3N0YXJ0cyBleGVjdXRpbmcgdGhlcmUuCisKK2BgLWJpb3NgYCB3aXRoIGBg
LWtlcm5lbGBgIGJvb3RzIHRoZSBrZXJuZWwgdGhyb3VnaCBIZXhhZ29uIFZNIGhvc3QKK2Zpcm13
YXJlLCBhcyBkZXNjcmliZWQgaW4gOnJlZjpgaGV4YWdvbi12bS1ib290YC4gVGhlIGtlcm5lbCB3
aW5kb3cgc3RhcnRzCithdCBgYDB4YTAwMDAwMDBgYC4KKworT3RoZXJ3aXNlLCBndWVzdCBzb2Z0
d2FyZSByZWFkcyB0aGUgZ2VuZXJhdGVkIERUQiBhdCBgYDB4OTk4MDAwMDBgYC4KK2BgLWFwcGVu
ZGBgIHNldHMgaXRzIGBgL2Nob3Nlbi9ib290YXJnc2BgIHByb3BlcnR5LgorCitCb2FyZC1zcGVj
aWZpYyBtYWNoaW5lcworLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK0Jv
dGggYGAta2VybmVsYGAgYW5kIGBgLWJpb3NgYCBhY2NlcHQgSGV4YWdvbiBFTEYgaW1hZ2VzLiBU
aGUgY29tYmluYXRpb25zCitoYXZlIGRpZmZlcmVudCBtZWFuaW5nczoKKworLi4gbGlzdC10YWJs
ZTo6CisgICA6aGVhZGVyLXJvd3M6IDEKKworICAgKiAtIE9wdGlvbnMKKyAgICAgLSBMb2FkaW5n
IGFuZCBlbnRyeQorICAgKiAtIGBgLWtlcm5lbGBgIGFsb25lCisgICAgIC0gTG9hZCBzZWdtZW50
cyBhdCBFTEYgcGh5c2ljYWwgYWRkcmVzc2VzIGFuZCBzdGFydCBhdCB0aGUgRUxGIGVudHJ5Lgor
ICAgKiAtIGBgLWJpb3NgYCBhbG9uZQorICAgICAtIExvYWQgZmlybXdhcmUgc2VnbWVudHMgYXQg
RUxGIHBoeXNpY2FsIGFkZHJlc3NlcyBhbmQgc3RhcnQgYXQgaXRzIGVudHJ5LgorICAgKiAtIGBg
LWJpb3NgYCBhbmQgYGAta2VybmVsYGAKKyAgICAgLSBMb2FkIGZpcm13YXJlIG5vcm1hbGx5LCBy
ZWxvY2F0ZSB0aGUga2VybmVsIHNlZ21lbnRzIGludG8gdGhlIGJvYXJkJ3MKKyAgICAgICBrZXJu
ZWwgd2luZG93LCBhbmQgZW50ZXIgZmlybXdhcmUgdGhyb3VnaCBhIFFFTVUgYm9vdCBzdHViLgor
CitUaGUgY29tYmluZWQgY2FzZSBpcyBkZXNjcmliZWQgaW4gOnJlZjpgaGV4YWdvbi12bS1ib290
YCwgdXNpbmcgdGhlIGtlcm5lbAorYmFzZSBpbiA6ZG9jOmBjZHNwYC4KKworYGAtZHRiIGZpbGVg
YCByZXBsYWNlcyB0aGUgZ2VuZXJhdGVkIHRyZWUuIEEgbm9uZW1wdHkgYGAtYXBwZW5kYGAgdmFs
dWUKK3NldHMgaXRzIGBgL2Nob3Nlbi9ib290YXJnc2BgLiBBIHJlcGxhY2VtZW50IHRyZWUgbXVz
dCBkZXNjcmliZSB0aGUKK3NlbGVjdGVkIGhhcmR3YXJlLXRocmVhZCBjb3VudCwgYWN0dWFsIFJB
TSwgYW5kIG1hdGNoaW5nIGRldmljZSBkcml2ZXJzLgorCisuLiBfaGV4YWdvbi12bS1ib290Ogor
CitCb290aW5nIGEga2VybmVsIHRocm91Z2ggSGV4YWdvbiBWTSBob3N0IGZpcm13YXJlCistLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK09uIHRoZSBg
YHZpcnRgYCBhbmQgYm9hcmQtc3BlY2lmaWMgbWFjaGluZXMsIGBgLWJpb3NgYCB3aXRoIGBgLWtl
cm5lbGBgCitzdGFydHMgdGhlIGtlcm5lbCB0aHJvdWdoIEhleGFnb24gVk0gaG9zdCBmaXJtd2Fy
ZS4gUUVNVSBsb2FkcyB0aGUgZmlybXdhcmUKK0VMRiBhcyBsaW5rZWQgYW5kIGFkZHMgdGhlIG1h
Y2hpbmUncyBrZXJuZWwgYmFzZSB0byB0aGUga2VybmVsIEVMRidzCitwaHlzaWNhbCBsb2FkIGFk
ZHJlc3Nlcywgc28gdGhlIGtlcm5lbCdzIGFkZHJlc3NlcyBhcmUgcmVsYXRpdmUgdG8gdGhlCitz
dGFydCBvZiBpdHMgd2luZG93LiBUaGUga2VybmVsIG11c3QgdXNlIHRoZSBjb3JyZXNwb25kaW5n
IEhleGFnb24gVk0KK2d1ZXN0IGxheW91dC4gUUVNVSBzdGFydHMgdGhyZWFkIHplcm8gYXQgYSBi
b290IHN0dWIgYXQgYGAweDk5YzAwMDAwYGAuCitUaGUgc3R1YiBwYXNzZXMgdGhlIERUQiBhZGRy
ZXNzIHdpdGggdGhlIGxvdyB3b3JkIGluIGBgcjBgYCBhbmQgdGhlIGhpZ2gKK3dvcmQgaW4gYGBy
MWBgLCB0aGVuIGp1bXBzIHRvIHRoZSBmaXJtd2FyZSdzIEVMRiBlbnRyeSBwb2ludC4gVGhlIEhl
eGFnb24KK1ZNIGhvc3QgZGVmaW5lcyB0aGUgY2hpbGQgVk0ncyByZWdpc3RlciBhbmQgZXhlY3V0
aW9uIHN0YXRlLgorCitRRU1VIHBsYWNlcyB0aGUgRFRCIGFmdGVyIHRoZSBsb2FkZWQga2VybmVs
LiAgUUVNVSBjb3BpZXMgaXQgdG8gZ3Vlc3QgUkFNCitiZWZvcmUgZW50ZXJpbmcgdGhlIGZpcm13
YXJlLiBBbiBvcHRpb25hbCBgYC1pbml0cmRgYCBpcyBwbGFjZWQKK2FmdGVyIHRoZSBEVEIgYmFz
ZS4gIGBgLWluaXRyZGBgIHJlcXVpcmVzIGJvdGggYGAtYmlvc2BgIGFuZCBgYC1rZXJuZWxgYC4K
KworQ29uc29sZSBhbmQgc2VtaWhvc3RpbmcKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK1NE
SyBzaW11bGF0b3IgcHJvZ3JhbXMgdXNlIHNlbWlob3N0aW5nIGZvciBjb25zb2xlIEkvTy4gVGhl
IGBgdmlydGBgIGFuZAorYm9hcmQtc3BlY2lmaWMgbWFjaGluZXMgYWxzbyBwcm92aWRlIGEgUEww
MTEgVUFSVCwgd2hvc2UgaG9zdCBiYWNrZW5kIGlzCitzZWxlY3RlZCB3aXRoIGBgLXNlcmlhbGBg
LgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0
ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4IDdiN2QwYmMzMWJjLi5lMDkxYjc1YzdhMyAxMDA2
NDQKLS0tIGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVt
L3RhcmdldC1oZXhhZ29uLnJzdApAQCAtMTA3LDUgKzEwNyw2IEBAIG1hY2hpbmVzLiBUaGlzIGNh
biBiZSBmdXJ0aGVyIGNvbmZpZ3VyZWQgdGhyb3VnaCBgYC1zZW1paG9zdGluZy1jb25maWdgYC4K
ICAgIDpjYXB0aW9uOiBIZXhhZ29uIGRvY3VtZW50YXRpb24KIAogICAgaGV4YWdvbi9tYWNoaW5l
cworICAgaGV4YWdvbi9ib290CiAgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNw
Ci0tIAoyLjM0LjEKCg==

