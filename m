Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFF606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SAa4dA5u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IrJ916Y6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzCl-0000zk-5Y; Mon, 19 Oct 2026 22:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCi-0000z2-Qx
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCf-0003iZ-K1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tENd4031699
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z4fBaknLYDzdYYbajLHrBU
 gLHvaSIC7wtw104fL5+q0=; b=SAa4dA5uQ3qveZuvN+t8kD5WGA6aXVwyDdE4U4
 ZNhuf3xizzZybRcBPcG8hyuBbxFcISNNNewnhXNIm5aYgW3rwniljgJtW5esWxfv
 Jcuk56hsi/UgNx8h5vQqsEMQ5whYMkv4cMY4vjXYAJ2+j9+kE9uu0dWcCS1554W7
 zK0nfayk8V5Mh/nqtDfA+9rofd3OOhCoDR1XzS/fHIGuS9w4gju3c/yChLjFwOB9
 fVuNK1kjJaMWWrMMzNi0EWBSex9WuILa46wCeFk3GzsEOW+z4f7Fueuf3gmH9SiP
 DkHwsi659gVG0CJsuXi5cSu+Td92lDxgdhlKBArFLBZoKx0Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5q8c90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:47 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso5321593c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792461826; x=1793066626; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z4fBaknLYDzdYYbajLHrBUgLHvaSIC7wtw104fL5+q0=;
 b=IrJ916Y6kQ31JyilPlf460ab1Y0m70hb4ti2lvBApNysxeaza9qiVrX6e3N9vnPKFF
 jtbmBzZYxsC9IkPshegHjjPA+N2ZEl6v2Udgn1FEabngY9oKfDRRa2va9DU151jfC/9d
 hcXPPi1faD/opViT50XhoSzQLQ199mGti1xfqH0bXDqHn5qG9m0rl8d8q9SnkAFEOeGU
 6vEDeAdOCIvElTjVnLd9TbgP+a+SzTWRG+pe6AMZlqe1IBBewuEkHGHueurTKjYqpVA9
 AXx4+i1yvOmy2TP/9RnBlpIy1EXJpDbuxXcSeSd8pGHzh+KDgaduvYOmlfwHRZI15WcE
 nGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792461826; x=1793066626;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z4fBaknLYDzdYYbajLHrBUgLHvaSIC7wtw104fL5+q0=;
 b=vlOfjgdfGTVAQP/yvkvfV5Vu60puGac2BnxUITPWIBCSq6Mts8NFYbX7GY17/c8aHW
 KrCLyyyX5JhVjHIU/IVKWQOZbkQAXR8q3gY8a1mfdoLDhR6UoKaob4wFEn6/S5fGE2un
 zAXP6VfOHHo2Wyy/1roEviFENYeWCq+dm4VpIobSuj9mMvIXm05a64zKlZtYxNYsrLa+
 eCGOJ5UDa3IVbMQmbN6S+qVMXCedRrIBaJY++8U8nnfk12zCQ3khiPbO4TdCw7aer5aX
 hlCVSJBqvUga5DtHnu+jdX6O5iRAttfqci89erIAqTCpFfFoHrETBj25x159fR5FgYfl
 h12w==
X-Gm-Message-State: AFq9FYLCMSz4H9GYrHc/5s3sYXlIOzsFk7xB30xtvtOkdENRCrHWrZkF
 ZAlUTJSejNQpvIb5uimhKcwhMGBObYX7fV+lbVQRw8d0tt8D+sVobOcwv1XtNQmE9z7WIcmjO+C
 5DZNxDUQ4T0QAHJYUCUNvtSg4c0L4DtCYG0GHGrE/qaT16ZSD+NjWke5cvC9PXg1vRA==
X-Gm-Gg: AYBFou2qlxXqadUF9ImND57pBcjszeksB9xPgB9oZsktfKgeX3dspuDZFdhOsGeKXD/
 e7s6dYPnkf3//exw/UcF4qoOnBIbVR1XPWAhn3ucGAcEQJ8blu6+ihxTwxI/QD9tttSTqr8Frlf
 z4vv7U/+i4WwDcPXUPpBbmmHT2UxMF/4pPKJ0A8XPwC79suQg+ZTlDWGCR8FBdvMRdxfTG8o6PE
 7an+zbYUTrX+Zklht3M9tuJEAUT/mkipsta5FI57YluTAw5eFfl9whjBRpIi/1dmyyr0a/nl7F9
 IbPdQFsthp7m8z0xpTLLdK/Fr2TFzR8FO3k5U6AzWjbXPGOSkpN3373Ut5e6gqLIt2xaqT6HX/R
 TevpFAYZLDyT5ytTal9v8Q48qRAR3vkRCnRTGgoLmcXTEkXEY
