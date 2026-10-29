Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE44606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=biuWiwSA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h2i/a9Ld
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVPG-0000Ya-5N; Thu, 29 Oct 2026 15:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOP-0000JJ-Bf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOM-0003zy-No
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxDI3872933
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tfkGM3MpGqHPYM69Z0DKF3kIZ4QYMTe2f5ICrFlr1R8=; b=biuWiwSA/qxv+uEw
 mKQYdBar1gZsSYxJqTlBpt3LeDbopfnIFhUt91tfbh1TSjyRZ1h5oeSxF1w5FCt9
 7imLpuTWOk4Peq+s8yYhCMXUqJFQCQkRFYv+K7eMqKy3lsLKtdBk+nQyHmaM4TVk
 KhBosVqwMmqgAMqR+NMwsrIDGNK1krn3Z8hVLy/ui/iuPcgY8/MGnRlPLywnidBL
 LGRXJhhFucRPmrs69RMK36nhIqYJKyptxh5mEoxXBxNj8lpLsF8DhSNBE6go6yOY
 OAKo6gINFMTIKz6IBVvkD34BceSkHgux9VmtQSKBe9ZIVQR4hujb1Fi0a6ARfK0g
 kzofuQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm7621p41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso5028052eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793300544; x=1793905344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tfkGM3MpGqHPYM69Z0DKF3kIZ4QYMTe2f5ICrFlr1R8=;
 b=h2i/a9LdKgxp7Lnz4C07R3RgD0rDGI/4SGLA9BreMj27qFS8+TwprbFV6pW7Y7RTli
 WeLZ68uWpAr35ik9Ah6rXiQx4EaQyVEC9R1USRACrqbx5Z/UAVqRtRb/T5udUdJVzy14
 nEFoH0nTs2SKvsD4oNFXdFmMezkJnFdyBFKFJYMqPkUWJOaCysYThjOCYJ+cpkLLqckk
 tGH6l3VifGvOgMrA61xlUwpiZUgNkQ0mxsGoAvE9VsL8nfprz3rlejf2kDfPrCdfM9oF
 EeNZoTmVeoE0wRByUSNB0j5UKFxbkc/h9iB0NostaeB0kYYBVt77tTOppnO1e7/S5MrF
 S/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300544; x=1793905344;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tfkGM3MpGqHPYM69Z0DKF3kIZ4QYMTe2f5ICrFlr1R8=;
 b=aNtUtGaldJq9QdvqysJwK9hZsMjbpKV53OgZtSSPCpqgbuoeqKizULTx9VDuhUwynf
 VDngLOy5Jw+1rhnM5nxyNevfg70wFucsCA3xVLeLiRMTs0DPqhdoR/lIFfvKKw7vUSkh
 0V8UgR1qqjQDYusWfcjIFqhOewhw5YWRYNDrKatkpP09LCBuGA2AlelXd84K7SyI8zAW
 bX03x56emBbIIavUlh/1XlYw6p3y31OUZWOWx00dGbdTGuLobynHtRczJ7TTtU7zPV8i
 Y/ogtAoxDSOx1fH8S/lViEXrdYr6hcCGkftL6ttusm22wTgOZdQeyU3gaBCURH/FBAg1
 Cxug==
X-Gm-Message-State: AFq9FYI1OiCW+WVcMGZAy2kkL33sdhjEkPe/RQVX8UlAxAqf5dwZgsVm
 B95JDs2bELAir8w2dzJBCF7TnS6o2JI+G66DxfxA04hvB1biVlq/INzm08s97YDuKZBNrRkD9sz
 urlZEuVE3ynYYG6PgxuOU7PU1b5r6cPlVbc2pg5ClGPfcDRz+vOYOKD7HTJIQCLs4Sg==
X-Gm-Gg: AYBFou0ZKHg3D0aylYgShGhSNs7aoCTEmUDQlbCc1gt4wGk4VB2w678LunbS3yGB8Gq
 9aVRN1Z6cJask29UezmC83ZqgbrsY6OnPcSgQSxZe05+UWIGs8O29aWzHN7SEApNE9kQhVCXujG
 caPcYwQqnn6u72QKnNp7y8mz0Fg9gbgmzdq2uSrPSZLcSmIDemDMcGILCmvbbcG1pytMGyVtGVi
 UtD9gwxgHiEbAChRp/YWNv9uHMVvjuHjc+k2p0JXXFH20xs3TyAbP3ZHISYybDa5kIv8Xbz7Xbi
 yX24f3ljrUySbosXZ7hrH6VBP20+TsnOmmaBI7ro0rZJ/kG4ss5YkKrtRjTvBqYiAnGX5gS+AzH
 82nzcX65FHjiU1DbMGU1t7yca1hyDY1RwIDRdPeQ0F474iDz2/solXalfo76UbkY/hucHK4O6Ei
 g+HVOtCnA=
