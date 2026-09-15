Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1583FC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4L-00062L-Q9; Tue, 15 Sep 2026 12:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W41-0005wX-9z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3z-0003qA-GC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFATvu4176138
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fvwL/IbEMWV8t1l928t0mwgbwsnd4aQXSPTQMPU5mAo=; b=kvNmv3iidS52/Y9J
 uKELo5JhIQ09P3V+EXQRt5r4zSZeVqfiwqQMGCAtf/S4kEyuBH3Y0+5LkJee8X6l
 p2R7hPbXsSaps65gsPfkEXfNg6etk1S/Azzy1Afakw9OSYlU2JRztlzMSTB68jfc
 pUxwV/WIg7ssOD3cLgPfW7d59c2dLhEzTa57zHsVIsF7UEjnxYVP0jC6D3MDMmli
 jwvckzsl7kmQtE8QBuMzT31MATw7rG5e8L0YXnMUzRS8JmnfweAfeBnYHnEBslnL
 Wk2hAHu2n1skoYUFLhDtEnUWlp/WaeYP8cee67kWGcJsJq7G4kn/3tcwj7IgklRz
 RgO45g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc2dj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4c1fc9ceaso3821749a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489876; x=1790094676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fvwL/IbEMWV8t1l928t0mwgbwsnd4aQXSPTQMPU5mAo=;
 b=GfLcjNvyssH3bPNt84E3BUGZGaVF4FWTMrEYNzmw5GJ2PmKem90TFlRMWPS6EUwdws
 XOo2mizgVWpGofumYq6p2kpqosG+oIt/aMeHNo4A+JLF80mERnfHVULXexTMpS6pnlvv
 ElXDNTcfqKELmBYW3LixwiNL5gpUq+kqv0zOaHq+CMayBkh3dSw5sbFAps+3V5s7QTEQ
 PfFK9EIAjIJ12/ERA3ydscBLMy+V/wpSgdTrNPCF+JfIG6kW4zgTdnGFJT2bJbtmo0Px
 zCIgnhJ9Iu2tdT/pc3p4cmOj8oYoCkS9DBAKFe4DS9sT1PZXVy3uJL7zQM4ft+6CCmX2
 +BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489876; x=1790094676;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvwL/IbEMWV8t1l928t0mwgbwsnd4aQXSPTQMPU5mAo=;
 b=QCFuCrtaIp3FEfBubeY3+3gEPSAQHrGGzwQGqFjqk222wf2ikwXNjhXMDO4uptlsdD
 uKKvMtCjHMHhrLeiFO4878L9sVTzxiyhXNp7wR27vKGaD5t3dxnJvl02QYB6Ixkndp2G
 2ZAcXGpR7cRn2hOkU1iAJE1y1+wTs4u2ZNyyU9RKGJdHnTtP7Y1iJNlk3qJ/22ojCzga
 Zm7tfGhbBlGwAWqsfOC2BWIyHczxbBReVD4oMvxe2iFn1LV4EFQmZstmGnEcoKDfvx2I
 rLTgzWSBBEwTQ+IttnDN3AM2JzFOYGSRkXa4q7rCDctKIsUlgn4xRvPvnMGy3erSryw5
 5Sfg==
X-Gm-Message-State: AFuF++k68T6P0p3u8zNEA68h6NXiBc6wtO4HICupsODUmi03vnlJnGGP
 sC/aDU7ZuGZ+XMsdEbN8tNM5M3dIsBd4aPTRKzjJa7eNCtXMF9rfOKXWFLgTpcamB+2H55Sw3nU
 2F7zqVif1WCefFim9QZ03578RfvKyvP8w+og8Rhxvh7Sv2fgEQgbzpnVqUz9b08/Xhw==
X-Gm-Gg: AYBFou3yjd9nAfBHuno2snDvAvOb49AZS87KvuRnVeF5tTm2vqJKj09dwm1ZElKgU8m
 0Ot1Mqp9XYo0FUpNK+lofy9+86kG3Sqzy9rAfvc+EMn3KDS9HUGp0+ML1069u3tlifNa0B8w6sR
 pppU7qHyj8RqbKwyqHPkXd2pqsVyrbPCInigi4UpRXOhBzhc0Y1hO9wayukp7Phu7Y5rWUsRkBR
 XHhCB5198l2viv99WTY7fWFJAgCD8igYuQD+YSjy4cF9Zr73D9Vgq3Zwu685MqRhitH06P9xAnw
 NrUF+i4SxoYfojL8UR/tOVjeTPIrZAarOmTMXOlJFexmvCZBcKSnZtkb3gVAyYwSVlbkKUW8iM8
 pHzB9YQZLhhGXlQrhV/TQJSC9J+id1eXxHQvwqBlFXQIqRVuZ
