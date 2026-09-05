Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC80C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqV-0002sr-Ry; Sat, 05 Sep 2026 14:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqI-0002rb-K3
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqG-0001dQ-SY
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HcGw53521237
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4DvtK8S5TJotU1fvpxHTlfk3iWSuq+07sN+ZNPnFJFw=; b=VyB98Y7rWDPyxwXW
 lSlhveGvNr5l/twiSv15ys+eSrTCgPZDzXlnpSaZ61Cl/JmvPHKgm68O3KGPSnJB
 //bNkLUtyA7BU1uUFPOwKMMRygBlJiBBD2ElpGeXc7OIlxEK92NmZxYoxE4hVz9Q
 cCX6vbk8pwzfbh+B8o/X9ther/ClnfrDZD0B++JEkmjEu2VZGoO5KgAEKjpeTbJa
 Slcw4ZbcolztBXrd/wqPKOaSp1DRu1nHEqG89q7Z4MOKC7CXckWDa8LWQv4OjFW5
 dm8PV0KUf4yqN/QxbvZJBW0IUOaOapjg4HOAQUIZ9lcPfa0XbYIEKBbNzFwxnmat
 jI6qWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany1xcb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d7293f13c6so27202585ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631814; x=1789236614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4DvtK8S5TJotU1fvpxHTlfk3iWSuq+07sN+ZNPnFJFw=;
 b=YnsToMW4nIHQyancBf5KjcXXACuz3fXLNldJM/UL3yHTJZSfcl8sV2fDvj3dCwyuxD
 kDrPBIYb1Y3CResuKESHVbIb6Lkbg3RjnNgxzmpDhmQ3zUM5g10FP2hq5HyEJU1ngaj4
 GlMyrQArAdkdT7UdRgGzasCVchRJ5Nvjl5DN8noH/JV+0a23763ZoxL0fHEFlhd5M/3X
 //nPEkDTWcA5nw4pIt4Y3szpvfc/0pqA1N4Vr7PtF9X2VLqUqpbiIW4BoM9exeAmFL9f
 YEhU7CB4nJH95o430Fs7VlgBe7gEMSIHDD0mhYrsyvig9pD3UyH7aAvMfPZbZlwJpRb3
 oMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631814; x=1789236614;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4DvtK8S5TJotU1fvpxHTlfk3iWSuq+07sN+ZNPnFJFw=;
 b=dQpNdbvFpDl218IZy6BSY6RGU/xinbIgQvvvhbrc6ZtJLwDxvpmsYVhuPVztjarvms
 E6ei1MNgjafUpSQXWhxQwyA0nCjIXrWA0t/QbXOvG2TI8AtMbnQyyROl3Fy+hiXVBDzY
 5HQPJyH7G1Hb/lleX58osa58HeReU4fQjZgwLfTWptw7iVkm4IC5SyCBgn+hNzwjgTZV
 9HLlMeAmnCjkhL2grOa8WOVYDB9u6/pFtFQccTfEHzGJRnTcoCF3yiHd+ZD388vfDlS6
 eie/ErgbrfjBjd9syCOYmMJJVHafJ8PNiodqRYzn5bq9DUe7oRocGBSEkSP+tEWyhEHD
 XXjw==
X-Gm-Message-State: AFuF++nYjWeyttlBicPudFoly7/JSemcXOEvxKbfcuA7ZeDPs4YG90zn
 BwE6PmPm+txmQEkk2qKtAwL61MzNE6FJX0VcjgKUoKt5QAfiG+RLNz0KINTGkS/mGCWyUCrbpy8
 /V69Inym62qMwwts3t3H1DK02WoKhrn0Pk98SahylHgfjuye6OQug93EQMzr7hJxrPQ==
X-Gm-Gg: AYBFou3CSbzbvWZUkmqgevZmEe9F0ueV5zRWdqPekzPj8WkYptVhpGKJd12soKbcJRB
 SZE6rZ9ucftC4W9lDP2Tc+Zvj887wun63PTmNtVoKGyEe/TWcsQq5+l9xRFaGmazPTCbBEzbOi/
 vNHkbat7AtU2yB2lnaI1gAGjlpBx0wZyUTjy7QjiJ5xbeochO3T4WCEMTIzbw5CqbZTNIP2eSZq
 xiSv3sraCg2H0LYOz4Si/OpW+S8KU3oCs/J7GEJGp5824UFmeLq/sytrU0Zy5gnq9RyH0YdIY/o
 ZcBw+r3l0x1nuDQBR48FFetXcksdFT5nubQgr0Wtc3hnVAucSjTCNzowa4oqSV4RilcneNw1+Dw
 VA1rUSGsjXjeT4D5FFr1HuIZfZ3uOeZvbBZcqcZQ43FaK6Fh5
