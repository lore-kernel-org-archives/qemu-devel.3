Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F8C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4L-00062M-RB; Tue, 15 Sep 2026 12:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4A-0005zg-Lq
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W48-0003rq-Po
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAc5h813981
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rBXlxaNGAMkAydJ5ombBnoAHAkAmT2hhBvrVhestqV4=; b=UOuMmC/AY8Km/Wne
 rrhtZJdENrXPN+YgUObpj4R8HZvM2XAFz66j5lKFA8K1HYaNKRAIFCkiK/JqloyT
 i8usDOcNxNi+7K11TePZNMzq4vxNtxzh/H8uC0TkCJ0/+C0shigPaHI0dNMSPLmM
 PmEZfEKVdbl2wkfEPJ4UlrrBBFZTC35oP7RaJ7rLZDic0xiU+YhSPdXrf9FsbxCI
 XhV3Vfg3kIKf5Mzc/iK7lllvjoH0jUMAS8yK9nKwzVJIYxtSEcfHCeCT8HmFb+dT
 9ithU6Jbes+zuqF0m5sg9Gfgtn7pZ2RYM2B5EvuWYPB79tfMFOOUPeaXGvYTJsG4
 oQUfHA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc174s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so3391401a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489886; x=1790094686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rBXlxaNGAMkAydJ5ombBnoAHAkAmT2hhBvrVhestqV4=;
 b=hNSFwO65cBgV1FDeD9kUT/ViTkTAIBzmTosVsNn0mHWj91SPs4vFtBHq2vm+ScCrNo
 aaA6PjnsNwUkov94DEJ1jukpZ6CuxHgrUDb1pGrFMCEaxohu5wNZzu1fzVip+4lYTnBt
 4FNv+TR3OTSRu6DAwvxMgj/xyByGRgATzUZlru7SgL/E3NRUMdvkhfhWxPDKTkACuRV8
 5vhTGJKRrhyTwQ2uxBnzy51Owg67EOdDW4J3LTrJlLqbhJXi92nWw0aE0eUKHk23XMAI
 H+Z86tIYsLhtsfNBz6N9YGnWIdsmBOB5hRofyF/nAVMAhZBsVOdcAKOir/sMQJmI4Uz2
 CxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489886; x=1790094686;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rBXlxaNGAMkAydJ5ombBnoAHAkAmT2hhBvrVhestqV4=;
 b=AHcwTqL1jVbX5ATuxKkEkadbFH9oWH3xoyAR7XNYqs6hSof1kDIYhT5Yl5SmnysKwU
 htQa5tM+VT6ZmFj0QcLK0R5tEUvLtW8gTxble7qSFzLrJJWW+u+pcm1K3NUmAgFRQ6g/
 SQJF3KY5QIM4Db39mEnTPZcGecnObM255ryJJWXlaK4CzzgWHW7ftYmu/BEb+olGEIso
 7o1f7NFb34UP31xL7tDJydmNJTpTAKTk5cRm/05sAFCJKBgjX2ZwTwW6CRwc/KNOoLij
 zwkk85ayNcF7MGS650WpA1EkuZhqjYUK7BGB2JKWQQn7IJqGCyxu6qK3Q1O7G4AwKY6n
 PuIA==
X-Gm-Message-State: AFuF++kehbFpv8bYxc0ivk0sfhnXSKyQPyYaS3Y4egUfPoGEKZLh9OUC
 lGYrjLFYW5cpjd4KBJzGowwVsbB5XGdafcfA4jmaACQ8sygfijgQ7YfKd82ckGMIMyRPAhpGfgv
 fcGPdlRugpUz4UErKfiVDBCR4TWWHr4BNfXUNftOhKHmUiBXuLRocrsVWExTigTytCA==
X-Gm-Gg: AYBFou120iK2waSyHok/lO+vJ2NhSXF5sX59HxHVV8KA9TgG2ewCBbQKmKSVuVDHWTH
 N8TU9ItGuIu0So03qT5C6MaJl7d14elkI4kwE8TFDrl/Yg4c3a2sBjZ4PMjWqRsKJrYuO2mhR4r
 rZ412Dz+GhS9fTTlLEbWR3xMTGAifDC7eATAhi0NF7Jmw5paOD78zFptNOB2wM4UcovzO3XVp8j
 6DYJssg3oOH+zk+FnZ2z/NACaafuNKnyjSJstrtraPfiPkgXCkQkZzZhJBRwmB4o6/L8jeVZgPD
 D/JMvE8d8FKFDewZZds5I+qpzese3+3+3zZsn+PSaaeUmy8PNmX1gbbwyYeygNQrMgtzrNstMU/
 7j8xTY3dMu728dUk2iZl4mJHfQiMCCUfzzqb7kXpgp9PUWgyp
X-Received: by 2002:a17:90b:1d52:b0:39d:f189:48d6 with SMTP id
 98e67ed59e1d1-39e10c45f67mr3364541a91.4.1789489885835; 
 Tue, 15 Sep 2026 09:31:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:39d:f189:48d6 with SMTP id
 98e67ed59e1d1-39e10c45f67mr3364478a91.4.1789489885379; 
 Tue, 15 Sep 2026 09:31:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 14/17] tests/tcg/hexagon: add predicate register transfer
 test
