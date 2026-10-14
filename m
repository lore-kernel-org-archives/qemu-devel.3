Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CF7CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2Jf-0000zi-OH; Wed, 14 Oct 2026 12:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Ja-0000yk-7h
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2JV-0001ZF-E0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbHv1467701
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OwEId9u4WijsIxmndtgjMiGSx7S1PZeqfFdYfIdbG+E=; b=USO30MTWIWO1ZlcQ
 n+hIamrmeLYmmw+0s5348Hfv06YfDUOoR98uKNvdzQs1yT/Z3GR7aI2zXgzZUfaJ
 m+dbTZoPkQAW+yxWJ2sQJeEOTqic1+FYtMo4vl2OixhE5bAVmsBLLaPr9PnYrRQv
 nvoj/xs5QBtdi8ZMN2tN3tCZsJSH0pYUkEKXgneFkBA+C5fR3b8H7p7sP787CFq3
 1uYvQ8EhzNm0YTDGclsv+3zwZbwQEAvikQ9NGQinaRhxiaTH39GHE8ZWh6GYAQTb
 o+XNdyo9mpCDKnNC6RwiDEMqeoHTImg8jUPxEf2UY4DuHICBy7Ntreo+/AwUDXNl
 6nAUMQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphkmgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so5027610eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997125; x=1792601925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OwEId9u4WijsIxmndtgjMiGSx7S1PZeqfFdYfIdbG+E=;
 b=PYj4VGQ2GJ+sRn9RYncLbxUvktX+MEFAvBYKvak/6IHbB7frqZ4MZ3hw0z0Ppsv1qe
 PPysOMHeS3ZrapyCN18mSf6AOg+TZufbGvj1gRgEu8Jd3BcHzKEDAz0GgKHRa0I4UjoF
 OQvxLq/AqHPR1so97DWJ+PTCaRVw/HghfF5NWOsY8zbs+mePaZfUB6CVuEXIa223a8Ty
 aXeeT94CXtBQ7TOQj0m6aDtJsklmyB7yY8RNysTRbmrQ0jaTnF4LnJ6aEs45DqPYSUYq
 662r9rACzQZXiy5UV9hPFlOFc6UFc6quZVDTLqdFnxpzs6jMyh5kpyWhOlpStQ9JT4GO
 cBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997125; x=1792601925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OwEId9u4WijsIxmndtgjMiGSx7S1PZeqfFdYfIdbG+E=;
 b=YQ6TmtnRKDQ2rdQkJ3SjESrQI3jpK7EAbeFGZiFsXzJfF9hMK5nXPBc5Oq/ELP1hIw
 WZVv6TfgQQw8RbE76jh/pPgPLlNuWCbyyJM1aFqajVzCWvtJSjxLTmtwRyKsnHacMSld
 Idytvk14aLJr48USH+tw07qPP7QlIUOPalv625ypWWYL9o2nhyfU7h4DyeOOl+s2+L2v
 hHrpiE3nJeN/EyCKPTgbAHJoRn+fJw/kY6F++fKPwFb4ODTLyjwRTCmwAxYCpU+UCzD4
 NBDJvjifhYcjMyW81pmgsVH9Q22dq6OjzjjmW4cf8BJA1FN0EuwUAg4KHsIUhz1gPcGq
 2l1w==
X-Gm-Message-State: AFq9FYJG/QMPbaZ83zesquMYFFEPHAYvZ5pk9KJjwf0D4JrFHDbUqB/W
 aPqyI+962+CxWGtv+jNvTf8ciWsm/FxbuU+NCeLDGFvFvyQYaNhKkXu0gQsK/4FBPe10OonjEtJ
 XM7DQGpUcyBJeM3pe5EudsFDA0NQ3iE2F98s05Qxsdgh9okWodozEYWvF2NDYsyGFZA==
X-Gm-Gg: AYBFou1KysWz+CvvVSSddgVxPeAeMocRj6BNpJVKgkl2YX2TbS0YQSKUPVMfrUeB1eB
 Jur1VLgpj5xtLCZ1PhX3HDCUIf52JPRMKUmDQkAxEM7z9NN9LHk1SnD0bIMgzpr1Q0A6RKdHYO4
 5Ia/ksd9bgmAuyGGLVQktyGh9GbbbYC8BDP5JNFMK+jpSc2BiKfCLOE36wTwIQtzlXD3a7RmbiW
 egu8x3mbQR+OB/5jngRTza39Q/JSMZOo4bRsBVAQ8HoQjiOwLtbq67ajcvjgl+7uyBLN/dJLTK8
 Qi5rkqGthF04CIqp0ItLKV4dVnL6alUlaANqCY08Qkt25wXswwpyou7MRIT0/JBIF5rbJGdts5V
 clRd//R6Q84JfWwzr1ydT5RlZHKGBk4+28VLp9a8RITOnYWA=
