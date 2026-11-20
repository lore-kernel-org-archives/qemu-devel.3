Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EF606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXvOLKLr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LozZIP1x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTE6-000601-Sp; Fri, 20 Nov 2026 13:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE3-0005yz-FP
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE1-0000hV-Qe
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:43 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKHPhd52043779
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juZrxqHUpIm/ImEGWCh1BIS8AF0/lU1ZIhsBhD0LY/U=; b=cXvOLKLrMtBJhaHq
 slYbKF1damntFQx/JHPU/moGI+zzWGnMdFXjb7DakvRuF8TcfCNFcuHgt7sazyxB
 +hIP/Nb54G9uAA8QHEhcuKLdAgo4BVmhixvDGA/Zygp4oGkbE74IdzpMBtTIZXe0
 vclp8wHQYiLCBiwxRYJIZ76tT4VehZObdMw1oeV9g2PuyPs6hMVYm7G4ahzI9QAC
 qRG7DvZudZOfRZkjEBXkFjtb5IHykx7P9kdLforomYS9eOmV6TsD9zMfaq1irFrK
 Sy+9R8L9DZmvK9u34Q2PzdKpbBMxx3+EMUmISownmUO4opEIXQqo5RwK7ulkA27f
 VWZVlA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2tkn89xc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:40 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-8255327a28fso1352052a34.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198840; x=1795803640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juZrxqHUpIm/ImEGWCh1BIS8AF0/lU1ZIhsBhD0LY/U=;
 b=LozZIP1xQd8h+YdQKeL/bjdag+Zh42hR4wOYH43IeFETkFrsQYbMQcZpQKmGIIBGC2
 SeLXeFonuR/CVbIn8nc+a14CHHx/OTowvbWKYpue3Z55NZlzN7VgYbyuedWCrGxL8R8s
 OSEEcEBP7cf0xy9+AniE/OqFNfdYMl0ohhBXTzva8xwVNbT8kyLb1q1RsmCPG4Bay5Gp
 py9ua4RE1eV23asb2ddkYnwGsYiIhWFKjzDaonOVLqCJzhYWD5RqQQDee1hcqxZQSFIw
 cysV47GMs+bws5vpnUs8ibKg9b66lCWK6dNx0DmNxsPXF5VvvpviAl3EZAo6BU19ROWB
 M5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198840; x=1795803640;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juZrxqHUpIm/ImEGWCh1BIS8AF0/lU1ZIhsBhD0LY/U=;
 b=h1YlbRkRLUor6qnD1QRLapVKk+NVfdS0S3yB6Bo67vmccVFbXEDVJG7kw1IJPyAAWa
 je0fhbKDs2iAVD0CydLGy1xvQ/wS6gxjJ9+qzINoNVmYVXnSM6pFZaHfDv7DQoIyp802
 Gj+kxYh1vTfvJgH4ONB75WAyJbG5+b8Z7Eh6JbUpgxsaJm8u9C/EHOulEpFNfywn+mAP
 keHhZ+DHzbGwGoo39cpgruNc1mmJo0qfRPauGpaym6fWhqf3OEE6I3aTU9IQRWUmJ7E+
 EI9QBoBZfOl/+XMnh7yB/pVBRsxnbCkANEwpYTuJ2ADMQ0+j+qkpRMwD9nX62Wap8LFj
 fPIQ==
X-Gm-Message-State: APuU4Z8IUPtey3FlutRuaXYOu3wYlcDy8XXOzMPYrD6gFzLCD6VZtu7V
 Th1qbdcva+oPm4UCoa5dyRRWQEHZYsBvdnPfQrrIstGsNwaZo2LWkSKxwr9sMCeaL/y0PGHf8N0
 Cgn1/87Yp0WIj708470Omg8kyE+s32dt5/ClODgZclnlEdXBN5jwQHCaC/Xq7CWjQ/A==
