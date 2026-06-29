Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F270FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnO-0004Qj-N7; Mon, 29 Jun 2026 09:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnN-0004QW-04
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnL-0003Ba-Bx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT6pc2618925
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=; b=h8dakk3EmqtrWXx8
 c+SgZmJpqcYfYtHZU3QqPB5chJvs1R44CdlURKlI663bPALOR0N6tGkno1Gag5TE
 TC57nBkAlKoBSmda3mRYi/nfIHXp4fUFUjunFq+iTtpIczXNJTwa7c8dkq1xVuv/
 n2Q93BvQJQneaulheU6Mzp1eSenGdX/w+j/RfDknOpHJUrVX98aXBaRv36la9//X
 Hh5HczAgc4NtApr9uQUNXqQVnE4TgXhFSzNVV6gpvlnR80VBUv+lGdcM8wMtP6uq
 sDRa4MAuQhpsqQjxq3YuvHpBLDV+/iqeUqKM9OS0jm11ozGjVmeFJ5tZi87iFNNJ
 FLY/Kg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrr3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:02 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139fe708181so2255325c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738781; x=1783343581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=Mi/Wbd5FttSkzJwwHavSmCxfI9u5mOXoBG/K+Of6HAGeXiDZPDZFm3J/T1g1odfCj2
 kezDXTcR9DOozy+JI00yqIZFEfqTBwiqiQArSm8ogCXbMvqLU+2Nn3dz7KSyLC7hrxcN
 ff2BJvA1IAymmzFWOSAILKx7AEUPWccq83rghHGdBv7nvgQ0hepXTAEFnac/PWbm4rNl
 V9l8y2YIRMSMecZoI9JYJ4aUoQrTirKZ2TrGOsJ2ySIyLv/hIQAhljcLezuHDg46kXIy
 /eaGnARNWhp0xXlEZEwIuy3ChD7ZNZWPfA8R6pe3vAxpoSaWLdo1KRmouwPvgX/SSrIc
 Ky2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738781; x=1783343581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=O04IXIBAj6X/n2Sf2N++xgZJSBlQFuCKV/DTCrgDthsQbFECIyft7E5o0D8B9HwTzz
 ac3Nmv2WVKPEcZ1nHrzmmWta2nJi9HegWDpWJuERh+JlKzVRtVq4GdPHv59OJQ9kgN5d
 +ReKyBJ0HaZTLrEX5dZ806LCT6jss/BMVUxDmt127kVoBnegLAPiKU/+B4xaYovSeqgO
 KzwV9q7HlOQGA491+aILzfwcKvdKLsNWGeXAGlXkLzs/Rp/aU1/CZLwAyanrydJnTcsA
 cSiOZ5AWBv2R8Z5trDPe0IYgFAva5FwNvp64/MccSbci8kWP48B7Qtsp3SPZPyFncQy5
 RINw==
X-Gm-Message-State: AOJu0YzGtZum+0aHxsyyNMIV49Tirr0pS8XbUYcD7aJrL+ZTbHa/QPLw
 s7f69gNMjrxWQzQj6TQ+vfXfpG5EphSWUiaCKKo/Luvi0kMXY/Vqdz3ahn6Xt7kf3b1zLSb/zhv
 eME8W+MTsQXWK9xPupR0uufvMo1C76i85abZbkb5JZkHyKz+njGIE479Sas78be4Alw==
X-Gm-Gg: AfdE7clNxItFmm2fcBlyLOH5RImmnu68P+jQjrFUw2qqoI70GmE2PB4gq//lTuH0ua7
 /mLVUiKVUyem63GER8LiKbTKtB9bmPkk3mBcZQshGttbs0C7J7gwojKm7TMFcTQ7h/lxoXgMVbS
 5KWGsCA4thvV3rRsDXG5UmWHE47mvjyRQcyjlqFGH8XU0f9hI3cxBNAC6FLOHcVwZWOULbgXB7b
 feDuzEOqg6kfBmTltGSIpyBIQTzstEBYvWBvV2GvLdLSDrV0TrCz40WVAYIKVz4tv8/2n77NFMb
 X+PpE84HPUd/3hwt6NNGxf+zr/rS9ilLf1ysotkX9+jh14Zlj57vn/vCu906ibUad9aa4ennm1s
 n5fxtbafJbddpRrDxbmLmFeE0cvlScp/e7LnJu6QzunZVRBj+DO0s4xUZ2GU=
