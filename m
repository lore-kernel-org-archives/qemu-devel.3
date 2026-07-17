Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E5CC44524
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2a-0006pk-WA; Fri, 17 Jul 2026 15:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2Z-0006p9-2s
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2X-00084y-J6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo6Of2344734
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 njuO05NTJQp6SvpT4Ks6OjCaxWfJHjkBxMIIyz4Wbzs=; b=FQ4ipItGt0o1W8t9
 bMJ5nh7u4SOIhmvWaQfUmgrcCw7MClSO6WZlK98mr0om4XhQxJvK3XprGPV3zj16
 YTfxCDJm8TyRKHeJt7gkgk5X7dfhX358meEUeMfnjBV7NReXlc1kj2A9PoPS0BDr
 FP0YVl6ZLrSoNihl74S7OlBYefxo6d785DP78Fje7eMavvlSpJYx+aGizXfu9l3d
 3BLbGhqh/wVxGF0s1+gTMDJ8swq9TgAOhftMFvZ6oUDnXTHBjNSYGfGsy76DSDB1
 iK/rMzDS0t/72zE4K1VJt9OhVrqH3xZG15L1ghuy4+UvQvrFhXC/o34syA/a1C+/
 ouW4zg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug10t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so156927795ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315763; x=1784920563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=njuO05NTJQp6SvpT4Ks6OjCaxWfJHjkBxMIIyz4Wbzs=;
 b=FR3+YLAxAOGUAFuiQGjl/WaBLBVns+cHBIITIBKrd+SOYp4xcx1xCD9Rwv2gCZbLRF
 ik/JhSMSx0+O7rYl6D6eJySlVWQdCGGM9XwZ0zZiZnQxGD6BKb/eEOi169/C467yWC1W
 sJRqyrjvkNQdYgrMssrKmzQl0qskITSyyTLyTsDYc5eEaVbT+s5gxnri5mUccjdkZLlF
 WktV8Voyua+1sBdoFS/IBTE+29eLJ/aq4aeWeoOAdVQmWzl4JI/viK+FgowA+Agk6Pbd
 V8DdAqmjzwyD3a70m9kRFJGfIy9vf29LF1xzRJRDzOtcR/WEec9bBElxQgwNSkHFGHy9
 bdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315763; x=1784920563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=njuO05NTJQp6SvpT4Ks6OjCaxWfJHjkBxMIIyz4Wbzs=;
 b=DfmGimanS8ojsuhCy/pIoH6NcYCDEQT6d4kXRDrRHrTP08hp6jx9lXDzl/6R7MJ/LQ
 Df1kyfoHe8jB7jTN5+5DIYa0UC8AADHmLEc83Pk1/XtzTYg63/T79LRSWhrcH4+ufjnj
 zXy9hcjLbKPa4dw8S9ohjPrAPfqk6c7ZnzzDC3J0rVqDtWtE0foWF1gAryEbg+Z8E33O
 cGfLN8VwD6UsRK7apTl9VQ2EvyC3aZSqM4i7yfZNI0VDr8YidhR/VX++JL9LEGNO+hbY
 muZoyYjbXqA1PnHbcAdI4wBtHTevRsRUF4TKA9EXYFmP/xji14pdWKlicsu3itMabNFQ
 46wQ==
X-Gm-Message-State: AOJu0YzIJo6Nmiut+R+ZEzSGUwxY50CH/Ha7Q7udhDVIKPx3B2p4oChZ
 xdXPoGO0CUQJiDQ0z4M9TDF2gGxvKBGXrXPskfMFYDpeC0Y8JbFjABfukDRn2pZJzIkd5/PM/57
 ZrjYwnC0BdY0W4toMhEiO/andvK6RNBx2gSfojBvodk0wi96j/Ey4HOv+0B1bUoazNg==
X-Gm-Gg: AfdE7ck4FSNmkQJOEaH8AvWDd5orIuF/A0kglr7QajZ3Y606FSZRg0p1eze8XDQu78n
 213WAad0pvIig44nR4atvXaiGKAvc8j9/CobnHqCjFByiuRS5FFkV0ZMMVsecYaGzwPheoO7WRn
 V3fc9ijN0HI6hniqRD+Fj1HisrvjtWnzkxc2s+WE/JnS8XwZy72nZcL+IPhwoqxasNdgVEFY/3I
 RBTmfemBTfd4vg6p47KlSpilqfvDDxjEpjaygqM7R01kY+j03sYelAmv9QZE0CBLgCZrmfcDgFh
 L8zAypIoGUSB3/azVbigMX+zF1HCA/YBDkTwYFpC7Axn/rxVauk1LyrPLeDmI2WLpedzB9Y5Puj
 pCpqLCQdg7iKFD1/uNt6AFAVdXzD3pVNuQPT3wZ4ZwcyWl68e
