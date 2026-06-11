Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44940CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2T-0000fL-Lr; Thu, 11 Jun 2026 01:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2Q-0000Ku-0Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2O-0002Va-7s
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GEfc3724538
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 342np824xJA2/8omYi9XTxQWbGZYU5eYioi5P1aEjHM=; b=e37R/2+o6d7sNCGQ
 RRJz3JoFA7pbxlMgY6HS+Gs7JbainVF9xI7RPkr1P/INh27FrjhSHdtpSoc3NUAC
 MRb6UCDLRBTtWoaxvoaJ3wy5ijgBp0dw1FVBeT8EqkoXF9UNtOE3hsBL9ZnM+ur7
 lRn2TOoPZ582eN6IZ8QlL5KV0UGP1sl1qDmqZ/Yr6Q79+a1C7Dor5DtFlY8wP5W8
 Sj5dy5O41MGcU7NEuLHVrORYbB+LZ98vvzqm/wENDY+xL3Yd6iyZkFqW3Pg1kffk
 R0+PMQAyXjeK+zBCRsdudIz/jRLc0VHL/lwicQmVLYHLk2cQq+ooj8I74WlXwYvf
 Ld+4tQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so7777552eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155986; x=1781760786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=342np824xJA2/8omYi9XTxQWbGZYU5eYioi5P1aEjHM=;
 b=Ogttjl0/CuHhWgE0SeGuc8ACr4gCb+2ZTcccQ8TuD0WXbN/o7BLg20FJ2TcM/xE+3V
 X4+e1zbslUGNpObJUfNxkYhr9c91cs9n9BlgUMFh57nM/nty9Myl2jvpA3frEy1x64Nj
 butbBpASMHal6LbB2uWggYXzGah/GDw4pV6goOTvUQumPaI5TccP4I6xYDXNGvcC/FD2
 5JykhFB+tYp6Q6c/x3G9S113XwydqtpGAk8OGXuPhzwJ55WBMtk8KG4ifwlMScjinaGD
 zIWBAO8ei88dv0Qof8X3Phv2jBqM+Gq4yTTMQDMkTXDLGHEAvouooSaDy7rmRrOnTB6S
 U5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155986; x=1781760786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=342np824xJA2/8omYi9XTxQWbGZYU5eYioi5P1aEjHM=;
 b=iMrMPdR6iU92g6yqBxGYiwOfi0uX4/Qf85kJzm0XhA4tCMExFtc3TSM0ZdoTh7kXUs
 S17CWwew3eht0Lrwjz2ianhmbZxCCrPFzSjjOgs36PsfDlNoNTFKe+cvzjJo0bpW72S8
 fiUASZyl7FbSFUmRblaH3tbe5Y5pez6HBj/HbGVi4Yn7tHckgXYpRow8zub9/dgnBZbF
 rNwsvac7Me4KG+9+bjMF1RrowIyA4ZOHcNzBuW19dT/yp89jTUsqmK7bOcM8WoE8hyPW
 BsMo9P4+yphmwplBuKhH4BKf7teFq6XUUYuTAAlmGBuacfEvCXKC4roJgPouu64aovQi
 FHkQ==
X-Gm-Message-State: AOJu0YxkAuZXVF+OIZ47NXT9GqKVaPFgODvnV9jfvWVeoZBwvthcglj3
 4+s+b2qKCAxFmQgnhjAJeT4vFAbZpQq0CGpdblEDQ2URkhlcTadvor6OvFLnjHqdq9y4x++igry
 8SNIOrSBPsbEyPQNaX6niIDZdQ+nSYiKeOlYIfTsy6WXZcrZIJ4V6n5Z0F95Unjhg3Q==
