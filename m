Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF787CDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifq-00044N-Nv; Fri, 19 Jun 2026 19:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifl-0003yL-NG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifj-0007V7-Qb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXskg1663659
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=WuFcXxSP9Fzp6C31qhgOnqeUQp9/ystWflMVHLK8WCY=; b=nx
 bZ05we7a81bP/IBmzSoDq7x6lQ7zKL4yxr3zE6K7TwTpoZivd+pyYiaT6ixzWpR4
 mr3numkFEPaZCVdWWQ+qenNiVel8PoXLsydvAV8Jh4AmRAFHkel91dtkNPcUL+/m
 LBXTfbFT7m9ZAiuIrfKN2S30hYeCNZQvVzziaq6Kd+4fC9kFVzTGpNHWkP1ndTc8
 H/t69Mon7FOclHF2OBxiRttAhiv6CwPmN9kDYTpJfLv4/51b3y72BC6AS+eXGrAM
 6X0Ds6q7qhPQrcmrdhyb0+v09erQ2lMKWJs5+RxhXM63DdaTGn9fV+8GzVXer+5h
 UfaqwsigNDwGEo4c1nOA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sdbte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30beab99453so4077048eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911850; x=1782516650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuFcXxSP9Fzp6C31qhgOnqeUQp9/ystWflMVHLK8WCY=;
 b=U8fm0Y/rvhVmM5mvor2hsoEDAlpRHGl4e/AWO4bzXm5lfxfvqsqK9iONlyrLpCgexf
 v5aocAg/cIcKn0XmU+Www+EccrC/ad3XaUGp1HN9ihDCLHUxxWTz41/uzxwg/XFWQrLW
 jWwhKjLNjjDVcK8h8LxcOT441P9D5KOXje348WadcpPnRnZv2NNkw79ei1W311kJY5O+
 EFKhgUknTPq+JyQlELCwXhYsjO9Gm7GjuDZNtpwuEPxKdFEV9HnwYxBu79dxeiagLkeH
 gP/3eIRzC6pTdcE+PoA8BruvXn6gf1lWef/aPh6BLO/mY+gRughfORh6HCLhbsVDoPau
 +fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911850; x=1782516650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WuFcXxSP9Fzp6C31qhgOnqeUQp9/ystWflMVHLK8WCY=;
 b=gCLDtWTTdCXyuqWRt+1ubVsrb1K8FDclKkwOg2W5DtjvLaNzuvziIuX+YWDGvoJujm
 3eDLjtbfkocqE7VlUNtVORcIQo7Hn7BcTyAjZas9VCvn20WWTy8tFdWw8fgW8Qw+cPdw
 Q4O2gYLkaTg2P+OeiwzecQwT28WyXd2uCWhmxbqqNS5Z2Y7gToqVvuGrSh0WYXU0eR5v
 f3BmpyESrpe11NJs/2/hkyzK7Kl9JAGVJgbipk1Bm86tlGGTebvVY1Smr06kRaqhi5DE
 AFGUCPnpR3Uvd0JwAjvpmbwLcCYgq07T4XsvcGRzMiZqYAMvVO+mVakgBi3Wlw964Yfg
 jhuQ==
X-Gm-Message-State: AOJu0Yw7qIyhlXMqF7I2ZT0LP8mzeBs67rHlnYD5Ti9TbL2oWOgPnMPL
 9vug0p8llxSJ5mrkp57VFHiqc1JaScVCf0vlPBXqO0sx/FbVf+LjjPq8dzbJIDPj8Lpa+h3XXQ9
 7SffCRNWxWy5iaW5E3v7pIzt+JoHSu0Wt6fpfrZeC+t55bAtO80ORHVLdKJhlkP3PlQ==
X-Gm-Gg: AfdE7cnjtDHYcWUDQ8dvxMGytqR+QvwSuRy78zL3H2RAwwcm0WqHWJLyK4u84NeoLOS
 SBGlQVD85kn7Nh99DeDy/2TbAN1uuE4TZ8AKpa/50bHLPdFbZEfKQiLxEBpgiFF2CMmX2vrSfcl
 eVxAgqWyKXDpj/0zJ/HiRPWk0JtUR1o9LwcUxhLtcGbtQGIGRShPZNcN9qbOhAxTvb0ufi3NG3+
 AYeQ1tijp6A2A/at5OwysXGvgmtpy+SAz680M0SxzGYxc7LEruEAAYvR8tmB2dNPsWNXH2qVrqZ
 lSG16Jce7Xdf4HyUbah4TSVvZokrcptSQOu2rD1W4mEZODGXR3qQG5C+SOkNzUnJ1YYIxvPafjp
 KlteVnP08qK3elyPavM8w3j+awceFrm6C5/Jhdkq+WrdBO2RWVxhfIgzV49Y=
