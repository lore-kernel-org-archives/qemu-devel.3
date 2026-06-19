Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10135CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBo-00022V-EW; Fri, 19 Jun 2026 18:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBm-0001zq-Ia
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBk-0001b6-Ut
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYdwT1253233
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=; b=lQGe8/c7IH72F4Om
 z+7FWsopDE8kflfwvlg830BpIAp8YYRjLemoRVXfEBPhzeUC1Zhe7/71KBpYktf1
 8Oh5fzHcyIz6j4FlnsNsgYZFPhiASokVHvR1x0vacRra9LkxtdcC5YWf9iLC+YoI
 qP5zHq0fM+Qqgk3JrdNAOud2L5D0ndHOh0K7qFOJZHFjgHDjrv9L33AhpppTkfnf
 q+HSK8xStPKh0uZbKp6PVUn868fRiYw7HHQjyOj5PkDoOoBnBapU9hPYKgU3XPBk
 VuOQ0S0xuNUAsacD9zBI9EfZRNXnHINLyAvOeCtss6y49i55AoTTt61jYN3Gb9UT
 Nn1kyg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8n2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bef75a41eso1996141eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909981; x=1782514781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=YHwTx1BQg2COVtuamEAzJPkNUawldi08nfJ9zbgBlYMbas9I2gvj8jCmfk7o4xLhnM
 nEbDLNAL9kafwfm1sl9yi3LEc/da4xreDucw8WnLfJa/sXTsICcT2Dyx6xyhCGm1sAsQ
 rO8vdRpboK2fUjXNLijhUpexShJ0MUxtzvaBTgyLYA6mdFn96+aaovEebMIv4Ni9LETN
 7jrq/Kd2GDUS2quD1yEjlMUzB/RSV4jnMBHUeT7xBK/MzLlLfXiTt9iHORb5As/8gG/2
 5HBZPvfhUFC21VkK9baD/hzBiAlS5UUH9nw4/OZCFEeiPxCRhdWWZYXfo5oDWSUtjVAQ
 mmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909981; x=1782514781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=nLRJftx7/Gje/CAga4jk8PWuxs3hNif84XAosQhaJ+Yfz2J8w0SJRIc+QROcfXjMC8
 ZubKTmE7hb/TXcLybjOHATRu4FCk04/aAYQDLaCniTT7oPcx5nHrsMayjyjaF2vv1OgH
 ROHLjn8loe3ZSi3va0E+m5i8zkkphDQle9UvkZxO7JwzRKzzJGI8a8nHg6MMVY5T/V4h
 PjzKB19gs/Ng5723iOj6dIUj/T/5egW9hDWs9ZWfeghjgID/e/fxQ7gJ0Z4ABZl2+zzc
 0pqpYA6PWsx3cwMWkOXDYLxsXGRmpb0tIeMiQJHJvpa+ppgbnqyBcPxKgl5zgfhX1l7O
 bxYQ==
X-Gm-Message-State: AOJu0YyvFGxTMakJuQMY4jk/bgtrMRt/ReixG4bfceH0UOsRM13rvAkH
 wcPX8IBfbC/LxOT5cock3Obror1TP6KQtxZCpcPoggSVbii7sWs0YFFHkOctI8DvaglFMB1jDWc
 dPe43D5Nwc2jBKJAJgP5ZQ82rjtx7m6m04xS7WOvUVyZgYzndlHc3xl/ZBeynDpQwAw==
X-Gm-Gg: AfdE7cngVz/svX+q6GR9nDEoqytzQFTmvhKUHBrO41MujAIVSLccuFk/WQrCBgkQaBW
 mAB+Zgxbf79i7YSzU85OCL2ysSPMGNVH0GyJDvnkVuee/2IUhkR5fNDuSPyTpsB4cJmoPiFYajY
 KHFojhsCStiln41cha69NPXQuPrMhf0pFJzX//hbSHJ6rAA8YZRcm2a5l62tITvR2kbFJzoOoAJ
 rz0tiRGXxuycmEjKMzTaBlcLWq6WSYWrmljjQj4jStIGwZWZD74b1swf5l7A2WY8PjgBOutYBhf
 bGX82gvOQwtecQg70QNK3p4RYIwkugmgi5CZ6cz9NY1hmevirhaVDHy9uR1guCErZQTyeY2zVTV
 PNexM8C/cIjzDKM8MtuTYQXZb4oVHifyjG/UmZJ5rwQuTAcvC3zsuJfzCb6E=
X-Received: by 2002:a05:7300:fb8e:b0:30b:f73f:ff6e with SMTP id
 5a478bee46e88-30c1d9c7fcfmr786034eec.11.1781909980783; 
 Fri, 19 Jun 2026 15:59:40 -0700 (PDT)
X-Received: by 2002:a05:7300:fb8e:b0:30b:f73f:ff6e with SMTP id
 5a478bee46e88-30c1d9c7fcfmr786021eec.11.1781909980261; 
 Fri, 19 Jun 2026 15:59:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/74] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Fri, 19 Jun 2026 15:58:14 -0700
Message-Id: <20260619225911.159473-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: SjZnV5fDt26mgeIcIYdV2xat6-HJZJDM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX3XPSJsO7Qg8W
 yoMhFEYAwGbDvPFsxW4c0dAP5fH0w3obLPx4GTNUuWLL/LQ04VufRc2Njz1uD4dzCmBOw69VOkf
 j0af0wEw+u+VjxeSO6AOvcUmiaKzOoy4ePyFwxPEApYVV9V+1AqI+duSm8M7Qxn/8Ht/Ty2uPFb
 sALKgtqSyP27l3fcaU7q1aiPTrUTZBXN3LqkV4bCE6zyS21hFmODhbEXRxlJ5T3T4jqueKtzo3X
 C2ShQnbMgmajCLQrc/dhxNmzzac+u5+xUdJ9ia4+I30SGS4lEd+mNzGKcdT6E6N0+ft2LDQcRJu
 chifdN6Vzy+GymgqpMBOzN9f6sBw79RQKeqBor3CbaHTUo3NQBlvtiWhz7ldWQoe9Sk1B1XPuTo
 xa+AUimu5BzGzR2LuP+HKFdmlbPRz1PFH1lXmOQcvTn4m9miZKbrwhS45u17bUIgUn1uu64plro
 HOhvgwtQ2KWR88EWAKw==
X-Proofpoint-GUID: SjZnV5fDt26mgeIcIYdV2xat6-HJZJDM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX8PPjlI8c98zT
 FXrZaJUkqVHyPXzs1X6zOP1jFeTUjLHw1aEmFXnEjG+C0sExItsnjD2JXvMr7qkWPoAGPlR0qpX
 f0G4lzWzn5bm68JCRlyQIf8U1qXj3Ro=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35c9dd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190220
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDggKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaAppbmRleCA2NDQ1NjgyMmJjMS4uMjhiOWI1OWUwZjIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBA
IC0xMDcsMyArMTA3LDExIEBAIERFRl9IRUxQRVJfNChwcm9iZV9ub3NodWZfbG9hZCwgdm9pZCwg
ZW52LCBpMzIsIGludCwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfc3RvcmVf
czAsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQs
IGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9p
ZCwgZW52LCBpbnQpCisKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBF
Ul8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzcmVnX3JlYWRfcGFp
ciwgaTY0LCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCisjZW5kaWYKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNWI5YzI2NmQwMmYuLmNkMzI0YzE5YTlkIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3NCw2ICsxMzc0LDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3ZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50
NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVM
UEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFk
X3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUg
cmVmZXJlbmNlZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUg
d2FybiguLi4pIC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

