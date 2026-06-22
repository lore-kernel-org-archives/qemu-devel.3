Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CB0CDB477
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9d-0003e2-AK; Mon, 22 Jun 2026 18:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9Y-0003bd-VG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9X-0006aX-6T
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJanKG2177025
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=; b=PItKmDR6u17ZGAOh
 Mg7zcSded5EfaVF9EKa8LtEpa/57/RIoSS1X0N7tu2SFDXIMNWhH0G3FlYdKjVZG
 3P0FNdQS8yRCV3aFOlpdAURfDCy82hi8LSuHA8akiF+bimXFlO9BU3vN7HA8PHJP
 gj3y8Klnnlnu0CN8D4uZdwYKm+qZkHv+YWhlpNhWP5SPM9TWTqrqYpDwwsothGUq
 oaRVoOz3E0DesLSz9l3Le9tkmbosOACfreiJM4PKmtlNJ6b04FrB+C7cFdVXNB1e
 i0bgewx3X4bG4biUPxx/QfShe6mmKJUx2OlhSoVoA36NlsKtGf/EQPax23zlpYf5
 GcnCdQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hahdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-138acbc0e69so18058968c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167391; x=1782772191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=azs43i9ceOhFfbtuRZdUjn4S2Qw8tnzemL6utqqQLWoVs0NYjcTXF5kGV+6rVkTzEJ
 Z6yjqkJueVz2eSXMxlhOIbLTS6l3BES+0/siptAduM9fXtlsbihTn/z8nXmN+CekpeAf
 dR8KQZ1fiT4SFD7UJxM9YHMoGCgXUmtEEUUAXEQ46ps/oJSxlwDjaQvpwc/Igiyuw2lk
 Ml3p/p9XiSueY+LTY3YBLjtKG6xc+L4u0hiEMqFfukYUN8cuFUx1BWOPrkOBXLQmC6SB
 2UJUa/f+KFgoO+H19H+8h/IgzL4TftuGRRLzGP4hQGidkMqQmvmovuiKyK1OqfcWRf/V
 kwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167391; x=1782772191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jO0e8rIhKLjhW5IYHunqKRgXza1ukawimSTttXDmgI=;
 b=kCjGRmwEJ4I08+QiltL6rMmsaB/5wBB2FML/ar+yW3x9ZY3Ht9rO35ulENVa+LNjF0
 xSWllR+GG799hU8FlP7cyO0+3zsFEkiEbrqMrOiS6udDb4ncciFfl7DB4lYRRUpGkSVH
 g47lYdzmp25NW4b7jPsZkpQLAFr6kT3pt/X3KgOBYV8nYs9xuK4qNY4JNHzRKH5uwb91
 Ua7YPUY3469rr2gm3uI8JIyce1O0BGngDO+mguc44LS6Zeui7m23VUlNjEM/w99uBSyU
 ep1nv2zNMmGjsYKWzSMYlYBpO65vhTMjO0LQ6HX68vrj68zaKlhQC0KGq+HEzkcqZFu+
 55Og==
X-Gm-Message-State: AOJu0Yzmdcjlhuwn+mueGAsA3Vv3ePV6VSE5I8+tWQLuQaMSb7RyzCua
 mmgbsIKVAwVguBcsY9LN8TT1un+/7EJYTeuqMnEd3nGBxTzpA4lBndrGEtOONJMRfX5j5iNDjhB
 BL+dlQa9PW2IVMo40ZnfyzXnuHjX9JoKHwEGnXsNsKVv1frJqM4A5wrqzJ2cuQvHTgQ==
X-Gm-Gg: AfdE7ckS2mf58MwWcuOZSUe5TzR1jJCemmUrXjqVih+l4MmNpaNR3oOBgcWNpP8sIBG
 eOWjvMwlkJXPUAakIvXEZnS08o/QOWaXWSzGAVk0ds9DEZTIouAmqzwxLbUlYMdtablfPpEf0ps
 9wgxMw25Aoy36Jaia0Al7UA4UTIpvTqvtQRyki45qht6NKfnEwYi7WrpWRGmUFEk7QxbzE2xx4w
 u3ppKTwxnKdkqjJ802lT+TRlQ9jh81tfJp+mxrhszHsiHnh5QSgW1i93qr9TO/Toyb8J0HvJh/I
 YLJ2EteaRdCvKXzWHxLE1caqN91xqGkqVSfiglyDVX1PcryIpZjjsOxRrIqJEeFfMwap4S1qVBo
 XB7sOe0ief5fjvV4cuRl4GI+YmPgm3t6uHmRxYeu0vvG1qWUfihGQ+ilD2hc=
X-Received: by 2002:a05:7022:4397:b0:138:5ae:3eaa with SMTP id
 a92af1059eb24-139ad6961c2mr9322100c88.9.1782167391272; 
 Mon, 22 Jun 2026 15:29:51 -0700 (PDT)
X-Received: by 2002:a05:7022:4397:b0:138:5ae:3eaa with SMTP id
 a92af1059eb24-139ad6961c2mr9322084c88.9.1782167390766; 
 Mon, 22 Jun 2026 15:29:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 28/75] target/hexagon: Add TCG overrides for rte, nmi