X-Received: by 2002:a05:7301:1f12:b0:30b:6191:7f96 with SMTP id
 5a478bee46e88-30c071933a8mr3085425eec.30.1781911849627; 
 Fri, 19 Jun 2026 16:30:49 -0700 (PDT)
X-Received: by 2002:a05:7301:1f12:b0:30b:6191:7f96 with SMTP id
 5a478bee46e88-30c071933a8mr3085415eec.30.1781911849122; 
 Fri, 19 Jun 2026 16:30:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 66/74] hw/hexagon: Add global register tracing
Date: Fri, 19 Jun 2026 15:59:03 -0700
Message-Id: <20260619225911.159473-67-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UzV-AblA7s8kULsvXaTcbe1RKRHEEUsF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX6SZH8/4Dz2B9
 4fqlLDdP4WIO3tfQSKX62lWZLJ0W2Ju2YsW/t9HxzfqYhJfDH1wUuE/bbA0R7RWXWvOJJcYyHzp
 92XFGLhLArBMa5ZT2JwrXykHhrEh11oFvWM5Nawhxcq4jmlJMmWPiiaIexM7vERCoFw50DYqeZR
 MSbP3qiAwAcce2889Gw6ChKAsOEJQN2GFqQa6KkeYeJPbZToG5AXlAkoIcBZpBESpBAJJVROaur
 9VK7e8xbTsaS4doLILlbneNe1eHQlSjfLa+JunZ51WbMkncjNNAlxXC8KBVI43YB8AAlt+lYMq/
 ENzofnxJ2t9kmWBMejwrvs/fQJUMD2xB/IL2Npv0rRoIRKXdCL1Cym4BDlzm7E5NSznsJpHNU66
 sudhYcwbYUUdbm4X8uVD7U9JRmt8gDsSTNVti8j0nKO4eY5lMSMhsqmFC6Au6SLTD7wBNMs0Sgq
 dQEQjmeA79CaCS96oXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX5Xp0m6hgQbMP
 bUdUq6vrjVN1g9S50wCisrSZDdETtWFFL3PKu1AO/7bvVvGiRtqiXzyGMQa04ZGgNJt8NDJEkob
 9dYtzQvWsjroqlsWFcMIMuMz+JVBxYQ=