X-Received: by 2002:a17:903:2a8e:b0:2da:e68f:45b4 with SMTP id
 d9443c01a7336-2db124aacbfmr227442445ad.8.1788631814164; 
 Sat, 05 Sep 2026 11:10:14 -0700 (PDT)
X-Received: by 2002:a17:903:2a8e:b0:2da:e68f:45b4 with SMTP id
 d9443c01a7336-2db124aacbfmr227442025ad.8.1788631813691; 
 Sat, 05 Sep 2026 11:10:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 09/17] tests/tcg/hexagon: add dczeroa cache line zero test
Date: Sat,  5 Sep 2026 11:09:41 -0700
Message-Id: <20260905180949.1852673-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9c5b07 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=StvKSay-7vg8R344wSoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Eq2xwYRwG21lYVFwb5Om60YMNIsEW87m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX7Hz9eAXnobUW
 LbxW2w3hvKS0GfRVnXnuW+BaKQ7prxYjWUEJCIExOHGHaj6hRCvrbZZV1YQxhZdil/h7hgpxa7u
 pSLF60JaXmrPngrjHjq6se/8wWiYdGN7BIn40kB5p5Ybgw7y1gN+mI2i/d6M5KgfKalQio8tEvV
 sMhXnRkMicoxHfBNZAN/VLHatWdVf1pj6C9cVKki33OoBw/kR0t0qaUfoqEh/UOpo1hhFfXameF
 W29l2VzjMPAethGTL0zN5/lpuVgoE7YOlFn2X1ht8SEMQ+7EI1DfZ1LzeKEpJQjmiZRRruA9hdG
 p3Jerei7w7k0C2bLurrwMZuMSEGTxasIe7U9Xz8qherS7Ph/tNtrwIt2ckiaiDSgvVx9z69wmxH
 6kznW7rjJyoY5fbr4Ywdx19mQa97NcwG8Wlc7EqBym8vJ1m97W+wIE//zIU0wzfeIss44vhQDKx
 94lL/y4Nu+6rbVKKckQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX5j73ZKBmQbKk
 Y4EMVBjShnNPYfNnj+x9PSrZAGysfZRem1kRVdHosP2uIAK/MEV/qHW2psjsQ5OIxJlDCcBf+Lm
 v++Kojyu/PaVEXfBBlZdMacWmYWT20U=
X-Proofpoint-GUID: Eq2xwYRwG21lYVFwb5Om60YMNIsEW87m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050201
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

