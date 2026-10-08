Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9959FCA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvNZ-00051x-Fw; Thu, 08 Oct 2026 17:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEvNX-00051H-7e
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:10:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEvNV-0001hh-7p
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:10:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0KMT3996466
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 02H9AiyUMYAzGOkdCUovbUTU4rITcaHPFSKCysPcLUI=; b=f2dGhyZ+SQNa7abK
 eHRfNfM7d6hKzwtQ7bQc9nMEKrNB89JivBOgDqAsexV/OfflGAtvDB2KzVBsq7sa
 IHgWwFT1AEQ/6Qnl9eLF2LNcTnatfjk9f+PXliuVtTkAw9/BYfrGye9LwwhBrkxi
 bCH/RnbULN/Xu9LNRyHgMO9XuBUUuX5KC3XOgG8iLjXgZYdS8Mfr/H82oL2An+o2
 xoJa8P9XP511qSq1ZbF/EQOjHAZxkg/KC8VjITHMRiF8tZqBR05D+5PySjCIKssT
 T7WKNLdd7a8vLwt26eiZ4+FdfDCNB6poDmfAFC2pUpeYAze+kiKCNTrOVikHBG/m
 ip9APQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj1v52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:10:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so10578684eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493809; x=1792098609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=02H9AiyUMYAzGOkdCUovbUTU4rITcaHPFSKCysPcLUI=;
 b=KCyya3f3KkpVXxsnSYZ7Lgp2lJ0/3BdwhRv4OS3YdyKWsVTBQG8o7SZjRleBwrIIMP
 YRpU4hEr5qjeIUCNV5+Stnq8+Vkt27EL7tbNQp9l5GUhoTL6HeRPtWJ7UX6i25IxxhTO
 uomSdcrfTJvMVaLZ7XCSJ6Q+qmZwxNkp8XPHWDNFkGJTsN/NOWvYFS1DC5tacOAukTL7
 wabt+JNIkoAuKOFjGNkg+s9YSo6ZoZGTnvVb7NmQawUSi8EeKjZMS4LgbyvxN62WCFlu
 9quuDqV6GMtd+ny+UmwytsAdKnEdu8tHTdYvo4yckerLABixoLKqQJTPxOAmBj4ItqZj
 eoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493809; x=1792098609;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=02H9AiyUMYAzGOkdCUovbUTU4rITcaHPFSKCysPcLUI=;
 b=hCnH+U5r6e794uox08Iah0RI/HYPbpOcsluZsecHfWvf8moTuv82h8m15u3BisvBRH
 zJUY44WJpReU9G+Wdgj1ABYxZ4LJtcNF2wRwuQmDzlWW10/qER3wi/lonid9upPahhMj
 EIdarY3VjOKyRm9zwfg6y0E/XzCeV+kKrv4GclYdBjBxAECWyp1zta9xTUh2609qzHn4
 NBC8y0jGzkUjWBCUwSuXnutU+LJ8hUAJdTRxiHG8kzGSUSq7EOu9CgQpst1bZZAPlVyX
 Ozg57WHsyfznmFH+YpiMt0Vb4IeaQ98CGvffSDXkYxKxhQYmBcDjdnflmKBoMu2vqT1C
 +iig==
X-Gm-Message-State: AFuF++lBAmmWvz5h3iZ0Z5fHuXJrJqa8K36dahRO5z+rWTZ0kMY/WZA0
 dp1cuWgOoqEsQoWCPz/rhAnkO0WOCpq5ZejrfhWTqEGmXeh+d+cJ1nq4OTTvo4PUBqBeR1E++/D
 DdqcnBY7ZhZTsKmBS/x1cPuWpq9NUPjgWogPjCdjEb2O70uitvvSlltaPxs4XDF2aEg==
