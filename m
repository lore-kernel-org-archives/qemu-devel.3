Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA69606A335
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tr1+w00L;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fU+OtsnX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbvQ-0006OC-45; Mon, 09 Nov 2026 21:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvI-0006Kw-UM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvF-0004Ca-11
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:23 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0j6FM1850593
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CiDo05Nwuu0cOu7puSU8aSckhUlRkC+K015yvWJzZhs=; b=Tr1+w00L89UJeguq
 Gbu2Jc86n7NwsVo9VUIoCsTHC3uSmGg6lPqLS0WmAr/k3jJxrE/svjYbKVbU02fm
 4Oy459J6XGx7q/hwOMh1X1eznrPaaZiU3XWjhbvgDXdR4ZfTy1SyFY4rh+1UGO8w
 GuscZrI34k2zM5UrVgiLlLU8gxgauA57lszQFIhbwOJ7L9FXVR3KSpJOBNH2gm6v
 hUCL3RcAhAx+bb2sJ+YMP99EAMkaQQ+BQkAWlLCLtS2+YxbaCbe0qY/irad9z+OQ
 ZMVXh/qqjZI0VHZsv3PHKa//6vCc03NM3/OtKsET3uMNRcyH4dO3QCdIss34kRat
 X429Rw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5u88b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f479b9819so2877268eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794278959; x=1794883759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CiDo05Nwuu0cOu7puSU8aSckhUlRkC+K015yvWJzZhs=;
 b=fU+OtsnXxK3kUQr1bciDHm5Hy4RoYx0Zp5rCPeTU2zMl9bD9NAT4hPDZxVsS3cWQwN
 ZbZid1qjHNgmhVQxiKfrvb+1WKqLMKnniPhoJ04I3w4hVVI8zcvNlHDKv10+RV341Hgb
 Yw2m4huix8G4wQc+y13iPho6IF1f/eu/8fNBxH9uFwfRDMxD763WUvJVrNhwbv/nIGTH
 1rIOL8I8eAKSFepn+CpllnfqcVwYkC/ST9X2w0SpaQcqVoE4AX4uyoHqKYAaOiNoppiD
 3XTcJ7cOJG1I01d/itRZ4u7NI1vQCvb16sqkT9WuW6f26ERLtZmy3nGLCCY7x6F28rub
 nGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278959; x=1794883759;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CiDo05Nwuu0cOu7puSU8aSckhUlRkC+K015yvWJzZhs=;
 b=RCTLDl8UKSu1/lu5rRefRGDReONRsjBXXbqirkEY7VxMT+xShmBSF4+RM0Og0EslH4
 MGAiwrGhx3NwBldiZzQyk4BxBztCOPHmelQRORCMsMM6Q3XbDO0nF8/oWPhTEF25fTO+
 2uCYWz3WHcWHR1a81R6ZwBkExkqllmwhwGo54A05TV75HI59F4dbUZL+Kd9bqRjbduQa
 JmcIvYhcyWJfGxPClpdHNa1MnqurIXegoohv8bgJE7z6RF4FgfyuFU6JacL18Wq7AmwC
 U/jJfHf/CdmzUksvlAwU5Jafh7KUxfE39Jwquj2EtS+7I12w45m/f0B+LIk73Xn4Hgyl
 psYQ==
X-Gm-Message-State: APuU4Z+k+V1zMdvs5nqaIA0YosUrUyz4opl7NxtROusl2+wRtvYZdsKy
 E/eotn9c/BtGc68bWOP37sSSzkWp0yD2lo3dpjxXnr3m1v7qNi/+ChBfQlKyIQq9QISEreBGfJe
 bkm7BqbrBFtPcNbILeK7Tdu38zAt9TnFMx3KTYLXTwsuI70Uw8ahYWgwOFhuFg7DbTA==
X-Gm-Gg: AYBFou0H6TQnX5ScTMprexrNdSMR8F8jgsNWe0gYdQKooeeEuEqSKLJBZ753UIRnqk2
 oX1jSjyYIhRdUtou6WbpXgTHPnP7xCKUeTtAMdiiEg8DAbnqGROCIyVLU+ey+ZdPZgaykgjXV7Z
 rOOO0PNWqY9TQj6ggi6mtTh5ZprbKe01BJ0EfOB2WdXSFMTLYZ+ZV9Qg5CEcsk+MuWliC6bcMdF
 ri/GKt5GAHr8LqVaEl9dmxUlAV6hvWdMUFln5DeZVhvWJsYmf2w9hdMc1oJp98KocdRSfZxNRas
 eXO1quuqqjwqy6qWfl+GOi4DATZNGcFBhPkZTl/WTLPnWxuGo3vSjQW1CFyzoMOCI7RTw+uAEez
 PcZ+5n/d+U3cD7Wu6ftfx+Dml3bfve1Igu1OEIpTPJjeKyLink9Fy19KquwCPE6BT5h1ccfHRHs
 TvhrIYTuM6BjUQ0pFWbJUV