VGVzdCB0aGUgZGN6ZXJvYSBpbnN0cnVjdGlvbiB3aGljaCB6ZXJvZXMgYSBjYWNoZSBsaW5lLiAg
VmVyaWZpZXMgYWxpZ25lZCwKdW5hbGlnbmVkLCBhbmQgYnVmZmVyLXN0YXJ0IGFkZHJlc3Nlcy4K
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2RjemVyb2EuYyB8IDg4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICB8ICAx
ICsKIDIgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5jCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNn
L2hleGFnb24vdGVzdF9kY3plcm9hLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2RjemVyb2Eu
YwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOGNkY2RkNmEzYjUKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi90ZXN0X2RjemVyb2EuYwpAQCAtMCww
ICsxLDg4IEBACisvKgorICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIElu
Yy4gYW5kL29yIGl0cyBzdWJzaWRpYXJpZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcgorICovCisKKy8qCisgKiBUZXN0IHRoZSBkY3plcm9hIGluc3RydWN0
aW9uLCB3aGljaCB6ZXJvZXMgYSAzMi1ieXRlIGNhY2hlIGxpbmUuCisgKiBUaGUgYWRkcmVzcyBp
cyByb3VuZGVkIGRvd24gdG8gYSAzMi1ieXRlIGJvdW5kYXJ5OiAoYWRkciAmIH4weDFmKS4KKyAq
LworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRpbnQuaD4KKyNpbmNsdWRlIDxz
dHJpbmcuaD4KKyNpbmNsdWRlIDxoZXhhZ29uX3Byb3Rvcy5oPgorCitpbnQgZXJyOworCisjaW5j
bHVkZSAiaGV4X3Rlc3QuaCIKKworc3RhdGljIHVpbnQ4X3QgYnVmWzEyOF0gX19hdHRyaWJ1dGVf
XygoYWxpZ25lZCgzMikpKTsKKworLyogZGN6ZXJvYSB3aXRoIGFuIGFsaWduZWQgYWRkcmVzcyAq
Lworc3RhdGljIHZvaWQgdGVzdF9kY3plcm9hX2FsaWduZWQodm9pZCkKK3sKKyAgICBpbnQgaTsK
KworICAgIG1lbXNldChidWYsIDB4ZmYsIHNpemVvZihidWYpKTsKKworICAgIFE2X2RjemVyb2Ff
QSgmYnVmWzMyXSk7CisKKyAgICBmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgeworICAgICAgICBj
aGVjazMyKGJ1ZltpXSwgMHhmZik7CisgICAgfQorICAgIGZvciAoaSA9IDMyOyBpIDwgNjQ7IGkr
KykgeworICAgICAgICBjaGVjazMyKGJ1ZltpXSwgMHgwMCk7CisgICAgfQorICAgIGZvciAoaSA9
IDY0OyBpIDwgOTY7IGkrKykgeworICAgICAgICBjaGVjazMyKGJ1ZltpXSwgMHhmZik7CisgICAg
fQorfQorCisvKiBkY3plcm9hIHdpdGggYW4gdW5hbGlnbmVkIGFkZHJlc3MgKHNob3VsZCByb3Vu
ZCBkb3duKSAqLworc3RhdGljIHZvaWQgdGVzdF9kY3plcm9hX3VuYWxpZ25lZCh2b2lkKQorewor
ICAgIGludCBpOworCisgICAgbWVtc2V0KGJ1ZiwgMHhmZiwgc2l6ZW9mKGJ1ZikpOworCisgICAg
LyogQWRkcmVzcyBidWYrNDAgcm91bmRzIGRvd24gdG8gYnVmKzMyICovCisgICAgUTZfZGN6ZXJv
YV9BKCZidWZbNDBdKTsKKworICAgIGZvciAoaSA9IDA7IGkgPCAzMjsgaSsrKSB7CisgICAgICAg
IGNoZWNrMzIoYnVmW2ldLCAweGZmKTsKKyAgICB9CisgICAgZm9yIChpID0gMzI7IGkgPCA2NDsg
aSsrKSB7CisgICAgICAgIGNoZWNrMzIoYnVmW2ldLCAweDAwKTsKKyAgICB9CisgICAgZm9yIChp
ID0gNjQ7IGkgPCA5NjsgaSsrKSB7CisgICAgICAgIGNoZWNrMzIoYnVmW2ldLCAweGZmKTsKKyAg
ICB9Cit9CisKKy8qIGRjemVyb2EgYXQgdGhlIHN0YXJ0IG9mIHRoZSBidWZmZXIgKi8KK3N0YXRp
YyB2b2lkIHRlc3RfZGN6ZXJvYV9zdGFydCh2b2lkKQoreworICAgIGludCBpOworCisgICAgbWVt
c2V0KGJ1ZiwgMHhmZiwgc2l6ZW9mKGJ1ZikpOworCisgICAgUTZfZGN6ZXJvYV9BKCZidWZbMF0p
OworCisgICAgZm9yIChpID0gMDsgaSA8IDMyOyBpKyspIHsKKyAgICAgICAgY2hlY2szMihidWZb
aV0sIDB4MDApOworICAgIH0KKyAgICBmb3IgKGkgPSAzMjsgaSA8IDY0OyBpKyspIHsKKyAgICAg
ICAgY2hlY2szMihidWZbaV0sIDB4ZmYpOworICAgIH0KK30KKworaW50IG1haW4odm9pZCkKK3sK
KyAgICB0ZXN0X2RjemVyb2FfYWxpZ25lZCgpOworICAgIHRlc3RfZGN6ZXJvYV91bmFsaWduZWQo
KTsKKyAgICB0ZXN0X2RjemVyb2Ffc3RhcnQoKTsKKworICAgIHB1dHMoZXJyID8gIkZBSUwiIDog
IlBBU1MiKTsKKyAgICByZXR1cm4gZXJyID8gMSA6IDA7Cit9CmRpZmYgLS1naXQgYS90ZXN0cy90
Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCmlu
ZGV4IGFhMTc2ZTU2ODgzLi5mY2YwYmQzOGYyNiAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFn
b24vbWVzb24uYnVpbGQKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTc0
LDYgKzc0LDcgQEAgdGVzdHMgKz0gewogICAndGVzdF9jbG9iYmVyLlMnOiB7J2NmbGFncyc6IGFz
bWZsYWdzfSwKICAgJ3Rlc3RfY21wLlMnOiB7J2NmbGFncyc6IGFzbWZsYWdzfSwKICAgJ3Rlc3Rf
Y29uZF9icmFuY2guYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKKyAgJ3Rlc3RfZGN6ZXJvYS5jJzog
eydjZmxhZ3MnOiBjZmxhZ3N9LAogICAndGVzdF9kb3RuZXcuUyc6IHsnY2ZsYWdzJzogYXNtZmxh
Z3N9LAogICAndGVzdF9leHQuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9maWJv
bmFjY2kuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAotLSAKMi4zNC4xCgo=

