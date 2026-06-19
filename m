Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB54ECD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifp-00041k-5F; Fri, 19 Jun 2026 19:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifk-0003y1-Sw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifj-0007Sw-4T
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXkod1286035
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=; b=S3I/ESAGtxaY0+ST
 kI5Ij4Zu8lmaITmH42yeJuz6aA615z29+HwXSCvPkyOptc1BVansZvBB0WPmomJj
 Qp9amZv1pFmBhxGH8kuq3auX5lIc1zcWXg8dgieY3djrVEDBs/PJBZclYbQbkR/Q
 v46qD6ovLujN7Z2XAihOtDbIchVtM2qPo1w7oj+BRCav8+fgW1s9zSumXEyJWeHX
 dbqrDDThW1zK6vJtyUCQLnwSGWIKBttFjRjLSMkOKChdrFNiH8RBwhWsfQeItCvg
 SFoRc0Jp0e0o5CmjaW79rL7+IM/Em3xojKSbnGVgo846cylG6ViP0mkRZxLgw7il
 Yfaijg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72kaa8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bccca5620so3405781eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911839; x=1782516639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=NqZ0XdpC8QS+PFU+XaAUYvL8JLWJArdBiVMFYbWRdJYL0ojkO8e7o4iqUHWPPDMel8
 0Kwn1RFXVIoMDTJvelYzLbYsRDfxwyLidXw6xECOFgO3a/98GmGLS3KSo5KnjulD/0Ju
 GuC67YjCt9ny+hBoSC3xHeVztP3P+tj5sUjL0wkUxbAIxdSOuJPm6uwi8fFBcgUoPX65
 Z8UBtD9IQEQdlDBQJo1QfIbyQL0EMcS4O6dvezmAFQaP/rbuH99nFc5Gbiptv0i0Nazy
 xpSWJbCA6Q6NG9ABJMUevtall1yMS3N95sg6Emfudw9pPFofRH/b2BAmj9tnaIOjCRt3
 z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911839; x=1782516639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=MqvL+0bM0Kbune/kbjEJJ+NrOIRPBM/JU846mNqF08X3BGxh1oc8Y6NY+w+zAn6wUv
 M6sU7n7hqI7JSjvIg3EhGCcxN04AOWeZN/MRQDQrD2nY+tMyO4VfQKEDvtD1hBMIHRdV
 qHGGuYwEfVU9S3z9Wc9jN1/9yuHjfE6EFEwQZ4rhkp8WiDmTaDXqxGRKwjbuI1n45cDK
 gcQCZ597vy4+ibJaUNxMhP2lk2jDU72lBh7NpAbX6rXcEKXuRlcYKdjN+Alq8J7etbs2
 7899APAKU5C98gmDzQlJfImrOX8jj2fusWatlInr4OMZcxAsy2OXPzyVJpygY9HscBr1
 QZKA==
X-Gm-Message-State: AOJu0YxKaoFiru1BOcDWQ0vRFTSa5jMYFNhbXHdFV0Dl0meLYM+WlzUU
 6qyu+rHZdcVMvr7XjzczCCQ2be/tsbBSJ68LoVtzGM1W4dzvw3daasP2IAUiMS+3laz/512gG1L
 zJ0tzFGpdLNZFPCd1eG//xpbRqKoB2Litqij/3ykIt7hChcpgI2qXKQ7PUr4se1Irdw==
X-Gm-Gg: AfdE7ck4rXymprO/2z/iCKTxEfR+dL4aT/gzwqNQ1uqSeypGalrW4eOQORNBjZTaKV6
 mtsoPi9FsbyDLHlJy7cZv+rDp9/Uzdl3Lz092SlDjT+7tnVblFxRhBGVEMHvJ8BdxiKHZ/O/LmZ
 Zs9NsWGWGFJ/rETw/w0e2AiMGNZsGdEY1WnrVeHNshuSOPKCqS+CzTDcDI82pdlVIX3X+YXepHy
 4/ZiaMAayMgmlsZV1i+M0NKqJqArB5QPCtoEh9+7K6DD5WxSy5mcJN1Gv7rI4f1kQzpGKeZ/HpR
 J9knuyMWTXwU+u/U//tHO60WnuluN7IBdfDO5+KswK9TGrA29ILDLcKtCE04pRdIgylSJMXkqb6
 hziH7fBiu+yDPnK1rwLOv6vRVA9H7BUxR+L9oJdKmC829KP1pGEHeDaF/jkY=
X-Received: by 2002:a05:7300:80ca:b0:2d8:7302:d3d with SMTP id
 5a478bee46e88-30c06e319fcmr3631459eec.8.1781911839012; 
 Fri, 19 Jun 2026 16:30:39 -0700 (PDT)
X-Received: by 2002:a05:7300:80ca:b0:2d8:7302:d3d with SMTP id
 5a478bee46e88-30c06e319fcmr3631438eec.8.1781911838518; 
 Fri, 19 Jun 2026 16:30:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 58/74] target/hexagon: Add implicit sysreg writes
Date: Fri, 19 Jun 2026 15:58:55 -0700
Message-Id: <20260619225911.159473-59-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX0f3rUVac0e6I
 PwqmDT8tlB6WLNLagIP5+N+1KEFo2VvzDtX7JOZpOkKy0hU+XqAE7LMKqEf3IgkiLQMED0Y7Pji
 rOCtiR4/CylR2mo74sW8wq7Xt3uoiCpDkYWz92aw+KaaZRIRoZ+BxYbn2vRMsUkPfDdjWH3OW0A
 Gfyk+/hKBaUDQbhWHRwP6VXyHjSI01N5IGsUsttiQE4rn2NHQrbjlhGe45kg+0tEbgY8z0Y687m
 UFt1TKmjDha4xmbWws7qJvcGpzXq84232Ike8asOqvTB96QfcEMtgvxkr4HJsSdsBgALmL5M6oD
 XJZ0s914ZqF134MpqsgG4dWMBE9IG7CvSOuXXLr5t3vyDwtHlkN42tJx+RTEDcPJuTNpQwF0FNr
 9lJqHGyEr+peTulGuCBB6agX4Gz6aF3x/yFA0qDH1QrjxH0C8Fn/GqjwULvMmoTTJkVpr4/rLyt
 QyYwCX2xzeWR+1enM+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXwdUXtIn0SNbF
 zAo06EFusy+QUsZxMQSxwT2ZzNaVmMeNBF0P+SxS5B67+JXkcWgyF0LscNeoUTw5rBJHGHXWu3c
 +3bB9p74EJ4Tb4Rut63EBd7M9HINBRQ=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35d11f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: FrfM72GMHPQlWcblDYtCHDFriemkhb27
X-Proofpoint-GUID: FrfM72GMHPQlWcblDYtCHDFriemkhb27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0YTM1Mzk1OGZmLi5mNTQ1MGNlZDdkZSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNCw2ICs0MjQsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDM2LDYgKzQ0NiwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

