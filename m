Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74751CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcku7-0000cb-98; Thu, 25 Jun 2026 10:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcku6-0000Qr-3C
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcku4-000096-6n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k9et1948004
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=IkOZGJLN0mCYWyyk
 210EhNYFqW6djWQUhii7mU/pAgMFHA37dbLcz00Ygjm5CJDdHWnDGlgqXEULHZQq
 +nGr/mhSM8gwTWEyJkNY9gV79jcOFOSgW/ypuukihuLMUhJS/QHiUM05cIDL3vN8
 FeFpQAO9SlUOH0nlHfaTmeJVk69fBbJTMcRD04Pa6tCt13XUZ5CnHLliE/tSRXg4
 y+IwV+XS9sgjQsDyBATL8iwF4a+h1ghb/6PyiKOI+INU0Vy9JIQhsA9s3KdG8I9o
 BSUPjEKQKutZMxSzIQ8xq0wY2mHsipBOH08TriVnFxcbFSq45NxXApiR6r3nS6lY
 MJY2FA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8spp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c17f62afdso925466eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397072; x=1783001872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=abls16APCXT/w9XJckMeh54Xuye26qtXEX7wA8qwQe7oVtds1bcXJD/qHqX4YeWWxy
 hL56VTI0a3Jc7E859PRN/qec+3RLwRNy0MJz52AAQAj85fRXVpfVj3Ic0rjG0Z1LZuBp
 n8qSwNUZUxY93c3NTPC/HzKeUOJiyklwfxB0YIXYXVn2wvozeqcBNGMH6SxMqXQLIcoY
 Ya8sp4NiATUh39u3OLw1BuqHZSvXI1fxv9bRhRCbqVnrhlXogQmINpJq6qfygNfYe/Ip
 8xyEk6WWg4GuzLjbchErKRwVUmEX03+11G1eRjARsEJ5wIiUMmweFE/5eJlb6ZeZbAxK
 YVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397072; x=1783001872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=tJK+BlZb7shHTbK0rhJp2CwRtitMsbkgqsUxlQR1yQ6D5Ak6QRV7y+mqHlUDFRlUsG
 /Fisuu3nroRHvH7cmHUb9koxGLeoSdOd8UYAvu2sH+Xr6DSZuT/i7CNEX3N1bIwgzTVu
 xmHV5XBn5IMK9bupzi88cWa83+FNTbaowxrKPAaB+R8htJ4yhJ5OZkf8IyZxSFBPvAky
 PsNtnEa2+j80XkkRxXvzwVj+CooC+2KzBa/OHo0fwK8WcK+/dDo6+jIrQtc6BeO+GiaI
 Q9+As4o8FuIcL/cKLCAmVjXmIFXke2f1QOkus8eSyKw51bFprBdZDzUK6u+F8YgTHlDM
 bJig==
X-Gm-Message-State: AOJu0YyJjzLkXhSHzOKUfgwZc7O4+YkZZBJAuf7Dy+j2mCQpZo9ljPdg
 TcrXMRMSgSuleHwGyuGWXUsVPUgwj03kfu30EtBx4yH6dZqw7bOBhVjr0WuxMGR2KWKFipBESgH
 edfnPMewMRAIouh06q5xl11+fbVEBu2pYqqsRbsPg26prWRsMWSKft6deap7LVymwDA==
X-Gm-Gg: AfdE7cmDWNL5P7c1wMnLI5SeUNR1y+9OhV4IpfLPDas+4aVRTO4N2UYzuSRY3WHg01h
 MCatJOnaWQjJmKVGK6Sj348AE5kRWkRa6UKkgGWocZn7Yp1jMFghvqjay6IXe5SM7PvDt03NJiy
 yw2G0ZVA7tf2Ozee5LMAykrlt5HBYx3Es4vUA9gFjBDSUAVHhwdacIThdr0zyCE0uXQphRq4ing
 hB6Y+MDxKbjy2yVHQ+2PY6MgTN1rWWmJdiatfMFFYW5GkLoxXbGe70+pIJ9A8Mit7ST0UrHx7UO
 JWtwFsvOG3mVrHKm0n9OlH7qnFdZFvVwJdMWA8Wl0A7ao0HQ6FxUl/JF3lYL8VE3r50Kkpbk0jK
 ba9bv3Ji3+VOXEtufopcjVIAp1HwMeXz4yAGoVn22g66gT2tnrRN5ZU/jsQU=
X-Received: by 2002:a05:7300:d407:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-30c55641f4dmr7067651eec.18.1782397072093; 
 Thu, 25 Jun 2026 07:17:52 -0700 (PDT)
X-Received: by 2002:a05:7300:d407:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-30c55641f4dmr7067626eec.18.1782397071492; 
 Thu, 25 Jun 2026 07:17:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 34/76] target/hexagon: Add pcycle setting functionality
Date: Thu, 25 Jun 2026 07:15:51 -0700
Message-Id: <20260625141633.449487-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX39wuuZY8qlXa
 o29rBjkamz4jlv/2wIXCmMyAvLrPJoOHv28aoVGtLfVGGTzNNlpuwfXCy8ZxFEWKr0oTyVvrgK7
 JMr3KQHwIm9RVEJAgZUrib5vhu6VKB0=
X-Proofpoint-GUID: _ChnQQlE_UKUjmieFhCLB-K-mXQpIeNy
X-Proofpoint-ORIG-GUID: _ChnQQlE_UKUjmieFhCLB-K-mXQpIeNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXw4c25k3tn1E4
 LFgfRucup/oW+B8iixI3AqEwkMfPEoprSe7DfQzFdF5li5zLmGh6cVV9oncF44lHpKvFCAm46ne
 HofUOfXAhmdgcgVzuvdW+dQGknFaU8/WF+4s8jiz3PpcJKaTpRplLQ9ziDyFUiGQz1RxXq5kjzz
 NW3ngBYxL7LtLif+d06CZU9awYE+pu/qv2yusjU2TzouopCBkWxKF/XmqfNZv4eSKbBzpl+fYCr
 hkeomrLyYs6DXg/cwOk87ApPBqZSwEU6zLHLZHeBA0HWY+uVQrIv5DBN/H1fY76RqQTskTrxePe
 zTr5Mf+gM5tE2ExJCyUZOZntOKvEVjxAqnRC0JUvXcGXL4ZqjQqrcBaZFRwkdZ3NCSAwEUtkWGT
 qMeVRSIMwYYQoq9dij2xsMFsTvcoGRJtoHuQt+DvWhW4OBg38S25YA1UNa/jNDjkrqJu1BA6I0D
 apCW8wjlziz4Xrty3iQ==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d3891 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250122
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

