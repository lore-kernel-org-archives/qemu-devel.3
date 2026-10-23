Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628A606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoTIpdUj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P8cHNzqj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Qy-0000pU-CS; Thu, 22 Oct 2026 21:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qo-0000TD-Nu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:50:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Ql-0006GX-Fk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:50:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1F1Pp2389451
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=; b=QoTIpdUj1tjDmtHd
 HZNww16qZl7U2YlAOP0QzL5C6TZ5606lgVYVU8qlyjfqNtb//YJB4OpaF1mPMa4J
 6WUjImcqYy2vXica6nmX2yfA4NrFVZH4TSrNj9k/+7ES8DiePTzoSXe3uTt4pGh3
 /PXbLSmgyahbr5mfntvCCJ+VaZn7pa/WhAHI++UtI2t5TCmsC9/0RHmNmdevFSe0
 mt0VNe0HlboRpamYw+1g0sCZX2s/QTuIC9kxWXc1OUKkDDO4UHr1r6Zz9E0pqDCy
 r1TQ/n3c7l47ol4c9iMjjMxDXlfuMi4ffEz8Co1ZVjuzdqIF9LkOOajovaJ+uByr
 SIRhHg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp9c6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso668817eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720249; x=1793325049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=P8cHNzqjaFbnKJ3Y1T7YmDuHJhQorG4F8nTf/aOL57KgDoIMU5VKyLk0ItMesVepl/
 Fbh1/y2Sm5thitZ/rwEowDJAYTRV4z9zvHL3BHt3yjfNxzTHhG3Gk4hvrJoOVQqiJvm+
 JUpR9lETRPXLXov013ngzfL0OJnJ4EorTe/gHMdGhYc9Nmj4XhGI3yOyC2OtjzNxdcK0
 aKKpY4fkr+nGXIAScKdRRomV7ZzTwbGTgA7GhOcPUK5hZ+90vSccZGX0iNwsxfWSY2dU
 DW7JCnf4P+Rz9ZLw8oHCvTbgnir7YZvGDWl3SLPEZnS/Gna/X1SVb91OfVSAUtHG7uEp
 jpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720249; x=1793325049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=fz3vc5KHEB0WNrEZCNlwNZ9+3gPfAlk42/UQS5rjc9V74e1xM0fw7yRa8zWeTbbJZF
 /YAx1OD2K8zbTnbD7xTFNtPhyF+uH0BWqMALwBwHUqDm1DTPRi/7HpicuvjUGvZ0jBTX
 NQJ6CrFZjTell3dPd0pYoGN4tyud5I9nxE5o5sap0JUG4y9A9vECHZxKwb/mUKzoJ/MM
 VBW6seGQWbVds3PPV7qRP5i8FKNiCq5tBCi8jtsgveIMCt1MVdjXMQbtB2vYNF5Ynn4o
 uR7wo7/61PwnloBWrXWsxU2wgULmedbNQVUR0oh2hQIad8Z8SB5d1YNklm7bciS9qymM
 NNuQ==
X-Gm-Message-State: AFq9FYJbOmvkXNzRm5FYM5p2FBMFFQ2IdD8VdnuCt9+dR3wuqEbqa9Ti
 R6R75CiUy84JP1u+D4pUXCBigQhKYw3KNCh3/ETWmUw82ZYcAcedRzJW51eRSySPowcRNctlD4K
 /4JF+FvOTzVFALIJ8IDLDlkOKjBdp561Fs8N8AKCzIM50Dy2pR6cC4LP1ztZsf3M5fQ==
X-Gm-Gg: AYBFou0cZ4ufPS7AY1/KDivHj0CnkoEH7etxY3j6H2fS4AES/Tt4ll40JK6uyLDI1sC
 iqHWkXgIRVVf8uhwTBKUw3kXeq/Ck2AbNYrpmXZ9jUUGqsvk/h3YBl09/TH6G8sq0igVpk81kDB
 ppwgyVErObYsc+Kj/QcWTPtiriRliiH7MtjlHg36tGArZXF4TT2JxcNpfj+wB+o0vI4YX4aDGKn
 yTbdYXsWiyQniW0uHe2Zilu1xQ5W4QK75mDyfiwNs73KQCiDmqMWr/jOPVHm2AGZt5PIEjDVSj2
 /c+8x915dXwVL1u9ZWeCT1P2/4IU/LSHztbMi8/c+owdYkzB7Ddm1v+f3XN30lEipbQMQXqgD/s
 LWaFpBQcrfwzQpLTCBWuyvipFIJ6CU9CzxscY7fWV+A9ciSb7
X-Received: by 2002:a05:693c:20c2:20b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-369d9841c2emr1060657eec.32.1792720248880; 
 Thu, 22 Oct 2026 18:50:48 -0700 (PDT)
X-Received: by 2002:a05:693c:20c2:20b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-369d9841c2emr1060617eec.32.1792720248273; 
 Thu, 22 Oct 2026 18:50:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:50:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/43] target/hexagon: fix allocframe FRAMEKEY scrambling
