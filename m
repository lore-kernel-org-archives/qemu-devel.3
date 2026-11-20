Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6B606B21D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KrsA75b8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chM7Y/lg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTEE-00062C-AF; Fri, 20 Nov 2026 13:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE8-00060m-6S
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE6-0000p3-Do
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:47 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKHPkKU2043957
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E03kImDsatFVsrjOWu+28rzbswdOKqZw85wwqwk5HY0=; b=KrsA75b8rFbv8mBm
 A2tohnJM1YjxsLpjfItXYPyqwvS3rpNalY388iCpA7ElbI8m+aMacy1PmhHKd4UJ
 5xHAWsBEyhcRGBZqXzhrRg0VXGVcvlC1+PSQRrkUIxhcL8MPfiBLJXhnxBjYacWf
 CiIP0k0R3UiQfCfDoXuzRJjl78+mHde34qalRveJc1SrRm+y0wRh9oucSiLhD4sx
 WwbFYguTICXQlycN6TZ3fI6tpCt36z+ajNfcvn0BFLZekNMn21uhTr211Bc6b7XZ
 aywypgIJ6wUlBJ+cuNrB529vjDgl1Ytjd6YvGYoMPJmFrm5Ev4ag0GcsNSXsialj
 7PivAg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2tkn89xu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:45 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-86287b38a31so1439428a34.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198845; x=1795803645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E03kImDsatFVsrjOWu+28rzbswdOKqZw85wwqwk5HY0=;
 b=chM7Y/lgAmwnSVqS4+YRXUYimimq9hR45taM7QRquCK/8cJozVUvjaeF/ELL47iPLN
 SihZZZdp7r3u/9TZKRkECmwETzBSM9xpfNmy9g1Q/30FpCEp+fb+tA2djDpQxhBM9Cvs
 AZzCLgNLClq5AOeiDl8YHo65UdISQB7FmOGknKH59VBS5QzxxvzyLgKCYtICsbZeSB3k
 jQFgqgu/z4LbtJjYoje1AiULwVkZHLYPtFzw9RUEp8n8iwkWCYnNVknlrwaUtljP8jHq
 FUk6P+534cHB6ysGYcbV0vY/eS7mJrs7LFXvwN87eZaCYxZGtS6WGiSTgh5hIs+3h8SV
 tuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198845; x=1795803645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E03kImDsatFVsrjOWu+28rzbswdOKqZw85wwqwk5HY0=;
 b=CDNWyfHIJU0Ddjkh7Df7SrIfk4g5ohymI5+kyBlCmh7Y2fXA/ANku8TvAtPrhMl1L0
 Q05hDmupONpGEutKrUt9m53h9dXtsXDjvHr8jQJWnRL42GEJUbzi2l5ix7tG/LXOJYKx
 y/5RPnmZoN/Lmyi/5IZu8JyFSouNQyHWc5QaIIrJxFAVI6PZZeUwM34MUhfgFnbbCgod
 4yad1PmCb8bSUAvSUzYA1fvStxfMRVbSJuVcgpLeRGjHPoQTGeV0joeKiyle6YKr2wdV
 sbD2V6r8/+F/DVI1Hld8+TL/3wyyGlo/ghj2zABSNSMpOfMhBNEUUr1OWlWSkKxlqV4O
 WejA==
X-Gm-Message-State: APuU4Z/ph65RSylmztb7wGLjJZDaMPsqvpou1Atv90k70zQ60dY8u0SH
 gOWBMZ/2ugDwqGMHmC4QOqJMUpVpUYTr0TmbwKOeaPdGDpqzFQd91smJrTUX8vQlL/hG5X4skne
 uLOuPAFnRVNUiBKxdreyMXC1X+j+IC51Y1mPab/EYT2oiizPCTctv9FLEyCjJey7ruQ==