X-Received: by 2002:a17:90b:3f46:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39e10fbc659mr3700721a91.16.1789489876275; 
 Tue, 15 Sep 2026 09:31:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3f46:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39e10fbc659mr3700630a91.16.1789489875734; 
 Tue, 15 Sep 2026 09:31:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 09/17] tests/tcg/hexagon: add dczeroa cache line zero test
Date: Tue, 15 Sep 2026 09:30:39 -0700
Message-Id: <20260915163047.4180600-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JQpU3nmMmKrFH6EdY6PFikQn_32yrLbf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfXxHUOr+uInSsq
 l0ZX7UU+0lYbUqMunWjim6IASzae7IaMdKweuDPN9a0A+7mS7ySvhOYWLxWf+eaLF5vsf3QPM0J
 IThV55Kin4TezEhpSG/9y+4CkPe5Q5A=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa972d5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=StvKSay-7vg8R344wSoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX8J7/gIUtq+uu
 0sABbHY6Kv3ayMo9kMvB0rljp0uDKTvFZ32dQ3O06v3Od0iNvvTzoE1OgeHSZP0i/zrmefACwPx
 GpTAhQHI1/Q8phabmLI5ymcFxYwCUn+oABq+SvOWmD/VwZFlfrUmmUl8H88rpd2n22ygvvAoUs3
 HLTJr2XTjFaAAo2INtqftLtyhY0XYxEnqAgFZjCkxjr0UYUHs6wUCKNKr+VFko2xl+cFpzVrN3+
 uxWS9e4IUfSLTNA0jhV80xbyCyDGv/Pw+ze2lhCy5N4sX7WutFJtF8UwCXdoBLE8kosvVjghD+D
 SlffGE5jo9kw6vg+rVNEvBwRQdExTU8Vv9GSO6VHUD1DGRgAiKWi68WAo2kf77BlG7cEswd8YXm
 5h4L3UcWvM++GkXcnSZB1GoiXY5dOVkdVVJcbhLpFKge6uE0QkT305/0giAcSx34MDqMQa5AuoA
 38kyDyIzOMkbvceiQHA==
X-Proofpoint-GUID: JQpU3nmMmKrFH6EdY6PFikQn_32yrLbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150240
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

