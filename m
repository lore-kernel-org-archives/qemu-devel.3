Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F14C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm6-0002Lj-0W; Fri, 24 Jul 2026 14:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlb-0002D2-JJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlZ-0000uv-G1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqVLm3516898
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mPv2+q7FzavU4aGhGG40hSfwWcWxCcWKqiyeW4bOzUE=; b=PG1Nm/m8r7c0WJNm
 q6f56+tyaC2vTl5Zj96xvhhD90qvWMuH5KlauWrDQ09SavTDdp5nZawp/tSHYUHs
 26bPILKJOf/+FaW0PlK8cy0cSq8i5eZ2ynGRoB6cAjExpaOWyD73LBwA54gQ/xTY
 cFfstXwnS5hIfHfL4Iy207mWsuu7rwyRsmf5NRNpA4i8nWdvgh+pFdv0ms70ixIk
 kNmwpVXg+oV1UczTNiiVLUNdRgVrIF27P6GQVmqgp8hA4SFJN7lp+Esaof5Wn1B8
 lESvrdHlX+plwYI3/yehmM+sGbxvShU3BSDUtxVx0vBiPEihz65EFBZiyUBwDfiP
 gv8v8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pwb2st-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so1043972a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918219; x=1785523019; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mPv2+q7FzavU4aGhGG40hSfwWcWxCcWKqiyeW4bOzUE=;
 b=SqBTicrU5B4rRERvmL3wvUpfNYCXhsmX2BBOgDYyp+64pUtL+gnc6GLWywBvr8hrEw
 sO/sMflFR97chq15xx0hpDqVe4OARaZ0w85R0VOiBaESSQuCDJZAiBsh4S8s5i51AvQp
 Gns4CJJ17jhlc3HvLTROaUcW7APZsNTm5nQw9xOzwAv9XHp+Eq8DKCiWyYpIOCO0p77i
 XYFTRbXT9Uh735zm9Z8GKvSlz0/BZn0vU1lMy2kIyyDFnAZ5SnTjhAuPsNwfg38L7bgZ
 bCCirraDQC+2o+j771bo8szeh/P9AvSijFl1ng1W5yLhmqn53HUOZcVST8+bTA/em9Yo
 dNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918219; x=1785523019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mPv2+q7FzavU4aGhGG40hSfwWcWxCcWKqiyeW4bOzUE=;
 b=Bu1EDt/UMZPjLhazUi0b5Y67TrwYSKVtTe0dV//YVj0ImC+aMX2sx5n9eupQH4Cv9E
 KLI3hWqOhtDungBWxUIsRUpkCftaSqysWh9VaIFzpbc7Vx3H/pmZw8w/VV7XZuqeomuB
 y3ZSaPeForvzeQehEqoXtvKv8Iu0nrO9JClhff0HC+hDV00yJrsn3isBddAxEuC6q795
 cgfLz3+78wuTT2J4zf8vMe6c/w3bGNJ5BguEqZPXtuY8m6ewH5XAHv8FpdgQq9o9XqY7
 mTYl/I7Xk+achz0bF5g/7G7+PM0RArBC9ND/atC2bpQNRTg4Bjoud8Ztt5vTMRuG+xKb
 QTtA==
X-Gm-Message-State: AOJu0Yy74bkBP4F5Egz2iTazQBgBiPf7+abJvDky+ZNEYiGsnAQ+WOSH
 jp4MC8KctDGk3E1PFxzodAdt8s8TDaKLYaQ5uZJdEwZXBGexbOzBlIzIiYNkS4kHO5I7JNkFwdU
 KVc9ccZmP+MNVUVFFPon2Fdlx3Oul6nbhwRJFVXnQ4uQZmP/3WQaYPsYH4EPrnw2DZA==
