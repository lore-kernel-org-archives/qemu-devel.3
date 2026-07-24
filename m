Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245FFC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm6-0002Lq-7R; Fri, 24 Jul 2026 14:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKld-0002Da-HU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlb-0000vd-Ad
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqXBG3779957
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fy5Rl6UqlrkaAsTuuam9rDEv2PscbyG19W04DCQdT7o=; b=jB2fq7QdX+PoEs24
 XIPobkeQm/pB+r851tMvuvn1J5AFpoVczof6isJ+qZ5XQr+Ye3jcRUE6Whyl/jcx
 RR6Q5/G7hif4peRr6PrzJYTU8b62gFzVie0vTcg9HivWPrHznwBYO3Fmhy+bKgNE
 ocj6PTZD9Jo/A6uZ3AousQHycpPYagVO05MQd5EfFxSkaglUcrl3fD76Izn0t2rA
 p1sKm9V7LorK/lqVPvR/z3S5rL/eW7h7zc6IQBiJn7M/L+oSBqo/Nr/cm1iQwsAL
 sGJcP2BLKFVybJgIYoMSVuvNOwLYaYnisZlXjV8X13St7/TUeNqoTa+7LRhB0lS3
 169S5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5byt0uu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso907371a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918220; x=1785523020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fy5Rl6UqlrkaAsTuuam9rDEv2PscbyG19W04DCQdT7o=;
 b=e7T72F+vCYWstxBwiO5wj75peerGaGVQRh/IyqGb4yG4DJEBHszG5ZjE2zEqgsSowj
 MjHlaMdqvKd+Ow+tPmzgYpIRuyQmgnC+WYYl0hi7f9OsD0KyagL7AS4TiLfCUV3uv3xQ
 x3hxUr0Cwce4Qwz18j3r9gdEaFxjpuQKnHXI+rF/p696KYL3mmvFz/BU7MKhK4dAslKl
 XDDsc8P/5R5skpX2QqyaChcpW9g7rerEqNgQO95YHvsUXN45sh2wX6SaJAy3SNsHvnVp
 xSyxyjQyr7BCMqlu0PZkLbc5ksaHK6hfu1UGIAF562GIc+FObSqK+sBHjHwvNkhQ8Wyh
 r+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918220; x=1785523020;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fy5Rl6UqlrkaAsTuuam9rDEv2PscbyG19W04DCQdT7o=;
 b=dgZyt1z5zVWb55l/k6jDRQNMTWY8E54jpTs1Jem+JGAPv6FT1amrEN3N9k6ciywkbl
 q0ooLJBcyi2UL05qr4RbDESaE95oBvksa5VW1EH2Y3hBO/6eGlAlADpaS3kbI5WCGzkc
 BK8y6tOPpHABDMQsJiTIVeXsrkq0RtqhK7YLfuLFIoQL5J11H/mbGH4qM2j3TcH+40yR
 rqbJHoBySIhcURfBFk+ZyFvjjcK4HTzyC+W4s6cMwe0TQOrWRQgFCGPJgiM9hDX+kKNT
 +YhTUhx0+RPkc6U7p0Na5/lGEwJFJ7VKNRXZsOWtNEVQ1s+4x73wNGYsGzhHnV9v8SJj
 mqow==
X-Gm-Message-State: AOJu0YwiLr3EC0L78cc+B9LInwW2k36zwQxZrHi/0/wzN4jEoej/v4mD
 VRlAhm2lYghpR67oLCHnrI/3gHoxmeE58oivJH9gaJTtszlrX51ekf7kPBMicFs6YmsKqtpo9mO
 cBg+kLro3UMPmvo1kA1gYfa4x8kuE2iEOVKCn/HPCmvkpakv19GQcnKw3bZoJsATpsA==
