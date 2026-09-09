Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33274C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49VP-0006xU-7Q; Wed, 09 Sep 2026 00:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VN-0006wx-5Y
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VK-0003rz-NX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688MgGo5336395
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fdwDXcs4SfI3UaOq8SilTZCLtIfPZsAl3o0N2Mz0v3o=; b=J0difbH3k3u80jQq
 b/ZMcglIj4CnQAE0yIp+ewVOhI6Fr/3cOd41+/+yOCpNhESnYYKZQWp19i/H7LnE
 LuiskidFXZXUNdt8505KQLn3MZOd92w5r8lWg3OjWyjL3YOoP32UiZAi37t1+Efg
 YeNTwYZ1USKLckMmiftKBsPWmpWIQ70EpD1Lb/4YFs6ooU/SBO4d7n8/erfE5dp4
 mJfk0yG/wjTFmxLrex4VIAoqVpq97Gim7yaBe2xO3EtVAAszE3Xk6uOkr8Pe9E9G
 nHJ0d/RCijNJARPQBcfPd7X+5eAGGj3WOCOfjZiDl2QEnqTCJ9QYqOlc3mbxwotF
 mfxKLA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqe7hxn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:45 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7f1da5e5b06so6536551a34.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926505; x=1789531305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fdwDXcs4SfI3UaOq8SilTZCLtIfPZsAl3o0N2Mz0v3o=;
 b=KiOEdTA8tAbI0S5pInODx9e9zQrqiLERIKGkNA3BXj0um1SumRMVJKF1+feI3LU9Td
 wDJPYZFU8llxVBZ5QvE27wUOdqW/BhXJA5YFhLsYYbiSMMy3FWJVV3rZdIr0TmFRsnIx
 2SHWtm5cdmtjHLZmhe6olD6lUt6ISSHzQintf8SQe02NCOkUrN/r+XKfEIpsrdNUtqxS
 wNTClSAyzkIDDaoCdSf9Xqyxw+Fi0gRX8GQV7H+dpnjHyBRWKiPJobfhn66pleQBL9HB
 zex4mqhPnybtT87QugTwBezxJ30Fpt42UNzbZtEDIh0g04IQSVYm5uxQJeSC6QVP/TL4
 FK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926505; x=1789531305;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdwDXcs4SfI3UaOq8SilTZCLtIfPZsAl3o0N2Mz0v3o=;
 b=XIH9ldxqL6eLUPExnH5Bs9u6a5vRAL5Ncr1tfihdUexqYCf1Khpbm2PQ7K6PYbOW4c
 mZOiuqPw3w5CGYIYrcuuvgInUKvV8Zhs7Dtcl4MclAN+vqXLX2SINYvka+YFpmuTW6sR
 j4Wl/p0j7nw3lM3iCKnGR5VbDaO0GR3KSklMm+cJhMXaiOON8TKWf71mm4aWwGB43XXd
 DsIHY9uKU7MaU41Rg9+rm0WsRDUWS72GhwlJ4opgP6r+FgMbAxQgkh2QPVwCyRQtJVrt
 P3uhKgWl/5pB8VGovAvYuxxe+ks+yeCydQuedbXeuhM9Cby5pQPaHSzWXEE+x0SXiVdy
 lO1A==
X-Gm-Message-State: AFuF++nIklvNFFyfA6HQUUxNUWcrwFbzYnA93dHNR1kSxzGcqkNEAKze
 5JKenQsf8Pqjjir8cJTWf20uFTwaXLzHPVpfZAVt1b/rHStSS/eAdOnnxdssJC/9wh2ORQlkNrR
 owP9AiWEMGxbNyPjdVijpu241EapVmuYu+AMjgs1PGf5yIhoItEKUWbv7eP8UYGqfSQ==