X-Received: by 2002:a17:90b:4b0e:b0:38d:e5d0:9bd with SMTP id
 98e67ed59e1d1-38e4b52ebfcmr4452004a91.26.1784315763432; 
 Fri, 17 Jul 2026 12:16:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0e:b0:38d:e5d0:9bd with SMTP id
 98e67ed59e1d1-38e4b52ebfcmr4451950a91.26.1784315762853; 
 Fri, 17 Jul 2026 12:16:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:16:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PULL 07/12] target/hexagon: raise SIGBUS on unaligned data access in
 sysemu
Date: Fri, 17 Jul 2026 12:15:42 -0700
Message-Id: <20260717191547.920048-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX1ZaRDkWJgEas
 qmF0IVdpj70gvfRTSefKtI8U13+CtIoAAG+RDXqESjvyc/Rf7ofnzxidC65qz88+oTD7HXQhW7D
 e8JrJz7QcIz8c6pVc/F+948+Rv9sdCOmnYFXlUtfUmE/83Zgc1PRej3FoblwVkZCQ4vBRZ3GgTW
 5feCTtROSgjXIoDH7dgMomDQtAFTUBtIVU6wMfKR8rYJ8xc+9VWTPOz4TiGyN2lxaqiV21VVNHB
 /nOySnkwreeymB/Zha6ke8cLSUZFdvMlsbm8XjkZ6FCoxfMJ0RXVBGdePfC8PjfLyxcvPeQyzwy
 P7UU0WyCO7m0QIRMSf32GPtBfro5Ur95vyyFUXN7kB88FDRX6+XniiNx9EmpLhk8yLP0Ui+nPiK
 jgm7hBHnwM+hr4rtl8SX44LOvqPQS/lEWzSk8OfzvIOjHlL27NIU8zFPxJAoO3RHhu6W33bvkxW
 3BUu+jYXserLpF8l7bw==
X-Proofpoint-GUID: drCmZamzb9cFjxzt-tqOI1E7gPV-KypE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfXwxhWVFWzyIPF
 gSjlSFGPcCkc2cSuYkj0rvXpR5tinoVlHC/3T52oTC3RUSyrG4uAZC1sRGpg+PAkHJ2EuDlnq9o
 mjIq50NjGom5b2ZlbrYeBgoyszsNM2M=
X-Proofpoint-ORIG-GUID: drCmZamzb9cFjxzt-tqOI1E7gPV-KypE
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a7f74 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QWbXAH-yNWLVfgUa_9MA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170197
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