X-Gm-Gg: AR+sD12Ndg96A0wUbktktfPOKG0yAKYPYxvOZUfiBsicIBHgsyZLhFcifKNDtAucFZ2
 24+GesCXQBxIZTCs1x0xdp6XVSrnSKPlj9Awppb17LHn6DewsJhA44JBIQHGSQK2f3yL5LOxFv4
 rWGhq0l8yQqS7ZJ783IT+O52cQMw+gPPS98GtYPjHhh285CB9cLw0calf7NLmW5wausnv5Orj7D
 QcoS5667QT8wghjc4e8L3MBdanMZ8Hlb6OyVJsigbk4KPktfdP8ccT+OpIcdJeVxXiW9UyDxZRZ
 jh1cdPlOsrW8/FEa6mjsK/MzhqgvM58N1SRbJCJDA5ELMyHZeD78vco2DyL9pxCziLCyDTmjyyh
 UH+uO83NR1e63qp8CoxeFH7Er3iXPM+r5vAiy8T3Snsx/0wyR
X-Received: by 2002:a17:90b:586c:b0:38e:7446:d2b8 with SMTP id
 98e67ed59e1d1-38ec6890685mr9207447a91.41.1784918220336; 
 Fri, 24 Jul 2026 11:37:00 -0700 (PDT)
X-Received: by 2002:a17:90b:586c:b0:38e:7446:d2b8 with SMTP id
 98e67ed59e1d1-38ec6890685mr9207411a91.41.1784918219921; 
 Fri, 24 Jul 2026 11:36:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:36:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 07/14] hw/hexagon/virt: add l2vic interrupt-controller and
 virtio-mmio FDT nodes
Date: Fri, 24 Jul 2026 11:36:41 -0700
Message-Id: <20260724183648.190531-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7V0RK1UsoVMVzupr61cVYgwzwQG273jQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX36Fzw14FdAXr
 sIUiFAz7mWlJ99XZ3GJ1qaYrXr0CoGPz3OmFVhZaZ2inCipZqkW4HS0RH506EsDUEVwVofM3Dod
 BeORjZZt/TAUKsmE0AzmzK1xqLGqvok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX1RQBQ5K/x5B1
 h+lElw/nb49M0X6icB/jMJB6MPB6ZoH4++xpkBkrdpYH3ItaYhMIr+07dgtfzyvmtg+tC2oDCmw
 eq3o44SaxmjXO4oqJJNZIhbPTmo0Vcou1hlDr8xTe5xbKeW+lEpXaEQJ6M18gPZLuwJFGyrY4CU
 Ms2oceqaRJgBBe3x03fS1KBZSSBDZepks5kbKwesIT8uXDsfCuF2VDqn6HW4MIxvWwk10fNUxd9
 oerzLARNFJK4Qgg8xxC1sBr+T16Y49bR+IKY0PtHGyO3bnj3+DsbU1+NbKaFAshkF6ahRL2fMrr
 vZ8vXyu/VGCjpp+PAj0h/10S4IwDj8SqG9VgbJ8VifvBYBHplrvPPtnbtE2YBbi0ddLY1C4jSFU
 b+cyoXKsRkifcMYKporlICZeM0CLkXNDSDNL+IQdKEePGj87EK2KODtTSmXzwHIHeGkjujRjdSG
 5xIeM8OvMBY+jum6rrA==
X-Proofpoint-GUID: 7V0RK1UsoVMVzupr61cVYgwzwQG273jQ
X-Authority-Analysis: v=2.4 cv=GMA41ONK c=1 sm=1 tr=0 ts=6a63b0cd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0mVyZMUypDDgmi1OqxwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240167
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

