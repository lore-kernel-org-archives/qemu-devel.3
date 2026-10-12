Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9067CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7V9-0003Ek-40; Mon, 12 Oct 2026 00:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UY-0001zy-0T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UU-0001D3-1w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1leUW3646992
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dEhhuxt4NM4PmwW0OOrSxZGKArlpV7cIeI0IvZpRyCc=; b=QYeI3MmRm7sWPBlO
 vTvUGCzk2jyGIEvz+BGk2eqpsAiRQbEMr+LsGm1kJhzH3PALanK/n3BxPNZSCSaR
 3wt5RMzJu+rIbhYHJCua3NhxtTjHcGItyMMo5F22IkukxLxFEKhaPiD3ixJlKGew
 9t2UapqYcAUvBk84re0U9B62P7DwHUPpLLPM0YU5Jw9iTlWKV781lsdhJ6eJmgrG
 7hg9w/KQYcM+Mp4r1YsEqfsAFXAdg3DVIoBwk4T92yOQGVUvLi68traHmV8rB76x
 X2VH9lgRFUuXDdWZLNMZbo8zLa2oDo2DpOVSOaM9Z269sS5wRYp0ORc8/aZFxFiK
 Euj/YA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjmhuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so4701209eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778689; x=1792383489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dEhhuxt4NM4PmwW0OOrSxZGKArlpV7cIeI0IvZpRyCc=;
 b=fesMmFZakTm/WnxpHHbPVlqsS2GCN2P00lo3493A7Bo1n1w7vjZnpeeDnzxCgDAYIo
 SiF/VHaPL4/cq0EGBVSEjd0XcbY4ImWtXUIPIehZEVB40fIToJFReaoUhHnNz43dCM7M
 yCGMe+9UP4w0DoYSfNdd70O1MCtq/QxdCiJA3c8zBglemKLM2Y7yBiODjI8xxfP1gYzs
 mQt9tGnK+TG0S7Ki4EiO/zgjTmFfRja40eIoRbfTe06Gfl0LbMCuV+QusJqar93tSExj
 HLM5+Mvgy/R7tiPKCTj3Y3p/QOmz5dSwFrsJGa6sp8PDV11iiXRbynZj1y5ZgEWmgYUP
 TNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778689; x=1792383489;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dEhhuxt4NM4PmwW0OOrSxZGKArlpV7cIeI0IvZpRyCc=;
 b=iHhM62itW23CBel6mBP4zdeGLZbfDQZY3hMu2axyKrJZZlVSGGDCVImGfEPboE0O+8
 ygW3O8RNJWZ1cpXqwO2tdnkadGk8KLtQB6oCg6hOOyaSlK2+rIPyFM0sruolKzJRF4d2
 0keVxlkbUW5/i+DFsOy4VCbl4fXGv0lmH6G7yrS7JMWks7iiYRpy5YOUDtUR8mP+/8fT
 0vrSMy4mjt7hnPjL3wfHMQ7MNoX8vM6UsJMjX/7+9otf1NGUOYF5L+Lapj4KruGBlceH
 RaNzNDUI3/fRxg9ux14arApI1G7b4u9X67PnOXixBuBgXp+bBN0aR0dTt/roZA40gzAA
 GBTg==
X-Gm-Message-State: AFq9FYJIifhE9XxQ5noKsNA8IOgmwzPdp4fCC6Fh5+lmFHvb7NuiTOcW
 BLwUYsnwB7PAbty8mZbuxxF0dfcibuhTuyRTnX3T+DEHd8isg0QVB3qOr17fOI3yKlOIsfB8ExN
 rlx+Y/0WvqEnp3x4R71GMvjOS4EqgprQC/NfqCiJayFBtl9bxhmdiNd8c5tRpzkLy1w==
X-Gm-Gg: AYBFou180xXey93MFkvK488B/fWhvJtW+U16D4IUtMOmHANo3ekVcaH99nXYxNSK/hh
 kns/VRWVsgZFrjV18HW55dp1fRyZ9/hFSjSiIYlWYrtMp7peZwyWO7ENZpi1rWU2Emtgn6MHcBd
 M2Hd5UcoZ4oXeX696DqWbUVpTvHLFlzSMUJq7EVVhgEP9PuuPP1rFQtKMGmz4lk0hwy8J5kOS47
 Gn9cySwcEWS5CZJA0psKYMa4b9++4UR88NezzXb7x5BfnFYcgHdrod40UP06OYzDGl/VsY3ThY8
 Jpx3iOhnx97GMSL0N5hlwo+lkmDvW2MhEnWdJ1WXCk4BHlyTYPtTnle2bx4vVExFMRr9YwKMzx0
 gIY61ZKwBHPooC4QXhHChJGa4kWv+SoiWzIZT+Vur1aaEFck=
