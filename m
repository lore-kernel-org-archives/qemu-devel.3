Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE20C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4gnA-0002cL-Pb; Thu, 10 Sep 2026 11:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4glX-0002IH-7i
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4glV-0005Le-HT
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:32:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4KCt1326239
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t/U2rmJlSQq+34BnwP7+1w4Q5mYzyCo4GCEEfKITLIc=; b=Tn9O1ByubEtATusL
 Kkxp0T7x+94ocneZWwiB+JHGGv73n1bdE3PZ5bcNyEEoaXNG+5SmLqUXGGmTcAVE
 i+ivh8qnPEQ9RtU+ZzU27Y9vRUnzaq23VLAQpAsigkCfv++cmiDMH41UIQQLVXRm
 awvOaB2kqSeEtM/72yf9NMWRkBnRd613B3pcAeWnRTU2TbqCQN/lg/F5nQ8IHUej
 PpPqeqylPDg98kg7sgQrSwy0vClbsi9kUdGVRu4N/JiYFLVZYyXPHAci7moEdeM7
 9xFEOF6Dr/RvqyKdkvYhJ37L+LBAVtwJcWrbTyYZvlvGtbGjjt+Y497jLiYoKV64
 T6dAPg==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwts0js8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:32:40 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-448d51840c4so6522891fac.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789054359; x=1789659159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t/U2rmJlSQq+34BnwP7+1w4Q5mYzyCo4GCEEfKITLIc=;
 b=VjdYe6eqbcgg/MSKZfOICyvvyI0eJvDMmwflqNhapdAZW+whRKhojINH7QFBfQbgv/
 1gRTi4HIPzXS/adlzdUwKwN4Vvqvr9ODuOCqH/+Qtat/DaNxAcvKmZrDHfOgG0JHPxc4
 WyXoSB8LYIKn5U1TX9awXFy3zdss8bsNelvCNj1wNXGAQDVCJCNEuLC/Umu7V4SfiKW/
 CpTnzT+/7TdcGLPUNrVm+KPJlKPBt0SvQW/GmUslAu7Fg+PsHQ2WFa8NMrBalcmM9CTp
 BXnYqpxttbioakoizbIn5UdXFS8c5qvwJkD4Z+Dk1h46Iz1Y+lkIiOl+MTkd253nAqm+
 jidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054359; x=1789659159;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t/U2rmJlSQq+34BnwP7+1w4Q5mYzyCo4GCEEfKITLIc=;
 b=a44xpK9XGwUBK4TMcCPebCk+5u8Sre4UtQbKx/UwZRXOZm5PHpqc7tOGlawFnHbPAE
 BE0R0j9PNxyF4Qot6+krC0Z/0w266oY7CuSFUhoIm9yxwobwCIZe4KOCxIPsNaDIrAh8
 PiGoS+SuDLDtV5XL6E+JxF+L2/i1/iuS0pndhkz8IuoBR2f0d3tOsK2bAbJEsfU7U16z
 1jFWAwCSprXDkyIqgsE+Y9rzba4IEmay0HKcYsB4iRqA15t+5tfhEKDdJWH3NbdLGteA
 ZXM94oaPRzedu0FFcuxLH4DtAu5L/xV0/OZwGrxQoFqCjQgPX661mbVmTK9lERr6XS7+
 yHPw==
X-Gm-Message-State: AFuF++m3xAW05CVSEacB5wqE0LRNJpnYearwZO2iSQAZ+Y2p/xb1RzYv
 EBn3gexzy9tNr/eW64aq04PWX416GljqgB4oVHlbWb1JVmw9Uvs7Sk67BUJ3gDPLkETIum2FBYs
 UXYBapxLUFqGVKX0D1iVPKqrI04l9BkuIOunzfW+9rdpKYvWkVo5pbV4tP5x03SuFbQ==
X-Gm-Gg: AYBFou2odRw1iG6L3rzEM9US2nuO60V9tWT6sIwkqEn1HrJT4exdFQqrZt2+kXQ9oMx
 hhV/WOmjssWmBRJoKBnXR0QTgc5Eh0xjQLUsJDLAUcFKqlK/E9aNmfx/qQkO3Sa65HSZ0k7ZZHO
 MXczZN+GqU4xtLoPRM5+nuuFuF8Zbh2ZR0vStGHsMEbI9frSjz2HIhMqZk8PdneQLOnVj1iz6E4
 /Sw1hYexAUpLMBQQFFnRVEdEtk3QYiLj+VzNP7+f41AQDrPmTa2cfs6YADMgL00uqQ8DhwwctjO
 8EIj2qOS/wj8nd91OrddIZcIGayWuCwUIel54t24i6dd+ivjmu/H35HvSY0FWEfyJq2EEXFJanK
 VwfJVH75DfLRn/sRsgtrjwyY82Agt2FXYDQqvV40qf8y9Ygyc