X-Gm-Gg: Acq92OGZsJkFPtZDqMevkAZ23/mJ6+x6tO/MIodM2uvgvh5HcSp/f99VD5p9+VyTg9V
 1UEdlOkdIeNe7RyLU4mAW8JV6YGgNGq+56hXW8uFRSk4jJIBC6LP8+g4oRNgmGg1PxUC4jsgUDb
 bgtT3NRmLZSVA8TvjJxmPTpQztD0c2JNpgYlrXyevHFvPZalTQ2eBJz2a4dvrS3tf0r5QrXOklc
 z9ziCvrl0MwjhUDgZHQFDVml/oP/fYuL7jG9px65wP6zlSpecQV0pEQzzATVxCez9A/Qh+lZg6E
 +ULzi8dcdSPGZW/qimu+fsk/iBM7G9fQ+LdZrFseJ9ZnMgOtWxOf/7Mk6c1PxFUGVp95ZMe/J11
 dGrlbYv86y1CWcApeip5DN2BN+UXzUO66wPDol6WqXBLDE7rAcTPhY8EqNiq18AxGyLdMES9f9a
 b2Racc
X-Received: by 2002:a05:7300:534f:b0:304:8364:e95c with SMTP id
 5a478bee46e88-3080479deb2mr1272012eec.15.1781155985753; 
 Wed, 10 Jun 2026 22:33:05 -0700 (PDT)
X-Received: by 2002:a05:7300:534f:b0:304:8364:e95c with SMTP id
 5a478bee46e88-3080479deb2mr1271985eec.15.1781155985099; 
 Wed, 10 Jun 2026 22:33:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement wait helper
Date: Wed, 10 Jun 2026 22:32:26 -0700
Message-Id: <20260611053249.3918491-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: FgAILBk4i4aBPQLaiaDyIwjYgWs-5xx8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX5eRhKkVJAmj0
 VF61hxu9tuT0I262b26xeRjOzBbkjQwsSHmtsvaX92tY6fwe3VtltAM2502lQ7xfeZ4/FAUEfyJ
 qcfxgKIxx1S/Ek5o65U5EqQb9bSwqpk=
X-Proofpoint-GUID: FgAILBk4i4aBPQLaiaDyIwjYgWs-5xx8
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a4892 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWtQ3YZIe0Xef7kIUYIA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX2FlPfx3nTYZk
 AB3YqcRUjMmSr1dXR/vnKLyv7e5VDgnbYl0h++T6LT6Z+Y3rLiyWyF8eek2tpoAH+i4CZgT64sR
 L9ejNtzi8dYCNHYuPB0hx9RUGGD+8DaF5bgnWqpaoir9RKpLohS32lQqprlpnfMGtt1Q6wLbH/S
 ZefyhkGcmMBaWnAPiKevNL+/w/3o3WZ/wTpsFLTIHbOQYu0rShDbRK/6yGtjhnHWUieQTL0I3ZG
 WJaLiBlPA7rnlbdqBoz069YWxlbCRo6CLB80hQvPVtGjLuWwyJdmAdJGCDxkEy41sUzRGu4CC22
 XkbgMKApShBLm+AUeTLIrXNXwWi9lqb2/SpGWqu4gatxY60sQyiy6vZBpkd1Np2Ay/NseLaiD+7
 tk8EUz2ULo+wEwxjv/zScwIZVnvZt934KRPB5UhaJ3PEtBWjKYzEKZBlNu0y4Q0YzEXixNNUg5A
 H/nWfUnkvM0kbM3ezbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8IDYwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA1OSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDI2NGVh
