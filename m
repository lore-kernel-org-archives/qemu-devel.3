Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F15CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2Jf-0000zl-OF; Wed, 14 Oct 2026 12:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Ja-0000yj-7I
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2JV-0001Zi-NA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbFvX301195
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U/M/6P4gwX9yNMbs+L6jBr/DCKCOnbulmkGdz93C2Fg=; b=hJ+zMkrCJL4Innrk
 Vhqym0qRVIfLpx3oDOLkrSQZxt19qx/oBGwdox3ri4s5tkcFzsfawJzxM68P9cmP
 YmNnxekHbp/2dwiW/OSw5c4iu5rLSjb3vwl/YiuKihlnX0Z65EV7pM4V+EjDMe7C
 VltHNnkMoHRh4Ccjq4FdXgaqAov3HA8iWhdt1WZ8Hqo8nOR6el/FTJQeUcRDzyGl
 wk/tEZ2qt2ybuBFq90bXqQTSdgLC9UnEWuebg4xJSpJWh1xsrDv1d6DBp9/hXWGY
 07b91RhDR1VHpCAR+kPqEbiKzCFHGI9SzGGD+Ksj2fwUwSUX0K9/AFbjIAmUlA1O
 DvxCUw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622nbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so8922154eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997128; x=1792601928; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U/M/6P4gwX9yNMbs+L6jBr/DCKCOnbulmkGdz93C2Fg=;
 b=ZJS7y078aZTdb0JKnzVekjTVq9K37R5metoByFnorVWkkNl04u1t8PkFKj/63FnSXX
 wkdD+U4xwAJYxtdgrXKaZVbtGKh9C/reI72ih0XHS3nWQJJ/yM5c/DbTUzOgjESKGcy9
 eRYVuJyHpzmOjS3VmxrczYONj4pDDzzlcaFEWHXAnd60sdUVsmwLAffGlFcBBHIKTphk
 5fse+HcoEbGMYCMz/HlORHnkYLp6jNOU3u3N+ZW2afa98luIGEsjS+N6j9XfD+krwKP7
 ZR30Wv48gGRwLy24JrIJFo1ryB3i/Dc44vo4dcRJDoC+W1bUWXWNiLmmNlTkuIFxRfY7
 RF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997128; x=1792601928;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U/M/6P4gwX9yNMbs+L6jBr/DCKCOnbulmkGdz93C2Fg=;
 b=C5pO5XIRhwjMHP765df5Lvd3SXhGIdI/5zXwuGiKwEs1DL3bM7LvqX/RW374b+TVWX
 VY8iy+6hB7P5aGixEQ7UQlKR2w6XaidLX6L/mW+M80A8rGGEs6CsPubB6hGmIEKi9Etn
 MO4iL8e3Xy1pdrbO98NQ+5kaaOiMQG/qXIB9dPEt1Iy8XOeqMldwP/V+sL0tvmSu2ZQ0
 vbWFyDCnYxKajtvBGZWaok+O7hEeZAqxHSNfp0MLHhiZq0jy4AvwmRmCJQrhuHlJOJFb
 t8cfcNYPu+KK2eAI5TXC4QkxtEfOSlldqrYtsPMMT6mufP/Ko/rA5PbVzM45xYp6Eff7
 Oyqw==
X-Gm-Message-State: AFq9FYJEgmjTRn1ioKVHWbznfpNkejm0E04nvQSO42v1KZ1wD4Ak8ZnF
 VHLGNCOvTu5aAhaQeZfg9jdW086fBMw3N8Zr+P6gYbWPUeaSoHbZ3XgEEmD58DKeWm21iBZ+X89
 fsPdKmiv/M9FpUrWy0+fJr1EBhECNkU+M52NOw2UiZXZAPOrpvFetbUmHLhCVKGEGPw==
X-Gm-Gg: AYBFou3KBhTKvOnLOeKZbW6Mwg6tcX7bEm1JEPeRQJV9fMtkRkQca4rRNxeIKe/3KYn
 WEJQYKxA/0OLJyKZPut+/+MGnxrhmT2jGYKl8fcLwtIwfnv3F1+hQNXREJDQOySTlTllu/CWHIL
 RBUTB2QNR+DIWOYXFaBrnsz1ERA2MXuUxP5XcbuHN8OPnZIHP09F8KuV9+3X9BP0CY/x+g+vhfb
 FIs6Ds7hUi2hl+sFp3JCjNXjUh36atG/qwMyv3EAbi44Y9kpM5cVGm0znjMnJceVW6Qwnf/8WWH
 ZFEKypIvxGXbF89RLOj2tcERLHJpEyzLPUvdQ2TEOi+W+Lz/mC2pUvF7pc3YJJc81g90CDo5Yq/
 k97fFdPjLYUuMTSkocj/UAIVTrpuWP7SS0va9IAK5hvWatNU=
