Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA76C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYe-0005A4-Ox; Tue, 18 Aug 2026 15:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwPYa-0004in-2h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:33:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwPYY-0000QG-7R
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:33:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHMgs1943788
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fLkpQEVgDNAo2ykGVZolAU
 4cGHJQm6TCfv4fFi5+fg4=; b=CUvyH4LB/kpTtUWHscBVujLtQB6dl1XG5Uqtdh
 hL3PpEAyVsLYErffpffDczGFxCs5XuB28Eod1xmnX+Zk5uHDj7IwAs4VU3bb2D9x
 ErqIj6fDR/IewmmyG5NvdpIYIjN+vbJ1Uw3RE5/j1d2IQS+Pa1FHX+MStciTgMA5
 i6A6M2tZKHsr2lsJdsM1d7W9okpACyJq6zjahOsqwizbrzgcg0fSBCoVvdTdR1TS
 h4QNACntTpz+xVYBvB9Xvu1ls3WSaxWZptn6Vidt9w/Cxl1I8Jz4IAjbSf56/frM
 0eLf5E/aagr1PN55pIwEKXbwnRcesqbkEqv33k8ielSQHTDQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn2833-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:33:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so275586a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081583; x=1787686383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fLkpQEVgDNAo2ykGVZolAU4cGHJQm6TCfv4fFi5+fg4=;
 b=fAn8WpWMBhBS3oFQgTu6so2dqHz6SOIy3ItYAI4X0XvK3m49uGEN1YKsTK4IShrwA+
 NFZfiYjI8s9OAsJkuEhArBHngEDe/1ioZ45JyjZHnQeo3XwvX1Srlv/ZsK1S/uy6M1Zs
 C1S8nW0jx2BjwOQdHTaEs/JW1kbbCPnriYU/Mt6TmsHGGGumHHoJ/Wh/7Srs3kb06Jtw
 KydPxqX85VYHkGbxUnSB/58nxz8+q8zJWZHzEyzc5RoMy51i//ymtgSAckLGfSrZJMwF
 drEXXTIVlyooaxCI/PdVyNWmE80JsJ+fFOOblhOmKdyFaweXDt3O4/5nKLRVfaB7yGGx
 RoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081583; x=1787686383;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fLkpQEVgDNAo2ykGVZolAU4cGHJQm6TCfv4fFi5+fg4=;
 b=l8E4E2gWLHpx8mSo7Lq05Mzikcf5uye0/cklRS3uCgI0TLw8uxXFc2sfBiFCDcdmqU
 I5drW6JZF/nBEBG1DeASSVvV4P6HdH/1zt/f/EpmTHJtbG3yI5Hlk4/ez8u6lJD0TQ7g
 qPdNZ912dCXTSF0qfVHCuklHnu6SEZw5ED3AqTnuVGbO+nRZnOub6DC5RLgTvchfU28T
 lVwVM0hRpVPp/Cc5TXPnvgZTdW5GQd9OHRPu8y2/z7k804wBx9EGx7dTCuF8jRp1fCYI
 3a/7zSvb6AHnyYrYQ5xJVdhnwfzDkoTe0eIIqj9yJt89HYw+BwIA7gEFcoDvENpSNwfQ
 hlTA==
X-Gm-Message-State: AOJu0Yw75x8zDCp2roSsRA4SeVFtj4/0cMTWI8oWJZMWNAexRxuTLNZD
 Clnkym7pLZPCWlP4ktmkhNt1i7NFICRTnQCtrs7Kq3s0Ns/k+qoMrWxi+bnrNvSiQiLPduOr96x
 tyxgMnG6t6TYdRhR9ehAwicye39GF+XTdwIOlPKzvVXzL72f24DktpF+1tWUT/741oA==
X-Gm-Gg: AR+sD11O1SPvN8yl8buJ8R0YJws0PCxp5OZgRUCkOLeZBR4qI1vrKv9iqqn+dbH+D+E
 ZsTpwtyMje3QjThm7NFAnyzmgFZEHasJX7/ie7F8awtpUhZoYHdPTbpNihQEToEXcMVsdO40nq9
 Cpa4cOVEORd2ApAmSwelhzpi77wp2vpxUdMIoHQSq55ev1F/s/Evt6m1rynDfi52gUTwP7UMC0C
 JjJgMSOPQRYmmc28pcapeO8scYVON/H1J69nDLuu2SU/SkQMNyS7lOHzXoUsvI1bLAAXsDT2Lrg
 RMTfWn7fRaMg40TezOYsJpOPvfOF1ru+QveBA2iV2cabZedPvbi6a7e3j26uigv3Wka2INROApq
 B4yFr4j9n6arHg2ZHYni2QeHqHy34pV4lwlBNbxwgQM1blqjG
X-Received: by 2002:a17:90b:2250:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-3957b2bc33emr112115a91.5.1787081583065; 
 Tue, 18 Aug 2026 12:33:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2250:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-3957b2bc33emr112015a91.5.1787081582450; 
 Tue, 18 Aug 2026 12:33:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1415315e2c9sm18633593c88.9.2026.08.18.12.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:33:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, marcandre.lureau@redhat.com,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] target/hexagon: Add HMP info tlb command