X-Received: by 2002:a05:6870:8a0f:b0:475:e0a7:9f2f with SMTP id
 586e51a60fabf-475e0a7aa39mr25457363fac.29.1789054359285; 
 Thu, 10 Sep 2026 08:32:39 -0700 (PDT)
X-Received: by 2002:a05:6870:8a0f:b0:475:e0a7:9f2f with SMTP id
 586e51a60fabf-475e0a7aa39mr25457322fac.29.1789054358824; 
 Thu, 10 Sep 2026 08:32:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm19563727fac.6.2026.09.10.08.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:32:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 4/9] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Thu, 10 Sep 2026 08:32:16 -0700
Message-Id: <20260910153221.1674285-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=PIaaavqC c=1 sm=1 tr=0 ts=6aa2cd98 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-GUID: hQDEH40hijQ7pNcL0VKJWqUeSQjE5Ok9
X-Proofpoint-ORIG-GUID: hQDEH40hijQ7pNcL0VKJWqUeSQjE5Ok9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfXyybCo+DWZjdB
 V8kc7+54KI1z1qrgFrmNBxRk3mU55Z32GBF7Rjt3LZZWRS2438nxgYX4vMbFeuYqWWZAsMcKKGW
 YShTCCoH4LhjzLWxrPBvt154x6mrZuE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE4NyBTYWx0ZWRfX6CxFcW3Mor0j
 OQQKfbM1ZXfmV5ryZ9R9zb9aTieRJB1zYSm9x81Dz1ibpxrdTUdOrY3gS5xKPmGJVROvqmYM96i
 nchJNfM+zWTGOCR1agTVEi9XJjJrNQvclKxQtn4RqDN+Q9nbE74kESEqRaiAlb7O3I2ky/Q57df
 ToEcfD/hoYouT0014DHrdvNxYtOTrQxr06BXT9p0Al6skIVqYCj6v/m27vcvDjuHMvrzpioVK7g
 ZLmtAqIMFFASj5rvgJ5NBkw5HFxgedvA1TQtr6ZaqjYFwQLMgQ4DfcpnKWGNffoAwbGIbnc2eTc
 cWTXe1TSF41CYPYI5YG4RAdSu+tZplGYmGEoDKWDkRIF3GEkjWYbxHahpkZvtsVvcHh/FZC19sa
 cANRE7LQrQtnbuWceL4rr0JDdzL3sIfR/uCWoOPdGrl6mvveuTszQSDSIbA8bjZF4EKjEBKQMpz
 htIHorxlS7256G8uX8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100187
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