X-Gm-Gg: AYBFou3tSmkm6oHb7S7JYJZhDaZ2scEwb9cZD8Lky7m67V6WGPI3E6e9BDnUbBIwmJ5
 MYGxy1euJNSlTpSpnlUi+FCqg4x3n5jsCIlR055ComkiboNRagnoIxzGD9q6bEGuCkWLIQaFk/p
 pWf2q/rTVhs6cNGSVHAvHYpDtXqPiHQwKNLM9P/WKn0dKpfj7LWP/EMX0sv23eCQ2hfpyksO9wN
 n/mtQmJLnC4nqSl39Kdlhs8KHzBzQasuDT4hV85XJ2yiQIJ+tPQnVRgRZTIdTx0mLgLj1MuhwLO
 kS5B4xu+uJBdd0H4sN7zV42TVQzZotA0lNoCq9fmVw63952Wx1XidYfcXKvHQr9ng6pS1xPosko
 l1Cl0MoIm3/rgb4BbOcqJIKuBb0+rsQ5ffpn5/aIBrAWzOKpD
X-Received: by 2002:a05:6820:2912:b0:6b7:46fc:1c5 with SMTP id
 006d021491bc7-6b746fc0332mr18306805eaf.36.1788926504898; 
 Tue, 08 Sep 2026 21:01:44 -0700 (PDT)
X-Received: by 2002:a05:6820:2912:b0:6b7:46fc:1c5 with SMTP id
 006d021491bc7-6b746fc0332mr18306773eaf.36.1788926504356; 
 Tue, 08 Sep 2026 21:01:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 2/9] target/hexagon: add the v73 J2_unpause scalar
 instruction
Date: Tue,  8 Sep 2026 21:01:30 -0700
Message-Id: <20260909040137.3414132-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX93RiNbNyH6L7
 yaUbLrUxp2boL7ZG9tJxDAintnyycRSZNhxfTBuzIDTcyXQStR/4g20/SZbeu27AAk73YCNzC5n
 +IpYS78RWAYfQr5761U8B9b84v9uGbg=
X-Proofpoint-ORIG-GUID: 7lbUDlPU1kRpXG2pG_b2vbjwCNUtmsDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX8TU9XtM13SPk
 E2AHT3apN1JxMoXK9rUkVGdH1ARDwvmoCE0shPtEO9YHI6jUEBVx6sYADGZjoKSZpwjLFWRWsnQ
 m8+CdnNNE+qSshJEFkGxaqCfVNBbcoIbo5fw2IRdy5Cg+8SCc7w0s/loHbXNhv2AiS96eLJw77S
 i8j6fdQ/Iohyzgm9A8unW08IJKi04yLLKyGvruSMOLG1V3lVfFJFfoc9gffw8ToOqWek/fU3nD4
 6hiPZSeqKQVFyJjLBSuBCa7uuQIuY7q1l2Ps76A1Lhiyig6SPx7TvpOydTtXa4DssaO7xgEi0IF
 9Odw3Qh1srC9FNbdrZjdyPAqm7nFbiQxClYEsoqMpJ6FwfZjeU2S+HtGmXR8aLolHKpuW8tI8dO
 qVX8dnNpBBsfeOFixWaNNiUdRQ+xPHzn3Q/pyWrHco1KJWUM1QnG4poT/ksOrJ2oVcKAAxWGt9X
 XOtfUN446KIOtAyGWfQ==
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6aa0da29 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fnvyaJKH3I3DEN-d1BkA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: 7lbUDlPU1kRpXG2pG_b2vbjwCNUtmsDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

