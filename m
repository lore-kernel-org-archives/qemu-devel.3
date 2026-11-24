Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7F606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MvYk96nZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UMeEbDQs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvo4-00072S-Hs; Tue, 24 Nov 2026 14:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvno-0006pZ-GQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnh-0006i5-Rk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:35 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXRXA2752110
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kfJuCpFmQ9ZsY2/6AEYCYMXoXkPklVmnz9AM9V30B4k=; b=MvYk96nZPadwaNus
 gENFJtu5/aM4XqukTCrGC67kQKgqWp56j0LqvHvstR9QAYVtNaoYIWuzKeb1oZp8
 4Clsm5Fmkv08EvNDTCmGmeAyoC1LzczUzZNDe1wIumaQ6AO1xiNfTiWnGbKOIeAz
 0sFbeAZg9VuIVJwSMKePebmXG7Y0aJA1ceVpTwAmCV87/xnEh6mRkqgd7/MwRIQd
 ntDp26omKoehJ1WooDPQneQCjmeSUb7QopoPWKTUpqEeeJdVIo85fmtzwaDiIm4n
 9ZguQhbMy4R7GnASKAVJl1n5eT3flag+wDPXUIH6zOugJrZeAeBY65tu8JSJKgOZ
 szYK5w==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd4jvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:28 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4b597558c4cso5661089b6e.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547008; x=1796151808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kfJuCpFmQ9ZsY2/6AEYCYMXoXkPklVmnz9AM9V30B4k=;
 b=UMeEbDQst/Hv82ODVU51E/YO5iziVaXuWtY9uv4IKR3UZIPGK4wxthGKkYQGIR1sjQ
 q7DDh4a0OlhFHX+jo/7m5hPzOTrCIKWeyObv2dttiy0AHEWVIcbDA4jGVbjjDKi04qol
 0QY0/S75qXdwcG/vlPmMCo018PY/O+Jzc/AiKIYsjxgZEZ4pcctkSJXB8PZ0XRzW9MBE
 s11VZ3xzPfmA87flPki2Vtf/RVSVD/sgR5LAcfdnYQ9FZBFhCMV7tdVKyP0N3dc1xYDZ
 9fPiE/fMQqndgbsAyFnj9H0NGN3+wIwFay/Odst7/VImK/VEgo+o81dEE3h46kAK0t0M
 fPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547008; x=1796151808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kfJuCpFmQ9ZsY2/6AEYCYMXoXkPklVmnz9AM9V30B4k=;
 b=G/8g2APZk7UdlpdD5RPNFuRM/yQFVT5rSPB4XxxhGfrnlXA9tNDzTE2ikpr/weqff3
 B2s+hGMcMaxQ0gCBdxfD+rTnIJSae2KZlK1jIT1x2QbitKtNmdPyUlZEqlBOgBLieC+J
 ZrLD0/A8U6nthNWHEIbAk5yYx+4HqKxPrSibPXIU1jQ9u0WdI9dhOp1E1Fukijh6wQAf
 ixMlh/aOlljufk0RwfkDF5P5Lok2OFLN9UF+4WulNMoHcPO/052+AezVf/Glm35UA349
 8M8JSNVpgQSEeEgALk/7EnGI/npHyYF97DwMbCxOO2o7/m9Jpu3F5Y6bmfhyAlVl0Fqd
 NpOw==
X-Gm-Message-State: APuU4Z+ugwTQt5UQbaL0fU/iGKtkM4sDbp4u7/IQ4LYIYGMb1Uy6Dk7e
 7onIc17Nc51sz9cBXRdMiYQs74vdKQbYNBv0qlv/+wo0YixjFYEzRi7mKJRtGs4LFDLxIh1Ce5I
 CcCkY5UcRYaK/UQcSwZb0bEY92TNxbF/s3+uESobBTi/4hYHsLBg1auVKMSfacaUd7Q==
