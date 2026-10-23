Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60387606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dAjF3aGr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWSm2kiH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4R0-0000zd-HC; Thu, 22 Oct 2026 21:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qo-0000TE-OE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:50:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Qk-0006GK-L0
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:50:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EtcC2389423
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 edtZMRXwtbbTQDqZwOhKhc6gWq5Iy5v2tvv6SyBk5WU=; b=dAjF3aGr2Q6bmtHx
 JbSKFkaK2WlGMsd+I6rU26OqdTfz7XRF0mHbhjXAXQMV1pP8eqS8yc9W3S/rrrhj
 /t2llbcGl3pZqLCN9TNC67cFdFlx5+lb3Vwyy12EhpP6r4dPQoJZxpmITuaXjVwu
 F6GG53ncmR83w3EIE65ROTFuzYWfx1FVNFuLjzz9rGfEB8Pc4slAmKz8lyShZYjq
 HEcd4KDvz+6CPHiK7AXTwhFZeXkPPjmdAERKHDf8dpXMnKkrpHJ1icGiRawXLMMv
 FWtNOKrFaoWpkk67IgtVGoQ989UYziU6kB+pAMM4ws9veHu0VljXf1SCJ+1IrJwa
 aZBr2g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp9c6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:50:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so1807056eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720248; x=1793325048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=edtZMRXwtbbTQDqZwOhKhc6gWq5Iy5v2tvv6SyBk5WU=;
 b=hWSm2kiHQ0iIGEIqNnyPaVQ1flZVhrlOmLvxvqbUFwMFQSRB4oNkLGqUa/Ep9paq/g
 Y4e+/ma9g7QksOeDMQ3KR/ZcOVlUxjkC3c4RYs7nNx+cVKrkMUW1eRK4l/LOEuY1iWPk
 xy5lJNv2l4FdW/t+RC/D22RVA5GWpTZO1IITWfbEnu56oghrPYtx+0c5CNawHm92iXNL
 fQbdWYDDUuPYcr2IjI4ObBwS+JSdgV/tbIKaqM+p9+pHVQfRdJ07gzG2OpdhROFi5oS8
 Wslo2HAfrjmvqReQCDQEBLSJb5VmGjP15Ndyy+I5xw0KKMqzR8sGHu+FSZnSJm3RUyMn
 ZzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720248; x=1793325048;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=edtZMRXwtbbTQDqZwOhKhc6gWq5Iy5v2tvv6SyBk5WU=;
 b=Qpxl9kLH4fLG+zXQeAIyiGv0UzCbFYxOxUcVe+Qcqh9JqGC5t8ELduK6ULcyqKUaFF
 h0DMGR3gmZYOtac04HbggMaPiEbHlRl5DjpeWTexSK4T/rOYTpeGDACnubxzqJWkP8D6
 MAU1qoWd5QMgf3xV6urvNZNMITXDUovtRaXV7ptOaN63zVdu4FZgspCHpqvudEKHMLqI
 DXi0AlnSJJKjxCfFWPodVxlKaZkG63UrjyUxVD+ZWtAlp1KOdXH+n6HjJct/rrIvFa91
 AEzmVewn7p4+yRMCDWZNvYhnELHJUcSCm09NyzdYJ6IHW+Bl3dWh0SHdQbdWFhIrZ/WS
 6Jng==
X-Gm-Message-State: AFq9FYISaSY1OVBE1mKW1IVuLjSRkzKR98W6lJNlMgGArWjO9EHsAZOH
 CL3D8iuY2XDVDPY96IG1H1Y2ez4r17rBic9o4R7D+Enfkm01ZJCYZAEl2mhWmJH88vay+kkBzdR
 b0wgsEmARBqcvRBXA9zIO27tvb7znXf2gcpJTL3xcC5TSbWA6fttybQr7eqIf83v3pw==
X-Gm-Gg: AYBFou2V7dTwW4MH747y5Wgn8lPdhO3/6BGYUJe4pxa3i8QZ2cUmpWWU6X9XReMA9IA
 ShelDBk4K5gzqfkG7Vt1iFBseHwsSJbihAXN7EoUJ87yrJdKAlPBcKrtDtovvfETR0zVm2EyNNx
 chn/9qfGEGzHADiIaZ8vNCbZBH49zWB3NXhwcHfq4BwrVszIF0nh7lUmKi+LQeO4q1m/ijiXRrU
 GUL+/qlRJHgmvQCCRc0mF3FLNIokP4tVPtbDavdJRgswfHo+IPQLKDdbUa8g5saxusFJmF/CwAH
 NfAljmjAK5wzNupsC/us8oY29VCa1RWgnk+jMDmCkSGf7KgDuDmGgGBg7H+iLNMO7OWsjIhMfzT
 LiL+m2DFVU1Rt3uQfZYvuTVk4wPbPddQFlIE2YfJQtilL5sTq