X-Received: by 2002:a05:693c:20c2:10b0:369:f9b6:f486 with SMTP id
 5a478bee46e88-36a4260db8cmr350076eec.41.1793300543167; 
 Thu, 29 Oct 2026 12:02:23 -0700 (PDT)
X-Received: by 2002:a05:693c:20c2:10b0:369:f9b6:f486 with SMTP id
 5a478bee46e88-36a4260db8cmr350036eec.41.1793300542358; 
 Thu, 29 Oct 2026 12:02:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm480598eec.28.2026.10.29.12.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:02:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/6] tests/functional/hexagon: update release assets to v0.3.1
Date: Thu, 29 Oct 2026 12:02:08 -0700
Message-Id: <20261029190208.1169519-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7KRd967QywVIqUe4GdQKw0JBRD-IiB0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfXxk2BRwddY/uZ
 KULbU5aetUCxa+tY0rjb73zF7hNfakfvoJVDcfBBzPs1qtpdFAH7WQ90PF1dpOOV2Is4jUudEY0
 KVD5LxTGuce/0TUoDp4p8P5n97CnePETHEifdqcPqkCa5Tmiw8Pxvm9SyhRA3oYcZphd6SedW8h
 MaZM+Jbewb5gPUQCvH/a/yk+P1kkDEUPGbNEkIh85j1KvDwZqsVAVYGDhqJjL/kNqlAsmpN3bGT
 jDRW0j1H2JcXcUAZPErbNUVRIwL1ixxL38CfR2yc8k5K9xCgFX9VDEndwrMgAJuGdQm6fk3NMKb
 UMMD2MXjm0fi8RrhkVn5f8Dl7T73CuZAdEtWL3MKiDtdm82A0XQmXelRHQwS4CkLGwMCDV0Nzz1
 t31oPN0oCmJG0uGAnEqZcsBo14uoGp+RF+Gk2L2j/5B5NB1QEa78gl6+tWPRSgDqcdjkEOYn6wq
 u0v1xixbV+CH2gVuaXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX3OYe6HpnQA3h
 /b+09CbwZQ+GP1eqKgD3QFI1WpJLezx6I7jWMysZr2MdAQVFY5ed8WuyceRQe7VEQczTTvlqsb3
 PhNOSPmWN4rexXNNeNfioXceWhWadQg=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae39840 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=dgVQSAvUoH3QtQfB048A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 7KRd967QywVIqUe4GdQKw0JBRD-IiB0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TW92ZSB0aGUgYXJjaF90ZXN0c191YXJ0IGFuZCBzeXN0ZXN0c19zdGFuZGFsb25lIGFzc2V0cyBm