X-Gm-Gg: AZFdTZfsCTeE7z88HudZbYAknWDsDqEK63Lblzuc1RTtBnrBoN3prfE1NiA4JNQDXi4
 sZo82iT4BtbzdzH6RB3isbvxPADCrsUHefmCYlKc6iLilfoXzURXIcnh6731DICLjg+K1rn2KHn
 pu8R6XJby8T//3B5XqwZQcFQk88OaCXOWsNlZZGHiIKN4JqLeopiEMVGOKWMHLEvNRmJVTQRfnM
 PO/i+YaMSFGw2677OzEjhca/Tt0V5ESGRXgUmnP8HROQ9RzjF764oWplhe4QbtSHg2pLqA270Gb
 TbtOcDRt492XyMGzpprkOF34ab9xKpfGmhaNk2kTVoVMLBmGCgTe3+GHi+OIefMJuWYDWadZToi
 ZlhTggN47QlvXRVGZtW6HN5cs2vQrOHb5l8BQoOx9eVaUTKYiw6kInGmFEnBYZt/DxYrXiOTxOn
 FGEwv5UvbFjCrjBHx1QDfkoQ==
X-Received: by 2002:a05:6808:1814:b0:4cb:f21c:a79f with SMTP id
 5614622812f47-57a0b946d49mr17227466b6e.39.1795547007577; 
 Tue, 24 Nov 2026 11:03:27 -0800 (PST)
X-Received: by 2002:a05:6808:1814:b0:4cb:f21c:a79f with SMTP id
 5614622812f47-57a0b946d49mr17227440b6e.39.1795547007152; 
 Tue, 24 Nov 2026 11:03:27 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:26 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 6/7] target/hexagon: raise decode failures at the
 faulting packet
Date: Tue, 24 Nov 2026 11:03:13 -0800
Message-Id: <20261124190314.3882017-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b05df80 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=BJZ_eTHKON5vc81CckUA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX6fC/uAnmBR5a
 6iZk87aVF/tF5Db5+o1tQhw2JCv3CQ8Bv03FRRH294wg643gsXU4X0aTsBbhXxlFqjYwoCRFLzZ
 KlTEBQ7oxX5CY4tS5xCAclKvEdl59YoxaG1fUjhn7bW+cjY2RVSX9WLAkfgo+FypHgcZEKOLlfe
 aV3cVqTL/FtNY5s/g5VPyX7RBYChKxXbL/njd+IoMYOyWizl+HE1SKpFRfPSTrJPBZ1a1xDAAdZ
 wXEH6xeVzZFeeIqKY5iU3r8Q02ixyzB5njIgDpccn+UxU8hwvhri7NdEER3WbzfSibsoGPDHa9D
 9t1vcABA3Nwv5kvNiiA245hYL95n4f8mZl6mgtthzN9oxqcI/OQUn8MWhYoNc8lzGVmXJyPLgDK
 eKYH4cjXw9D9U+5z7B6bjn9UGhVnAF4pF1fhhx7WsbWeSX6idV6+2P2xPp3TCTxR1p1qz8nKJRK
 jJM8mRcUz6awMSrL01w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfXyqcly0lB8azd
 Z751ovi/X+Q0eG+LrDDzb5/ugSfs5ipNuD5x2hDP7lrMLrGumSDQktiA5NsYK3r7e+wHSPbkaCQ
 XflXBoT2jw7PLQWDDIt3ty+EOZPb+rY=
