Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ABAC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SN8-0005ZK-62; Tue, 01 Sep 2026 13:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN1-0005Xi-IT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SN0-00080J-06
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HTorc2594390
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tUb6HZcIOhxOTay/dp40hNaQg6ai7PBaXk7NXeGW/Mw=; b=KzJ3az8uhgnfA/Ks
 7KV8XNvccCjI3KWIM552XWpXRv15LMAW8YWwfOgtQaASPECK/7YeczF08aVRTNHp
 LKFodSC/RMcAo45FJ1hY4hnmvTh80u1nAzx/2g2ZUtLfbLxG9WMkfR6melsVRIPz
 bRNtkPC08Yt0+SNwZAHSrKPZC7tunp5Lr7AwUJUp0XJtrYfd18ohHq0el2WC1lSB
 q/JPrTbcqTXRUaiQUD2up6Lnahbs+7iZYb60oaANORL6vDJK3DKkqMbxXsekIc44
 fnjXlV2haN5ourGV9vNhsZIr190opEG3qPeVEK9k2i022tCHru6Agb8107Q5rRXe
 2Iwt4A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k00gx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so160066a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284040; x=1788888840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tUb6HZcIOhxOTay/dp40hNaQg6ai7PBaXk7NXeGW/Mw=;
 b=Z2cSn7CXIw8a6RAgwooWIHy6pu914uM+ugw6jsw8WUjDVn0KFJa/pNIxbwi4mJKwYa
 6WXT93EOFCRikPDTxpdPhbl6OFUesnXvSyw0TVxnMJKS1IMVJrUW1pL2t74wpsAgRQKz
 RUhBJz0Yj9y6lP96Kr83ngHwxU6iMQK7J+iSIrhK8Ih85rqvLHQBoyv1anivn9PtX0bP
 S1ITNqw53e5Bo7PuHTbBYOmFZ09BC/iynHJp6skhcTl58jy/oZV2rfSGH6DKLE/BHBei
 CcNHA76tCDU12Mt5sWs8hLRn7lX6dWRJA1aXLBPFLkfCipKg1NGsWILhdkMGwRw1Fczb
 ZsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284040; x=1788888840;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tUb6HZcIOhxOTay/dp40hNaQg6ai7PBaXk7NXeGW/Mw=;
 b=dnfUFGb1/0hxI4qsbzIyVNoojoWO98CBnmR9K8my37lp5ci1DTEO0NmLMSmdgTB8xM
 EzlX91URVG/AWZNc58U5W9zaQ3qVqBjk9xHC67S//lfdeOXI3bOhdZAiITmY6l6a2IKC
 mlTbKhYZIgqzCTrnglYA0k3cX0wqhpCVGV8cdwp15P7jk+o8qRxUB4u3L5MTijOEK+kn
 RswpLBBKJR3XS8KAVkpnwGm+lQ4TPNsc2unwwh+yC7coqm9WPSzvD/3Y7okP/mLBU3B/
 OXqJUqIxOnfw0pn8CRG4UlBX4ou8WOp1twIhmgwhU3qVPcPzNocacx5WWZjD7m4QVFsf
 sIWw==
X-Gm-Message-State: AFuF++mVw42R1f/A1IU33ey1NTbceg2iX4ZlRZHvFeVWZUJrGo5EOcDU
 rJ6ruKN405Mh3ZxugHbK+EEGViMdp1AzmaLTVgbte5xkr5+c9JjxWZFO21NCReG8pT/VHnKzKNZ
 mnj/82KpgI9qBAO2bx7cuBVo8r+GKGPkfpIQrRK8LvwI8p3yiubp83qnePm1XmSN/WA==
X-Gm-Gg: AYBFou2BGwKyqHp0/GKlvlcZXh/tJi/A8kR2Azdckb7yV7gDsC8NW9f9kl4ybRnHgdW
 vfqSWKaPYm5jKeNxAd4Xqr1EQhIGCRu4jRx/VbGa5Y8GodYp2pqVzpkSALPN9aUIdlNBG3Pqr3z
 xMxy0r0HisUMCpaOWJfE5i61rIdvHk7cWPThSdPAC9bJ+MUZ9P3oayDb0MHPzu2ayNY5u1w1JxD
 hEUIi+yge+gSMS76jMr9GSotQL8eLejKS4ijzUGlTkWqeyHmyx5X72LWeKN2T5FeUgrh+tccxoz
 nvfJawQc1h/fSZKE0G3Rlbz2ATdDT3oMSD1/RdBVn7yjoQLwXIDiZOOUgphCtmOAbC8+XSQrQ/7
 yrqQmNT1JcHxCDyi6ZSWS7HGSecL6MrzUVrsRuYvYtPf1HLf+
