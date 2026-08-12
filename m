Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AC4C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2UK-0007Jq-7S; Wed, 12 Aug 2026 02:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U5-0007IY-U2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U2-0003r7-Nx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62BCI2646686
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c02fVbhAOudqyZ1yr7+yFyrl17CR8xGkMKQ8YOwRWdU=; b=jwWdmVFSoSqQdlKb
 b2614KJ0X1Y3EJ4q6fE9Iw6AZTsX/vUMNT29lCsjUthypkd0DDj8SHsOqjOd7VLi
 Xw3rYbtLNPBCCl3kbLTzo3Z+oijWvDyYXGzuEam8TlsmFu6K8tKnkwucqHu/YNqD
 BYvSzqE6ovaD2j77OfXTVczTKlB95E0kY0ZMxvrxYvG0pd4d7Q8u1X0RJL0yZudL
 JDI1PxZP3FRI3UztfMi2bXSIFmUd7NyOd8EyLsRq5ndZRv4/1BIlhQak8g/PBSrM
 tB5NPLx+5EP1TMTwvXOLBC9rQ1T0CDw/YHN9QZj0K4E6DNh6dLPaaGQy1nCcwI9l
 ujrbOw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kkvrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so1008293a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516237; x=1787121037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c02fVbhAOudqyZ1yr7+yFyrl17CR8xGkMKQ8YOwRWdU=;
 b=Sad3NvghwZ6VU61qj2IR+kcNoRh0Le3gRSmRqs9Qs0XEJHgkeX+g1T3xj3BU+ceUUk
 eptlZCMPp8VSTdDIoh5qyAxzhMlHwWjgD5gRMF/Czs/Hn+LTsBW49Zyb6BngAQ7Wtico
 K4m7qJehtu44SPLmws/akI2ApxjVdxxbVGEZx/t9PoOJXos8ezd6K5Wim34wz/+aZDwR
 xfuOOvahGXtsDHaep9Dp0snavI+1IlQjELGkEkhWEodwz273/a6CyDlYuKIgawF0gSov
 PTJ2HdUkXZbtDy7vpfv1UMlVOvTmL57ahuKe0//XVyypGMgqUvMpIQXgZitD323EQb/k
 d01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516237; x=1787121037;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c02fVbhAOudqyZ1yr7+yFyrl17CR8xGkMKQ8YOwRWdU=;
 b=OL+Pj8n5fZoxHFhE3DUsQ0hezlJ4zfsdB8avEhZv+QCyUoY6aIVla7H45mPrn5YPJT
 yNDezTlxpZ8GNSr2l1COzFvKtbFP0y462ARzNcEwdCFLR7DyQvDtjWRKqbQ41cbWzbLl
 Agyr3RTd7coeyot/TRrUdvDdajQb9Nfw8p4IXXA0O0JVyN066iLBLpzvc+Rv9LitCnem
 9j4ZsvxAOK0QZ3TOj88MsAaQ1mf9Kt/PATFFnqHHAqoBied8NazTYoSxHctLIg9bpDsV
 +tSrylmnjTmkAID8Nk/IMeezi9lDg1Qrji3Ofwbu/KbwWTciQejCA7/YN6xr+6DhH/eI
 JIaQ==
X-Gm-Message-State: AOJu0Yx7q2WRssbpoluvX967rHz0wm8scdnW+ISdCNCo5DWwvI9MudSY
 DVlX3MfQjUWCZSPAsOA+GNXftU5VURlu0QMO9Y0pmly4xZlvzJBh+AavNKS3066uJFQvXUKAekU
 LAVer1dpQS5+SNS2kxfQH1f2gYo9eG0tJtpfl9laCSy/ijnojVET659sDZCfjyvCLJg==