X-Proofpoint-ORIG-GUID: 8zsxzk1j9V6cyueq9gk27v-S7PQPpKeK
X-Proofpoint-GUID: 8zsxzk1j9V6cyueq9gk27v-S7PQPpKeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QSBndWVzdCBoYW5kbGVyIGZvciBhbiBpbnZhbGlkIHBhY2tldCBvciBvcGNvZGUgc2tpcHMgdGhl
IHBhY2tldCBieQphZHZhbmNpbmcgRUxSIHBhc3QgaXQuICBnZW5fZXhjZXB0aW9uX2RlY29kZV9m
YWlsKCkgcmFpc2VkIHRoZSBleGNlcHRpb24KYXQgdGhlIGFkZHJlc3MgYWZ0ZXIgdGhlIHBhY2tl
dCB3b3Jkcywgc28gdGhlIGhhbmRsZXIgc3RlcHBlZCBvdmVyIHRoZQpwYWNrZXQgdGhhdCBmb2xs
b3dlZCBhcyB3ZWxsLiAgSW4gc3lzdGVtIG1vZGUgcmVwb3J0IHRoZSBhZGRyZXNzIG9mIHRoZQpm
YXVsdGluZyBwYWNrZXQuICBsaW51eC11c2VyIGtlZXBzIHJlcG9ydGluZyB0aGUgYWRkcmVzcyBh
ZnRlciB0aGUgd29yZHMsCndoaWNoIGlzIHdoZXJlIHRoZSBpbnZhbGlkIGVuY29kaW5nIHRlc3Rz
IHJlc3VtZS4KClRoaXMgZW5hYmxlcyB0aGUgbGxzY19vbl9leGNwIHN5c3Rlc3QuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKy0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICA1ICsrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYwppbmRleCAyNDYxYjAwNjRhMi4uZjEwZmMyYzgzOTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0y
NzEsMTMgKzI3MSwyMiBAQCB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IGNhdXNlKQogICovCiBzdGF0aWMgdm9pZCBnZW5fZXhjZXB0aW9uX2RlY29k
ZV9mYWlsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbndvcmRzLCBpbnQgY2F1c2UpCiB7Ci0gICAg
dGFyZ2V0X3Vsb25nIGZhaWxfcGMgPSBjdHgtPmJhc2UucGNfbmV4dCArIG53b3JkcyAqIHNpemVv
Zih1aW50MzJfdCk7CisgICAgdGFyZ2V0X3Vsb25nIG5leHRfcGMgPSBjdHgtPmJhc2UucGNfbmV4
dCArIG53b3JkcyAqIHNpemVvZih1aW50MzJfdCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQor
ICAgIHRhcmdldF91bG9uZyBmYWlsX3BjID0gbmV4dF9wYzsKKyNlbHNlCisgICAgLyoKKyAgICAg
KiBBIGd1ZXN0IGhhbmRsZXIgc2tpcHMgdGhlIHBhY2tldCBieSBhZHZhbmNpbmcgRUxSLCBzbyBp
dCBtdXN0IGJlIHRoZQorICAgICAqIGFkZHJlc3Mgb2YgdGhlIGZhdWx0aW5nIHBhY2tldCBhbmQg
bm90IHRoZSBvbmUgYWZ0ZXIgaXQuCisgICAgICovCisgICAgdGFyZ2V0X3Vsb25nIGZhaWxfcGMg
PSBjdHgtPmJhc2UucGNfbmV4dDsKKyNlbmRpZgogCiAgICAgZ2VuX2V4ZWNfY291bnRlcnMoY3R4
KTsKICAgICB0Y2dfZ2VuX21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgZmFpbF9wYyk7CiAg
ICAgZ2VuX3ByZWNpc2VfZXhjZXB0aW9uKGNhdXNlLCBmYWlsX3BjKTsKICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47Ci0gICAgY3R4LT5iYXNlLnBjX25leHQgPSBmYWlsX3Bj
OworICAgIGN0eC0+YmFzZS5wY19uZXh0ID0gbmV4dF9wYzsKIH0KIAogc3RhdGljIGludCByZWFk
X3BhY2tldF93b3JkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgsCmRp
ZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IGY5OTc1NjNiYWNh
Li40MTMwYzFiNGVlMSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
c3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMu
cHkKQEAgLTkyLDYgKzkyLDExIEBAIGRlZiB0ZXN0X2ZyYW1lbGltaXQoc2VsZik6CiAgICAgICAg
IGV4Y2VwdGlvbiBhdCB0aGUgYWxsb2NmcmFtZSBwYWNrZXQuIiIiCiAgICAgICAgIHNlbGYucnVu
X2V4aXRfemVybygiZnJhbWVsaW1pdCIpCiAKKyAgICBkZWYgdGVzdF9sbHNjX29uX2V4Y3Aoc2Vs
Zik6CisgICAgICAgICIiIkFuIGV4Y2VwdGlvbiBiZXR3ZWVuIGEgbG9hZC1sb2NrZWQgYW5kIHRo
ZSBzdG9yZS1jb25kaXRpb25hbAorICAgICAgICBjbGVhcnMgdGhlIHJlc2VydmF0aW9uLiIiIgor
ICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImxsc2Nfb25fZXhjcCIpCisKICAgICBkZWYgdGVz
dF9hY2Nlc3Moc2VsZik6CiAgICAgICAgICIiImFjY2VzcyBjaGVja3MgUl9PS3xXX09LIG9uIF90
ZXN0ZmlsZV9hY2Nlc3MuIiIiCiAgICAgICAgIHRlc3RmaWxlID0gc2VsZi5zY3JhdGNoX2ZpbGUo
Il90ZXN0ZmlsZV9hY2Nlc3MiKQotLSAKMi4zNC4xCgo=