X-Gm-Gg: AYBFou3NUSIxUSdYtILyzx5LyYmow8BvJrelOX/0p5Y8ldCdc1H+bK3Hdl0jL1MDxV+
 5nVAtzxLf0HVVnAMOqcmsYqAp+zpKgD1ggFWH130uHn7kNx2TAi8I/6KGdIqdWctu9bI2/FS2B3
 cXoYM3thzjzqsXsMbGtLyiiIuOLhSvrU7fqmjXhwUPAEQSL/Hvkx1HxgSC64xfzR5CKrZZST01X
 6d1FgT+xJSLKSzL5qLoq67D8eOjxHWvJ9gnIOXkfYmdCYi5tyH9lPJ5GwHnaEr+CJMkDOZ3v4tk
 2hOOeH2sjLMKuYcMHteYW4r6enU+T/9MJEs8W8Y/2MMQkmpyCX31NhGJMqQJJeEr5ObQLL+0A5m
 7SeHFIA7MvJgrG94o/Y06cBrJXo/Zb1BQhHAz5pTd3iw25GE=
X-Received: by 2002:a05:7022:285:10b0:14c:e31e:5dd4 with SMTP id
 a92af1059eb24-16207a9af50mr6894118c88.36.1791493809023; 
 Thu, 08 Oct 2026 14:10:09 -0700 (PDT)
X-Received: by 2002:a05:7022:285:10b0:14c:e31e:5dd4 with SMTP id
 a92af1059eb24-16207a9af50mr6894071c88.36.1791493808215; 
 Thu, 08 Oct 2026 14:10:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a31f6be0sm1628501c88.13.2026.10.08.14.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:10:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
Date: Thu,  8 Oct 2026 14:10:02 -0700
Message-Id: <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXwQXmcIAAAGxk
 DHez28o7vnKyoEzCDMFv0lfTtjShRUSoGagcmH7C1s1hF+POvA+aRqO0b6eQWquyGGev3eJw58s
 oDASQgJUtl26zBspg1MyR0pxnnBg11M9qNbNdwDOh29SPaNbYwwh5NEyYAwv67JdUKLPmwnWktr
 4lN24OyY27OkF0/PExt/24awEs30//pPRjHjD1v7HwToRB6e1JYpbnoukyRpQXMT1+3+WejiUUT
 VoRR5WY01x+kd1nOSxG2waHWNMwQMJQVzlHoPTWkUl/rgVKvufr2SWQ1s2sG312meWLhTWHYPwK
 O6sTtNxz66CkwzpMv3PoTxuhTcII+GzbMkNEf/JYO6TdywvBZOUMBWb1odF9C1eBNvn2xAhQeJI
 5K6QWZSMcCloGbVUTUkcNYEu5lsA2ma4j2wT5DySSLAMji2o0ZvIxi4erDD9XRShc9IHWJ29Qpe
 5PYqs3IVza9zZUrkwQQ==
X-Proofpoint-GUID: IQuMIUxxqcayJlRh24wYx09yjD3FlJZb
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac806b1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mWocMZdqMPi0kNrwBuIA:9 a=ZrxtPELqu-BLy5ea:21
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: IQuMIUxxqcayJlRh24wYx09yjD3FlJZb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX9hG44DiHXrjh
 7rNQ9wmoom5aa3352Hc9cT0eavi1rEInEc88NhK4fEsNvw8a62hak8dUFRzcg4s5z2Y1ymtbFsd
 MguB4F5uYLWAdFEjMPd5nYxFh0Ms9js=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080084
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