X-Gm-Gg: AR+sD11Vj2BdzEJadbnDINwf7N7BYtayW79UK5hq14dGH2PdWJmrdGfoD9CyqicMyWy
 ezNnbM+d/WBuWVhx5AYE6FeFhN5gIT+eI8wtSvnXZ3mY42la4hLHBHRjlPWGQGhL+yYxKMTECXs
 ChxvuLW/PWG1sjLFFfci7aDsnnaa9TtROc/sFVCawychGwd20yjZTFRbFbyLmf0KbhBPnwqf2iu
 9X8HdCqSOEt8DsPyGKQfLdSR5sRflK3i+MAmK/jLzcyICgXR3DlcAOy4uJnKjR7j7QhLSkcfwi5
 CVF7hPV6lq/EYmP8YaP0HBzp5b9cnBv+RY/yScm3EEm8NWJDtIFvXbLnjzelGvOFoaTcGe5opgm
 jbp+3EQ1Tqg7mrhu64JhA7T5SBypjNICkW43Q63Y4yHtiM/n2
X-Received: by 2002:a17:90b:3149:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-38ec694b61dmr7624867a91.6.1784918219063; 
 Fri, 24 Jul 2026 11:36:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3149:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-38ec694b61dmr7624834a91.6.1784918218647; 
 Fri, 24 Jul 2026 11:36:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:36:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 06/14] hw/hexagon/virt: instantiate virtio-mmio transports
Date: Fri, 24 Jul 2026 11:36:40 -0700
Message-Id: <20260724183648.190531-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfXxv5aotTN81+2
 aTWqx9LZ3DZRrBsQJeroN2wrXcP+86zk8gQOHNH8fLAFzlczsUXKCfvM6PDGtdc5d7/GMaHKsqg
 ZtomuK3/QZGu9pYXrNZVgGwXMrFhQJm7RX73tR8GgL09tsyW+EMc0deD4ZGXcjqg9w+fAS3rSvX
 k5vcfSGgDn93T58lLxglnB33XW75YNEXQ7UIGRTu9kCLJmRGr1fDDZW/ijyG40GQtbCoyuEkdeI
 MkJZuJr5npk7WsmTuS2bNmYQe/RUjC1y/9lSoztY8osM3oEvO9gpKAiWoNn1SaQHV0mM4GRu2YG
 P9hz7qWgsQ4tKXfDsN6zmUgq6aZFaEIa17FW/+c8sraYMEtM9j7rIvdFrNrkB9b7AZ7Sq0Opzv+
 FDnf4WQrMK2qtUN2F0wIpSGRLoBkV6w2DDstLVJcsCNkh/7TjeZAIz4RelvyC9zk4hu8qiFbnZU
 HCJ2C2nc912Yvtrr+RA==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a63b0cc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5bsKbiArNqFjW8UKV0IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: oJcPjb8nf1VZYcQzI_QbpMRPOJH8FxVf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX3G4HcLThRlxD
 ySgX2rWfdB04gWqjm5dcFCt8D8hjCFVSoNNKZj4rwm1PsMFEGifN7L2+UI2Sec5+rhxtu6JYniH
 ob2O2FWVw78osP3oVJraHn8IjiU2ExA=
X-Proofpoint-GUID: oJcPjb8nf1VZYcQzI_QbpMRPOJH8FxVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240167
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

