Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED603CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXyj-0007fH-0w; Thu, 11 Jun 2026 01:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyc-0007e8-KS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXya-0000k5-43
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GZdk3846464
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=DQBIVGYghjzyw90bMHrQCq4RL70HUwqTEiVHuIkHj+w=; b=Gi
 Yd6OXMt/3OLJymf0I42tDn6JSoQCCjV2hja5UeIub+l/gHmhTEAUewRyZx6QrvE1
 qcZDD1G6gRsmSW2ZLmbAoLZi7N9HkzM/B3eUigg2x+FMTv9YhPf/+pFAS0PVAcao
 n4eAVG4LSbp5jFR5txDyi8PzYPgRIUq1XyDJl5nkyex3xvhCsX7QsQyXH6atrG1q
 4zjdpynxSZMRxO0eobi9GB1VT/3/vR1vGgn1m4WTygzPpFUA5uC8CsAMDg+8a/Uz
 DEI4W7vtvWaxZuxiLj5hI27DeXaBvCqnEUYWZeXWVntvrDVEWVLwQsalECcpNF0o
 OQtr9zCSQRgZuBvERXPA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1qyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307fe856724so1876033eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155750; x=1781760550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQBIVGYghjzyw90bMHrQCq4RL70HUwqTEiVHuIkHj+w=;
 b=EiOIs8W6iB1NMdKfz7dI3jLOsQR5Bgop/dMeIztmcqffxYiv/ZbAcHS/10G1w7Rj9D
 0u14u/KJJvsBjvSWhsDrJknuOEBt1fEpeyQe1V6CLJygNJ0yLV/U35HbRBIg0EeF9UW8
 6yJxXZvf38wDeBHY4JnaLsVne8YvU5jhQjVUjkX8S2i2bNIKeRuxJXsWvkOLu6ZY5z+0
 vJ9VSRgTiCKi6ofQ38BYwi6/Jqfd8qqhcgATWrzIv8w6D/69+OYq48dYkpKbTeGwuq+f
 paL8ZTbo0XT3EPQKt5Bb1mAiJ0Jw3IkWw3eUbVKYwIglrV5hMEDH/ozktlQrpfGfYgWB
 335g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155750; x=1781760550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DQBIVGYghjzyw90bMHrQCq4RL70HUwqTEiVHuIkHj+w=;
 b=tO+kG4bpg11jQoelN5Ha+1yEh5ykcLGnc2e6quBKzh1KJ6pkpIBVXQk9xNhQEiCUpd
 MPnyb+odirVF0OKbHK/nq9s+y85/jn726+SXtLAl6cyBToApOW3Ou9QjKYjUSGC7uc2u
 c7qrmU5o5MORgV87F4GSxoPmzZClO50EuTLSVBTsU2LfhuBRqeoHEPu5wZW8XpMevuup
 bFokS98VtWOHlyaYP31O0D9Rkdmt4AQuIWBZzLUJu+rT6sbHcQ0Q/klTfi5CMcSxSZTb
 6OADRtpPlRfhQWRrRp0x0TUrdwi9T5yLOLvAZ2MqBX1Kw0MippnHrL+s8AVLy5xw6RdT
 BHpg==
X-Gm-Message-State: AOJu0YwkWzVfjZkTDf22c+X68Iyb1rlkAppiEraQGZ/5oOCpvKIVtr4p
 F/EOdoq1q6AdB6HhGj/XBk3N0bSca3vp1BdwkW5DWMX10Vbwf6teE7Ex/eKwvXFNVNyI7GNmNym
 RvvNT7a97+pbc++BY3t+djUr6DXCZ+L4CEIJJ9mxenGhhNdx3IYgnhTNgaGNDpAkRJQ==
X-Gm-Gg: Acq92OGjqbU2uDp3v2tgAmSCAWa2oSsOmwHVTnEYGDjHrlD6u36StADB5O8hg+mD1XS
 4nrvHFA4rp9POsteOxpm0jieGifpnALb/xewFsP2jX6zvTxwNrdcFkM5SBE+M/H+sMXWdcd4kvI
 1Ae4ubcyVB8WOgBjf+Kay2A5PmWHvfr+2QsluMV4AhgqHNkIb6Vo3fj3YY/IxTDOLZ5l40+6thE
 zJW8KejufK+a2/Vx4H62SmwDoZG8SuVbDU5WLc5WGyZynvixoIKFNOX57GQPHA3viYUrYjcjn53
 Xu2B/IUxDxxbq0Y+hmbYKZLIRATLiYYN/SeooudMkHiwYahkY7Q+j6gXI//g6ivC2YmAr4Iy25B
 JZCl6gGqYwjwhYdvR2VKFUklHKk9zG4mCd9aLr6shG2xyzcztmGJp0e+IpaJ1tyGTRApKDsTVMk
 +eCuhc