Date: Thu, 22 Oct 2026 18:49:59 -0700
Message-Id: <20261023015040.2473105-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXwxz6hV5dQOUa
 brLcXF3eIXnxFJcuaW1YTZ0Gik5jxMznaEgkmhynmWMYszj2KrKoyHUpDxw5QoD59xPu8oTg5yY
 cZkHeMpoXRt3nIQMZp8ktQUtQ1uM9rU=
X-Proofpoint-GUID: Qxez8oPG8exffjnjvHFohOWu2dpm-BS1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX6HkBIN9gtXCk
 8F2NL3edBGbIRm9CcpR6bkS/HJcJPc0A7ALhPJ2G2gdiTfFgBoXNpyb7hmd69zH6m5qJBN2qHWU
 pOnL6xVgDoAIVNUkVUYQxNhVnQrvrrxrdGUIjfTFY2TK7lIi+t/qVtYhRadfZZ4NcELjyqkOTqJ
 OcvAWcqZZAN8q1ekl1oSfB9n9140qJAwIPBz4o61CAiTRCC4w/N/4YlIKRH8jySbrQ0O9Jylxkh
 S1fMA91GBoCSWBWlZ35I66SXqNMA1BH8//1QQiKGl52zI9Kaunvq0CH2wpQJfhMveM2VnIJJu9P
 amFqoyjobEOIvqrcbO9H2Wi0iQgylQRecETPE8X2il28LXiSVpVu0UXoTmmnvldAvLpmCdYV5gq
 kUK8uNIPAkBEclToC8WT36AdgmnNh8HyfoQrNE9wSibhiLw/lA0EFxm9CrZUP1T8MiWZ94ekcKR
 thUDKQwsE/0xJaNRQ3A==
X-Proofpoint-ORIG-GUID: Qxez8oPG8exffjnjvHFohOWu2dpm-BS1
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adabd79 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=aMyhTJ8ZNNJ-BQydHqwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
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