X-Received: by 2002:a05:7301:1a16:b0:368:72f0:353a with SMTP id
 5a478bee46e88-369d988d119mr1015484eec.38.1792720247594; 
 Thu, 22 Oct 2026 18:50:47 -0700 (PDT)
X-Received: by 2002:a05:7301:1a16:b0:368:72f0:353a with SMTP id
 5a478bee46e88-369d988d119mr1015465eec.38.1792720247040; 
 Thu, 22 Oct 2026 18:50:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:50:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 01/43] hw/hexagon: add V73NC_1 machine
Date: Thu, 22 Oct 2026 18:49:58 -0700
Message-Id: <20261023015040.2473105-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXzmgk8xGPnxSO
 qNdmvPwZqLDl6q3Gq86UR12fgBXMV4Mr/9OFQtWsjnnZsmqk4J1/Kl9fX8O/T1Wtg5J8+Ae7kJL
 RMNOTeYR8z8Wu9APzAd/JtRfc/7ZrSc=
X-Proofpoint-GUID: zhjn0GVqeHutePZgd8Apb25HTJmIeb7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX8hkFvXNN3vdj
 7WZcswx2+fz1X4RaNM1hCAmyptMztWqehrd3oxrvRAUNtR18ueCum43pjN1zyDgSHH3tkt/3dRf
 wubkNy9ObQfnKhdR+TNcZdLJJEtPXbKcAOGc13xV8K2Dktld5cY007IM+ArXtESO0X0CON9aACP
 3iP/lK6d4/zfAFOOo4HnNqc002NxUPl7y5hNkLIaapgs5tkjF1V7s5JryU3BzGEyWCqy/ray1n7
 d07eu1klViuTNkLKKuFXGj9f6fY9DZNJFZasgQXXIwOeRAPvmPP8S2bxbCsCZGFJBwxq9TAOacX
 VGg15XD+Ovvbtj8P5nsuBlEI3jkFQaFZwOShwmH1k+TITkqo/QR85mfBqRhg7ecacZZIaw/a69y
 hckIRU6lw9H3kvntnGyo70oHh9KIhyXsnRwdZGMkcW9nw380vyDhmmThX0xf9BBWe1RIO5XmIIs
 yDFCN+btgaumD7EVZ4Q==