X-Received: by 2002:a05:701b:2916:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-16a5dc01448mr22013957c88.32.1791997127404; 
 Wed, 14 Oct 2026 09:58:47 -0700 (PDT)
X-Received: by 2002:a05:701b:2916:b0:14a:d8fe:3390 with SMTP id
 a92af1059eb24-16a5dc01448mr22013933c88.32.1791997126778; 
 Wed, 14 Oct 2026 09:58:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11137939c88.6.2026.10.14.09.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:58:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 3/5] target/hexagon: halt on tlblock when the TLB lock is
 contended
Date: Wed, 14 Oct 2026 09:58:35 -0700
Message-Id: <20261014165837.2916482-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
References: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: m-L_L44aN90mQe9zfx6siqbzxCKYaHW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXwcatgdWVghh8
 +4Q0U6QF0S4EhCXbb2nX1QQqZ/UIElAVZ6sbfI/TekE99PYSut3LAQOTO3DKbb1rFPaUuL0P9jN
 aylOHi+1aLEWZfKE0l8sF9Ni6Nkc6dMPvtO3aObs1I6HX9F+XAyU+cgJme/bgMhfTjUhhm/q9Pw
 TxsH/DnV6iAKxj/IJ05WATQusJ8t771GP1XK+/iWYDv49Ww6/gRIgNO+kdChXkaCuhaPhW59ulc
 HfYh5UCHoAqdtBFC17KHwb5zFBzRaDd7AmstbuP2iUDsWmhs1CKO5FB2jzrwCrSsSO639XDuTYu
 Eq5VK4DUBC5ljU0lfcbc8SMS18vPR9pcVmidfZ5sjongHViSFmTOti03l8/gudjVE+10eWBUXHV
 3ECAhQlY1uNY8Fg5GVhH3taiy5V8hwr6wDVNETIBqPgcDnCyo8uHW0eUVK+HBFBsVDwufprSXNZ
 JSX2Lq8AJ4Br5YBakeA==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfb4c8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=n7pvLpctYYjJJk5sxiwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX739+4D7ZzE9k
 ZhQRiH49IbmgfPiuM3/ChcFCWUukl3mu4RXNeXeN906/MOwM7rYhTbfg/cu2AiXXH62Hu8E+GUL
 KxRNVhwV48R5mwODKbFpAtLB/1EOyiU=
X-Proofpoint-GUID: m-L_L44aN90mQe9zfx6siqbzxCKYaHW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

U2V0IFBDIHRvIHRoZSB0bGJsb2NrIGluc3RydWN0aW9uIGFuZCBsZWF2ZSB0aGUgQ1BVIGxvb3Ag
d2hlbiB0aGUgbG9jayBpcwpjb250ZW5kZWQuIFRoaXMgcmV0cmllcyB0bGJsb2NrIGFmdGVyIG93
bmVyc2hpcCBpcyBwYXNzZWQgYW5kIHByZXZlbnRzCmV4ZWN1dGlvbiB3aXRob3V0IHRoZSBsb2Nr
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyB8IDMgKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X21tdS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCmluZGV4IDYzNzg3M2IyNjY4Li43OWEx
OTc5N2EwNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9tbXUuYwpAQCAtMTIsNiArMTIsNyBAQAogI2luY2x1ZGUgInN5c3RlbS9j
cHVzLmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1
cHQuaCIKKyNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxvb3AuaCIKICNpbmNsdWRlICJjcHVfaGVs
cGVyLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHV0bGIuaCIKICNpbmNsdWRlICJoZXhfbW11LmgiCkBA
IC0xODAsNiArMTgxLDcgQEAgdm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IFBDKQogICAgICAgICAgICAgICAgICIsIHRocmVhZCBtYXkgaGFuZ1xuIiwgUEMp
OwogICAgICAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgICAgICAgICAg
Y3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKKyAgICAgICAgICAgIGNwdV9s
b29wX2V4aXQoY3MpOwogICAgICAgICAgICAgcmV0dXJuOwogICAgICAgICB9CiAgICAgICAgIGVu
di0+dGxiX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19XQUlUSU5HOwpAQCAtMTkxLDYgKzE5Myw3IEBA
IHZvaWQgaGV4X3RsYl9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKICAg
ICAgICAgZW52LT5ncHJbSEVYX1JFR19QQ10gPSBQQzsKICAgICAgICAgQ1BVU3RhdGUgKmNzID0g
ZW52X2NwdShlbnYpOwogICAgICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hB
TFQpOworICAgICAgICBjcHVfbG9vcF9leGl0KGNzKTsKICAgICB9IGVsc2UgewogICAgICAgICBl
bnYtPnRsYl9sb2NrX2NvdW50Kys7CiAgICAgICAgIGVudi0+dGxiX2xvY2tfc3RhdGUgPSBIRVhf
TE9DS19PV05FUjsKLS0gCjIuMzQuMQoK

