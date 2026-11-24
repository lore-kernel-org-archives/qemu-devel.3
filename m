Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582D606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P7FRw6e7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TohZj5ew
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvna-0006li-NP; Tue, 24 Nov 2026 14:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnX-0006kP-1G
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnU-0006gy-KR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:22 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXZjV2132763
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k0CGIDlAugGIc42R/BMnm1W+vIrHRNcpRgsaTHTIPfQ=; b=P7FRw6e7dn/gZx3a
 Fom80M1on/n+hMl78kV78Fdd0droJHesD/0pFBXeJwaqhThrCnlUCv5RaYj9tFMH
 gwiV+p+1EQBt9PDNtdmKu+XbcpXzAFy5WWdcDfQUo9Xpx1kVJCbHjvGGgJS1gLnp
 FtX8PPsIRqmYspVYeKi7TvxDFPhxhiUZQk2k/otVLnZAaUe4050f+8LQ82jkphTk
 SE/MVhnlsUl+5GiJn+qgruyzOsFqCTmcLwECjFGgiM8SvteqWC8l+qoh+t/682At
 CCBlosEavjpJlRdq7cfZaphUoC//MIYt1eP5369JlpKRhibniWSO5YZTMizvr1o1
 eAmlMw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b801r30-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:19 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4cbf700ddccso3582742b6e.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546999; x=1796151799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k0CGIDlAugGIc42R/BMnm1W+vIrHRNcpRgsaTHTIPfQ=;
 b=TohZj5ewjCfvL+3uvS3DGiw2l252lRPjYeuOH4aD3iMH4X31Gj7oLll2FuSJpONcYd
 T0IGo7dcOql1lYbDVBLQwFfoKGX13fbZuCofagWvnnSmjR0DWdAG67MSQnWii/Bc6Gun
 lyDEWTpLTSJ9lWVYDca3aeCAqe1d6QenpFNKWIwva9VREqvlxPzc9o8I0wkEISbjwMrU
 d7RKVWo44M0RJe7gyi1xuUh1V/QQLtWGiXr+Y4PtUBRAPSRyqpkeowAFbP5AGe/eGsxb
 rvDLsEPdl55L/L/7slaOB3dUnyeOYMzEwQyorILZjLgJWJQWrWJquTS28NdUOjptlAyk
 COcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546999; x=1796151799;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k0CGIDlAugGIc42R/BMnm1W+vIrHRNcpRgsaTHTIPfQ=;
 b=JysFSLNpgcdkSaXA/cLvhqeY5fkcyWZM65vsVPjG+iR29kyKJbIjp0hX+Scn5Shx8g
 eZEfPSnDdBfP3K421qzXc9JsJ561EVvxADXLClViwoEsMTycQ9ZbebfoU6q7SBvwY3HN
 1cTEJOIEOOsIkI9td8tVQ53YWrWElcWnghuDLk4/uOJH/rI/bYBJ/4vkzfu9r78BzqF6
 niPNXVomsAM9PtMP8mpRi6XMmanYgK/TjGqF6NQGGPK0OmUm+RCehsRLip0vAgfAZ8ur
 BVZoV5spWxbFgWibjvaPdmIiwoLsPCn2UZX74/5uWm25td6SckEb7WRjyB6UN552ioyH
 wSUg==
X-Gm-Message-State: APuU4Z/TpXYxVR0AwPid4WxGF5C6vZWTGoTIFLHNeXdiExpoeX2//LgD
 bTOF116S9MJFhaB1iQcACAuSLY7d6JGD0QIv+QzAa15ovpmS6rm+tzpcBJjB5hO45AGUjNUZhhQ
 i+dnV5DBez6z6zvaaVdBmbyx4+HdcTlCqa1SbkbYNKjDoZ0npUtFgS2BHWyRNBUG2oQ==