X-Received: by 2002:a05:701b:42c2:10b0:143:2984:6517 with SMTP id
 a92af1059eb24-16a60fd3678mr26274581c88.38.1791997124399; 
 Wed, 14 Oct 2026 09:58:44 -0700 (PDT)
X-Received: by 2002:a05:701b:42c2:10b0:143:2984:6517 with SMTP id
 a92af1059eb24-16a60fd3678mr26274536c88.38.1791997123728; 
 Wed, 14 Oct 2026 09:58:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11137939c88.6.2026.10.14.09.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:58:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 2/5] target/hexagon: wake K0 and TLB lock waiters
Date: Wed, 14 Oct 2026 09:58:34 -0700
Message-Id: <20261014165837.2916482-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
References: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 9uypFZuhdYCBDeFq3yJkwQm0s0IopJ_7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX6bsNdmaLVt88
 KMiGQlswlpE9Gk1SxkFpcInSI7ApUC+WG/arjFp3V6BWNRg2sCKsuaarQVdoDY3Br9bLt3qhXFP
 saO1nL2xfk5rvkyCRFLHmHOBbtK7qQE=
X-Proofpoint-ORIG-GUID: 9uypFZuhdYCBDeFq3yJkwQm0s0IopJ_7
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acfb4c5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=B3wVGE7vzLrs5E8uOrsA:9 a=f_BrlBvIKBnCG3jP:21
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXzGpVq0Xg8TR4
 AWSNmOZYXAhpINJpevk2ntUX/TxEz14J1gguzXrfF6AXRtoPjcgB0TJj/yfVcMrIMTefI1M65os
 7ItbmLPpSb9OPZu8cd4qD1h66aVp8Jskc+EiENw7u2msT8USI8JAixRLTfIPwZc64ABzqOJOl7N
 //mR0IZSp2Bfp+RnbT0tvNCk0I+lDkopt8eKE6iNH+C04j8kPnyLg5FggtOQbkrJYRXFIZWCsyC
 6OqXpaUl5zvOrkt+IiEoV9RnIKD0qOPGJOgeUeSPXxcaGDZPwIEkmWz+RWO7u4lI0+QtGuZTs+u
 QM6hyQEHkSh5f3NmoKRsn0C8uZUclwWj2mnsA6fN9RA/F+A9gpL/sP3zJuWO2pNJEqEqXp9g7DA
 CwB/EunOV+HBzWdxYwRQ8gFHWl22TRs5HQzP4Tfv/Ho4JVlcO71E5TeVI9BTnPy9mMJjCvJZ2Jd
 GjVaYtFySBgW/JSvD/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