RXhwb3NlIGwydmljIGFzIGEgZGV2aWNlLXRyZWUgaW50ZXJydXB0LWNvbnRyb2xsZXIgbm9kZSBh
bmQgcmVmZXJlbmNlCml0IHZpYSBpbnRlcnJ1cHQtcGFyZW50LCBzbyBndWVzdCBrZXJuZWxzIGNh
biBkaXNjb3ZlciB0aGUgdmlydGlvLW1taW8KdHJhbnNwb3J0cy4KClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL3Zp
cnQuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXggNDZmZjA2ODc1
MjguLjc4ZTcxZDNiZDY1IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYworKysgYi9ody9o
ZXhhZ29uL3ZpcnQuYwpAQCAtNzYsNiArNzYsMzAgQEAgc3RhdGljIHZvaWQgY3JlYXRlX2ZkdChI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgIHFlbXVfZmR0X3NldHByb3AoZmR0LCAi
L2Nob3NlbiIsICJybmctc2VlZCIsIHJuZ19zZWVkLCBzaXplb2Yocm5nX3NlZWQpKTsKIH0KIAor
c3RhdGljIGludDMyX3QgZmR0X2FkZF9sMnZpYyhIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1z
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNo
aW5lX2NvbmZpZyAqbV9jZmcpCit7CisgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUodm1z
KTsKKyAgICBpbnQzMl90IGwydmljX3BoYW5kbGUgPSBxZW11X2ZkdF9hbGxvY19waGFuZGxlKG1z
LT5mZHQpOworICAgIGNoYXIgKm5vZGVuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIvc29jL2ludGVy
cnVwdC1jb250cm9sbGVyQCV4IiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtX2NmZy0+bDJ2aWNfYmFzZSk7CisgICAgY29uc3QgY2hhciBjb21wYXRbXSA9ICJxY29tLGgy
LXBpY1wwaHZtLXBpYyI7CisKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgIi9z
b2MiLCAiaW50ZXJydXB0LXBhcmVudCIsIGwydmljX3BoYW5kbGUpOworCisgICAgcWVtdV9mZHRf
YWRkX3N1Ym5vZGUobXMtPmZkdCwgbm9kZW5hbWUpOworICAgIHFlbXVfZmR0X3NldHByb3BfY2Vs
bChtcy0+ZmR0LCBub2RlbmFtZSwgIiNhZGRyZXNzLWNlbGxzIiwgMHgwKTsKKyAgICBxZW11X2Zk
dF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICIjaW50ZXJydXB0LWNlbGxzIiwgMHgx
KTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiY29tcGF0aWJsZSIs
IGNvbXBhdCwgc2l6ZW9mKGNvbXBhdCkpOworICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMt
PmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgbV9j
ZmctPmwydmljX2Jhc2UsIG1fY2ZnLT5sMnZpY19zaXplKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9w
KG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0LWNvbnRyb2xsZXIiLCBOVUxMLCAwKTsKKyAg
ICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICJwaGFuZGxlIiwgbDJ2
aWNfcGhhbmRsZSk7CisKKyAgICBnX2ZyZWUobm9kZW5hbWUpOworICAgIHJldHVybiBsMnZpY19w
aGFuZGxlOworfQorCiBzdGF0aWMgdm9pZCBmZHRfYWRkX2h2eChIZXhhZ29uVmlydE1hY2hpbmVT
dGF0ZSAqdm1zLAogICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGhleGFnb25f
bWFjaGluZV9jb25maWcgKm1fY2ZnKQogewpAQCAtMTc2LDEzICsyMDAsMTYgQEAgc3RhdGljIHZv
aWQgZmR0X2FkZF9jcHVfbm9kZXMoY29uc3QgSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcykK
ICAgICB9CiB9CiAKLXN0YXRpYyB2b2lkIGNyZWF0ZV92aXJ0aW9fZGV2aWNlcyhjb25zdCBIZXhh
Z29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQorc3RhdGljIHZvaWQgY3JlYXRlX3ZpcnRpb19kZXZp
Y2VzKGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50MzJfdCBsMnZpY19waGFuZGxlKQogeworICAgIE1hY2hpbmVT
dGF0ZSAqbXMgPSBNQUNISU5FKHZtcyk7CiAgICAgaHdhZGRyIHNpemUgPSBiYXNlX21lbW1hcFtW
SVJUX01NSU9dLnNpemU7CiAKICAgICBmb3IgKGludCBpID0gMDsgaSA8IFZJUlRJT19ERVZfQ09V
TlQ7IGkrKykgewogICAgICAgICBpbnQgaXJxID0gVklSVElPX0lSUV9CQVNFICsgaTsKICAgICAg
ICAgaHdhZGRyIGJhc2UgPSBiYXNlX21lbW1hcFtWSVJUX01NSU9dLmJhc2UgKyBpICogc2l6ZTsK
KyAgICAgICAgY2hhciAqbm9kZW5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvdmlydGlvX21t
aW9AJSIgUFJJeDY0LCBiYXNlKTsKICAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9IHFkZXZfbmV3
KCJ2aXJ0aW8tbW1pbyIpOwogICAgICAgICBTeXNCdXNEZXZpY2UgKnMgPSBTWVNfQlVTX0RFVklD
RShkZXYpOwogCkBAIC0xOTIsNiArMjE5LDE2IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV92aXJ0aW9f
ZGV2aWNlcyhjb25zdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgICAgICBzeXNi
dXNfbW1pb19tYXAocywgMCwgYmFzZSk7CiAgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShzLCAw
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbih2bXMtPnBhcmVu
dF9vYmoubDJ2aWMsIGlycSkpOworCisgICAgICAgIHFlbXVfZmR0X2FkZF9zdWJub2RlKG1zLT5m
ZHQsIG5vZGVuYW1lKTsKKyAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcobXMtPmZkdCwg
bm9kZW5hbWUsICJjb21wYXRpYmxlIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
InZpcnRpbyxtbWlvIik7CisgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwg
bm9kZW5hbWUsICJyZWciLCAwLCBiYXNlLCBzaXplKTsKKyAgICAgICAgcWVtdV9mZHRfc2V0cHJv
cF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0cyIsIGlycSk7CisgICAgICAgIHFl
bXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgImludGVycnVwdC1wYXJlbnQi
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbDJ2aWNfcGhhbmRsZSk7CisKKyAgICAg
ICAgZ19mcmVlKG5vZGVuYW1lKTsKICAgICB9CiB9CiAKQEAgLTI1OCw2ICsyOTUsNyBAQCBzdGF0
aWMgdm9pZCB2aXJ0X2luaXQoTWFjaGluZVN0YXRlICptcykKICAgICBIZXhhZ29uVmlydE1hY2hp
bmVTdGF0ZSAqdm1zID0gSEVYQUdPTl9WSVJUX01BQ0hJTkUobXMpOwogICAgIGNvbnN0IHN0cnVj
dCBoZXhhZ29uX21hY2hpbmVfY29uZmlnICptX2NmZyA9ICZ2NjhuXzEwMjQ7CiAgICAgaW50MzJf
dCBjbGtfcGhhbmRsZTsKKyAgICBpbnQzMl90IGwydmljX3BoYW5kbGU7CiAKICAgICBxZW11X2Zk
dF9zZXRwcm9wX3N0cmluZyhtcy0+ZmR0LCAiL2Nob3NlbiIsICJib290YXJncyIsIG1zLT5rZXJu
ZWxfY21kbGluZSk7CiAKQEAgLTI3OCw3ICszMTYsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0X2luaXQo
TWFjaGluZVN0YXRlICptcykKIAogICAgIGZkdF9hZGRfaHZ4KHZtcywgbV9jZmcpOwogCi0gICAg
Y3JlYXRlX3ZpcnRpb19kZXZpY2VzKHZtcyk7CisgICAgbDJ2aWNfcGhhbmRsZSA9IGZkdF9hZGRf
bDJ2aWModm1zLCBtX2NmZyk7CisgICAgY3JlYXRlX3ZpcnRpb19kZXZpY2VzKHZtcywgbDJ2aWNf
cGhhbmRsZSk7CiAKICAgICBmb3IgKGludCBpID0gMDsgaSA8IG1zLT5zbXAuY3B1czsgaSsrKSB7
CiAgICAgICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKG9iamVjdF9uZXcobXMtPmNw
dV90eXBlKSk7Ci0tIAoyLjM0LjEKCg==

