Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383BACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZLr-00006u-A0; Sun, 04 Oct 2026 23:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLd-0008Ja-W9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLV-0000ps-Rb
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xwpK4060139
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 03:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=; b=ORjEnwCGeApjiWAs
 U10tmgjSi/U+IBp1WpA3rpnnY9olovoabUXt8gfv8UH3rVcRFiEYFLgo0z105lZ+
 Mva3anilwDct4XaOe3XKiN0oHauNwGwGCD/CXskbYuSHl8D/YSY3sD9o7q4AXChk
 Z+1TlGlzgHn7Edlr6Mw+C+buiVNcr6Nwjv+df+m2V+Ad63mxPgC3SmUe0fJ0pidC
 3ZQzaUNUfzXHNEsm4ha0E8FS/tu2iqRlGDEmmyDGfUk+4nY6ZKIhtG3P8LRXK6CQ
 A5gbH27tK+pX0tqfPpxf4M3N79bqGE4tByXN+lZALwKAkl9kppYvvagTm1ZC2hAe
 laGlvA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn88wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:26:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so2099418eec.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 20:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791170792; x=1791775592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=;
 b=icT3QukGjiZiZk9t2aXvlY1aFK1na4f+TY9TNTpJmAtfB9/7nStUoj+zCbVuhHUQ0P
 Tb8/+MC1gFFnEMWphDkiumsEUhi7tWVNR2zE8F9+pVUtDcjfXlZ32Nv1ZDDtofZBN4gu
 aYcBLUO7Mivy2c+5F5Soz+lrwz9f45B09zhwuMh7ZdAL0yrMUaCx8ap/jCl2P4ZmeaWx
 v3EK8yGobqxT91tv4SzxTg7D+zJgcaoIEvCgXIwrDt08wZ11iLk09HiXUoU9G4iUZ/a1
 PAvLFXo8F9uuzofPPpQh5I8wLo6ZRsvuNJN8MtIfcZIE3rpn0RuHMcvZd9/NrvULB5Oi
 dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791170792; x=1791775592;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=;
 b=E1TYTr0ieGoVakrfBooO70MVTcJTDvQG9ngjzFH9q7FnJCfYN07CtWYyNGQL5G6nip
 mqCw0DdlsmS7S3Ij1/hmg1vqQTeZdFQDoVyRU8Tei3NNYMlenpLFNoXYuHOzqu4034Of
 q7tFh3Px+pKiAZ/fcUWbAslsF4YOkH0tmYYE4Hss17uyPMxtKCu8FULlHslsxUDPpL2D
 fE/OGngtXs47K/YLPNDyUXGTKlUPmdVf8YCrx3/j1Gdy93GQWg+Mr855jFI5vgO1u7dF
 mgDoxfGB9EUjJFVDcAi5n3pP6eGtsUGgqkvKhvvyBhYurW2iLwza7gQs8GegREibI0Se
 qE9g==
X-Gm-Message-State: AFuF++kiDW7KCumtCd02s2Fn53qQ9ndcu7G0pOgTI95MIfpE90xriNCo
 uRlEr/37IBJR4cPinPXPnl1pYno1Xgj24tq96goHqwuam+IgfwH9ttnMrRfWDA1cdp5dObFYs40
 JWhqXZpqoRAy96q5eFn2ZUasaWlc5ThOXnUrGfwEegpKp2u/q16GQOp+PF7S+xk299Q==