V2FrZSB0aGUgc2VsZWN0ZWQgSzAgb3IgVExCIGxvY2sgd2FpdGVyIHdoZW4gb3duZXJzaGlwIHBh
c3Nlcy4gVXBkYXRlIGl0cwppbnRlcnJ1cHQgc3RhdGUgYW5kIGtpY2sgdGhlIHZDUFUuCgpSZXZp
ZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0u
Y29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICB8IDIgKysKIHRhcmdldC9o
ZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgfCA4ICsrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi9oZXhf
bW11LmMgICAgICAgIHwgMyArKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgfCAy
ICsrCiA0IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5jCmluZGV4IGMyZmMyN2YxYzAyLi40ZTRhODFjMTYyZCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYwpAQCAtNDUyLDYgKzQ1Miw3IEBAIHN0YXRpYyB1aW50MzJfdCBzZXRfZW5hYmxlX21hc2so
Q1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX0UsIG1vZGVjdGwpOwogICAgIHRocmVhZF9lbmFibGVkX21hc2sgfD0gMHgxIDw8
IGVudi0+dGhyZWFkSWQ7CiAgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX01PREVD
VEwsIE1PREVDVExfRSwgdGhyZWFkX2VuYWJsZWRfbWFzayk7CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKICAgICByZXR1cm4gdGhyZWFkX2VuYWJsZWRfbWFzazsKIH0KIApAQCAtNDcy
LDYgKzQ3Myw3IEBAIHN0YXRpYyB1aW50MzJfdCBjbGVhcl9lbmFibGVfbWFzayhDUFVIZXhhZ29u
U3RhdGUgKmVudikKICAgICB0aHJlYWRfZW5hYmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExf
RSwgbW9kZWN0bCk7CiAgICAgdGhyZWFkX2VuYWJsZWRfbWFzayAmPSB+KDB4MSA8PCBlbnYtPnRo
cmVhZElkKTsKICAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdfTU9ERUNUTCwgTU9E
RUNUTF9FLCB0aHJlYWRfZW5hYmxlZF9tYXNrKTsKKyAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShl
bnYpOwogICAgIHJldHVybiB0aHJlYWRfZW5hYmxlZF9tYXNrOwogfQogc3RhdGljIHZvaWQgZG9f
c3RhcnRfdGhyZWFkKENQVVN0YXRlICpjcywgcnVuX29uX2NwdV9kYXRhIHRiZCkKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhf
aW50ZXJydXB0cy5jCmluZGV4IGFiNjZkNTQ4YTFlLi4wM2UxZjI4ZGE5YiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhf
aW50ZXJydXB0cy5jCkBAIC0yNDAsOCArMjQwLDEwIEBAIHN0YXRpYyBib29sIGhleF9pc19xdWFs
aWZpZWRfZm9yX2ludChDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IGludF9udW0pCiAgICAgYm9v
bCBzc3JfaWUgPSBnZXRfc3NyX2llKGVudik7CiAgICAgYm9vbCBzc3JfZXggPSBnZXRfc3NyX2V4
KGVudik7CiAgICAgYm9vbCBpbWFzayA9IGdldF9pbWFza19iaXQoZW52LCBpbnRfbnVtKTsKKyAg
ICBib29sIGxvY2tfcGVuZGluZyA9IGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19VTkxP
Q0tFRCB8fAorICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSAhPSBI
RVhfTE9DS19VTkxPQ0tFRDsKIAotICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQgJiYgc3Ny
X2llICYmICFzc3JfZXggJiYgIWltYXNrOworICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQg
JiYgc3NyX2llICYmICFzc3JfZXggJiYgIWltYXNrICYmICFsb2NrX3BlbmRpbmc7CiB9CiAKIHN0
YXRpYyB2b2lkIGNsZWFyX3BlbmRpbmdfbG9ja3MoQ1BVSGV4YWdvblN0YXRlICplbnYpCkBAIC0y
NTcsNyArMjU5LDkgQEAgc3RhdGljIHZvaWQgY2xlYXJfcGVuZGluZ19sb2NrcyhDUFVIZXhhZ29u
U3RhdGUgKmVudikKIAogc3RhdGljIGJvb2wgc2hvdWxkX25vdF9leGVjKENQVUhleGFnb25TdGF0
ZSAqZW52KQogewotICAgIHJldHVybiAoZ2V0X2V4ZV9tb2RlKGVudikgPT0gSEVYX0VYRV9NT0RF
X1dBSVQpOworICAgIHJldHVybiBnZXRfZXhlX21vZGUoZW52KSA9PSBIRVhfRVhFX01PREVfV0FJ
VCB8fAorICAgICAgICAgICBlbnYtPmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfV0FJVElORyB8
fAorICAgICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1dBSVRJTkc7CiB9
CiAKIHN0YXRpYyB2b2lkIHJlc3RvcmVfc3RhdGUoQ1BVSGV4YWdvblN0YXRlICplbnYsIGJvb2wg
aW50X2FjY2VwdGVkKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jIGIvdGFy
Z2V0L2hleGFnb24vaGV4X21tdS5jCmluZGV4IDBjYTUyZWQ2NjZkLi42Mzc4NzNiMjY2OCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9tbXUuYwpAQCAtMTksNiArMTksNyBAQAogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNs
dWRlICJody9oZXhhZ29uL2hleGFnb25fdGxiLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhh
Z29uX2dsb2JhbHJlZy5oIgorI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCiAKIHN0YXRpYyBp
bmxpbmUgdm9pZCBoZXhfbG9nX3RsYncodWludDMyX3QgaW5kZXgsIHVpbnQ2NF90IGVudHJ5KQog
ewpAQCAtMjcxLDYgKzI3Miw4IEBAIHZvaWQgaGV4X3RsYl91bmxvY2soQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgICAgIHVubG9ja190aHJlYWQtPnRsYl9sb2NrX3N0YXRlID0gSEVYX0xPQ0tf
UVVFVUVEOwogICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKHVubG9ja190aHJlYWQsIFNZU0NGR19U
TEJMT0NLLCAxKTsKICAgICAgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJf
VU5MT0NLKTsKKyAgICAgICAgaGV4X2ludGVycnVwdF91cGRhdGUodW5sb2NrX3RocmVhZCk7Cisg
ICAgICAgIHFlbXVfY3B1X2tpY2soY3MpOwogICAgIH0KIAogICAgIGlmIChxZW11X2xvZ2xldmVs
X21hc2soQ1BVX0xPR19NTVUpKSB7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGFjY2FkZDc5MjdhLi41YmRi
NGE2ZTg4MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEzOTcsNiArMTM5Nyw4IEBAIHN0YXRpYyB2b2lk
IGhleF9rMF91bmxvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIHVubG9ja190aHJl
YWQtPmswX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19RVUVVRUQ7CiAgICAgICAgIFNFVF9TWVNDRkdf
RklFTEQodW5sb2NrX3RocmVhZCwgU1lTQ0ZHX0swTE9DSywgMSk7CiAgICAgICAgIGNwdV9pbnRl
cnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKTsKKyAgICAgICAgaGV4X2ludGVycnVw
dF91cGRhdGUodW5sb2NrX3RocmVhZCk7CisgICAgICAgIHFlbXVfY3B1X2tpY2soY3MpOwogICAg
IH0KIAogfQotLSAKMi4zNC4xCgo=