X-Received: by 2002:a05:693c:88da:10b0:36e:9145:4531 with SMTP id
 5a478bee46e88-375214da6b9mr1456321eec.39.1794278958908; 
 Mon, 09 Nov 2026 18:49:18 -0800 (PST)
X-Received: by 2002:a05:693c:88da:10b0:36e:9145:4531 with SMTP id
 5a478bee46e88-375214da6b9mr1456295eec.39.1794278958349; 
 Mon, 09 Nov 2026 18:49:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm2700263eec.25.2026.11.09.18.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:49:16 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/11] target/hexagon: leave stack exchange to virtual SPSWAP
Date: Mon,  9 Nov 2026 18:48:53 -0800
Message-Id: <20261110024901.1610588-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
References: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfXyhROy6t/1VRl
 ZWPKJkIB3oBGQOgRDVghNzoIL94kUgyWZkvFQqbPl1q23QD8zBWRp+3pW+o343f+QnsgzjPHCWo
 Vxy5Q/lsaK7f+RwKxefeInYycXZWMyk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX5pdCk0XwH7go
 t6bB7fc5fAtg9aL+grb4lmhLTD5lDCB351orzzNMvc5nxSr45IpAMRsDapQHyql02nvfaeXhNwp
 P3sP6xNK69CMVL4tDK3UBLAdwuA8tWwdBBNzlpkFNxQ3/LpNylXyFLVLxpuKswmZ/pXTp40j+qa
 OykZXdf7ID6OHKcJt5jVRmoOAKaMsRygL84IWJbevIcoJrli6r87/y2I7k5bCAGPdx6qJ4Le589
 wtjzR+bqxTur+GrRHwLU06sWxwVlylZT7gk/cs/tSb/0fB7vDhDBF8fwOtQAj2rcy2f0/UZld9V
 1lPBBL2WrITqmkv6Fuz8aTphvgM6scoF251Ol7gbBvCXq1A3RYGr7S2ZND9ORrwCU3Ex1hWILhD
 CWYTSIQjtg0jZvF2++Ade/54krCsPzvLzvbjQOYJdp/rKRhOo9LTrZmXPcw53wyzrQ2fvyhDAi8
 W9HxEaN/JWPFUCzxOuw==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af2862f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KyXbCS5fjtpWEbryLUkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: J5fkEV1b7hSWyblXr0XBOZeFYWL8VH9U
X-Proofpoint-GUID: J5fkEV1b7hSWyblXr0XBOZeFYWL8VH9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100010
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClZpcnR1
YWwgUlRFIG11c3QgcmVzdG9yZSBzdGF0dXMgYW5kIGJyYW5jaCB0byBHRUxSIHdpdGhvdXQgc3dh
cHBpbmcKU1AgYW5kIEdPU1AuIEFuIGltcGxpY2l0IHN3YXAgdW5kb2VzIHRoZSBleHBsaWNpdCBl
eGl0IFNQU1dBUCBhbmQKcmVzdW1lcyBndWVzdCB1c2VyIGNvZGUgb24gdGhlIGtlcm5lbCBzdGFj
ay4KClNpZ25lZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29t
bS5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDYgLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBi
L3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IGYyMmQ0YTc3NTE2Li5hY2M2OGFhNmMyMyAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
aGV4c3dpLmMKQEAgLTgzMSwxMiArODMxLDYgQEAgdm9pZCBoZXhhZ29uX3ZtcnRlKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgIHVpbnQzMl90IG9sZF9zc3IgPSBlbnYtPnRfc3JlZ1tIRVhfU1JF
R19TU1JdOwogICAgIENQVVN0YXRlICpjcyA9IGVudl9jcHUoZW52KTsKIAotICAgIGlmIChHRVRf
RklFTEQoR1NSX1VNLCBnc3IpKSB7Ci0gICAgICAgIHVpbnQzMl90IHNwID0gZW52LT5ncHJbSEVY
X1JFR19TUF07Ci0KLSAgICAgICAgZW52LT5ncHJbSEVYX1JFR19TUF0gPSBlbnYtPmdyZWdbSEVY
X0dSRUdfR09TUF07Ci0gICAgICAgIGVudi0+Z3JlZ1tIRVhfR1JFR19HT1NQXSA9IHNwOwotICAg
IH0KICAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdfU1NSLCBTU1JfU1MsCiAgICAg
ICAgICAgICAgICAgICAgICBHRVRfRklFTEQoR1NSX1NTLCBnc3IpKTsKICAgICBTRVRfU1lTVEVN
X0ZJRUxEKGVudiwgSEVYX1NSRUdfU1NSLCBTU1JfR00sCi0tIAoyLjM0LjEKCg==

