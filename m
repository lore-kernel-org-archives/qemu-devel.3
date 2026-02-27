Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DF91039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4b6-0000UW-Cj; Fri, 27 Feb 2026 15:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aH-0007JO-FP
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aF-0006sz-C3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:12 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0G3F065287
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vee/O2pPgEzEo3KC9cS6hP6BP+Mdhv5Br7i//thT9yU=; b=CZJknqrRt470aN98
 4eOHH4KBapa2oDSMEon2QehYrFNnYRm66E/G3c+ZxO1AGEBYPnjc+nT5BPNBIvMg
 s/Jrpt1Onkr9fSxz28SgrwtUq+Q8Wfw82zkwqm5eNoXTsWia3Y8U6sjODjAN6J/a
 PE4V12swznqJbW4eUH1X0z4MFIIFqbpWuUJjoUPLPSufWAITJj4IR87rv0uSXur1
 bcJiDd+/KExHherCNNtRwwevpH69istWVAQyB3UBW6teMlPLw0v5Tm27cOSGwzP4
 ZxRMZdaf6t/n/hlOTt5tlDbpCmZokD9fBwOUtY4Og247xv4kNfPu5WLKVFHDOM1K
 zF9Jeg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cka2xhqu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:10 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-679a47a1febso52222951eaf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224630; x=1772829430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vee/O2pPgEzEo3KC9cS6hP6BP+Mdhv5Br7i//thT9yU=;
 b=jG2nLcuzXLIiR0g91TDzVxEwMBKuKeNQQDnCXlWsNtBxaXGt+LeqsDbUNQ4iC7L8A6
 FZM+Dx5xjsZQq76KR5cbEen2FHWFYfncS0XIod4HSJuxEaqw3ALlbgJsUWeyiQ1OeAjF
 FIf19pWU66pEEM70QmVjBTKm1HEaqS9cvpZoCSdlKKi20JUOUWQ13FOJdCFb5JDzM470
 MpHfh003ocmvqx3N/3HiIeReemvUK+rgSB8ON9RxMdsT+s2l9Oq9Rvw9rLdGkTJQxTex
 6zejGWxAjQnM7Q7+Br4fsp5YWi9n2Rl+wnn326HPIWGb8P2yzaRvpvXIFzZVWVMOdSg2
 6mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224630; x=1772829430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vee/O2pPgEzEo3KC9cS6hP6BP+Mdhv5Br7i//thT9yU=;
 b=jLU2FG3Lcq+LeQh6ctOFAhsTR3yZNWyIJa76AKAOOnVbeXPHT52JyqgMTqi18TKF+P
 bi7rCg12jETLuPQ1zRnT05bhdIsYOvpEl2/oj6YZQUx46V+H6t3gDHnAqM9g+IoMHI0G
 b+KcBPVX7LBo7Y+Zw1cBIxxA/bfFZP796sUB/s5KUfQ4mD415wl763f7S8rvc4qErBVs
 sB8K0g12DcVD+5Bb4EQ7SwRRNkKbtaDUKIDUQlypb7fi1KiRAOVr5Djf/YjCd3UxC8Ky
 /UQJaUZ2jhNUBKUqmt9q/2N5GDPe2/0EsxSMmr6SAkac2LhDve1rZ20BVngmXPJme1Uj
 XxMw==
X-Gm-Message-State: AOJu0Yz2o5JkDZ77kcFQsCTH+Lv8nYs8YzXYeyTpUsarbdgPaBzJN06n
 c/CYnLovtunJHDZBYxbwLGg+Zz9jQGtNg+3rx9tupGgMEphtFVPsHc5mbtbfy2fm6Yk8UN6ITzi
 gMRWoAdNbdAigxa9AHqLtyHcUfsZqB0XVep45Y3ZyvElJrPGNqslgmsYLQz98JnPPOg==
X-Gm-Gg: ATEYQzyq6G9NFmjDQUngkyMDbAASK0Td/IiVGp0ObYslLbSYEGkaYu3jYUl+dwpe1yF
 PgchR6tcH3/IGhFHDZbw7nLWyrc523UWIgFDE72NOrhClNePiu1RXFymh/hJdt810wcME9U0+RZ
 1nOq/R1hJb8ImXxyq5/HYZdVBQ9I+xO9zZx5IQBceRtTUWzBt/lxdbdVRe1sNnMu2HhkzGET6bk
 NDnDlGhSsTFpMqve/3MXyOPGa8ba48aiobonMiyaqQIkg5+p1zqRONAHJkOH5YpNI5D8tZsTHXE
 C/UXWkB5vZI959bx1DQ014uweuls2DkhWRH/xxJjH1ZYUifZF5n6zZs5eY2wV5T+JbnwGXcaDB6
 g/X0r4fYa9JrR6tqjsMFOWgutxQRF9xpgYy0kiinKk1wLhxh454loacqpoC6OxV3nt95PtA==
X-Received: by 2002:a05:6820:2081:b0:679:f08b:5379 with SMTP id
 006d021491bc7-679faf9c624mr2594731eaf.71.1772224629595; 
 Fri, 27 Feb 2026 12:37:09 -0800 (PST)
