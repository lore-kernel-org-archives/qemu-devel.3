Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E344CA6009
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEc8X-0004e8-AU; Wed, 07 Oct 2026 20:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8R-0004cd-BT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8P-00080g-FB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6980aLeQ2434424
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=; b=V1nzLWvfH6tAkxVd
 jOgv3iHQeHCTBAvmk3Q1NHx73NmcClUa2nonpDyunf11mfC8dhoe6qBZWz2F0yzE
 W0v0wsVCw/mJTvDHYVARa4EQaYUwFwBLHPQMhdmfBoiUTsmx3CuGwbkgQ6Wuaj8J
 SkiBO3KmWQSQYNNryDshMCh/Ym7JZsTmD6cYSCtDcDtSnaY9Grx/bV3PjWYKGLCI
 EEDdghWC5PHtXZEKSaCmi7axmqIBxAbSgL7mlAbeQJFZCcOlW8MyfWYMvoFc+QB6
 6aAubx5qly6e7fBd32l2ueFEVAYMGuWd0G0fRLyPL3B44DkXEQFd2Pxa5PXLnb5s
 LwdF4g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sg802g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:37:19 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14fed306427so15754374c88.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791419839; x=1792024639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=;
 b=NSGHr0ueNhqDPH0N37P2zua1LlAeYRATUXbdde4oSiy9iY5ELTNHqrMb7GpJUQK/wU
 olS8L3W+kSgxe3o2+Ehf/qdG2bJGrtnuAqiOepCDGm9e/SmUqnvHGNTWDvKMkfOtnSCS
 dlcm1InyjxM/njihWEo3V27b0S+0sEvQr9eycZ7YYiQy7MQpp264IIcPjZ4K7rY2Fvn7
 Bnra/ytfnEQ5xSQort9RFhmhRJlJxkt5/tvnBRc4ohrcYNSqdkDeTlkgkPEThLWr2fzL
 jYLn3BvIOYpKqY9sNJIuBxYKdnoZjPG/WJZbAlYdIZQ4WW+vhtQ2ohPQHDGDjHy89lSF
 9gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791419839; x=1792024639;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SW8nhTNJVPbJYwsftXD+NCmIRsW44vNyR0OwIj7NR3U=;
 b=WmE1c7XVvXNEcNtSVrXF82GOnl53MlBcr2PtKre1tlxtlumVlkTK023Pn2x6pa3Ov7
 BsFjz/kcfFo1KGiTWlFjqKu4rV0fvEiV5bR5xErjTtIftjnS/2kOAZZo1NvUfYH8QR9+
 DfMy2iivyHoNZ8p0FozVxLNvDRQULNJvvH6VTHEJhoMf994JE3AaaBhq2RgFCxYicACb
 PggbuVcGEyrz7w1N+22gS3bIfG4YNHfMTAGCCsvSkN6R3XKABwbOQ4WiaidaFESCfYll
 9l0R2usk2kdgIdn0nwM91jVbO6zbmdSpegvADz137YuKgPwHvZCAItHxJqcimHDrkkGH
 dWgw==
X-Gm-Message-State: AFuF++mNikyLGcEGEDhmQufUlQMA8P8uXSeDvrGc2MOrzNegrKR0/4NJ
 Ku3OQxhCTacwE3oxMnhq14w2Y/DW3iW0+j50obC1Jud1dO87MdCr9iLJYNpao7oQ6swQgPOkSZR
 rkw6tjr8VnoL11Wvl6nx80ukXUDKMnBYaR6AXjqi0kBr4ymr8fPhNSSNCih/iLY/ESQ==
X-Gm-Gg: AYBFou2im/PqiK9l4qxlF+OYm2luLPOt1ERanDkyYOGyy8jUfY3i8N7TLTO5F5drexQ
 SzZ1MO7eMbOQ8bDRVs2ebyZlyP89hMG4BA4GiHYZq/V6Fb/lnJT110SciI0JjbLSNixqrF/2Eyb
 sHfTEcfMtPv0BmsTmNx7fS4nCfVGzxUOQik8bf0DcrQMTd1hffNF6tiQL6r4d29ys1oWmtMO9AF
 cRTCH7Z5dtjpb++OGqr1l8Iu1gzluU01VSpBhTPH3S50SQB6zHVCqr6efSqLCdGuzZyesrYQ62Y
 xDy55jhSF8lTeGMFsgSLE/iOGr9qbc5PO1qvETUfaEyHlLsGwt+bNX0zJbSwoSd3oeV0dEO1mxM
 DPSOQh05m5jdijN/i3JzNMhAGA1oDnGM27Ys5lz0HTiBXtGw=