X-Gm-Gg: AYBFou2SGIEvNLWg+1NxM1mxYlJJ9geF4oHyXlttpHYrj6BTPabRLYSByEvqA3fZhN1
 Z9JhuT6znq/6V1SAk5P2Bpj6Mu/h16P6HKWVo1dCFml+YDVppLJIZn5m+1TX08/phbzefDQdNLq
 U3mD/SKRXLlmy7VEHSBInTkfjFp5UWhvRmJ0tt03xE3r1dI2jyFrSOt+f/knwnWwX8YuPD3E5Sw
 nwgDUcUy3vhMH6iJ/rYEfy0cf/i1kmdqx+2hBo/j957dYWAa98hqJgvhNRiqNTqIzzigKSaLfKO
 B/TnGSuVgbMDxs8Q634X8uRxkbaJTRQteAAANwFzTA07Q+4Yeqx2HlnMUgfehKVSMd+qSxphKWE
 ZDlV7CpCidFqTQOrP7l/QtKXbtcQws3WUuYoWI12v8lo+I8t4V734LSNNXAVoGv2DpBX1AicjbC
 uFvOFVL/OoIOpkU1VMwLuSIA==
X-Received: by 2002:a05:6830:3143:b0:862:c34b:482c with SMTP id
 46e09a7af769-863159d88dbmr6119097a34.23.1795198840192; 
 Fri, 20 Nov 2026 10:20:40 -0800 (PST)
X-Received: by 2002:a05:6830:3143:b0:862:c34b:482c with SMTP id
 46e09a7af769-863159d88dbmr6119056a34.23.1795198839680; 
 Fri, 20 Nov 2026 10:20:39 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:39 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 04/12] target/hexagon: deliver floating point
 exceptions after the packet
Date: Fri, 20 Nov 2026 10:20:23 -0800
Message-Id: <20261120182031.560481-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: f6JICkrM1SloJ8Bwn7ApP8FwFqAhwdPL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX9gA2pNLbIOz0
 vW3Zbf0pilUqxmXPSdYoYhBJ00qF3v/fDTkE60TU3w7Z4dOS2Js/jMUc/h9DRKecrwrPqFOJuo+
 hpvQeUimcZtT4zsPtE6lUut1n/bjLjY+lzN5yelCJrKelyH14+hE9TX2p8DHdazspQJf/3z8riJ
 wtu7YJCMfOKP8Cc95wPnD+rnX26wap7avfsoj7f7t8E/wCuNgI39UhJ7Z3hBDanCKBNoBkSOrvF
 TMVXkAj27C/uwCXzzVjFIZupeqaMFX1fBrD3OlaWT7ihQzlY1e61ZcyI4qACQV+43O1LExgiOKV
 NX5EOxujMIOWphh/P/AC6isaK7nwvfvFUuTLoN9h+0NfYDnr+VjsE1JfYrC2bjOcs+uaH6XrGif
 i7XMQrw6kq5K2K5e/5q2l087fsie3+bJCBQlhcwV99+I6tUswRaQXqo0mzDZt0POlnJlNIBlfjJ
 24+wYSDkhBzLSQlkseQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MiBTYWx0ZWRfX1Y7zjJmNiqCl
 xy3QphjQBbeqlZdUqsy0UUQG5uMzZEJ2B+ZG6WXzRO+aEz2YXT1T9UI+REWXThtGHmMln0MaWMP
 H5jrv3hnlCYIXabIhEU/SMPMedi9WwM=
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6b008f78 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=WGR0rWkjfx4cIdXbClMA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: f6JICkrM1SloJ8Bwn7ApP8FwFqAhwdPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200072
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