X-Received: by 2002:a05:693c:88c9:20b0:34c:79d4:ba0d with SMTP id
 5a478bee46e88-3537dffd5b2mr13499373eec.14.1791778688737; 
 Sun, 11 Oct 2026 21:18:08 -0700 (PDT)
X-Received: by 2002:a05:693c:88c9:20b0:34c:79d4:ba0d with SMTP id
 5a478bee46e88-3537dffd5b2mr13499344eec.14.1791778688146; 
 Sun, 11 Oct 2026 21:18:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:18:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 25/25] target/hexagon: implement nmi
Date: Sun, 11 Oct 2026 21:17:22 -0700
Message-Id: <20261012041722.1159355-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX0/v9Tf9PM4HX
 rZW9mEFpdJSNaTBOwqe94Oo7+7RoOnBj6QGEtR+My3cEvKU4d9b47yBTPr6O+ibZ6sMXV9gc+PA
 rw0qq/vqym0G7geUW6ct0hCmZmMTXzpU9FXJPpee3JGemp8g8n4CRhFhBYeFCrUveLJEi36Pr8M
 pUqckIknegHK+oBayoTXc7W0bebo13eCHq7aUkYyjTsKItJLv5qyGQeDwxDDpXAUu8/oom/0Ucd
 5CuL+C5u83xU58K3Tipyo8fdAuz+znQoye3IGGQS+fPVw5gvhIyok+n/0E+KDU989V/q2HaevvJ
 S7y05wuzVX6+5GYxZ+89IyPzFzkPMcdGWoM7alTXj+c1s6PJgTWy1QCKJrik0ttYBAVtt96+5QG
 WWcAI8FehYfOFvx0uZ4INvW6/P8dTIUADpINC+mlxxyiJesAVukXlbO9+zCJtbkE4lkFfkhIIKy
 +iJJeZqA7DwDrDfELkw==
X-Proofpoint-ORIG-GUID: MlH4VnXa9CzEw9K90oQsEEHPGSzDQ58M
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acc5f81 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=AJ2bX_oiER2d6UdsYA0A:9 a=moDVMSTfssfMrl6B:21
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: MlH4VnXa9CzEw9K90oQsEEHPGSzDQ58M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX2O2Big6p9yHn
 7vIskfmX2YuhrCZD/Q7fvEIZc1vw2/qg7Ibp84lG/6rVAbsu2TgEMgqCsMG2yEWNolMJm5MK63I
 wuyVE1XVLVCjQupirnK+Qa9RB4h6YiY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120016
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