X-Received: by 2002:a05:701b:450b:20b0:143:298f:33b8 with SMTP id
 a92af1059eb24-1620a5cd061mr4275529c88.44.1791419839007; 
 Wed, 07 Oct 2026 17:37:19 -0700 (PDT)
X-Received: by 2002:a05:701b:450b:20b0:143:298f:33b8 with SMTP id
 a92af1059eb24-1620a5cd061mr4275502c88.44.1791419838239; 
 Wed, 07 Oct 2026 17:37:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm4380048c88.7.2026.10.07.17.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 17:37:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH v3 03/12] tests/tcg/hexagon: Cover HVX vector write conflicts
Date: Wed,  7 Oct 2026 17:37:02 -0700
Message-Id: <20261008003711.3984454-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5ddEEAqyhJJmTro806xEfrqjvY9kFrxW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX94bPFTWtG8q8
 TRlqVqPfBuu2vY0NUiD5tCxpZi4yhv3clJbIQWaXZoc3dmpSY5cjF66PahOcHU8eTDNDZt31E9Q
 HzzO4P0CeCk0gtiiZFSM+/p1zfhS19M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfXyqtB4L0ZsGsA
 59vaN/DpalTD+L2MR3ZV5vDNs9rCOA/XCTMo5VIUwErD3IS5jzRPwVh/LVfV9FISkuAY3QwnGb/
 7rVALsmF02xyBiWqcp6nyhSo/pIBB569gG9UcF/T71LchxXw5voF9+cJGOalZUPGD8oKj+oVknP
 l+XHATEyiszLnvh5EZDnuotOLv5AVXN8JXb397SnTSbJx0NlVD32o9SPgLz4ajAaNfzc75z2+oG
 jxeODNNfoCZQtpfi8GhE00BcJUKiO3inqUI6i2us72BQwqZPR7WxQIHnveEh20Xjk+Qz1a/93MK
 2qkWRajNpxVrhWcZNNpHf3M/il9rwp4iIYIplXM7yVEwO/15LWk4FQXrlm5bTPTL37T+DvVxPOW
 Na6NyJVnppfwwcSaAOewLfpvb7EiX3fWaI9hMOuCiBRQuSQw25KyuHfkgtKQOgNt18Ny6S1ci+V
 PFZJzBBtWxE5xDlP2TA==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac6e5bf cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LU5tE7T4vROUmwdGADEA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 5ddEEAqyhJJmTro806xEfrqjvY9kFrxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080001
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