aGV4YWdvbi1zb2Z0bW11IGhhZCBubyBlbmZvcmNlbWVudCBvZiBhbGlnbm1lbnQgZm9yIHNjYWxh
ciBsb2FkcyBhbmQKc3RvcmVzOiB0aGUgTU9fQUxJR04gZmxhZyBhZGRlZCBieSB0aGUgcHJldmlv
dXMgdHdvIGNvbW1pdHMgdHJpZ2dlcnMKVExCX0lOVkFMSURfTUFTSy9hbGlnbm1lbnQgZmF1bHRz
IGluIGNwdXRsYi5jLCBidXQgSGV4YWdvbidzClRDR0NQVU9wcyBkaWQgbm90IGltcGxlbWVudCBk
b191bmFsaWduZWRfYWNjZXNzLCBzbyB0aGUgZmF1bHQgd2FzCm5ldmVyIGRlbGl2ZXJlZCB0byB0
aGUgZ3Vlc3QuCgpBZGQgaGV4YWdvbl9jcHVfZG9fdW5hbGlnbmVkX2FjY2VzcygpLCB3aGljaCBy
YWlzZXMKSEVYX0NBVVNFX01JU0FMSUdORURfTE9BRC9fU1RPUkUgdmlhIHRoZSBleGlzdGluZyBI
RVhfRVZFTlRfUFJFQ0lTRQpwYXRoLCBtaXJyb3JpbmcgcmFpc2VfdGxibWlzc19leGNlcHRpb24o
KS9yYWlzZV9wZXJtX2V4Y2VwdGlvbigpLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hdGhldXMg
VGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDQyZDkzZTVkYTQ3Li5lMmFm
NzM2YTk5ZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKQEAgLTYzNyw2ICs2MzcsMTggQEAgc3RhdGljIHZvaWQgcmFpc2VfcGVybV9l
eGNlcHRpb24oQ1BVU3RhdGUgKmNzLCB1aW50MzJfdCBWQSwgaW50IHNsb3QsCiAgICAgY3MtPmV4
Y2VwdGlvbl9pbmRleCA9IGV4Y3A7CiB9CiAKK3N0YXRpYyB2b2lkIHJhaXNlX21pc2FsaWduZWRf
ZXhjZXB0aW9uKENQVVN0YXRlICpjcywgdWludDMyX3QgVkEsIGludCBzbG90LAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSkK
K3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworICAgIGludDMyX3Qg
ZXhjcCA9IChhY2Nlc3NfdHlwZSA9PSBNTVVfREFUQV9TVE9SRSkgPworICAgICAgICAgICAgICAg
ICAgIEhFWF9DQVVTRV9NSVNBTElHTkVEX1NUT1JFIDogSEVYX0NBVVNFX01JU0FMSUdORURfTE9B
RDsKKworICAgIHNldF9iYWR2YV9yZWdzKGVudiwgVkEsIHNsb3QsIGFjY2Vzc190eXBlKTsKKyAg
ICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVYX0VWRU5UX1BSRUNJU0U7CisgICAgZW52LT5jYXVz
ZV9jb2RlID0gZXhjcDsKK30KKwogc3RhdGljIGNvbnN0IGNoYXIgKmFjY2Vzc190eXBlX25hbWVz
W10gPSB7ICJNTVVfREFUQV9MT0FEICIsICJNTVVfREFUQV9TVE9SRSIsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIk1NVV9JTlNUX0ZFVENIIiB9OwogCkBAIC03
MTUsNiArNzI3LDE4IEBAIHN0YXRpYyB2YWRkciBoZXhhZ29uX3BvaW50ZXJfd3JhcChDUFVTdGF0
ZSAqY3MsIGludCBtbXVfaWR4LAogICAgIHJldHVybiByZXN1bHQ7CiB9CiAKK3N0YXRpYyBHX05P
UkVUVVJOCit2b2lkIGhleGFnb25fY3B1X2RvX3VuYWxpZ25lZF9hY2Nlc3MoQ1BVU3RhdGUgKmNz
LCB2YWRkciBhZGRyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGludCBtbXVfaWR4LAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnRwdHJfdCByZXRhZGRyKQoreworICAgIENQVUhleGFnb25TdGF0
ZSAqZW52ID0gY3B1X2Vudihjcyk7CisKKyAgICByYWlzZV9taXNhbGlnbmVkX2V4Y2VwdGlvbihj
cywgYWRkciwgMCwgYWNjZXNzX3R5cGUpOworICAgIGRvX3JhaXNlX2V4Y2VwdGlvbihlbnYsIGNz
LT5leGNlcHRpb25faW5kZXgsIGVudi0+Z3ByW0hFWF9SRUdfUENdLAorICAgICAgICAgICAgICAg
ICAgICAgICByZXRhZGRyKTsKK30KKwogI2VuZGlmCiAKIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMg
aGV4YWdvbl90Y2dfb3BzID0gewpAQCAtNzMyLDYgKzc1Niw3IEBAIHN0YXRpYyBjb25zdCBUQ0dD
UFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewogICAgIC5wb2ludGVyX3dyYXAgPSBoZXhhZ29uX3Bv
aW50ZXJfd3JhcCwKICAgICAuY3B1X2V4ZWNfcmVzZXQgPSBjcHVfcmVzZXQsCiAgICAgLnRsYl9m
aWxsID0gaGV4YWdvbl90bGJfZmlsbCwKKyAgICAuZG9fdW5hbGlnbmVkX2FjY2VzcyA9IGhleGFn
b25fY3B1X2RvX3VuYWxpZ25lZF9hY2Nlc3MsCiAgICAgLmNwdV9leGVjX2hhbHQgPSBoZXhhZ29u
X2NwdV9oYXNfd29yaywKICAgICAuZG9faW50ZXJydXB0ID0gaGV4YWdvbl9jcHVfZG9faW50ZXJy
dXB0LAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCi0tIAoyLjM0LjEKCg==

