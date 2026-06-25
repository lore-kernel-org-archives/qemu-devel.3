Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA78CCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNM-0002ax-5F; Thu, 25 Jun 2026 10:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNG-0002Zq-JR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNE-0008WL-Ld
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jspa2009328
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=; b=hOhPzXb9BLfRHMgc
 yYONpTRPwd0qCSODkfXUjz4B49EXPqEqqhaZ9chsQuayDgQpdmgalpQ85QpGNNMR
 tW2BPSGOKsmyvcLvafkaOdSvH2Ynwp6+dZfwH9rL1hsI7+NVKeUe7RbhD3alb2N0
 GAHBJ49uBKzBCMMFFyRXCtYAm94qsDMfOo0zTVOWbiBRUflPnK01J3f6edoT5GZ6
 j0reaT/JIs31OVBtaynDnvJSYtz2AMwmQ+2bfT5j9pZlM7E3nw/duJ+nzo1LYM15
 rgn5MmH1DdTYZ30NqquY21EAkcOheCVuE4beHuoikBWTeauWt0LHgDMfh55xzjFk
 DJtX/A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjqtn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c17bc96afso5086801eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398890; x=1783003690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=DuhrYuDO9vAYefE4E6u+LZhAJxTPOaCZ0zSJ+wOlB/i27Ill8213fiNvOjRguh+KdK
 lV2K29aX4WWFS2OE1/WEQB52P7UXJ9yolgMBTygyrziPdfoGycuWVYe3RJFvn123O1+G
 MraBTrwtGpRkWQwouVSSWw1kJD5thUJjhLjA+kc80Ahki5+0KbOxFnlZkh8hy7QRQn78
 oYG01CVG99B3QpykzQGMBQZmgAGdaXuSHj19z9wvJsuE6PI5A03Xuc5R8J7wIKEmP7uW
 ICYmM1Z4NWdAryx75X5gqXYok3LF29OB/tHdKxG6HqeaoLwnMwxbkT4/esgXjMcmEJmK
 7Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398890; x=1783003690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=X0LT3gWql8EINN3FM76Jla3HHXjedYtPhnQr84YJM2MEMS+8k2C01Ik9PpcnoqiLPn
 +giTUHeDA6PiTLcjWd1d4eNKIBgGbjwhhesYrfr3mUB9jvn4txsg+hN4iZNI978Ps22h
 7aAt06s8gyrVuodc9wEkVcSJ1JDUrdHWgjyq6FAgAtbsJAlCG8TOZPIUe5K1Avr1oRug
 xJtuCx5fSgOJs+BTy3yimGM0aHquAGtIjAMkk9l8MI72Kn9MA9EqC0XSJdFZ3cPimScD
 ST25+6uJUmfMkLjuelkFtD0LU32dOsBydKEt61YGJGOdEskjC/xpmXsvH5tcLRgH6QxZ
 s06g==
X-Gm-Message-State: AOJu0YwWW8jhchCtodUI57o8C/2rv1AkHttBe5Fp2DcCn5IQJQuBL2TW
 o758jGU1fg45VkKaP47CqlwwkiOuPmpx8ym5QwXUyHk1E6aLIbc5bHO577R232ekH3BsvFKln4a
 9wG0RAOGu5XUpWiuhnfO4cSAsJ/HWoForFq4/0JvNhAwIBhTQjffcgOoXA3vy1KP3tw==
X-Gm-Gg: AfdE7ck69Beb85k9mc52dzXcWMxnjQteXkL56abZaYUO6eu0GTBJ7uwUTEjTO0k1tU7
 NZ5gOb9LmiZP+e39yOZS1nrPT8Im2fPbiKRo4/m7vORITa4naypU1XDS1p6Sw0PTu5Od37+8Csd
 Y86NG+sDKZGMjyLlEEugvF2Cna42iBXUVJ/OpmO0vtI0wQnHSTr6dpTzxm5o4lGjNcvTwYo/r7+
 zypkSAU8tnU6drjeBpU44iBZZ4/901+jrg9PQDrmLW1JpdY/Gn43hc5IFtcyfJlQvRqPQIzf1ko
 3PsRIqbDDbJ3mzQRKJPy6/KpWot4WiLw2a/gF90rpbM7X21GDH7W8w3vqkeCtkhYM4Zb+ad/8r4
 omN2BtuhNg1oi/Brh0Rz8cPj+0TXpOw09IrbVd1m53nZOtURQu4ErYPjaVgM=
X-Received: by 2002:a05:7301:9f13:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-30c84b9dcc0mr3022206eec.8.1782398890406; 
 Thu, 25 Jun 2026 07:48:10 -0700 (PDT)
X-Received: by 2002:a05:7301:9f13:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-30c84b9dcc0mr3022179eec.8.1782398889871; 
 Thu, 25 Jun 2026 07:48:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 41/76] target/hexagon: Implement iassign{r,w} helpers
Date: Thu, 25 Jun 2026 07:15:58 -0700
Message-Id: <20260625141633.449487-42-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d3fab cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfX/z/Xzqfv+VKy
 9V9197mlASKTgsCVGHYp+n9SiK4FyaxqVnqrDDdA0/ZGb28IWwqQPUWO9fobiHE6d04ooNDBRXz
 ZqlHNKtbl2Qlo+p8GGAMLbRdXQnMuXbe4k7p7alY/II6XFkzxzWsSsvF8ZNFOB3SqWDkFsfHQuP
 w3sZBaaN7t6FASymDuxv3LqVldzSoK/LeUraG13tfpPhDVGWbLFJtpeIrFhbtiOSozosxh25tX6
 SjZuuwaA2Neo6NgnO7jQCpeabetfI7KnhUulaFEeohuUdJj2kHogg88r6IZt8lbBcT1AVPrTN9c
 baS7F6tK8orCjf/Hr78HXJlUwWUN2nICPXkG16tGAgySQxKAdyxbYT3EdWxAIX1AyBwPchijaai
 sXtdHENosAEDkHT9FWusT3BVsY+s7Om7s4utrdOEvnaZQ5E6y2HJkPaxqU91WTm1REHCmaGxNNB
 UXGle1gne4ko+dE7Hyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNiBTYWx0ZWRfXwkiZH9KNf90h
 nAJ/w7eoRnkPFhvP5AHZh++dFBMH/h5AWkAUt8ccDJ6RsnRUB/qLm3a3xKHdp4LTubp84/PiIls
 qZlRAmp85hGbFd/Baodq6q9nun3rgdQ=
X-Proofpoint-GUID: yXQeMV1vCbTXzMh7JpC1N9uAz3fEtqHM
X-Proofpoint-ORIG-GUID: yXQeMV1vCbTXzMh7JpC1N9uAz3fEtqHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250126
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDc4Mjc2OTZjNmIyLi42ZjAxZjNiOTFk
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTcsMTIgKzE0MTcsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

