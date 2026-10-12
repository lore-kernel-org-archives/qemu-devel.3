Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC94CA9ED9
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7U0-0001vX-Hy; Mon, 12 Oct 2026 00:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tp-0001u4-Eo
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7Tl-00017g-JT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:17:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lEOe052432
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A0vU/H3jz+KbcHqs/xaFNhD+3bg12UCLlwyd+eL840o=; b=owlafgCZYyA0XY7H
 AotqlkAyiS8NFgsMqtKIaBEDW0KFa4OThIfg59UFKWyxyt9bG5s56ObCjRcXqFFq
 qMnX2EC7OVcepgK/Pz3QFbkq3R1DzwHob7UZcAZIb+W0iqzTJpqtWHkHqdfunj0W
 w/yVSu4Vvho4Ub2hmOILwE+yDYQ9BqlPGlX8Go2l6R0Orgj2gYfnN6uOPVgTXpmC
 3j1PsfT3EEcPi6T38DK2TaEoNZRDpYUHZvZkzziTF4ps9/Cv9GI5tEY5v6Rmqiu/
 7KD4wmWmUVTKFPW/xWCvdL2e4TmdJpQTVEN5vlEElPKlaJbnLxQtXQLPq2GpkAk0
 KTR7Gg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9vg27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so3542380eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778656; x=1792383456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A0vU/H3jz+KbcHqs/xaFNhD+3bg12UCLlwyd+eL840o=;
 b=gwKQrbLVPbJCMOWfPTUYyLeXWv9FY+is9zoi3Grb5YhR+6j+X1GVjjX/SWDEY9fb8h
 +0AOOWCkG0e2jIlRkMComN4412BDaUMJN1jHZjlkRoxcdPpyctu54TZJnL89Cad61QYY
 h1aidZg8DMZ+FK5+e+Ii7UGkN4sHKvItqPS1291du1NHS2HPh6eWgwcQXFNnbafejhGl
 jqr9Yon5Dsp0ECSBEdqwAKpx/pgqB2NHWS2tLjxzLbWxjPMOlHyJrw/XADO5saED+hPS
 ovPxEo3v/uxTEkcFogPVm1DBIJlfDenLdvqmx0evH2YW3UG1PFzlcjM5Y8fEby5cp4Su
 WXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778656; x=1792383456;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A0vU/H3jz+KbcHqs/xaFNhD+3bg12UCLlwyd+eL840o=;
 b=XQoXZGIlUnIVAp1wfp/rDhJxiEhOAadjR6PswLC0M2GuRD9km4X9Tbn+Ic+YwNeF/E
 /vK+WTEBDNdiiS7rOEpkuNjiUPuSfsok8Ykh06kJshfh9mXr+NGqwEI7D6csgukVM8iZ
 oKmQLtJfrzYquLHS3P8tWTRHhj3bi/WDb/KVN11m8IMhdxBW+ycntn4BXOEiZtr5PbMV
 fh+7CtULcWVuOTDNJnYkyurp6Xu58hQVDz3D0XnBPuFb5lMuCcx2VqD4/Fi6mew6OJpt
 XPXgEtrKBdPDQDh4luI8kJytBxcO4xKyZchEKRrLxQSPKtd1YMVXSz/JF95HbJ43OOmi
 IJYg==
X-Gm-Message-State: AFq9FYJa85ghdRh30KI72XEQjw2LSB6Ix0g+MpxMFX3ug8jOWq7ArNUn
 wvpgqdPMRyWrN1LkJSYTxZcO9TVSdY27oDrPOzsSYomJz3MI2JguKo8pgntkb9jAXZtZsHjf84F
 W+nkG1oP0lQF05l3yM/uIdloFHffoj1C9rWMzrTu17A8Jbbg4VAl+J+T4mR3stE33gQ==
