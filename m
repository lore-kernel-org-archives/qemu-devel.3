Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51658606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A0iSgY6z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xqk/279h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Rw-00034q-LL; Thu, 22 Oct 2026 21:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rl-0002BM-0F
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Ri-0006Pi-UQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EqVl1335001
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=; b=A0iSgY6z99K8b/M8
 5Zrn/QBqid9HjPeTPcAsDOYSoMrUoiTvMvC28/gZcjDqQBWcXrUoWTNE6yfu89Wv
 D2EzMEQpafdniflt992LMgvV4PGEfiKfRN6Ir8CWSVdp96UgoqjGK7d3R3YlqhTz
 9QbF/rr9/eJJ1dMqTk/1Fsqpq7UlgerP+vPmCevV0KuYIiVmz14WVefwWQMQlwCG
 LYCAwWRPp/ikzL3LT+/+o3L7vWoAwXMGdz7XFE9opQ+MtL3UsxF0w8Z0Je20ITGP
 Mql0GIs5gHWbTjweX1Z4u3K7PfAVo6Z+JWOmf2naxdXXsE6brJzaRKdQIIIk2yTZ
 oomR8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8tju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so562509eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720299; x=1793325099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=Xqk/279he+ZCuESpLEDESPl1H8qLzVmRSa1eRAuOsdUc+4PRN2NhfguZ6QgkmYJv2u
 oR+Gwv4Uta1LJG51KIquP/sXC0LsZIJake38PcdeelPMx9mgLKurngNgXStmLuPq8gpH
 lXpLnB9QgxePfnijlhwO31reFqDbcF5XAqS/OXKADHjiObxamp5cClExio0AadgrlT1l
 o2lCYuR0ZJ6mDvII77dJoqerYWZBfQXj10OJ9kDlMSe5GY7xRJINrnLfwINdObWU6sdC
 cyWifdh/1bgMUMrUHkaZWVQMmBa+bH/CdzwMaE5HKYItXbfckhj07ygLR01Ba++naDQV
 wqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720299; x=1793325099;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=YzlhPJwLMVgh+vWQL4fRChqBLcZ/ozaWObDO4fbu7uC05F4r+r6Y9gK0rJtmMmQn1n
 klv7gQRB+WKiJVubUV18Mrxr0IArk0k2Bc4n15sEALJx200Efv/q7FK0oBR2yFaGU/2B
 CwaOs7gpsMCiYhVsUJgwQ+tUFnPjqjyXxWL5yRAl3r3+Tigt7GpwECbUFpASLaWWJDjc
 pcAZGyyqteffc+GRPStCDph8QuWBS/sRbEdW58QvAZtqXckljyH9WtjH6o4gJmcRjSAV
 x0P1ixDMBiCpMIGPHypUtAQX1GwWwKjxY1T0sHC+h/XqqQJ2RXtJDckP5YCep1DqKJ7D
 SQrg==
X-Gm-Message-State: AFq9FYJscqwjtIu7F50qjxZETpyLUE8QStkiTSLutlB//BdtBAaE+KwT
 tvVkMNDB8vnHakJbuqc5o9Pqige3U3LNUFOaY/Dv8MIXsfb1RaFlO8C5zien72qqALsME06Juo4
 faHsSrMA8sQR4OVF3J4gH4N5HbhfbMd4hX3aSa8j+BSm++CkKc5dwiNQO8PYn9PbiZA==
X-Gm-Gg: AYBFou37s0Q9NILNsKEgRMCWQo1c2nq26hQLetkieJLdX6NQZt268aFTvU1dL2p7qaF
 eNyELsvG0nud7S4rTMQU0k2RW/MvZ7ffHk9MpOlgdjMkCZnbFzbAMr6laU1v0rMOBh1JipZRNa/
 5Ab5lo1pbHh5NF04qYtxGyD4zgugNuZqKVegTO/qM1f2sHBbO0FoCxHLjnk8lX1JO6kLLEpQKET
 0qD5X1P8vKrXKMKaQcOJIvQYi4xc1RPUjpDog4z+6crOZ4aaNrsou3kpy1+PIuj2elKIWXPrAW4
 PxuBT4zeAD8OfkAPK/SN+/96ZfsASIE8DwGAKFNHRaY+KO2A8SPIpf128FLfksuHYBx/GvpzedU
 7HHsGkfb/wNzK8izA3ckSTfs2DNo+K2RphscPt5tqSCirMA8d