X-Received: by 2002:a05:701b:428b:20b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-18512764f0bmr14264886c88.26.1792461825761; 
 Mon, 19 Oct 2026 19:03:45 -0700 (PDT)
X-Received: by 2002:a05:701b:428b:20b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-18512764f0bmr14264865c88.26.1792461825200; 
 Mon, 19 Oct 2026 19:03:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm49452078c88.11.2026.10.19.19.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:03:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 0/4] hexagon semihosting: Address coverity finding
Date: Mon, 19 Oct 2026 19:03:38 -0700
Message-Id: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: EdzvkgHr86k1XK2v9KpdeAuW_SE6fsWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX37BTo4p4c2P0
 dBuJyc5Hdl0HkiAGhy1eHD+lxmj1cDSgID+nJzzrjDy7HhwKVL+QyM2at99u80A8Wwb1yAjrfK3
 Rpru8Idar5F/zD9x57RC8P0A/r6z6yfPlXYHr6nwf6/M+2ewessd7A3lBm+R+pLNgidsXm8wcVe
 awyTU4NVQGHSaq4GMKS04D5Mb3rAOHO4q6Qr+OwCd913afnwq/tEMRTIg5TZk3eikyypODBTLJ7
 zLG8J/Q7aklLtZzCmeW5/7wwIvTCRZjSx1axkw5DQvriUkXlhgPERaLOJZq5Pcey7GRs8NAILZE
 1Q9+U11ox4V083k0Vdb+wTPle2PkPmW+NoiWCW2/PK0oK1xr3FhOtZCN0CH2NqbTAdBTdOL+gzu
 AbqV0MNG5xGTBy/ANZVtrSXzlrSWD9QLT4tM4mfSTb0w3ALmRU8lVOYo5fBH1/zok30xqfcD0OU
 Cc7gUw/wOcqjXRvm00Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX0im1vCbGWhvA
 DoF9xKRptEOh7pR88aQLTwRkp/rtzy0+cMH+wSXhRmao2n8nNAaVpUKBNDhprmUR6Vn8bkdE7T7
 KirsLXp+nI847dii6DFekS26cN0HElk=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad6cc03 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DHhsvDEEjNy1lX6SIIwA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: EdzvkgHr86k1XK2v9KpdeAuW_SE6fsWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200007
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlc2UgZml4ZXMgYXJlIHRvIG1pdGlnYXRlIHRoZSBpc3N1ZShzKSByZXBvcnRlZCBieSBDb3Zl
cml0eSBhbmQgUGV0ZXIKTWF5ZGVsbC4KCnY1IC0gRnVsbHkgcmV2aWV3ZWQgKyBxdWV1ZWQgZm9y
IFBSLgoKSW4gdjU6IG1vdmVkIHVubG9ja191c2VyKCkgdG8gImZpeCBzZW1paG9zdGluZyBPUEVO
IGZpbGVuYW1lIGhhbmRsaW5nIi4KCkluIHY0OgotIERyb3BwZWQgImFkZCBkaXJlY3Rvcnkgc2Vt
aWhvc3Rpbmcgb3BlcmF0aW9ucyI6IG5lZWRzIGEgYmV0dGVyIGRlc2lnbgphcHByb2FjaCwgcGVy
aGFwcyB3L3NvbWUgYXJjaGl0ZWN0dXJlLWluZGVwZW5kZW50IHN0YXRlLiAgTm90IHJlcXVpcmVk
IHRvCm1pdGlnYXRlIENvdmVyaXR5IGlzc3Vlcy4KLSBQdWxsZWQgdGhlIGhleGFnb25fcmVhZCoo
KS0+Z2V0X3VzZXIoKSBvdXQgb2YgImZpeCBzZW1paG9zdGluZyBPUEVOIGZpbGVuYW1lCmhhbmRs
aW5nIiBpbnRvIGl0cyBvd24gcGF0Y2guCgpJbiB2MzoKLSBUaGUgZmlyc3QgcGF0Y2ggbm93IHVz
ZXMgZ2V0X3VzZXJfKigpIGZvciBzZW1paG9zdGluZyBhcmd1bWVudCBhY2Nlc3NlcywKaW5zdGVh
ZCBvZiBoZXhhZ29uX3JlYWRfbWVtb3J5KCksIG5vdyByZW1vdmVkLgotIEZvciBIRVhfU1lTX09Q
RU4sIGZpbGVuYW1lL2xlbiB2YWxpZGF0aW9uIGVycm9ycyBhcmUgaGFuZGxlZCB0b2dldGhlci4K
CkluIHYyOgotIEhFWF9TWVNfT1BFTiBzd2l0Y2hlZCB0byBsb2NrX3VzZXIoKSBmcm9tIGxvY2tf
dXNlcl9zdHJpbmcoKQotIHB1bGxlZCBpbiB7b3BlbixyZWFkLGNsb3NlfWRpciBmcm9tIHRoZSBh
IHByZXYgcGF0Y2gsIGNoYW5nZXMgc2luY2UgdGhhdCB2MjoKICAqIFJlcGxhY2VzIFBPU0lYIERJ
Uiwgb3BlbmRpcigpLCByZWFkZGlyKCksIGFuZCBjbG9zZWRpcigpIHdpdGggcG9ydGFibGUgR0xp
YiBHRGlyIEFQSXMuCiAge3VuLH1sb2NrX3VzZXIKICAqIFJlcGxhY2VzIHRoZSBmaXhlZCBCVUZT
SVogcGF0aCBidWZmZXIgYW5kIGJ5dGUtYnktYnl0ZSBndWVzdCByZWFkcyB3aXRoIGxvY2tfdXNl
cl9zdHJpbmcoKS91bmxvY2tfdXNlcigpLgogICogQWRkcyBTZW1paG9zdGluZ0Rpciwgd2hpY2gg
c3RvcmVzIHRoZSBHRGlyIHBsdXMgZW51bWVyYXRpb24gc3RhdGUKICAqIFN5bnRoZXNpemVzIC4g
YW5kIC4uLCBvbWl0dGVkIGJ5IGdsaWIKICAqIFdyaXRlcyBpbm9kZSB6ZXJvIGluc3RlYWQgb2Yg
aG9zdCBkX2lubywgd2hpY2ggR0xpYiBkb2VzIG5vdCBleHBvc2UgcG9ydGFibHkuCiAgKiBMaW1p
dHMgcmV0dXJuZWQgbmFtZXMgdG8gMjU0IGNoYXJhY3RlcnMgcGx1cyBOVUwsIHJhdGhlciB0aGFu
IGRlcGVuZGluZyBvbiBob3N0IHN0cnVjdCBkaXJlbnQ6OmRfbmFtZSBzaXplLgogIFByZXYgb3Bl
bmRpciB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC85ODIzZjY3Zi1iZmM2
LTQwZTItYmEzZS1jYjAyZTUzYTQwMDRAb3NzLnF1YWxjb21tLmNvbS8KCnYyOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTE0MjIzMTU5LjI3MzUyNjItMS1icmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRl
dmVsLzIwMjYwOTA2MjIyNTUxLjM3MTI5NTQtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20v
CgpCcmlhbiBDYWluICg0KToKICB0YXJnZXQvaGV4YWdvbjogdXNlIGdldF91c2VyKigpIGZvciBz
ZW1paG9zdGluZyBhcmd1bWVudHMKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5nIE9Q
RU4gZmlsZW5hbWUgaGFuZGxpbmcKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5nIFNU
QVQgZmlsZW5hbWUgaGFuZGxpbmcKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5nIEFD
Q0VTUyBmaWxlbmFtZSBoYW5kbGluZwoKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCB8ICAg
MiAtCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAgNDggKystLS0tLS0tLS0tLQogdGFy
Z2V0L2hleGFnb24vaGV4c3dpLmMgICAgIHwgMTM0ICsrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCAxMDIgZGVsZXRp
b25zKC0pCgotLSAKMi4zNC4xCgo=

