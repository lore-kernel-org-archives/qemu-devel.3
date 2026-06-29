Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E36DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCHb-0003fn-Iw; Mon, 29 Jun 2026 09:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCH9-0003ZS-CQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCH7-0006Bm-TI
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATDMZ2647785
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=; b=HSttfQIeQLc2ZGkr
 B9ybAzIZgojJ4i0JkQx7kCEebh5rc0SddIqVmHqUStVD5GRKUifbQ/QFpDS6EwRd
 weEtHD8BKB5NspxOJZtS43X176SyKxcjIMwdlcpxHb11eCx1AlXGOMZPK4XvG7El
 QiIHR6iSGmUliojMxtbioOcqwG8kE+nz46kvu9NxzAXLXU58PUlKoiTXyn7d7PVT
 K4UW9YGZVnkS+hVsSK5KeFdq1XrYgcqchJ8FNf83Z4QQIot0ag5bug0bxb+hCt9s
 wQ7nhDWtNVi8v9xCB9olJsGkznF3pkjEpCO+V3K49XbubWgx1TvokE0YVF03OuIN
 bC/wag==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhj3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9b1b608e2so18069455ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740628; x=1783345428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=RC/jV8r+gvbSrLvEIISNDWvShDqJhpB58u1fZ8QQMt3MZjiomHpld4KjwtYCm3bZBB
 TzEsyz16smZI05x87iP5hjCA7WvDT5Pn8IBjvxrW8hPNfvc+wKa4XnEap0AM7kmVVS6g
 ID+9u5S5KFc/0ppyLchRZijMsXuhyt15317PD6fKLtfSruAixZXNoZwe9oVfbSBDrfMg
 RJMl46HkXLRcyTYxGgw7vFPFC4RV3y85F1VKakRuoRt+bFWZntfnRhvXVOXN9s7/fRCR
 vvdK43NuSzK7TTK4psFlO4u8xyE9V9SZln9jCP93qJRfcVLzBlPXFlxDgQvGSjrLRG4G
 tUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740628; x=1783345428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=mBj9Erh6uYogmMsHR5Y0+79DHOlS/bMsr2lgZgeZIYOE3/hh10MhnCyv4+Sf0Cu0Yn
 Z2EJN1rrMOufSiZfO7fVzXZXs2qqekbyHFomXmsi9XcpJw2Hot3ykyXRo0PICw17C5lD
 QzL0t/QaQ6AnYA58QdwRqJgRrexQfWRNu8RjrHBW/HAQYb5lhrhotE30hb9Az3vDJ+Mo
 l/glIjgcoSMoiaYA98DixU/eScSpFGI4KHBSA4jaaosz5WG9H4PajzeXaL0v7s/8wNE2
 WCVQypR4oEJ2GZfmqFaQZJclqv5ss+hn52YS37Ipzgh/ELnMtgBlr5f/NF9E2zW0SZ17
 3nzA==
X-Gm-Message-State: AOJu0Ywg3Y7pmbd/K/RjhIzobZEeus6w9uG/K0wsYWIdg16xr9us8cJ4
 KgzQPgSEiHuR1Osg6uVdrJywyNFHQarMOdOauPYAPvpEWxOPrhanaZaIX+v3NzXoBQ7X/tqbsBT
 PWMRZOBAR59qbNDVAz5eTfJBMPpkHeToxfPAW5t1wdlCF7Qv75bAM9L9a0BIKh7eBrw==
X-Gm-Gg: AfdE7ckC7854iLC0Wm5gRIs0C3xkmVR8euAFOYfXgI0t96t/1aGv8VjmJOzr+U2agmY
 aPJBIoZ4KVsuVXiKeGx8ariRjqNPt9yxbgusNjvvsj/QhnbUgud2gFLGM7mMucvXNVVg0r+kf+c
 B11z1EI+hEVUMZezTbn0cIsQIWIx7Ka38xFPqknSQKZqyOuBRXjo2O9lE+NhJY/ayG+yTxcT1mF
 H4Q2kKQrhMtfNAXn1bVwTP3OgVOu5mSF4krjDBbkMTAtVmFZQ9qxIxZZPsWvSaqz2ZPpfNhXwNc
 Te4VqRfd3ePdPBo06bCbpupUPO442nhIap6pGFawgjweAq8VI/pHj+qhi6PbAN7Pt5klWQFlydP
 N4PIBrn4tQrIdui2KK1S09Rmsjn2vagbzVrRtqQaIGrBPqV0kfOmicmwXVwI=
X-Received: by 2002:a17:903:1850:b0:2c9:dbb5:c1ec with SMTP id
 d9443c01a7336-2c9dbb5c4f3mr51510095ad.47.1782740627691; 
 Mon, 29 Jun 2026 06:43:47 -0700 (PDT)
X-Received: by 2002:a17:903:1850:b0:2c9:dbb5:c1ec with SMTP id
 d9443c01a7336-2c9dbb5c4f3mr51509835ad.47.1782740627149; 
 Mon, 29 Jun 2026 06:43:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 42/77] target/hexagon: Implement iassign{r,w} helpers
Date: Mon, 29 Jun 2026 06:11:57 -0700
Message-Id: <20260629131232.2487780-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UmDGLoWw044-kV3npEY2YrITi4sHba8O
X-Proofpoint-ORIG-GUID: UmDGLoWw044-kV3npEY2YrITi4sHba8O
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a427694 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX7y3ZkDDQK0+o
 mLkSlRjIPD5AwvM4iuk3Mx9JPS0Jjm3bbob9uWyEKBqjK8RCMI+CGHSoGy9PAMs1vB6iAQkIOVl
 UNbNHUblnXGRf6SYwxE9Ekbgv9XsEuY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX4TnEQFhcCR3s
 a+1Zgju1g2ExHrgElzEsfZAXV/WzA6f5mttM6g8br0iJah+M0CIBNaTRTh9KNJ7rAEIL+B/qB8+
 tCkV5+oeHPlrD2CAz8AAUxczz+GF2w4efk631+FF7TnDOJzxa5LXaAg6iYxho82c0EApHBs3Xsj
 f68yaip+oetWhqPNWmHZliQH1bCV3G3N0YJfH/WsAzhfwhy9zFTJ2c3q9BIqAo01aT+9/oQkCV0
 T9NylK9MedvDatw0D3MFrVgitLkELwQkP+Q9y3RTYhZrDJXgpQ8CSkwYHzQBo6exVHZ9nuvSW8T
 K5TAscBHMZ7vucWSsNtHk5R/r81qgztpAmDnxVeXriBXfuuZBI77kxVI5rQv3zsnVVknh37AeL4
 Uayu3HUhKHGkA9Wa9/qlMwQIPSGPNUkIFGV1DsNuKsWxBwsNt1hhwB5wbenbahAxDq13oKSrv1q
 fNcwxYiY8NUFb8ua/dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDc4Mjc2OTZjNmIyLi42ZjAxZjNiOTFk
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTcsMTIgKzE0MTcsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

