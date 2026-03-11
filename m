Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB3FD88F6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsL-0000tz-RQ; Wed, 11 Mar 2026 00:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arp-0000l5-Ao
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arn-0008Sp-1P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3wfRx3419279
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ozqc8QSFtCqpLZSCBy6L5p77CWpiJaCCf27Mm9sBZMI=; b=LqMZ1ErkopfXkFj/
 //vva9TeY/HC847WKukha09p6Qt2fU+Dvx9k9eKkrgyH8efuaEvryER5+xvXh7ye
 xmpHvoGSo1k6PAKKDpX7V9Al5PIS/+xlQ7uS8kGY7CIYmIPyRg3q3SdNyyY+hHMB
 eZ119PNvZ4suEeq2ddNoy2XLgYLBbTLHNiVvmbq6/b0PLb3ThEnjqC6cCK+600h5
 z0rs5GohkMPySq1JtlnbPMvJLyPOvdwZC7sr7otX6K+fHEUSmnSPm8v/4GaeXNY5
 CYFeesfiQ/gyUqj2mObq/cNoN1UwI3rK6LRDX1OWtkuv70s9hzggK4fvuxocoreG
 8LM47Q==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2ba69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:14 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-4171fdb5a67so25273507fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202093; x=1773806893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ozqc8QSFtCqpLZSCBy6L5p77CWpiJaCCf27Mm9sBZMI=;
 b=B960wuWMOqU8ZFzkivht1aJwXP9N+xUMhF+OHdHQz4QI00CBlFAtPYttCXRj490379
 MlTtYSh6c6VlpDp816cW3cRPn2zVwbCl0aXEiIZi9OqcQ+woovZrgfiOHcgu0nGwZy7H
 +gNTHjRmJJ3kOcusHLbDSt0z+glCQyLA8WMtTVUO9xdjqaQMk4uZORx78PLvIjj97T3p
 uZ9nOgWu1gPF3t5tex9XYOZrAbSwIkOlpGE08gs76fRgtO0WVXxDc8EQFAZyJCkAF70b
 QTwh9ESmF3Afkrazd8ictaMce0Ma2HQanbwosDH0OS+kqdiKvlmR4xiKe1ct1JsBbcN8
 eYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202093; x=1773806893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ozqc8QSFtCqpLZSCBy6L5p77CWpiJaCCf27Mm9sBZMI=;
 b=UIxF8kMJT2RuXQ6FAfPLGds3FU/v0CfW/lT0PPeCMd1MjS4G9Ec/o0hUcy50w7GLzv
 VdGKTcdf8T93fBx5z8s39zTE33EjyulCV7oi2uQuAXAqxv1RscjMUZLs7HeLxyTcjuOP
 JpbeplM7Vpd93aeY3SH7k+yRaKQbVGjqo/gYHkgIL+zLyNiAzZSgDUfyjN8XxJGIIT1V
 qJLukCDF+IDzbcFPaSLkBFpYnwINzDhhWA8WeKluX+h73iloE0LS5NegxWTpoKq3zPfw
 B4GsnnY4NEbfRxPU7p9q73MCWpz3IK/mgfpmWdCDb0oljc/tanROaW2j2udQTgjtIJg8
 PvXw==
X-Gm-Message-State: AOJu0YwdYTG5rDNAk5ndOVQQYG3hrOtqtSIU/1ikVmt9V1k1Tm0gcuLs
 fkSatRsU8cXWgfemkuhc2s0U9lnLaKtSF3cv10BMczgeKsFXuN5JcuqE9yRGuLB+pk3jLORK/gT
 a/5HyQtw7YLvCHB5P4oV6nPK6umXwDTsss3Seebn3UY8OtiwPri4lMIEsFZzX/htdnA==
X-Gm-Gg: ATEYQzzR2HezHXW+7Lj7ojxeQZx3mmO5eg6/1SZHxvC3Wrtwt+VchkNW2gB1qd9ujJR
 W6G6llOTxqBLJgYTy+l1dQCuicZA7+Sy8hxrB7nv9liIybyLyrgDQMK9teGPQvB8cXAnCdjmODu
 SinubF79+gZWOCAe+O439tIH48aE6JXJ8JVF02dlN6uuYJdaH+24FvVw0a0wuIm37A9xTZ64ABm
 jxnnORg2qH/L6Um4HM0DZ1LfS+5GsJfFpGgyJxbrdlHpe+YfVbKPPToxYN8vT5ywDfkmae62Yyv
 sm+T+egjr16jc8Asi9Q8xweCib/jmNZj35tESOhrqHfR0Ke/aw1EDBT41PiGJyM8GezS5GI+yZs
 d3JIhbzdqrhUvB+mox2ZC/2Aw6vS8Y7ZrBMPRKgy2tw44YMEfG4nidodM7zmzcCY1SIDywA==
X-Received: by 2002:a05:6871:205:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-4177c6f4d69mr909141fac.6.1773202093442; 
 Tue, 10 Mar 2026 21:08:13 -0700 (PDT)
