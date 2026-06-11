Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC1ECD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2T-0000fs-Nr; Thu, 11 Jun 2026 01:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2N-0008UC-3f
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2J-0002Q1-LG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQSK3817120
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cwQETMMZ4Sg5dnan0uk0SSuZyEKTQ7a8wKkBHCqkcH4=; b=P+7icbuCNNRXAqpT
 TsGG+BP3fscQhOZ5gAgvQX7MKY5vLGJKXXOc+calwrEhVH/qO/pAuvnQso1MRAj9
 EhbKtmh+WEsgjIMYpCK+FfKqU5gib7YhrTgWdcBoKqOTEyHQNhmvg4myfGYuzqG5
 fLtQ6RlZ/rdOk6FYcIS/CEIEAZ2Akq/zTRDyksIV/rFTzZWdXQKNWgMtNKz1XnJH
 OjfSkVqO3zh7H+nhwfPaBiwVHLOt02/u70y1UScYy3V0UKRLK/QjbPHTQoQe4Kvg
 Eg6XlEMOkmF7bWiHUiy9z2vQR8SAs3MbqQlbxktxCqIpVJjDVDTXN0SLyEJ91RmK
 udhZeQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uss5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-307fe856724so1884701eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155981; x=1781760781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwQETMMZ4Sg5dnan0uk0SSuZyEKTQ7a8wKkBHCqkcH4=;
 b=fmpsdwt37KMvzKKNs6/gTd4LQV20OTG6kziRmxk1zpPSWDNTRLbqgwSNGW8qaI4Ycm
 TRQyaXShneg/+GMMAStVkf+D2h8ntz4cHoDQKpi0RqHg7hoH48KOLDcNB3MbeTv8vkul
 TonsdmVJgWVVgBFciy9buoT94+CGsM+xL0ZeQXUQbXY0tMZg6rnRXvuWixRhLN1CnQuL
 krv2eG5OnuHti0KHTKOvUQHVwW2b74p/7Yz7kHAPzDP8zz3WGfTnNIVULtZeCMq/Y+OG
 F03MU5owAnyoE/kNGJeKrT88qPf3Hm52WEPPxhb4EKztXyuogEZUTGoUuBLZLXvCCOOP
 Sx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155981; x=1781760781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cwQETMMZ4Sg5dnan0uk0SSuZyEKTQ7a8wKkBHCqkcH4=;
 b=AJphEclPgDZXSz6gOyVlgDviNlwO8GTJ/9Iz8+UAOf5OnyPz6SRjxPm+VlAlwLBOG8
 koGVsLCntZIdlzT8G/1Dh5sdF8NNXwtQea1Iawz8qGjV1tWkU+X+s42hjl/JNLdH79wt
 9HZebf+BKuNMCaMmaP0bVzKPz7G+h148MKq+mMGnxuh7QqXU/JprXQVdfYMn/qn7YpWc
 3+bjwfAIHL9gbhaQz1+hgcCdGT8gU8M93A+YrgqG9ee1N4hBltT2ygnOzoWwKqmJX8u7
 Xe1ErRh+BWa+mmW5PPABCr1es3gTuoO1uaVSTaHBWKB9gYdQB79rnYtJ8w3KLaeDVrJo
 jcEg==
X-Gm-Message-State: AOJu0YzkJo5YOOWG3MZKW2fthKs9LaAZXFlBVLfO1ErlhWZryeLn86Pu
 ckklyHXrg64p1m+lEyamEOimEmxuA9fscyMtVh/yib3HjUWrKXLknaODs80suUw/bTGnPMIFAM3
 3II1Ut0Qk73XyJiLBvURd+v8b0LJqFZiNiIoPI4edcsPkShNVc/Kbbd3vFfC/jArWyQ==
X-Gm-Gg: Acq92OGE8WmSCIWUv4krw4uJK2+AACE3ucmrqKu/8HHqGW5U86tYM42+oa6jY7jAcgT
 DhpQB4B9F5J2SBInSV/uGb5HApqQwgYpAjsZHUeCw3umVmZCSUasYOSzIY0sEpLrQIpdvQs4cf3
 XwgKa8PUwUlreTY3s1E3gp+/yl6rFl3vuXXygHGn5t4hsylf2kcQfJOgMKs7a5pdud8MQsYtKLK
 bS3IRTTUCMnAYY5ZPOYjvb7HGpr8QOL2eWbXAzMVWfOTz2xklxrDhwaUOYNzfMhtDa6Pz/8bnFu
 v7OuGq6kG9c5IczmRMG0ywR3BAVrZI75As4/fP25UiILzgBn5aZ1StcGThbKe69HP1ZbV0GYP5v
 a9KMydgDn1AVbwTpp/XopwjeVRTVqqVWGdU+W7tQ20IicydXnzkZ7yU/u387RLksvEhFOcrmiNL
 t1nAwN
X-Received: by 2002:a05:7301:e30:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-30804a0f026mr1077781eec.19.1781155981484; 
 Wed, 10 Jun 2026 22:33:01 -0700 (PDT)
X-Received: by 2002:a05:7301:e30:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-30804a0f026mr1077750eec.19.1781155980870; 
 Wed, 10 Jun 2026 22:33:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:32:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement iassign{r,w} helpers
Date: Wed, 10 Jun 2026 22:32:23 -0700
Message-Id: <20260611053249.3918491-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a488e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX9g/khr6GjspL
 gm+5GoqrobRQRlSuX05uwMdWFU9s91BIqaqopW72tJoNjbZLagnVrYg+btZYGagRvMO9HwOZU32
 y1ptZEC86FU2LQA1ACiHW+LU2Q33rC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX5laMO/C1Cm2h
 WWGFLXwR1ZP1r2VDOxAF8rUtKEdp+Nmevq2XHfG6KLktVVhVsKfYrZGyXW3nb9LAzaVUdTJU4ag
 6ITQ0RhR1DcfZHmTq6AwNxzKu75Ss3qhO6d6aU6zovn0f+MAu97IYXmHK1u4yBqOHuTJk+fNlIK
 TVSu3Ztbny8OqQMlIxYUCiVJDU9Rbj95LzlaN/TvGxMtsmOLut0oyz8YO5Nm8Y1M8s8I4r0TSRV
 pbtIv7rICE7Y10ev2L3+ISRWmf9Sajzah9mdWFdwfmtPONrzWh2PtQGwAhwVyea281HFa+nD0LX
 IsO6YhcbIdxtYIDl+nIG1/Bz1roqkxYCnorbDnkv6b1CBvAeGSY2Df1gWBbcf0TUZhYoWF8GTD7
 DaQcrxca1smW0uqKaZfpT59Krxb6+rIQst3B29e+tRHn7lMF03vO2Jgc9E6Ra11vE01PsL4W8A+
 wy2/tdgU+PJ2j7PJI5Q==
X-Proofpoint-GUID: rvwgWuKTCIWuYqoVpkhVuDm-no3aVwRi
X-Proofpoint-ORIG-GUID: rvwgWuKTCIWuYqoVpkhVuDm-no3aVwRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGU1MGI3NzBkNjk1Li43ZmFlOWMyMDU0
NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTYsMTIgKzE0MTYsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
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