X-Gm-Gg: AYBFou2M7Mt4hLpj66kyWWxpNz9IWF66Xy8TuNORNZhwS8OBItzei3ZqxQt9GMM4WJH
 mc3UZzGFOPm3n6tMiIQ+qVG32euC8LSIUZMSfZ6/MT0N8mI0NQEPCKWibqwUiLp+c1BrmVvhJxm
 EGw0+cdFzmgCUGxmZXmrn23EpsJFtW2D9oyYEnp7u8QjNDLPLsXUINo9wJFBCKAdKFtHVd+JFI3
 0neKejf3HjH1i7Go/KRUpAhzf14LCb2DM43AygBU9XNDLNn6GXE+9/WmeX0uv2sIQNdwAWcmbvb
 9HcA8WnAKmuC4J7bVmUSlJahPhhbEDYfcrkTyVya7iXfoaQCgTNwXXQjkbFLCRhevs52BJP80+b
 ex9kuy4352sVU8+kRgHrTYeYMxU54HxjyVVrg08rylb1cNTcIVLkJsxzEpV5UWlngw4ArWM/VOo
 ZvI2hqjpNdXNXuaTZSUriEIg==
X-Received: by 2002:a05:6830:4103:b0:862:7ba1:9b35 with SMTP id
 46e09a7af769-8631597709bmr5214098a34.11.1795198844559; 
 Fri, 20 Nov 2026 10:20:44 -0800 (PST)
X-Received: by 2002:a05:6830:4103:b0:862:7ba1:9b35 with SMTP id
 46e09a7af769-8631597709bmr5214061a34.11.1795198844075; 
 Fri, 20 Nov 2026 10:20:44 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:43 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 07/12] target/hexagon: raise decode failures at
 the faulting packet
Date: Fri, 20 Nov 2026 10:20:26 -0800
Message-Id: <20261120182031.560481-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: RJfcJtZ4blFmInEPqnkXRW1wWXrRkkCS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX5H8/aC9yvu6B
 aUSwqRmRuXCXLKA9F5n9d7oN7r4baEri4cVkVrTigxiXxuCOfBAAX/Mmi4cOHyx+QzARrfv6WEl
 Zp1EgUkHeEH2NK7MNJ1tjaxF9KJ7WhPm2xRgIdjjBlw8IOhVDwBiXPvqBKyxlg0ycIl9f56hN0M
 elHkZrPEF2A67JAdYBX8bViahX6rOBIks1PgZ5ahkon2IYCYS6hUPxvVePh2ujd/yEmR2+uiUsa
 G4kAiyQ1KMy5K/gQz9M+Vy1ECMbpsrC9vSHMncnjNlPxat1ZcYbNDjJipLuOvbV5SYTqX8OTMij
 sHa9UFeAKzRSUzvaIAdnXmPIrFKeNxvpSbj8fmfB0l9w2GC31BnOCUFvEAfB4h1dGgw0x0Gi2zh
 T6d13N4UcC79eBS9KFyPcaOCzxIIlhT7MFfxVQQ1w8lYiNGNgHrNBA8CRf5dV/YczA8X9x4GZ7Q
 GTJcqJ1MvnpBMqDjxuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX7YjhN27Z8idE
 lf/r2B/8VOtRobM3oizp0Mv4ROp5PxztDWP+xvKBoMN338woQnnNO6F7L7LRO/n8XbUTxTpfMzF
 PE6o0wga2DzBAZCA6HHtO2fpuFQFXDU=
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6b008f7d cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BJZ_eTHKON5vc81CckUA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: RJfcJtZ4blFmInEPqnkXRW1wWXrRkkCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200073
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