Date: Tue, 15 Sep 2026 09:30:44 -0700
Message-Id: <20260915163047.4180600-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX1jzuZKv1onp0
 Vz8QwPDQY8xAvUriDP033e555U5jTJMGGLSABp9c6oOtF90owr4I4ltnaWmMYOjuRNIhuh78+EK
 YmcXy1HQwRPcqcmFF+e0mkqgYWpIyqw=
X-Proofpoint-GUID: CgQ3rXH3-sjxun5yJTP_D12WWYD3XwtI
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa972de cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=yBA84NwwydepxRIuKt4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: CgQ3rXH3-sjxun5yJTP_D12WWYD3XwtI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX/iGNNK0CEjcV
 bVl+fBzoRu2UYj9wgejQuhnscva2QJge4Rx+AyrnyxexKIb2+FBkmQ8NHKkYF/j3k3pDdg+7jOD
 Lw150AuP07+JgvZFXtPKZZ5tk5op2O4pAw8WsmylKq3PKNE+oJ9411WxmWZu8g50vmdpAT48FHD
 kQPGt0+lRtGPudbx+GDdNNVkVoTaFd/bSr/DOxAIiB8H3moBd40zDBaMEA8GOWo8vj5/r6uqE2g
 vsqlknzaFIo/lfIs8lTSguysPvreazFaaEbqlf8BrgY7fKewpbwktsaQWVr/JhUb2bweHvE0BFA
 5ekAk/TkQNt/Q55VIUAkLC+G0Qquwjh27IPug4JE91N6DdEMf3PZ5L4f6f0g+O3FysEtH4Ltrby
 IIGdghQ7czoprmgCIFR2PAtkF5cfoddQr+Clw1bLaxJYm+WoqyJTosg1ov9l154NRruJrDuFivP
 4t/nNKeILf3txUcOe1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyB8IDI2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21pc2MuYwpp
bmRleCBjMDc1NDdiNmY2OC4uYWJiMzRhYjZhNjUgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhh
Z29uL21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKQEAgLTQ0Niw2ICs0NDYs
MzEgQEAgc3RhdGljIHZvaWQgY2hlY2tfc3RvcmVfaW1tKHZvaWQpCiAgICAgY2hlY2szMihzdG9y
ZWltbV93b3JkX2FycmF5WzJdLCAweGZmZmZmZmZmKTsKIH0KIAorLyoKKyAqIFJkID0gUHMgLS0g
dHJhbnNmZXIgcHJlZGljYXRlIHJlZ2lzdGVyIHRvIGdlbmVyYWwgcmVnaXN0ZXIuCisgKiBUaGUg
cmVzdWx0IGlzIDB4MDAgb3IgMHhmZiBkZXBlbmRpbmcgb24gdGhlIHByZWRpY2F0ZSB2YWx1ZS4K
KyAqLworc3RhdGljIHZvaWQgY2hlY2tfcHJlZ190cmFuc2Zlcih2b2lkKQoreworICAgIHVpbnQz
Ml90IHJlc3VsdDsKKworICAgIC8qIFNldCBwMCA9IHRydWUsIHRoZW4gUmQgPSBwMCBzaG91bGQg
Z2l2ZSAweGZmICovCisgICAgYXNtIHZvbGF0aWxlKCJwMCA9IGNtcC5lcSglW3ZhbF0sICVbdmFs
XSlcblx0IgorICAgICAgICAgICAgICAgICAiJVtyZXNdID0gcDBcblx0IgorICAgICAgICAgICAg
ICAgICA6IFtyZXNdICI9ciIocmVzdWx0KQorICAgICAgICAgICAgICAgICA6IFt2YWxdICJyIigx
KQorICAgICAgICAgICAgICAgICA6ICJwMCIpOworICAgIGNoZWNrMzIocmVzdWx0LCAweGZmKTsK
KworICAgIC8qIFNldCBwMCA9IGZhbHNlLCB0aGVuIFJkID0gcDAgc2hvdWxkIGdpdmUgMHgwMCAq
LworICAgIGFzbSB2b2xhdGlsZSgicDAgPSBjbXAuZXEoJVthXSwgJVtiXSlcblx0IgorICAgICAg
ICAgICAgICAgICAiJVtyZXNdID0gcDBcblx0IgorICAgICAgICAgICAgICAgICA6IFtyZXNdICI9
ciIocmVzdWx0KQorICAgICAgICAgICAgICAgICA6IFthXSAiciIoMSksIFtiXSAiciIoMikKKyAg
ICAgICAgICAgICAgICAgOiAicDAiKTsKKyAgICBjaGVjazMyKHJlc3VsdCwgMHgwMCk7Cit9CisK
IGludCBtYWluKCkKIHsKICAgICBpbnQzMl90IHJlczsKQEAgLTU5MCw2ICs2MTUsNyBAQCBpbnQg
bWFpbigpCiAgICAgdGVzdF9kcG1weXNzX3JuZF9zMCgpOwogCiAgICAgY2hlY2tfc3RvcmVfaW1t
KCk7CisgICAgY2hlY2tfcHJlZ190cmFuc2ZlcigpOwogCiAgICAgcHV0cyhlcnIgPyAiRkFJTCIg
OiAiUEFTUyIpOwogICAgIHJldHVybiBlcnI7Ci0tIAoyLjM0LjEKCg==