X-Received: by 2002:a17:90b:264c:b0:396:61f1:da5c with SMTP id
 98e67ed59e1d1-396d0e86577mr55408976a91.4.1788284040010; 
 Tue, 01 Sep 2026 10:34:00 -0700 (PDT)
X-Received: by 2002:a17:90b:264c:b0:396:61f1:da5c with SMTP id
 98e67ed59e1d1-396d0e86577mr55408920a91.4.1788284039604; 
 Tue, 01 Sep 2026 10:33:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:33:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v2 03/11] hw/intc: clear pending bit on l2vic de-assertion
Date: Tue,  1 Sep 2026 10:33:45 -0700
Message-Id: <20260901173353.200474-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NCBTYWx0ZWRfX0DljbRidTILa
 kItZcPjycWSZDzEaMJlkttcRXDaBHY6GyQDPgc8UwtBNC4lcAxyZ368vvYvhEOIsPWcIhasXZ8x
 FcWlWW+FrCgqXTlJ/k42hpGVhH5PF8k0gW6QMOYgkUxxb9be+FeTVKG5ugdHOh+fAXtKMZ0lUDc
 iEkfOhYgRVWZ2vTOFnyVB/ETHQgJEkY1uccUyuQ1cjj/O7Hx0e/uRqYeOrI8tyihc2S6FArJyBA
 oqbYvmVwk3LrIMr/9iXuXsW+y9G6ByJ97ZVqXl+IbXsohh0qEK/zD5c2CDU5YDadLbHJdJsVV9v
 qEOyH1KEaFqpOIzr0VYvW+FOHy+tkVQF6JCWlvNKTwbdpsoSHrnNB6YJkjQr26XPI+rdHkksNXw
 l80ifKAfJWf1rjKa6q0DP8kqGFu2Knr1VE9/gZTr2sD3Xh3cAEZj6beR88Gd9sjM23yhUSvZ4wS
 0/E4sTEJCatL5aXMtNA==
X-Proofpoint-GUID: ZJRvnnuk_4VwuKVYYd3QmwXANoZA3NNG
X-Proofpoint-ORIG-GUID: ZJRvnnuk_4VwuKVYYd3QmwXANoZA3NNG
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a970c88 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Z8PlLslTYKWvlVeuNugA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NCBTYWx0ZWRfXwUYS7SoBhBy0
 IInB0ORNpB6OlTi0UD9+n9u3+j4VMBe6Pp9WXugGfUP4AsEOM6FxsQZAoqcP1da/cB42M2qUxbC
 Qf9rw0UMYc+DJGRrfj9/KcmnkUe/Ppc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010154
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpsMnZpY19zZXRfaXJxKCkg
Y2xlYXJzIGEgbGV2ZWwtdHJpZ2dlcmVkIHNvdXJjZSdzIHBlbmRpbmcgYml0IG9uCmRlLWFzc2Vy
dGlvbiwgc28gYSBzb3VyY2UgdGhhdCBkcm9wcyBiZWZvcmUgaXQgaXMgbGF0Y2hlZCBpbnRvCmlu
dF9zdGF0dXMgaXMgbm90IHNwdXJpb3VzbHkgcmUtZGVsaXZlcmVkIG9uIHRoZSBuZXh0IGNpYWQu
CkVkZ2UtdHJpZ2dlcmVkIHNvdXJjZXMgKGludF90eXBlIHNldCkga2VlcCB0aGUgcHVsc2Ugc2Vt
YW50aWNzIHRoZXkKYWxyZWFkeSBoYXZlIHZpYSBTT0ZUX0lOVC9zZXRfaXJxKGxldmVsPTEpLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGh3L2ludGMvaGV4LWwydmljLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaHcvaW50Yy9oZXgtbDJ2aWMuYyBiL2h3L2lu
dGMvaGV4LWwydmljLmMKaW5kZXggZjA3ZWM4NTBkNDkuLmE5ODZmMGJkZjM1IDEwMDY0NAotLS0g
YS9ody9pbnRjL2hleC1sMnZpYy5jCisrKyBiL2h3L2ludGMvaGV4LWwydmljLmMKQEAgLTI5OSw2
ICsyOTksOCBAQCBzdGF0aWMgdm9pZCBsMnZpY19zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGly
cSwgaW50IGxldmVsKQogCiAgICAgaWYgKGxldmVsKSB7CiAgICAgICAgIHNldF9iaXQzMihpcnEs
IHMtPmludF9wZW5kaW5nKTsKKyAgICB9IGVsc2UgaWYgKCF0ZXN0X2JpdDMyKGlycSwgcy0+aW50
X3R5cGUpKSB7CisgICAgICAgIGNsZWFyX2JpdDMyKGlycSwgcy0+aW50X3BlbmRpbmcpOwogICAg
IH0KICAgICBsMnZpY191cGRhdGUocywgaXJxKTsKIH0KLS0gCjIuMzQuMQoK