X-Proofpoint-ORIG-GUID: zhjn0GVqeHutePZgd8Apb25HTJmIeb7F
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adabd78 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pj8LCFR3QBkfOnWAeuwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KClNpZ25l
ZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClJl
dmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9oZXhhZ29uL21h
Y2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysrKysrKysKIDMg
ZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hl
eGFnb24vbWFjaGluZV9jZmdfdjczbmNfMS5oLmluYwoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
aGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCmluZGV4IDli
NWQzM2ZmYzNiLi5hMDFjZjVjYjNiMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCkBAIC0yNyw2ICsyNyw3
IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjcxX3JldiA9IDB4OGM3MSwKICAgICB2NzNfcmV2ID0g
MHg4YzczLAogICAgIHY3M21fcmV2ID0gMHhjYzczLAorICAgIHY3M25jXzFfcmV2ID0gMHg4Yjcz
LAogICAgIHY4MV9yZXYgPSAweDg3ODEsCiAgICAgdjgxZGdiXzFfcmV2ID0gMHhjYzgxLAogfSBS
ZXZfdDsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjczbmNfMS5oLmluYyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjczbmNfMS5oLmluYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMC4uNzI5ZTQ4OTc1YzgKLS0tIC9kZXYvbnVsbAorKysgYi9ody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMKQEAgLTAsMCArMSw3MyBAQAorLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8KKworc3RhdGljIGNvbnN0
IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY3M25jXzEgPSB7CisgICAgLmNmZ2Jhc2Ug
PSAgICAgICAgICAgICAweGQ4MTgwMDAwLAorICAgIC5sMnRjbV9zaXplID0gICAgICAgICAgMHgw
MDAwMDAwMCwKKyAgICAubDJ2aWNfYmFzZSA9ICAgICAgICAgIDB4ZmM5MTAwMDAsCisgICAgLmwy
dmljX3NpemUgPSAgICAgICAgICAweDAwMDAxMDAwLAorICAgIC5jc3JfYmFzZSA9ICAgICAgICAg
ICAgMHhmYzkwMDAwMCwKKyAgICAucXRtcl9yZWdpb24gPSAgICAgICAgIDB4ZmM5MjEwMDAsCisg
ICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsCisgICAg
ICAgIC5yZXNlcnZlZDAgPSAweDAwMDAwMDAwLAorICAgICAgICAuc3Vic3lzdGVtX2Jhc2UgPSAw
eDAwMDAyMDAwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5LAorICAgICAgICAubDJj
ZmdfYmFzZSA9IDB4MDAwMGQ4MWEsCisgICAgICAgIC5yZXNlcnZlZDEgPSAweDAwMDAwMDAwLAor
ICAgICAgICAubDFzMF9iYXNlID0gMHgwMDAwZDkwMCwKKyAgICAgICAgLmF4aTJfbG93YWRkciA9
IDB4MDAwMDMwMDAsCisgICAgICAgIC5zdHJlYW1lcl9iYXNlID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLnJlc2VydmVkMiA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5mYXN0bDJ2aWNfYmFzZSA9IDB4
MDAwMGQ4MWUsCisgICAgICAgIC5qdGxiX3NpemVfZW50cmllcyA9IDB4MDAwMDAwODAsCisgICAg
ICAgIC5jb3Byb2NfcHJlc2VudCA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5leHRfY29udGV4dHMg
PSAweDAwMDAwMDAyLAorICAgICAgICAudnRjbV9iYXNlID0gMHgwMDAwZDkwMCwKKyAgICAgICAg
LnZ0Y21fc2l6ZV9rYiA9IDB4MDAwMDA4MDAsCisgICAgICAgIC5sMnRhZ19zaXplID0gMHgwMDAw
MDQwMCwKKyAgICAgICAgLmwyZWNvbWVtX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAudGhy
ZWFkX2VuYWJsZV9tYXNrID0gMHgwMDAwMDAzZiwKKyAgICAgICAgLmVjY3JlZ19iYXNlID0gMHgw
MDAwMDAwMCwKKyAgICAgICAgLmwybGluZV9zaXplID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnRp
bnlfY29yZSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMml0Y21fc2l6ZSA9IDB4MDAwMDAwMDAs
CisgICAgICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsCisgICAgICAgIC5yZXNlcnZlZDMg
PSAweDAwMDAwMDAwLAorICAgICAgICAuZHRtX3ByZXNlbnQgPSAweDAwMDAwMDAwLAorICAgICAg
ICAuZG1hX3ZlcnNpb24gPSAweDAwMDAwMDAyLAorICAgICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3Ro
ID0gMHgwMDAwMDAwNywKKyAgICAgICAgLmNvcmVfaWQgPSAweDAwMDAwMDAwLAorICAgICAgICAu
Y29yZV9jb3VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzAgPSAweDAwMDAw
MDQwLAorICAgICAgICAuY29wcm9jMl9yZWcxID0gMHgwMDAwMDAyMCwKKyAgICAgICAgLnYyeF9t
b2RlID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmNvcHJvYzJfcmVnMiA9IDB4MDAwMDAwMDEsCisg
ICAgICAgIC5jb3Byb2MyX3JlZzMgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWc0
ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnNSA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5jb3Byb2MyX3JlZzYgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWc3ID0g
MHgwMDAwMDAwMCwKKyAgICAgICAgLmFjZF9wcmVzZXQgPSAweDAwMDAwMDAwLAorICAgICAgICAu
bW5kX3ByZXNldCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMWRfc2l6ZV9rYiA9IDB4MDAwMDAw
MTAsCisgICAgICAgIC5sMWlfc2l6ZV9rYiA9IDB4MDAwMDAwMjAsCisgICAgICAgIC5sMWRfd3Jp
dGVfcG9saWN5ID0gMHgwMDAwMDAwMiwKKyAgICAgICAgLnZ0Y21fYmFua193aWR0aCA9IDB4MDAw
MDAwODAsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDAwMDAwMDAxLAorICAgICAgICAucmVzZXJ2
ZWQ1ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnJlc2VydmVkNiA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAwMDAwMGEsCisgICAgICAgIC5jb25zaXN0
ZW5jeV9kb21haW4gPSAweDAwMDAwMGUwLAorICAgICAgICAuY2FwYWNpdHlfZG9tYWluID0gMHgw
MDAwMDA4MCwKKyAgICAgICAgLmF4aTNfbG93YWRkciA9IDB4MDAwMDQwMDAsCisgICAgICAgIC5j
b3Byb2MyX2ludDhfc3ViY29sdW1ucyA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3JlY2ZnX3By
ZXNlbnQgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9mcDE2X2FjY19leHAgPSAweDAw
MDAwMDAwLAorICAgICAgICAuQVhJTTJfc2Vjb25kYXJ5X2Jhc2UgPSAweDAwMDA0MDAwLAorICAg
ICAgICAuQVhJTV9kYXRhX3dpZHRoID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwxZF93YXlzID0g
MHgwMDAwMDAwMCwKKyAgICAgICAgLmwxaV93YXlzID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwy
d2F5X251bSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kbWFfanRsYl9lbnRyaWVzID0gMHgwMDAw
MDAwMCwKKyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBi
L2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwppbmRleCA4ODI0ZmUxMGE1OS4uZDkwNGQ1YWZhMTQg
MTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMKQEAgLTMwLDYgKzMwLDcgQEAKIAogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y2
NmdfMTAyNC5oLmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMiCisj
aW5jbHVkZSAibWFjaGluZV9jZmdfdjczbmNfMS5oLmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2Nm
Z192ODFkZ2JfMS5oLmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192ODFxYV8xLmguaW5jIgog
CkBAIC0yMDAsNiArMjAxLDIyIEBAIHN0YXRpYyB2b2lkIHY2OG5fMTAyNF9pbml0KE9iamVjdENs
YXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBtYy0+ZGVmYXVsdF9jcHVzID0gNjsKIH0K
IAorc3RhdGljIHZvaWQgdjczbmNfMV9jb25maWdfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUp
Cit7CisgICAgaGV4YWdvbl9jb21tb25faW5pdChtYWNoaW5lLCB2NzNuY18xX3JldiwgJnY3M25j
XzEpOworfQorCitzdGF0aWMgdm9pZCB2NzNuY18xX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25z
dCB2b2lkICpkYXRhKQoreworICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9j
KTsKKworICAgIG1jLT5kZXNjID0gIkhleGFnb24gVjczTkNfMSI7CisgICAgbWMtPmluaXQgPSB2
NzNuY18xX2NvbmZpZ19pbml0OworICAgIGluaXRfbWMobWMpOworICAgIG1jLT5kZWZhdWx0X2Nw
dV90eXBlID0gVFlQRV9IRVhBR09OX0NQVV9WNzM7CisgICAgbWMtPmRlZmF1bHRfY3B1cyA9IDY7
Cit9CisKIHN0YXRpYyB2b2lkIHY4MWRnYl8xX2NvbmZpZ19pbml0KE1hY2hpbmVTdGF0ZSAqbWFj
aGluZSkKIHsKICAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hpbmUsIHY4MWRnYl8xX3Jldiwg
JnY4MWRnYl8xKTsKQEAgLTI1OCw2ICsyNzUsMTEgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGhl
eGFnb25fbWFjaGluZV90eXBlc1tdID0gewogICAgICAgICAucGFyZW50ID0gVFlQRV9IRVhBR09O
X0RTUF9NQUNISU5FLAogICAgICAgICAuY2xhc3NfaW5pdCA9IHY2OG5fMTAyNF9pbml0LAogICAg
IH0sCisgICAgeworICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJWNzNOQ18xIiks
CisgICAgICAgIC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCisgICAgICAgIC5j
bGFzc19pbml0ID0gdjczbmNfMV9pbml0LAorICAgIH0sCiAgICAgewogICAgICAgICAubmFtZSA9
IE1BQ0hJTkVfVFlQRV9OQU1FKCJWODFER0JfMSIpLAogICAgICAgICAucGFyZW50ID0gVFlQRV9I
RVhBR09OX0RTUF9NQUNISU5FLAotLSAKMi4zNC4xCgo=

