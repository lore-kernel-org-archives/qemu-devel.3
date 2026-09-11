Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F2AC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x586K-00079O-6e; Fri, 11 Sep 2026 16:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x586I-000792-4N
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:43:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x586G-000771-LN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:43:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BHWlwc1461965
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 20:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bA6M78DnphziI4wrL2CbrdMurP2BD8Ikcl/OMT8KQ7I=; b=l4lWyV8c5ybjpsRP
 P2NZ298ziJng0Pf/I4uO6Idf6hkzFpNXlS9onMqCLBab5O7LLSR5r1tGgLRqW9j/
 mEXmMZVk6BXKcBVLK5cXA/FXNndeZJKmrq0gmDsG47EvaoeYxQN4iB/wPCT1Bfgi
 tlN4wrayHPbHvPenpQinViZ3r0lfT1sxBntF3EwbmQeen0stjEh8iqpFnCDpXLjf
 Zbi2gXaf1wND2oW5t6n+bWrXMTpW4XFJGc7ArlwbLRZkEd9kO2SESuuCEbKlXipT
 MjNXUkO+n/Pi1LG0BKD/jeyWTAZbRvRzIMRNyhQLz4zk4Os4mE2rqwRAiocjItbB
 Q9HkTQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmp0dgpta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 20:43:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8633c0d7353so1720908b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789159435; x=1789764235; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bA6M78DnphziI4wrL2CbrdMurP2BD8Ikcl/OMT8KQ7I=;
 b=Ire/N/2rvkWG3VmK6McJayZy77OVyjoAgMCspGRgLYsMpRLO14KMAYdYSVOtsfuyVq
 r1oQySTU8+IwVeYIjanamPMxHqEw/Wa6th1Bdbn/hXay4xZRc9uezFGVuqWREsyQcsG7
 MjEZbwyFk6dlClFo7LRh2hPPc4zhFLj5nlvNdkvBNQotEUMUK6TI7oABvcC7MMdzOivo
 HtByBDNgoR5xwdZQJtk+YHitsr5m6XUQ8/9i0T0fvhMo8UptESAnmiExgEn4iM7F+qUM
 9hIy/G6oB0h8IhHoGB31PhjL4Da0Zd+omlMFDNg083tdQxNokgFGYq/HQQ8wuQCtSn7C
 Ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789159435; x=1789764235;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bA6M78DnphziI4wrL2CbrdMurP2BD8Ikcl/OMT8KQ7I=;
 b=hEkMjCz91lrnJhnd/LiT/emKhhzqwO2Rq+yqxTaAfaFImwK5n8XLGSVByIZVWPDn+N
 +Qnjc0rmT9rWffBog/QonVF6TYWZR9tMEf82ojTQoktvnXsEzkw4tj6Nqt2hyulIP7ym
 LFNauBz7y31BzU/D0dmVhVntxOB+2Dh3+GdHPpmUMo4kaaBEiU95nCbfpHl8dHSiwhfo
 7altxfgBltfjkVKPddilYPCGu5Mwtu4bF0U9Jxf3QC/WoCc56r924QXw3wnANUhZjjaI
 aE6Za9rB8uvEkcj9O2ffTxyvlWDPoKp/7ZGLVbS22e+r1szCr1YQIVWKt0nwkCiGjT7m
 IV7w==
X-Gm-Message-State: AFuF++l9wuAEf8soGBV1Gt9Iyoy/mlpM7+sqjyplznQuHLWZb0niJLXw
 dYO29W1GKrl3rKL0SyHw0WiQdBH8tk5AUYVHSBx66/51Y5iP7OWinozjFSsNxDISNW2JtLX1UdA
 Jknp2eiG2+jn+BzWncrew6d3XnCDKSK+BiA6hJmMFdBDlnMrlIyzPkEoODNVai6Udaw==
X-Gm-Gg: AYBFou2ieSziyGTCdE45sNN41S1sRsonUcEcGydfcKaUKw3Jdldys1yBRG7YT3LGiMK
 6pKDcZZyNOLTATpOwWde3grrRTE8XysUFXLCO6+86++4DYW1NFD/TOCc0fg0IARCvi+EyTb+cI3
 56QPEjMEUthsl5Rs2KOSaXmA1EM6sOUcShg5xtc5B3fMMQw9ewDqw+dtYsY4TSFFfZcLussrfUs
 eGT5Y3fMFOgUWynUZuzl02f3T07pl809oE6r9/Y7A+NB+VhMWuU6O5TNP1REhWAvTdL9hEzt6wV
 1OgGQPTZL4j7HCDH1eKBIK53BFmrUSJf/Cn13Oq8I9NsEs2wlkTi2Nwl6yeCky0ftygeOQ4MZCv
 rmlp8UWDQvBJK8gOtraQGMtprGiqBBFM+EiObCrf3342FLJFo