djczIGFscmVhZHkgYWRkZWQgSjJfY2FsbHJoIGFuZCBKMl9qdW1wcmggYnV0IHVuaW50ZW50aW9u
YWxseQpvbWl0dGVkIGB1bnBhdXNlYC4gIEl0cyBlZmZlY3QgaXMgdG8gY2F1c2Ugb3RoZXIgdGhy
ZWFkcycgcGF1c2UKaW5zdHJ1Y3Rpb25zIHRvIGNlYXNlIHBhdXNpbmcsIGJ1dCB3ZSB0cmVhdCBg
cGF1c2VgIGFzIGEgbm9wIG9yCmEgeWllbGQgaW4gUlIsIHNvIHVucGF1c2UgY2FuIHNhZmVseSBi
ZSBhIG5vcC4KCldoaWxlIGhlcmUsIHNwZWxsIHRoZSBvdGhlciB0d28gdjczIGVudHJpZXMnIHZl
cnNpb24gYXMgSEVYX1ZFUl9WNzMKaW5zdGVhZCBvZiB0aGUgbGl0ZXJhbCAweDczLCBtYXRjaGlu
ZyBldmVyeSBvdGhlciBlbnRyeSBpbiB0aGUgdGFibGUuCgpSZXZpZXdlZC1ieTogTWFyY28gTGll
YmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29u
L2NoZWNrX3Jldl9nYXRpbmcuYyAgfCAxMiArKysrKysrKystLS0KIHRlc3RzL3RjZy9oZXhhZ29u
L3Y3M19zY2FsYXIuYyAgICAgICAgfCAgNyArKysrKysrCiB0YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMgICAgIHwgIDUgKysrLS0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29k
ZV9wcC5kZWYgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZiAgIHwg
IDMgKysrCiA1IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dhdGluZy5jIGIvdGVz
dHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dhdGluZy5jCmluZGV4IDI2YjY2ZjU0NTUyLi5kNTI5
NWJmMjRhYiAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dhdGluZy5j
CisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2NoZWNrX3Jldl9nYXRpbmcuYwpAQCAtMyw5ICszLDEy
IEBACiAgKiBhcmUgcmVqZWN0ZWQgd2l0aCBTSUdJTEwuCiAgKgogICogQ29tcGlsZWQgd2l0aCAt
bXY2NiBzbyB0aGF0IGVfZmxhZ3Mgc2VsZWN0cyBDUFUgdjY2LiBUaGUgdGVzdCBlbWJlZHMKLSAq
IGEgdjY4IGluc3RydWN0aW9uIChMMl9sb2Fkd19hcTogInIwID0gbWVtd19hcShyMCkiKSB2aWEg
LndvcmQKLSAqIGVuY29kaW5nLiBUaGUgcmV2aXNpb24tZ2F0ZWQgZGVjb2RlciBtdXN0IHJlamVj
dCBpdCwgYW5kIGxpbnV4LXVzZXIKLSAqIG11c3QgZGVsaXZlciBTSUdJTEwuCisgKiBpbnN0cnVj
dGlvbnMgZnJvbSB2NjggdGhyb3VnaCB2NzMgdmlhIC53b3JkIGVuY29kaW5nOiB0aGUgYXNzZW1i
bGVyCisgKiBlbmZvcmNlcyB0aGUgc2VsZWN0ZWQgQ1BVJ3Mgb3duIG1pbmltdW0gdmVyc2lvbiwg
c28gbm9uZSBvZiB0aGVzZSAtLQorICogaW5jbHVkaW5nIG9uZXMgaXQgb3RoZXJ3aXNlIGtub3dz
IGhvdyB0byBhc3NlbWJsZSBhdCB0aGVpciBvd24KKyAqIHRhcmdldCwgc3VjaCBhcyBjYWxscmgg
b3IgdW5wYXVzZSAtLSBjYW4gYmUgd3JpdHRlbiBhcyB0aGVtc2VsdmVzIGluCisgKiBhIGZpbGUg
YnVpbHQgZm9yIHY2Ni4gVGhlIHJldmlzaW9uLWdhdGVkIGRlY29kZXIgbXVzdCByZWplY3QgZXZl
cnkKKyAqIG9uZSBvZiB0aGVtLCBhbmQgbGludXgtdXNlciBtdXN0IGRlbGl2ZXIgU0lHSUxMLgog
ICoKICAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBp
dHMgc3Vic2lkaWFyaWVzLgogICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIKQEAgLTEwMiw2ICsxMDUsOCBAQCBUUllfRlVOQyh2NzNfY2FsbHJoLAogICAgICAgICAg
Ii53b3JkIDB4NTBjNWMwMDAgICAgLyogY2FsbHJoIHI1ICovXG4iKQogVFJZX0ZVTkModjczX2p1
bXByaCwKICAgICAgICAgICIud29yZCAweDUyYzBjMDAwICAgIC8qIGp1bXByaCByMCAqL1xuIikK
K1RSWV9GVU5DKHY3M191bnBhdXNlLAorICAgICAgICAgIi53b3JkIDB4NTdlMGQwMDAgICAgLyog
dW5wYXVzZSAqL1xuIikKIAogaW50IG1haW4odm9pZCkKIHsKQEAgLTEzMyw2ICsxMzgsNyBAQCBp
bnQgbWFpbih2b2lkKQogCiAgICAgYXNzZXJ0KHRyeV92NzNfY2FsbHJoKCkgPT0gU0lHSUxMKTsK
ICAgICBhc3NlcnQodHJ5X3Y3M19qdW1wcmgoKSA9PSBTSUdJTEwpOworICAgIGFzc2VydCh0cnlf
djczX3VucGF1c2UoKSA9PSBTSUdJTEwpOwogCiAgICAgYXNzZXJ0KHNpZ25hbHNfaGFuZGxlZCA9
PSBleHBlY3RlZF9zaWduYWxzKTsKIApkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vdjcz
X3NjYWxhci5jIGIvdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxhci5jCmluZGV4IGZlZTY3ZmM1
MzExLi4yYjVmM2FhMjE0OSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxh
ci5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Y3M19zY2FsYXIuYwpAQCAtODYsMTAgKzg2LDE3
IEBAIHN0YXRpYyB2b2lkIHRlc3RfanVtcHJoKHZvaWQpCiAgICAgY2hlY2szMihyZXMsIDEpOwog
fQogCitzdGF0aWMgdm9pZCB0ZXN0X3VucGF1c2Uodm9pZCkKK3sKKyAgICAvKiBOb3RoaW5nIGlz
IHBhdXNlZCwgc28gdGhpcyBqdXN0IG5lZWRzIHRvIGV4ZWN1dGUgd2l0aG91dCBmYXVsdGluZy4g
Ki8KKyAgICBhc20gdm9sYXRpbGUoInVucGF1c2Vcblx0Iik7Cit9CisKIGludCBtYWluKCkKIHsK
ICAgICB0ZXN0X2NhbGxyaCgpOwogICAgIHRlc3RfanVtcHJoKCk7CisgICAgdGVzdF91bnBhdXNl
KCk7CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/
IDEgOiAwOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jIGIv
dGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCmluZGV4IGE5MWI5MWEyM2U2Li40NDUx
M2Y0NjgwOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYwpAQCAtNTcxLDggKzU3MSw5IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZfaW5mb1tYWF9MQVNUX09Q
Q09ERV0gPSB7CiAgICAgW0YyX2RmbXB5aGhdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjY3
LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtGMl9kZm1weWxoXSA9IHsgLmludHJv
ZHVjZWQgPSBIRVhfVkVSX1Y2NywgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbRjJf
ZGZtcHlsbF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNjcsIC5yZW1vdmVkID0gSEVYX1ZF
Ul9OT05FIH0sCi0gICAgW0oyX2NhbGxyaF0gPSB7IC5pbnRyb2R1Y2VkID0gMHg3MywgLnJlbW92
ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbSjJfanVtcHJoXSA9IHsgLmludHJvZHVjZWQgPSAw
eDczLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtKMl9jYWxscmhdID0geyAuaW50
cm9kdWNlZCA9IEhFWF9WRVJfVjczLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtK
Ml9qdW1wcmhdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjczLCAucmVtb3ZlZCA9IEhFWF9W
RVJfTk9ORSB9LAorICAgIFtKMl91bnBhdXNlXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
MywgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbTDJfbG9hZHdfYXFdID0geyAuaW50
cm9kdWNlZCA9IEhFWF9WRVJfVjY4LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtM
NF9sb2FkZF9hcV0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNjgsIC5yZW1vdmVkID0gSEVY
X1ZFUl9OT05FIH0sCiAgICAgW1k2X2RtY2ZncmRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJf
VjY4LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZiBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29k
ZV9wcC5kZWYKaW5kZXggZDllOGVhMmFlYmQuLjFmY2UzMThiMmJiIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYKQEAgLTU4NSw2ICs1ODUsNyBAQCBERUZfRklFTERST1dfREVT
QzMyKElDTEFTU19KIiAwMTAwIC0tLS0tLS0tIFBQLS0tLS0tIC0tLS0tLS0tIiwiWyM0XSAoI3U4
KSAiKQogREVGX0VOQzMyKEoyX3RyYXAwLCAgICAgSUNMQVNTX0oiIDAxMDAgIDAwLS0tLS0tICBQ
UC1paWlpaSAgLS0taWlpLS0iKQogREVGX0VOQzMyKEoyX3RyYXAxLCAgICAgSUNMQVNTX0oiIDAx
MDAgIDEwLXh4eHh4ICBQUC1paWlpaSAgLS0taWlpLS0iKQogREVGX0VOQzMyKEoyX3BhdXNlLCAg
ICAgSUNMQVNTX0oiIDAxMDAgIDAxLS0tLWlpICBQUC1paWlpaSAgLS0taWlpLS0iKQorREVGX0VO
QzMyKEoyX3VucGF1c2UsIjAxMDEwMTExMTExLS0tLS1QUDAxLS0tLTAwMC0tLS0tIikKIAogREVG
X0ZJRUxEUk9XX0RFU0MzMihJQ0xBU1NfSiIgMDEwMSAtLS0tLS0tLSBQUC0tLS0tLSAtLS0tLS0t
LSIsIlsjNV0gUmQ9KFJzKSAiKQogREVGX0VOQzMyKFkyX2ljZGF0YXIsICAgSUNMQVNTX0oiIDAx
MDEgIDEwMXNzc3NzICBQUC0tLS0tLSAgLS0tZGRkZGQiKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvc3lzdGVtLmlkZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9zeXN0
ZW0uaWRlZgppbmRleCAwMmFlZThjZThlZS4uYjQ0ZTg3NTY1YzMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9y
dGVkL3N5c3RlbS5pZGVmCkBAIC01MSw2ICs1MSw5IEBAIFE2SU5TTihKMl90cmFwMSwidHJhcDEo
UngzMiwjdTgpIixBVFRSSUJTKEFfQ09GLEFfTk9URV9OT1BBQ0tFVCxBX1JFU1RSSUNUX05PUEFD
CiBRNklOU04oSjJfcGF1c2UsInBhdXNlKCN1OCkiLEFUVFJJQlMoQV9DT0YsQV9OT1RFX05PUEFD
S0VULEFfUkVTVFJJQ1RfTk9QQUNLRVQpLAogIkVudGVyIGxvdy1wb3dlciBzdGF0ZSBmb3IgI3U4
IGN5Y2xlcyIse2ZQQVVTRSh1aVYpO30pCiAKK1E2SU5TTihKMl91bnBhdXNlLCJ1bnBhdXNlIixB
VFRSSUJTKEFfQ09GLEFfTk9URV9OT1BBQ0tFVCxBX1JFU1RSSUNUX05PUEFDS0VUKSwKKyJSZXN1
bWUgcGF1c2VkIHRocmVhZHMiLHtmVU5QQVVTRSgpO30pCisKIFE2SU5TTihKMl9ydGUsICAicnRl
IiwgQVRUUklCUyhBX1BSSVYsQV9OT1RFX1BSSVYsQV9OT19USU1JTkdfTE9HKSwKICJSZXR1cm4g
ZnJvbSBFeGNlcHRpb24iLAogewotLSAKMi4zNC4xCgo=