cm9tIHYwLjIuMTQsCmFuZCBhcmNoX3Rlc3RzX3NlbWlob3N0aW5nIGZyb20gdjAuMi45LCB0byB2
MC4zLjEuCgpUaGUgY2hhbmdlcyBhZGQgdGVzdCBidWdmaXhlcyBhbmQgYWRkaXRpb25hbCBjb3Zl
cmFnZToKCiAtIHRlc3RfZ3Vlc3RfbW9kZSBub3cgY292ZXJzIGRpcmVjdC10by1ndWVzdCBldmVu
dHMuCiAtIHRlc3RfcGFnZWNyb3NzX3RsYm1pc3N4IGNoZWNrcyBFTFIgb24gYSBwYWdlLXN0cmFk
ZGxpbmcgZmV0Y2guCiAtIHBlbmRfd2FrZV93YWl0IGFzc2VydHMgdGhlIHRocmVhZCBlbmFibGUg
bWFzayBhbmQgbm8gbG9uZ2VyIHRha2VzCiAgIGswbG9jayBpbiBpdHMgSVNSLCB3aGljaCBjYXVz
ZWQgaGFuZ3MuCiAtIGxvY2tfdmVyaWZ5IHNraXBwZWQgZm9yIG5vdzogYmVmb3JlIHYwLjIuMjIg
aXQgaGFkIGJ1Z3MgZXhwb3NlZCBieSBtdHRjZywKICAgYW5kIHYwLjMuMSBzdGlsbCBoYXMgaW52
YWxpZCBhc3NlcnRpb25zIGFib3V0IFNXSSBkZWxpdmVyeS4KIC0gdGVzdF9sMnZpYyBjb3ZlcnMg
VklEIHdyaXRlLCBpbnRlcnJ1cHQgZGVsaXZlcnkgYW5kIGNpYWQtbDJ2aWMgYWNrcy4KIC0gdGVz
dF9pbnRfc3RlZXJpbmcgZGlkbid0IGl0ZXJhdGUgZW5vdWdoIHdoZW4gd2FpdGluZyBhbmQgd291
bGQgZmFpbCBvbgogICBhIGhlYXZpbHkgbG9hZGVkIHN5c3RlbS4KIC0gVGhlIHN5c3Rlc3RzIHBh
Y2thZ2UgaXMgYnVpbHQgd2l0aCBTREsgNi43LjAuMC4KIC0gc3dpX3RvdWNoX21lbW9yeSBpcyBp
bnRyb2R1Y2VkIHRvIGNvdmVyIHNlbWlob3N0aW5nIGJ1ZmZlcgogICBhbGlnbm1lbnQvcGFnaW5n
LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgfCAgMSAr
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgMTAgKysrKysr
LS0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgICB8IDE0ICsr
KysrKysrKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxk
IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDBmZDkwZTQ5MWEy
Li5mMTc1ODRkNzUxYSAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29u
LmJ1aWxkCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtOCw2
ICs4LDcgQEAgdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiBdCiAKIHRlc3RfaGV4
YWdvbl90aW1lb3V0cyA9IHsKKyAgJ2FyY2hfdGVzdHMnOiAxODAsCiAgICdxY29tX2RzcF9maXJt
d2FyZSc6IDI0MCwKICAgJ3N5c3Rlc3RzJzogMTgwLAogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVu
Y3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKaW5kZXggMjhiZjJmMDJkMzkuLmE0MzdlNGQ0YWFjIDEw
MDc1NQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5Cisr
KyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKQEAgLTIxLDEz
ICsyMSwxNSBAQCBjbGFzcyBBcmNoVGVzdHNVYXJ0KFFlbXVTeXN0ZW1UZXN0KToKIAogICAgIEFT
U0VUX1RBUkJBTEwgPSBBc3NldCgKICAgICAgICAgImh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29t
bS9xZW11LWhleGFnb24tdGVzdGluZy9yZWxlYXNlcy8iCi0gICAgICAgICJkb3dubG9hZC92MC4y
LjE0L2FyY2hfdGVzdHNfdWFydC50YXIuZ3oiLAotICAgICAgICAiY2U5M2NiOTBiOWQ3NTdjMTk0
NmRmZThmZTZhYmNlYzgyOTJiMDhhNjY1NDZhYzUxYjJkZDQ4NjUwYjA1ZmE5MSIsCisgICAgICAg
ICJkb3dubG9hZC92MC4zLjEvYXJjaF90ZXN0c191YXJ0LnRhci5neiIsCisgICAgICAgICIxYmFi
YTU5YWQyOWMyNGEzZDM4MDQzY2M5ZjY4NDZmZCIKKyAgICAgICAgImZkM2Y4OGU4YjY3NTAxYzEz
NzIyOTE2YzZjNzQ0YzNjIiwKICAgICApCiAgICAgQVNTRVRfU0VNSUhPU1RJTkdfVEFSQkFMTCA9
IEFzc2V0KAogICAgICAgICAiaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdv
bi10ZXN0aW5nL3JlbGVhc2VzLyIKLSAgICAgICAgImRvd25sb2FkL3YwLjIuOS9hcmNoX3Rlc3Rz
X3NlbWlob3N0aW5nLnRhci5neiIsCi0gICAgICAgICJmMGNlNzMxZGM4ZGMyYjg2MTc5MmI4YmQ2
MDgwOGNiNzE0ZmQxOTIyYzBkYzc5M2FmNjUwOTBjMGJhNTI1YmIwIiwKKyAgICAgICAgImRvd25s
b2FkL3YwLjMuMS9hcmNoX3Rlc3RzX3NlbWlob3N0aW5nLnRhci5neiIsCisgICAgICAgICIzN2I0
NjAxNDZlN2EyYTY4OThiYTY0NTRkZmVhN2UxYyIKKyAgICAgICAgIjY0MDUzYjMxZThlM2FjZjdj
OTdlN2U4MjIwOWI2YmRhIiwKICAgICApCiAKICAgICBkZWYgcnVuX3VhcnRfdGVzdChzZWxmLCB0
ZXN0X25hbWU6IHN0ciwKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3N5c3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkK
aW5kZXggMWMxZDU0NDBiYjYuLmZiMWQyNDU0ZmQxIDEwMDc1NQotLS0gYS90ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFn
b24vdGVzdF9zeXN0ZXN0cy5weQpAQCAtMTMsNyArMTMsNyBAQAogCiBfVEFSQkFMTF9CSU5fUEFU
SCA9ICgKICAgICAic3lzdGVzdHNfc3RhbmRhbG9uZV9wYWNrYWdlIiwKLSAgICAiU3RhbmRhbG9u
ZVN5c1Rlc3RzXzYuNC4wLjJfdjY4IiwKKyAgICAiU3RhbmRhbG9uZVN5c1Rlc3RzXzYuNy4wLjBf
djY4IiwKICAgICAiYmluIiwKICkKIApAQCAtMjEsOCArMjEsMTAgQEAgY2xhc3MgU3lzVGVzdHNT
dGFuZGFsb25lVGVzdHMoUWVtdVN5c3RlbVRlc3QpOgogICAgIFNZU1RFU1RfVElNRU9VVF9TRUMg
PSAzMAogCiAgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAotICAgICAgICAiaHR0cHM6Ly9naXRo
dWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzL2Rvd25sb2FkL3Yw
LjIuMTQvc3lzdGVzdHNfc3RhbmRhbG9uZS50YXIuZ3oiLAotICAgICAgICAiZjBjNTM1ZDc0NjM4
NDEyNjk1NDc1N2I2Y2U1NDQ1MmM1ZmU4MjYyNDYxOGM3OTg2MjQ5NWVlYzI0NzE4YTZmZiIsCisg
ICAgICAgICJodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1oZXhhZ29uLXRlc3Rpbmcv
cmVsZWFzZXMvIgorICAgICAgICAiZG93bmxvYWQvdjAuMy4xL3N5c3Rlc3RzX3N0YW5kYWxvbmUu
dGFyLmd6IiwKKyAgICAgICAgIjQwMTYzZmE5NGQ2N2E2M2U1ZWY2NDVmYzgzNjgyZTRlIgorICAg
ICAgICAiYjU2ZTFkNzlhOTA2ODYxNDA1NWU3NGYzNWQ0Y2Y3MGQiLAogICAgICkKIAogICAgIGRl
ZiBzZXRVcChzZWxmKToKQEAgLTkwLDYgKzkyLDEwIEBAIGRlZiB0ZXN0X2FjY2VzcyhzZWxmKToK
ICAgICBkZWYgdGVzdF9zZW1paG9zdChzZWxmKToKICAgICAgICAgc2VsZi5ydW5fY29uc29sZV9w
YXR0ZXJuKCJzZW1paG9zdCIsICJQQVNTIiwgIi1hcHBlbmQiLCAiYXJnMSIsICJhcmcyIikKIAor
ICAgIGRlZiB0ZXN0X3N3aV90b3VjaF9tZW1vcnkoc2VsZik6CisgICAgICAgICIiIkEgc2VtaWhv
c3RpbmcgcmVhZCByZXN0YXJ0cyBhZnRlciBhIGZhdWx0IG9uIGl0cyBzZWNvbmQgcGFnZS4iIiIK
KyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzd2lfdG91Y2hfbWVtb3J5IikKKwogICAgIGRl
ZiB0ZXN0X2R0Z19pbnRlcnJ1cHQoc2VsZik6CiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygi
ZHRnX2ludGVycnVwdCIpCiAKQEAgLTEwOCw2ICsxMTQsOCBAQCBkZWYgdGVzdF9odnhfbXVsdGko
c2VsZik6CiAgICAgZGVmIHRlc3Rfc3RhbmRhbG9uZV92ZWMoc2VsZik6CiAgICAgICAgIHNlbGYu
cnVuX2V4aXRfemVybygic3RhbmRhbG9uZV92ZWMiKQogCisgICAgQHVuaXR0ZXN0LnNraXAoImxv
Y2tfdmVyaWZ5IGhhcyB0aW1pbmcgZGVmZWN0cyBiZWZvcmUgdjAuMi4yMiAiCisgICAgICAgICAg
ICAgICAgICAgImFuZCBpbiB2MC4zLjEiKQogICAgIGRlZiB0ZXN0X2xvY2tfdmVyaWZ5KHNlbGYp
OgogICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImxvY2tfdmVyaWZ5IikKIAotLSAKMi4zNC4x
Cgo=