X-Received: by 2002:a05:7300:434f:b0:307:3a6c:e708 with SMTP id
 5a478bee46e88-3080460737cmr1318985eec.5.1781155749548; 
 Wed, 10 Jun 2026 22:29:09 -0700 (PDT)
X-Received: by 2002:a05:7300:434f:b0:307:3a6c:e708 with SMTP id
 5a478bee46e88-3080460737cmr1318954eec.5.1781155749031; 
 Wed, 10 Jun 2026 22:29:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8] target/hexagon: Fix badva reference, delete CAUSE
Date: Wed, 10 Jun 2026 22:28:24 -0700
Message-Id: <20260611052857.3911981-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a2a47a7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ejuVO2Xu0EV66GDXWbY8I9h3cXLK-teu
X-Proofpoint-GUID: ejuVO2Xu0EV66GDXWbY8I9h3cXLK-teu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfX8vks/yccFgpK
 jp45izYVWDFyliWX36xm5atk/QAY77ZyV0bZPZqGgstDlkNwdExQ4jA50rKGY5F6+dRHz6Q88H7
 dRAvOeCcjenEEVGaPUJCmlNMyZRkB2JsmjOAX7SPkR/dJ3Zfv5J1CjjUvRj8au7B/vEYi02gxE6
 nmJDf+5dLaFmrcGL7hTPfk7lQ0ziY4mWdumrRwZotDgzae9efmBsbde34FLLCrzYqA2EntNuEZ/
 2ZQ3rRNHEeLE2u9KLM6O9k5q0bWrGPR7xM0T6JH4eNfUGbmMNejNBPrt60ynF2ZZl9SkBV2cj5M
 RvTmOTDu8Ecr9yL9n2W4nkb/3dnTNohmafer8Xnk+80LYtmYc2TE66nhIhLDiuuzowPFi9KYHhi
 h/alAsd4+w6Z/XcXdJWEvS7kLYul2iTUJjzTr0R+G9JAWFgk42kOvCk2nzjlWsgmB8WuqhC+HcW
 UUdfQc/BNZCKH6+Y4hQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfXxo3oX+32DdZo
 8V7jsIEYPvBxwwVy+asCaOgk+NkJqTnsgKv1TwpDTdNIkbWpzls4jH582qZAo6Ygef4Ym/dtLLf
 FWmdKf1/NIkHc/wHd6PiLCJqYV9Zsyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110050
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDExICsrKysrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MmM1M2YyYzI4MzYuLmJkNTY4YmRkODcxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMTEwLDYgKzExMCwxNCBAQCBzdGF0aWMg
dm9pZCBwcmludF9yZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCByZWdudW0p
CiAgICAgICAgICAgICAgICAgIGhleGFnb25fcmVnbmFtZXNbcmVnbnVtXSwgdmFsdWUpOwogfQog
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIHByaW50X3Rfc3JlZyhGSUxF
ICpmLCBjb25zdCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkKK3sKKyAgICBxZW11
X2ZwcmludGYoZiwgIiAgJXMgPSAweCIgVEFSR0VUX0ZNVF9seCAiXG4iLAorICAgICAgICAgICAg
ICAgICBoZXhhZ29uX3NyZWduYW1lc1tyZWdudW1dLCBlbnYtPnRfc3JlZ1tyZWdudW1dKTsKK30K
KyNlbmRpZgorCiBzdGF0aWMgdm9pZCBwcmludF92cmVnKEZJTEUgKmYsIENQVUhleGFnb25TdGF0
ZSAqZW52LCBpbnQgcmVnbnVtLAogICAgICAgICAgICAgICAgICAgICAgICBib29sIHNraXBfaWZf
emVybykKIHsKQEAgLTIwOSw4ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BV
SGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFncykKICAgICBxZW11X2ZwcmludGYo
ZiwgIiAgY3MwID0gMHgwMDAwMDAwMFxuIik7CiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIGNzMSA9
IDB4MDAwMDAwMDBcbiIpOwogI2Vsc2UKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0NB
VVNFKTsKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0JBRFZBKTsKKyAgICBwcmludF90
X3NyZWcoZiwgZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVY
X1JFR19DUzApOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ1MxKTsKICNlbmRpZgot
LSAKMi4zNC4xCgo=