WTRfbm1pIHdhcyBhIG5vLW9wLCBsZXQncyBmaWxsIGluIHRoZSBtaXNzaW5nIGltcGxlbWVudGF0
aW9uLgoKV2UnbGwgcmFpc2UgQ1BVX0lOVEVSUlVQVF9OTUkgb24gZWFjaCBydW5uaW5nIHRocmVh
ZCBpbiB0aGUgbWFzay4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFu
LmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAg
fCAgMSArCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggfCAgMSArCiB0YXJnZXQvaGV4YWdv
bi9zeXNfbWFjcm9zLmggfCAgMyArLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICB8IDEx
ICsrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxNyArKysrKysrKysr
KysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1
LmgKaW5kZXggMTg4YTkxZTg4MjMuLjY1ZmQyYjI5ODMwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTksNiArNTksNyBAQCB0
eXBlZGVmIHN0cnVjdCBIZXhhZ29uSFZYQ29udGV4dFN0YXRlIEhleGFnb25IVlhDb250ZXh0U3Rh
dGU7CiAjZGVmaW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lOVEVSUlVQVF9UR1RfSU5U
XzAKICNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sgQ1BVX0lOVEVSUlVQVF9UR1RfSU5U
XzEKICNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLIENQVV9JTlRFUlJVUFRfVEdUX0lO
VF8yCisjZGVmaW5lIENQVV9JTlRFUlJVUFRfTk1JIENQVV9JTlRFUlJVUFRfVEdUX0VYVF8wCiAK
ICNkZWZpbmUgSEVYX0NQVV9NT0RFX1VTRVIgICAgMQogI2RlZmluZSBIRVhfQ1BVX01PREVfR1VF
U1QgICAyCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90YXJnZXQv
aGV4YWdvbi9jcHVfaGVscGVyLmgKaW5kZXggYWZiNGRmNTlmODAuLjk1YThmNjU4N2I2IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5oCkBAIC0yMiw2ICsyMiw3IEBAIHZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhl
eGFnb25TdGF0ZSAqZW52KTsKIHZvaWQgaGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCBjYXVzZSk7CiB2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzayk7CiB2b2lkIGhleGFnb25fc3RvcF90
aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYpOwordm9pZCBoZXhhZ29uX25taShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgdGhyZWFkX21hc2spOwogdm9pZCBoZXhhZ29uX3Jlc3VtZV90
aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhl
eGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogdWludDMy
X3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52
KTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhh
Z29uL3N5c19tYWNyb3MuaAppbmRleCA3MjE3OWQ0OWFiMy4uMmU0Y2RhMjllNjEgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNf
bWFjcm9zLmgKQEAgLTI1Myw3ICsyNTMsNiBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAo
aGV4YWdvbl90bGJfZ2V0X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKLS8q
IE5NSSByb3V0aW5nIG5vdCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBu
b3cgKi8KLSNkZWZpbmUgZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorI2Rl
ZmluZSBmRE9fTk1JKFRIUkVBRF9NQVNLKSBoZXhhZ29uX25taShlbnYsIFRIUkVBRF9NQVNLKQog
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKaW5kZXggNWFlMjAyNmViMmQuLjY1NTBlN2ZhODAwIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzkzLDcgKzM5
Myw4IEBAIHN0YXRpYyBib29sIGhleGFnb25fY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykKIAog
ICAgIHJldHVybiBoZXhhZ29uX3RocmVhZF9pc19lbmFibGVkKGVudikgJiYKICAgICAgICAgKGNz
LT5pbnRlcnJ1cHRfcmVxdWVzdCAmIChDUFVfSU5URVJSVVBUX0hBUkQgfCBDUFVfSU5URVJSVVBU
X1NXSQotICAgICAgICAgICAgfCBDUFVfSU5URVJSVVBUX0swX1VOTE9DSyB8IENQVV9JTlRFUlJV
UFRfVExCX1VOTE9DSykpOworICAgICAgICAgICAgfCBDUFVfSU5URVJSVVBUX0swX1VOTE9DSyB8
IENQVV9JTlRFUlJVUFRfVExCX1VOTE9DSworICAgICAgICAgICAgfCBDUFVfSU5URVJSVVBUX05N
SSkpOwogfQogI2VuZGlmCiAKQEAgLTc1OSw2ICs3NjAsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBTeXNlbXVDUFVPcHMgaGV4YWdvbl9zeXNlbXVfb3BzID0gewogc3RhdGljIGJvb2wgaGV4YWdv
bl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVlc3Qp
CiB7CiAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKyAgICBpZiAoaW50
ZXJydXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX05NSSkgeworICAgICAgICBjcHVfcmVzZXRf
aW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX05NSSk7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBm
YWxzZTsKKyAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhFWF9FVkVOVF9JTVBSRUNJU0U7
CisgICAgICAgIGVudi0+Y2F1c2VfY29kZSA9IEhFWF9DQVVTRV9JTVBSRUNJU0VfTk1JOworICAg
ICAgICBoZXhhZ29uX2NwdV9kb19pbnRlcnJ1cHQoY3MpOworICAgICAgICByZXR1cm4gdHJ1ZTsK
KyAgICB9CiAgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BVX0lOVEVSUlVQVF9UTEJfVU5M
T0NLKSB7CiAgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKICAgICAgICAgY3B1X3Jlc2V0X2lu
dGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRl
eCAwZjk5OWE0OGFjNy4uYzJmYzI3ZjFjMDIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTUzOSw2ICs1
MzksMjMgQEAgdm9pZCBoZXhhZ29uX3N0b3BfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52KQog
ICAgIH0KIH0KIAordm9pZCBoZXhhZ29uX25taShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdGhyZWFkX21hc2spCit7CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VB
UkQoKTsKKworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAq
dGhyZWFkID0gY3B1X2Vudihjcyk7CisKKyAgICAgICAgaWYgKCEodGhyZWFkX21hc2sgJiAoMXUg
PDwgdGhyZWFkLT50aHJlYWRJZCkpIHx8CisgICAgICAgICAgICBnZXRfZXhlX21vZGUodGhyZWFk
KSA9PSBIRVhfRVhFX01PREVfT0ZGKSB7CisgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAg
fQorICAgICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX05NSSk7CisgICAgfQor
fQorCiBzdGF0aWMgaW50IHN5c19pbl9tb25pdG9yX21vZGVfc3NyKHVpbnQzMl90IHNzcikKIHsK
ICAgICBpZiAoKEdFVF9TU1JfRklFTEQoU1NSX0VYLCBzc3IpICE9IDApIHx8Ci0tIAoyLjM0LjEK
Cg==