X-Proofpoint-ORIG-GUID: UzV-AblA7s8kULsvXaTcbe1RKRHEEUsF
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a35d12a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8QmChvNvioVktlEtA_0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAxICsKIGh3L2hleGFnb24vdHJh
Y2UuaCAgICAgICAgICAgICB8ICAyICsKIGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyB8
IDczICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vdHJhY2Ut
ZXZlbnRzICAgICAgICB8ICAzICsrCiA0IGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3RyYWNlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9oZXhhZ29uL3RyYWNlLWV2ZW50cwoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVz
b24uYnVpbGQKaW5kZXggZTAyNjg1MTMwOWUuLmQ0MjA2YTVkM2Y4IDEwMDY0NAotLS0gYS9tZXNv
bi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtMzU5OSw2ICszNTk5LDcgQEAgaWYgaGF2ZV9z
eXN0ZW0KICAgICAnaHcvZGlzcGxheScsCiAgICAgJ2h3L2RtYScsCiAgICAgJ2h3L2ZzaScsCisg
ICAgJ2h3L2hleGFnb24nLAogICAgICdody9oeXBlcnYnLAogICAgICdody9pMmMnLAogICAgICdo
dy9pM2MnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS5oIGIvaHcvaGV4YWdvbi90cmFj
ZS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi45ZTBiMzlmM2M2Ngot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vdHJhY2UuaApAQCAtMCwwICsxLDIgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisjaW5jbHVkZSAi
dHJhY2UvdHJhY2UtaHdfaGV4YWdvbi5oIgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCmluZGV4IDI4Y2I1
YTQxNThkLi5iNWU1OTEzNTA3ZSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYwpAQCAtMTYsMTEgKzE2
LDgyIEBACiAjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vY3B1LmgiCiAjaW5jbHVkZSAidGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCIKICNpbmNsdWRlICJxZW11L2xvZy5oIgorI2luY2x1ZGUgInRy
YWNlLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogCiAjZGVmaW5lIElNTVVUQUJMRSAofjAp
CiAjZGVmaW5lIElOVkFMSURfUkVHX1ZBTCAweGRlYWRiZWVmCiAKK3N0YXRpYyBjb25zdCBjaGFy
ICpoZXhfc3JlZ19uYW1lc1tdID0geworICAgIFtIRVhfU1JFR19TR1AwXSA9ICJzZ3AwIiwKKyAg
ICBbSEVYX1NSRUdfU0dQMV0gPSAic2dwMSIsCisgICAgW0hFWF9TUkVHX1NUSURdID0gInN0aWQi
LAorICAgIFtIRVhfU1JFR19FTFJdID0gImVsciIsCisgICAgW0hFWF9TUkVHX0JBRFZBMF0gPSAi
YmFkdmEwIiwKKyAgICBbSEVYX1NSRUdfQkFEVkExXSA9ICJiYWR2YTEiLAorICAgIFtIRVhfU1JF
R19TU1JdID0gInNzciIsCisgICAgW0hFWF9TUkVHX0NDUl0gPSAiY2NyIiwKKyAgICBbSEVYX1NS
RUdfSFRJRF0gPSAiaHRpZCIsCisgICAgW0hFWF9TUkVHX0JBRFZBXSA9ICJiYWR2YSIsCisgICAg
W0hFWF9TUkVHX0lNQVNLXSA9ICJpbWFzayIsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gImdldmIi
LAorICAgIFtIRVhfU1JFR19FVkJdID0gImV2YiIsCisgICAgW0hFWF9TUkVHX01PREVDVExdID0g
Im1vZGVjdGwiLAorICAgIFtIRVhfU1JFR19TWVNDRkddID0gInN5c2NmZyIsCisgICAgW0hFWF9T
UkVHX0lQRU5EQURdID0gImlwZW5kYWQiLAorICAgIFtIRVhfU1JFR19WSURdID0gInZpZCIsCisg
ICAgW0hFWF9TUkVHX1ZJRDFdID0gInZpZDEiLAorICAgIFtIRVhfU1JFR19CRVNUV0FJVF0gPSAi
YmVzdHdhaXQiLAorICAgIFtIRVhfU1JFR19JRUxdID0gImllbCIsCisgICAgW0hFWF9TUkVHX1ND
SEVEQ0ZHXSA9ICJzY2hlZGNmZyIsCisgICAgW0hFWF9TUkVHX0lBSExdID0gImlhaGwiLAorICAg
IFtIRVhfU1JFR19DRkdCQVNFXSA9ICJjZmdiYXNlIiwKKyAgICBbSEVYX1NSRUdfRElBR10gPSAi
ZGlhZyIsCisgICAgW0hFWF9TUkVHX1JFVl0gPSAicmV2IiwKKyAgICBbSEVYX1NSRUdfUENZQ0xF
TE9dID0gInBjeWNsZWxvIiwKKyAgICBbSEVYX1NSRUdfUENZQ0xFSEldID0gInBjeWNsZWhpIiwK
KyAgICBbSEVYX1NSRUdfSVNEQlNUXSA9ICJpc2Ric3QiLAorICAgIFtIRVhfU1JFR19JU0RCQ0ZH
MF0gPSAiaXNkYmNmZzAiLAorICAgIFtIRVhfU1JFR19JU0RCQ0ZHMV0gPSAiaXNkYmNmZzEiLAor
ICAgIFtIRVhfU1JFR19MSVZFTE9DS10gPSAibGl2ZWxvY2siLAorICAgIFtIRVhfU1JFR19CUktQ
VFBDMF0gPSAiYnJrcHRwYzAiLAorICAgIFtIRVhfU1JFR19CUktQVENGRzBdID0gImJya3B0Y2Zn
MCIsCisgICAgW0hFWF9TUkVHX0JSS1BUUEMxXSA9ICJicmtwdHBjMSIsCisgICAgW0hFWF9TUkVH
X0JSS1BUQ0ZHMV0gPSAiYnJrcHRjZmcxIiwKKyAgICBbSEVYX1NSRUdfSVNEQk1CWElOXSA9ICJp
c2RibWJ4aW4iLAorICAgIFtIRVhfU1JFR19JU0RCTUJYT1VUXSA9ICJpc2RibWJ4b3V0IiwKKyAg
ICBbSEVYX1NSRUdfSVNEQkVOXSA9ICJpc2RiZW4iLAorICAgIFtIRVhfU1JFR19JU0RCR1BSXSA9
ICJpc2RiZ3ByIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UNF0gPSAicG11Y250NCIsCisgICAgW0hF
WF9TUkVHX1BNVUNOVDVdID0gInBtdWNudDUiLAorICAgIFtIRVhfU1JFR19QTVVDTlQ2XSA9ICJw
bXVjbnQ2IiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UN10gPSAicG11Y250NyIsCisgICAgW0hFWF9T
UkVHX1BNVUNOVDBdID0gInBtdWNudDAiLAorICAgIFtIRVhfU1JFR19QTVVDTlQxXSA9ICJwbXVj
bnQxIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UMl0gPSAicG11Y250MiIsCisgICAgW0hFWF9TUkVH
X1BNVUNOVDNdID0gInBtdWNudDMiLAorICAgIFtIRVhfU1JFR19QTVVFVlRDRkddID0gInBtdWV2
dGNmZyIsCisgICAgW0hFWF9TUkVHX1BNVVNUSUQwXSA9ICJwbXVzdGlkMCIsCisgICAgW0hFWF9T
UkVHX1BNVUVWVENGRzFdID0gInBtdWV2dGNmZzEiLAorICAgIFtIRVhfU1JFR19QTVVTVElEMV0g
PSAicG11c3RpZDEiLAorICAgIFtIRVhfU1JFR19USU1FUkxPXSA9ICJ0aW1lcmxvIiwKKyAgICBb
SEVYX1NSRUdfVElNRVJISV0gPSAidGltZXJoaSIsCisgICAgW0hFWF9TUkVHX1BNVUNGR10gPSAi
cG11Y2ZnIiwKKyAgICBbSEVYX1NSRUdfUzU5XSA9ICJzNTkiLAorICAgIFtIRVhfU1JFR19TNjBd
ID0gInM2MCIsCisgICAgW0hFWF9TUkVHX1M2MV0gPSAiczYxIiwKKyAgICBbSEVYX1NSRUdfUzYy
XSA9ICJzNjIiLAorICAgIFtIRVhfU1JFR19TNjNdID0gInM2MyIsCit9OworCitzdGF0aWMgY29u
c3QgY2hhciAqZ2V0X3NyZWdfbmFtZSh1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8IEFS
UkFZX1NJWkUoaGV4X3NyZWdfbmFtZXMpICYmIGhleF9zcmVnX25hbWVzW3JlZ10pIHsKKyAgICAg
ICAgcmV0dXJuIGhleF9zcmVnX25hbWVzW3JlZ107CisgICAgfQorICAgIHJldHVybiAiVU5LTk9X
TiI7Cit9CisKIC8qIEdsb2JhbCBzeXN0ZW0gcmVnaXN0ZXIgbXV0YWJpbGl0eSBtYXNrcyAqLwog
c3RhdGljIGNvbnN0IHVpbnQzMl90IGdsb2JhbF9zcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10g
PSB7CiAgICAgW0hFWF9TUkVHX0VWQl0gPSAweDAwMDAwMGZmLApAQCAtNzcsNiArMTQ4LDcgQEAg
dWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMs
IHVpbnQzMl90IHJlZywKIAogICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOwogCisgICAgdHJhY2Vf
aGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsK
ICAgICByZXR1cm4gdmFsdWU7CiB9CiAKQEAgLTg5LDYgKzE2MSw3IEBAIHZvaWQgaGV4YWdvbl9n
bG9iYWxyZWdfd3JpdGUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAg
ICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NS
RUdfR0xCX1NUQVJUKTsKICAgICBzLT5yZWdzW3JlZ10gPSB2YWx1ZTsKKyAgICB0cmFjZV9oZXhh
Z29uX2dsb2JhbHJlZ193cml0ZShodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKIH0K
IAogdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfbWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxS
ZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS1l
dmVudHMgYi9ody9oZXhhZ29uL3RyYWNlLWV2ZW50cwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMC4uNWQ2MjNlZDI1MTYKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29u
L3RyYWNlLWV2ZW50cwpAQCAtMCwwICsxLDMgQEAKKyMgSGV4YWdvbiBnbG9iYWwgcmVnaXN0ZXIg
YWNjZXNzCitoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKHVpbnQzMl90IGh0aWQsIGNvbnN0IGNoYXIg
KnJlZ19uYW1lLCB1aW50MzJfdCB2YWx1ZSkgImh0aWQ9JXUgcmVnPSVzIHZhbHVlPTB4JXgiCito
ZXhhZ29uX2dsb2JhbHJlZ193cml0ZSh1aW50MzJfdCBodGlkLCBjb25zdCBjaGFyICpyZWdfbmFt
ZSwgdWludDMyX3QgdmFsdWUpICJodGlkPSV1IHJlZz0lcyB2YWx1ZT0weCV4IgotLSAKMi4zNC4x
Cgo=