SGFuZCB0aGUgazBsb2NrL3RsYmxvY2sgbG9jayBpbXBsZW1lbnRhdGlvbiBmdW5jdGlvbnMgdGhl
IHBhY2tldCBQQyBhcyBhCmNvbnN0YW50IGluc3RlYWQgb2YgcmVseWluZyBvbiBuZXh0X1BDJ3Mg
b3Bjb2RlLWRlcGVuZGVudCBzdGFnaW5nLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJp
YW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuaCAg
ICB8ICAyICstCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggfCAgNCArKy0tCiB0YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmMgICAgfCAxNiArKysrKysrKystLS0tLS0tCiB0YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYyAgfCAxNiArKysrKysrKystLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2hleF9tbXUuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuaAppbmRleCA1NmIyYzRhODlk
MC4uMjNhYjg3Njk4MzAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmgKQEAgLTIyLDcgKzIyLDcgQEAgZXh0ZXJuIGJvb2wg
aGV4X3RsYl9maW5kX21hdGNoKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqc2l6ZSwgaW50MzJfdCAqZXhj
cCwgaW50IG1tdV9pZHgpOwogZXh0ZXJuIGludCBoZXhfdGxiX2NoZWNrX292ZXJsYXAoQ1BVSGV4
YWdvblN0YXRlICplbnYsIHVpbnQ2NF90IGVudHJ5LAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QgaW5kZXgpOwotZXh0ZXJuIHZvaWQgaGV4X3RsYl9sb2NrKENQVUhl
eGFnb25TdGF0ZSAqZW52KTsKK2V4dGVybiB2b2lkIGhleF90bGJfbG9jayhDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKTsKIGV4dGVybiB2b2lkIGhleF90bGJfdW5sb2NrKENQ
VUhleGFnb25TdGF0ZSAqZW52KTsKIHZvaWQgZHVtcF9tbXUoTW9uaXRvckhNUCAqaG1wLCBDUFVI
ZXhhZ29uU3RhdGUgKmVudik7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3N5
c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaAppbmRleCBhNWI5YjdmMjU5
Mi4uNzIxNzlkNDlhYjMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaAor
KysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKQEAgLTE0NSwxMCArMTQ1LDEwIEBACiAj
ZGVmaW5lIGZEQ0lOVklEWChSRUcpCiAjZGVmaW5lIGZEQ0lOVkEoUkVHKSBkbyB7IFJFRyA9IFJF
RzsgfSB3aGlsZSAoMCkgLyogTm90aGluZyB0byBkbyBpbiBxZW11ICovCiAKLSNkZWZpbmUgZlNF
VF9UTEJfTE9DSygpICAgICAgIGhleF90bGJfbG9jayhlbnYpOworI2RlZmluZSBmU0VUX1RMQl9M
T0NLKCkgICAgICAgaGV4X3RsYl9sb2NrKGVudiwgUEMpOwogI2RlZmluZSBmQ0xFQVJfVExCX0xP
Q0soKSAgICAgaGV4X3RsYl91bmxvY2soZW52KTsKIAotI2RlZmluZSBmU0VUX0swX0xPQ0soKSAg
ICAgICAgaGV4X2swX2xvY2soZW52KTsKKyNkZWZpbmUgZlNFVF9LMF9MT0NLKCkgICAgICAgIGhl
eF9rMF9sb2NrKGVudiwgUEMpOwogI2RlZmluZSBmQ0xFQVJfSzBfTE9DSygpICAgICAgaGV4X2sw
X3VubG9jayhlbnYpOwogCiAjZGVmaW5lIGZUTEJfSURYTUFTSyhJTkRFWCkgXApkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCmlu
ZGV4IGQ2ZWU3YzQwNzk4Li4zMmZhMDMyM2JkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
aGV4X21tdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwpAQCAtMTU2LDcgKzE1Niw3
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwcmludF90aHJlYWRfc3RhdGVzKGNvbnN0IGNoYXIgKnN0
cikKICAgICB9CiB9CiAKLXZvaWQgaGV4X3RsYl9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52KQor
dm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykK
IHsKICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfTU1VLCAiaGV4X3RsYl9sb2NrOiAiIFRBUkdF
VF9GTVRfbGQgIlxuIiwKICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOwpAQCAtMTcw
LDcgKzE3MCw2IEBAIHZvaWQgaGV4X3RsYl9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAg
IHVpbnQ4X3QgdGxiX2xvY2sgPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19UTEJMT0NLLCBzeXNj
ZmcpOwogICAgIGlmICh0bGJfbG9jaykgewogICAgICAgICBpZiAoZW52LT50bGJfbG9ja19zdGF0
ZSA9PSBIRVhfTE9DS19RVUVVRUQpIHsKLSAgICAgICAgICAgIGVudi0+bmV4dF9QQyArPSA0Owog
ICAgICAgICAgICAgZW52LT50bGJfbG9ja19jb3VudCsrOwogICAgICAgICAgICAgZW52LT50bGJf
bG9ja19zdGF0ZSA9IEhFWF9MT0NLX09XTkVSOwogICAgICAgICAgICAgU0VUX1NZU0NGR19GSUVM
RChlbnYsIFNZU0NGR19UTEJMT0NLLCAxKTsKQEAgLTE3OCwxOSArMTc3LDIyIEBAIHZvaWQgaGV4
X3RsYl9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAgICAgICAgIGlmIChl
bnYtPnRsYl9sb2NrX3N0YXRlID09IEhFWF9MT0NLX09XTkVSKSB7CiAgICAgICAgICAgICBxZW11
X2xvZ19tYXNrKENQVV9MT0dfTU1VIHwgTE9HX0dVRVNUX0VSUk9SLAotICAgICAgICAgICAgICAg
ICAgICAgICAgICAiRG91YmxlIHRsYmxvY2sgYXQgUEM6IDB4JSIgUFJJeDMyCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICIsIHRocmVhZCBtYXkgaGFuZ1xuIiwKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgZW52LT5uZXh0X1BDKTsKLSAgICAgICAgICAgIGVudi0+bmV4dF9QQyArPSA0Owor
ICAgICAgICAgICAgICAgICJEb3VibGUgdGxibG9jayBhdCBQQzogMHgiIFRBUkdFVF9GTVRfbHgK
KyAgICAgICAgICAgICAgICAiLCB0aHJlYWQgbWF5IGhhbmdcbiIsIFBDKTsKICAgICAgICAgICAg
IENQVVN0YXRlICpjcyA9IGVudl9jcHUoZW52KTsKICAgICAgICAgICAgIGNwdV9pbnRlcnJ1cHQo
Y3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CiAgICAgICAgICAgICByZXR1cm47CiAgICAgICAgIH0K
ICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX1dBSVRJTkc7CisgICAgICAg
IC8qCisgICAgICAgICAqIG5leHRfUEMgaGFzIGFscmVhZHkgYmVlbiBhZHZhbmNlZCBwYXN0IHRo
aXMgcGFja2V0LiAgUmV3aW5kIGl0CisgICAgICAgICAqIHNvIHRoYXQgdGhlIHRocmVhZCByZS1l
eGVjdXRlcyB0aGUgdGxibG9jayB3aGVuIGl0IGlzIHdva2VuIGJ5CisgICAgICAgICAqIHRoZSB0
aHJlYWQgdGhhdCByZWxlYXNlcyB0aGUgbG9jay4KKyAgICAgICAgICovCisgICAgICAgIGVudi0+
bmV4dF9QQyA9IFBDOwogICAgICAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CiAgICAg
ICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CiAgICAgfSBlbHNlIHsK
LSAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7CiAgICAgICAgIGVudi0+dGxiX2xvY2tfY291bnQr
KzsKICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX09XTkVSOwogICAgICAg
ICBTRVRfU1lTQ0ZHX0ZJRUxEKGVudiwgU1lTQ0ZHX1RMQkxPQ0ssIDEpOwpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpp
bmRleCA0ZjAwY2E3NzNmMy4uYjNiNDZiZGFiODkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xMjgzLDcg
KzEyODMsNyBAQCB2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCiAgICAgaGV4YWdvbl9tb2RpZnlfc3NyKGVudiwg
bmV3LCBvbGQpOwogfQogCi1zdGF0aWMgdm9pZCBoZXhfazBfbG9jayhDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3N0YXRpYyB2b2lkIGhleF9rMF9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJn
ZXRfdWxvbmcgUEMpCiB7CiAgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2FyY2hjcHUoZW52KTsK
ICAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CkBAIC0xMjk3LDcgKzEyOTcsNiBAQCBz
dGF0aWMgdm9pZCBoZXhfazBfbG9jayhDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CiAgICAgaWYgKEdFVF9TWVND
RkdfRklFTEQoU1lTQ0ZHX0swTE9DSywgc3lzY2ZnKSkgewogICAgICAgICBpZiAoZW52LT5rMF9s
b2NrX3N0YXRlID09IEhFWF9MT0NLX1FVRVVFRCkgewotICAgICAgICAgICAgZW52LT5uZXh0X1BD
ICs9IDQ7CiAgICAgICAgICAgICBlbnYtPmswX2xvY2tfY291bnQrKzsKICAgICAgICAgICAgIGVu
di0+azBfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX09XTkVSOwogICAgICAgICAgICAgU0VUX1NZU0NG
R19GSUVMRChlbnYsIFNZU0NGR19LMExPQ0ssIDEpOwpAQCAtMTMwNSwxOSArMTMwNCwyMiBAQCBz
dGF0aWMgdm9pZCBoZXhfazBfbG9jayhDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgfQog
ICAgICAgICBpZiAoZW52LT5rMF9sb2NrX3N0YXRlID09IEhFWF9MT0NLX09XTkVSKSB7CiAgICAg
ICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIkRvdWJsZSBrMGxvY2sgYXQgUEM6IDB4JSIgUFJJeDMyCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICIsIHRocmVhZCBtYXkgaGFuZ1xuIiwKLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT5uZXh0X1BDKTsKLSAgICAgICAgICAgIGVudi0+bmV4dF9QQyArPSA0OworICAg
ICAgICAgICAgICAgICJEb3VibGUgazBsb2NrIGF0IFBDOiAweCIgVEFSR0VUX0ZNVF9seAorICAg
ICAgICAgICAgICAgICIsIHRocmVhZCBtYXkgaGFuZ1xuIiwgUEMpOwogICAgICAgICAgICAgY3B1
X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKICAgICAgICAgICAgIGNwdV9sb29w
X2V4aXQoY3MpOwogICAgICAgICAgICAgcmV0dXJuOwogICAgICAgICB9CiAgICAgICAgIGVudi0+
azBfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX1dBSVRJTkc7CisgICAgICAgIC8qCisgICAgICAgICAq
IG5leHRfUEMgaGFzIGFscmVhZHkgYmVlbiBhZHZhbmNlZCBwYXN0IHRoaXMgcGFja2V0LiAgUmV3
aW5kIGl0CisgICAgICAgICAqIHNvIHRoYXQgdGhlIHRocmVhZCByZS1leGVjdXRlcyB0aGUgazBs
b2NrIHdoZW4gaXQgaXMgd29rZW4gYnkKKyAgICAgICAgICogdGhlIHRocmVhZCB0aGF0IHJlbGVh
c2VzIHRoZSBsb2NrLgorICAgICAgICAgKi8KKyAgICAgICAgZW52LT5uZXh0X1BDID0gUEM7CiAg
ICAgICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7CiAgICAgICAgIGNw
dV9sb29wX2V4aXQoY3MpOwogICAgIH0gZWxzZSB7Ci0gICAgICAgIGVudi0+bmV4dF9QQyArPSA0
OwogICAgICAgICBlbnYtPmswX2xvY2tfY291bnQrKzsKICAgICAgICAgZW52LT5rMF9sb2NrX3N0
YXRlID0gSEVYX0xPQ0tfT1dORVI7CiAgICAgICAgIFNFVF9TWVNDRkdfRklFTEQoZW52LCBTWVND
RkdfSzBMT0NLLCAxKTsKLS0gCjIuMzQuMQoK