X-Received: by 2002:a05:7022:6885:b0:138:177c:b971 with SMTP id
 a92af1059eb24-139dbab88fdmr13025946c88.29.1782738781397; 
 Mon, 29 Jun 2026 06:13:01 -0700 (PDT)
X-Received: by 2002:a05:7022:6885:b0:138:177c:b971 with SMTP id
 a92af1059eb24-139dbab88fdmr13025925c88.29.1782738780868; 
 Mon, 29 Jun 2026 06:13:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 14/77] target/hexagon: Add guest, system reg number defs
Date: Mon, 29 Jun 2026 06:11:29 -0700
Message-Id: <20260629131232.2487780-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a426f5e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bkeoO_PjjHb74JHBc7JTK62RAzlv8ame
X-Proofpoint-ORIG-GUID: bkeoO_PjjHb74JHBc7JTK62RAzlv8ame
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX2rfsv+igq9EV
 xdLAftn13jWhhJ5yU9NDGv9rqjsOfT7ClKuGDg8pfP8cDzow5sotOE7DxB8Zb7MgoNHqUx5Q6od
 9Tfpqzw2eVn8J4g0SUMm0N4Jk40te6NSl1dLFsPMwlgliAnzN2ZqElHXrL+87FagCizymuknXwK
 AFAprvGK0AeOJ6OD4d60ZqEowwstxEJ7LEldk1+HCegUOy+EcPSz4MQA5dwBaI7Iq8EEXnJSjQA
 Iwej9UOiJEpVV2RJlTB/rihCbrnrOfIT1nss/8al3vQT4X0MNWVtO9KPmGwm0ZnDoNAWatBA486
 GCGqQDHxqCEvCXCR6PIl0XldvPFyQZO7iBrk0outUZ+GMBCou7kr5+r7TBcgRAjQOQNCEMkq+Yh
 /DzYHookFaW+/hkw3GHRO1zfqtPlvr8ffg8tJFUVLfY9ZrT7PAOXHOs1bB4rxUrOHbecnm6Kv/+
 LesXsBtFw5hrYkA83ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXxtCFb+wjlI0h
 D/f8dn7CnLDOQSwJB7Yx2p4Cpy+f1hvYrqywIyxNqx7kZOkKmjNiZZaudUkTzUoj3ASirA26Xkq
 KRMgMmgWbeDp8t/AWzDiOa2w3LSo5eg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgfCAgIDcgKysrCiB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oIHwgMTE3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQv
aGV4YWdvbi9jcHUuaAppbmRleCBlMjI1NjdkOGU2Ny4uZTBjZjg3ZTVhNGMgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMCw2
ICsyMCwxMyBAQAogCiAjaW5jbHVkZSAiZnB1L3NvZnRmbG9hdC10eXBlcy5oIgogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgTlVNX0dSRUdTIDMyCisjZGVmaW5lIEdSRUdfV1JJ
VEVTX01BWCAyCisjZGVmaW5lIE5VTV9TUkVHUyA2NAorI2RlZmluZSBTUkVHX1dSSVRFU19NQVgg
MgorI2VuZGlmCisKICNpbmNsdWRlICJjcHUtcW9tLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtY29t
bW9uLmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKaW5kZXggYmRk
ZmMyODAyMWMuLjIxNGI3YjhmZGU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVn
cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTgxLDQgKzgxLDEyMSBAQCBl
bnVtIHsKICAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMsCiB9OwogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKworI2RlZmluZSBIRVhfR1JFR19WQUxVRVMgXAorICBERUNMX0hF
WF9HUkVHKEcwLCAgICAgICAgIDApIFwKKyAgREVDTF9IRVhfR1JFRyhHRUxSLCAgICAgICAwKSBc
CisgIERFQ0xfSEVYX0dSRUcoRzEsICAgICAgICAgMSkgXAorICBERUNMX0hFWF9HUkVHKEdTUiwg
ICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHMiwgICAgICAgICAyKSBcCisgIERFQ0xfSEVY
X0dSRUcoR09TUCwgICAgICAgMikgXAorICBERUNMX0hFWF9HUkVHKEczLCAgICAgICAgIDMpIFwK
KyAgREVDTF9IRVhfR1JFRyhHQkFEVkEsICAgICAzKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xF
XzFULCAgMTApIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfMlQsICAxMSkgXAorICBERUNMX0hF
WF9HUkVHKEdDWUNMRV8zVCwgIDEyKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzRULCAgMTMp
IFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfNVQsICAxNCkgXAorICBERUNMX0hFWF9HUkVHKEdD
WUNMRV82VCwgIDE1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDQsICAgMTYpIFwKKyAgREVD
TF9IRVhfR1JFRyhHUE1VQ05UNSwgICAxNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ2LCAg
IDE4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDcsICAgMTkpIFwKKyAgREVDTF9IRVhfR1JF
RyhHUENZQ0xFTE8sICAyNCkgXAorICBERUNMX0hFWF9HUkVHKEdQQ1lDTEVISSwgIDI1KSBcCisg
IERFQ0xfSEVYX0dSRUcoR1BNVUNOVDAsICAgMjYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05U
MSwgICAyNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQyLCAgIDI4KSBcCisgIERFQ0xfSEVY
X0dSRUcoR1BNVUNOVDMsICAgMjkpIFwKKyAgREVDTF9IRVhfR1JFR19ET05FCisKKyNkZWZpbmUg
REVDTF9IRVhfR1JFR19ET05FCisjZGVmaW5lIERFQ0xfSEVYX0dSRUcobmFtZSwgdmFsKSBIRVhf
R1JFR18gIyNuYW1lID0gdmFsLAorZW51bSBoZXhfZ3JlZyB7CisgICAgSEVYX0dSRUdfVkFMVUVT
Cit9OworI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKwor
I2RlZmluZSBERUNMX0hFWF9HUkVHX0RPTkUgMAorI2RlZmluZSBERUNMX0hFWF9HUkVHKF8sIHZh
bCkgKDEgPDwgdmFsKSB8CitzdGF0aWMgaW5saW5lIGJvb2wgZ3JlZ19pbXBsZW1lbnRlZChlbnVt
IGhleF9ncmVnIGdyZWcpCit7CisjaWYgTlVNX0dSRUdTID4gMzIKKyNlcnJvciAiTlVNX0dSRUdT
IHRvbyBsYXJnZSBmb3IgZ3JlZ19pbXBsZW1lbnRlZCgpOiB1cGRhdGUgYGltcGxfYml0bWFwYCIK
KyNlbmRpZgorICAgIHN0YXRpYyBpbnQzMl90IGltcGxfYml0bWFwID0gSEVYX0dSRUdfVkFMVUVT
OworICAgIHJldHVybiBpbXBsX2JpdG1hcCAmICgxIDw8IGdyZWcpOworfQorI3VuZGVmIERFQ0xf
SEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2VuZGlmIC8qIENPTkZJR19V
U0VSX09OTFkgKi8KKworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitlbnVtIHsKKyAgICBIRVhf
U1JFR19TR1AwID0gMCwKKyAgICBIRVhfU1JFR19TR1AxID0gMSwKKyAgICBIRVhfU1JFR19TVElE
ID0gMiwKKyAgICBIRVhfU1JFR19FTFIgPSAzLAorICAgIEhFWF9TUkVHX0JBRFZBMCA9IDQsCisg
ICAgSEVYX1NSRUdfQkFEVkExID0gNSwKKyAgICBIRVhfU1JFR19TU1IgPSA2LAorICAgIEhFWF9T
UkVHX0NDUiA9IDcsCisgICAgSEVYX1NSRUdfSFRJRCA9IDgsCisgICAgSEVYX1NSRUdfQkFEVkEg
PSA5LAorICAgIEhFWF9TUkVHX0lNQVNLID0gMTAsCisgICAgSEVYX1NSRUdfR0VWQiAgPSAxMSwK
KyAgICBIRVhfU1JFR19HTEJfU1RBUlQgPSAxNiwKKyAgICBIRVhfU1JFR19FVkIgPSAxNiwKKyAg
ICBIRVhfU1JFR19NT0RFQ1RMID0gMTcsCisgICAgSEVYX1NSRUdfU1lTQ0ZHID0gMTgsCisgICAg
SEVYX1NSRUdfSVBFTkRBRCA9IDIwLAorICAgIEhFWF9TUkVHX1ZJRCA9IDIxLAorICAgIEhFWF9T
UkVHX1ZJRDEgPSAyMiwKKyAgICBIRVhfU1JFR19CRVNUV0FJVCA9IDIzLAorICAgIEhFWF9TUkVH
X0lFTCA9IDI0LAorICAgIEhFWF9TUkVHX1NDSEVEQ0ZHID0gMjUsCisgICAgSEVYX1NSRUdfSUFI
TCA9IDI2LAorICAgIEhFWF9TUkVHX0NGR0JBU0UgPSAyNywKKyAgICBIRVhfU1JFR19ESUFHID0g
MjgsCisgICAgSEVYX1NSRUdfUkVWID0gMjksCisgICAgSEVYX1NSRUdfUENZQ0xFTE8gPSAzMCwK
KyAgICBIRVhfU1JFR19QQ1lDTEVISSA9IDMxLAorICAgIEhFWF9TUkVHX0lTREJTVCA9IDMyLAor
ICAgIEhFWF9TUkVHX0lTREJDRkcwID0gMzMsCisgICAgSEVYX1NSRUdfSVNEQkNGRzEgPSAzNCwK
KyAgICBIRVhfU1JFR19MSVZFTE9DSyA9IDM1LAorICAgIEhFWF9TUkVHX0JSS1BUUEMwID0gMzYs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcwID0gMzcsCisgICAgSEVYX1NSRUdfQlJLUFRQQzEgPSAz
OCwKKyAgICBIRVhfU1JFR19CUktQVENGRzEgPSAzOSwKKyAgICBIRVhfU1JFR19JU0RCTUJYSU4g
PSA0MCwKKyAgICBIRVhfU1JFR19JU0RCTUJYT1VUID0gNDEsCisgICAgSEVYX1NSRUdfSVNEQkVO
ID0gNDIsCisgICAgSEVYX1NSRUdfSVNEQkdQUiA9IDQzLAorICAgIEhFWF9TUkVHX1BNVUNOVDQg
PSA0NCwKKyAgICBIRVhfU1JFR19QTVVDTlQ1ID0gNDUsCisgICAgSEVYX1NSRUdfUE1VQ05UNiA9
IDQ2LAorICAgIEhFWF9TUkVHX1BNVUNOVDcgPSA0NywKKyAgICBIRVhfU1JFR19QTVVDTlQwID0g
NDgsCisgICAgSEVYX1NSRUdfUE1VQ05UMSA9IDQ5LAorICAgIEhFWF9TUkVHX1BNVUNOVDIgPSA1
MCwKKyAgICBIRVhfU1JFR19QTVVDTlQzID0gNTEsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHID0g
NTIsCisgICAgSEVYX1NSRUdfUE1VU1RJRDAgPSA1MywKKyAgICBIRVhfU1JFR19QTVVFVlRDRkcx
ID0gNTQsCisgICAgSEVYX1NSRUdfUE1VU1RJRDEgPSA1NSwKKyAgICBIRVhfU1JFR19USU1FUkxP
ID0gNTYsCisgICAgSEVYX1NSRUdfVElNRVJISSA9IDU3LAorICAgIEhFWF9TUkVHX1BNVUNGRyA9
IDU4LAorICAgIEhFWF9TUkVHX1M1OSA9IDU5LAorICAgIEhFWF9TUkVHX1M2MCA9IDYwLAorICAg
IEhFWF9TUkVHX1M2MSA9IDYxLAorICAgIEhFWF9TUkVHX1M2MiA9IDYyLAorICAgIEhFWF9TUkVH
X1M2MyA9IDYzLAorfTsKKyNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLworCiAjZW5kaWYK
LS0gCjIuMzQuMQoK