Date: Mon, 22 Jun 2026 15:28:17 -0700
Message-Id: <20260622222904.607771-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: AMvZrtxlOH8TD9Tn45rjy9o4QNRt7I2U
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39b760 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QG2uPxDT_WX1JUO730YA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX0fROjQVDBm/W
 F0zA99xBPAE+reFIv4KadvyNKAZ0WR1jO/P/ucq9jQ/R20rgP7WQnjUVlr/xu0ONG/BbNHs0b3q
 HinREf0HcL+uXNhc/cMksPbFAFX434s=
X-Proofpoint-GUID: AMvZrtxlOH8TD9Tn45rjy9o4QNRt7I2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX00mg9wuuiHho
 jNpMmdlMw++yGySw5Ixkyi3UHDo605eWgQrFwG3zCCL/KptN56ChgUazyIa04WA2xFv+uzANTz3
 xXwfufjDvQ5QxZcoQhOCYEuIgxW71oh3g/26i9+RtxSm0zFwF5ykNeRh6wdBxroHVhidqXJkzlN
 3JnFP0xXRA13fCAh5vc6KIRVy4mzOE71BxOkrKBflkvrA7L/YYbmDQ/2ksv8OLAcKTGlkTICk4J
 0cIS+ujInVFkhewkZZ3k5XpfoUXRJwN6iKk1bYY/hNdKXhYcmUcBfVhs55N4xEJnypJzsrzlSdT
 kWocqlDlNYSLfx2jtCTD8LkeveJ+wLhzC+W42qbBvMW9Xom9IUKIxXQUMhx3FPE6W9TdS4clehj
 sCgDC/f3mfUjyg4TmDIalNRL316b6aTv7tATde4bW3rjhfaYAG2wp34eyV4S0yi9G4XPPmk88oA
 UtZuhqZh2LiVd5Q+8lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxNiArKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIu
aCAgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggIHwgIDMgKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgIDYgKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5
cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA4NjUwZjY0YTZkNC4uMjY0
ZWEwMjc1MmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaApAQCAtOTUsNCArOTUsMjAgQEAKICAgICAgICAg
Z2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCiAgICAgfSB3aGlsZSAoMCkKIAorLyoKKyAqIHJ0
ZSAocmV0dXJuIGZyb20gZXhjZXB0aW9uKQorICogICAgIENsZWFyIHRoZSBFWCBiaXQgaW4gU1NS
CisgKiAgICAgSnVtcCB0byBFTFIKKyAqLworI2RlZmluZSBmR0VOX1RDR19KMl9ydGUoU0hPUlRD
T0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3ZfaTMyIG5ld19zc3IgPSB0Y2dfdGVtcF9u
ZXdfaTMyKCk7IFwKKyAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKG5ld19zc3IsIGhleF90X3Ny
ZWdbSEVYX1NSRUdfU1NSXSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0
YW50X3RsKDApLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tT
U1JfRVhdLm9mZnNldCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2lu
Zm9bU1NSX0VYXS53aWR0aCk7IFwKKyAgICAgICAgZ2VuX2xvZ19zcmVnX3dyaXRlKGN0eCwgSEVY
X1NSRUdfU1NSLCBuZXdfc3NyKTsgXAorICAgICAgICBnZW5fanVtcHIoY3R4LCBoZXhfdF9zcmVn
W0hFWF9TUkVHX0VMUl0pOyBcCisgICAgfSB3aGlsZSAoMCkKKwogI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4
IDY4MmYwYzZjMjZlLi4wZWMzYTA5OWNiNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyNyw0ICsxMjcsNyBAQCBE
RUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8xKHN0b3AsIHZv
aWQsIGVudikKIERFRl9IRUxQRVJfMih3YWl0LCB2b2lkLCBlbnYsIGkzMikKIERFRl9IRUxQRVJf
MihyZXN1bWUsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHJlc2NoZWQsIHZvaWQsIGVu
dikKK0RFRl9IRUxQRVJfMyhtb2RpZnlfc3NyLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hF
TFBFUl8xKHBlbmRpbmdfaW50ZXJydXB0LCB2b2lkLCBlbnYpCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3Mu
aAppbmRleCA0ZGU0ZDUzODIzYS4uZThiYmVhZGZkZmIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTIz
Niw0ICsyMzYsNyBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAoaGV4YWdvbl90bGJfZ2V0
X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKKy8qIE5NSSByb3V0aW5nIG5v
dCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBub3cgKi8KKyNkZWZpbmUg
ZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKaW5kZXggYzYyMGE1Yjg2MzYuLjJjZDdmNDhlYTJmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ4
MCw2ICsxNDgwLDEyIEBAIHZvaWQgSEVMUEVSKHNldHByaW8pKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB0aHJlYWQsIHVpbnQzMl90IHByaW8pCiAgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKIH0KIAorCit2b2lkIEhFTFBFUihwZW5kaW5nX2ludGVycnVwdCkoQ1BVSGV4YWdvblN0
YXRlICplbnYpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfaW50ZXJydXB0X3Vw
ZGF0ZShlbnYpOworfQogI2VuZGlmCiAKIAotLSAKMi4zNC4xCgo=