X-Received: by 2002:a05:6820:2081:b0:679:f08b:5379 with SMTP id
 006d021491bc7-679faf9c624mr2594722eaf.71.1772224629219; 
 Fri, 27 Feb 2026 12:37:09 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:08 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 28/37] target/hexagon: Add TCG overrides for thread ctl
Date: Fri, 27 Feb 2026 12:36:18 -0800
Message-Id: <20260227203627.932864-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=BOC+bVQG c=1 sm=1 tr=0 ts=69a20076 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 24htqPeOiUZ0oopj-boqSPmJFCYFJ6PK
X-Proofpoint-ORIG-GUID: 24htqPeOiUZ0oopj-boqSPmJFCYFJ6PK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX+kE0CisBtZYt
 m/JkiGiWVTHEvzfmOImcBGym4KpnFsFDSZC0jBjXnmZUMEXR5ecA5Tj7zQH3lmYp8sLfp96shc4
 MCJ3+vInuCnYDYT4ZPM/pC9KERzuDAAxT7xl1SQtTj+KChMC66G109G8/bBcerQA2uLIDgBJ2gT
 io8Jlrmjqe9YVSBla7diNGjE1Cvao1OkK3D6/bSEdDT3DYiVit+fqz1mb5cxOUo4nuk4dlqAIIw
 EmA0+fd+b0rnU+sAnOvSpzSkfdI0S0Yr6chXNmZBgDiYVC2v6Yr4P9PcIVNFWJX7nj+io1rjYxS
 qqS5UY9T7Z5L9a6EIFVt2HUSj1ATPobx5AB6vqOJaBw9vfOTUTGiFqQKPr9qjpIZo95IVMZ6xyA
 mX42+OJjhbUBpGFyPToN12IF3c/jhPPzE6xCJ+bzpQ39u2NnhLTTdTVFntydb+7PM12aZ6tl642
 SaE3A7zy06yt36uS/Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgoKUmV2aWV3ZWQt
Ynk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMTggKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaCAgICAgIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA3ZjIyM2ZmMzg4NC4uMDQ1M2UzYmIyYzQgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19zeXMuaApAQCAtNjIsNCArNjIsMjIgQEAKICAgICAgICAgdGNnX2dlbl9leHRy
aF9pNjRfaTMyKGN0eC0+dF9zcmVnX25ld192YWx1ZVtIRVhfU1JFR19TR1AxXSwgdG1wKTsgXAog
ICAgIH0gd2hpbGUgKDApCiAKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfd2FpdChTSE9SVENPREUpIFwK
KyAgICBkbyB7IFwKKyAgICAgICAgUnNWID0gUnNWOyBcCisgICAgICAgIGdlbl9oZWxwZXJfd2Fp
dCh0Y2dfZW52LCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5wa3QtPnBjKSk7IFwKKyAgICB9IHdoaWxl
ICgwKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX3Jlc3VtZShTSE9SVENPREUpIFwKKyAgICBnZW5f
aGVscGVyX3Jlc3VtZSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfc3RhcnQo
U0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9zdGFydCh0Y2dfZW52LCBSc1YpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfWTJfc3RvcChTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgUnNW
ID0gUnNWOyBcCisgICAgICAgIGdlbl9oZWxwZXJfc3RvcCh0Y2dfZW52KTsgXAorICAgIH0gd2hp
bGUgKDApCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCA2ZDE0ODQ2MDM4NS4uYjJjY2U0YjQ3YmEgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
bHBlci5oCkBAIC0xMjQsNCArMTI0LDggQEAgREVGX0hFTFBFUl8yKGdyZWdfcmVhZF9wYWlyLCBp
NjQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8zKHNyZWdfd3JpdGUsIHZvaWQsIGVudiwgaTMyLCBp
MzIpCiBERUZfSEVMUEVSXzMoc3JlZ193cml0ZV9wYWlyLCB2b2lkLCBlbnYsIGkzMiwgaTY0KQog
REVGX0hFTFBFUl8zKHNldHByaW8sIHZvaWQsIGVudiwgaTMyLCBpMzIpCitERUZfSEVMUEVSXzIo
c3RhcnQsIHZvaWQsIGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHN0b3AsIHZvaWQsIGVudikKK0RF
Rl9IRUxQRVJfMih3YWl0LCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihyZXN1bWUsIHZv
aWQsIGVudiwgaTMyKQogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDc0YTEzNWZjN2ZmLi42ODll
NzlkODNlNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MjEsNiArMTQyMSwyNiBAQCB1aW50MzJfdCBI
RUxQRVIoaWFzc2lnbnIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAgICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAordm9pZCBIRUxQRVIoc3RhcnQpKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpOworfQorCit2b2lkIEhFTFBFUihzdG9wKShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFj
aGVkKCk7Cit9CisKK3ZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwogdWludDMy
X3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkKQog
ewogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoyLjM0LjEKCg==