X-Gm-Gg: AZFdTZcBb5hO2JzhmQGC5X7hvO6kLQNWK/A4GulHWw453yBIzygfv0f20DlIc2fKRiX
 MYYUQ2V1exBTQMlbGGfg8RwaO2wnmnIt6Ec0JtYgt0xfkbMyZrVjpsjLtzuahZlso4jkpPLJXQg
 Zr/BY+Vk0Qeihhx3CKU9BCfNOQIe482tTUIA6NUKKjZNcgRALQR++lAqMWRSfE2tDFjJ5/PnFps
 6Cy0l4IOO7cWmY500/JiEBgzXF2BhEVqqn2xWspJXQM2N+NJ3CXYcYo7PoR8kNDhBVtUY53ND33
 r4QllHCjiME+f0iCeDx+V/XnRjK6/3VUL5JTT7nsKQLRYgtoR7aSdFTIpSHbqYBfy+P7Nyk7CtX
 t+3Lb8eXpBx0IOV/67crHnEY5o3zHACxItfmXkRpEvgktaV80qpnmrNrhIMAtrsxdA3MWX5nk6Q
 G49CeRQfq5VgCmk3m658KzBw==
X-Received: by 2002:a05:6808:1524:b0:567:f627:67eb with SMTP id
 5614622812f47-57a0a719dbbmr15110174b6e.25.1795546998827; 
 Tue, 24 Nov 2026 11:03:18 -0800 (PST)
X-Received: by 2002:a05:6808:1524:b0:567:f627:67eb with SMTP id
 5614622812f47-57a0a719dbbmr15110147b6e.25.1795546998403; 
 Tue, 24 Nov 2026 11:03:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 1/7] target/hexagon: read the old predicate value
 through C4
Date: Tue, 24 Nov 2026 11:03:08 -0800
Message-Id: <20261124190314.3882017-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX4+Ppf+5cTzS7
 L4FwNhCmaSY+Gc+s+OAyQrRJAwQHxDRkuhLDYg3p5/D1J9WIsruCryivdeYSoIKhkwegfsonFm0
 D1h4n04y90AOnjfuemFE0ViGYfxmO3EcVLjazxTs0Zgi6u2MLbdAo0wypI8YRvJdl8gacnW+3JK
 eJZsedU0YglW2resQaGNnhvBu0/wsCLYjr7pnqaxpLyWFochjzF9UDsIF9POxJlwi3oqEKxqioF
 hNiox9QXlPXfjwLc3siaCMWHcgYHM7htVHhHEoo2zgmIPFE/NqDoz1+beoh+uDJGVrMQUSkWcwS
 VPPG2z/FSfUpDU96RnrAgRRwz83sOsHEyxF1tD6zcOeensVWqddT/8MQGehR6lR/DbLWFYASSFT
 rbRymf70MmajcIfcGdzoW509HW+fXtNJ0ZOEWOuPaRSPlGSjD3JPOPWPY62JiQxOuWatMPy6Nqz
 c1FF743xKzQhDnJDc9Q==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b05df77 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9fZTsBWXyneHJwdpUA4A:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: xxM3_0uyMHRMyl-suKFaKD-68BQ7tzyV
X-Proofpoint-GUID: xxM3_0uyMHRMyl-suKFaKD-68BQ7tzyV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX+wJHt5//ncDA
 XUre+xrS4q65KAsFN+7Sj0mlrCAgz+U2vg7UZqXxAyq5Ooz81EnGiRh1P5kewaOWUoRm/XNTCde
 dc8brYLxIFvdCo79+MvgJ9L/iT8iF7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClRyYWNr
IEM0IHJlYWRzIGFzIHJlYWRzIG9mIGFsbCBmb3VyIHByZWRpY2F0ZXMuIFRoaXMgcHJldmVudHMg
dGhlCnBhY2tldCBzaG9ydCBjaXJjdWl0IGZyb20gZXhwb3NpbmcgYSBwcmVkaWNhdGUgcmVzdWx0
IHRvIGFuIG9sZC12YWx1ZQpjb250cm9sIHJlZ2lzdGVyIHJlYWQuCgpTaWduZWQtb2ZmLWJ5OiBN
YXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICB8ICA2ICsrKysrLQogdGVzdHMvdGNnL2hleGFn
b24vcGFja2V0X3VzZXIuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
dGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwg
NDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rz
L3RjZy9oZXhhZ29uL3BhY2tldF91c2VyLmMKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IGJjM2I0OWFiMDZk
Li5jOTg4Yzg1ZjMzYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTI0OCw3ICsyNDgsMTEgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGN0eF9sb2dfcmVnX3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGlu
dCBybnVtLAogCiBzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19yZWdfcmVhZChEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHJudW0pCiB7Ci0gICAgaWYgKHRlc3RfYml0KHJudW0sIGN0eC0+cmVnc193
cml0dGVuKSkgeworICAgIGlmIChybnVtID09IEhFWF9SRUdfUDNfMF9BTElBU0VEKSB7CisgICAg
ICAgIGZvciAoaW50IGkgPSAwOyBpIDwgTlVNX1BSRUdTOyBpKyspIHsKKyAgICAgICAgICAgIGN0
eF9sb2dfcHJlZF9yZWFkKGN0eCwgaSk7CisgICAgICAgIH0KKyAgICB9IGVsc2UgaWYgKHRlc3Rf
Yml0KHJudW0sIGN0eC0+cmVnc193cml0dGVuKSkgewogICAgICAgICBjdHgtPnJlYWRfYWZ0ZXJf
d3JpdGUgPSB0cnVlOwogICAgIH0KIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Bh
Y2tldF91c2VyLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9wYWNrZXRfdXNlci5jCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi4yN2FjMTdkZTc0NQotLS0gL2Rldi9udWxsCisr
KyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3BhY2tldF91c2VyLmMKQEAgLTAsMCArMSwzOCBAQAorLyoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRpbnQuaD4KKworc3Rh
dGljIGludCBlcnI7CisKKyNpbmNsdWRlICJoZXhfdGVzdC5oIgorCitzdGF0aWMgdm9pZCB0ZXN0
X3ByZWRpY2F0ZV9yZWFkKHZvaWQpCit7CisgICAgdW5zaWduZWQgb2xkLCBuZXc7CisKKyAgICBh
c20gdm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMweDEyXG4iCisgICAgICAgICJwMzowID0gcjBc
biIKKyAgICAgICAgIntcbiIKKyAgICAgICAgIiAgICBwMCA9IGNtcC5lcShyMCxyMClcbiIKKyAg
ICAgICAgIiAgICAlW29sZF0gPSBwMzowXG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW25l
d10gPSBwMzowXG4iCisgICAgICAgIDogW29sZF0gIj1yIihvbGQpLCBbbmV3XSAiPXIiKG5ldykK
KyAgICAgICAgOiA6ICJyMCIsICJwMCIsICJwMSIsICJwMiIsICJwMyIKKyAgICApOworICAgIC8q
IFBhY2tldCByZWFkcyBvbGQgQzQsIHRoZW4gY29tbWl0cyBQMC4gKi8KKyAgICBjaGVjazMyKG9s
ZCwgMHgxMik7CisgICAgY2hlY2szMihuZXcsIDB4ZmYpOworfQorCitpbnQgbWFpbih2b2lkKQor
eworICAgIHRlc3RfcHJlZGljYXRlX3JlYWQoKTsKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQ
QVNTIik7CisgICAgcmV0dXJuIGVyciAhPSAwOworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hl
eGFnb24vbWVzb24uYnVpbGQgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCA3
MGY2NDc1NjU2Yy4uYjM2MzViZTNmY2IgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC05Niw2ICs5
Niw3IEBAIHRlc3RzICs9IHsKICAgJ21pc2MuYyc6IHsnY2ZsYWdzJzogW2NmbGFncywgJy1tdjcx
JywgJy1PMiddfSwKICAgJ211bHRpcGxlLXdyaXRlcy5jJzogeydjZmxhZ3MnOiBbY2ZsYWdzLCAn
LW1odngnXX0sCiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6
ICdoZXgtb3ZlcmZsb3cnfSwKKyAgJ3BhY2tldF91c2VyLmMnOiB7J2NmbGFncyc6IFtjZmxhZ3Ms
ICctTzInXX0sCiAgICdwcmVnX2FsaWFzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdkdWFs
X3N0b3Jlcy5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAogICAnZnJhbWVrZXkuYyc6IHsnY2ZsYWdz
JzogY2ZsYWdzfSwKLS0gCjIuMzQuMQoK