X-Received: by 2002:a05:693c:8110:b0:365:921:8ce with SMTP id
 5a478bee46e88-369d98b98b0mr1028497eec.32.1792720298594; 
 Thu, 22 Oct 2026 18:51:38 -0700 (PDT)
X-Received: by 2002:a05:693c:8110:b0:365:921:8ce with SMTP id
 5a478bee46e88-369d98b98b0mr1028478eec.32.1792720298064; 
 Thu, 22 Oct 2026 18:51:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 33/43] target/hexagon: drop a pending HALT when resuming
Date: Thu, 22 Oct 2026 18:50:30 -0700
Message-Id: <20261023015040.2473105-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX3dBkGThymzyG
 RwKGOjQACC0T5Oml2Rh68feCddM0+1l4gO9FTNqkC0P0/1p6mnXe/pMgfx298SzxHJdFvYJWUxx
 oB8h+6T54GbcCulxYis8jBtu3ri7JRXH1GSL3ZH1ECRcCSdX//q0yPSLiVvWgIU+7UQvKuS18K5
 HtFJoexjax8b6Y8mvh7ujk30SkqNyyL3Uwi5+hcg99IyYDvhevbdZxNYeQy5cNCK79mUCpqkOWb
 A8R49BiEU3o05jjiYfGrern95fqmEmJAmNdDEanMvj6BFx6/VBcEs3r1dziJOEDodSeEd8Qbj3E
 5mPafmLV7Vp9ukWqVYxOKbBBeBcW5r+d31XgW1P2dTXoK0s+CAjF5mrB91AyyOsgatT2QlpatS9
 KIFpxtQjTtExoic4B0gwGBg360fYKUmn0JWkZZAlF7UzyxQPvG9ubrpklH9aXppzdsdZooKqNZa
 wmasiGpNFh35GBNVOVQ==
X-Proofpoint-ORIG-GUID: Nn-WBzaEvL-dgm8r121FzQSKoylZyaEK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX8hgroOe3Cor3
 EH/ri/8Z27aFDTdqu5cYzjdJhMPcaBtKRAdKWDAey7cHDSVMCb0v/jhrB0JsiHj/uKOP9h7JbtU
 kYKfks50PivZG4d5wfe1RIod90/VaJA=
X-Proofpoint-GUID: Nn-WBzaEvL-dgm8r121FzQSKoylZyaEK
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adabdab cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=I2XebtYxRxNeac7nJm4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
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

QSB0aHJlYWQgZW50ZXJpbmcgd2FpdCBtb2RlIHJhaXNlcyBDUFVfSU5URVJSVVBUX0hBTFQgb24g
aXRzZWxmIGFuZCBvbmx5CnRha2VzIGl0IG9uY2UgaXRzIFRCIGVuZHMuICBJZiBhbm90aGVyIHRo
cmVhZCByZXN1bWVzIGl0IGluIGJldHdlZW4sIHRoZQpIQUxUIGlzIHN0aWxsIHBlbmRpbmcuCgpD
bGVhciB0aGUgSEFMVCBvbiByZXN1bWUuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmMKaW5kZXggYzY2YWQ4ODEwOGQuLjkxOWZjYmM3Yzk3IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBA
IC05OCw2ICs5OCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fcmVzdW1lX3RocmVhZChDUFVIZXhh
Z29uU3RhdGUgKmVudikKICAgICBjbGVhcl93YWl0X21vZGUoZW52KTsKICAgICBjcyA9IGVudl9j
cHUoZW52KTsKICAgICBBU1NFUlRfRElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgY3MtPmV4Y2Vw
dGlvbl9pbmRleCk7CisgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9I
QUxUKTsKICAgICBjcy0+aGFsdGVkID0gZmFsc2U7CiAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9
IEhFWF9FVkVOVF9OT05FOwogICAgIHFlbXVfY3B1X2tpY2soY3MpOwotLSAKMi4zNC4xCgo=