QSBndWVzdCBoYW5kbGVyIGZvciBhbiBpbnZhbGlkIHBhY2tldCBvciBvcGNvZGUgc2tpcHMgdGhl
IHBhY2tldCBieQphZHZhbmNpbmcgRUxSIHBhc3QgaXQuICBnZW5fZXhjZXB0aW9uX2RlY29kZV9m
YWlsKCkgcmFpc2VkIHRoZSBleGNlcHRpb24KYXQgdGhlIGFkZHJlc3MgYWZ0ZXIgdGhlIHBhY2tl
dCB3b3Jkcywgc28gdGhlIGhhbmRsZXIgc3RlcHBlZCBvdmVyIHRoZQpwYWNrZXQgdGhhdCBmb2xs
b3dlZCBhcyB3ZWxsLiAgSW4gc3lzdGVtIG1vZGUgcmVwb3J0IHRoZSBhZGRyZXNzIG9mIHRoZQpm
YXVsdGluZyBwYWNrZXQuICBsaW51eC11c2VyIGtlZXBzIHJlcG9ydGluZyB0aGUgYWRkcmVzcyBh
ZnRlciB0aGUgd29yZHMsCndoaWNoIGlzIHdoZXJlIHRoZSBpbnZhbGlkIGVuY29kaW5nIHRlc3Rz
IHJlc3VtZS4KClRoaXMgZW5hYmxlcyB0aGUgbGxzY19vbl9leGNwIHN5c3Rlc3QuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKy0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICA1ICsrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYwppbmRleCBlZWYzOTJiMWU5Yy4uMTI2ZDdiMjlhOWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0y
NzEsMTMgKzI3MSwyMiBAQCB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IGNhdXNlKQogICovCiBzdGF0aWMgdm9pZCBnZW5fZXhjZXB0aW9uX2RlY29k
ZV9mYWlsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbndvcmRzLCBpbnQgY2F1c2UpCiB7Ci0gICAg
dGFyZ2V0X3Vsb25nIGZhaWxfcGMgPSBjdHgtPmJhc2UucGNfbmV4dCArIG53b3JkcyAqIHNpemVv
Zih1aW50MzJfdCk7CisgICAgdGFyZ2V0X3Vsb25nIG5leHRfcGMgPSBjdHgtPmJhc2UucGNfbmV4
dCArIG53b3JkcyAqIHNpemVvZih1aW50MzJfdCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQor
ICAgIHRhcmdldF91bG9uZyBmYWlsX3BjID0gbmV4dF9wYzsKKyNlbHNlCisgICAgLyoKKyAgICAg
KiBBIGd1ZXN0IGhhbmRsZXIgc2tpcHMgdGhlIHBhY2tldCBieSBhZHZhbmNpbmcgRUxSLCBzbyBp
dCBtdXN0IGJlIHRoZQorICAgICAqIGFkZHJlc3Mgb2YgdGhlIGZhdWx0aW5nIHBhY2tldCBhbmQg
bm90IHRoZSBvbmUgYWZ0ZXIgaXQuCisgICAgICovCisgICAgdGFyZ2V0X3Vsb25nIGZhaWxfcGMg
PSBjdHgtPmJhc2UucGNfbmV4dDsKKyNlbmRpZgogCiAgICAgZ2VuX2V4ZWNfY291bnRlcnMoY3R4
KTsKICAgICB0Y2dfZ2VuX21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgZmFpbF9wYyk7CiAg
ICAgZ2VuX3ByZWNpc2VfZXhjZXB0aW9uKGNhdXNlLCBmYWlsX3BjKTsKICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47Ci0gICAgY3R4LT5iYXNlLnBjX25leHQgPSBmYWlsX3Bj
OworICAgIGN0eC0+YmFzZS5wY19uZXh0ID0gbmV4dF9wYzsKIH0KIAogc3RhdGljIGludCByZWFk
X3BhY2tldF93b3JkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgsCmRp
ZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDVkYzA1MjU2YWFl
Li5hYzIwNzE3OTVmYiAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMu
cHkKQEAgLTk2LDYgKzk2LDExIEBAIGRlZiB0ZXN0X21tdV9jYWNoZW9wcyhzZWxmKToKICAgICAg
ICAgIiIiQ2FjaGUgb3BlcmF0aW9ucyByYWlzZSBUTEIgbWlzcyBhbmQgcHJpdmlsZWdlIGV4Y2Vw
dGlvbnMuIiIiCiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygibW11X2NhY2hlb3BzIikKIAor
ICAgIGRlZiB0ZXN0X2xsc2Nfb25fZXhjcChzZWxmKToKKyAgICAgICAgIiIiQW4gZXhjZXB0aW9u
IGJldHdlZW4gYSBsb2FkLWxvY2tlZCBhbmQgdGhlIHN0b3JlLWNvbmRpdGlvbmFsCisgICAgICAg
IGNsZWFycyB0aGUgcmVzZXJ2YXRpb24uIiIiCisgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygi
bGxzY19vbl9leGNwIikKKwogICAgIGRlZiB0ZXN0X2FjY2VzcyhzZWxmKToKICAgICAgICAgIiIi
YWNjZXNzIGNoZWNrcyBSX09LfFdfT0sgb24gX3Rlc3RmaWxlX2FjY2Vzcy4iIiIKICAgICAgICAg
dGVzdGZpbGUgPSBzZWxmLnNjcmF0Y2hfZmlsZSgiX3Rlc3RmaWxlX2FjY2VzcyIpCi0tIAoyLjM0
LjEKCg==