X-Gm-Gg: AYBFou1+bxNlsJ7BMbMxODi4ZffF1FnJMxgAiL9U76QrknsLi6ifzmTSFG7S3QswY5w
 /86uWLcaSrQnDgUK0QgthhA4ISydWwjXjx2AayNcFnt8MoSP3zM8TLZ+Pp6dgxtPGgmiQPkm5N7
 jVD5JZ5RR+pZyAZPHhtN4ExEHHNWlmtblinSJUGZjpLqFP2v1ZfqmryZB/KMeEroK96ujQvcEHk
 2RufaC/dnabd7oOjHV+q2sthUPYUm/wid1gYD2qHvPVRuCM7uY8MzLJXhd1OX5fO4zejKE1dh4f
 A7laTvpc1SROEb5D4lkwQyv36spSsMwH24h6ojBMIr+wWu3yeUuCDAar1wroN2vyNHLNKv9RAXO
 oLBkG8M0yH7mG2IozVcfjcum0jpFIxbYXrTZSKz0KGLuH92E=
X-Received: by 2002:a05:7022:69a5:b0:14d:3c0c:79ea with SMTP id
 a92af1059eb24-14f5b413047mr17354972c88.8.1791170791694; 
 Sun, 04 Oct 2026 20:26:31 -0700 (PDT)
X-Received: by 2002:a05:7022:69a5:b0:14d:3c0c:79ea with SMTP id
 a92af1059eb24-14f5b413047mr17354911c88.8.1791170791032; 
 Sun, 04 Oct 2026 20:26:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fcd83fadsm18596255c88.11.2026.10.04.20.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:26:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH v2 09/10] linux-user/hexagon: add v75-v81 HWCAPs
Date: Sun,  4 Oct 2026 20:26:15 -0700
Message-Id: <20261005032616.1293829-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: VRYnQVn5FLhs793LPRorMpmfglei3QOJ
X-Proofpoint-GUID: VRYnQVn5FLhs793LPRorMpmfglei3QOJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfX8ftbDSk0bMyM
 O49ZbrQOYZFS0QkE05oaF5MGrYVcw2oTnKRY0D2XUJwhIANQ1161YTdNDeVtiuraR0oEx4nBHWd
 4mBdJT0p388i7c43g1vnIo3HEP6TQE45PN4WySp9IE9z2fVbRBhTcctTlHh7xOp/hSgRXGEFXeK
 h3Cr5QbB7PJ8+hRO2a+9awSVmVC/F1Vtc4BeJGrTjPLqdHUlBDhDgmxFjkP10NaT9JLHR/s6Qn1
 r07QOmWPvcwHXWJKRohY+dysoJahkV2uUGMaemqC5pP1K329xmDlMO6XEOKt9QqZlVFqM7nkxds
 EUxpSmYHf9CfSLfa9yk5OzQa6++qj7kf7xsABAgD8oGfqPWNobPaOcvQckhe444bBHb+nKFVxwH
 AEBGiuidA+n/vTavl2aKbTkZcp9Gbylv6ACROhoIwViFmCLB7cIoTeS8P6o22qqv0OjNiBvhXm+
 XMD1F8TCZtt9OsK3HHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfX7M1SOXQ2viKD
 S0ZDQFuacN8wnoarrYkbWw+g3IEwLCoc4DklHHt/W6w8BrDyRRDuEH7iSVfmrq7y+FHGPEvu/Xn
 McWc7fnKmOqmTDO1zEWMVylJPfYQ2WM=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac318e8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BRFeZrn0LRIrCjf-XoEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050013
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
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jIHwgOSArKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24v
ZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA0NDA1MzJlZTQx
My4uM2E2YmE0ZTEzMDQgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
KysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNTMsNiArNTMsMTUgQEAgYWJp
X3Vsb25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WNzM6
CiAgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y3MzsKICAgICAgICAgYnJlYWs7
CisgICAgY2FzZSBIRVhfVkVSX1Y3NToKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9J
U0FfVjc1OworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjc5OgorICAgICAgICBo
d2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNzk7CisgICAgICAgIGJyZWFrOworICAgIGNhc2Ug
SEVYX1ZFUl9WODE6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKKyAg
ICAgICAgYnJlYWs7CiAgICAgZGVmYXVsdDoKICAgICAgICAgcmV0dXJuIDA7CiAgICAgfQotLSAK
Mi4zNC4xCgo=

