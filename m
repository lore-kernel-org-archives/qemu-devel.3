Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99898FD88F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa6-0001gb-HC; Tue, 10 Mar 2026 23:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZw-0001d8-5j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZt-0005Dy-Ij
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2jWjs2179919
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MPan3D+y3ONLjUyCU8kgpWedH9GrUvCIGlLg3gYTnTA=; b=fNEuS7zecEYxvpbN
 C6LEc9XltIpjWaTwdL2QvMSaw4d/04utWhpmOWZEOnBuuc4/HsU7kDZ97LNSa+pO
 Zvrq5hxqpeb8Lwh5ZXJxJhU3YFn9k7q3jRP+PpXVnrlGaUtQTDs3nBNYjr2iEKET
 tEHzqoph68+nNT8aLm/+N3rcPrEWXPYV0Im67ZFnFAj4WNJlUl7TbMyeCCWVRQXU
 2pNXOkqpfFf5nCCerU3lm29ZkRvNt/JzFECIadaLjC9mKfvFv5BZdk51QqD0HhgL
 IgiBKqPN2Y6++NaHLD9p1KCoaqzfFy2pmdN7EriR3Iv3oDE5StZQXGMyEtHfl+9T
 xTcZSg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvssryc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:44 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d73bcdba71so39000267a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200984; x=1773805784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPan3D+y3ONLjUyCU8kgpWedH9GrUvCIGlLg3gYTnTA=;
 b=DGUDTwGR7wdhWKLJI9TWmsM7lfkRD2Z1yqz9at6dGbruv2guqaeEm7YDs8Mn9P+GiV
 QBKOYEcECJa63EK2g/ZgsNokMaAsROFoewI41h6kkwcFy0P/rO0TzwtKo70ViDXEf4Km
 OYUK9Ai8dEpQp9fh9S3LRTIPvCdvoqvYv79OZbK7qsyluiZbpfX0gROMhGxJPxdS5eEI
 Cj0NLWvPimfKCn54F2wgA6s46dSY7PVV3d0sua068l4lBhjCq3K8AbF6zgwDp8mOSUIS
 6SsCaA7DkNyeB0CTlJDd5sKk6DTvsP69OkvRyGRoTLDgn1wPnAH2m0sId5bZXxugPgWS
 RSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200984; x=1773805784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MPan3D+y3ONLjUyCU8kgpWedH9GrUvCIGlLg3gYTnTA=;
 b=qUp4EJTrD6/ytc3HcZ3NRWhmxQpTJQhGTpPBRnCiIT+NFbYzXtQVDJRn+zpuiW0RXl
 IZZu6wl23p+P7d5KPTyeoc1Wi0jqtbPXjd0ea0b2bldEUeejKTwTbbUahiLmtMg7k72n
 bIfjSzAw/BIoP4LoOGi0LT332u7I4BTjdkuiOunNiL9xdqHTkcW/MYX+elLpGB513ph4
 1y9voR0RBujNm9woXFwCCMR+yI3xhdx6YzzmDv23csk5X/tSV4Qx3LLVHGaEhMwcjac6
 gelvOcqJ5YmGZC53gzWlTXvvckEZ24ouRDo3wSqFvnkfSEiv/iXoo8WkjsEevEza9ON8
 hUJw==
X-Gm-Message-State: AOJu0YzziMYmoLm96TIJr9+O4AzVuXutjxWCDTWzCmxNDZURCpG4LIEd
 R0br8+eQPP9HJWi3weOzpV4zsRlpnuqxy8A+iNPOh3FtUYozGe/BO7Og3rJE9dqUXxi7feiSKHg
 Vc9ESVh4y6Z375qUJalk2uZwrLw47HBmh5FLw7xeVOMQtqV76hf8Vpf1rIPB5EgqJwA==
X-Gm-Gg: ATEYQzy97n+2YIN3lPmmKR0H+MH/uMS6+lbxgpOzRAp9kEjNpfoc9cn647wK5CBvHf2
 uIK/cBO70j69mGgumC8zqYzmd8I1jEowV9EYJTvpJWtM3JwKM+DozGUnKmgrAXNc3fhDyVrlUQe
 mG1MmlKwKnMoa4ltheCzCcOvP3RoW4BdFe6hmtQDVcN0/FXMaY5sFD2FtIvDIOYfg5KXB5Pi6Dw
 S5n6GJ91qmKaR1RForgkGkD5CqSEnAdYxcQFVvh8BzSMJo8mq4A19bfLRxmWEsEr7EfaKAly9Q4
 ySDeqDOo8CJ40le52JzFijdrCHyNnrAqKHswlaseKKqsB9563s48xjAOzUIS40sQVNYqQR2HbaY
 jzY4nOFFxZLXB8KI3oxP4JxE90colqDSsiMUND3KW0fQyHJc9Y9Si7Go/kF6+CKpmGxi+5A==
