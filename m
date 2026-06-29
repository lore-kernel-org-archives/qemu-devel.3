Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78989C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIa-0004gu-9g; Mon, 29 Jun 2026 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHe-0003jB-Ij
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHc-0006GW-86
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEs02579129
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=; b=MvTTOfRSBvJSkWjk
 AZb6cWhwaA9hIC3aMs8YSf79suZ/k+l2JxZgkNP0IVxuwzAdZ5drm0lF7HnmVBH8
 B36cC4ulk4gay5hH5zSNvmFsvFJMieqzqFJrQyshyzEfEiq74SndMKZ0EUyuawjZ
 sM2jvotGrcoG8kijxgvxkpApVDpyZwzRoka54qkkHH+9StjXDuHjGzbJ6tBXf1+v
 ltzN0Q8PcZCKBDAqZwDSUvOQA2v1AOKD8u5y0ekEi6lpvLpk7UQkpxLvvG/cZerx
 DmQmavfq6J3I1gUBItwswRnMBHtWcKPIEB4BqwXv4mueFzwoN5yMKfbWZjKVyWSZ
 W4teTw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hkt9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9b71388fbso28491805ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740648; x=1783345448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=PnIClXN3SbNyF6KF2QPLlLI87hwWBUWk97ktVQvyOlssNEXwCh0hoAzV9xBx8Tv5Ny
 YkltMhKUgifZg30HkalV5LlA4aygyVV5EL4NmyeYMcr47EuXHnxdchwBPycZSlXcZcbq
 yuBdse1StDeLAnmT8H6CzuxMnQ52hR0T1HkGSRrAIT9CwUTM+ckWRep96AM8UTNUGLEu
 MucVTjvA3FhqHTjfCB4kVb0qcIJuaRQVgwUBMtkR8id/wurXR889xIFsMI9N2i2LJg9n
 l4ijB+aU3HDgU4qJ5aUtMQOB7wRG0NqB747sVCDnYvGEZfyka+4+PjipJDRykRn2VDLy
 2VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740648; x=1783345448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=hZE+CYAhoIgOxTQgITVt+AtMGU69qwoV26Y1HSUCi//PguLxvDBLQfxC8ZBFA6v8Rw
 EVq48Z+xmLXIDkovAmwAjU9+dagCALpG+vLzZsZklGuu0ozeFjxqY0eWwNfQHkagjxQo
 MX7uVe1AHkJO2QdAlUHCLHEb8lE0pfd0rmtKFr/kZ9xsyg6Vx0KS+3JBvdR9tmVmFVjc
 2ied6nPDnV7PKFDE1AW+phr8+FkrRV8BGXFYHUcMN/UkmIXHruNQyuIFGGle/3avyv8i
 QZk7gtimXuYbeIrZN8b2keiPlF4r66Eb4Bklreukjz18Zwp8xQsCna4G2P8XzZlr5UeZ
 TXiw==
X-Gm-Message-State: AOJu0YytV8vwnO544Dq6UODadg9K7gkKgWKFw/p+V16h/LOVcH+q73Lb
 Swe4ez2vhinCHo9GQ848yeGjWOi1kH6+mfhdyc2KPUowCOQpv+NeQ/nzWLNdn+vH26NYVBuxyh9
 OQw1xMB7fWjKKJSPlCLLkRbtTBAtzgqvOs0O0vSCf9RSXmRQC9LoW8ZpkTtvvViGWAQ==
X-Gm-Gg: AfdE7clUhtZOR0gUzgV6aa+bi5ihWS6fARywW5jK9R+DRW6cYTGc+ZcdcecONXJop3t
 4tjFQfXGdmOgOa7nHdT57NUsU1AqjC3j+QHyJBDSt5WpCWbCzIzumsA08WnzcC0cEVuqD67TSyD
 RJaBKwZP7VTnSMmdlhK/IQqeMMQ7g7kR+Ageq1lbWWBI4KgZNtXOCNpPI6F9WlrlzoFjFDZpVGr
 sL4aZH4h0DVPqXDLsakmEql1xzVnj6v8ZHf+2lYdKP5spGs3B+gsN8vUWvwqUCueqAmLxUBvgXQ
 UGzfw+j1H4V6UY2qs+idEQYMobV1UYeUiSgwfYtau1s4VR00vKn3K6uLDxLhhlcwQOBNmLM94pI
 o2vte6Rvvz571LM1jRYYNGFa6Eu/VEaQ3TVqWUdCRif4v+FXlO1KvTA+6W6Q=
X-Received: by 2002:a17:902:ccc9:b0:2c0:e5ee:f554 with SMTP id
 d9443c01a7336-2ca25dbd290mr3910555ad.8.1782740648241; 
 Mon, 29 Jun 2026 06:44:08 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2c0:e5ee:f554 with SMTP id
 d9443c01a7336-2ca25dbd290mr3910305ad.8.1782740647863; 
 Mon, 29 Jun 2026 06:44:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 57/77] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Mon, 29 Jun 2026 06:12:12 -0700
Message-Id: <20260629131232.2487780-58-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX9sVx+ZWep14f
 jWux2OdKf/j0w8uUYp2/OP8JvIUjNzWge/3vhin45Rn06jkWWSAEygnnZlFATa1GEenGOwnrKK0
 a0oh3vEztcpyYihv1TqN3FGr5qE9SyU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXyMqnEJRW3vau
 M9V7O4fxA2iGdY9moQM18OfJM6uWlWmujQd9wjUkesMFcRS+1tBizQj1c9UQ36vDIl2RA2Hw/k9
 /ai03vK1Ybs5CTFp58cXEh2Zr/T/jhtJErurDPSoJXo1OmzrMcC15zKTXpeMN8eT+61c8ebbJR1
 SAJBg51WGj2Lw3BT8aj9EsoSvSOzXA2yhmmbJiX+SjNEm33k2O7nP4P/QUVy3vd3uIwWqVubd4p
 Sd4DLy00obTtJzOcQ27aaRfsUCBflwBeyvnJpGDWN2nQsjLT4F7TkUYo4EfyGqKvlHh7NCfdWZn
 VQ2qszeQJLtsyHi8IOCq4zFNUPEKhI5QQhb6XGHhOFdEdL+x9TQyqTho03xdErq37+2/SPIWfrw
 3InswmicB+neSZU1zKjT5c3cNx+3C70MkM6Z9SNeShNlMQISnvQ/0X5RSOQLsS1fJXD6s5F1epX
 S4wvM52e+28UbhtdySA==
X-Proofpoint-ORIG-GUID: 9VlbXrJzODg5fSVM_9nUBvlGVCOMjmZt
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4276a8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9VlbXrJzODg5fSVM_9nUBvlGVCOMjmZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNjcwNjY4ODA4YTgu
LjNhZjkwZTMwYjBmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ3LDYgKzQ0NywzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