X-Received: by 2002:a05:6871:205:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-4177c6f4d69mr909124fac.6.1773202093032; 
 Tue, 10 Mar 2026 21:08:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 05/32] target/hexagon: Implement {g,s}etimask helpers
Date: Tue, 10 Mar 2026 21:07:31 -0700
Message-Id: <20260311040758.1068731-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b0eaae cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2yY3krT2Qpcqih5ofcWTRixt-19pCNHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX8FV4YK/tg+Ok
 pjottNRzmLAWKwJ55O0aIi3De0aUx6b1zvmU3kznuUs0c3gsWOcT8NA5xKjUSEIqtJaIi48Xv69
 KaWLnojDeSg5p4+NsJRvd7T90OZUVsuKPm7Q3tMhQKyjf/X3vz2MwvzaECulvfDEZUzg/KZOB5k
 mNfp2bb4enBbqOZlfnliRY4oBTGe0H4ssFh5X1Tww2hS2uOpq9ZJRuON3cjYMk0RIQ1Gq9G4YAb
 Z+qBwQ0RVt2TeiyStSwfYckmgvb4Naer5jpHkUPZyKKrOQw+clv6v8OfxXvUhsWBsJfTQhiO7qe
 0YGLOR4iGG40OAfC40HflTbZvMJiUfurhQETG5rbyJkM7UlqvevIL2166C0+ZlPYHBSPM+0LT+I
 4qCiZBfjPAAbQhKZSJ84anp7mUn3L1pk5P5hW8EmNFl6QEiOcEzg98Dsb9dPzFjky0Q424doLqc
 sYuey6KT0dg4tFGfWaw==
X-Proofpoint-GUID: 2yY3krT2Qpcqih5ofcWTRixt-19pCNHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMSBm
aWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIu
YwppbmRleCA4MjYwNWYxZDRhYS4uMTYxYzdlYWYzMWYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDk2
LDEyICsxNDk2LDQzIEBAIHZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IG1hc2spCiAKIHVpbnQzMl90IEhFTFBFUihnZXRpbWFzaykoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQzMl90IHRpZCkKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwor
ICAgIENQVVN0YXRlICpjczsKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNI
KGNzKSB7CisgICAgICAgIEhleGFnb25DUFUgKmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsK
KyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpmb3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7Cisg
ICAgICAgIGlmIChmb3VuZF9lbnYtPnRocmVhZElkID09IHRpZCkgeworICAgICAgICAgICAgdWlu
dDMyX3QgaW1hc2sgPSBmb3VuZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAg
ICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULCAiJXM6IHRpZCAiIFRBUkdFVF9GTVRfbHgK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIiBpbWFzayA9IDB4JXhcbiIsIF9fZnVuY19fLCBl
bnYtPnRocmVhZElkLAorICAgICAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQpR0VUX0ZJ
RUxEKElNQVNLX01BU0ssIGltYXNrKSk7CisgICAgICAgICAgICByZXR1cm4gR0VUX0ZJRUxEKElN
QVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgfQorICAgIH0KKyAgICByZXR1cm4gMDsKIH0KIAog
dm9pZCBIRUxQRVIoc2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQs
IHVpbnQzMl90IGltYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQ1BV
U3RhdGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBDUFVfRk9SRUFDSChjcykg
eworICAgICAgICBIZXhhZ29uQ1BVICpmb3VuZF9jcHUgPSBIRVhBR09OX0NQVShjcyk7CisgICAg
ICAgIENQVUhleGFnb25TdGF0ZSAqZm91bmRfZW52ID0gJmZvdW5kX2NwdS0+ZW52OworCisgICAg
ICAgIGlmICh0aWQgPT0gZm91bmRfZW52LT50aHJlYWRJZCkgeworICAgICAgICAgICAgU0VUX1NZ
U1RFTV9GSUVMRChmb3VuZF9lbnYsIEhFWF9TUkVHX0lNQVNLLCBJTUFTS19NQVNLLCBpbWFzayk7
CisgICAgICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULCAiJXM6IHRpZCAiIFRBUkdF
VF9GTVRfbHgKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIiBpbWFzayAweCV4XG4iLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgZm91bmRfZW52LT50aHJlYWRJZCwgaW1h
c2spOworICAgICAgICAgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZm91bmRfZW52KTsKKyAgICAg
ICAgICAgIHJldHVybjsKKyAgICAgICAgfQorICAgIH0KKyAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKKyAgICAgICAgICAgICAgICAgICJzZXRpbWFzayB1c2VkIHdpdGggYW4gaW52
YWxpZCB0aWQgbmVhciBQQzogMHgleFxuIiwKKyAgICAgICAgICAgICAgICAgIGVudi0+bmV4dF9Q
Qyk7CiB9CiAKIHZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUg
KmVudiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCi0tIAoyLjM0LjEKCg==