X-Gm-Gg: AYBFou2vNahKVZgXmQePjbcvGTtPZGCkDrezifgCIghcjYBJGnfd+IPnf7BaB2EXAId
 FOfaFsE1qRRZ/xj2uN1pYGLb8UpuJev1MUzDOQvFlMItv5cKMmTq2NSf1cIefWX0/2w2Oaudd8n
 vOJmNBIuxzaVoaO+VuMQm9bYDcPa9zey3IpOim6qSdXEnPcHoob7LIr+g4bYed9iXNsYKApklxi
 Bo7WJLjMN0S19FP4e/DYXuaAdzN+7AmUVPz6eK5smxuPvftb6MRvRs4towsxcu47+kMFc15/Hfl
 9se/WbAAEI67o03b6h6jzewj3PfM4/Wjpjh1KukmCymS9+F/RHCyXH200sYpZ23kcmRyuPxOHZu
 TvZNO6g93K2RRck9jj4yzniS3TOA5O1vsXrIwI3Np1hbdAE4=
X-Received: by 2002:a05:7022:ea8a:b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-16a5bf3ee1emr10649825c88.18.1791778655425; 
 Sun, 11 Oct 2026 21:17:35 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8a:b0:166:3e26:c4b5 with SMTP id
 a92af1059eb24-16a5bf3ee1emr10649798c88.18.1791778654688; 
 Sun, 11 Oct 2026 21:17:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/25] target/hexagon: gdbstub - Add sys reg support
Date: Sun, 11 Oct 2026 21:17:03 -0700
Message-Id: <20261012041722.1159355-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acc5f60 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fcRPBzItccz9Tp0UfQgA:9 a=8xdMwVX4q_ZhBw1O:21
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: n_if6OIx5ENEAl1WqbcGS0B3_MSnDQl7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX1vb5kJfkDUxU
 2flYL6NT88gdMWf/2CiSW4dTzsBBYdvASpYt0XUMndeBBZ7leecOiGVrY1yvtWDlNZvyeIgClhf
 LHA8eAwHaJPanT0WYdWBDTAGPgf0dlaCK5fMiU6HbMCLEsGxZjRWMi/uHabSY640K6q4qWVAbBw
 onQr1L2IdhDsEQkMwtVtwbppgDWot1tY7HmdRZ2aqLEQP80bYGZy18sCKN4aFfviXaPCz9PO4sN
 X7to0RI3elAo9nnZOdneQ67KOAKJJGWTnElfBn1RXGhepXrtx7Kj94pJ59TlEdcIj5xMBiDji1u
 t6IJX+NJP4xE8XjqG9kfS3EwGNbQpE2IjWdntJwk4i1eudpVnS6b8LQwb36hQ4fDWv1zD3DDg04
 PUxVNQNz1O/EeM0IXwG7a1+PJPlRqRv78zCOwmddVPYBZVVEWovqNgGPiz8LJxnLSLCTsiEXno8
 Yd2tqVy24drnfkYqNcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXxZf9KRiV+3d8
 O2J6sqNdcD63pfZvNhl035q0gMBth9si98cjYQkkTHib2V7fhN9SF/lQ3j/MTM3nXkhRbrFAgIP
 EFiI0M7N/rtyP8thlUKYj0iQwTamrUs=