VGVzdCB0aGUgZGN6ZXJvYSBpbnN0cnVjdGlvbiB3aGljaCB6ZXJvZXMgYSBjYWNoZSBsaW5lLiAg
VmVyaWZpZXMgYWxpZ25lZCwKdW5hbGlnbmVkLCBhbmQgYnVmZmVyLXN0YXJ0IGFkZHJlc3Nlcy4K
ClJldmlld2VkLWJ5OiBTaWQgTWFubmluZyA8c2lkLm1hbm5pbmdAb3NzLnF1YWxjb21tLmNvbT4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5jIHwgODggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgIHwgIDEg
KwogMiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvdGNnL2hleGFnb24vdGVzdF9kY3plcm9hLmMKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cv
aGV4YWdvbi90ZXN0X2RjemVyb2EuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi44Y2RjZGQ2YTNiNQotLS0g
L2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5jCkBAIC0wLDAg
KzEsODggQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5j
LiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyCisgKi8KKworLyoKKyAqIFRlc3QgdGhlIGRjemVyb2EgaW5zdHJ1Y3Rp
b24sIHdoaWNoIHplcm9lcyBhIDMyLWJ5dGUgY2FjaGUgbGluZS4KKyAqIFRoZSBhZGRyZXNzIGlz
IHJvdW5kZWQgZG93biB0byBhIDMyLWJ5dGUgYm91bmRhcnk6IChhZGRyICYgfjB4MWYpLgorICov
CisKKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorI2luY2x1ZGUgPHN0
cmluZy5oPgorI2luY2x1ZGUgPGhleGFnb25fcHJvdG9zLmg+CisKK2ludCBlcnI7CisKKyNpbmNs
dWRlICJoZXhfdGVzdC5oIgorCitzdGF0aWMgdWludDhfdCBidWZbMTI4XSBfX2F0dHJpYnV0ZV9f
KChhbGlnbmVkKDMyKSkpOworCisvKiBkY3plcm9hIHdpdGggYW4gYWxpZ25lZCBhZGRyZXNzICov
CitzdGF0aWMgdm9pZCB0ZXN0X2RjemVyb2FfYWxpZ25lZCh2b2lkKQoreworICAgIGludCBpOwor
CisgICAgbWVtc2V0KGJ1ZiwgMHhmZiwgc2l6ZW9mKGJ1ZikpOworCisgICAgUTZfZGN6ZXJvYV9B
KCZidWZbMzJdKTsKKworICAgIGZvciAoaSA9IDA7IGkgPCAzMjsgaSsrKSB7CisgICAgICAgIGNo
ZWNrMzIoYnVmW2ldLCAweGZmKTsKKyAgICB9CisgICAgZm9yIChpID0gMzI7IGkgPCA2NDsgaSsr
KSB7CisgICAgICAgIGNoZWNrMzIoYnVmW2ldLCAweDAwKTsKKyAgICB9CisgICAgZm9yIChpID0g
NjQ7IGkgPCA5NjsgaSsrKSB7CisgICAgICAgIGNoZWNrMzIoYnVmW2ldLCAweGZmKTsKKyAgICB9
Cit9CisKKy8qIGRjemVyb2Egd2l0aCBhbiB1bmFsaWduZWQgYWRkcmVzcyAoc2hvdWxkIHJvdW5k
IGRvd24pICovCitzdGF0aWMgdm9pZCB0ZXN0X2RjemVyb2FfdW5hbGlnbmVkKHZvaWQpCit7Cisg
ICAgaW50IGk7CisKKyAgICBtZW1zZXQoYnVmLCAweGZmLCBzaXplb2YoYnVmKSk7CisKKyAgICAv
KiBBZGRyZXNzIGJ1Zis0MCByb3VuZHMgZG93biB0byBidWYrMzIgKi8KKyAgICBRNl9kY3plcm9h
X0EoJmJ1Zls0MF0pOworCisgICAgZm9yIChpID0gMDsgaSA8IDMyOyBpKyspIHsKKyAgICAgICAg
Y2hlY2szMihidWZbaV0sIDB4ZmYpOworICAgIH0KKyAgICBmb3IgKGkgPSAzMjsgaSA8IDY0OyBp
KyspIHsKKyAgICAgICAgY2hlY2szMihidWZbaV0sIDB4MDApOworICAgIH0KKyAgICBmb3IgKGkg
PSA2NDsgaSA8IDk2OyBpKyspIHsKKyAgICAgICAgY2hlY2szMihidWZbaV0sIDB4ZmYpOworICAg
IH0KK30KKworLyogZGN6ZXJvYSBhdCB0aGUgc3RhcnQgb2YgdGhlIGJ1ZmZlciAqLworc3RhdGlj
IHZvaWQgdGVzdF9kY3plcm9hX3N0YXJ0KHZvaWQpCit7CisgICAgaW50IGk7CisKKyAgICBtZW1z
ZXQoYnVmLCAweGZmLCBzaXplb2YoYnVmKSk7CisKKyAgICBRNl9kY3plcm9hX0EoJmJ1ZlswXSk7
CisKKyAgICBmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgeworICAgICAgICBjaGVjazMyKGJ1Zltp
XSwgMHgwMCk7CisgICAgfQorICAgIGZvciAoaSA9IDMyOyBpIDwgNjQ7IGkrKykgeworICAgICAg
ICBjaGVjazMyKGJ1ZltpXSwgMHhmZik7CisgICAgfQorfQorCitpbnQgbWFpbih2b2lkKQorewor
ICAgIHRlc3RfZGN6ZXJvYV9hbGlnbmVkKCk7CisgICAgdGVzdF9kY3plcm9hX3VuYWxpZ25lZCgp
OworICAgIHRlc3RfZGN6ZXJvYV9zdGFydCgpOworCisgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAi
UEFTUyIpOworICAgIHJldHVybiBlcnIgPyAxIDogMDsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3Rj
Zy9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5k
ZXggMjA5NGVmM2Y2NWMuLmZiZWEzMTU0ZWQ3IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdv
bi9tZXNvbi5idWlsZAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNzQs
NiArNzQsNyBAQCB0ZXN0cyArPSB7CiAgICd0ZXN0X2Nsb2JiZXIuUyc6IHsnY2ZsYWdzJzogYXNt
ZmxhZ3N9LAogICAndGVzdF9jbXAuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9j
b25kX2JyYW5jaC5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAorICAndGVzdF9kY3plcm9hLmMnOiB7
J2NmbGFncyc6IGNmbGFnc30sCiAgICd0ZXN0X2RvdG5ldy5TJzogeydjZmxhZ3MnOiBhc21mbGFn
c30sCiAgICd0ZXN0X2V4dC5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCiAgICd0ZXN0X2ZpYm9u
YWNjaS5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCi0tIAoyLjM0LjEKCg==

