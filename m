Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C644C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIq-0005yn-Mf; Mon, 29 Jun 2026 09:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHu-0003t7-U6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHt-0006MP-BA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuGg2601187
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=; b=kNsdpf1oO7Pn9iNl
 8At2cVzqNlw9pRt1pBSKfBVcBSuKqhGJAbKgEr4LFGm/Q2bdxFrlq9htM2+hErJ1
 9TKo0KV8BgXBN2U30IvsUiNR2QMQEi4klVTOWlkMmE2jn17BNgllqMPpUQZ33dtI
 C3aQyj9xMd6J5450WdG2wGKBDuvXUvVogvD6cHaPRMhEa1GQhpAASetZN/V+jLCY
 LH4jq7HTu1yPAN6Q9HBincltaYYaPMrBQhgs/yWPpsOm8wPuR3YtGM9oahmfS1k3
 kE6nPiFZgoHi8JH/M51OFnMhEVySqEW+wyhsGy2wySO0Z6bQ7e/jOCe6cO1zHBLX
 pSX1Cg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw93ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37fe90ee192so1235769a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740665; x=1783345465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=jJYMG8WgYk3Zl8VKtQ3ZprJ/mXqrHBdg9XRAclzjBQUbw/KUwWbVxBy1XS5+lksvI9
 gN1tplVtL0ygvtcl+PzU6VkH+ZoAdie4nIxOY/7wyGEJVp77Ubg24Ouy9vvycvkYE/OT
 H1SBKz9bX0fXMl2ykXX6GWbXkWLM7RFvyagosrItLprDqi4AS/K0luph+lQcW3WKPv/d
 jt5/eWB84DPaAdIIwdmO6x0hDcJYF07DoinZm3JHNPiCDTvCIgoaOBTQBEo/hZF7z9j5
 jTQJ3T7ZdzjtKNLAbrfPWgTjAqLjPwyC/mJXWmsAZMOs7p4xNCvnWtbBuHQSARzcRKwQ
 E/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740665; x=1783345465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=EF8jGFDhHN30AHWby9HjHh0QkKempy44or7Rn22mBznwY053v59U4pkXz/VP6NjTy7
 l9iJWX3UnC7mxRhigNgv4qeIFcMFNLQ4BARkMlzgqlRZcyM8aenKEM9k4hgfUwBr/BbA
 03s2A7RGVKzWkiYe8AwR1Ok4EbeuTByDs6H1O1wCs3DjaHyH5rxx0HxstG0yVy01Rii/
 1TgVEyKR+XCq6QT+UbiwFSPynKt5TF5OObYyLs7Q8+EeXYgoKC+b2zTT9u4WUfSMERoF
 o5vbjj203Gz19Zv2ngnSJb5TzwF8wHZc5cfaz0+qGGdtnfGG7oGhqSBVHLrFuankxGef
 YG3A==
X-Gm-Message-State: AOJu0YzPfeOc4rj0h7Mx5h1UPHWReYIAqMxeI1FZab0AFUVoVA5N2RGF
 cG1fP+bKJRyxUus5Fot5wdaIX59mmc2KnELgrGw0aEYJEp/+/N91o95qyBl7jV/5/CzsmAnXJae
 gO4hsHJF6Ci8l2eTrF0nu0xw4AwWqI74tPRXStxi2uVKiToUQsNeVy15VEB9M3WfbPA==
X-Gm-Gg: AfdE7cnAec9ZPtzcUTlnjngXRZ20EUGY1r0YsOcPBh6tgOa6Ttb4AWxAZtdxcraDLf0
 DQVKYo3HLXsfiAlhrKWPZYe9XwDC5cX8PRxLpL/8Q5aKnxf02EvMbpv/MHEdbK9qoFAnd6U2Mot
 G8VchotYfa1364jb2CxrqssUB4K9qoU4pgeK8e5BMyzUeuO4LdRJ8V6YEk/hol/wPBbGMzIhYAk
 2tdO1X63VfT2csqY8nctprwwq+NjUQdRf8KEKt/Dj0D36kOmLoIcVZJj0KxbahcvwB5HvhojFfj
 4Ij49YTbXicA8RSwGTJKC1Dz35qYxdAykg9XiV4UaC/3LFg02/6tziFseE7QMYetIlAUfvCrw7h
 Sinp9YRW/Sig0Wzt+2M2Rkk8Dc6jYVlQngImFKK2F2yqC7ZA7CXWNN+z6ik8=
X-Received: by 2002:a17:903:1850:b0:2c9:dbb5:c1ec with SMTP id
 d9443c01a7336-2c9dbb5c4f3mr51529915ad.47.1782740665246; 
 Mon, 29 Jun 2026 06:44:25 -0700 (PDT)
X-Received: by 2002:a17:903:1850:b0:2c9:dbb5:c1ec with SMTP id
 d9443c01a7336-2c9dbb5c4f3mr51529645ad.47.1782740664796; 
 Mon, 29 Jun 2026 06:44:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 68/77] target/hexagon: Add guest reg reading functionality