X-Proofpoint-ORIG-GUID: n_if6OIx5ENEAl1WqbcGS0B3_MSnDQl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBzeXN0ZW0gYW5kIGd1ZXN0IHJlZ2lzdGVycyB0byB0aGUgZ2Ri
c3R1Yi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgIHwgIDEgKwogdGFy
Z2V0L2hleGFnb24vaW50ZXJuYWwuaCB8ICA0ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAg
ICB8IDEzICsrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDc4IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCBmMDJhOTg0NTA4YS4uNjk3OWMxNTNmNWQg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5oCkBAIC0yMzksNiArMjM5LDcgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhj
ZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAqLwogYm9vbCBoZXhhZ29uX3RocmVh
ZF9pc19lbmFibGVkKGNvbnN0IENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2Vudik7CiB1aW50MzJf
dCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKTsK
K3ZvaWQgaGV4YWdvbl9ncmVnX3dyaXRlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBy
ZWcsIHVpbnQzMl90IHZhbCk7CiB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQoQ1BVSGV4YWdv
blN0YXRlICplbnYpOwogI2VuZGlmCiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVy
bmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCmluZGV4IDA1ZDExMjk5MTZlLi4zZWQ4
MzkwNGViNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0yNCw2ICsyNCwxMCBAQCBpbnQgaGV4YWdvbl9nZGJf
cmVhZF9yZWdpc3RlcihDUFVTdGF0ZSAqY3B1LCBHQnl0ZUFycmF5ICpidWYsIGludCByZWcpOwog
aW50IGhleGFnb25fZ2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUsIHVpbnQ4X3QgKmJ1
ZiwgaW50IHJlZyk7CiBpbnQgaGV4YWdvbl9odnhfZ2RiX3JlYWRfcmVnaXN0ZXIoQ1BVU3RhdGUg
KmVudiwgR0J5dGVBcnJheSAqbWVtX2J1ZiwgaW50IG4pOwogaW50IGhleGFnb25faHZ4X2dkYl93
cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbik7Cisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK2ludCBoZXhhZ29uX3N5c19nZGJfcmVhZF9yZWdpc3Rl
cihDUFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1lbV9idWYsIGludCBuKTsKK2ludCBoZXhhZ29u
X3N5c19nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBp
bnQgbik7CisjZW5kaWYKIAogdm9pZCBoZXhhZ29uX2RlYnVnX3ZyZWcoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0pOwogdm9pZCBoZXhhZ29uX2RlYnVnX3FyZWcoQ1BVSGV4YWdvblN0
YXRlICplbnYsIGludCByZWdudW0pOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA4YTgyZDQ2YzFhMC4uNjA5NDA5ZTMyZDAgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CkBAIC00OTIsNiArNDkyLDEwIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnZGJfZmluZF9zdGF0aWNfZmVhdHVyZSgiaGV4YWdvbi1odngueG1sIikpOwogCiAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyAgICBnZGJfcmVnaXN0ZXJfY29wcm9jZXNzb3IoY3MsIGhleGFn
b25fc3lzX2dkYl9yZWFkX3JlZ2lzdGVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
ZXhhZ29uX3N5c19nZGJfd3JpdGVfcmVnaXN0ZXIsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGdkYl9maW5kX3N0YXRpY19mZWF0dXJlKCJoZXhhZ29uLXN5cy54bWwiKSk7CisKICAgICBp
ZiAoIUhFWEFHT05fQ1BVKGRldiktPnRsYikgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJo
ZXhhZ29uIGNwdSByZXF1aXJlcyAndGxiJyBsaW5rIHByb3BlcnR5IHRvIGJlIHNldCIpOwogICAg
ICAgICByZXR1cm47CkBAIC04NTYsMTEgKzg2MCwxNCBAQCB1aW50MzJfdCBoZXhhZ29uX2dyZWdf
cmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQogICAgIGNhc2UgSEVYX0dS
RUdfR1BDWUNMRUhJOgogICAgICAgICByZXR1cm4gc3NyX2NlID8gaGV4YWdvbl9nZXRfc3lzX3Bj
eWNsZV9jb3VudF9oaWdoKGVudikgOiAwOwogICAgIGRlZmF1bHQ6Ci0gICAgICAgIHFlbXVfbG9n
X21hc2soTE9HX1VOSU1QLCAicmVhZGluZyBncmVnICUiIFBSSWQzMgotICAgICAgICAgICAgICAg
ICIgbm90IHlldCBzdXBwb3J0ZWQuXG4iLCByZWcpOwotICAgICAgICByZXR1cm4gMDsKKyAgICAg
ICAgcmV0dXJuIGVudi0+Z3JlZ1tyZWddOwogICAgIH0KIH0KKwordm9pZCBoZXhhZ29uX2dyZWdf
d3JpdGUoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywgdWludDMyX3QgdmFsKQor
eworICAgIGVudi0+Z3JlZ1tyZWddID0gdmFsOworfQogI2VuZGlmCiAKIHN0YXRpYyB2b2lkIGhl
eGFnb25fY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0
YSkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyBiL3RhcmdldC9oZXhhZ29u
L2dkYnN0dWIuYwppbmRleCA3NmFiNTIzNWY2ZS4uMzBiNGQ3MTBjZGIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2dkYnN0dWIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKQEAg
LTE2LDkgKzE2LDE0IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRl
ICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUgImdkYnN0dWIvaGVscGVycy5oIgogI2luY2x1
ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKKyNpbmNsdWRlICJjcHVfaGVscGVyLmgiCisjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5oIgorI2VuZGlmCiAKIGludCBoZXhhZ29uX2dkYl9yZWFkX3JlZ2lzdGVyKENQ
VVN0YXRlICpjcywgR0J5dGVBcnJheSAqbWVtX2J1ZiwgaW50IG4pCiB7CkBAIC03Niw2ICs4MSw2
NCBAQCBpbnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90
ICptZW1fYnVmLCBpbnQgbikKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogfQogCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK2ludCBoZXhhZ29uX3N5c19nZGJfcmVhZF9yZWdpc3RlcihD
UFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1lbV9idWYsIGludCBuKQoreworICAgIENQVUhleGFn
b25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2Fy
Y2hjcHUoZW52KTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgaWYgKG4gPCBOVU1fU1JF
R1MpIHsKKyAgICAgICAgdWludDMyX3QgdmFsOworICAgICAgICBpZiAobiA8IEhFWF9TUkVHX0dM
Ql9TVEFSVCkgeworICAgICAgICAgICAgdmFsID0gZW52LT50X3NyZWdbbl07CisgICAgICAgIH0g
ZWxzZSB7CisgICAgICAgICAgICB2YWwgPSBjcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICAgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBuLCBlbnYtPnRocmVh
ZElkKSA6IDA7CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnbChtZW1fYnVm
LCB2YWwpOworICAgIH0KKyAgICBuIC09IE5VTV9TUkVHUzsKKworICAgIGlmIChuIDwgTlVNX0dS
RUdTKSB7CisgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZ2wobWVtX2J1ZiwgaGV4YWdvbl9ncmVn
X3JlYWQoZW52LCBuKSk7CisgICAgfQorICAgIG4gLT0gTlVNX0dSRUdTOworCisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKworaW50IGhleGFnb25fc3lzX2dkYl93cml0ZV9yZWdpc3Rl
cihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9idWYsIGludCBuKQoreworICAgIENQVUhleGFn
b25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2Fy
Y2hjcHUoZW52KTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgaWYgKG4gPCBOVU1fU1JF
R1MpIHsKKyAgICAgICAgdWludDMyX3QgdmFsID0gbGRsX2xlX3AobWVtX2J1Zik7CisgICAgICAg
IGlmIChuID09IEhFWF9TUkVHX1NTUikgeworICAgICAgICAgICAgdWludDMyX3Qgb2xkID0gZW52
LT50X3NyZWdbSEVYX1NSRUdfU1NSXTsKKyAgICAgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVH
X1NTUl0gPSB2YWw7CisgICAgICAgICAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCB2YWwsIG9s
ZCk7CisgICAgICAgIH0gZWxzZSBpZiAobiA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAg
ICAgICAgZW52LT50X3NyZWdbbl0gPSB2YWw7CisgICAgICAgIH0gZWxzZSBpZiAoY3B1LT5nbG9i
YWxyZWdzKSB7CisgICAgICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZShjcHUtPmdsb2Jh
bHJlZ3MsIG4sIHZhbCwgZW52LT50aHJlYWRJZCk7CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJu
IHNpemVvZih1aW50MzJfdCk7CisgICAgfQorICAgIG4gLT0gTlVNX1NSRUdTOworCisgICAgaWYg
KG4gPCBOVU1fR1JFR1MpIHsKKyAgICAgICAgaGV4YWdvbl9ncmVnX3dyaXRlKGVudiwgbiwgbGRs
X2xlX3AobWVtX2J1ZikpOworICAgICAgICByZXR1cm4gc2l6ZW9mKHVpbnQzMl90KTsKKyAgICB9
CisgICAgbiAtPSBOVU1fR1JFR1M7CisKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQor
I2VuZGlmCisKIHN0YXRpYyBpbnQgZ2RiX2dldF92cmVnKENQVUhleGFnb25TdGF0ZSAqZW52LCBH
Qnl0ZUFycmF5ICptZW1fYnVmLCBpbnQgbikKIHsKICAgICBpbnQgdG90YWwgPSAwOwotLSAKMi4z
NC4xCgo=