VGhlIGFyY2hpdGVjdHVyZSBzY3JhbWJsZXMgb25seSB0aGUgTFIgd29yZCBvZiB0aGUge0ZQLCBM
Un0gZnJhbWUgdGhhdAphbGxvY2ZyYW1lIHN0b3Jlcy4gIFdpdGggdGhlIGlkZWYgcGFyc2VyIGVu
YWJsZWQsIGZGUkFNRV9TQ1JBTUJMRSBidWlsdAp0aGUgWE9SIGtleSB3aXRoIEZSQU1FS0VZIGlu
IGJvdGggaGFsdmVzIG9mIHRoZSA2NC1iaXQgdmFsdWUsIHNvIHRoZQpzdG9yZWQgRlAgd2FzIHNj
cmFtYmxlZCBhcyB3ZWxsLgoKZGVhbGxvY2ZyYW1lIGlzIGFsc28gcGFyc2VyLWdlbmVyYXRlZCBh
bmQgYXBwbGllcyB0aGUgc2FtZSBpbmNvcnJlY3QKdHJhbnNmb3JtIGEgc2Vjb25kIHRpbWUsIHdo
aWNoIG1hc2tzIHRoZSBlcnJvci4gIGRlYWxsb2NfcmV0dXJuIHVzZXMgdGhlCmhhbmQtd3JpdHRl
biBUQ0cgaW1wbGVtZW50YXRpb24gdGhhdCBjb3JyZWN0bHkgZGVzY3JhbWJsZXMgb25seSBMUiwg
c28KaXQgbGVhdmVzIEZQIGNvcnJ1cHQgd2hlbiByZXR1cm5pbmcgZnJvbSBhIGZyYW1lIGFsbG9j
YXRlZCBieSB0aGUgcGFyc2VyLgoKQWRkIGEgcmVncmVzc2lvbiB0ZXN0IHRoYXQgc2V0cyBhIG5v
bnplcm8gRlJBTUVLRVksIGFsbG9jYXRlcyBhIGZyYW1lLAphbmQgcmV0dXJucyB0aHJvdWdoIGRl
YWxsb2NfcmV0dXJuIHRvIHZhbGlkYXRlIHRoZSByZXN0b3JlZCBGUC4KClVuY292ZXJlZCBieSB0
ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClJldmlld2VkLWJ5OiBNYXJjbyBM
aWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyB8ICAyICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9m
cmFtZWtleS5jICAgICAgICAgICAgICAgIHwgNTQgKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0
cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgIDEgKwogMyBmaWxlcyBj
aGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgYi90YXJnZXQvaGV4YWdvbi9pZGVmLXBh
cnNlci9wYXJzZXItaGVscGVycy5jCmluZGV4IDQ5Y2MxMWZkZGQ4Li4xNDg0MGQ5ODczNyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCkBAIC0xOTg5LDcg
KzE5ODksNyBAQCBIZXhWYWx1ZSBnZW5fcnZhbHVlX2ZzY3IoQ29udGV4dCAqYywgWVlMVFlQRSAq
bG9jcCwgSGV4VmFsdWUgKnZhbHVlKQogICAgICp2YWx1ZSA9IGdlbl9ydmFsdWVfZXh0ZW5kKGMs
IGxvY3AsIHZhbHVlKTsKICAgICBPVVQoYywgbG9jcCwgImdlbl9yZWFkX3JlZygiLCAmZnJhbWVf
a2V5LCAiLCBIRVhfUkVHX0ZSQU1FS0VZKTtcbiIpOwogICAgIE9VVChjLCBsb2NwLCAidGNnX2dl
bl9jb25jYXRfaTMyX2k2NCgiLAotICAgICAgICAma2V5LCAiLCAiLCAmZnJhbWVfa2V5LCAiLCAi
LCAmZnJhbWVfa2V5LCAiKTtcbiIpOworICAgICAgICAma2V5LCAiLCB0Y2dfY29uc3RhbnRfdGwo
MCksICIsICZmcmFtZV9rZXksICIpO1xuIik7CiAgICAgT1VUKGMsIGxvY3AsICJ0Y2dfZ2VuX3hv
cl9pNjQoIiwgJnJlcywgIiwgIiwgdmFsdWUsICIsICIsICZrZXksICIpO1xuIik7CiAgICAgcmV0
dXJuIHJlczsKIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMgYi90
ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwLi4xNGM3ZmNiYzY1NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2ZyYW1la2V5LmMKQEAgLTAsMCArMSw1NCBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgUXVh
bGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAq
ICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNs
dWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorCitpbnQgZXJyOworCisjaW5jbHVk
ZSAiaGV4X3Rlc3QuaCIKKworLyoKKyAqIGFsbG9jZnJhbWUgcHVzaGVzIHtMUiwgRlB9LCBzY3Jh
bWJsaW5nIExSIHdpdGggRlJBTUVLRVkuICBSZXR1cm4gdGhyb3VnaAorICogZGVhbGxvY19yZXR1
cm4gYW5kIHJlcG9ydCB0aGUgRlAgdGhhdCBpdCByZXN0b3Jlcy4KKyAqLworc3RhdGljIGlubGlu
ZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCkKK3sK
KyAgICB1aW50MzJfdCBmcF9iYWNrLCBzYXZlZF9mcCwgc2F2ZWRfbHI7CisKKyAgICBhc20gdm9s
YXRpbGUoIiVbc2F2ZWRfZnBdID0gcjMwXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVbc2F2ZWRf
bHJdID0gcjMxXG5cdCIKKyAgICAgICAgICAgICAgICAgImZyYW1la2V5ID0gJVtrZXldXG5cdCIK
KyAgICAgICAgICAgICAgICAgInIzMCA9ICVbZnBdXG5cdCIKKyAgICAgICAgICAgICAgICAgInIz
MSA9ICMjMWZcblx0IgorICAgICAgICAgICAgICAgICAiYWxsb2NmcmFtZSgjMClcblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY19y
ZXR1cm5cblx0IgorICAgICAgICAgICAgICAgICAiMTpcblx0IgorICAgICAgICAgICAgICAgICAi
JVtmcF9iYWNrXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVbemVy
b11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1cblx0IgorICAgICAg
ICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAgICAgICAgOiBbZnBf
YmFja10gIj0mciIoZnBfYmFjayksCisgICAgICAgICAgICAgICAgICAgW3NhdmVkX2ZwXSAiPSZy
IihzYXZlZF9mcCksIFtzYXZlZF9scl0gIj0mciIoc2F2ZWRfbHIpCisgICAgICAgICAgICAgICAg
IDogW2tleV0gInIiKGtleSksIFtmcF0gInIiKGZwKSwgW3plcm9dICJyIigwKQorICAgICAgICAg
ICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAgICByZXR1cm4gZnBfYmFjazsKK30K
Kworc3RhdGljIHZvaWQgY2hlY2tfZnJhbWUodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCkKK3sK
KyAgICBjaGVjazMyKGZyYW1lX3JvdW5kdHJpcChrZXksIGZwKSwgZnApOworfQorCitpbnQgbWFp
bigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwgMHgxMjM0ZmZmMCk7CisgICAgY2hlY2tfZnJhbWUo
MHhmMjFmMjBhMCwgMHgxMjM0ZmZmMCk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNT
Iik7CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21l
c29uLmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3
YzIuLjBmZDYyY2U3ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWls
ZAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0
ZXN0cyArPSB7CiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6
ICdoZXgtb3ZlcmZsb3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwK
ICAgJ2R1YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzog
eydjZmxhZ3MnOiBjZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFn
c30sCiAgICdtZW1fbm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVm
X2V4Y2VwdGlvbi5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