QWRkIGEgVklSVF9NTUlPIHJlZ2lvbiBhbmQgdmlydGlvLW1taW8gdHJhbnNwb3J0cywgd2lyZWQg
aW50byBsMnZpYy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL3ZpcnQuYyB8IDI4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvaHcvaGV4YWdvbi92aXJ0LmMgYi9ody9oZXhhZ29uL3ZpcnQuYwppbmRleCA3NTYxYWVkZDJi
Ny4uNDZmZjA2ODc1MjggMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vdmlydC5jCisrKyBiL2h3L2hl
eGFnb24vdmlydC5jCkBAIC0zMCwxMSArMzAsMjAgQEAKIAogZW51bSB7CiAgICAgVklSVF9VQVJU
MCwKKyAgICBWSVJUX01NSU8sCiAgICAgVklSVF9GRFQsCiB9OwogCitzdGF0aWMgY29uc3QgaW50
IFZJUlRJT19ERVZfQ09VTlQgPSA4OworLyoKKyAqIFZpcnRpbyBJUlFzIHJ1biBmcm9tIFZJUlRJ
T19JUlFfQkFTRSB0bworICogVklSVElPX0lSUV9CQVNFICsgVklSVElPX0RFVl9DT1VOVCAtIDEK
KyAqLworc3RhdGljIGNvbnN0IGludCBWSVJUSU9fSVJRX0JBU0UgPSAxNjsKKwogc3RhdGljIGNv
bnN0IE1lbU1hcEVudHJ5IGJhc2VfbWVtbWFwW10gPSB7CiAgICAgW1ZJUlRfVUFSVDBdID0geyAw
eDEwMDAwMDAwLCAweDAwMDAwMjAwIH0sCisgICAgW1ZJUlRfTU1JT10gPSB7IDB4MTEwMDAwMDAs
IDB4MDAwMDEwMDAgfSwKICAgICBbVklSVF9GRFRdID0geyAweDk5ODAwMDAwLCAweDAwNDAwMDAw
IH0sCiB9OwogCkBAIC0xNjcsNyArMTc2LDI0IEBAIHN0YXRpYyB2b2lkIGZkdF9hZGRfY3B1X25v
ZGVzKGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCiAgICAgfQogfQogCitzdGF0
aWMgdm9pZCBjcmVhdGVfdmlydGlvX2RldmljZXMoY29uc3QgSGV4YWdvblZpcnRNYWNoaW5lU3Rh
dGUgKnZtcykKK3sKKyAgICBod2FkZHIgc2l6ZSA9IGJhc2VfbWVtbWFwW1ZJUlRfTU1JT10uc2l6
ZTsKIAorICAgIGZvciAoaW50IGkgPSAwOyBpIDwgVklSVElPX0RFVl9DT1VOVDsgaSsrKSB7Cisg
ICAgICAgIGludCBpcnEgPSBWSVJUSU9fSVJRX0JBU0UgKyBpOworICAgICAgICBod2FkZHIgYmFz
ZSA9IGJhc2VfbWVtbWFwW1ZJUlRfTU1JT10uYmFzZSArIGkgKiBzaXplOworICAgICAgICBEZXZp
Y2VTdGF0ZSAqZGV2ID0gcWRldl9uZXcoInZpcnRpby1tbWlvIik7CisgICAgICAgIFN5c0J1c0Rl
dmljZSAqcyA9IFNZU19CVVNfREVWSUNFKGRldik7CisKKyAgICAgICAgb2JqZWN0X3Byb3BlcnR5
X2FkZF9jaGlsZChPQkpFQ1QoTUFDSElORSh2bXMpKSwgInZpcnRpby1tbWlvWypdIiwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QoZGV2KSk7CisgICAgICAgIHN5c2J1
c19yZWFsaXplX2FuZF91bnJlZihzLCAmZXJyb3JfZmF0YWwpOworICAgICAgICBzeXNidXNfbW1p
b19tYXAocywgMCwgYmFzZSk7CisgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShzLCAwLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbih2bXMtPnBhcmVudF9vYmou
bDJ2aWMsIGlycSkpOworICAgIH0KK30KIAogc3RhdGljIHZvaWQgdmlydF9pbnN0YW5jZV9pbml0
KE9iamVjdCAqb2JqKQogewpAQCAtMjUyLDYgKzI3OCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRfaW5p
dChNYWNoaW5lU3RhdGUgKm1zKQogCiAgICAgZmR0X2FkZF9odngodm1zLCBtX2NmZyk7CiAKKyAg
ICBjcmVhdGVfdmlydGlvX2RldmljZXModm1zKTsKKwogICAgIGZvciAoaW50IGkgPSAwOyBpIDwg
bXMtPnNtcC5jcHVzOyBpKyspIHsKICAgICAgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9D
UFUob2JqZWN0X25ldyhtcy0+Y3B1X3R5cGUpKTsKICAgICAgICAgcWVtdV9yZWdpc3Rlcl9yZXNl
dChkb19jcHVfcmVzZXQsIGNwdSk7Ci0tIAoyLjM0LjEKCg==