U1NSOlhFIGdhdGVzIGFjY2VzcyB0byB0aGUgSFZYIGNvcHJvY2Vzc29yOiBleGVjdXRpbmcgYW4g
SFZYIGluc3RydWN0aW9uCndoaWxlIGl0IGlzIGNsZWFyIG11c3QgcmFpc2UgYSBwcmVjaXNlIGV4
Y2VwdGlvbiB3aXRoIGNhdXNlIDB4MTYsCk5PX0NPUFJPQ19FTkFCTEUuCgpDYXJyeSBTU1I6WEUg
aW4gYSBUQiBmbGFnIGFuZCBlbWl0IHRoZSBleGNlcHRpb24gZm9yIHRoZQpmaXJzdCBIVlggcGFj
a2V0IG9mIGEgVEIgd2hlbiB0aGUgY29wcm9jZXNzb3IgaXMgZGlzYWJsZWQuCgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vY3B1LmggICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCB8
ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyB8IDExICsrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhh
Z29uL2NwdS5oCmluZGV4IDhhNGE4MWRjMjZjLi4zMmNkY2ZlODUyOSAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTIwNyw2ICsy
MDcsNyBAQCBzdHJ1Y3QgQXJjaENQVSB7CiBGSUVMRChUQl9GTEFHUywgSVNfVElHSFRfTE9PUCwg
MCwgMSkKIEZJRUxEKFRCX0ZMQUdTLCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChUQl9GTEFHUywg
UENZQ0xFX0VOQUJMRUQsIDQsIDEpCitGSUVMRChUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVE
LCA1LCAxKQogCiBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQ
VUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IGQ4NjI4MzgzZjFk
Li5iODdhMmIyMGUyZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTg5LDYgKzg5LDggQEAgdHlwZWRlZiBz
dHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBUQ0d2IGJyYW5jaF90YWtlbjsKICAgICBUQ0d2IGRj
emVyb19hZGRyOwogICAgIGJvb2wgcGN5Y2xlX2VuYWJsZWQ7CisgICAgYm9vbCBodnhfY29wcm9j
X2VuYWJsZWQ7CisgICAgYm9vbCBodnhfY2hlY2tfZW1pdHRlZDsKICAgICB1aW50MzJfdCBudW1f
Y3ljbGVzOwogfSBEaXNhc0NvbnRleHQ7CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNGE3Yjc2ZTNiY2MuLjExMDlhOGQ5MTRj
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9j
cHUuYwpAQCAtMzMxLDYgKzMzMSw4IEBAIHN0YXRpYyBUQ0dUQkNQVVN0YXRlIGhleGFnb25fZ2V0
X3RiX2NwdV9zdGF0ZShDUFVTdGF0ZSAqY3MpCiAgICAgaGV4X2ZsYWdzID0gRklFTERfRFAzMiho
ZXhfZmxhZ3MsIFRCX0ZMQUdTLCBNTVVfSU5ERVgsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjcHVfbW11X2luZGV4KGVudl9jcHUoZW52KSwgZmFsc2UpKTsKICAgICBoZXhfZmxhZ3MgPSBG
SUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVELCAxKTsKKyAgICBo
ZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5B
QkxFRCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIEdFVF9TU1JfRklFTEQoU1NSX1hFLCBl
bnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdKSk7CiAjZWxzZQogICAgIGhleF9mbGFncyA9IEZJRUxE
X0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLCBNTVVfVVNFUl9JRFgpOwogI2Vu
ZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5jCmluZGV4IDVkM2Q2N2U1ZDNlLi5iNDRjZjQ4ZDc1NyAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNs
YXRlLmMKQEAgLTcxOCw2ICs3MTgsMTQgQEAgc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChE
aXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgICAgIGkgPSBmaW5kX25leHRfYml0KGN0eC0+cHJl
ZGljYXRlZF90bXBfdnJlZ3MsIE5VTV9WUkVHUywgaSArIDEpOwogICAgICAgICB9CiAgICAgfQor
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBpZiAoY3R4LT5wa3QucGt0X2hhc19odngg
JiYgIWN0eC0+aHZ4X2NvcHJvY19lbmFibGVkICYmCisgICAgICAgICFjdHgtPmh2eF9jaGVja19l
bWl0dGVkKSB7CisgICAgICAgIGdlbl9wcmVjaXNlX2V4Y2VwdGlvbihIRVhfQ0FVU0VfTk9fQ09Q
Uk9DX0VOQUJMRSwgY3R4LT5wa3QucGMpOworICAgICAgICBjdHgtPmh2eF9jaGVja19lbWl0dGVk
ID0gdHJ1ZTsKKyAgICB9CisjZW5kaWYKIH0KIAogYm9vbCBpc19nYXRoZXJfc3RvcmVfaW5zbihE
aXNhc0NvbnRleHQgKmN0eCkKQEAgLTEyMzUsNiArMTI0Myw5IEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fdHJfaW5pdF9kaXNhc19jb250ZXh0KERpc2FzQ29udGV4dEJhc2UgKmRjYmFzZSwKICNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+bnVtX2N5Y2xlcyA9IDA7CiAgICAgY3R4LT5w
Y3ljbGVfZW5hYmxlZCA9IEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgUENZQ0xFX0VO
QUJMRUQpOworICAgIGN0eC0+aHZ4X2NvcHJvY19lbmFibGVkID0KKyAgICAgICAgRklFTERfRVgz
MihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VOQUJMRUQpOworICAgIGN0eC0+aHZ4
X2NoZWNrX2VtaXR0ZWQgPSBmYWxzZTsKICNlbmRpZgogfQogCi0tIAoyLjM0LjEKCg==