X-Received: by 2002:a05:6830:2a91:b0:7d7:455d:1003 with SMTP id
 46e09a7af769-7d76a6bd729mr906345a34.4.1773200983855; 
 Tue, 10 Mar 2026 20:49:43 -0700 (PDT)
X-Received: by 2002:a05:6830:2a91:b0:7d7:455d:1003 with SMTP id
 46e09a7af769-7d76a6bd729mr906333a34.4.1773200983554; 
 Tue, 10 Mar 2026 20:49:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 12/35] target/hexagon: Add guest, system reg number state
Date: Tue, 10 Mar 2026 20:49:00 -0700
Message-Id: <20260311034923.1044737-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX1Q9C3w8aANPP
 LjjpLP9mx8+7YpFXG8b8RuzLt1lKmnQK29VkLGIiGybtSeqAWaO5JHXm6/hlPskMtP3dwNm9dwy
 bcxnzVIZHvb8Ynak3Ou66YhlXRXSR50kEU9AxYaDL5nlAwMi565Wr9SuN6xNLooLlJ7xquBJy0H
 FjhbupX1jIhU6B0mtgBwGXXcEFpNr0mM5AN66rPC8lKt9u21tvG/E5vJjFIY494MfIlUpSZsMhm
 p9yFnY8PDFQSWnm+vcCV8ulRCk6/X2nr8cGUYflbmgWPnGdxXen+RCyVhKyxUUPnyc+RhbKL4Xm
 tJtYwnSQKQpNdI9KxbLuIHd5HVxnMrhP6jvncPucyX01YNiMneOmRbWd+65Sbl73telxvaIGRTG
 yQ3zoNvmzeptNnoTCic3bbDNBN7O7c3u5baVHKUpmqYMQ4FU5dT2iNBIRs1I+LTJsbUefpuoIv5
 9ajv4RuhX6AHyC8esaw==
X-Proofpoint-ORIG-GUID: 3kHkXSgHznl3OVGbVhU439mmCzKgTvuL
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0e658 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3kHkXSgHznl3OVGbVhU439mmCzKgTvuL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMzgyNWRlNDNlZTcuLjM1NjI5
NjVjODhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtOTksNiArOTksMTcgQEAgdHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRl
IHsKICAgICB0YXJnZXRfdWxvbmcgc3RhY2tfc3RhcnQ7CiAKICAgICB1aW50OF90IHNsb3RfY2Fu
Y2VsbGVkOworCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBTb21lIHN5c3RlbSBy
ZWdpc3RlcnMgYXJlIHBlciB0aHJlYWQgYW5kIHNvbWUgYXJlIGdsb2JhbC4gKi8KKyAgICB1aW50
MzJfdCB0X3NyZWdbTlVNX1NSRUdTXTsKKworICAgIHVpbnQzMl90IGdyZWdbTlVNX0dSRUdTXTsK
KyAgICB1aW50MzJfdCB3YWl0X25leHRfcGM7CisKKyAgICAvKiBUaGlzIGFsaWFzIG9mIENQVVN0
YXRlLmNwdV9pbmRleCBpcyB1c2VkIGJ5IGltcG9ydGVkIHNvdXJjZXM6ICovCisgICAgdWludDMy
X3QgdGhyZWFkSWQ7CisjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3ZhbHVlX3VzcjsKIAog
ICAgIE1lbUxvZyBtZW1fbG9nX3N0b3Jlc1tTVE9SRVNfTUFYXTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggMWYxNzI0MDQ2MDgu
LjZmYWJmYWFkNmQyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzA2LDYgKzMwNiwxMSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBzZXRfZmxv
YXRfZGV0ZWN0X3RpbmluZXNzKGZsb2F0X3RpbmluZXNzX2JlZm9yZV9yb3VuZGluZywgJmVudi0+
ZnBfc3RhdHVzKTsKICAgICAvKiBEZWZhdWx0IE5hTiB2YWx1ZTogc2lnbiBiaXQgc2V0LCBhbGwg
ZnJhYyBiaXRzIHNldCAqLwogICAgIHNldF9mbG9hdF9kZWZhdWx0X25hbl9wYXR0ZXJuKDBiMTEx
MTExMTEsICZlbnYtPmZwX3N0YXR1cyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBt
ZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50MzJfdCkgKiBOVU1fU1JFR1MpOworICAg
IG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50MzJfdCkgKiBOVU1fR1JFR1MpOworICAg
IGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyNlbmRpZgogICAgIGVudi0+Y2F1c2VfY29kZSA9IEhF
WF9FVkVOVF9OT05FOwogfQogCi0tIAoyLjM0LjEKCg==