QW4gdW5tYXNrZWQgZmxvYXRpbmcgcG9pbnQgZXhjZXB0aW9uIHVzZWQgdG8gdGFrZSB0aGUgZXhj
ZXB0aW9uIGluIHRoZQptaWRkbGUgb2YgdGhlIHBhY2tldCwgd2l0aCB3aGF0ZXZlciBQQyB3YXMg
bGFzdCB3cml0dGVuLiAgVGhlCmFyY2hpdGVjdHVyZSB0YWtlcyBpdCBhZnRlciB0aGUgcGFja2V0
IGNvbW1pdHMsIGxpa2UgdHJhcDAsIHNvIHBlbmQgaXQKdGhlIHdheSB0aGUgVExCIHBlbmRzIGFu
IGltcHJlY2lzZSBleGNlcHRpb24gYW5kIHJhaXNlIGl0IGF0IHRoZSBlbmQgb2YKdGhlIHBhY2tl
dC4gIFJlcG9ydCBFTFIgYXMgdGhlIGxhc3Qgd29yZCBvZiB0aGUgcGFja2V0IHNvIHRoYXQgYSBo
YW5kbGVyCnJlc3VtZXMgYXQgdGhlIG5leHQgcGFja2V0IGJ5IGFkdmFuY2luZyBFTFIgYnkgb25l
IHdvcmQuCgpUaGlzIGVuYWJsZXMgdGhlIGZsb2F0X2V4Y3Agc3lzdGVzdC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9hcmNoLmMgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrLS0tLQogdGFyZ2V0
L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8IDEwICsrKysrKysrLS0KIHRlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IHwgIDUgKysrKysKIDQgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXggNWVlODdiMzIwYjYu
LmRkYmNiYTljZGQwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMTQsMTMgKzIxNCwxNCBAQCB2b2lkIGFyY2hfZnBvcF9z
dGFydChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAqLwogI2RlZmluZSBSQUlTRV9GUF9FWENFUFRJ
T04gICBkbyB7fSB3aGlsZSAoMCkKICNlbHNlCisvKgorICogRmxvYXRpbmcgcG9pbnQgZXhjZXB0
aW9ucyBhcmUgdGFrZW4gYWZ0ZXIgdGhlIHBhY2tldCB0aGF0IGNhdXNlZCB0aGVtCisgKiBjb21t
aXRzLCBzbyBwZW5kIHRoaXMgb25lIGZvciBjaGVja19pbXByZWNpc2VfZXhjZXB0aW9uKCkuCisg
Ki8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OIFwKICAgICBkbyB7IFwKLSAgICAgICAgQ1BV
U3RhdGUgKmNzID0gZW52X2NwdShlbnYpOyBcCi0gICAgICAgIGNzLT5leGNlcHRpb25faW5kZXgg
PSBIRVhfRVZFTlRfRlBUUkFQOyBcCisgICAgICAgIGVudi0+aW1wcmVjaXNlX2V4Y2VwdGlvbiA9
IEhFWF9FVkVOVF9GUFRSQVA7IFwKICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNF
X0ZQVFJBUF9DQVVTRV9CQURGTE9BVDsgXAotICAgICAgICBkb19yYWlzZV9leGNlcHRpb24oZW52
LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYt
PmdwcltIRVhfUkVHX1BDXSwgMCk7IFwKICAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
aW5kZXggYWNjNjhhYTZjMjMuLjk2ZDRhNzgzZWQ0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtOTcyLDYgKzk3Miw3
IEBAIHZvaWQgaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykKICAgICAgICAg
YnJlYWs7CiAKICAgICBjYXNlIEhFWF9FVkVOVF9GUFRSQVA6CisgICAgICAgIGVudi0+aW1wcmVj
aXNlX2V4Y2VwdGlvbiA9IDA7CiAgICAgICAgIGlmIChldmVudF90b19ndWVzdChlbnYsIENDUl9H
RUUpKSB7CiAgICAgICAgICAgICBndWVzdF9ldmVudF9lbnRyeShlbnYsIGVudi0+Y2F1c2VfY29k
ZSwgZW52LT5ncHJbSEVYX1JFR19QQ10sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
RVhfR0VWQl9IV19GUFRSQVAsIGZhbHNlKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggNDFhMGYyYjA4NTIu
LmVlZjM5MmIxZTljIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMTM0NSwxMSArMTM0NSwxNyBAQCBzdGF0
aWMgdm9pZCB1cGRhdGVfZXhlY19jb3VudGVycyhEaXNhc0NvbnRleHQgKmN0eCkKICNpZm5kZWYg
Q09ORklHX1VTRVJfT05MWQogLyoKICAqIEEgdGxicCBpbnN0cnVjdGlvbiBtYXkgZGV0ZWN0IG11
bHRpcGxlIFRMQiBtYXRjaGVzIGFuZCBzZXQgYSBwZW5kaW5nCi0gKiBpbXByZWNpc2UgZXhjZXB0
aW9uLiAgUmFpc2UgaXQgYWZ0ZXIgdGhlIHBhY2tldCB0aGF0IHJhbiB0aGUgdGxicC4KKyAqIGlt
cHJlY2lzZSBleGNlcHRpb24sIGFuZCBhIGZsb2F0aW5nIHBvaW50IGluc3RydWN0aW9uIG1heSBz
ZXQgYSBwZW5kaW5nCisgKiBmbG9hdGluZyBwb2ludCBleGNlcHRpb24uICBSYWlzZSB0aGVtIGFm
dGVyIHRoZSBwYWNrZXQgdGhhdCBjYXVzZWQgdGhlbS4KKyAqCisgKiBBIGZsb2F0aW5nIHBvaW50
IGV4Y2VwdGlvbiBlc3RhYmxpc2hlcyB0aGUgZXhjZXB0aW9uIHBvaW50IGFmdGVyIHRoZQorICog
cGFja2V0LCBsaWtlIHRyYXAwLiAgRUxSIGlzIHRoZSBsYXN0IHdvcmQgb2YgdGhlIHBhY2tldCwg
c28gYSBoYW5kbGVyCisgKiByZXN1bWVzIGF0IHRoZSBuZXh0IHBhY2tldCBieSBhZHZhbmNpbmcg
RUxSIGJ5IG9uZSB3b3JkLgogICovCiBzdGF0aWMgdm9pZCBjaGVja19pbXByZWNpc2VfZXhjZXB0
aW9uKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwo
Y3R4LT5wa3QucGMpOworICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwoY2hlY2tfZm9yX2F0
dHJpYigmY3R4LT5wa3QsIEFfRlBPUCkgPworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3R4LT5uZXh0X1BDIC0gNCA6IGN0eC0+cGt0LnBjKTsKICAgICBUQ0dMYWJlbCAqbGFiZWwgPSBn
ZW5fbmV3X2xhYmVsKCk7CiAKICAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfRVEsIGhl
eF9pbXByZWNpc2VfZXhjZXB0aW9uLCAwLCBsYWJlbCk7CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDc2ZTI0ODBjMWQzLi42MDY1NjcyMzBiOSAxMDA3NTUK
LS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTgyLDYgKzgyLDExIEBA
IGRlZiB0ZXN0X2Z0cnVuYyhzZWxmKToKICAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChvcy5wYXRo
LmdldHNpemUoZnRydW5jX3BhdGgpLCAxLAogICAgICAgICAgICAgICAgICAgICAgICAgICJfdGVz
dGZpbGVfZnRydW5jIHNob3VsZCBiZSAxIGJ5dGUgYWZ0ZXIgZnRydW5jIikKIAorICAgIGRlZiB0
ZXN0X2Zsb2F0X2V4Y3Aoc2VsZik6CisgICAgICAgICIiIlVubWFza2VkIGZsb2F0aW5nIHBvaW50
IGV4Y2VwdGlvbnMgYXJlIHRha2VuIGFmdGVyIHRoZSBwYWNrZXQKKyAgICAgICAgdGhhdCBjYXVz
ZWQgdGhlbSBjb21taXRzLiIiIgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImZsb2F0X2V4
Y3AiKQorCiAgICAgZGVmIHRlc3RfYWNjZXNzKHNlbGYpOgogICAgICAgICAiIiJhY2Nlc3MgY2hl
Y2tzIFJfT0t8V19PSyBvbiBfdGVzdGZpbGVfYWNjZXNzLiIiIgogICAgICAgICB0ZXN0ZmlsZSA9
IHNlbGYuc2NyYXRjaF9maWxlKCJfdGVzdGZpbGVfYWNjZXNzIikKLS0gCjIuMzQuMQoK