X-Received: by 2002:a05:6a21:3a94:b0:3d3:ae1f:d7f4 with SMTP id
 adf61e73a8af0-3daed616ac5mr10748765637.20.1789159434625; 
 Fri, 11 Sep 2026 13:43:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a94:b0:3d3:ae1f:d7f4 with SMTP id
 adf61e73a8af0-3daed616ac5mr10748737637.20.1789159434167; 
 Fri, 11 Sep 2026 13:43:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm9735743eec.28.2026.09.11.13.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:43:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH v2 6/6] tests/functional/hexagon: add test_hvx_context arch
 test
Date: Fri, 11 Sep 2026 13:43:34 -0700
Message-Id: <20260911204334.1264922-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
References: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=U7EHnuru c=1 sm=1 tr=0 ts=6aa4680b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=bgrJZOaH1VlBtLBOFfcA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: ybRPZD3gDepdDXONVgVoLttCzI5U5He_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI5MiBTYWx0ZWRfXzlJWshaKVpDz
 xHXu67vzMUxV97GorkQxko9KvkYl5Qjy0rlJZdp+ZJN4B4MaJ+wmRzvnVlwoz6z35fmv5oTt06V
 cB3fJHK0yqRGMVuhEJneNjn6LP06af4=
X-Proofpoint-GUID: ybRPZD3gDepdDXONVgVoLttCzI5U5He_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI5MiBTYWx0ZWRfX70E9Ziq6xO3P
 9mXsujqDH42TFRT4LbaljcXXV4Z3HoVIYMZXM8S89eoYRqrixT443gDRl2fhoYIBt58zFDngQ4Q
 rvOiOriZbQ8mXDy5G75nx2qYstwm9erxSYL7OyaTcckDhgvitRIRahhhHVDAKxCmhsKbdUQSzZ+
 ERsYo2ZY9DJUsyrrcr+A46UIhYL9QuXnH5PhGxJf2LbJfPdvvee0guUKrKAlihqJmjhUYBHovJR
 QPgrOTwhcAd8YA2DxMi7o/wUJ9vYt8eWpqCYQ7mbG6irNyQlEkadhdU/FsPHw5QGWxwGpo0DLtD
 BUsTPsKyyzBTrRvnf0qnyRFFVBH7XIxMiDxShRgyg2yjcKGwC2ndn0Qqeuz+kr3ezq8zPsk3BgF
 O1niTlGGW/nzr2h1N1cYbWyFIrnSUfyLCLiF4Klyet6qFTuW/AIZUIziB8WQrxGZSsz52jCzJjj
 ZHOAgzRdBP72q5/rE2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110292
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

UGFzc2VzIG5vdyB0aGF0IEhWWCByYWlzZXMgTk9fQ09QUk9DX0VOQUJMRSB3aGVuIFNTUjpYRSBp
cyBjbGVhci4KClJldmlld2VkLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVh
bGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5w
eSB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDVkN2NlNDg3NDM2Li5m
NzNjMWY0MmJmMCAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJj
aF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3Rz
LnB5CkBAIC05OCw2ICs5OCwxMyBAQCBkZWYgdGVzdF91c2VyX21vZGUoc2VsZikgLT4gTm9uZToK
ICAgICAgICAgIiIiCiAgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF91c2VyX21vZGUi
KQogCisgICAgZGVmIHRlc3RfaHZ4X2NvbnRleHQoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIi
VGVzdHMgdGhlIEhWWCBjb3Byb2Nlc3NvciBjb250ZXh0OiBTU1IgWEEgY29udGV4dCBzZWxlY3Rp
b24KKyAgICAgICAgYW5kIGlzb2xhdGlvbiwgdnNwbGF0L3N0b3JlLCBhbmQgdGhlIE5PX0NPUFJP
Q19FTkFCTEUgZXhjZXB0aW9uCisgICAgICAgIHJhaXNlZCB3aGVuIFNTUjpYRSBpcyBjbGVhci4K
KyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9odnhfY29udGV4
dCIpCisKIAogaWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKICAgICBRZW11U3lzdGVtVGVzdC5t
YWluKCkKLS0gCjIuMzQuMQoK