MDI3NTJkLi42OGIyMzg5NTQyOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19z
eXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw3ICs4MCw3IEBA
CiAjZGVmaW5lIGZHRU5fVENHX1kyX3dhaXQoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCiAgICAg
ICAgIFJzViA9IFJzVjsgXAotICAgICAgICBnZW5faGVscGVyX3dhaXQodGNnX2VudiwgdGNnX2Nv
bnN0YW50X3RsKGN0eC0+cGt0LT5wYykpOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2FpdCh0Y2df
ZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QucGMpKTsgXAogICAgIH0gd2hpbGUgKDApCiAK
ICNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRl
eCA5NTdkZWEyZTc3YS4uMjE1Njk3N2E0ODcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDg2LDkgKzE0
ODYsNjUgQEAgdm9pZCBIRUxQRVIoc3RvcCkoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgaGV4
YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCi12b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQorc3RhdGljIHZvaWQgc2V0X3dhaXRfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAg
IEhleGFnb25DUFUgKmNwdTsKKyAgICB1aW50MzJfdCBtb2RlY3RsOworICAgIHVpbnQzMl90IHRo
cmVhZF93YWl0X21hc2s7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworCisgICAgY3B1
ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpZiAoIWNwdS0+Z2xvYmFscmVncykgeworICAgICAg
ICByZXR1cm47CisgICAgfQorICAgIG1vZGVjdGwgPQorICAgICAgICBoZXhhZ29uX2dsb2JhbHJl
Z19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfTU9ERUNUTCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICB0aHJlYWRfd2FpdF9tYXNrID0g
R0VUX0ZJRUxEKE1PREVDVExfVywgbW9kZWN0bCk7CisgICAgdGhyZWFkX3dhaXRfbWFzayB8PSAw
eDEgPDwgZW52LT50aHJlYWRJZDsKKyAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdf
TU9ERUNUTCwgTU9ERUNUTF9XLCB0aHJlYWRfd2FpdF9tYXNrKTsKK30KKworc3RhdGljIHZvaWQg
aGV4YWdvbl93YWl0X3RocmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgUEMpCit7
CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKworICAg
IGlmIChxZW11X2xvZ2xldmVsX21hc2soTE9HX0dVRVNUX0VSUk9SKSAmJgorICAgICAgICAoZW52
LT5rMF9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEIHx8CisgICAgICAgICBlbnYtPnRs
Yl9sb2NrX3N0YXRlICE9IEhFWF9MT0NLX1VOTE9DS0VEKSkgeworICAgICAgICBxZW11X2xvZygi
V0FSTklORzogZXhlY3V0aW5nIHdhaXQoKSB3aXRoIGFjcXVpcmVkIGxvY2siCisgICAgICAgICAg
ICAgICAgICJtYXkgbGVhZCB0byBkZWFkbG9ja1xuIik7CisgICAgfQorICAgIGdfYXNzZXJ0KGdl
dF9leGVfbW9kZShlbnYpICE9IEhFWF9FWEVfTU9ERV9XQUlUKTsKKworICAgIGNzID0gZW52X2Nw
dShlbnYpOworICAgIC8qCisgICAgICogVGhlIGFkZHRpb24gb2YgY3B1X2hhc193b3JrIGlzIGJv
cnJvd2VkIGZyb20gYXJtJ3Mgd2ZpIGhlbHBlcgorICAgICAqIGFuZCBpcyBjcml0aWNhbCBmb3Ig
b3VyIHN0YWJpbGl0eQorICAgICAqLworICAgIGlmICgoY3MtPmV4Y2VwdGlvbl9pbmRleCAhPSBI
RVhfRVZFTlRfTk9ORSkgfHwKKyAgICAgICAgKGNwdV9oYXNfd29yayhjcykpKSB7CisgICAgICAg
IHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAiJXM6IHRocmVhZCAlIiBQ
Ukl1MzIgIiBza2lwcGluZyBXQUlUIG1vZGUsIGhhdmUgc29tZSB3b3JrXG4iLAorICAgICAgICAg
ICAgX19mdW5jX18sIGVudi0+dGhyZWFkSWQpOworICAgICAgICByZXR1cm47CisgICAgfQorICAg
IHNldF93YWl0X21vZGUoZW52KTsKKyAgICBlbnYtPndhaXRfbmV4dF9wYyA9IFBDICsgNDsKKwor
ICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7Cit9CisKK3ZvaWQgSEVM
UEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKK3sKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworCisgICAgaWYgKCFmSU5fREVCVUdfTU9ERShlbnYtPnRocmVhZElkKSkg
eworICAgICAgICBoZXhhZ29uX3dhaXRfdGhyZWFkKGVudiwgUEMpOworICAgIH0KIH0KIAogdm9p
ZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKLS0g
CjIuMzQuMQoK