Q2M6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5
OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNn
L2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMgfCAxMDcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxlLXdyaXRlcy5jIGIvdGVzdHMv
dGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMKaW5kZXggYmQyYjEzODRkZDkuLjljYTVhZGY3
NmFkIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYworKysg
Yi90ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYwpAQCAtMTMsNiArMTMsNyBAQAog
CiAjaW5jbHVkZSA8YXNzZXJ0Lmg+CiAjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8c3Rk
aW50Lmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNsdWRl
IDxzdHJpbmcuaD4KQEAgLTIyMyw2ICsyMjQsODMgQEAgc3RhdGljIGludCB0ZXN0X3ZyZWdfbGVn
YWxfcHJlZGljYXRlZCh2b2lkKQogICAgIHJldHVybiBzaWc7CiB9CiAKKy8qCisgKiBDb21wbGVt
ZW50YXJ5IHByZWRpY2F0ZWQgd3JpdGVzIHRvIHRoZSBzYW1lIFYtcmVnaXN0ZXIgcGFpciBhcmUg
bGVnYWwuCisgKiB2MTYgYW5kIHYyMiBhcmUgc3BsYXR0ZWQgd2l0aCBkaXN0aW5jdCBwYXR0ZXJu
czsgc2luY2UgcDAgaXMgYWx3YXlzCisgKiB0cnVlLCB2MTQgbXVzdCBlbmQgdXAgaG9sZGluZyB2
MTYncyBwYXR0ZXJuLiAgRXh0cmFjdGluZyBhIHdvcmQgZnJvbQorICogdjE0IGNvbmZpcm1zIHRo
ZSBleGVjdXRlZCBicmFuY2ggYWN0dWFsbHkgcmFuLCByYXRoZXIgdGhhbiBtZXJlbHkgdGhhdAor
ICogbm8gU0lHSUxMIHdhcyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX3BhaXJf
bGVnYWxfcHJlZGljYXRlZCh2b2lkKQoreworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVz
dWx0OworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAgPSAjMFxuIgorICAgICAgICAi
cjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkgPSByMVxuIgorICAgICAg
ICAicjQgPSAjMHgxMTExMTExMVxuIgorICAgICAgICAicjUgPSAjMHgyMjIyMjIyMlxuIgorICAg
ICAgICAidjE2ID0gdnNwbGF0KHI0KVxuIgorICAgICAgICAidjIyID0gdnNwbGF0KHI1KVxuIgor
ICAgICAgICAicjQgPSAjMFxuIgorICAgICAgICAicDAgPSBjbXAuZXEocjAsIHIwKVxuIgorICAg
ICAgICAie1xuIgorICAgICAgICAiICAgIGlmIChwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjIyLCB2
MTYpXG4iCisgICAgICAgICIgICAgaWYgKCFwMCkgdjE1OjE0ID0gdmNvbWJpbmUodjE2LCB2MjIp
XG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW3Jlc3VsdF0gPSB2ZXh0cmFjdCh2MTQsIHI0
KVxuIgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiVbc2lnXSA9IHIwXG4iCisgICAgICAgIDog
W3NpZ10gIj1yIihzaWcpLCBbcmVzdWx0XSAiPXIiKHJlc3VsdCkKKyAgICAgICAgOiBbcmVzdW1l
X3BjXSAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAicjQiLCAicjUiLCAi
cDAiLAorICAgICAgICAgICJ2MTQiLCAidjE1IiwgInYxNiIsICJ2MjIiLCAibWVtb3J5Iik7CisK
KyAgICByZXR1cm4gc2lnID09IFNJR0lMTCA/IFNJR0lMTCA6IHJlc3VsdDsKK30KKworLyoKKyAq
IEEgZnV0dXJlIHdyaXRlIG1heSBjb25zdW1lIGEgdGVtcG9yYXJ5IHZhbHVlIGZyb20gdGhlIHNh
bWUgVi1yZWdpc3Rlci4KKyAqIGJ1ZiBpcyB6ZXJvZWQgd2hpbGUgdjAgaXMgaW5pdGlhbGl6ZWQg
bm9uLXplcm8sIHNvIHYwLnRtcCBsb2FkcyBhbGwtemVybworICogYW5kIHYwLncgPSB2YWRkKHYw
LnRtcC53LCAxKSBtdXN0IGVuZCB1cCBhcyAxIGluIGV2ZXJ5IHdvcmQuICBFeHRyYWN0aW5nCisg
KiBhIHdvcmQgZnJvbSB0aGUgcmVzdWx0CisgKiBjb25maXJtcyB0aGUgYWRkIGFjdHVhbGx5IHVz
ZWQgdGhlIGxvYWRlZCAudG1wIHZhbHVlLCByYXRoZXIgdGhhbgorICogbWVyZWx5IHRoYXQgbm8g
U0lHSUxMIHdhcyByYWlzZWQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF92cmVnX2xlZ2FsX3RtcCh2
b2lkKQoreworICAgIGxvbmcgbG9uZyBidWZbMTZdIF9fYXR0cmlidXRlX18oKGFsaWduZWQoMTI4
KSkpOworICAgIGludCBzaWc7CisgICAgdWludDMyX3QgcmVzdWx0OworCisgICAgbWVtc2V0KGJ1
ZiwgMCwgc2l6ZW9mKGJ1ZikpOworCisgICAgYXNtIHZvbGF0aWxlKAorICAgICAgICAicjAgPSAj
MFxuIgorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAgICJtZW13KCVbcmVzdW1lX3BjXSkg
PSByMVxuIgorICAgICAgICAicjIgPSAlW2J1Zl1cbiIKKyAgICAgICAgInIzID0gIzFcbiIKKyAg
ICAgICAgInI0ID0gIzBcbiIKKyAgICAgICAgInI1ID0gIzJcbiIKKyAgICAgICAgInYwID0gdnNw
bGF0KHI1KVxuIgorICAgICAgICAidjEgPSB2c3BsYXQocjMpXG4iCisgICAgICAgICJ7XG4iCisg
ICAgICAgICIgICAgdjAudG1wID0gdm1lbShyMiArICMwKVxuIgorICAgICAgICAiICAgIHYwLncg
PSB2YWRkKHYwLncsIHYxLncpXG4iCisgICAgICAgICJ9XG4iCisgICAgICAgICIlW3Jlc3VsdF0g
PSB2ZXh0cmFjdCh2MCwgcjQpXG4iCisgICAgICAgICIxOlxuIgorICAgICAgICAiJVtzaWddID0g
cjBcbiIKKyAgICAgICAgOiBbc2lnXSAiPXIiKHNpZyksIFtyZXN1bHRdICI9ciIocmVzdWx0KQor
ICAgICAgICA6IFtyZXN1bWVfcGNdICJyIigmcmVzdW1lX3BjKSwgW2J1Zl0gInIiKGJ1ZikKKyAg
ICAgICAgOiAicjAiLCAicjEiLCAicjIiLCAicjMiLCAicjQiLCAicjUiLCAidjAiLCAidjEiLCAi
bWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnID09IFNJR0lMTCA/IFNJR0lMTCA6IHJlc3VsdDsK
K30KKwogc3RhdGljIGludCB0ZXN0X3ZyZWdfaWxsZWdhbF9taXhlZCh2b2lkKQogewogICAgIGlu
dCBzaWc7CkBAIC0yNDIsNiArMzIwLDI2IEBAIHN0YXRpYyBpbnQgdGVzdF92cmVnX2lsbGVnYWxf
bWl4ZWQodm9pZCkKICAgICByZXR1cm4gc2lnOwogfQogCisvKiBBIHBhaXIgd3JpdGUgYW5kIGEg
c2luZ2xlIHdyaXRlIHRvIGVpdGhlciBwYWlyIG1lbWJlciBhcmUgaWxsZWdhbC4gKi8KK3N0YXRp
YyBpbnQgdGVzdF92cmVnX2lsbGVnYWxfcGFpcl9vdmVybGFwKHZvaWQpCit7CisgICAgaW50IHNp
ZzsKKworICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIx
ID0gIyMxZlxuIgorICAgICAgICAibWVtdyglW3Jlc3VtZV9wY10pID0gcjFcbiIKKyAgICAgICAg
Ii53b3JkIDB4MWY1MDU1ZWUgICAgLyogeyB2MTU6MTQgPSB2Y29tYmluZSh2MjEsIHYxNikgKi9c
biIKKyAgICAgICAgIi53b3JkIDB4MWUwM2U1ZWUgICAgLyogICB2MTQgPSB2NSB9ICovXG4iCisg
ICAgICAgICIxOlxuIgorICAgICAgICAiJVtzaWddID0gcjBcbiIKKyAgICAgICAgOiBbc2lnXSAi
PXIiKHNpZykKKyAgICAgICAgOiBbcmVzdW1lX3BjXSAiciIoJnJlc3VtZV9wYykKKyAgICAgICAg
OiAicjAiLCAicjEiLCAibWVtb3J5Iik7CisKKyAgICByZXR1cm4gc2lnOworfQorCiBzdGF0aWMg
aW50IHRlc3RfdnJlZ19pbGxlZ2FsX3VuY29uZCh2b2lkKQogewogICAgIGludCBzaWc7CkBAIC0z
MDgsMTAgKzQwNiwxMyBAQCBpbnQgbWFpbigpCiAgICAgYXNzZXJ0KHRlc3RfcG9zdF9pbmNyZW1l
bnQzKCkgPT0gU0lHSUxMKTsKIAogICAgIGFzc2VydCh0ZXN0X3ZyZWdfbGVnYWxfcHJlZGljYXRl
ZCgpID09IDIzKTsKLSAgICBhc3NlcnQodGVzdF92cmVnX2lsbGVnYWxfbWl4ZWQoKSA9PSBTSUdJ
TEwpOwotICAgIGFzc2VydCh0ZXN0X3ZyZWdfaWxsZWdhbF91bmNvbmQoKSA9PSBTSUdJTEwpOwor
ICAgIGFzc2VydCh0ZXN0X3ZyZWdfcGFpcl9sZWdhbF9wcmVkaWNhdGVkKCkgPT0gMHgxMTExMTEx
MSk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19sZWdhbF90bXAoKSA9PSAxKTsKKyAgICBhc3NlcnQo
dGVzdF92cmVnX2lsbGVnYWxfbWl4ZWQoKSA9PSAwKTsKKyAgICBhc3NlcnQodGVzdF92cmVnX2ls
bGVnYWxfcGFpcl9vdmVybGFwKCkgPT0gMCk7CisgICAgYXNzZXJ0KHRlc3RfdnJlZ19pbGxlZ2Fs
X3VuY29uZCgpID09IDApOwogCi0gICAgYXNzZXJ0KHRlc3RfcXJlZ19pbGxlZ2FsKCkgPT0gU0lH
SUxMKTsKKyAgICBhc3NlcnQodGVzdF9xcmVnX2lsbGVnYWwoKSA9PSAwKTsKIAogICAgIHB1dHMo
IlBBU1MiKTsKICAgICByZXR1cm4gRVhJVF9TVUNDRVNTOwotLSAKMi4zNC4xCgo=

