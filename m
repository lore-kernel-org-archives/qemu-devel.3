Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8B7CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2T-0000e5-J6; Thu, 11 Jun 2026 01:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2L-0008N2-R9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2J-0002Ps-C1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GJpH2247966
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mUbwH39pJvroWXvtk/P0f2uJ0g92UP/uywt2v4xWgns=; b=LAT0AeLlWUSshXcL
 KqII/Mmxjjh8Pu294HxgYPuBkoX7mzaZIOvUejWIc9c4iVjx9Ih3pPgJVRKGKK4T
 NvhjLiStoP+VEPhJq+yDSxr7H22Jy233dCp5EAHLiI23hqyLqBdplKOwVw1wTLy0
 1c1KN3j+BpjQGW+tSOZyRq8PF2AaSNDG58VUTBVTCzobO/dQtGqMXCDUdkrRyURm
 Xjfo3WLEhH9frpBu/d1788QeC1dAKajrZMj7+5k2Bq+CvxrX1G01d0g242jq7Kq7
 w4+QLLiAjnkkiEe/9nHrPC8YdabR5YkNq9q5gTJsYDDJGFCpvHpfxJpzNJuJS8fj
 fMgjeg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79hrhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso9682509eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155980; x=1781760780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUbwH39pJvroWXvtk/P0f2uJ0g92UP/uywt2v4xWgns=;
 b=ZSZie5C2ARnmx3PgEn03vX5F5ORf4uDesVXDHvOQSz1+az6JlDYaFtmQpbVJ+3y/eY
 PrKf+aQncr58W/Fogi/tGJ22fI0n/Z6O1RVWKSoFDCj4OkXCd5tnkSOjRr3INRSpRjOz
 5nj5HfM+UDybgMUxW/7Jz+JnvfNfFQXx+QdXIqnRbDhdSzwCkVaVJt8Rvyy6mzahBZzM
 usyjEaaU54eiapLM3IOcnRO7hI0b9ENCSP1gAzTn2kBX19QelkG57jRw+kBtomCZp/lh
 ygSBhNAzZgUuueOZR9X7rFNVPPwFSRnEQc8EQKymcf7+inuyW5eDt0FNOycD6I62aBuV
 /eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155980; x=1781760780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mUbwH39pJvroWXvtk/P0f2uJ0g92UP/uywt2v4xWgns=;
 b=shhbNoL20RRh95P4RGuNfhKY/qWfjJ5KSb4q5m0j+1MXOQdi+C7kO69RSYe4R2SbwI
 jDZS5FO0hCjbNAdZNR6IFo46PbyUTBh9axwNfBI+TNtOGJIndKAuvcjymM6DHWQIkDKX
 PMkWVrQPE670HgU6s11CJFM1qKNEPs04i0bRV1I8CcNOetU3uLESdgASvcmaDhuyU3eX
 5L2qsIy0nDERTbdcRkFu2bo+thLVNVr4SXW0O8o+LthNKpUhjQh5G6e864StTAkdbRYc
 Y5k9WPVJlRbB8aW9FGTsU98GbcS5ehQIBf7pTt4hZV5Ow0rBgscA1R2SiJB4q7UeU6Cl
 kxUg==
X-Gm-Message-State: AOJu0YxuS6Rb9bE8XMZiafQN+OOwjL9ndNYKf4pVpR1H82P4EDp37EYm
 G8uNefRMT/n2mEvXz4dUG4WNHHKu+RY4bC1JVGODfDV7IPKw6HnrSp0cC1bcdNxuwH0EweIQtQn
 F6LlS/TlCJCdcA1N5hB6kjTDoagsMBFS+Vv1Fgtr3RXwPmQlkvwmoj6db4n03ObHxkg==
X-Gm-Gg: Acq92OH+PfaSyd7Von4jZZNMnIqAyhUKwZ5sYb/CCr9aGRll8bx/dPn7hcgrs4DC/h7
 rPuCyad4iEd0fE2vHnh1mpMXHmJE2A5AqMruqYbb9XCUJPyEYszXTjeSaAZBxOaU8cG+z8cZVye
 MRTff1veNqC+4m3KDo8SiS3KADK786rzQY9wsxFkDto6ejasYeOyVd5T/f86Yg0qEiV38F3H6S7
 w6qVARO9WSLvvafQFokea7CQnAITmm+mksgfdgzI3WO8DAALK1FNTgCbueMoGGTTxaslgA8hxqK
 8LB9ntnKL1yBoRBhtGvqTwlaNXbkaQckd8EPv4+obEfHHwLuVeEyJ6fxFb0i9JZYctwkok3Vll0
 hvFRDnAT7K738y6sR0ku0eRhPnsdjQn6D6BKb4InUT1DHWZt8JkPBnqI5GTE7wD8LVjccqmsqBl
 5t+r98
X-Received: by 2002:a05:7300:72c1:b0:304:d82f:c2da with SMTP id
 5a478bee46e88-308047cfd83mr1066046eec.8.1781155979859; 
 Wed, 10 Jun 2026 22:32:59 -0700 (PDT)
X-Received: by 2002:a05:7300:72c1:b0:304:d82f:c2da with SMTP id
 5a478bee46e88-308047cfd83mr1066021eec.8.1781155979334; 
 Wed, 10 Jun 2026 22:32:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:32:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement {c,}swi helpers
Date: Wed, 10 Jun 2026 22:32:22 -0700
Message-Id: <20260611053249.3918491-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Tv-3jqJHZ-AoHajH6wRQW4QbykH4ychr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX1UepBxX/NPVf
 krlzqYx4mHRdJUMphdlBk58q2UAunnIjFnOJAi6vLwknYm07RCvlEOuuWvc/HlmaH9fbgJrxRMD
 GeygPpZf6C/psVuh3uGjC+TULYvFqxjiLSETfYwr0+Uxo4aKXC+oRBCbc0xXpFJr6PlSIMeAH3F
 IcSefX3cmo9+mtzSoMSMBXZtgQYnOhWZblJ0haiZd/dJSt8RWYL32RlaL2wJrH8TE5YzEu8LgMY
 OnAJ0ImVgyMDAjgV+DErdvJoHGs7khEc5G6M3e5CKytoJBHPDOLXx6+Jl1pYaMxWQxHUEUONBZm
 R8AyyVPKOW/JoH2/EAfw2a8KAJ5bd/UMC1jWY2YnGdr7DJhnUmlpEAhoaKkO1clMh+YEYtWTICf
 raciug2pXzjDyR29xtvhhLDTwYGZOGNkLDlVPcIvXlQFkp4TS+7bUSmHyB092GJEYIlRKNFSEOY
 xrh0f0xOcxZQt6TSfIQ==
X-Proofpoint-GUID: Tv-3jqJHZ-AoHajH6wRQW4QbykH4ychr
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a488c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX3fwbPzHopM87
 cRTVBjnkL64bp3waZKq6U55by0R7fKpzPIhfOb1lT3dcOLwtrUvsh6XFBn5AQgQ6HIFp/dwxDAc
 njfjaYjYc/HbBypx473vdT2oRrhnqRU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
NzA2Y2IwYTVkOWYuLmU1MGI3NzBkNjk1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjMsNiArMjMsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzUsNiArMzYsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MiwxMiArMTQwNCwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