Date: Tue, 18 Aug 2026 12:33:00 -0700
Message-Id: <20260818193300.2871415-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1dNPAUxMYGuZ
 4PQddJLv3IGaT8SPCmJUzq60fAlzfvuO3WhOtuWEJ8lHAp5oFtc04Dq++RjYtPd4hCtGWFrSY0a
 JpeGI3TkkuQiE7JtZa67MpZzKZ8Ywtg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2TqgJtQ7kp9W
 XKKhc6mOB9+pmB20Kq/WXQsBiTZzQtndbE74eksby80gy61okizDsRPwHBQ6HQA55vIfjXeAk7J
 i0YJhvOJfH3FL0wvjJlsM7cb7+7GNN7ZfjesnPPoOk8w+g/N6MJPtxYUwEuvKhZfoZxA8Uf1MMn
 FVJ2GYSaOge/NfUQ1h/OfGrUsUj7TUzYZV45pMunzZ5GSs4IFKhhPpPDGxaWiOPd8qaX2YytmpG
 An9mJaNVeTY+Chp/SHHK8XJ+ovfvtVSe8BiCIEV9lL2TlGsM1EQau3jLAb9mYZ6soDKUq6MtQ2a
 UfenAzbNDFUUhOkcyUlaipjFugNxnv8AGX4eQn0Ma02Hk7OwqgjFnHHUPrwv8Svv99g+plmnRDE
 KoURTyEsz7HXj2FmFtnGs7LPmQQ37RiEiUlDDIqidqmbexk/DKwVFKeitz+cKJT3V7gXKvHvXXj
 xkAnx60p42IOmMJIXPw==
X-Proofpoint-ORIG-GUID: yIaxUIlrFrZDhEN5PjWhqS8jLQjO1g9g
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b36f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=OWQKN7LhHfg1Drc0v9cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: yIaxUIlrFrZDhEN5PjWhqS8jLQjO1g9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL21vbml0b3IuYyAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysr
KysKIGhtcC1jb21tYW5kcy1pbmZvLmh4ICAgICAgIHwgIDMgKystCiB0YXJnZXQvaGV4YWdvbi9t
ZXNvbi5idWlsZCB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL21vbml0b3IuYwoK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21vbml0b3IuYyBiL3RhcmdldC9oZXhhZ29uL21v
bml0b3IuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uMTUwMDQ1NzY5
Y2MKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9tb25pdG9yLmMKQEAgLTAsMCAr
MSwyMyBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMu
IGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNs
dWRlICJjcHUuaCIKKyNpbmNsdWRlICJoZXhfbW11LmgiCisjaW5jbHVkZSAibW9uaXRvci9obXAu
aCIKKyNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCIKKwordm9pZCBobXBfaW5mb190bGIoTW9u
aXRvciAqbW9uLCBjb25zdCBRRGljdCAqcWRpY3QpCit7CisgICAgQ1BVQXJjaFN0YXRlICplbnYg
PSBtb25fZ2V0X2NwdV9lbnYobW9uKTsKKworICAgIGlmICghZW52KSB7CisgICAgICAgIG1vbml0
b3JfcHJpbnRmKG1vbiwgIk5vIENQVSBhdmFpbGFibGVcbiIpOworICAgICAgICByZXR1cm47Cisg
ICAgfQorCisgICAgZHVtcF9tbXUobW9uLCBlbnYpOworfQpkaWZmIC0tZ2l0IGEvaG1wLWNvbW1h
bmRzLWluZm8uaHggYi9obXAtY29tbWFuZHMtaW5mby5oeAppbmRleCA4MjEzNGViNmMyMS4uMGQz
MWZiOGE4NGMgMTAwNjQ0Ci0tLSBhL2htcC1jb21tYW5kcy1pbmZvLmh4CisrKyBiL2htcC1jb21t
YW5kcy1pbmZvLmh4CkBAIC0xOTMsNyArMTkzLDggQEAgRVJTVAogICAgICAgICAuaGVscCAgICAg
ICA9ICJzaG93IHZpcnR1YWwgdG8gcGh5c2ljYWwgbWVtb3J5IG1hcHBpbmdzIiwKICAgICAgICAg
LmNtZCAgICAgICAgPSBobXBfaW5mb190bGIsCiAgICAgICAgIC5hcmNoX2JpdG1hc2sgPSBRRU1V
X0FSQ0hfSTM4NiB8IFFFTVVfQVJDSF9TSDQgfCBRRU1VX0FSQ0hfU1BBUkMgXAotICAgICAgICAg
ICAgICAgICAgICAgICAgfCBRRU1VX0FSQ0hfUFBDIHwgUUVNVV9BUkNIX1hURU5TQSB8IFFFTVVf
QVJDSF9NNjhLLAorICAgICAgICAgICAgICAgICAgICAgICAgfCBRRU1VX0FSQ0hfUFBDIHwgUUVN
VV9BUkNIX1hURU5TQSB8IFFFTVVfQVJDSF9NNjhLIFwKKyAgICAgICAgICAgICAgICAgICAgICAg
IHwgUUVNVV9BUkNIX0hFWEFHT04sCiAgICAgfSwKIAogU1JTVApkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCA0
YzkyMWVlZTczYi4uYTg0YTM1MTA2ZjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29u
LmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0yNjEsNiArMjYxLDcg
QEAgaGV4YWdvbl9zb2Z0bW11X3NzLmFkZChmaWxlcygKICAgICAnaGV4X2ludGVycnVwdHMuYycs
CiAgICAgJ2hleHN3aS5jJywKICAgICAnbWFjaGluZS5jJywKKyAgICAnbW9uaXRvci5jJywKICkp
CiAKICMKLS0gCjIuMzQuMQoK