X-Gm-Gg: AR+sD11XmubVcBC6kuwpgSTgzYNmSQ0M6Fmmoem1teT/cVPH8yY9k9yF9dyFhd6FIC/
 cS4YEgbeSIXa8ktSaNEbPZDOu5zpMdi3ml6W3fv4B8vM7D0TLd4+AzgxeaRH8+x6uUMcD4JDT3H
 fWplpSMh0geh5J/pWbPULkceBKgn28Try7FrIOlO/oDUx5oUBI/zcb5y6wNe+r+vZq+lEbS7V2u
 F9l1XSPyPWnmNluVSmZbom8TOwQJ067ugOM0ZZsZv9lYLQybA9lGDKkBSqPh3PcbnlHYij1ixyj
 fuLfUjlIruXnJGmRh22xNyifZqB44bKIMMpUawv+TsfoPl+3VaJ9MjqEF756mKjNWaNwNwoVBBj
 K6dhtpgL0pgCg4UG3gBtQc7kkGfwsxX6bPhLKQuEybC5Ye6rH
X-Received: by 2002:a17:90b:55c5:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-393017b600dmr2918696a91.18.1786516236417; 
 Tue, 11 Aug 2026 23:30:36 -0700 (PDT)
X-Received: by 2002:a17:90b:55c5:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-393017b600dmr2918650a91.18.1786516235885; 
 Tue, 11 Aug 2026 23:30:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 21/41] target/hexagon: add GVec override for HVX vmpyih multiply
Date: Tue, 11 Aug 2026 23:29:12 -0700
Message-Id: <20260812062932.543840-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: c4zhat9q5n7gFwmyIE31D9zAiE79rTUn
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c130d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XUVkopRKjuBywFHujjMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX8uDcUqX6Seno
 vEYJoNswYN/G9b8AR/Ue9dXm5hwak0JUrfFSwYKWr6CFI9EstYdkJsxsciG8ZN2zbMEHDxCQP+H
 PAYQXQaX7/EfWLRujI+qyvFVLXs7gx6wZcMAPJP6S3CKDsuyoq+3IO9BmjyOXRBiqGyvCaEkimf
 nnyFzxxKo2bcRPut3CSTOItghQYpWP/5kZDFqBmYOdvyok/OdpsjMp3BUBHraYxauMK3nm7u3hr
 7rGte0kz7zjfs6rlgNWg73273P9TpWOWV3seq95EE3p/QJW8sSvKbJsVVvUiILyix1v1IutyW5T
 sEnVokyv7uRwoHx1p+8FbAQVbcM5c8HvpacPqD+qlQtW6gdGpv2E6H8xrH/xlsGIUCGfaZ5G1YC
 l2kDx5eHeDD0nNbM9u8gsksm+UnQrMRXcV6cUSPmRLTTjStnJb4R9oYseXwkt7pIgaDklj8Kikf
 oU863d6Rt2tjzbbDdBg==
X-Proofpoint-GUID: c4zhat9q5n7gFwmyIE31D9zAiE79rTUn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX3EfPkf1ncSoY
 P98Vhb9Kx76sjahRHQQduU6k5E9r6TZB0RfKN0T9nsQ/qoKsFT+lzo1rq80WpE87JcuY0KcZCPP
 7fjXA9j2vo8rCZrby1/Ke75H2XI/W20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MDcxNTIyNDEu
MTU3NjMzNC00LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19odnguaCB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19odnguaAppbmRleCAyODljZTg5OTU5OC4uN2U1MzcyYTc2NDIgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19odnguaApAQCAtMzIxLDYgKzMyMSwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0
X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQgKmN0eCkKIAogI2RlZmluZSBmR0VOX1RDR19WNl92c3Vi
dXdzYXRfZHYoU0hPUlRDT0RFKSBcCiAgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNzdWIsIE1P
XzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2
X3ZtcHlpaChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfbXVsKE1PXzE2LCBWZFZfb2Zm
LCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9C
WVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCiAvKiBWZWN0b3Igc2hpZnQgcmlnaHQgLSB2YXJpb3Vz
IGZvcm1zICovCiAjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhc3JoKFNIT1JUQ09ERSkgXAogICAgIGRv
IHsgXAotLSAKMi4zNC4xCgo=