Date: Mon, 29 Jun 2026 06:12:23 -0700
Message-Id: <20260629131232.2487780-69-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX2cqRsw9q3PqO
 DtsHc67+IRM7C80jIDMUsPBP8InzM5sJ6GIgTSqvW0v6947rl1LkHLcvBDN6ugtfu//01QW97tG
 ZHIXRH2om+Ewvij0x0rjO8v/0uqZNUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX3AtpI1r9DfDU
 4PtUd+UYOXDF+dEcLLan4X5DtxiDAubnFGv+PYd5GG7ZpvKoWt+aoOXOJJYMFV7EcgxHt8kBs+9
 5gU4OMCRwzk4Rq9gD7TtCyWtKqgfm2MwYPyJ5UBCLDIo+y7Vth9PC2Whcy4DLfTo9DN01jqWGOW
 bHTG4/af5B39g9JIEMTORikM2QG0J7PXHnPGtpKjgC0O8gCEH6qsMn1VPjl6Wl/8HzpG2P7pmW0
 8+JLgzX3Dxx7a74R+Nk+hUfd1dagiVge0jgU16beirpCzvvDPD4GNLXLXxdMJE+LMCGjMetuPFk
 yNtdptPVwUY+1IIth274rKuj4sGsdBVydboFeVTKtNC6wAnRVHgiy8TGfieRkbHWBm9LD/K7weD
 OXlJEe7nOwJcjKX2fC3EcPbDqLTt+H9W0CIV+kHJqLsFtO6morkww1XT9rVTdeYrH0jWfuSd/G4
 VBs2bcgdKxfnfdWvPMQ==
X-Proofpoint-GUID: lbfKsO8eYQWvTG3CJOUkzLX-NzhPBqJt
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a4276b9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IJQQmebJWjVxhimlKuwA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lbfKsO8eYQWvTG3CJOUkzLX-NzhPBqJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICB8ICAxICsKIHRh
cmdldC9oZXhhZ29uL2NwdS5jICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgfCAxNiArKysrKysrKysrKysrKy0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDM0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA2YTk1YTZiYzViMS4u
NGExMmRjMDQ3MjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0yMjAsNiArMjIwLDcgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFn
b25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAqIG5vdCBzdG9w
cGVkLgogICovCiBib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRl
ICp0aHJlYWRfZW52KTsKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCByZWcpOwogdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0KENQVUhl
eGFnb25TdGF0ZSAqZW52KTsKICNlbmRpZgogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGIzNWNhYWVjZmFlLi4wNmJlNWM4ZDQ5
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTc3MCw2ICs3NzAsMjUgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICNlbmRpZgogfQogCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8PSBIRVhfR1JFR19H
MykgeworICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CisgICAgfQorICAgIHN3aXRjaCAo
cmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86CisgICAgICAgIHJldHVybiBoZXhh
Z29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAgIGNhc2UgSEVYX0dSRUdfR1BD
WUNMRUhJOgorICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdo
KGVudik7CisgICAgZGVmYXVsdDoKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJy
ZWFkaW5nIGdyZWcgJSIgUFJJZDMyCisgICAgICAgICAgICAgICAgIiBub3QgeWV0IHN1cHBvcnRl
ZC5cbiIsIHJlZyk7CisgICAgICAgIHJldHVybiAwOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0
IHZvaWQgKmRhdGEpCiB7CiAgICAgSGV4YWdvbkNQVUNsYXNzICptY2MgPSBIRVhBR09OX0NQVV9D
TEFTUyhjKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggOGEzNzIzY2JhZmEuLjEyNTk1MmFlZTU5IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTg3OCwxMyArMTg3OCwyNSBAQCB1aW50NjRfdCBIRUxQRVIoc3JlZ19y
ZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcp
CisKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiBoZXhhZ29uX2dy
ZWdfcmVhZChlbnYsIHJlZyk7CiB9CiAKIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKKwogewotICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7CisgICAgaWYgKHJlZyA9PSBIRVhfR1JFR19HMCB8fCByZWcgPT0gSEVYX0dS
RUdfRzIpIHsKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCkoZW52LT5ncmVnW3JlZ10pIHwKKyAg
ICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdyZWdbcmVnICsgMV0pKSA8PCAzMik7Cisg
ICAgfQorICAgIHN3aXRjaCAocmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Cisg
ICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgZGVm
YXVsdDoKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCloZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJl
ZykgfAorICAgICAgICAgICAgICAgKCh1aW50NjRfdCkoaGV4YWdvbl9ncmVnX3JlYWQoZW52LCBy
ZWcgKyAxKSkgPDwgMzIpOworICAgIH0KIH0KIAogLyoKLS0gCjIuMzQuMQoK

